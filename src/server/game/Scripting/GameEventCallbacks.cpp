#include "GameEventCallbacks.h"

#ifdef _DEBUG
    #define PROFILE_CALLBACK_EXECUTION_TIMES
#endif

#ifdef PROFILE_CALLBACK_EXECUTION_TIMES
#include "DbgHelp.h"
#include <WinBase.h>
#pragma comment(lib, "Dbghelp.lib")

void printStack(char *Output, int MaxSize)
{
    Output[0] = 0;
    unsigned int   i;
    void         * stack[100];
    unsigned short frames;
    SYMBOL_INFO  * symbol;
    HANDLE         process;

    process = GetCurrentProcess();
    SymInitialize(process, NULL, TRUE);
    frames = CaptureStackBackTrace(0, 100, stack, NULL);
    symbol = (SYMBOL_INFO *)calloc(sizeof(SYMBOL_INFO) + 256 * sizeof(char), 1);
    symbol->MaxNameLen = 255;
    symbol->SizeOfStruct = sizeof(SYMBOL_INFO);

    for (i = 1; i < frames; i++)
    {
        SymFromAddr(process, (DWORD64)(stack[i]), 0, symbol);

        sprintf_s(Output, MaxSize, "%s%i: %s - 0x%0llX\n", Output, frames - i - 1, symbol->Name, (uint64)symbol->Address);
    }

    free(symbol);
}
static double               PCFreq = 0.0;         // CPU speed bazed timer. Must be divided to be the same on all PC
static __int64              CounterStart = -1;
//get our CPU TickCount
void StartCounter()
{
    LARGE_INTEGER li;
    if (!QueryPerformanceFrequency(&li))
        return;

    PCFreq = double(li.QuadPart) / 1000.0;

    QueryPerformanceCounter(&li);
    CounterStart = li.QuadPart;
}
__int64 GetTick()
{
    if (CounterStart == -1)
        StartCounter();
    LARGE_INTEGER li;
    QueryPerformanceCounter(&li);
    return li.QuadPart;
}
#endif

// multi threaded list needs to block read on delete
// only some scripts will use unregister. If you do not intend to use unregister, you should remove support for multi threading
#define ADD_DELETE_SUPPORT  

#ifdef ADD_DELETE_SUPPORT  
std::atomic<int>    HasPendingDelete = 0;   // block read until we finish delete
std::atomic<int>    IsReadingList = 0;      // block delete until we finish read
HANDLE              DeleteMutex = NULL;     // wait for this
#endif

// scripts should call this to subscribe to a list of events
void RegisterCallbackFunction(CallbackEventTypes EventType, EventCallbackFunctionPointer Callback, void *CallbackCreateParam)
{
#ifdef ADD_DELETE_SUPPORT  
    if (HasPendingDelete != 0)
    {
        WaitForSingleObject(DeleteMutex, INFINITE);
        ReleaseMutex(DeleteMutex);
    }

    IsReadingList++;
#endif

    //make sure it's unique. This is only a security check to avoid infinite register bugs
    for (auto itr = GameEventCallbacks[EventType].begin(); itr != GameEventCallbacks[EventType].end(); itr++)
        if ((*itr)->cb == Callback && (*itr)->CallbackCreateParam == CallbackCreateParam)
        {
#ifdef ADD_DELETE_SUPPORT  
            IsReadingList--;
#endif
            return;
        }

#ifdef ADD_DELETE_SUPPORT
    IsReadingList--;
#endif

    CallbackCreateParamStore *cbs = new CallbackCreateParamStore;
    cbs->cb = Callback;
    cbs->CallbackCreateParam = CallbackCreateParam;

#ifdef PROFILE_CALLBACK_EXECUTION_TIMES
    cbs->Statistics.TimesCalled = 0;
    cbs->Statistics.TimeSpent = 0;
    printStack(cbs->Statistics.CallStackRegistered, sizeof(cbs->Statistics.CallStackRegistered));
#endif

    //all good, register
    GameEventCallbacks[EventType].push_back(cbs);
}

//server core should call this to trigger all subscribed callback functions
static int CallbackRecursiveCallCounter = 0;
void TriggerCallbackFunctions(CallbackEventTypes EventType, void *param)
{
    //nothing to do
	if(GameEventCallbacks[EventType].empty())
		return;

    if (CallbackRecursiveCallCounter > 0)
        return;
    CallbackRecursiveCallCounter++;
#ifdef ADD_DELETE_SUPPORT  
    if (HasPendingDelete != 0)
    {
        WaitForSingleObject(DeleteMutex, INFINITE);
        ReleaseMutex(DeleteMutex);
    }

    IsReadingList++;
#endif

	for(auto itr=GameEventCallbacks[EventType].begin();itr!=GameEventCallbacks[EventType].end();itr++)
	{
#ifdef PROFILE_CALLBACK_EXECUTION_TIMES
        __int64 TimeAtStart = GetTick();
#endif

        (*(*itr)->cb)(param, (*itr)->CallbackCreateParam);  // call the callback function

#ifdef PROFILE_CALLBACK_EXECUTION_TIMES
        (*itr)->Statistics.TimeSpent += GetTick() - TimeAtStart;
        (*itr)->Statistics.TimesCalled++;
#endif
    }
    CallbackRecursiveCallCounter--;
#ifdef ADD_DELETE_SUPPORT  
    IsReadingList--;
#endif
}

#ifdef ADD_DELETE_SUPPORT  
void UnRegisterCallbackFunction(CallbackEventTypes EventType, EventCallbackFunctionPointer Callback, void *CallbackCreateParam)
{
    if (DeleteMutex == NULL)
    {
        DeleteMutex = CreateMutex(NULL, FALSE, NULL);
    }

    //mark threads that we want to delete something. Stop reading our list
    WaitForSingleObject(DeleteMutex, INFINITE); // wait for other threads that are deleting from list
    HasPendingDelete = 1;                       // mark NEW read threads to wait for us to finish delete

    //do a spinlock to wait for reader threads to finish
    uint32 AntiDeadlockLoop = 1000;
    while (IsReadingList != 0 && AntiDeadlockLoop > 0)
    {
        Sleep(1);
        AntiDeadlockLoop--;
    }

    // do the delete
    for (auto itr = GameEventCallbacks[EventType].begin(); itr != GameEventCallbacks[EventType].end(); itr++)
    {
        CallbackCreateParamStore *cbcs = *itr;
        if (cbcs->cb == Callback && cbcs->CallbackCreateParam == CallbackCreateParam)
        {
            GameEventCallbacks[EventType].erase(itr);
            if (cbcs->CallbackCreateParam != NULL)
                cbcs->CallbackCreateParam = NULL; // delete should be done by server script
            delete cbcs;
            break;
        }
    }

    //release the read lock from the list
    HasPendingDelete = 0;           // allow read threads to use the list
    ReleaseMutex(DeleteMutex);      // allow blocked read threads to continue execution
}
#endif

ObjectCallbackSupport::~ObjectCallbackSupport()
{
    if (ProcessingTriggers > 0)
        return;
    ProcessingTriggers++; // block any new triggers while we destroy the list
    for (int i = 0; i < MAX_CALLBACKEVENT_TYPES; i++)
    {
        for (auto itr = Callbacks[i].begin(); itr != Callbacks[i].end(); itr++)
        {
            CallbackHookStore *chs = *itr;
            if (chs->CallbackCreateParam != NULL && chs->DeleteCreateParam != 0)
                delete chs->CallbackCreateParam;
            delete chs;
        }
        Callbacks[i].clear();
    }
}

void ObjectCallbackSupport::RegisterCallbackFunc(CallbackEventTypes EventType, EventCallbackFunctionPointerSafe Callback, void *pCreateParam, char pDeleteCreateParam)
{
    //check if we already have this callback. Do not register more than once
    for (auto itr = Callbacks[EventType].begin(); itr != Callbacks[EventType].end(); itr++)
        if ( //(*itr)->CallbackType == EventType &&
            (*itr)->CallbackLocation == Callback && (*itr)->CallbackCreateParam == pCreateParam)
            return;
    //register as new
    CallbackHookStore *store = new CallbackHookStore;
    store->CallbackLocation = Callback;
    store->CallbackType = EventType;
    store->CallbackCreateParam = pCreateParam;
    store->DeleteCreateParam = pDeleteCreateParam;
    store->IsDeleted = 0;
    //add it to our list of callbacks
    Callbacks[EventType].push_back(store);
}

void ObjectCallbackSupport::TriggerCallbackFunc(CallbackEventTypes EventType, void *param)
{
    //nothing to do here
    if (Callbacks[EventType].empty())
        return;

    //do not proc procs on proc
    if (ProcessingTriggers > 0)
        return;
    ProcessingTriggers++;

    ProcessingTriggerType = EventType;
    for (auto itr = Callbacks[EventType].begin(); itr != Callbacks[EventType].end();)
    {
        CallbackHookStore *cb = *itr;
        itr++;  //because of suicidal callbacks
//        if (cb->CallbackType == EventType)
        {

#ifdef PROFILE_CALLBACK_EXECUTION_TIMES
            __int64 TimeAtStart = GetTick();
#endif

            cb->CallbackLocation(param, cb->CallbackCreateParam);

#ifdef PROFILE_CALLBACK_EXECUTION_TIMES
            cb->Statistics.TimeSpent += GetTick() - TimeAtStart;
            cb->Statistics.TimesCalled++;
#endif
        }
    }
    if (ProcessDeleteList != 0)
    {
        for (int i = 0; i < MAX_CALLBACKEVENT_TYPES; i++)
        {
            for (auto itr = Callbacks[i].begin(); itr != Callbacks[i].end();)
            {
                CallbackHookStore *chs = *itr;
                auto TodelItr = itr;
                itr++;
                if (chs->IsDeleted)
                {
                    Callbacks[EventType].erase(TodelItr);
                    DebugCheckDoubleDelete(chs);
                }
            }
        }
        ProcessDeleteList = 0;
    }
    ProcessingTriggers--;
}

void ObjectCallbackSupport::UnRegisterCallbackFunc(CallbackEventTypes EventType, EventCallbackFunctionPointerSafe Callback, void *pCreateParam, char pDeleteCreateParam)
{
//    if (ProcessingTriggers > 0)
//        return;
    ProcessingTriggers++; // block any new triggers while we destroy the list
    for (auto itr = Callbacks[EventType].begin(); itr != Callbacks[EventType].end(); itr++)
    {
        CallbackHookStore *chs = *itr;
        if ( // chs->CallbackType == EventType &&
            chs->CallbackLocation == Callback && chs->CallbackCreateParam == pCreateParam)
        {
            if (ProcessingTriggers > 1 && ProcessingTriggerType == EventType)
            {
                chs->IsDeleted = 1;
                ProcessDeleteList = 1;
            }
            else
            {
                Callbacks[EventType].erase(itr);
                if (chs->CallbackCreateParam != NULL && pDeleteCreateParam != 0)
                    DebugCheckDoubleDelete(chs->CallbackCreateParam);
                DebugCheckDoubleDelete(chs);
            }
            break;
        }
    }
    ProcessingTriggers--;
}

#ifdef _DEBUG
    std::set<void*> DeletedZones;
    void DebugCheckDoubleDelete(void *mem)
    {
        ASSERT(DeletedZones.find(mem) == DeletedZones.end());
        DeletedZones.insert(mem);
        //we will leak this memory. Will only happen in debug !
    } 
#endif

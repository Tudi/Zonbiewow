#ifndef _GAME_EVENT_CALLBACKS_H_
#define _GAME_EVENT_CALLBACKS_H_

/*
Do not try to be a smartass and put very frequent events in this list. This is for server custom modes and not some spell or damage scripting.
Considering events cut in execution, try to not make many changes server wide. Try to localize change as much as possible ( a value or 2 )
*/

#include <list>
#include <string.h>

// to speed up things, each event type should have it's own list of function pointers
enum CallbackEventTypes
{
    CALLBACK_TYPE_CREATURE_SPAWN = 0,
    CALLBACK_TYPE_LOOT_ITEM_ROOL,
    CALLBACK_TYPE_LOOT_ITEM_GROUP_ROLL,
    CALLBACK_TYPE_LOOT_GOLD_GENERATED,
    CALLBACK_TYPE_LOOT_SEND,            // after we generated a loot list. Send it to player. Final filtering ?
    CALLBACK_TYPE_LOOT_ITEM,            // when we remove an item from a lootable object
    CALLBACK_TYPE_SAVE_ITEM,
    CALLBACK_TYPE_DELETE_ITEM,
    CALLBACK_TYPE_SELL_ITEM,
    CALLBACK_TYPE_DMG_DONE,
    CALLBACK_TYPE_DMG_RECEIVED,
//    CALLBACK_TYPE_DMG_CHANGE_SCHOOL,
    CALLBACK_TYPE_HEAL_DONE,
    CALLBACK_TYPE_HEAL_RECEIVED,
    CALLBACK_TYPE_WHOIS_LIST_UPDATED,
    CALLBACK_TYPE_WHISPER_NOCHECKS,     // used for fake player addons to whisper back some random text without checking if destination player exists
    CALLBACK_TYPE_ADD_FRIEND,           // used for fake player addons to whisper back some random text without checking if destination player exists
    CALLBACK_TYPE_GROUP_INVITE,         // used for fake player addons to whisper back some random text without checking if destination player exists
    CALLBACK_TYPE_NAME_QUERY,           // used for fake player addons to whisper back some random text without checking if destination player exists
    CALLBACK_TYPE_RESET_ALL_INSTANCES,
    CALLBACK_TYPE_TARGET_KILL,
    CALLBACK_TYPE_PLAYER_PERIODIC_TICK,
    CALLBACK_TYPE_PLAYER_REVIVE,
    CALLBACK_TYPE_PLAYER_HONOR_CALC,
    CALLBACK_TYPE_PLAYER_MAP_CHANGE,
    CALLBACK_TYPE_PLAYER_VENDOR_BUY_ITEM,       // made it for ironman
    CALLBACK_TYPE_PLAYER_TAKE_MAIL_ITEM,        // made it for ironman
    CALLBACK_TYPE_PLAYER_AUCTION_TAKE_ITEM,     // made it for ironman
    CALLBACK_TYPE_PLAYER_TRADE_ACCEPT,          // made it for ironman
    CALLBACK_TYPE_PLAYER_GUILD_JOIN,            // made it for ironman
    CALLBACK_TYPE_PLAYER_GROUP_INVITE,            // made it for ironman
    CALLBACK_TYPE_PLAYER_GROUP_ACCEPT,            // made it for ironman
    CALLBACK_TYPE_PLAYER_ITEM_EQUIP,
    CALLBACK_TYPE_PLAYER_ITEM_CONSUME,     // deny feature ?
    CALLBACK_TYPE_PLAYER_ITEM_STORED,
    CALLBACK_TYPE_PLAYER_ITEM_SAVED,
    CALLBACK_TYPE_PLAYER_ITEM_DELETED,
    CALLBACK_TYPE_PLAYER_KILL_CREATURE,
    CALLBACK_TYPE_PLAYER_SUMMON_MINNION,
    CALLBACK_TYPE_PLAYER_SUMMON_GUARDIAN,
    CALLBACK_TYPE_PLAYER_GOSSIP_SELECT,                // when scripting non existing gossip creatures. Myeah
//    CALLBACK_TYPE_PLAYER_WEAPON_DAMAGE_CALC,
    CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY,
    CALLBACK_TYPE_PLAYER_SPELL_POST_CAST,
    CALLBACK_TYPE_PLAYER_FALL_LAND,
    CALLBACK_TYPE_CHAT_RECEIVED,
    CALLBACK_TYPE_MAP_PERIODIC_UPDATE,  // instead a global update tick, call this when we are done updating objects. A semi safe way to create spawns on this map
    CALLBACK_TYPE_CREATURE_UPDATE,
    CALLBACK_TYPE_SAME_AURA_CAN_STACK,
    MAX_CALLBACKEVENT_TYPES
};

class Creature;
class Map;
struct LootStoreItem;
class Player;
class Object;
class ObjectGuid;
struct Loot;
class Item;
struct ItemTemplate;
class Item;
enum SpellModOp : unsigned char;
class SpellInfo;
enum WeaponAttackType : unsigned char;

#ifdef _DEBUG
    #define OBJECTTYPEIDSTORE       const type_info* ObjectTypeID;
    #define StoreObjectTypeId       ObjectTypeID = &typeid(this);
    #define PointerCast(NewType,p)  ((NewType*)p)->ObjectTypeID==&typeid(NewType*)?((NewType*)p):NULL
#else
    #define OBJECTTYPEIDSTORE       
    #define StoreObjectTypeId       
    #define PointerCast(NewType,p)  ((NewType*)p)
#endif

//callback functions look alike, they are separated by function params
struct CP_WEAPON_DMG_CALC
{
    OBJECTTYPEIDSTORE
    CP_WEAPON_DMG_CALC(Player *lo, ItemTemplate const *pi, WeaponAttackType at, float *mind, float *maxd, int school) { p = lo; ItemTempl = pi; AtkType = at;  MinDmg = mind; MaxDmg = maxd; SpellSchool = school; StoreObjectTypeId }
    Player              *p;
    ItemTemplate const  *ItemTempl;
    WeaponAttackType    AtkType;
    float               *MinDmg;
    float               *MaxDmg;
    int                 SpellSchool;
};
struct CP_AURA_CAN_STACK
{
    OBJECTTYPEIDSTORE
    CP_AURA_CAN_STACK(Player *lo, Aura const *paur) { p = lo;  aur = paur; CanStack = false; StoreObjectTypeId }
    Player             *p;
    Aura const         *aur;
    bool               CanStack;
};
struct CP_FALL_INFO
{
    OBJECTTYPEIDSTORE
    CP_FALL_INFO(Player *lo, float pdist, uint32 time) { p = lo;  FallDist = pdist; FallTime = time; StoreObjectTypeId }
    Player              *p;
    float               FallDist;
    uint32              FallTime;
};
struct CP_SPELL_CAST
{
    OBJECTTYPEIDSTORE
    CP_SPELL_CAST(Player *lo, SpellInfo const *pSpell, int tgtc, WorldObject *t, void *sp, int pAttackerProcFlags, int pVictimProcFlags, int pprocSpellType)
    {
        p = lo; SpellInf = pSpell; TargetCount = tgtc; target = t;  CastedSpell = sp; AttackerProcFlags = pAttackerProcFlags; VictimProcFlags = pVictimProcFlags; procSpellType = pprocSpellType; StoreObjectTypeId
    }
    Player              *p;
    SpellInfo const     *SpellInf;
    WorldObject         *target;
    int                 TargetCount;
    void                *CastedSpell;
    int                 AttackerProcFlags;
    int                 VictimProcFlags;
    int                 procSpellType;
};
struct CP_SPELL_MOD_APPLY
{
    OBJECTTYPEIDSTORE
    CP_SPELL_MOD_APPLY(Player *lo, SpellInfo const *pSpell, uint8 pm, int32 pbase, int32 *pModf, float *pModpct) { p = lo; SpellInf = pSpell; Base = pbase;  ModType = (SpellModOp)pm; ModFlat = pModf; ModPCT = pModpct; StoreObjectTypeId }
    Player              *p;
    SpellInfo const     *SpellInf;
    SpellModOp          ModType;
    int32               Base;
    int32               *ModFlat;
    float               *ModPCT;
};
struct CP_CREATURE_SPAWN
{
    OBJECTTYPEIDSTORE
    CP_CREATURE_SPAWN(Creature *s, Map *m) { Spawn = s; map = m; StoreObjectTypeId }
	Creature    *Spawn;	// this creature is getting spawned
    Map         *map;
};
struct CP_LOOT_ROLL_CHANCE
{
    OBJECTTYPEIDSTORE
    CP_LOOT_ROLL_CHANCE(float *c, Player *lo, ItemTemplate const *pi) { chance = c; LooterPlayer = lo; Item = pi; StoreObjectTypeId }
    float               *chance;
    Player              *LooterPlayer;
    ItemTemplate const  *Item;
};
struct CP_INT32_PARAM
{
    OBJECTTYPEIDSTORE
    CP_INT32_PARAM(int32 *g, Player *lo) { Value = g; Player = lo; StoreObjectTypeId}
    int32              *Value;      // gold already generated using rates of the server
    Player             *Player; // who will receive the gold
};
struct CP_ITEM_STORED
{
    OBJECTTYPEIDSTORE
    CP_ITEM_STORED(ItemTemplate const *i, Player *lo, Item *StoredItem) { ItemTemplate = i; Owner = lo; ItemObject = StoredItem;StoreObjectTypeId}
    ItemTemplate const  *ItemTemplate;              // item that is getting stored
    Player              *Owner;                     // who will receive the item
    Item                *ItemObject;                // if we managed to store this item. Can be null ?
};
struct CP_ITEM_LOOTED
{
    OBJECTTYPEIDSTORE
    CP_ITEM_LOOTED(Player *lo, Item *i) { Owner = lo; Item = i; StoreObjectTypeId }
    Item          *Item;      // item that is getting stored
    Player        *Owner;       // who will receive the item
};
enum CP_DMG_ATTACK_TYPE
{
    CP_DMG_DIRECT_DAMAGE = 0,                            // used for normal weapon damage (not for class abilities or spells)
    CP_DMG_SPELL_DIRECT_DAMAGE = 1,                            // spell/class abilities damage
    CP_DMG_DOT = 2,
    CP_DMG_HEAL = 3,
    CP_DMG_NODAMAGE = 4,                            // used also in case when damage applied to health but not applied to spell channelInterruptFlags/etc
    CP_DMG_SELF_DAMAGE = 5,
    CP_DMG_DOT_HEAL = 6,
    CP_DMG_BASE_ATTACK = 10+0,
    CP_DMG_OFF_ATTACK = 10 + 1,
    CP_DMG_RANGED_ATTACK = 10 + 2,
};
struct CP_DMG_DONE_RECEIVED
{
    OBJECTTYPEIDSTORE
    CP_DMG_DONE_RECEIVED(Unit *pAttacker, Unit *pVictim, int32 pdmg, int const pTicks, SpellInfo const *psp, WeaponAttackType const patk, int32 pCritDmg):
      OriDamage(pdmg), TickCount(pTicks), atk(patk), sp(psp), CritDmg(pCritDmg)
    {
        Attacker = pAttacker;
        Victim = pVictim;
        FlatMods = 0;
        StoreObjectTypeId
    }
    uint32  GetDamage()
    {
        int32 FinalDamage = OriDamage + CritDmg + FlatMods;
        if (FinalDamage < 0)
            return 0;
        return FinalDamage;
    }
    void ForceDamageAbsorb()
    {
        FlatMods = - 0x0FFFFFFF;
    }
    Unit                *Attacker;     
    Unit                *Victim;       
    int32               OriDamage;
    int32               FlatMods;
    int32               CritDmg;
    int const          TickCount;
    SpellInfo const           *sp;
    WeaponAttackType const    atk;
};
struct CP_WHISPER_FROM_CLIENT
{
    OBJECTTYPEIDSTORE
    CP_WHISPER_FROM_CLIENT(Player *pWhisperer, const char  *pmsg, const char  *pDestinationPlayer) { Whisperer = pWhisperer; msg = pmsg; DestinationPlayer = pDestinationPlayer; DenyDefaultParsing = 0; StoreObjectTypeId}
    Player      *Whisperer;
    const char  *msg;     
    const char  *DestinationPlayer;
    uint32      DenyDefaultParsing;
};
struct CP_ADD_FRIEND
{
    OBJECTTYPEIDSTORE
    CP_ADD_FRIEND(Player *pPlayer, const char  *pTargetPlayer) { Player = pPlayer; TargetPlayer = pTargetPlayer; DenyDefaultParsing = 0; StoreObjectTypeId}
    Player      *Player;
    const char  *TargetPlayer;
    uint32      DenyDefaultParsing;
};
struct CP_GROUP_INVITE
{
    OBJECTTYPEIDSTORE
    CP_GROUP_INVITE(Player *pPlayer, const char  *pTargetPlayer) { Player = pPlayer; TargetPlayer = pTargetPlayer; DenyDefaultParsing = 0; StoreObjectTypeId}
    Player      *Player;
    const char  *TargetPlayer;
    uint32      DenyDefaultParsing;
};
struct CP_NAME_QUERY
{
    OBJECTTYPEIDSTORE
    CP_NAME_QUERY(Player *pPlayer, uint64 pGUID) { Player = pPlayer;GUID = pGUID; DenyDefaultParsing = 0; StoreObjectTypeId}
    Player      *Player;
    uint64      GUID;
    uint32      DenyDefaultParsing;
};
struct CP_HONOR_RECEIVE
{
    OBJECTTYPEIDSTORE
    CP_HONOR_RECEIVE(Player *pAttacker, Unit *pVictim, int32 *pHonor) { Attacker = pAttacker; Victim = pVictim;  Honor = pHonor; StoreObjectTypeId}
    Player      *Attacker;
    Unit        *Victim;
    int32       *Honor;
};
struct CP_CHAT_RECEIVED
{
    OBJECTTYPEIDSTORE
    CP_CHAT_RECEIVED(Player *pWhisperer, uint32 pType, std::string *pchannel, std::string  *pmsg, std::string  *pTo) {
        SenderPlayer = pWhisperer; MsgType = pType; Channel = pchannel; Msg = pmsg; DestinationPlayer = pTo; DenyDefaultParsing = 0; StoreObjectTypeId
    }
    Player          *SenderPlayer;
	uint32	        MsgType;
	std::string	    *Channel;
    std::string     *Msg;
    std::string     *DestinationPlayer;
    uint32          DenyDefaultParsing;
};
struct CP_MAP_CHANGED
{
    OBJECTTYPEIDSTORE
    CP_MAP_CHANGED(Player *pPlayer, Map *pMap, Map **ppMap) { Player = pPlayer; NewMap = pMap; pNewMap = ppMap; StoreObjectTypeId }
    Player          *Player;
    Map	            *NewMap;
    Map	            **pNewMap;
};
struct CP_ASK_DISABLED_FEATURE
{
    OBJECTTYPEIDSTORE
    CP_ASK_DISABLED_FEATURE(Player *pPlayer) { Player = pPlayer; DenyDefaultParsing = 0;  StoreObjectTypeId }
    Player          *Player;
    uint8           DenyDefaultParsing;
};
struct CP_ASK_DISABLED_FEATURE_MAIL
{
    OBJECTTYPEIDSTORE
    CP_ASK_DISABLED_FEATURE_MAIL(Player *pPlayer, uint32 pSender) { Player = pPlayer; DenyDefaultParsing = 0;  Sender = pSender;  StoreObjectTypeId }
    Player          *Player;
    uint32          Sender;
    uint8           DenyDefaultParsing;
};
struct CP_VENDOR_BUY_ITEM
{
    OBJECTTYPEIDSTORE
    CP_VENDOR_BUY_ITEM(Player *pPlayer, Creature *pVendor, uint32 pItemId) { Player = pPlayer; Vendor = pVendor; ItemId = pItemId; DenyDefaultParsing = 0;  StoreObjectTypeId }
    Player          *Player;
    Creature        *Vendor;
    uint32          ItemId;
    uint8           DenyDefaultParsing;
};
struct CP_MAP_PERIODIC_UPDATE
{
    OBJECTTYPEIDSTORE
    CP_MAP_PERIODIC_UPDATE(Map *pMap, uint32 pTimeDiff) { map = pMap; TimeDiff = pTimeDiff;  StoreObjectTypeId }
    Map	            *map;
    uint32          TimeDiff;
};
struct CP_LOOT_SEND
{
    OBJECTTYPEIDSTORE
    CP_LOOT_SEND(Player *pLooter, ObjectGuid *pLootedObject, Loot *pLoot) { Looter = pLooter; LootedObject = pLootedObject;  Loot = pLoot;  StoreObjectTypeId }
    Player          *Looter;
    ObjectGuid      *LootedObject;
    Loot            *Loot;
};
struct CP_ITEM_USE_DENY
{
    OBJECTTYPEIDSTORE
    CP_ITEM_USE_DENY(Player *pOwner, Item  *pitem, Creature *pCreature) { Owner = pOwner; item = pitem; DenyDefaultParsing = 0; creature = pCreature; StoreObjectTypeId }
    Player      *Owner;
    Item        *item;
    Creature    *creature;
    uint32      DenyDefaultParsing;
};
struct CP_CREATURE_INTERRACT
{
    OBJECTTYPEIDSTORE
    CP_CREATURE_INTERRACT(Player *pplayer, Creature  *pcreature) { player = pplayer; creature = pcreature; StoreObjectTypeId }
    Player      *player;
    Creature    *creature;
};
struct CP_GOSSIP_SELECT
{
    OBJECTTYPEIDSTORE
    CP_GOSSIP_SELECT(Player *pplayer, ObjectGuid  *pguid, uint32 pgossipListId, uint32 pmenuId) { player = pplayer; guid = pguid; gossipListId = pgossipListId; menuId = pmenuId; StoreObjectTypeId }
    Player      *player;
    ObjectGuid  *guid;
    uint32      gossipListId;
    uint32      menuId;
};
struct CP_ITEM_SAVED
{
    OBJECTTYPEIDSTORE
    CP_ITEM_SAVED(Item *pItemObject) { ItemObject = pItemObject; StoreObjectTypeId }
    Item        *ItemObject;
};
struct CP_ITEM_EQUIPPED
{
    OBJECTTYPEIDSTORE
    CP_ITEM_EQUIPPED(Player *lo, Item *StoredItem, bool pApply) { Owner = lo; ItemObject = StoredItem; Apply = pApply; StoreObjectTypeId }
    Player              *Owner;                 
    Item                *ItemObject;            
    bool                Apply;
};
//standard definition of a callback function
typedef void (*EventCallbackFunctionPointerSafe)(void *params, void *CallbackCreateParam);  // use this whenever possible. Context should be stored within the params
typedef void (*EventCallbackFunctionPointer)(void *params, void *CallbackCreateParam);      // use CallbackCreateParam only for static objects !

struct CallbackProfilerData
{
    uint32                          TimesCalled;                // for debug and performance profiling purpuses
    uint64                          TimeSpent;                  // for debug and performance profiling purpuses
    char                            CallStackRegistered[5000];  // for debug and performance profiling purpuses. When we register this callback, we will monitor where it came from for the sake of reporting
};
struct CallbackCreateParamStore
{
    EventCallbackFunctionPointer    cb;
    void                            *CallbackCreateParam;           // required when callback function is called at global context
    CallbackProfilerData            Statistics;
};

//each servre event type has a list of callback functions
static std::list<CallbackCreateParamStore*> GameEventCallbacks[MAX_CALLBACKEVENT_TYPES];

// scripts should call this to subscribe to a list of events
void RegisterCallbackFunction(CallbackEventTypes EventType, EventCallbackFunctionPointer Callback, void *CallbackCreateParam);

//server core should call this to trigger all subscribed callback functions
void TriggerCallbackFunctions(CallbackEventTypes EventType, void *param);

// server scripts should call this to subscribe to a list of events. Do not use this :P
void UnRegisterCallbackFunction(CallbackEventTypes EventType, EventCallbackFunctionPointer Callback, void *CallbackCreateParam);

//for object based event hooking
class ObjectCallbackSupport
{
public:
    //store a callback by attaching it to the object. A callback type helps us identify what to trigger. Callback location is the actual callback function. Everything else should be stored inside the param
    struct CallbackHookStore
    {
        EventCallbackFunctionPointerSafe    CallbackLocation;
        CallbackEventTypes                  CallbackType;
        CallbackProfilerData                Statistics;
        void                                *CallbackCreateParam;     // if some subscript registered this event, and wants to pass on some variables to the proc function
        char                                DeleteCreateParam;        // if for some reason the create script can not call cleanup or would call it in an out of order fashion
        char                                IsDeleted;                // this is set 1 if a proc deletes another proc
    };
    ObjectCallbackSupport()
    {
        ProcessingTriggers = 0;
        ProcessDeleteList = 0;
    }
    //destructor should delete allocated buffers to not leak memory
    ~ObjectCallbackSupport();
    //register a new C like function to be called when a specific event happens. Function has protection to not register the same callback more than once
    void RegisterCallbackFunc(CallbackEventTypes EventType, EventCallbackFunctionPointerSafe Callback, void *pCreateParam = NULL, char pDeleteCreateParam = 1);
    // unregister callback event. Just in case you do not wish to spam the server with useless events
    void UnRegisterCallbackFunc(CallbackEventTypes EventType, EventCallbackFunctionPointerSafe Callback, void *pCreateParam = NULL, char pDeleteCreateParam = 0);
    // trigger the actual callback of a specific type
    void TriggerCallbackFunc(CallbackEventTypes EventType, void *param);
private:
    char ProcessingTriggers, ProcessingTriggerType; // do not proc events on proc events
    char ProcessDeleteList;
    std::list<CallbackHookStore*>    Callbacks[MAX_CALLBACKEVENT_TYPES];
};

#ifdef _DEBUG
    void DebugCheckDoubleDelete(void *);
#else
    #define DebugCheckDoubleDelete(mem)  delete mem;
#endif

#endif

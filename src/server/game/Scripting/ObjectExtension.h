#ifndef __OBJECT_EXTENSION_H_
#define __OBJECT_EXTENSION_H_

#include "Define.h"
#include <map>

//in case you are out of ideas how to get a new ID, you could use __FILE__ and __LINE__ . Some compilers also support COUNTER
#define GENERATE_UNIQUE_ID(FileName,LineNumber) (crc32(FileName)*1000+LineNumber)

#ifdef _DEBUG
    #define DECLARE_EXTENSION_TYPE      std::map<uint32, const type_info*> ExtensionTypes;
    #define SET_EXTENSION_TYPE          ExtensionTypes[ID] = &typeid(T);
    #define SET_EXTENSION_TYPEINT64     ExtensionTypes[ID] = &typeid(int64);
    #define CHECK_EXTENSION_TYPE        std::map<uint32, const type_info*>::iterator i = ExtensionTypes.find(ID); \
                                        if (i->second != &typeid(T)) \
                                        { \
                                            ASSERT(false); \
                                            return NULL; \
                                        }
#else
    #define DECLARE_EXTENSION_TYPE
    #define SET_EXTENSION_TYPE
    #define SET_EXTENSION_TYPEINT64
    #define CHECK_EXTENSION_TYPE
#endif

class ObjectExtension
{
public:
    typedef std::map<uint32, void*> ExtensionSet;

    //release all allocated buffers. Do not leak out memory
    ~ObjectExtension()
    {
        //delete all allocated memory
        for (ExtensionSet::iterator itr = m_extensions.begin(); itr != m_extensions.end(); itr++)
            delete itr->second;
        //clear the list. probably done anyway
        m_extensions.clear();
    }

    //bind a memory location to an ID ( variable name )
    template <typename T>
    void SetExtension(uint32 ID, T* ptr,bool DeleteOldIfExists = false)
	{
        ExtensionSet::iterator itr = m_extensions.find(ID);
		if( ptr == NULL )
		{
			if(itr != m_extensions.end())
			{
//				*cur_value = 0;	//just mark value as destroyed for debugging
                if(DeleteOldIfExists == true)
				    delete itr->second;
                m_extensions.erase(itr);
            }
		}
		else 
		{
			//find old one and delete it
			if(itr != m_extensions.end() && ptr != itr->second )
			{
//				*cur_value = 0;	//just mark value as destroyed for debugging
                if(DeleteOldIfExists == true && itr->second != ptr)
				    delete itr->second;
//				m_extensions.erase( ID );
			}
    		m_extensions[ID] = ptr;
            SET_EXTENSION_TYPE
		}
	}

    // can return NULL
    template <typename T>
    T *GetExtension(uint32 ID)
    {
        ExtensionSet::iterator itr = m_extensions.find(ID);
        if (itr == m_extensions.end())
            return NULL;
        else
        {
            CHECK_EXTENSION_TYPE
            return (T*)itr->second;
        }
    }

    //get an extension with a specific ID. If it does not exist, create it
    template <typename T>
    T *GetCreateExtension(uint32 ID)
    {
        ExtensionSet::iterator itr = m_extensions.find(ID);
        if (itr == m_extensions.end())
        {
            T *NewInstance = new T;
            SetExtension<T>(ID, NewInstance);
            return NewInstance;
        }
        else
        {
            CHECK_EXTENSION_TYPE
            return (T*)itr->second;
        }
    }

    template <typename T>
    T *GetCreateExtension(uint32 ID, T DefaultValue)
    {
        ExtensionSet::iterator itr = m_extensions.find(ID);
        if (itr == m_extensions.end())
        {
            T *NewInstance = new T(DefaultValue);
            SetExtension<T>(ID, NewInstance);
            return NewInstance;
        }
        else
        {
            CHECK_EXTENSION_TYPE
            return (T*)itr->second;
        }
    }

    //delte extension from list and the memory associated to it
    template <typename T>
    void DeleteExtension(uint32 ID)
    {
        SetExtension<T>(ID, NULL);
    }

    //search if an in64 variable exists. Can create a new variable an initialize it. This is probably the function you will use most
	int64* GetCreateIn64Extension(uint32 ID, bool AllowNull = false, int64 DefaultValue = 0)
	{
        int64 *Ext = GetExtension<int64>( ID );
		if( Ext == NULL )
		{
            if (AllowNull == true)
                return NULL;
			int64 *p = new int64;
			*p = DefaultValue;
            m_extensions[ID] = p;
            SET_EXTENSION_TYPEINT64
			return p;
		}
		else
			return Ext;
	}
private:
    ExtensionSet m_extensions;
    DECLARE_EXTENSION_TYPE
};

#endif

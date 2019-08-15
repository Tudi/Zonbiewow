#pragma once

#define MAX_RANDOMIZER_COUNT                15          // too many item randomizers would not fit into the query buffer MAX_MESSAGE_LENGTH. This needs to be limited
#define MAX_ITEM_LEVEL                      296.0f      // item scaling will be done based on the current itemtemplate database !!!

#include <list>
#include "ObjectGuid.h"

#ifdef _DEBUG
//    #define FORCE_GEN_STATS_ON_ITEMS    // debugging the addon
#endif

//do not ever change the order of this list ! Can only add new tyoes to the end
enum RIStatTypes {
    RI_STAT_TYPE_NOT_USED,
    RI_Strength,
    RI_Agility,
    RI_Stamina,
    RI_Intelect,
    RI_SPIRIT,
    RI_HEALTH,
    RI_MANA,                                          
    RI_RAGE,
    RI_FOCUS,
    RI_ENERGY,
    RI_RUNE,
    RI_RUNIC_POWER,
    RI_ARMOR,
    RI_RESISTANCE_HOLY,
    RI_RESISTANCE_FIRE,
    RI_RESISTANCE_NATURE,
    RI_RESISTANCE_FROST,
    RI_RESISTANCE_SHADOW,
    RI_RESISTANCE_ARCANE,
    RI_ATTACK_POWER,
    RI_ATTACK_POWER_RANGED,
    RI_DAMAGE_MAINHAND,
    RI_DAMAGE_OFFHAND,
    RI_DAMAGE_RANGED,
    RI_DODGE,
    RI_PARRY,
    RI_BLOCK_RATING,
    RI_BLOCK,
    RI_HIT_MELEE,
    RI_HIT_RANGED,
    RI_HIT_SPELL,
    RI_CRIT_MELEE,
    RI_CRIT_RANGED,
    RI_CRIT_SPELL,
    RI_HIT_TAKEN_MELEE,
    RI_HIT_TAKEN_RANGED,
    RI_HIT_TAKEN_SPELL,
    RI_CRIT_TAKEN_MELEE,
    RI_CRIT_TAKEN_RANGED,
    RI_CRIT_TAKEN_SPELL,
    RI_HASTE_MELEE,
    RI_HASTE_RANGED,
    RI_HASTE_SPELL,
    RI_EXPERTISE,
    RI_ARMOR_PENETRATION,
    RI_HIT_RATING,
    RI_CRIT_RATING,
    RI_HIT_TAKEN_RATING,
    RI_CRIT_TAKEN_RATING,
    RI_RESILIANCE_RATING,
    RI_HASTE_RATING,
    RI_MANA_REGEN,
    RI_SPELL_POWER,
    RI_HEALTH_REGEN,
    RI_SPELL_PENETRATION,
    RI_MAGIC_FIND_INSTANCES,
    RI_MAGIC_FIND_POWER_INSTANCES,
    RI_Move_Speed,
    RI_Move_Mounted_Speed,
    RI_Damage_Physical,
    RI_Damage_Holy,
    RI_Damage_Fire,
    RI_Damage_Nature,
    RI_Damage_Frost,
    RI_Damage_Shadow,
    RI_Damage_Arcane,
    RI_SPELL_AURA_MOD_HEALING_TAKEN,
    RI_Damage_Target_HP_PCT,
    RI_Damage_Target_HP_MISSING_PCT,
    RI_HEAL_TARGET_HP_PCT,
    RI_HEAL_TARGET_MISSING_HP_PCT,
    RI_AURA_DURATION_Flat,
    RI_AURA_DURATION_PCT,
    RI_SPELL_DAMAGE_Flat,
    RI_SPELL_DAMAGE_PCT,
    RI_SPELL_DOT_DAMAGE_Flat,
    RI_SPELL_DOT_DAMAGE_PCT,
    RI_SPELL_CRIT_DMG_Flat,
    RI_SPELL_CRIT_DMG_PCT,
    RI_SPELL_TREATH_REDUCTION,
    RI_DropChanceNoJunk,
    RI_MELEE_CRIT_DMG_PCT,
    RI_RANGED_CRIT_DMG,
    RI_SPELL_THREATH_BOOST, // to be removed
    RI_HEALTH_REGEN_ALWAYS,
    RI_HEALTH_REGEN_ALWAYS_PCT,
    RI_HEALTH_REGEN_MISSING_PCT,
    RI_HEALTH_REGEN_EXISTING_PCT,
    RI_POWER_REGEN_PCT,
    RI_POWER_BURN_TARGET,
    RI_POWER_BURN_TARGET_PCT,
    RI_SPELL_TARGET_PLUS,
    RI_GAIN_DUAL_WIELD,
    RI_GAIN_TITAN_GRIP,
    RI_SPELL_KNOCKBACK,
    RI_SPELL_AURA_MOD_CRITICAL_HEALING_AMOUNT,
    RI_SPELL_AURA_MOD_HIT_CHANCE,
    RI_SPELL_AURA_MOD_SPELL_HIT_CHANCE,
    RI_SPELL_AURA_MANA_SHIELD_1,
    RI_SPELL_AURA_MANA_SHIELD_2,
    RI_SPELL_AURA_WATER_WALK,
    RI_SPELL_AURA_FEATHER_FALL,
    RI_SPELL_AURA_HOVER,
    RI_TAKEN_SPELL_AURA_MOD_HEALING_PCT,
    RI_SPELL_AURA_MOD_HEALING_DONE,
    RI_SPELL_AURA_MOD_HEALING_DONE_PERCENT,
    RI_MAGIC_FIND_NON_INSTANCE,
    RI_MAGIC_FIND_POWER_NON_INSTANCE,
    RI_LIFE_STEAL_FLAT,
    RI_LIFE_STEAL_PCT,
    RI_POWER_BURN_FLAT,
    RI_POWER_MISSING_TO_DMG_PCT,
    RI_DAMAGE_RECEIVED_TO_MANA,
    RI_DAMAGE_RECEIVED_TO_MANA_PCT,
    RI_Cloack_On_Deadly_Blow,   
    RI_EXTRA_GOLD_PCT,
    RI_ICEBLOCK_On_Deadly_Blow,   
    RI_DivineShield_On_Deadly_Blow,
    RI_MIN_MAX_DMG,
    RI_SPELL_AURA_HASTE_SPELLS,
    RI_EXPLODE_ON_TARGET_DIE,
    RI_CHAIN_LIGHTNING_ON_STRUCK_1,
    RI_DAMAGE_TAKEN_AGRO_COUNT_FLAT,
    RI_DAMAGE_TAKEN_TO_DONE_FLAT,
    RI_DAMAGE_TAKEN_TO_DONE_PCT,
    RI_Strength_PCT,
    RI_Agility_PCT,
    RI_Stamina_PCT,
    RI_Intelect_PCT,
    RI_SPIRIT_PCT,
    RI_STAT_ALL_PCT,
    RI_SPELL_AURA_REDUCE_PUSHBACK,
    RI_SPELLMOD_GLOBAL_COOLDOWN,
    RI_DMG_TAKEN_RAID_SIZE_FLAT,
    RI_DMG_TAKEN_RAID_SIZE_PCT,
    RI_DMG_DONE_RAID_SIZE_FLAT,
    RI_DMG_DONE_RAID_SIZE_PCT,
    RI_DMG_TAKEN_FROM_GOLD_FLAT,
    RI_Talent_Points,
    RI_SHARED_HP_TANK_FLAT,
    RI_SHARED_HP_TANK_PCT,
    RI_SHARED_HP_CASTER_FLAT,
    RI_SHARED_HP_CASTER_PCT,
    RI_CHANCE_TO_REDUCE_COOLDOWN_OF_PREVIOUS_SPELL_FLAT,
    RI_LOW_HEALTH_EXTRA_DMG_FLAT,
    RI_LOW_HEALTH_EXTRA_DMG_PCT,
    RI_LOW_HEALTH_EXTRA_DODGE,
    RI_LOW_HEALTH_EXTRA_ABSORB,
    RI_STAT_DROPCHANCE,
    RI_MAX_HP_DMG_TAKEN,
    RI_AURA_ICE_ARMOR,
    RI_AURA_DEMON_ARMOR,
    RI_AURA_FEL_ARMOR,
    RI_AURA_METAMORPHOSIS,
    RI_GAIN_REINCARNATION,
    RI_DEBUFF_ON_HEAL,
    RI_CAST_DISPERSION_ON_DEADLY_BLOW,
    RI_CHANCE_TO_DISENGAGE_ON_DMG,
    RI_TARGET_CAST_STORMSTRIKE_ON_HEAL,
    RI_POTION_COOLDOWN_CLEAR,
    RI_OVERHEALS_ADD_TO_TARGET_DAMAGE,
    RI_PARTY_MIMICS_SELF_CASTS,
    RI_MY_HEALTH_BASED_HEAL,
    RI_CHANCE_DOUBLE_CAST,
    RI_UTIL_STAT_DROPCHANCE,
    RI_ATTACK_STAT_DROPCHANCE,
    RI_DEFENSE_STAT_DROPCHANCE,
    RI_DAMAGE_FOR_UNIQUE_KILL,
    RI_HEAL_FOR_UNIQUE_KILL,
    RI_DAMAGE_FOR_UNIQUE_USABLE_ITEM,
    RI_HEAL_FOR_UNIQUE_USABLE_ITEM,
    RI_DAMAGE_FOR_ACHIEVEMENTS_EARNED,
    RI_HEAL_FOR_ACHIEVEMENTS_EARNED,
    RI_DMG_FOR_QUESTS,
    RI_HEAL_FOR_QUESTS,
    RI_DMG_FOR_HONORABLE_KILLS_RATING,
    RI_HEAL_FOR_HONORABLE_KILLS_RATING,
    RI_SPELLMOD_COST,
    RI_LEATHER_PROFICIENCY,
    RI_MAIL_PROFICIENCY,
    RI_PLATE_PROFICIENCY,
    RI_1H_AXE_PROFICIENCY,
    RI_1H_MACE_PROFICIENCY,
    RI_1H_SWORD_PROFICIENCY,
    RI_POLEARM_PROFICIENCY,
    RI_SHIELD_PROFICIENCY,
    RI_2H_AXE_PROFICIENCY,
    RI_2H_MACE_PROFICIENCY,
    RI_2H_SWORD_PROFICIENCY,
    RI_STAFF_PROFICIENCY,
    RI_LEARN_FROST_NOVA,
    RI_LEARN_SUMMON_SUCUBUS,
    RI_LEARN_CHARGE,
    RI_LEARN_INERVATE,
    RI_GAIN_MARK_OF_THE_WILD,
    RI_LEARN_NATURE_GRASP,
    RI_LEARN_REBIRTH,
    RI_LEARN_Deterrence,
    RI_LEARN_RapidFire,
    RI_LEARN_ARCANE_POWER,
    RI_LEARN_COUNTERSPELL,
    RI_LEARN_EVOCATION,
    RI_LEARN_Focus_Magic,
    RI_LEARN_ICY_VEINS,
    RI_LEARN_DIVINE_STORM,
    RI_LEARN_SEAL_OF_LIGHT,
    RI_LEARN_DIVINE_HYMN,
    RI_LEARN_HYMN_OF_HOPE,
    RI_LEARN_INNER_FOCUS,
    RI_LEARN_MANA_BURN,
    RI_LEARN_LAST_STAND,
    RI_LEARN_BLOODLUST,
    RI_LEARN_SHAMANISTIC_RAGE,
    RI_LEARN_BLADE_FURY,
    RI_LEARN_COLD_BLOOD,
    RI_LEARN_FAN_OF_KNIVES,
    RI_LEARN_KILLING_SPREE,
    RI_LEARN_HYSTERIA,
    RI_WINDFURRY_WEAPON,
    RI_INCREASE_THREATH_FOR_PETS,
    RI_PET_AURA_IMMOLATION,
    RI_DMG_LOGIN_STREAK,
    RI_HEAL_LOGIN_STREAK,
	RI_CHANCE_TO_CHARGE_ON_TARGET_SWAP,
    RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_STRENGTH_PERCENT,
    RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_AGILITY_PERCENT,
    RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_INTELECT_PERCENT,
    RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_SPIRIT_PERCENT,
    RI_SPELL_AURA_MOD_SPELL_HEAL_OF_STRENGTH_PERCENT,
    RI_SPELL_AURA_MOD_SPELL_HEAL_OF_AGILITY_PERCENT,
    RI_SPELL_AURA_MOD_SPELL_HEAL_OF_INTELECT_PERCENT,
    RI_SPELL_AURA_MOD_SPELL_HEAL_OF_SPIRIT_PERCENT,
    RI_HEALS_RECHARGE_ABSORBS,
    RI_CHANCE_TO_DISCOVER_TRANSMOG_ON_KILL,
    RI_RUN_BURNING_STEPS,
    RI_RUN_CAST_PREV_SPELL,
    RI_SPELL_AURA_MOD_ATTACK_POWER_OF_ARMOR,
    RI_SPELL_AURA_MOD_ATTACK_POWER_OF_STRENGTH_PERCENT,
    RI_SPELL_AURA_MOD_ATTACK_POWER_OF_AGILITY_PERCENT,
    RI_SPELL_AURA_MOD_ATTACK_POWER_OF_INTELECT_PERCENT,
    RI_SPELL_AURA_MOD_ATTACK_POWER_OF_SPIRIT_PERCENT,
    RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_STRENGTH_PERCENT,
    RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_AGILITY_PERCENT,
    RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_INTELECT_PERCENT,
    RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_SPIRIT_PERCENT,
    RI_CAST_WHILE_MOVE,
    RI_CAST_INSTANT_SPELLS_IN_PARALLEL,
    RI_IGNORE_CAST_FACING,
    RI_NEGATIVE_MELEE_HASTE_TO_DMG,
    RI_NEGATIVE_RANGED_HASTE_TO_DMG,
    RI_NEGATIVE_SPELL_HASTE_TO_DMG,
    RI_NEGATIVE_SPELL_HASTE_TO_HEAL,
    RI_DAMAGE_SCHOOL_CHANGE_TO_FIRE,
    RI_DAMAGE_SCHOOL_CHANGE_TO_NATURE,
    RI_DAMAGE_SCHOOL_CHANGE_TO_FROST,
    RI_DAMAGE_SCHOOL_CHANGE_TO_SHADOW,
    RI_DAMAGE_SCHOOL_CHANGE_TO_ARCANE,
    RI_HELLFIRE_ON_JUMP,
    RI_ELECTROCUTE_WHILE_CASTING,
    RI_DIABLO_WALKS_AMONG_US,
    RI_HEAL_DISTANCE_BASED,
    RI_BLOOD_LUST_ON_DAMAGE_TAKEN,
    RI_MOVE_EXPLODE,
    RI_FIST_PROFICIENCY,
    RI_SPELLMOD_RANGE,
    RI_INCREASE_AURA_MAX_STACK,
    RI_ARMOR_TO_RESISTANCE_HOLY,
    RI_ARMOR_TO_RESISTANCE_FIRE,
    RI_ARMOR_TO_RESISTANCE_NATURE,
    RI_ARMOR_TO_RESISTANCE_FROST,
    RI_ARMOR_TO_RESISTANCE_SHADOW,
    RI_ARMOR_TO_RESISTANCE_ARCANE,
    RI_PCT_HEAL_NEARBY_PLAYER_COUNT,
    RI_PCT_DMG_NEARBY_PLAYER_COUNT,
    RI_PCT_DUST_GAIN_PCT,
    RI_LEARN_TELEPORT,
    RI_LEARN_RIGHTOUS_FURY,
    RI_DMG_KILLSTREAK_BASED_FLAT,
    RI_HEAL_LOWHEALTH_HEAL_STREAK_FLAT,
    RI_SMOOTH_DAMAGE_OVER_TIME,
    RI_DIVIDE_DAMAGE_OVER_TIME,
    RI_BLOOD_RUNE_REGEN_FLAT,
    RI_UNHOLY_RUNE_REGEN_FLAT,
    RI_FROST_RUNE_REGEN_FLAT,
    RI_DEATH_RUNE_REGEN_FLAT,
    RI_RUNIC_POWER_REGEN_PCT,
    RI_ENERGY_REGEN_PCT,
    RI_FOCUS_REGEN_FLAT,
    RI_RAGE_POWER_REGEN_PCT,
    RI_SPRINT_ON_KILL,
    RI_EXTRA_DMG_WHILE_BEHIND_TARGET,
    RI_EXTRA_DEFENSE_WHILE_FACE_TARGET,
    RI_HEAL_RESTORE_RECENT_DMG_TAKEN_PCT,
    RI_XP_GAIN, // for hardcore
    RI_SINGLE_TARGET_TO_AOE_DMG,
    RI_CHAIN_LIGHTNING_ON_HIT_1,
    RI_CHAIN_LIGHTNING_ON_HIT_2,
    RI_CHAIN_LIGHTNING_ON_HIT_3,
    RI_CHAIN_LIGHTNING_ON_STRUCK_2,
    RI_CHAIN_LIGHTNING_ON_STRUCK_3,
    RI_LEARN_DEATH_GRIP,
    RI_HEALTH_TO_DAMAGE,
    RI_DAMAGE_DONE_PCT,
    RI_DAMAGE_DONE_FLAT,

        RI_MAX_STAT_TYPES,  // these can be picked. Rest should be in the works

        RI_STAT_DUST_GAIN_ON_SALE = 1000, // this is hardcoded in the client
        RI_STAT_ITEMS_SACRIFICED,         // hardcoded in DB to store sacrifice count
        RI_STAT_DPS_CHANGE_ON_EQUIP,      // tell client how much you would gain if you would equip this item
        RI_STAT_DEFENSE_CHANGE_ON_EQUIP,  // tell client how much you would gain if you would equip this item
        RI_STAT_ATK_SCORE,
        RI_STAT_DEF_SCORE,

    RI_WAND_SKILL,
    RI_DAMAGE_TAKEN_DAMAGE_DONE_FLAT, // for casters to balance on tanks
    RI_DAMAGE_TAKEN_DAMAGE_DONE_PCT,
    RI_DAMAGE_BASED_ON_STAT_DIVERSITY,
    RI_SMART_STAT_DROPPING,   // chance to find a stat upgrade
    RI_FLIGHT_ON_JUMP,
    RI_NONCLASS_SPELL_REGENS_POWER,
    RI_REDUCE_ITEM_COOLDOWNS_FLAT,
    RI_OUT_OF_INSTANCE_MFP_MINROLL_PCT,
    RI_REPAIR_ON_COMPANION,
    RI_SPAWN_EMPOWER_POINTS_SPEED,
    RI_SPAWN_EMPOWER_POINTS_POWER,
    RI_SPAWN_EMPOWER_POINTS_DEFENSE,
    RI_MAX_LEVEL_INCREASE,
    RI_CHANCE_TO_DISCOVER_TRANSMOG_MOUNT_ON_INSTANCE_CLEAR,
    RI_SPELL_X_IS_AOE_TARGETTING,   //lay of hands, vanish, fiegn death, last stand, barkskin, Shadow Ward, fear ward
    RI_CAST_BACK_GOOD_SPELLS,
    RI_CHANCE_TO_REPEAT_OLDER_CAST,
    RI_PROTECTIVE_SHIELD_CAP,   // shield keeps regening until it reaches this cap
    RI_PROTECTIVE_SHIELD_RECHARGE,
    RI_SPELL_AURA_MOD_RESISTANCE_OF_STAT_PERCENT,
    RI_SPELL_AURA_MOD_ATTACKER_SPELL_CRIT_CHANCE,
    RI_SPELL_AURA_MOD_ATTACKER_MELEE_HIT_CHANCE,
    RI_SPELL_AURA_MOD_ATTACKER_RANGED_HIT_CHANCE,
    RI_SPELL_AURA_MOD_ATTACKER_SPELL_HIT_CHANCE,
    RI_SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_CHANCE,
    RI_SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_CHANCE,
    RI_SPELL_AURA_MOD_TARGET_ABSORB_SCHOOL,
    RI_SPELL_AURA_MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE,
    RI_SPELL_AURA_HASTE_RANGED,
    RI_SPELL_AURA_MOD_HOT_PCT,
    RI_SPELL_AURA_MOD_HEALING_RECEIVED,
    RI_CREATE_HEALTH_POTION,
    RI_ShieldBasedOnHealth,
    RI_Clear_CoolDown_SpellSPecific,
    RI_Specific_Spell_damage,
    RI_SPECIFIC_SpawnCreature,
    RI_LOCK_ON,     // cast spell even if target is out of range
    RI_AUTO_EMPOWERED_SHIELD_ON_COMBAT, //entering combat will automatically grant you an empowered shield
    RI_REGEN_ON_STEALTH,    // entering stealth will grant you life regen
    RI_MAKE_AFK_PEOPLE_DANCE,
    RI_MAKE_AFK_PEOPLE_DRUNK,
    RI_SPECIFIC_TALENT,
    RI_SPECIFIC_TALENT_MOD,
    RI_SPELLMOD_CRITICAL_CHANCE = 7,
    RI_SPELLMOD_IGNORE_ARMOR = 13,
    RI_SPELLMOD_RESIST_MISS_CHANCE = 16,
    RI_SPELLMOD_DAMAGE_MULTIPLIER = 20,
    RI_SPELLMOD_BONUS_MULTIPLIER = 24,
    RI_SPELLMOD_VALUE_MULTIPLIER = 27,
};

struct PossibleRandomStatRolls;
class RI_PlayerStore;

class RI_StatStore
{
public:
    RI_StatStore()
    {
        ProcDataStore = NULL;
    }
    ~RI_StatStore();
    bool RollStatType(PossibleRandomStatRolls *RI_PickableStats, RI_PlayerStore *rip, int MaxStatCount, bool UpdateRollChance);
    bool RollStatPower(float RIPowerScaler);
    RIStatTypes     Type;
    float           Power;
    void            *ProcDataStore;
};

struct ItemTemplate;
class Field;
class Item;
class Player;
class RI_PlayerStore;

class RI_ItemStore
{
public:
    RI_ItemStore(Item *it);
    ~RI_ItemStore();
    char *FormatQueryResponse(RI_PlayerStore *ps, Player *p, int TransactionID,char *AppendTo = NULL);
    void PushClientAddonUpdate(Player *SendToPlayer = NULL);
    void MarkClientIsUpdated(bool Updated = true);
    void GenerateRandomStats(const Item *BaseItem, int Difficulty, int MagicFind, int MagicStrength, int PlayerClass, RI_PlayerStore *rip);
    void LoadFromDB(Player *p, Item *it, Field *f);
    void SaveToDB();
    void DeleteFromDB();
    bool SkipSave();
    void ApplyEffects(Player *p, Item *it,bool Apply);
    int GetDestroyDustAmount();
    float GetRollStrength(int RGB1, int RGB2);
    float GetStatSum(int Type);
    bool IsLoadedFromDB() { return LoadedFromDatabase!=0; }
    std::list<RI_StatStore*> *GetStats() {  return &ItemExtraStats; }
    bool ReRollStatTypeAtIndex(int index);
    bool ReRollStatValueAtIndex(int index);
    void OnPlayerRevive();
private:
    bool ReRollStat(RI_StatStore *riss, RI_PlayerStore *rip, PossibleRandomStatRolls *RI_PickableStats, int MaxStatCount, bool UsePlayerRollChanceMods, float RIPowerScaler);
    std::list<RI_StatStore*> ItemExtraStats;
    Item *Owner;
    ObjectGuid LoadedForPlayer;     // used to check if owner of the item changed since we loaded it from DB
    char    LoadedFromDatabase;     // no need to save it again. Should be deleted when item is deleted
    char    HasEffectsApplied;
    uint16  LastUpdatedClientSlot;
};

void RI_ItemSaved(void *p, void *);
void RI_ItemDeleted(void *p, void *);
void RI_ApplyRandomStatsOnItemChange(void *p, void *);
char *FormatQueryResponseEmpty(int TransactionID);
bool RI_RerollStatTypeAtIndex(Player *p, Item *i, int Index);
bool RI_RerollStatValueAtIndex(Player *p, Item *i, int Index);
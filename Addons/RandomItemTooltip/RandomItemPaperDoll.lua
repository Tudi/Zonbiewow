--local RI_Realm = "InfiniScale" 
local IRS = RANDOM_ITEM_IRS     -- item random stat format string DB
local IRSC = RANDOM_ITEM_IRSC   -- item random stat color
local IRNRL = RANDOM_ITEM_IRNRL -- max value a stat can roll at 100% diff

RI_STAT_TOTAL = {}
for i=1,#IRS do 
   RI_STAT_TOTAL[i] = {
      StatValue = 0
   }
end
  
--if GetRealmName() == RI_Realm then
if  PLAYERSTAT_MAGICFIND == nil then 
   table.insert(PLAYERSTAT_DROPDOWN_OPTIONS, 6, "PLAYERSTAT_MAGICFIND")
   _G[PLAYERSTAT_DROPDOWN_OPTIONS[6]] = "Magic Find"    
   table.insert(PLAYERSTAT_DROPDOWN_OPTIONS, 7, "PLAYERSTAT_PASSIVEEFFECTS")
   _G[PLAYERSTAT_DROPDOWN_OPTIONS[7]] = "Passive Effects" 
   table.insert(PLAYERSTAT_DROPDOWN_OPTIONS, 8, "PLAYERSTAT_CHANCEEFFECTS")
   _G[PLAYERSTAT_DROPDOWN_OPTIONS[8]] = "Chance Effects" 
    table.insert(PLAYERSTAT_DROPDOWN_OPTIONS, 9, "PLAYERSTAT_AGGRESSIVEEFFECTS")
   _G[PLAYERSTAT_DROPDOWN_OPTIONS[9]] = "Aggressive Effects" 
   --maybe only display dropdown option when we have a stat to prevent clutter? 
end
--end

local function IsActiveBuff(buff) -- 
  for i=1,40 do
   local name = UnitBuff("player",i)
   if name == buff then return true end
  end
 return false
end

local function round(number, decimals) 
   return (("%%.%df"):format(decimals)):format(number)
end


function GetRiTotalStats(StatType)
--	if GetRealmName() ~= RI_Realm then return end -- No reason to qury on unsuported realm/server
	QuryStatTotalAmount(StatType)
	if nil == RI_STAT_TOTAL[StatType].StatValue then return 0 end
	local StatValue = RI_STAT_TOTAL[StatType].StatValue
  return tonumber(round(StatValue,0))

end

local origPaperDollFrame_UpdateStats= PaperDollFrame_UpdateStats;  -- hook
	PaperDollFrame_UpdateStats = function() 
		--
 return origPaperDollFrame_UpdateStats()
end

local origOnServerMessage = OnServerMessage;  -- hook
OnServerMessage = function(...) 
   local message = ...;  
   if( string.find(message, ".#RIQS ") ~= nil ) then --
      Tag, StatType, StatValue = strsplit(" ", message)
      StatType = tonumber(StatType)
     -- print("Got stat type "..StatType.." name "..IRS[StatType].." = "..StatValue)	  
	  RI_STAT_TOTAL[StatType] = {StatValue = StatValue} -- store total results
      return origOnServerMessage(...) -- returns RIQS to RandomItemTooltip if it has other uses
   end
   return origOnServerMessage(...)
end

   local origUpdatePaperdollStats = UpdatePaperdollStats;  -- hook
UpdatePaperdollStats = function(...) 
   local prefix,index = ...;    
   
   local stat1 = _G[prefix..1]; 
   local stat2 = _G[prefix..2];
   local stat3 = _G[prefix..3];
   local stat4 = _G[prefix..4];
   local stat5 = _G[prefix..5];
   local stat6 = _G[prefix..6];

   _G[stat1:GetName().."StatText"]:SetTextColor(1, 1, 1) -- sets statframes back to white if changed previously  
   _G[stat2:GetName().."StatText"]:SetTextColor(1, 1, 1) -- May be a better way
   _G[stat3:GetName().."StatText"]:SetTextColor(1, 1, 1)
   _G[stat4:GetName().."StatText"]:SetTextColor(1, 1, 1) 
   _G[stat5:GetName().."StatText"]:SetTextColor(1, 1, 1) 
   _G[stat6:GetName().."StatText"]:SetTextColor(1, 1, 1)       
   
   if ( index == "PLAYERSTAT_MELEE_COMBAT" ) then
	 stat5:Show();  -- "PaperDollFrame_SetMeleeCritChance" missing this for some reason
   elseif  ( index == "PLAYERSTAT_MAGICFIND" ) then
      PaperDollFrame_SetMagicFind(stat1)
      PaperDollFrame_SetMagicFindPower(stat2)
      PaperDollFrame_SetMagicFindOutOfInstance(stat3)
      PaperDollFrame_SetMagicFindOutOfInstancePower(stat4)
      PaperDollFrame_SetEquipItemDropChance(stat5)
      PaperDollFrame_SetExtraGold(stat6)
   elseif (index == "PLAYERSTAT_PASSIVEEFFECTS" ) then
      PaperDollFrame_SetGainHover(stat1)
      PaperDollFrame_SetGainFeatherFall(stat2)
      PaperDollFrame_SetGainWaterWalk(stat3)
      PaperDollFrame_SetGainDualWield(stat4)
      PaperDollFrame_SetGainTitansGrip(stat5)
      PaperDollFrame_Set(stat6)
   elseif (index == "PLAYERSTAT_CHANCEEFFECTS") then
      PaperDollFrame_SetChanceDivineShield(stat1)
	  PaperDollFrame_SetChanceIceBlock(stat2)
	  PaperDollFrame_SetChanceCloack(stat3)
	  PaperDollFrame_SetChanceKnockdown(stat4)
	  stat5:Hide(); 
      PaperDollFrame_Set(stat6)
   elseif (index == "PLAYERSTAT_AGGRESSIVEEFFECTS") then
      PaperDollFrame_SetChainLightningOnStruck(stat1)
      PaperDollFrame_SetTargetExplodesOnKill(stat2)
	  stat3:Hide(); 
      stat4:Hide(); 
	  stat5:Hide(); 
      PaperDollFrame_Set(stat6) -- oddy placed stat6:Show() in UpdatePaperdollStats. Hidework around
   end
  return origUpdatePaperdollStats(...); 
end
--------------------------------------------------------
--                PLAYERSTAT_MAGICFIND                --
--------------------------------------------------------
function PaperDollFrame_SetMagicFind(statFrame, unit)
		--QuryEquiptSlot()
   _G[statFrame:GetName().."Label"]:SetText("Find:");  
   _G[statFrame:GetName().."StatText"]:SetTextColor(1, 1, 1)     
   _G[statFrame:GetName().."StatText"]:SetText(GetRiTotalStats(56));
     statFrame.tooltip = "increase number of dropped stats"; 
   statFrame:Show();
end
function PaperDollFrame_SetMagicFindPower(statFrame, unit)
   _G[statFrame:GetName().."Label"]:SetText("Find Power:");
   _G[statFrame:GetName().."StatText"]:SetTextColor(1, 1, 1)  
   _G[statFrame:GetName().."StatText"]:SetText(GetRiTotalStats(57));
     statFrame.tooltip = "increase the stat limit an item can roll"; 
   statFrame:Show();
end
function PaperDollFrame_SetMagicFindOutOfInstance(statFrame, unit)
   _G[statFrame:GetName().."Label"]:SetText("Find World:");
   _G[statFrame:GetName().."StatText"]:SetTextColor(1, 1, 1)  
   _G[statFrame:GetName().."StatText"]:SetText(GetRiTotalStats(107));
   statFrame.tooltip = "Chance to find random enchant\n on items outside of instances."; 
   statFrame:Show();
end
function PaperDollFrame_SetMagicFindOutOfInstancePower(statFrame, unit)
   _G[statFrame:GetName().."Label"]:SetText("Find World Power:");
   _G[statFrame:GetName().."StatText"]:SetTextColor(1, 1, 1)  
   _G[statFrame:GetName().."StatText"]:SetText(GetRiTotalStats(108).."%");
     statFrame.tooltip = "increase the stat limit an item can roll in the world"; 
   statFrame:Show();
end
function PaperDollFrame_SetEquipItemDropChance(statFrame, unit)
   _G[statFrame:GetName().."Label"]:SetText("Drop Chance:");
   _G[statFrame:GetName().."StatText"]:SetTextColor(1, 1, 1)  
   _G[statFrame:GetName().."StatText"]:SetText(GetRiTotalStats(81).."%");
   statFrame.tooltip = "Increases the chance of\n obtaining an equiptment item"; 
   statFrame:Show();
end
function PaperDollFrame_SetExtraGold(statFrame, unit)
   _G[statFrame:GetName().."Label"]:SetText("Extra Gold:");
   _G[statFrame:GetName().."StatText"]:SetTextColor(1, 1, 1)    
   _G[statFrame:GetName().."StatText"]:SetText(GetRiTotalStats(116).."%");
   statFrame.tooltip = "Increases the amount of\n gold obtained from loot"; 
   statFrame:Show();
end
--------------------------------------------------------
--             PLAYERSTAT_PASSIVEEFFECTS              --
--------------------------------------------------------
function PaperDollFrame_SetGainHover(statFrame, unit)
	local IsActive = "Inactive" ; g = 0 ; r = 1
   _G[statFrame:GetName().."Label"]:SetText("Hover:");
    if IsActiveBuff("Hover") == true then IsActive = "Active"; g = 1; r =0 end   
   _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)   
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Floating a few feet above the ground,\n granting slow fall, and allowing travel over water."; 
   statFrame:Show();
end
function PaperDollFrame_SetGainFeatherFall(statFrame, unit)
    local IsActive = "Inactive" ; g = 0 ; r = 1
   _G[statFrame:GetName().."Label"]:SetText("Feather Fall:");
    if IsActiveBuff("Slow Fall") == true then IsActive = "Active"; g = 1; r =0 end
   _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)      
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Slows falling speed."; 
   statFrame:Show();
end
function PaperDollFrame_SetGainWaterWalk(statFrame, unit)
   local IsActive = "Inactive" ; g = 0 ; r = 1
   _G[statFrame:GetName().."Label"]:SetText("Water Walk:"); 
    if IsActiveBuff("Water Walking") == true then IsActive = "Active"; g = 1; r =0 end
   _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)     
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Allows walking over water."; 
   statFrame:Show();
end
function PaperDollFrame_SetGainDualWield(statFrame, unit)
	local IsActive = "Inactive" ; g = 0 ; r = 1
   _G[statFrame:GetName().."Label"]:SetText("Dual Wield:");
 if IsSpellKnown(674) == true then IsActive = "Active"; g = 1; r =0 end   
   _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)       
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Allows one-hand and off-hand weapons\n to be equipped in the off-hand."; 
   statFrame:Show();
end
function PaperDollFrame_SetGainTitansGrip(statFrame, unit) -- GetGainTitansGrip()
	local IsActive = "Inactive" ; g = 0 ; r = 1
	if GetRiTotalStats(94) >= 1 then 
		IsActive = "Active";g = 1; r =0 
	 else 
		IsActive = "Inactive"; g = 0 ; r = 1 
	end 
   
   _G[statFrame:GetName().."Label"]:SetText("Titans Grip:");     
   _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)       
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Allows you to dual-wield a\n pair of two-handed weapons."; 
   statFrame:Show();
end
--------------------------------------------------------
--             PLAYERSTAT_CHANCEEFFECTS               --
--------------------------------------------------------
function PaperDollFrame_SetChanceDivineShield(statFrame, unit)
   local IsActive = "Inactive" ; g = 0 ; r = 1
	if GetRiTotalStats(118) >= 1 then 
		IsActive = "Active";g = 1; r =0 
	 else 
		IsActive = "Inactive"; g = 0 ; r = 1 
	end 
	
   _G[statFrame:GetName().."Label"]:SetText("Divine Shield:");
   _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)     
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Chance to Divine shield on Deadly Blow."; 
   statFrame:Show();
end
function PaperDollFrame_SetChanceIceBlock(statFrame, unit)
 local IsActive = "Inactive" ; g = 0 ; r = 1
	if GetRiTotalStats(117) >= 1 then 
		IsActive = "Active";g = 1; r =0 
	 else 
		IsActive = "Inactive"; g = 0 ; r = 1 
	end 
 
   _G[statFrame:GetName().."Label"]:SetText("Ice Block:");        
   _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)       
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Chance to Ice Block on Deadly Blow."; 
   statFrame:Show();
end
function PaperDollFrame_SetChanceCloack(statFrame, unit)
 local IsActive = "Inactive" ; g = 0 ; r = 1
	if GetRiTotalStats(115) >= 1 then 
		IsActive = "Active";g = 1; r =0 
	 else 
		IsActive = "Inactive"; g = 0 ; r = 1 
	end 
   _G[statFrame:GetName().."Label"]:SetText("Cloack:");        
   _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)       
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
        statFrame.tooltip = "Chance to Cloack on Deadly Blow."; 
   statFrame:Show();
end
function PaperDollFrame_SetChanceKnockdown(statFrame, unit)
 local IsActive = "Inactive" ; g = 0 ; r = 1
	if GetRiTotalStats(95) >= 1 then 
		IsActive = "Active";g = 1; r =0 
	 else 
		IsActive = "Inactive"; g = 0 ; r = 1 
	end 

    _G[statFrame:GetName().."Label"]:SetText("Knockdown:");        
    _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)     
    _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Chance to Knockdown target."; 
   statFrame:Show();
end
--------------------------------------------------------
--           PLAYERSTAT_AGGRESSIVEEFFECTS             --
--------------------------------------------------------
function PaperDollFrame_SetChainLightningOnStruck(statFrame, unit)
 local IsActive = "Inactive" ; g = 0 ; r = 1
	if GetRiTotalStats(122) >= 1 then 
		IsActive = "Active";g = 1; r =0 
	 else 
		IsActive = "Inactive"; g = 0 ; r = 1 
	end 
	
   _G[statFrame:GetName().."Label"]:SetText("Chain Lightning:");        
    _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)        
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Being hit will cast Chain Lightning."; 
   statFrame:Show();
end
function PaperDollFrame_SetTargetExplodesOnKill(statFrame, unit)
 local IsActive = "Inactive" ; g = 0 ; r = 1
	if GetRiTotalStats(121) >= 1 then 
		IsActive = "Active";g = 1; r =0 
	 else 
		IsActive = "Inactive"; g = 0 ; r = 1 
	end 
   _G[statFrame:GetName().."Label"]:SetText("Exploding Kills:");        
    _G[statFrame:GetName().."StatText"]:SetTextColor(r, g, 0)      
   _G[statFrame:GetName().."StatText"]:SetText(IsActive);
     statFrame.tooltip = "Upon killing a target they will explode."; 
   statFrame:Show();
end
function PaperDollFrame_Set(statFrame, unit)
   _G[statFrame:GetName().."Label"]:SetText("");        
   _G[statFrame:GetName().."StatText"]:SetText("");
     statFrame.tooltip = ""; 
   statFrame:Show();
end
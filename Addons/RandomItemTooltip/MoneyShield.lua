local function FormatMoney(money)
   local ret = ""
   local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
   local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
   local copper = mod(money, COPPER_PER_SILVER);
   if gold > 0 then
      ret = gold .. " gold "
   end
   if silver > 0 or gold > 0 then
      ret = ret .. silver .. " silver "
   end
   ret = ret .. copper .. " copper"
   return ret
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_MONEY")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)      
      local tmpMoney = GetMoney()
	  if event == "COMBAT_LOG_EVENT_UNFILTERED"  then 
      if self.CurrentMoney then
         self.DiffMoney = tmpMoney - self.CurrentMoney
      else
         self.DiffMoney = 0
      end
      self.CurrentMoney = tmpMoney
	 if self.DiffMoney > 0 then
        -- ChatFrame1:AddMessage("You gained " .. FormatMoney(self.DiffMoney) .. ".")
      elseif self.DiffMoney < 0 then   
			CombatText_AddMessage("Money Shield", COMBAT_TEXT_SCROLL_FUNCTION, 1, 1, 1,_ , 1);
	  end
	  end
end)
--when you place an item in one of the slots, 
--it jsut sends a message to the server from inventory x1,y1 to cube x2,y2
-- it would need at least one button : combine
--which sends another message to the server
-- .#RIC A b1 s1 b2 s2 b3 
local NumHoradricSlots = 9

Horadric = CreateFrame("Frame", "Horadric", Horadric, "UIPanelDialogTemplate")
Horadric:SetSize(130, 175)--1 = 3x3,190= 3x3+1center, 230= 3x12, 
Horadric:EnableMouse(true)
Horadric:SetMovable(true)
Horadric:RegisterForDrag("LeftButton")
Horadric:SetPoint("CENTER" )
Horadric:SetScript("OnDragStart", Horadric.StartMoving)
Horadric:SetScript("OnDragStop", Horadric.StopMovingOrSizing)
Horadric:SetScript("OnHide", function(self) ResetHoradricButtons() DisableAddOn("Horadric") end)

local fontstring = Horadric:CreateFontString(nil, "ARTWORK", "GameFontNormal")
fontstring:SetPoint("TOPLEFT",12,-8)
fontstring:SetText("Horadric")

HoradricCombine = CreateFrame("BUTTON", "HoradricCombine", Horadric, "GameMenuButtonTemplate")
HoradricCombine:SetSize(120, 25)
HoradricCombine:SetText("Combine");
HoradricCombine:SetScript("OnMouseDown", function(self, button) HoradricCombine_OnClick(self, button) end)

local button, lastButton, texture;
button = CreateFrame("BUTTON", "HoradricButton1", Horadric, "ItemButtonTemplate");
button:SetPoint("LEFT", 10, 43); -- 50,70
button:SetScript("OnMouseDown", function(self, button) HoradricButton_OnClick(self, button) end)
button:SetScript("OnReceiveDrag", function(self, button) HoradricButton_OnClick(self, "LeftButton") end)
button:SetScript("OnEnter", function(self, button) HoradricButton_OnEnter(self) end)
button:SetScript("OnLeave", function(self, button) HoradricButton_OnLeave(self) end)

lastButton = HoradricButton1
lastButton.slot = 1;


SLASH_HORADRIC1 = "/horadric"
SLASH_HORADRIC2 = "/hcube"
SlashCmdList["HORADRIC"] = function(msg)
  Horadric:Show()
end 

for i=2,NumHoradricSlots do
   button = CreateFrame("BUTTON", "HoradricButton"..i, Horadric, "ItemButtonTemplate");
   button:SetScript("OnMouseDown", function(self, button) HoradricButton_OnClick(self, button) end)
   button:SetScript("OnReceiveDrag", function(self, button) HoradricButton_OnClick(self, "LeftButton") end)
   button:SetScript("OnEnter", function(self, button) HoradricButton_OnEnter(self) end)
   button:SetScript("OnLeave", function(self, button) HoradricButton_OnLeave(self) end)
   if ( mod(i, 3) == 1 ) then
      button:SetPoint("TOP", _G["HoradricButton"..(i - 3)], "BOTTOM", 0, -2);
   else
      button:SetPoint("LEFT", lastButton, "RIGHT", 1, 0);
   end
	if HoradricButton9 then 
		HoradricCombine:SetPoint("CENTER", HoradricButton8, "BOTTOM", 0, -13);
	end
   lastButton = button;
   lastButton.slot = i;
   lastButton.hasItem = false;
end

function HoradricPlaceItem(self)
	local infoType, info1, info2 = GetCursorInfo()
	local _, link, _, _, _, _, _,_, _, textureName = GetItemInfo(info1);			
		if (infoType == "item") then	
			self.icon = textureName
			self.itemid = info1
			self.hasItem = true
			self.orgbagbutton = LAST_LOCKED_ITEMBUTTON
			self.locked = true
				if self.orgbagbutton == nil then HoradricRemoveItem(self);ClearCursor()	; return end -- equipt item to heradric cancle
			--print(self:GetName().." Set to "..info2.." from "..self.orgbagbutton:GetName() )
		end		
	ClearCursor()	
	HoradricButton_OnUpdate()
	HoradricButton_OnEnter(self)--instant tooltipshow
end

function HoradricRemoveItem(self)
	if self.orgbagbutton ~= nil then ContainerFrame_Update(self.orgbagbutton:GetParent()) end		
	self.icon = nil
	self.itemid = nil
	self.hasItem = false;
	self.orgbagbutton = nil
	self.locked = false
	SetItemButtonTexture(self,self.icon)	
	HoradricButton_OnUpdate()
	GameTooltip:Hide()
end 

function ResetHoradricButtons()
local button
	for i =1,NumHoradricSlots do		
       button = _G["HoradricButton"..i]
	   if button:IsShown() then
		 HoradricRemoveItem(button)
	   end
	end  
	HoradricButton_OnUpdate()
end

function GetHoradricButtons(i)
local button
	button = _G["HoradricButton"..i]
	if button.orgbagbutton == nil then return end 
  return button.orgbagbutton
end

function GetHoradricInfo(i)
local button
	button = _G["HoradricButton"..i]	
	if button.itemid == nil then return end
	local itemName, link, itemQuality, _, _, _, _,_, _, textureName = GetItemInfo(button.itemid);
  return button.itemid, textureName, button.locked ,button.hasItem ,button.orgbagbutton
end

function GetInUseHoradricSlot()
	local button;
	for i=1, NumHoradricSlots do
		button = _G["HoradricButton"..i]
		if ( not button.hasItem ) then
			return i;
		end
	end
	return 9;
end

function HoradricButton_OnClick(self, button)
	--print(self:GetName().." "..button)
	if button == "RightButton" then
		HoradricRemoveItem(self)
		HoradricButton_OnUpdate()
	end
	if button == "LeftButton" then
		if CursorHasItem() then
			 HoradricPlaceItem(self)
			 HoradricButton_OnUpdate()	
		else		
			if self.hasItem then
				local bag,slot = self.orgbagbutton:GetParent():GetID(),self.orgbagbutton:GetID()
				--print("Picking up Horadric item from "..self.orgbagbutton:GetName())
				PickupContainerItem(bag,slot)
				HoradricRemoveItem(self)				
			end
		end
	end
end

function HoradricButton_OnUpdate()
   local button
   local BS
   for i =1,NumHoradricSlots do		
   local itemid, textureName, locked ,hasItem ,orgbagbutton = GetHoradricInfo(i)
       button = _G["HoradricButton"..i]
	   SetItemButtonTexture(button,button.icon)	   
	   SetItemButtonDesaturated(orgbagbutton, locked, 0.5, 0.5, 0.5);
   end
end

function HoradricButton_OnEnter(self)
  GameTooltip:SetOwner( self, "anchor" )
  if self.hasItem then 
   local itemName, link, itemQuality, _, _, _, _,_, _, textureName = GetItemInfo(self.itemid);
	GameTooltip:SetHyperlink(link)
	GameTooltip:Show()
  end
end

function HoradricButton_OnLeave(self)
  GameTooltip:Hide()
  
end

-- .#RIC A b1 s1 b2 s2 b3 
function HoradricCombineAccept()
local bag={}
local slot={}
local index =2
  for i=1,NumHoradricSlots do bag[i]  = " ";	slot[i] = " "; end		
	for i=1,NumHoradricSlots do	
		local itemid, textureName, locked ,hasItem ,orgbagbutton = GetHoradricInfo(i)
		 if hasItem then
		    if i == 5 then 
				bag[1]  = orgbagbutton:GetParent():GetID()
				slot[1] = orgbagbutton:GetID()-1
		    else
				for i2=1,GetInUseHoradricSlot() do
					bag[index]  = orgbagbutton:GetParent():GetID()
					slot[index] = orgbagbutton:GetID()-1
				end
			  index = index+1	
		    end			  
		 end
	end	
	local RIC = bag[1].." "..slot[1].." "..
			    bag[2].." "..slot[2].." "..
				bag[3].." "..slot[3].." "..
				bag[4].." "..slot[4].." "..
				bag[5].." "..slot[5].." "..
				bag[6].." "..slot[6].." "..
				bag[7].." "..slot[7].." "..
				bag[8].." "..slot[8].." "..
				bag[9].." "..slot[9];
				
	--print(".#RIC 0 "..RIC)
	AddonCommSendPacketToServer("RIC", "0 "..RIC)
	ResetHoradricButtons()
end

 function HoradricCombine_OnClick(self, button)
	 StaticPopup_Show("HORADRIC_ACCEPT")
	 HoradricCombineAccept()
 end
 
local frame, events = CreateFrame("Frame"), {};
function events:CHAT_MSG_CHANNEL(...)
	OnServerMessage(...)
end
function events:ITEM_LOCKED(bag,slot)
local button
	bag = bag+1
	local ContainerFrame = _G["ContainerFrame"..bag]
	--print(ContainerFrame.size)
	if slot == nil then return end
	if ContainerFrame == nil then return end
	if ContainerFrame.size  == nil then return end --equipt item locking error
	local index = ContainerFrame.size + 1 - slot;
	button = _G["ContainerFrame"..bag.."Item"..index]
    LAST_LOCKED_ITEMBUTTON = button
end

frame:SetScript("OnEvent", function(self, event, ...)
	events[event](self, ...); 
end);
for k, v in pairs(events) do
	frame:RegisterEvent(k);
end

StaticPopupDialogs["HORADRIC_ACCEPT"] = {
  text = "Are you sure you wish to combine these items??",
  button1 = "Yes",
  button2 = "No",
  OnAccept = function()
      HoradricCombineAccept()
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3, 
}

local function ClickToHoradricWAR(self, button)
   if Horadric:IsShown() then
      if ( button == "RightButton" ) then    
         local bag,slot = self:GetParent():GetID(),self:GetID()
         local button = _G["HoradricButton"..GetInUseHoradricSlot()]
         PickupContainerItem(bag,slot)
         HoradricButton_OnClick(button, "LeftButton")
         return        
      end
   end
end
Horadric:Hide()

--[[ --not useable causes forbidden action error on item use.
if Horadric:IsVisible() then 
hooksecurefunc("ContainerFrameItemButton_OnClick", function(self, button) ClickToHoradricWAR(self, button) end)
else
local origContainerFrameItemButton_OnClick= ContainerFrameItemButton_OnClick; -- Right clicking items in to Horadric Frame
	ContainerFrameItemButton_OnClick = function(self, button)			  	  -- unable to eat/drink/use items. protected action.
	if Horadric:IsShown() then
		if ( button == "RightButton" ) then	
			local bag,slot = self:GetParent():GetID(),self:GetID()
			local button = _G["HoradricButton"..GetInUseHoradricSlot()]
				PickupContainerItem(bag,slot)
				HoradricButton_OnClick(button, "LeftButton")
			return		
		end
	end
   return origContainerFrameItemButton_OnClick(self, button)
end
end]]--

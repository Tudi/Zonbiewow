local MainFrameWidth = 512
local MainFrameHeight = 128

-- create main window frame
local MainWindowFrame = CreateFrame("Frame", "DragFrame2", UIParent)
MainWindowFrame:SetMovable(true)
MainWindowFrame:EnableMouse(true)
MainWindowFrame:RegisterForDrag("LeftButton")
MainWindowFrame:SetScript("OnDragStart", MainWindowFrame.StartMoving)
MainWindowFrame:SetScript("OnDragStop", MainWindowFrame.StopMovingOrSizing)

-- The code below makes the frame visible, and is not necessary to enable dragging.
MainWindowFrame:SetPoint("TOPRIGHT")
MainWindowFrame:SetSize(MainFrameWidth, MainFrameHeight)
--MainWindowFrame.tex = MainWindowFrame:CreateTexture("ARTWORK")
--MainWindowFrame.tex:SetAllPoints()
--MainWindowFrame.tex:SetTexture(0.5, 0.5, 0.5, 0.5)

MainWindowFrame.tex = MainWindowFrame:CreateTexture(nil,"BACKGROUND")
MainWindowFrame.tex:SetTexture("Interface\\AddOns\\RandomItemTooltip\\Images\\PBar6.tga",true)
MainWindowFrame.tex:SetPoint("CENTER",0,0)
--MainWindowFrame.tex:SetBlendMode("DISABLE")
--MainWindowFrame.tex:SetBlendMode("BLEND")

-- create a label and describe our addon
MainWindowFrame.ButtonAsLabel = CreateFrame("Button", "DescriptiveLabel", MainWindowFrame, "UIPanelButtonTemplate2")
MainWindowFrame.ButtonAsLabel:SetPoint("CENTER", -70, 50)
MainWindowFrame.ButtonAsLabel:SetText("At what difficulty should the next instance be created ?")
MainWindowFrame.ButtonAsLabel:SetSize(1,1)

-- create the slide bar
MainWindowFrame.slider = CreateFrame("Slider", "TestSlider", MainWindowFrame, "OptionsSliderTemplate")
MainWindowFrame.slider:SetPoint("CENTER", -25, 6)
MainWindowFrame.slider:SetWidth(MainWindowFrame:GetWidth() - 95)
MainWindowFrame.slider:SetMinMaxValues(-90, 1000)
MainWindowFrame.slider:SetValueStep(1)
getglobal(MainWindowFrame.slider:GetName() .. 'Low'):SetText('')
getglobal(MainWindowFrame.slider:GetName() .. 'High'):SetText('')
--getglobal(MainWindowFrame.slider:GetName() .. 'Text'):SetText('At what difficulty should the next instance be created ?')
MainWindowFrame.slider:SetScript("OnValueChanged", function(self, value)
--      button:SetPoint("CENTER", value, 0)
		if value ~= 0 then
--			print('Next created instance difficulty will be set to '..value..'%')
		end
--		if value >= 0 then
--			MainWindowFrame.tex:SetTexture( value / 1000 , 0, 0, 0.5)
--		else 
--			MainWindowFrame.tex:SetTexture(0, -value / 90, 0, 0.5)
--		end
end)
MainWindowFrame.slider:SetValue(0)

-- create a button in top right corner to minimize the addon
MainWindowFrame.IsShown = 1

local ButtonToMinimizeHCube = CreateFrame("Button", "MinimizeCube", MainWindowFrame, "UIPanelButtonTemplate2")
ButtonToMinimizeHCube:SetText("C")
ButtonToMinimizeHCube:SetSize(20,20)
ButtonToMinimizeHCube:SetPoint("TOPRIGHT", -20, 0 )
ButtonToMinimizeHCube:SetScript("OnClick", function(self, button, down)
	if(Horadric:IsVisible()) then
		Horadric:Hide()
	else
		Horadric:Show()
	end
end)
SetTooltip(ButtonToMinimizeHCube,"Horadric cube will let you recraft existing items")

local ButtonToMinimizeStatFilter = CreateFrame("Button", "MinimizeFilter", MainWindowFrame, "UIPanelButtonTemplate2")
ButtonToMinimizeStatFilter:SetText("F")
ButtonToMinimizeStatFilter:SetSize(20,20)
ButtonToMinimizeStatFilter:SetPoint("TOPRIGHT", -40, 0 )
ButtonToMinimizeStatFilter:SetScript("OnClick", function(self, button, down)
	if(HideStatsFrame:IsVisible()) then
		HideStatsFrame:Hide()
	else
		HideStatsFrame:Show()
	end
end)
SetTooltip(ButtonToMinimizeStatFilter,"You can filter which stats to be shown on items. Stat will be there, just not visible")

local ButtonToMinimizeShowStats = CreateFrame("Button", "MinimizeStatList", MainWindowFrame, "UIPanelButtonTemplate2")
ButtonToMinimizeShowStats:SetText("S")
ButtonToMinimizeShowStats:SetSize(20,20)
ButtonToMinimizeShowStats:SetPoint("TOPRIGHT", -60, 0 )
ButtonToMinimizeShowStats:SetScript("OnClick", function(self, button, down)
	if(ShowStatValues:IsVisible()) then
		ShowStatValues:Hide()
	else
		ShowStatValues:Show()
	end
end)
SetTooltip(ButtonToMinimizeShowStats,"View a list of stats from all your items equipped right now")

local ButtonToPragonStats = CreateFrame("Button", "ParagonStatList", MainWindowFrame, "UIPanelButtonTemplate2")
ButtonToPragonStats:SetText("P")
ButtonToPragonStats:SetSize(20,20)
ButtonToPragonStats:SetPoint("TOPRIGHT", -80, 0 )
ButtonToPragonStats:SetScript("OnClick", function(self, button, down)
	if(ParagonStatValues:IsVisible()) then
		ParagonStatValues:Hide()
	else
		ParagonStatValues:Show()
	end
end)
SetTooltip(ButtonToPragonStats,"spend Paragon points")

local ButtonToLootFilterConfig = CreateFrame("Button", "LootFilterConfig", MainWindowFrame, "UIPanelButtonTemplate2")
ButtonToLootFilterConfig:SetText("L")
ButtonToLootFilterConfig:SetSize(20,20)
ButtonToLootFilterConfig:SetPoint("TOPRIGHT", -100, 0 )
ButtonToLootFilterConfig:SetScript("OnClick", function(self, button, down)
	if(SelectLootFiltering:IsVisible()) then
		SelectLootFiltering:Hide()
	else
		SelectLootFiltering:Show()
	end
end)
SetTooltip(ButtonToLootFilterConfig,"Configure what type of loot you wish to receive")

local ButtonToPersonalTeleportation = CreateFrame("Button", "PersonalTele", MainWindowFrame, "UIPanelButtonTemplate2")
ButtonToPersonalTeleportation:SetText("T")
ButtonToPersonalTeleportation:SetSize(20,20)
ButtonToPersonalTeleportation:SetPoint("TOPRIGHT", -120, 0 )
ButtonToPersonalTeleportation:SetScript("OnClick", function(self, button, down)
	if(TeleportLocationsFrame:IsVisible()) then
		TeleportLocationsFrame:Hide()
	else
		TeleportLocationsFrame:Show()
	end
end)
SetTooltip(ButtonToPersonalTeleportation,"Use personal teleportation system")

local ButtonToMinimize = CreateFrame("Button", "MinimizeSlider", MainWindowFrame, "UIPanelButtonTemplate2")
ButtonToMinimize:SetText("D")
ButtonToMinimize:SetSize(20,20)
ButtonToMinimize:SetPoint("TOPRIGHT", 0, 0 )
ButtonToMinimize:SetScript("OnClick", function(self, button, down)
	if(MainWindowFrame.IsShown == 0) then
		MainWindowFrame:SetSize(MainFrameWidth, MainFrameHeight)
		--MainWindowFrame:Show()
		MainWindowFrame.slider:Show()
		MainWindowFrame.ButtonAsLabel:Show()
		MainWindowFrame.IsShown = 1
		MainWindowFrame.tex:Show()
	else
	--	MainWindowFrame:Hide()
		MainWindowFrame.slider:Hide()
		MainWindowFrame.ButtonAsLabel:Hide()
		--MainWindowFrame:Hide()
		MainWindowFrame:SetSize(1,MainFrameHeight)
		MainWindowFrame.IsShown = 0;
		MainWindowFrame.tex:Hide()
	end
end)
SetTooltip(ButtonToMinimize,"Make this addon very small, to not take up visible space")

-- periodically update server with the status of the scrollbar
local total = 0
local LastSent = 0
local function onUpdate(self,elapsed)
    total = total + elapsed
    if total >= 1 and LastSent ~= MainWindowFrame.slider:GetValue() then
		LastSent = MainWindowFrame.slider:GetValue()
		local playerName = UnitName("player");
        SendAddonMessage(nil, "#csInstanceDiffSet "..LastSent, "WHISPER", playerName)
--		SendChatMessage("#csInstanceDiffSet "..LastSent,WHISPER,nil,playerName)
        total = 0
    end
end
local f = CreateFrame("frame")
f:SetScript("OnUpdate", onUpdate)
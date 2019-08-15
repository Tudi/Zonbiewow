DropFilteringTypesEnum = {
    DROP_ONLY_ACTIVE_QUEST_ITEMS   = 1,
    DROP_ONLY_QUEST_ITEMS          = 2,
    DROP_ONLY_EMPTY                = 4,    
    DROP_SKIP_NON_EQUIP            = 8,    
    DROP_SKIP_EQUIP                = 16,   
    DROP_SKIP_GRAY                 = 32,
    DROP_SKIP_WHITE                = 64,
    DROP_SKIP_GREEN                = 128,
    DROP_SKIP_BLUE                 = 256,
    DROP_SKIP_EPIC                 = 512,
    DROP_ONLY_CRAFTING             = 1024, 
}

local FilteringStatus = 0

-- create main window frame
SelectLootFiltering = CreateFrame("Frame", "SelectLootFiltering", nil)
SelectLootFiltering:SetMovable(true)
SelectLootFiltering:EnableMouse(true)
SelectLootFiltering:RegisterForDrag("LeftButton")
SelectLootFiltering:SetScript("OnDragStart", SelectLootFiltering.StartMoving)
SelectLootFiltering:SetScript("OnDragStop", SelectLootFiltering.StopMovingOrSizing)

-- The code below makes the frame visible, and is not necessary to enable dragging.
SelectLootFiltering:SetSize(170, 260)
SelectLootFiltering.tex = SelectLootFiltering:CreateTexture("ARTWORK")
SelectLootFiltering.tex:SetAllPoints()
SelectLootFiltering.tex:SetTexture(0.5, 0.5, 0.5, 0.5)
SelectLootFiltering:SetPoint("Center", 0, 0);

SelectLootFiltering.ButtonAsLabel = CreateFrame("Button", "DescriptiveLabel", SelectLootFiltering, "UIPanelButtonTemplate2")
SelectLootFiltering.ButtonAsLabel:SetPoint("TOPLeft", SelectLootFiltering:GetWidth() / 2, -10)
SelectLootFiltering.ButtonAsLabel:SetText("Configure loot filtering")
SelectLootFiltering.ButtonAsLabel:SetSize(1,1)

local FilterRowsCreated = 0
local LootFilterCheckboxes = {}
function AddNewStatRow(StatName,StatDescription)
	-- create a label we can use to show the status of the stat
	ButtonAsLabel = CreateFrame("CheckButton", "FilterCheckBox"..FilterRowsCreated, SelectLootFiltering, "ChatConfigCheckButtonTemplate")
	ButtonAsLabel:SetPoint("TOPLeft", 10, -25 - FilterRowsCreated * 20)
	getglobal(ButtonAsLabel:GetName() .. 'Text'):SetText(StatName)
	ButtonAsLabel.OriginalText = StatName;
	SetTooltip(ButtonAsLabel,StatDescription)
	--ButtonAsLabel:SetSize(150, 20)
	ButtonAsLabel.Index = FilterRowsCreated
	ButtonAsLabel:SetScript("OnMouseDown", function(self, button) OnClickToggleFilter(self.Index) end)
	
	LootFilterCheckboxes[FilterRowsCreated] = ButtonAsLabel
	FilterRowsCreated = FilterRowsCreated + 1
end

AddNewStatRow("Active Quests","Only roll on items that are needed for an active quest")
AddNewStatRow("Quest Items","Only roll on items that might be required for quests. Even if you did not start the quest")
AddNewStatRow("No drops","No items should drop. Powerleveling")
AddNewStatRow("Only equipement","Only roll on items that can be equipped by the player")
AddNewStatRow("No equipement","Only roll on items that can not be equipped by the player")
AddNewStatRow("No Gray","Skip rolling on items with gray quality")
AddNewStatRow("No White","Skip rolling on items with white quality")
AddNewStatRow("No Green","Skip rolling on items with green quality")
AddNewStatRow("No Blue","Skip rolling on items with blue quality")
AddNewStatRow("No Purple","Skip rolling on items with purple quality")
AddNewStatRow("Craft materials only","For ironman and hardcore mode to be able to level professions")

function OnClickToggleFilter(Index)
	--print("Trying to toggle filter "..Index)
	AddonCommSendPacketToServer("QLFS","1 "..Index)
end

function QueryStatusOfLootFilteringOptions()
	-- send query to the server
	SendGreeting()
	AddonCommSendPacketToServer("QLFS","0")
end

function UpdateFilteringStatusFrameContent()
	for i = 0,FilterRowsCreated,1 do
		if(LootFilterCheckboxes[i] ~= nil) then		
			local FilterMask = bit.lshift(1,LootFilterCheckboxes[i].Index)
--print( "FilterMask "..FilterMask.." for "..LootFilterCheckboxes[i].Index.." server mask "..FilteringStatus.." checkbox "..LootFilterCheckboxes[i].OriginalText)
			if(bit.band(FilteringStatus,FilterMask) ~= 0) then
				LootFilterCheckboxes[i]:SetChecked(true)
			else
				LootFilterCheckboxes[i]:SetChecked(false)
			end
		end
	end
end

function OnServerFilterStatusUpdate(message)
	FilteringStatus = tonumber(message)
--print("Server sent paragon stat "..StatType.." value "..StatValue)
	UpdateFilteringStatusFrameContent()	
end

-- our DB might be outdated
RegisterOpcodeHandler("QLF ",OnServerFilterStatusUpdate)
SelectLootFiltering:SetScript("OnShow", QueryStatusOfLootFilteringOptions);
SelectLootFiltering:Hide()

local PStatValues = {}

-- create main window frame
ParagonStatValues = CreateFrame("Frame", "ParagonStatValues", nil)
ParagonStatValues:SetMovable(true)
ParagonStatValues:EnableMouse(true)
ParagonStatValues:RegisterForDrag("LeftButton")
ParagonStatValues:SetScript("OnDragStart", ParagonStatValues.StartMoving)
ParagonStatValues:SetScript("OnDragStop", ParagonStatValues.StopMovingOrSizing)

ParagonStatValues:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", 
                                            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border", 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 4, right = 4, top = 4, bottom = 4 }});
											
-- The code below makes the frame visible, and is not necessary to enable dragging.
ParagonStatValues:SetSize(190, 373)
ParagonStatValues.tex = ParagonStatValues:CreateTexture("ARTWORK")
ParagonStatValues.tex:SetAllPoints()
--ParagonStatValues.tex:SetTexture(0.5, 0.5, 0.5, 0.5)
ParagonStatValues:SetPoint("Center", 0, 0);

ParagonStatValues.ButtonAsLabel = CreateFrame("Button", "DescriptiveLabel", ParagonStatValues, "UIPanelButtonTemplate2")
ParagonStatValues.ButtonAsLabel:SetPoint("TOPLeft", ParagonStatValues:GetWidth() / 2, -10)
ParagonStatValues.ButtonAsLabel:SetText("Paragon Status")
ParagonStatValues.ButtonAsLabel:SetSize(1,1)

local StatRowsCreated = 0
local ParagonStatLabels = {}
function AddNewStatRow(StatName,StatDescription, ServerSideStatIndex)
	-- create a label we can use to show the status of the stat
	ButtonAsLabel = CreateFrame("Button", "PStat"..StatRowsCreated, ParagonStatValues, "UIPanelButtonTemplate2")
	ButtonAsLabel:SetPoint("TOPLeft", 10, -25 - StatRowsCreated * 20)
	ButtonAsLabel:SetText(StatName)
	ButtonAsLabel.OriginalText = StatName
	ButtonAsLabel.ServerSideStatIndex = ServerSideStatIndex
	SetTooltip(ButtonAsLabel,StatDescription)
	ButtonAsLabel:SetSize(150, 20)

	if( StatRowsCreated > 1 ) then
		ButtonAsLabel.Index = StatRowsCreated
		ButtonAsLabel:SetScript("OnMouseDown", function(self, button) OnClickBuyStat(self.Index - 2) end)
		
		-- create a button which helps us add more stats
		local ButtonAsAdd = CreateFrame("Button", "PStatAdd"..StatRowsCreated, ParagonStatValues, "UIPanelButtonTemplate2")
		ButtonAsAdd:SetPoint("TOPLeft", 150 + 5, -25 - StatRowsCreated * 20)
		ButtonAsAdd:SetText("+")
		ButtonAsAdd:SetSize(25, 20)
		ButtonAsAdd.Index = StatRowsCreated
		ButtonAsAdd:SetScript("OnMouseDown", function(self, button) OnClickBuyStat(self.Index - 2) end)
		ButtonAsAdd.ServerSideStatIndex = ServerSideStatIndex
		SetTooltip(ButtonAsAdd,StatDescription)
	end
	
	ParagonStatLabels[StatRowsCreated] = ButtonAsLabel
	StatRowsCreated = StatRowsCreated + 1
end

AddNewStatRow("Level","Amount of experiance the account has gained after reaching max level on played characters",-2)
AddNewStatRow("Unspent points","Spend these to customize your character. Paragon stats do not depend on equipped items",-1)
AddNewStatRow("Strength","Base damage modifier. Gets converted into attack power. Increases shield block value",0)
AddNewStatRow("Agility","Base damage modifier. Gets converted into attack power. Increases armor. Increases crit chance for some classes. Increases dodge chance.",1)
AddNewStatRow("Stamina","Increases max health",2)
AddNewStatRow("Intelect","Increases max mana. Increases mana regen. Increases crit chance for some classes.",3)
AddNewStatRow("Spirit","Increases mana regen",4)
AddNewStatRow("Movement speed","Increases movement speed on land, while not mounted.",5)
AddNewStatRow("Haste","Reduces time between attacks",6)
AddNewStatRow("Critical chance","The chance for a damage to receive critical damage bonus",7)
AddNewStatRow("Critical damage","Increases the bonus damage amount when you land a critical strike",8)
AddNewStatRow("Armor","Reduces physical damage taken",9)
AddNewStatRow("Resist magic","Reduces damage taken from magical attacks",10)
AddNewStatRow("Life regen","Increases life regenerated while out of combat",11)
AddNewStatRow("Area damage","Potion of single target damage will get converted periodically into an area explosion",12)
AddNewStatRow("Life steal","Portion of damage dealt will be converted into health gained",13)
AddNewStatRow("Dust gain","Magical dust can be spent to modify drop chances of item magical effects",14)

function OnClickBuyStat(Index)
	--print("Trying to buy stat "..Index)
	AddonCommSendPacketToServer("PABS",""..Index)
end

function QueryStatusOfParagonFrame()
	-- send query to the server
	SendGreeting()
	AddonCommSendPacketToServer("PAAS","")
end

function UpdateParagonStatusFrameContent()
	for i = 0,StatRowsCreated,1 do
		if(ParagonStatLabels[i] ~= nil and PStatValues[ParagonStatLabels[i].ServerSideStatIndex] ~= nil) then		
--print("	original text is "..ParagonStatLabels[i].OriginalText.." stat value is "..PStatValues[i-2])
			ParagonStatLabels[i]:SetText( ParagonStatLabels[i].OriginalText.." : "..PStatValues[ParagonStatLabels[i].ServerSideStatIndex])
		end
	end
end

function OnServerParagonStatUpdate(message)
	local StatType, StatValue = strsplit(" ", message)
--print("Server sent paragon stat "..StatType.." value "..StatValue)
	PStatValues[tonumber(StatType)] = StatValue
	UpdateParagonStatusFrameContent()	
end

-- our DB might be outdated
RegisterOpcodeHandler("PASS",OnServerParagonStatUpdate)
ParagonStatValues:SetScript("OnShow", QueryStatusOfParagonFrame);
ParagonStatValues:Hide()

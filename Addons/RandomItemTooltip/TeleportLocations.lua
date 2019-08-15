local TeleportLocationNames = {}

-- create main window frame
TeleportLocationsFrame = CreateFrame("Frame", "TeleportLocationsFrame", nil)
TeleportLocationsFrame:SetMovable(true)
TeleportLocationsFrame:EnableMouse(true)
TeleportLocationsFrame:RegisterForDrag("LeftButton")
TeleportLocationsFrame:SetScript("OnDragStart", TeleportLocationsFrame.StartMoving)
TeleportLocationsFrame:SetScript("OnDragStop", TeleportLocationsFrame.StopMovingOrSizing)

-- The code below makes the frame visible, and is not necessary to enable dragging.
TeleportLocationsFrame:SetSize(470, 120)
TeleportLocationsFrame.tex = TeleportLocationsFrame:CreateTexture("ARTWORK")
TeleportLocationsFrame.tex:SetAllPoints()
TeleportLocationsFrame.tex:SetTexture(0.5, 0.5, 0.5, 0.5)
TeleportLocationsFrame:SetPoint("Center", 0, 0);

TeleportLocationsFrame.ButtonAsLabel = CreateFrame("Button", "DescriptiveLabel", TeleportLocationsFrame, "UIPanelButtonTemplate2")
TeleportLocationsFrame.ButtonAsLabel:SetPoint("TOPLeft", TeleportLocationsFrame:GetWidth() / 2, -10)
TeleportLocationsFrame.ButtonAsLabel:SetText("Teleport locations")
TeleportLocationsFrame.ButtonAsLabel:SetSize(1,1)

local TeleRowsCreated = 0
local TeleportLocationEditBoxes = {}
function AddNewStatRow(StatName,StatDescription, ServerSideStatIndex)
	-- create a label we can use to show the status of the stat
	local Editbox = CreateFrame("EditBox", "TeleName"..TeleRowsCreated, TeleportLocationsFrame, "InputBoxTemplate")
	Editbox:SetPoint("TOPLeft", 10, -25 - TeleRowsCreated * 20)
	Editbox:SetText(StatName)
	--Editbox.OriginalText = StatName
	--Editbox.ServerSideStatIndex = ServerSideStatIndex
	SetTooltip(Editbox,StatDescription)
	Editbox:SetSize(140, 20)
	Editbox.Index = TeleRowsCreated
		
	-- create a button record location
	local ButtonAsCreate = CreateFrame("Button", "TeleStore"..TeleRowsCreated, TeleportLocationsFrame, "UIPanelButtonTemplate2")
	ButtonAsCreate:SetPoint("TOPLeft", 150 + 5, -25 - TeleRowsCreated * 20)
	ButtonAsCreate:SetText("Create here")
	ButtonAsCreate:SetSize(150, 20)
	ButtonAsCreate.Index = TeleRowsCreated
	ButtonAsCreate:SetScript("OnMouseDown", function(self, button) OnclickStoreLoc(self.Index) end)
	SetTooltip(ButtonAsCreate,"Create a portal. Player later can use this portal to teleport here")
		
	-- create a button record location
	local ButtonAsLoad = CreateFrame("Button", "TeleLoad"..TeleRowsCreated, TeleportLocationsFrame, "UIPanelButtonTemplate2")
	ButtonAsLoad:SetPoint("TOPLeft", 150 + 5 + 150 + 5, -25 - TeleRowsCreated * 20)
	ButtonAsLoad:SetText("Teleport to")
	ButtonAsLoad:SetSize(150, 20)
	ButtonAsLoad.Index = TeleRowsCreated
	ButtonAsLoad:SetScript("OnMouseDown", function(self, button) OnclickRecallLoc(self.Index) end)
	SetTooltip(ButtonAsLoad,"Teleport to an previously created portal. Can only be used out of combat!")
	
	TeleportLocationEditBoxes[TeleRowsCreated] = Editbox
	TeleRowsCreated = TeleRowsCreated + 1
end

AddNewStatRow("Unknown","Teleports the player to this location",0)
AddNewStatRow("Unknown","Teleports the player to this location",0)
AddNewStatRow("Unknown","Teleports the player to this location",0)
AddNewStatRow("Unknown","Teleports the player to this location",0)

function OnclickStoreLoc(Index)
	--print("Store current location as portal location "..Index)
	AddonCommSendPacketToServer("TLLS",Index.." "..TeleportLocationEditBoxes[Index]:GetText())
end

function OnclickRecallLoc(Index)
	--print("teleport to portal location "..Index)
	AddonCommSendPacketToServer("TLLR",""..Index)
end

function QueryStatusOfParagonFrame()
	-- send query to the server
	SendGreeting()
	AddonCommSendPacketToServer("PTLS","")
end

function UpdateTeleLocFrameContent()
	for i = 0,TeleRowsCreated,1 do
		if(TeleportLocationEditBoxes[i] ~= nil and TeleportLocationNames[TeleportLocationEditBoxes[i].Index] ~= nil) then		
			TeleportLocationEditBoxes[i]:SetText( TeleportLocationNames[TeleportLocationEditBoxes[i].Index] )
		end
	end
end

function OnServerTeleportLocationStatusUpdate(message)
--print("received message "..message)
	local N0, M0, X0, Y0, Z0, N1, M1, X1, Y1, Z1, N2, M2, X2, Y2, Z2, N3, M3, X3, Y3, Z3 = strsplit(" ", message)
	TeleportLocationNames[0] = N0
	TeleportLocationNames[1] = N1
	TeleportLocationNames[2] = N2
	TeleportLocationNames[3] = N3
	UpdateTeleLocFrameContent()	
end

-- our DB might be outdated
RegisterOpcodeHandler("PTLN",OnServerTeleportLocationStatusUpdate)
TeleportLocationsFrame:SetScript("OnShow", QueryStatusOfParagonFrame);
TeleportLocationsFrame:Hide()

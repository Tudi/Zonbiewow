local MainFrameWidth = 64 * 6
local MainFrameHeight = 50

-- create main window frame
local MainWindowFrame = CreateFrame("Frame", "DragFrame2", UIParent)
MainWindowFrame:SetMovable(true)
MainWindowFrame:EnableMouse(true)
MainWindowFrame:RegisterForDrag("LeftButton")
MainWindowFrame:SetScript("OnDragStart", MainWindowFrame.StartMoving)
MainWindowFrame:SetScript("OnDragStop", MainWindowFrame.StopMovingOrSizing)

-- The code below makes the frame visible, and is not necessary to enable dragging.
MainWindowFrame:SetPoint("CENTER")
MainWindowFrame:SetSize(MainFrameWidth, MainFrameHeight)
MainWindowFrame.tex = MainWindowFrame:CreateTexture("ARTWORK")
MainWindowFrame.tex:SetAllPoints()
MainWindowFrame.tex:SetTexture(0.5, 0.5, 0.5, 0.5)

-- create a label and describe our addon
MainWindowFrame.ButtonAsLabel = CreateFrame("Button", "TestButton", MainWindowFrame, "UIPanelButtonTemplate2")
MainWindowFrame.ButtonAsLabel:SetPoint("CENTER", 0, 10)
MainWindowFrame.ButtonAsLabel:SetText("At what difficulty should the next instance be created ?")
MainWindowFrame.ButtonAsLabel:SetSize(1,1)

-- create the slide bar
MainWindowFrame.slider = CreateFrame("Slider", "TestSlider", MainWindowFrame, "OptionsSliderTemplate")
MainWindowFrame.slider:SetPoint("CENTER", 0, -5)
MainWindowFrame.slider:SetWidth(MainWindowFrame:GetWidth() - 20)
MainWindowFrame.slider:SetMinMaxValues(-90, 1000)
MainWindowFrame.slider:SetValueStep(1)
MainWindowFrame.slider:SetScript("OnValueChanged", function(self, value)
--      button:SetPoint("CENTER", value, 0)
		if value ~= 0 then
--			print('Next created instance difficulty will be set to '..value..'%')
		end
		if value >= 0 then
			MainWindowFrame.tex:SetTexture( value / 1000 , 0, 0, 0.5)
		else 
			MainWindowFrame.tex:SetTexture(0, -value / 90, 0, 0.5)
		end
end)
MainWindowFrame.slider:SetValue(0)

-- create a button in top right corner to minimize the addon
MainWindowFrame.IsShown = 1
local ButtonToMinimize = CreateFrame("Button", "TestButton", MainWindowFrame, "UIPanelButtonTemplate2")
ButtonToMinimize:SetText("_")
ButtonToMinimize:SetSize(20,20)
ButtonToMinimize:SetScript("OnClick", function(self, button, down)
if(MainWindowFrame.IsShown == 0) then
	MainWindowFrame:SetSize(MainFrameWidth, MainFrameHeight)
	ButtonToMinimize:SetPoint("CENTER", MainWindowFrame:GetWidth() / 2 - ButtonToMinimize:GetWidth()/2, MainWindowFrame:GetHeight() / 2 - ButtonToMinimize:GetHeight()/2 )
--	MainWindowFrame:Show()
	MainWindowFrame.slider:Show()
	MainWindowFrame.ButtonAsLabel:Show()
	MainWindowFrame.IsShown = 1
else
--	MainWindowFrame:Hide()
	MainWindowFrame.slider:Hide()
	MainWindowFrame.ButtonAsLabel:Hide()
	MainWindowFrame:SetSize(20,20)
	ButtonToMinimize:SetPoint("CENTER", 0, 0 )
	MainWindowFrame.IsShown = 0;
end
end)
ButtonToMinimize:SetPoint("CENTER", MainWindowFrame:GetWidth() / 2 - ButtonToMinimize:GetWidth()/2, MainWindowFrame:GetHeight() / 2 - ButtonToMinimize:GetHeight()/2 )

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
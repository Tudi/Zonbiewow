-- count the number of stats we should show
local StatRowsToShow = 0
for _ in pairs(RANDOM_ITEM_IRS) do StatRowsToShow = StatRowsToShow + 1 end

local StatColumnCount = 7 -- can change this to make the UI look more "square"
local StatRowCountPerColumn = math.ceil(StatRowsToShow / StatColumnCount)
local OneRowHeight = 10 -- kinda hardcoded
local HeaderRowHeight = 22 -- kinda hardcoded
local MainFrameHeight = HeaderRowHeight + StatRowCountPerColumn * OneRowHeight
local OneStatCheckBoxWidth = 20 * 6 + 7 -- 10 chars from description + 1 for the checkbox
local MainFrameWidth = StatColumnCount * OneStatCheckBoxWidth 

-- create main window frame
HideStatsFrame = CreateFrame("Frame", "HideStatsFrame", nil)
HideStatsFrame:SetMovable(true)
HideStatsFrame:EnableMouse(true)
HideStatsFrame:RegisterForDrag("LeftButton")
HideStatsFrame:SetScript("OnDragStart", HideStatsFrame.StartMoving)
HideStatsFrame:SetScript("OnDragStop", HideStatsFrame.StopMovingOrSizing)

-- The code below makes the frame visible, and is not necessary to enable dragging.
HideStatsFrame:SetSize(MainFrameWidth, MainFrameHeight)
HideStatsFrame.tex = HideStatsFrame:CreateTexture("ARTWORK")
HideStatsFrame.tex:SetAllPoints()
HideStatsFrame.tex:SetTexture(0.5, 0.5, 0.5, 0.5)
local ResolutionWidth = GetScreenWidth() * UIParent:GetEffectiveScale()
local ResolutionHeight = GetScreenHeight() * UIParent:GetEffectiveScale()
HideStatsFrame:SetPoint("Center", 0, 0);

HideStatsFrame.ButtonAsLabel = CreateFrame("Button", "DescriptiveLabel", HideStatsFrame, "UIPanelButtonTemplate2")
HideStatsFrame.ButtonAsLabel:SetPoint("TOPLeft", HideStatsFrame:GetWidth() / 2, -10)
HideStatsFrame.ButtonAsLabel:SetText("Hide these stats when showing item tooltips")
HideStatsFrame.ButtonAsLabel:SetSize(1,1)

function ToggleShowStat(StatIndex)
	if( HideItemStat[StatIndex] == nil or HideItemStat[StatIndex] == 0 ) then 
		HideItemStat[StatIndex] = 1
	else
		HideItemStat[StatIndex] = 0
	end
end

local CheckBoxWidth = 10
local CheckBoxHeight = 10
function CreateCheckbutton(parent, x_loc, y_loc, StatIndex)
	local checkbutton = CreateFrame("CheckButton", "ToggleStatShow_" .. StatIndex, parent, "ChatConfigCheckButtonTemplate");
	checkbutton:SetPoint("TOPLEFT", x_loc, y_loc);
	local FullName = RANDOM_ITEM_IRS[StatIndex]
	FullName = string.gsub(FullName,"%%d ",'')
	FullName = string.gsub(FullName,"%%d%%%% ",'')
	FullName = string.gsub(FullName,"%%f ",'')
	FullName = string.gsub(FullName,"%%.02f ",'')
	FullName = string.gsub(FullName,"%%.02f%%%% ",'')
	local Name = string.sub(FullName,1,20)
	getglobal(checkbutton:GetName() .. 'Text'):SetText(Name)
	getglobal(checkbutton:GetName() .. 'Text'):SetFontObject("GameFontNormalSmall")
	checkbutton:SetScript("OnClick", function() ToggleShowStat(StatIndex); end)
	checkbutton:SetSize(CheckBoxWidth,CheckBoxHeight)
	checkbutton.tooltip = IRT[StatIndex]
	--checkbutton:SetScale(0.7)
	if( HideItemStat ~= nil and HideItemStat[StatIndex] == 1 ) then
		checkbutton:SetChecked(true)
	end
	return checkbutton;
end

local CheckBoxesInitialized = 0
function PopulateCheckboxes()
	CheckBoxesInitialized = 1
	for j=0,StatColumnCount do
		for i=1,StatRowCountPerColumn-1 do
			local StatIndex = j*StatRowCountPerColumn + i
			if(RANDOM_ITEM_IRS[StatIndex] == nil) then
				break;
			end
			CreateCheckbutton(HideStatsFrame,(j*OneStatCheckBoxWidth),-20-(i * CheckBoxHeight),StatIndex)
		end
	end
end

HideStatsFrame:RegisterEvent("ADDON_LOADED");
function HideStatsFrame:OnEvent(event, arg1)
	if event == "ADDON_LOADED" and CheckBoxesInitialized == 0 then
		if HideItemStat == nil then
			HideItemStat = {};
		end
		PopulateCheckboxes()
	end
end
HideStatsFrame:SetScript("OnEvent", HideStatsFrame.OnEvent);

HideStatsFrame:Hide()
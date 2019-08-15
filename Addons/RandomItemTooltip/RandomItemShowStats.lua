RANDOM_ITEM_STAT_SUMMARY_VALUES  = {}
RANDOM_ITEM_STAT_SUMMARY_COUNTS  = {}

-- create main window frame
ShowStatValues = CreateFrame("Frame", "ShowStatValues", nil)
ShowStatValues:SetMovable(true)
ShowStatValues:EnableMouse(true)
ShowStatValues:RegisterForDrag("LeftButton")
ShowStatValues:SetScript("OnDragStart", ShowStatValues.StartMoving)
ShowStatValues:SetScript("OnDragStop", ShowStatValues.StopMovingOrSizing)

-- The code below makes the frame visible, and is not necessary to enable dragging.
ShowStatValues:SetSize(250, 250)
ShowStatValues.tex = ShowStatValues:CreateTexture("ARTWORK")
ShowStatValues.tex:SetAllPoints()
ShowStatValues.tex:SetTexture(0.5, 0.5, 0.5, 0.5)
local ResolutionWidth = GetScreenWidth() * UIParent:GetEffectiveScale()
local ResolutionHeight = GetScreenHeight() * UIParent:GetEffectiveScale()
ShowStatValues:SetPoint("Center", 0, 0);

ShowStatValues.ButtonAsLabel = CreateFrame("Button", "DescriptiveLabel", ShowStatValues, "UIPanelButtonTemplate2")
ShowStatValues.ButtonAsLabel:SetPoint("TOPLeft", ShowStatValues:GetWidth() / 2, -10)
ShowStatValues.ButtonAsLabel:SetText("Sumary of random stats")
ShowStatValues.ButtonAsLabel:SetSize(1,1)

ShowStatValues.text = ShowStatValues.text or ShowStatValues:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
ShowStatValues.text:SetAllPoints(true)
ShowStatValues.text:SetJustifyH("LEFT")
ShowStatValues.text:SetJustifyV("TOP")
ShowStatValues.text:SetTextColor(0,1,1,1)

function QueryStatusOfPaperDollFrame()
	-- clear old list
	RANDOM_ITEM_STAT_SUMMARY_VALUES = nil
	RANDOM_ITEM_STAT_SUMMARY_COUNTS = nil
	RANDOM_ITEM_STAT_SUMMARY_VALUES = {}
	RANDOM_ITEM_STAT_SUMMARY_COUNTS = {}
	-- send query to the server
	SendGreeting()
	AddonCommSendPacketToServer("RIQA","")
end

function UpdatePaperDollFrameContent()

	PaperDollFrameStatSumary()-------------------------------------------------------------------------------------
		
	local StatRowsToShow = 0
	local LongestRow = 0
--	for _ in pairs(RANDOM_ITEM_STAT_SUMMARY_VALUES) do StatRowsToShow = StatRowsToShow + 1 end
	local FullContent = "\n\n\n\n"
	for i,v in pairs(RANDOM_ITEM_STAT_SUMMARY_VALUES) do
		local StatFormated = format(RANDOM_ITEM_IRS[i],v)
		for i=0,RANDOM_ITEM_STAT_SUMMARY_COUNTS[i]-1 do
			FullContent = FullContent.."   "..StatFormated.."\n"
		end
		--FullContent = FullContent..StatRowsToShow.." "..StatFormated.."\n"
		if( string.len( StatFormated ) > LongestRow ) then LongestRow = string.len( StatFormated ) end
		StatRowsToShow = StatRowsToShow + 1 
	end
--	format(This quest \"%d\" is \nlevel %d and has \na questid of %d",StatRowsToShow,StatRowsToShow,StatRowsToShow)
	ShowStatValues.text:SetText(FullContent)
	ShowStatValues:SetSize(LongestRow * 7 + 14, StatRowsToShow * 13 + 50)
	--print("Size is "..StatRowsToShow)
end

ShowStatValues:SetScript("OnShow", QueryStatusOfPaperDollFrame);
ShowStatValues:Hide()




----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
StatSumaryfontstring = PaperDollFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
StatSumaryfontstring:SetPoint("TOP",-10,-77)
StatSumaryfontstring:Hide()

local StatSumaryPagePage = 0
StatSumaryPagestring = PaperDollFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
StatSumaryPagestring:SetPoint("BOTTOM",-10,140)
StatSumaryPagestring:SetText(StatSumaryPagePage)
StatSumaryPagestring:Hide()


local StatSumaryButton = CreateFrame("Button", nil, PaperDollFrame, "UIPanelButtonTemplate")
StatSumaryButton:SetText("Stat_Sumary")
StatSumaryButton:SetSize(65,20)
StatSumaryButton:SetPoint("TOPRIGHT", -35, -52)
StatSumaryButton:SetScript("OnClick", function(self, button, down)
QueryStatusOfPaperDollFrame()
      if(StatSumaryfontstring:IsVisible()) then
         StatSumaryfontstring:Hide()
         CharacterModelFrame:Show()
		 CharacterResistanceFrame:Show()
		 CharacterAttributesFrame:Show()
		 PrevStatSumaryButton:Hide()
		 NextStatSumaryButton:Hide()
		 StatSumaryPagestring:Hide()
		 StatSumaryPagePage = 0
      else 
		 CharacterModelFrame:Hide()
		 CharacterAttributesFrame:Hide()
         CharacterResistanceFrame:Hide()
		 StatSumaryPagestring:Show()
		 StatSumaryfontstring:Show()
		 PrevStatSumaryButton:Show()
		 NextStatSumaryButton:Show()
      end
end)

local PrevStatSumaryButton = CreateFrame("Button", "PrevStatSumaryButton", PaperDollFrame, "UIPanelButtonTemplate2")
PrevStatSumaryButton:SetText("<")
PrevStatSumaryButton:SetSize(20,20)
PrevStatSumaryButton:SetPoint("BOTTOM", -30, 135)
PrevStatSumaryButton:SetScript("OnClick", function(self, button, down) PrevStatSumaryPage()end)
PrevStatSumaryButton:Hide()

local NextStatSumaryButton = CreateFrame("Button", "NextStatSumaryButton", PaperDollFrame, "UIPanelButtonTemplate2")
NextStatSumaryButton:SetText(">")
NextStatSumaryButton:SetSize(20,20)
NextStatSumaryButton:SetPoint("BOTTOM", 10, 135)
NextStatSumaryButton:SetScript("OnClick", function(self, button, down) NextStatSumaryPage() end)
 NextStatSumaryButton:Hide()

function PrevStatSumaryPage()
	StatSumaryPagePage = StatSumaryPagePage-1
	if StatSumaryPagePage < 0 then StatSumaryPagePage = 0 end
	--print(StatSumaryPagePage)
	StatSumaryfontstring:SetText(_G["RI_StatSumarypage"..StatSumaryPagePage])
	StatSumaryPagestring:SetText(StatSumaryPagePage)

end

function NextStatSumaryPage()
	StatSumaryPagePage = StatSumaryPagePage+1
	if StatSumaryPagePage > 3 then StatSumaryPagePage = 3 end
	--print(StatSumaryPagePage)
	StatSumaryfontstring:SetText(_G["RI_StatSumarypage"..StatSumaryPagePage])
	StatSumaryPagestring:SetText(StatSumaryPagePage)

end

local RowCountToPage
function PaperDollFrameStatSumary()
	RowCountToPage = 0 
	local StatRowsToShow = 0

	local FullContent = ""
	local FullContent2 = ""
	local FullContent3 = ""

	for i,v in pairs(RANDOM_ITEM_STAT_SUMMARY_VALUES) do
		local StatFormated = format(RANDOM_ITEM_IRS[i],v)
		for i=0,RANDOM_ITEM_STAT_SUMMARY_COUNTS[i]-1 do
			RowCountToPage = StatRowsToShow/25
			if     RowCountToPage < 1 then
			FullContent = FullContent.."   "..StatFormated.."\n"
			elseif RowCountToPage < 2 then
			FullContent2 = FullContent2.."   "..StatFormated.."\n"
			elseif RowCountToPage < 3 then
			FullContent3 = FullContent3.."   "..StatFormated.."\n"
			end
		end
		StatRowsToShow = StatRowsToShow + 1 
	end
	StatSumaryfontstring:SetText(FullContent)
	RI_StatSumarypage0 = FullContent
	RI_StatSumarypage1 = FullContent2
	RI_StatSumarypage2 = FullContent3
end
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
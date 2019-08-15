
function Explode(message)
	local ListOfStructValues={} ;	ValueCount=0
	for str in string.gmatch(message, "([^%s]+)") do

			ListOfStructValues[ValueCount] = str			
			ValueCount = ValueCount + 1
	
	end	
	return ValueCount, ListOfStructValues
end

function OnEnterTippedFrame(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, true)
	GameTooltip:Show()
end

function OnLeaveTippedFrame()
	GameTooltip_Hide()
end

-- if text is provided, sets up the button to show a tooltip when moused over. Otherwise, removes the tooltip.
function SetTooltip(self, text)
	if text then
		self.tooltipText = text
		self:SetScript("OnEnter", OnEnterTippedFrame)
		self:SetScript("OnLeave", OnLeaveTippedFrame)
	else
		self:SetScript("OnEnter", nil)
		self:SetScript("OnLeave", nil)
	end
end
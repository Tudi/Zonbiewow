local Version = "2"
local LastBagId = -1
local LastBagSlot = -1
local LastInventorySlot = -1
local LastInventorySlotInspect = -1
local LastTradeRecipient = -1 --TTrade
local LastTradePlayer = -1
local TransactionID = 4


local IRS = RANDOM_ITEM_IRS     -- item random stat format string DB
local IRSC = RANDOM_ITEM_IRSC   -- item random stat color
local IRNRL = RANDOM_ITEM_IRNRL -- max value a stat can roll at 100% diff
IRS[1000]="%d Dust on sale"

local InventoryToolTips = {}
local TooltipCache = {}

--local TradePlayerItem = {}
--local TradeRecipientItem = {}

-- get the item id from the currently shown tooltip
local prevItemId = 0
local prevItem
function GetItemIDFromToolTip()
	if prevItem ~= GameTooltip:GetItem() then
		itemName, itemLink = GameTooltip:GetItem()
		local s1, itemID = strsplit(":", string.match(itemLink, "item[%-?%d:]+"))
		prevItemId = tonumber(itemID)
	end
	return prevItemId;
end

function ResetKnownTooltipSlots()
	LastInventorySlot = -1
	LastBagId = -1
	LastBagSlot = -1
	LastInventorySlotInspect = -1
	LastTradeRecipient = -1	--TTrade
	LastTradePlayer = -1
end


-- function gets triggered when we hover over a bag item
function DisplayItemToolTipContainers(self)
	ResetKnownTooltipSlots()
	local BagItemId = GetItemIDFromToolTip()
	if( BagItemId <= 0 ) then
		--print("Bag slot is empty on "..LastBagId.." "..LastBagSlot)
		return
	end
	LastBagId = self:GetParent():GetID()
	LastBagSlot = self:GetID()
	--print("Bag : set query data to "..LastBagId.." "..LastBagSlot.." "..BagItemId)
end

function DisplayStuffings(bag,slot)
	LastBagId = bag
	LastBagSlot = slot
end

-- function gets triggered when we hover over an inventory item
function DisplayItemToolTipInventory(slot)
	ResetKnownTooltipSlots()
	local InventoryItem = GetItemIDFromToolTip()
	if( InventoryItem <= 0 ) then
		--print("Inventory slot is empty on "..slot)
		return
	end	
	LastInventorySlot = slot
	--print("Inventory : set query data to "..LastInventorySlot.." "..InventoryItem)
end

function DisplayItemToolTipInspect(slot)
	-- nothing changed, no need to panic
	ResetKnownTooltipSlots()
	local InventoryItem = GetItemIDFromToolTip()
	if( InventoryItem <= 0 ) then
		--print("Inventory slot is empty on "..slot)
		return
	end	
	LastInventorySlotInspect = slot
	--print("Inspect : set query data to "..LastInventorySlotInspect.." "..InventoryItem)
end

function DisplayTradeRecipientItemTooltip(slot) -- TTrade
	ResetKnownTooltipSlots()
	local InventoryItem = GetItemIDFromToolTip()
	if( InventoryItem <= 0 ) then return end
	LastTradeRecipient = slot
end

function DisplayTradePlayerItemTooltip(slot) --TTrade
	ResetKnownTooltipSlots()
	local InventoryItem = GetItemIDFromToolTip()
	if( InventoryItem <= 0 ) then return end	
	--LastTradePlayer = slot
end

function SetPlayerTradeSlot(self,button) --TTrade
 local BagId = self:GetParent():GetID()
 local BagSlot = self:GetID()
	print("BagSlot: "..BagSlot.." BagSlot: "..BagSlot.." button: "..button)
end

-- function triggered when the tooltip gets shown
local WaitTransactionFinish = 0
local TransactionIDDetails = {}

function GetCacheIndex(InventorySlot,BagId,BagSlot,InventorySlotInspect,LastTradeRecipient,LastTradePlayer)
--print(InventorySlot,BagId,BagSlot,InventorySlotInspect,LastTradeRecipient)
	if( InventorySlot >= 0 ) then
		return InventorySlot
	end
	if( InventorySlotInspect >= 0 ) then -- inspected items should not be cached. Source can change, item can be the same, can't guess if cache is good or not
		return 50 + InventorySlotInspect
	end	
	if( BagId >= 0 and BagSlot >= 0 ) then
		return 50 + 50 + BagId * 50  + BagSlot
	end
		if( LastTradeRecipient > -1) then
		return 10100 + LastTradeRecipient
	end
	if( LastTradePlayer > -1) then
		return 10200 + LastTradePlayer
	end
	return 10000
end

function HasTooltipDataCached()
	VerifyTooltipOrigin()

	if( LastInventorySlot == -1 and LastBagId == -1 and LastBagSlot == -1 and LastInventorySlotInspect == -1 and LastTradeRecipient == -1 and LastTradePlayer == -1) then
		--print("Unknown tooltip slot")
		return 2
	end
	
	local CacheIndex = GetCacheIndex(LastInventorySlot,LastBagId,LastBagSlot,LastInventorySlotInspect,LastTradeRecipient,LastTradePlayer)
	
	if( TooltipCache[CacheIndex] == nil ) then 
	--	print("Cache is not ready for item at index "..CacheIndex)
		return 0 
	end
	
	local ItemId = GetItemIDFromToolTip()
	if( TooltipCache[CacheIndex]['ItemId'] ~= ItemId ) then 
		--print("Cache itemid is "..TooltipCache[CacheIndex]['ItemId'].." but tooltip has "..ItemId.." at index "..CacheIndex)
		return 0 
	end
	
	--print("Cache for index "..CacheIndex.." has item id "..ItemId);
	return 1,TooltipCache[CacheIndex]['linecount'],TooltipCache[CacheIndex]['lines'],TooltipCache[CacheIndex]['lineColors'],TooltipCache[CacheIndex]['StatTypes']
	--local HasCache, TooltipLineCount, ParsedQuery, ParsedQueryColors = HasTooltipDataCached()
end

function QuryAndShowExtraTooltip(tooltip)
	local TimeNow = GetTime()
	if(WaitTransactionFinish > TimeNow ) then
		--print("Still waiting on the previous query reply "..WaitTransactionFinish..">"..TimeNow)
		return
	end

	local TooltipCacheType = HasTooltipDataCached()
	if( TooltipCacheType == 2 ) then
		--print("Unknown location of tooltip. Can't show extra info")
		return
	end
	if( TooltipCacheType == 1 ) then
		ShowExtraTooltip(tooltip)
		return
	end

	WaitTransactionFinish = TimeNow + 1000 / 1000 -- start a new transaction
	-- prepare a new transaction
	TransactionID = TransactionID + 1
	local LTR = LastTradeRecipient-1
	local QueryString = TransactionID.." "..LastInventorySlot.." "..LastBagId.." "..LastBagSlot.." "..LastInventorySlotInspect.." "..LTR
	local ItemId = GetItemIDFromToolTip()
	--print("Sending to server : item id is "..ItemId..". Addon msg : "..QueryString)
	
	TransactionIDDetails[TransactionID] = {}
	TransactionIDDetails[TransactionID]['Inv'] = LastInventorySlot
	TransactionIDDetails[TransactionID]['BagId'] = LastBagId
	TransactionIDDetails[TransactionID]['BagSlot'] = LastBagSlot
	TransactionIDDetails[TransactionID]['InvInspect'] = LastInventorySlotInspect
	TransactionIDDetails[TransactionID]['TradeRecipient'] = LastTradeRecipient
	TransactionIDDetails[TransactionID]['TradePlayer'] = LastTradePlayer
	TransactionIDDetails[TransactionID]['ItemId'] = ItemId
	
	AddonCommSendPacketToServer("RI  ", QueryString)
end

function CacheAtIndex(CacheIndex,ItemId,TooltipLineCount,ParsedQuery,ParsedQueryColors,message, ParsedQueryStatTypes)
	--print("Store in cache index "..CacheIndex.." item id "..ItemId)
	TooltipCache[CacheIndex] = {}
	TooltipCache[CacheIndex]['ItemId'] = ItemId
	TooltipCache[CacheIndex]['linecount'] = TooltipLineCount
	TooltipCache[CacheIndex]['lines'] = ParsedQuery
	TooltipCache[CacheIndex]['lineColors'] = ParsedQueryColors
	TooltipCache[CacheIndex]['message'] = message
	TooltipCache[CacheIndex]['StatTypes'] = ParsedQueryStatTypes
end

function CacheTransactionResult(ReceivedTransactionId, TooltipLineCount, ParsedQuery, ParsedQueryColors, message, ParsedQueryStatTypes)
	--print("Trying to cache transaction id "..ReceivedTransactionId.." results")
	if(TransactionIDDetails[ReceivedTransactionId] == nil ) then 
		--print("Received transaction id "..ReceivedTransactionId.." has no cached details")
		return 
	end
	--print("query slots "..TransactionIDDetails[ReceivedTransactionId]['Inv'].." "..TransactionIDDetails[ReceivedTransactionId]['BagId'].." "..TransactionIDDetails[ReceivedTransactionId]['BagSlot'].." "..TransactionIDDetails[ReceivedTransactionId]['InvInspect'])
	local CacheIndex = GetCacheIndex(TransactionIDDetails[ReceivedTransactionId]['Inv'],TransactionIDDetails[ReceivedTransactionId]['BagId'],TransactionIDDetails[ReceivedTransactionId]['BagSlot'],TransactionIDDetails[ReceivedTransactionId]['InvInspect'],TransactionIDDetails[ReceivedTransactionId]['TradeRecipient'],TransactionIDDetails[ReceivedTransactionId]['TradePlayer']  )	
	CacheAtIndex(CacheIndex,TransactionIDDetails[ReceivedTransactionId]['ItemId'],TooltipLineCount,ParsedQuery,ParsedQueryColors,message, ParsedQueryStatTypes)
end

-- how many arguments should we read to be able to parse this format string ?
function CountArguments(query)
	if(query == nil) then
		return 0
	end
	local count = 0
	for i in string.gmatch(query, "%%d") do
	   count = count + 1
	end
	for i in string.gmatch(query, "%%f") do
	   count = count + 1
	end
	for i in string.gmatch(query, "%%.02f") do
	   count = count + 1
	end
	for i in string.gmatch(query, "%%s") do
	   count = count + 1
	end
	return count
end

-- for some reason the version did not get reported to the server. Try again
function OpcodeHandlerResendGreeting(message)
	--print("Server has requested greeting message from client")
	GreetingSent = 0
	SendGreeting()
end

-- this is when we query the status of the paperdoll frame
function OnServerQuerySingleStatValue(message)
	--print("Server sent us message : "..message)
	message = ".#RI "..message
	Tag, StatType, StatValue, StatRepeat = strsplit(" ", message)
	StatType = tonumber(StatType)
	StatValue = tonumber(StatValue)
	StatRepeat = tonumber(StatRepeat)
	RANDOM_ITEM_STAT_SUMMARY_VALUES[StatType] = StatValue
	RANDOM_ITEM_STAT_SUMMARY_COUNTS[StatType] = StatRepeat
	if(UpdatePaperDollFrameContent ~= nil ) then UpdatePaperDollFrameContent() end		
	--print("Got stat type "..StatType.." name "..IRS[StatType].." = "..StatValue.." Repeat "..StatRepeat)
end

function ParseStatList(ListOfStructValues,ValueCount, ParseStartIndex)
	local ParsedQuery = {}
	local ParsedQueryColors = {}
	local ParsedQueryStatType = {}
	local TooltipLineCount = 0;
	local ReadIndex = ParseStartIndex
	local AttackRollsLuck = 0
	local DefenseRollsLuck = 0
	--print("Shpuld parse values starting from "..ParseStartIndex.." until "..(ValueCount-1))
	for i2 = ParseStartIndex, ValueCount-1 do
		local LuckyRoll = 0
		local StatTypeIndex = tonumber(ListOfStructValues[ReadIndex]);
		local FormatedString;
		if(StatTypeIndex >= 0) then
			FormatedString = IRS[StatTypeIndex];
		else
			FormatedString = ""
		end		
		--print("Process string index "..StatTypeIndex.." as string "..FormatedString)
		if( FormatedString ~= nil ) then
			local ArgumentCountUsed = CountArguments(FormatedString)
			--if HideStat[StatTypeIndex] then print(FormatedString.." hidden");FormatedString = "";end
			local TooltipString
			--print(ArgumentCountUsed.." arguments for "..FormatedString)
			if(ArgumentCountUsed == 0) then
				--print("Index "..ReadIndex.." valuecount "..ValueCount.." "..ListOfStructValues[ReadIndex])
				TooltipString = FormatedString
				----print( (ReadIndex.." "..StatTypeIndex..FormatedString)
			end
			if(ArgumentCountUsed == 1) then
				--print("Index "..ReadIndex.." valuecount "..ValueCount.." "..ListOfStructValues[ReadIndex])			
				local FormatedStringParam = ListOfStructValues[ReadIndex+1]
				TooltipString = string.format(FormatedString,FormatedStringParam)
				if( IRNRL ~= nill and IRNRL[StatTypeIndex] ~= nil ) then LuckyRoll = tonumber(FormatedStringParam) / IRNRL[StatTypeIndex] end
				----print( (ReadIndex.." "..StatTypeIndex..FormatedString.."="..FormatedStringParam.." as tooltip "..TooltipString)
				
			end
			if(ArgumentCountUsed == 2) then
			  
				local FormatedStringParam1 = ListOfStructValues[ReadIndex+1]
				local FormatedStringParam2 = ListOfStructValues[ReadIndex+2]
				TooltipString = string.format(FormatedString,FormatedStringParam1,FormatedStringParam2)
			  
			end
			----print( (ReadIndex.." "..StatTypeIndex..FormatedString.."="..TooltipString)
			ParsedQuery[TooltipLineCount] = TooltipString
			ParsedQueryStatType[TooltipLineCount] = StatTypeIndex
			ParsedQueryColors[TooltipLineCount] = {}
			if(StatTypeIndex < 0 or IRSC[StatTypeIndex] == nil ) then
				ParsedQueryColors[TooltipLineCount][0] = 0.5 -- R
				ParsedQueryColors[TooltipLineCount][1] = 0.5 -- G
				ParsedQueryColors[TooltipLineCount][2] = 1	-- B
			else
				ParsedQueryColors[TooltipLineCount][0] = IRSC[StatTypeIndex][0]
				ParsedQueryColors[TooltipLineCount][1] = IRSC[StatTypeIndex][1]
				ParsedQueryColors[TooltipLineCount][2] = IRSC[StatTypeIndex][2]
				--is this a defense roll ?
				if( IRSC[StatTypeIndex][0] == IRSC[13][0] and IRSC[StatTypeIndex][1] == IRSC[13][1] and IRSC[StatTypeIndex][2] == IRSC[13][2] ) then 
					DefenseRollsLuck = DefenseRollsLuck + LuckyRoll
				elseif( IRSC[StatTypeIndex][0] == IRSC[20][0] and IRSC[StatTypeIndex][1] == IRSC[20][1] and IRSC[StatTypeIndex][2] == IRSC[20][2] ) then 
					AttackRollsLuck = AttackRollsLuck + LuckyRoll
				elseif( IRSC[StatTypeIndex][0] == IRSC[43][0] and IRSC[StatTypeIndex][1] == IRSC[43][1] and IRSC[StatTypeIndex][2] == IRSC[43][2] ) then 
					DefenseRollsLuck = DefenseRollsLuck + LuckyRoll
					AttackRollsLuck = AttackRollsLuck + LuckyRoll
				end
			end			
			TooltipLineCount = TooltipLineCount + 1
			ReadIndex = ReadIndex + 1 + ArgumentCountUsed
			if( ReadIndex >= ValueCount ) then
				--print("Finished parsing tooltip query. Have "..TooltipLineCount.." lines")
				break
			end
		else
			ReadIndex = ReadIndex + 1 -- this is a wild guess that only 1 argument would have been used
			--print("Could not find format string for index "..StatTypeIndex)
		end
	end
	
	if( TooltipLineCount > 0 and ( AttackRollsLuck > 0 or DefenseRollsLuck > 0 )) then 
		-- pretify
		AttackRollsLuck = tonumber(string.format("%.1f", AttackRollsLuck))
		DefenseRollsLuck = tonumber(string.format("%.1f", DefenseRollsLuck))
		ParsedQuery[TooltipLineCount] = ParsedQuery[TooltipLineCount-1]
		ParsedQuery[TooltipLineCount-1] = "Rolled Luck "..AttackRollsLuck.."Off/"..DefenseRollsLuck.."Def"
		ParsedQueryColors[TooltipLineCount-1] = {}
		ParsedQueryColors[TooltipLineCount] = ParsedQueryColors[TooltipLineCount-1]
		ParsedQueryColors[TooltipLineCount-1][0] = 1
		ParsedQueryColors[TooltipLineCount-1][1] = 1
		ParsedQueryColors[TooltipLineCount-1][2] = 1
		TooltipLineCount = TooltipLineCount + 1
	end
	
	return TooltipLineCount, ParsedQuery, ParsedQueryColors, ParsedQueryStatType
end

-- server message seems to be something we could parse as a query reply
function OnServerQueryReply(message)
	--print("Server sent : "..message)
	message = ".#RI "..message
	local ValueCount, ListOfStructValues = Explode(message)
	if( ValueCount <= 1 ) then
		WaitTransactionFinish = 0
		--print("Invalid query reply")
		return
	end
	--print("received "..ValueCount.." values ".." in msg "..message);
	local TooltipLineCount, ParsedQuery, ParsedQueryColors, ParsedQueryStatTypes = ParseStatList( ListOfStructValues, ValueCount, 2 )
	local message = string.sub(message,6) 
	local ReceivedTransactionId = tonumber(ListOfStructValues[1])
	CacheTransactionResult(ReceivedTransactionId, TooltipLineCount, ParsedQuery, ParsedQueryColors, message, ParsedQueryStatTypes)
	ResetKnownTooltipSlots()
	WaitTransactionFinish = 0
end

-- server message seems to be something we could parse as a query reply
function OnServerQueryPush(message)
	--print("OnServerQueryPush: Server sent : "..message)
	message = ".#RI "..message
	local ValueCount, ListOfStructValues = Explode(message)
	if( ValueCount <= 1 ) then
		WaitTransactionFinish = 0
		--print("Invalid query reply")
		return
	end
	local TooltipLineCount, ParsedQuery, ParsedQueryColors, ParsedQueryStatTypes = ParseStatList( ListOfStructValues, ValueCount, 6 )
	--print("OnServerQueryPush: received "..ValueCount.." values ".." in msg "..message.." Parsed it to "..TooltipLineCount.." lines")
	local message = string.sub(message,6) 
	local InventorySlot = tonumber(ListOfStructValues[1])
	local BagId = tonumber(ListOfStructValues[2])
	local BagSlot = tonumber(ListOfStructValues[3])
	local InvestigatedSlot = tonumber(ListOfStructValues[4])
	local ItemId = tonumber(ListOfStructValues[5])
	local CacheIndex = GetCacheIndex(InventorySlot,BagId,BagSlot,InvestigatedSlot)	
	CacheAtIndex(CacheIndex, ItemId, TooltipLineCount, ParsedQuery, ParsedQueryColors, message, ParsedQueryStatTypes)
end

-- if we received a query reply for this item, and we parsed it, we can show it
function ShowExtraTooltip(tooltip)
	SetMFDust = "" -- items without any randomizations
	if (not tooltip) then return end
	
	local item, link = tooltip:GetItem();
    local shoppingTooltip1, shoppingTooltip2, shoppingTooltip3 = unpack(tooltip.shoppingTooltips); 
    local _,_,_,_,_,_,_,d,itemEquipLoc = GetItemInfo(link)  
	if InvType[itemEquipLoc] == nil then return end -- skip nonwearable items
	local HasCacheC, TooltipLineCountC, ParsedQueryC, ParsedQueryColorsC,ItemId = GetSlotInspectTooltipDataCached(InvType[itemEquipLoc]) 
	--GetShoppingToolTip(InvType[itemEquipLoc],shoppingTooltip1)
	local HasCacheC2, TooltipLineCountC2, ParsedQueryC2, ParsedQueryColorsC2,ItemId = GetSlotInspectTooltipDataCached(InvType[itemEquipLoc]+1) -- secondcompare
	local HasCache, TooltipLineCount, ParsedQuery, ParsedQueryColors, ParsedQueryStatTypes = HasTooltipDataCached()
	

	if(HasCache == 1)  then
		if( TooltipLineCount >= 1 ) then
			SetMFDust = " |cFF8080ff"..ParsedQuery[TooltipLineCount-1]-- toss in to ShowExtraTooltip 
			--print("Will show additional "..TooltipLineCount.." tooltips")
			for i = 0, TooltipLineCount - 2, 1 do
				-- check if we wanted to filter out this stat type
				if not( HideItemStat ~= nil and ParsedQueryStatTypes[i] ~= nil and HideItemStat[ParsedQueryStatTypes[i]] == 1 ) then
					if(ParsedQueryColors[i][0] ~= nil ) then 
						local message = ParsedQuery[i],ParsedQueryColors[i][0],ParsedQueryColors[i][1],ParsedQueryColors[i][2]
						GameTooltip:AddLine(ParsedQuery[i],ParsedQueryColors[i][0],ParsedQueryColors[i][1],ParsedQueryColors[i][2])	
						--SendAddonMessage("RITT", message, "WHISPER",TradeFrameRecipientNameText:GetText())					
					else
						GameTooltip:AddLine(ParsedQuery[i])
					end
				end
			end
		GameTooltip:Show()
		end
	end
	
	if(HasCacheC == 1)  then --  Do a .RI request for InvType[itemEquipLoc]?
		if( TooltipLineCountC >= 1 ) then 
			for i = 0, TooltipLineCountC - 2, 1 do
				if(ParsedQueryColorsC[i][0] ~= nil ) then 
					shoppingTooltip1:AddLine(ParsedQueryC[i],ParsedQueryColorsC[i][0],ParsedQueryColorsC[i][1],ParsedQueryColorsC[i][2])				
				else
					shoppingTooltip1:AddLine(ParsedQueryC[i])
				end
			end
		end
		shoppingTooltip1:Show()
	end
	
		if(HasCacheC2 == 1)  then 
			if( TooltipLineCountC2 >= 1 ) then 
				for i = 0, TooltipLineCountC2 - 2, 1 do
					if(ParsedQueryColorsC2[i][0] ~= nil ) then 
						shoppingTooltip2:AddLine(ParsedQueryC2[i],ParsedQueryColorsC2[i][0],ParsedQueryColorsC2[i][1],ParsedQueryColorsC2[i][2])				
					else
						shoppingTooltip2:AddLine(ParsedQueryC2[i])
					end
				end
			end
			shoppingTooltip2:Show()
		end
end

function GetSlotInspectTooltipDataCached(SlotInspect)
if SlotInspect == nil then return end
	local CacheIndex = GetCacheIndex(SlotInspect,-1,-1,-1,-1,-1)
	 if( TooltipCache[CacheIndex] == nil ) then return 0 ; end
  return 1,TooltipCache[CacheIndex]['linecount'],TooltipCache[CacheIndex]['lines'],TooltipCache[CacheIndex]['lineColors'],TooltipCache[CacheIndex]['ItemId'],TooltipCache[CacheIndex]['message'],TooltipCache[CacheIndex]['StatTypes'] 
end


-- server message that can be interpreted as a Db update query
function OnServerDBUpdate(message)
	--print("received DB update message "..message)
	--cut out junk from the beggining
	local s,e = string.find(message, " ")
	message = string.sub(message,e+1)
	--print("cut remains "..message)
	s,e = string.find(message, " ")
	local row = string.sub(message,0,s-1)
	row = tonumber(row)
	--print("type "..row)
	
	message = string.sub(message,e+1)
	--print("cut remains "..message)
	s,e = string.find(message, " ")
	local PackedColor = string.sub(message,0,s)
	PackedColor = tonumber(PackedColor)
	local R = (PackedColor % 256) / 256;
	local G = ((PackedColor / 256) % 256) / 256;
	local B = ((PackedColor / 256 / 256 ) % 256) / 256;
	IRSC[row]={}
	IRSC[row][0] = R
	IRSC[row][1] = G
	IRSC[row][2] = B
	--print("Color R"..R.." G "..G.." B "..B)
	
	local data = string.sub(message,e+1)
	IRS[row] = data
	--print("format str '"..data.."'")
end

-- greet the server
local GreetingSent = 0
function SendGreeting()
	if GreetingSent > 1 then
		return
	end
	GreetingSent = GreetingSent + 1
	AddonCommSendPacketToServer("RIV ",Version)
end

function QuryStatTotalAmount(StatType)
	AddonCommSendPacketToServer("RIQS",StatType)
end

function VerifyTooltipOrigin()

	ResetKnownTooltipSlots()
	if(_G["CharacterHeadSlot"] ~= nil and PaperDollFrame:IsVisible() ) then
		if(MouseIsOver(_G["CharacterHeadSlot"])) then	DisplayItemToolTipInventory(0); return end
		if(MouseIsOver(_G["CharacterNeckSlot"])) then	DisplayItemToolTipInventory(1); return end
		if(MouseIsOver(_G["CharacterShoulderSlot"])) then	DisplayItemToolTipInventory(2); return end
		if(MouseIsOver(_G["CharacterBackSlot"])) then	DisplayItemToolTipInventory(14); return end
		if(MouseIsOver(_G["CharacterChestSlot"])) then	DisplayItemToolTipInventory(4); return end
		if(MouseIsOver(_G["CharacterShirtSlot"])) then	DisplayItemToolTipInventory(3); return end
		if(MouseIsOver(_G["CharacterTabardSlot"])) then	DisplayItemToolTipInventory(18); return end
		if(MouseIsOver(_G["CharacterWristSlot"])) then	DisplayItemToolTipInventory(8); return end
		if(MouseIsOver(_G["CharacterHandsSlot"])) then	DisplayItemToolTipInventory(9); return end
		if(MouseIsOver(_G["CharacterWaistSlot"])) then	DisplayItemToolTipInventory(5); return end
		if(MouseIsOver(_G["CharacterLegsSlot"])) then	DisplayItemToolTipInventory(6); return end
		if(MouseIsOver(_G["CharacterFeetSlot"])) then	DisplayItemToolTipInventory(7); return end
		if(MouseIsOver(_G["CharacterFinger0Slot"])) then	DisplayItemToolTipInventory(10); return end
		if(MouseIsOver(_G["CharacterFinger1Slot"])) then	DisplayItemToolTipInventory(11); return end
		if(MouseIsOver(_G["CharacterTrinket0Slot"])) then	DisplayItemToolTipInventory(12); return end
		if(MouseIsOver(_G["CharacterTrinket1Slot"])) then	DisplayItemToolTipInventory(13); return end
		if(MouseIsOver(_G["CharacterMainHandSlot"])) then	DisplayItemToolTipInventory(15); return end
		if(MouseIsOver(_G["CharacterSecondaryHandSlot"])) then	DisplayItemToolTipInventory(16); return end
		if(MouseIsOver(_G["CharacterRangedSlot"])) then	DisplayItemToolTipInventory(17); return end
	end	

	for i=1, 13 do --MAX_CONTAINER_FRAMES
		if(_G["ContainerFrame"..i]:IsVisible()) then
			for j=1, 36 do --MAX_CONTAINER_ITEMS
				if(MouseIsOver(_G["ContainerFrame"..i.."Item"..j])) then DisplayItemToolTipContainers(_G["ContainerFrame"..i.."Item"..j]); return end
				end
		end
	end
	
	if Stuffing ~= nil then
	  for i=0, 13 do --MAX_CONTAINER_FRAMES
		if(StuffingFrameBags:IsVisible()) then
			for j=1, 36 do --MAX_CONTAINER_ITEMS
				if _G["StuffingBag"..i.."_"..j] ~= nil then
					if(MouseIsOver(_G["StuffingBag"..i.."_"..j])) then DisplayStuffings(i,j) ; end
				end
			end
		end
	  end
	end
	
	if(_G["InspectHeadSlot"] ~= nil and InspectPaperDollFrame:IsVisible() ) then
		if(MouseIsOver(_G["InspectHeadSlot"])) then	DisplayItemToolTipInspect(0); return end
		if(MouseIsOver(_G["InspectNeckSlot"])) then	DisplayItemToolTipInspect(1); return end
		if(MouseIsOver(_G["InspectShoulderSlot"])) then	DisplayItemToolTipInspect(2); return end
		if(MouseIsOver(_G["InspectBackSlot"])) then	DisplayItemToolTipInspect(14); return end
		if(MouseIsOver(_G["InspectChestSlot"])) then	DisplayItemToolTipInspect(4); return end
		if(MouseIsOver(_G["InspectShirtSlot"])) then	DisplayItemToolTipInspect(3); return end
		if(MouseIsOver(_G["InspectTabardSlot"])) then	DisplayItemToolTipInspect(18); return end
		if(MouseIsOver(_G["InspectWristSlot"])) then	DisplayItemToolTipInspect(8); return end
		if(MouseIsOver(_G["InspectHandsSlot"])) then	DisplayItemToolTipInspect(9); return end
		if(MouseIsOver(_G["InspectWaistSlot"])) then	DisplayItemToolTipInspect(5); return end
		if(MouseIsOver(_G["InspectLegsSlot"])) then	DisplayItemToolTipInspect(6); return end
		if(MouseIsOver(_G["InspectFeetSlot"])) then	DisplayItemToolTipInspect(7); return end
		if(MouseIsOver(_G["InspectFinger0Slot"])) then	DisplayItemToolTipInspect(10); return end
		if(MouseIsOver(_G["InspectFinger1Slot"])) then	DisplayItemToolTipInspect(11); return end
		if(MouseIsOver(_G["InspectTrinket0Slot"])) then	DisplayItemToolTipInspect(12); return end
		if(MouseIsOver(_G["InspectTrinket1Slot"])) then	DisplayItemToolTipInspect(13); return end
		if(MouseIsOver(_G["InspectMainHandSlot"])) then	DisplayItemToolTipInspect(15); return end
		if(MouseIsOver(_G["InspectSecondaryHandSlot"])) then	DisplayItemToolTipInspect(16); return end
		if(MouseIsOver(_G["InspectRangedSlot"])) then	DisplayItemToolTipInspect(17); return end
	end	
	
	for i=1,7 do --TTrade
		if(MouseIsOver(_G["TradeRecipientItem"..i.."ItemButton"])) then DisplayTradeRecipientItemTooltip(i) end
	end
	for i=1,7 do
		if(MouseIsOver(_G["TradePlayerItem"..i.."ItemButton"])) then DisplayTradePlayerItemTooltip(i) end
	end
	
	--------------------------------------------------------------------------------------------------
--	if( _G["Horadric"] ~= nil and _G["Horadric"].IsShown() ) then
		for i=1,9 do
			local button =_G["HoradricButton"..i]
			if(MouseIsOver(button)) then DisplayItemToolTipContainers(button.orgbagbutton);end
		end
--	end
end

-- register hook for tooltip refresh. on 4.x client this gets spammed all the time :S
GameTooltip:HookScript("OnTooltipSetItem", QuryAndShowExtraTooltip)

local frame, events = CreateFrame("Frame"), {};
--function events:UNIT_INVENTORY_CHANGED(...)
--end

--function events:ADDON_LOADED(...)
--	SendGreeting() -- will only send it once. It will tell the server it is ok to send us query replies
--end

function events:PLAYER_ENTERING_WORLD(...)
	SendGreeting() -- will only send it once. It will tell the server it is ok to send us query replies
end

--frame:SetScript("OnEvent", function(self, event, ...)
--	events[event](self, ...); -- call one of the functions above
--end);

for k, v in pairs(events) do
	frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end

RegisterOpcodeHandler("RIQV",OpcodeHandlerResendGreeting)
RegisterOpcodeHandler("RIQS",OnServerQuerySingleStatValue)
-- server send item update before the client requested it
RegisterOpcodeHandler("RIPU",OnServerQueryPush)
-- server replied to our item query
RegisterOpcodeHandler("RI  ",OnServerQueryReply)
-- our DB might be outdated
RegisterOpcodeHandler("RIDB",OnServerDBUpdate)

local origSetTooltipMoney=SetTooltipMoney;
SetTooltipMoney = function(...) 
   local frame, money, type, prefixText, suffixText = ...
   if SetMFDust then 
	if GameTooltip:GetItem() ~= nil then
		suffixText = SetMFDust     
	end
   end
   return origSetTooltipMoney(frame, money, type, prefixText,suffixText)
end

MainMenuBarMaxLevelBar.Show = function() end
MainMenuExpBar.Hide = function() end
MainMenuExpBar:Show()
MainMenuExpBar:SetScript('OnHide', function (self) self:Show() end)
MainMenuBarMaxLevelBar:Hide()
MainMenuExpBar.pauseUpdates = nil;

InvType = {
   INVTYPE_HEAD           = 0,
   INVTYPE_NECK           = 1,
   INVTYPE_SHOULDER       = 2,
   INVTYPE_BODY           = 3, --shirt
   INVTYPE_CHEST          = 4,
   INVTYPE_ROBE           = 4,
   INVTYPE_WAIST          = 5,
   INVTYPE_LEGS           = 6,
   INVTYPE_FEET           = 7,
   INVTYPE_WRIST          = 8,
   INVTYPE_HAND           = 9,
   INVTYPE_FINGER         = 10, --11 
   INVTYPE_TRINKET        = 12, --13
   INVTYPE_CLOAK          = 14,
   INVTYPE_WEAPON         = 15, --16
   INVTYPE_SHIELD         = 16,
   INVTYPE_2HWEAPON       = 15, --16
   INVTYPE_WEAPONMAINHAND = 15,
   INVTYPE_WEAPONOFFHAND  = 16,
   INVTYPE_HOLDABLE       = 16, --held in offhand
   INVTYPE_RANGED         = 17,
   INVTYPE_THROWN         = 17,
   INVTYPE_RANGEDRIGHT    = 17,
   INVTYPE_RELIC          = 17,
   INVTYPE_TABARD         = 19
}

--Todo: 
-- Add which effects are to be lost
-- add other uneqipt methods
--
local HSRI = {  139,179,180,181,182,183,184,185,
			    186,187,189,190,191,192,193,194,
			    195,196,197,198,199,200,201,202,
				203,204,205,206,207,208,209,210,
				211,212,213,214,215,216,217,218,
				219,264,276,277,94,93 };
			
local function ItemHasSpecialRI(invSlot)
	local HasCache, TooltipLineCount, ParsedQuery, ParsedQueryColors,ItemId,data = GetSlotInspectTooltipDataCached(invSlot-1)
	if data == nil then return false end
	local ReadIndex = 0
	local ValueCount, ListOfStructValues = Explode(data)
		for i2 = 1, ValueCount-1 do
		local StatTypeIndex = tonumber(ListOfStructValues[ReadIndex]);
		   local ArgumentCountUsed = CountArguments(FormatedString)
		   ReadIndex = ReadIndex + 1 + ArgumentCountUsed
		    if tContains(HSRI, StatTypeIndex) then 
				return true
			end
		end

	return false
end

local lastaction = ""
local origEquipmentManager_RunAction= EquipmentManager_RunAction; --PaperDollFrame -=> mouseove+Alt
	EquipmentManager_RunAction = function(action)
	
	if ItemHasSpecialRI(action.invSlot) then
		StaticPopup_Show("REMOVE_RI_ITEM_CONFIRM",action)
		lastaction = action
		return
	end
   return origEquipmentManager_RunAction(action) 
end

local CONFIRM_CONTINUE = "Do you wish to continue?";
local REMOVE_RI_ITEM_CONFIRMATION = "You are about to remove an item which is granting an effect"
StaticPopupDialogs["REMOVE_RI_ITEM_CONFIRM"] = {
   text = REMOVE_RI_ITEM_CONFIRMATION.."\n"..CONFIRM_CONTINUE,
   button1 = OKAY,
   button2 = CANCEL,
   OnAccept = function(self)
	  origEquipmentManager_RunAction(lastaction) 
   end,
   OnCancel = function(self)
       --ClearCursor()
   end,
   timeout = 0,
   exclusive = 1,
   whileDead = 1,
   hideOnEscape = 1,
   --hasItemFrame = 1
};


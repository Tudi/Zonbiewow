MessageHandlers = {}

function AddonCommSendPacketToServer(Opcode, Message)
	if(string.len(Opcode) > 4) then
		print("Opcode can not be longer than 4 bytes")
	end
	-- this might differ from one version to another, right now opcode will be added to the beggining of the message
	local NewMessage = ".#"..Opcode..Message
	--print("Sending message to server : "..NewMessage)
	SendAddonMessage(nil, NewMessage, "GUILD", nil)
end

function RegisterOpcodeHandler(Opcode, PacketHandlerFunction)
	if( MessageHandlers[Opcode] ~= nil ) then
		print("This opcode "..Opcode.." already has a handler "..MessageHandlers[Opcode].." . Will overwrite it!")
	end
	if(PacketHandlerFunction == nil) then
		print("Opcode "..Opcode.." is trying to use a nil value as packet handler instead a function")
	end
	MessageHandlers[Opcode] = PacketHandlerFunction
end

-- server sent us a message that can be interpreted as a query reply
function OnServerMessage(message, sender, language, ChannelName, TargetName, Flags, Zone, ChannelNumber, ChannelNameShort, LineID, GUID, ...)
	--print("Server sent us a message "..message.." Time diff "..(1 - (WaitTransactionFinish-GetTime())))
	--print("Server sent us a message "..message.." channel name "..ChannelName)
	if(ChannelName == nil) then
		return
	end
	local PacketSigniture = string.sub(ChannelName,1,2)
	--print("Packet signiture is "..PacketSigniture)
	if( PacketSigniture ~= ".#") then
		return
	end
	local Opcode = string.sub(ChannelName,3,3+4-1)
	--print("Packet opcode is '"..Opcode.."'")
	if(MessageHandlers[Opcode] == nil ) then
		print("Server sent us a packet that is not yet handled ? "..Opcode)
		return
	end
	--print("Remaining message is "..message)
	MessageHandlers[Opcode](message)
end

local frame, events = CreateFrame("Frame"), {};
function events:CHAT_MSG_CHANNEL(...)
	OnServerMessage(...)
end
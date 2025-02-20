-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

local CHAT_GROUPS = vRP.Groups()


-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:SERVERMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chat:ServerMessage")
AddEventHandler("chat:ServerMessage",function(Mode, Message, routingPlayers)
    ProfilerEnterScope( ('chat:ServerMessage:%s:%s'):format( Mode,Message ) )

	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        ProfilerEnterScope( ('chat:ServerMessage:%s:%s:getIdentity'):format( Mode,Message ) )
		local Name = vRP.FullName(Passport)
        local messageTitle = Name .. " ["..Passport.."]"
        ProfilerExitScope()
		local Messages = Message:gsub("[<>]","")
        local tag = Entity(GetPlayerPed(source))["state"]["VipEmote"]
        if Mode == "global" or Mode == "ajuda" then
            if vRP.HasGroup(Passport,"Tutor") then
                TriggerClientEvent("chat:ClientMessage",-1,messageTitle,Messages,Mode,true,{
                    background = "rgba(33,124,1,.75)",
                }, tag)
            else
                TriggerClientEvent("chat:ClientMessage",-1,messageTitle,Messages,Mode, nil, nil, tag)
            end

            ProfilerExitScope()

            return
        end
		if not CHAT_GROUPS[Mode] then
            if Mode == "local" then
                TriggerClientEvent("chat:ClientMessageWithShowMe", source, source, messageTitle, Messages, Mode, tag)

                local playerPedId  = GetPlayerPed( source )
                local playerPedPos = GetEntityCoords( playerPedId )

                for _, routingPlayerId in ipairs( routingPlayers ) do

                    local routingPlayerPedId  = GetPlayerPed( routingPlayerId )
                    local routingPlayerPedPos = GetEntityCoords( routingPlayerPedId )

                    if #( routingPlayerPedPos - playerPedPos ) <= 10.0 then

                        TriggerClientEvent("chat:ClientMessageWithShowMe", routingPlayerId, source, messageTitle, Messages, Mode, tag)
                    end
                end
            else
                TriggerClientEvent("chat:ClientMessage",-1,messageTitle,Messages,Mode, nil, nil, tag)
                exports["vrp"]:SendWebHook("chat","**Passaporte:** "..Passport.."\n**Mandou a msg:** "..Messages..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
            end
		else
			if vRP.HasGroup(Passport,Mode) then
				local Service = vRP.NumPermission(Mode)
				for Passports,Sources in pairs(Service) do
                    TriggerClientEvent("chat:ClientMessage",Sources,messageTitle, Messages,Mode, nil, {
                        background = "#3a85fa"
                    }, tag)
				end
			end
		end
	end

    ProfilerExitScope()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:SERVERMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chat:DeleteMessage")
AddEventHandler("chat:DeleteMessage",function(Message)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",5) then
        TriggerClientEvent("chat:ClientDelete",-1,Message)
        TriggerClientEvent("Notify","importante","Mensagem apagada.",5000,"CHAT")
        -- TriggerClientEvent("Notify2","#DeleteMessage")
        exports["vrp"]:SendWebHook("delchat","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n** DELETOU MENSAGEM:** "..Message.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
    end
end)
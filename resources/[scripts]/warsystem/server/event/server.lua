Event = {}
PlayersEvent = {}
PlayerKills = {}
PlayersEventSpectate = {}

RegisterCommand("eventcreate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local EventId = #Event + 1
            Event[EventId] = {Rounds = 0, Teams = {}}
            -- local Info = {}
            -- Info["Name"] = "Team 1"
            -- Info["Players"] = GetPassportString("5,162,655,91",EventId,1)
            -- Info["Score"] = 0
            -- Event[EventId]["Teams"][1] = Info
            -- Wait(100)
            -- Info = {}
            -- Info["Name"] = "Team 2"
            -- Info["Players"] = GetPassportString("157,1257,34,504",EventId,2)
            -- Info["Score"] = 0
            -- Event[EventId]["Teams"][2] = Info
            -- Wait(100)
            -- Event[EventId]["Spectate"] = GetPassportString("2",EventId)
            -- Event[EventId]["Bucket"] = parseInt(15)
            -- Event[EventId]["Name"] = "Team x Team"
            -- Wait(100)
            -- UpdateClientInfoEvent(EventId)
            -- Wait(100)
            -- StartRound(EventId,true)
            local Keyboard = vKEYBOARD.keyDouble(source,"Nome do time:","Ids para o time: Exemplo (1,2,3,4,5)")
            if Keyboard and Keyboard[1] then
                local Info = {}
                Info["Name"] = Keyboard[1]
                Info["Players"] = GetPassportString(Keyboard[2],EventId,1)
                Info["Score"] = 0
                Event[EventId]["Teams"][1] = Info
            end
            Wait(250)
            local Keyboard = vKEYBOARD.keyDouble(source,"Nome do time:","Ids para o time: Exemplo (1,2,3,4,5)")
            if Keyboard and Keyboard[1] then
                local Info = {}
                Info["Name"] = Keyboard[1]
                Info["Players"] = GetPassportString(Keyboard[2],EventId,2)
                Info["Score"] = 0
                Event[EventId]["Teams"][2] = Info
            end
            Wait(250)
            local Keyboard = vKEYBOARD.keySingle(source,"Ids Espectadores: Exemplo (1,2,3,4,5)")
            if Keyboard and Keyboard[1] then
                Event[EventId]["Spectate"] = GetPassportString(Keyboard[1]) or {}
            end
            Wait(250)
            local Keyboard = vKEYBOARD.keySingle(source,"Mundo:")
            if Keyboard and Keyboard[1] then
                Event[EventId]["Bucket"] = parseInt(Keyboard[1])
            end
            Wait(250)
            local Keyboard = vKEYBOARD.keySingle(source,"Nome do evento:")
            if Keyboard and Keyboard[1] then
                Event[EventId]["Name"] = Keyboard[1]
            end
            Wait(250)
            local Keyboard = vKEYBOARD.keySingle(source,"Tipo de arena:")
            if Keyboard and Keyboard[1] then
                Event[EventId]["Type"] = Keyboard[1]
            end
            Wait(250)
            local Keyboard = vKEYBOARD.keySingle(source,"Quantidade de rounds:")
            if Keyboard and Keyboard[1] then
                Event[EventId]["MaxRounds"] = parseInt(Keyboard[1])
            else
                Event[EventId]["MaxRounds"] = 10
            end
            Wait(250)
            if not Event[EventId]["Spectate"] then
                Event[EventId]["Spectate"] = {}
            end
            Wait(250)
            PreStartRound(EventId,true)
            TriggerClientEvent("Notify",source,"sucesso","Evento criado com sucesso ID: <b>"..EventId.."</b>.",90000,"Eventos")
            -- TriggerClientEvent("Notify2",source,"#createdEvent",{msg=EventId})
		end
	end
end)

RegisterCommand("eventstart",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"ID:")
            if Keyboard and Keyboard[1] then
                local EventId = parseInt(Keyboard[1])
                if Event[EventId] and Event[EventId]["Teams"] then
                    StartRound(EventId,true)
                    TriggerClientEvent("Notify",source,"sucesso","Evento iniciado com sucesso ID: <b>"..parseInt(Keyboard[1]).."</b>.",5000,"Eventos")
                    -- TriggerClientEvent("Notify2",source,"#eventStarted",{msg=parseInt(Keyboard[1])})
                else
                    TriggerClientEvent("Notify",source,"negado","Evento não encontrado ID: <b>"..parseInt(Keyboard[1]).."</b>.",5000,"Eventos")
                    -- TriggerClientEvent("Notify2",source,"#eventNotFound",{msg=parseInt(Keyboard[1])})
                end
            end
        end
    end
end)

RegisterCommand("restartevent",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"ID:")
            if Keyboard and Keyboard[1] then
                StartRound(parseInt(Keyboard[1]),true)
                TriggerClientEvent("Notify",source,"sucesso","Evento reiniciado com sucesso ID: <b>"..parseInt(Keyboard[1]).."</b>.",5000,"Eventos")
                -- TriggerClientEvent("Notify2",source,"#restartEvent",{msg=parseInt(Keyboard[1])})
            end
        end
    end
end)

function TriggerKillFeedEvent(Killer,Victim,Weapon,EventId)
    if EventId then
        if Event[EventId] and Event[EventId]["Teams"] then
            for Group,Table in pairs(Event[EventId]["Teams"]) do
                async(function()
                    for i=1,#Table["Players"] do
                        local Source = Table["Players"][i]
                        local Kills = PlayerKills[tostring(Source)]
                        TriggerClientEvent("event:KillFeed",Source,Killer,Victim,Weapon,Kills)
                    end
                end)
            end
            for i=1,#Event[EventId]["Spectate"] do
                async(function()
                    local Source = Event[EventId]["Spectate"][i]
                    TriggerClientEvent("event:KillFeed",Source,Killer,Victim,Weapon)
                    TriggerClientEvent("event:Update",Source,Event[EventId]["Info"])
                end)
            end
        end
    end
end

function Server.killFeedEvent(Killer,Victim,Weapon)
    if PlayersEvent[tostring(Killer)] then
        -- print("Kill Event Triggered")
        local EventId = PlayersEvent[tostring(Killer)]["EventId"]
        local Group = SourceGroup[Killer]
        local GroupVictim = SourceGroup[Victim]
        local KillerPed = GetPlayerPed(Killer)
        local VictimPed = GetPlayerPed(Victim)
        local KillerName = Entity(KillerPed)["state"]["Name"]
        local VictimName = Entity(VictimPed)["state"]["Name"]
        PlayerKills[tostring(Killer)] = PlayerKills[tostring(Killer)] + 1
        TriggerKillFeedEvent(KillerName,VictimName,Weapon,EventId)
        -- local Source = tostring(Victim)
        --NextSpectateEvent(Victim,PlayersEvent[Source],true,PlayersEvent[Source]["EventId"])
        Wait(2500)
        local Group = GetAmountPlayersEvent(EventId)
        -- print("Has Done?",Group,tostring(Event[EventId]["RoundDone"]))
        if Group and not Event[EventId]["RoundDone"] then
            Event[EventId]["RoundDone"] = true
            -- print("Wait")
            Wait(7500)
            -- print("Round Done")
            AddPoint(EventId,parseInt(Group))
        end
    end
end

RegisterCommand("eventpause",function(source,Message)
	local Passport = vRP.Passport(source)
    if Passport and PlayersEvent[tostring(source)] then
        local Keyboard = vKEYBOARD.keySingle(source,"ID:")
        if Keyboard and Keyboard[1] then
            local EventId = parseInt(Keyboard[1])
            if Event[EventId] then
                Event[EventId]["Pause"] = true
                TriggerClientEvent("Notify",source,"sucesso","Evento pausado com sucesso.",5000,"Eventos")
                if Event[EventId] and Event[EventId]["Teams"] then
                    for Group,Table in pairs(Event[EventId]["Teams"]) do
                        async(function()
                            for i=1,#Table["Players"] do
                                local Source = Table["Players"][i]
                                TriggerClientEvent("event:pause",Source)
                            end
                        end)
                    end
                end
            end
        end
    end
end)

RegisterCommand("eventplay",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"ID:")
            if Keyboard and Keyboard[1] then
                local EventId = parseInt(Keyboard[1])
                if Event[EventId] then
                    StartRound(parseInt(EventId))
                    Event[EventId]["Pause"] = false
                    TriggerClientEvent("Notify",source,"sucesso","Evento resumido com sucesso ID: <b>"..EventId.."</b>.",5000,"Eventos")
                    -- TriggerClientEvent("Notify2",source,"#resumeEvent",{msg=EventId})
                end
            end
        end
    end
end)

RegisterCommand("copypreset",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
        local nPASSPORT = parseInt(Message[1])
		if PlayersEvent[tostring(source)] then
            TriggerClientEvent("skinshop:Apply",source,vRP.UserData(nPASSPORT,"Clothings"))
        end
    end
end)

RegisterCommand("addpointevent",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"ID:","Time:1 ou 2")
            if Keyboard and Keyboard[1] then
                local EventId = parseInt(Keyboard[1])
                local Group = parseInt(Keyboard[2])
                AddPoint(EventId,Group)
                TriggerClientEvent("Notify",source,"sucesso","Ponto adicionado com sucesso.",5000,"Eventos")
                -- TriggerClientEvent("Notify2",source,"#addpointevent")
            end
        end
    end
end)

RegisterCommand("rempointevent",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"ID:","Time:1 ou 2")
            if Keyboard and Keyboard[1] then
                local EventId = parseInt(Keyboard[1])
                local Group = parseInt(Keyboard[2])
                RemPoint(EventId,Group)
                TriggerClientEvent("Notify",source,"sucesso","Ponto removido com sucesso.",5000,"Eventos")
                -- TriggerClientEvent("Notify2",source,"#rempointevent")
            end
        end
    end
end)
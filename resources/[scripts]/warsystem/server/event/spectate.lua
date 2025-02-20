PlayerSpectateEvent = {}

RegisterServerEvent("event:NextSpectate")
AddEventHandler("event:NextSpectate",function()
    -- local Source = source
    -- local Passport = vRP.Passport(Source)
    -- if PlayersEvent[tostring(Source)] then
    --     NextSpectateEvent(Source,PlayersEvent[tostring(Source)],true,PlayersEvent[tostring(Source)]["EventId"])
    -- elseif PlayersEventSpectate[tostring(Source)] then
    --     NextSpectateEvent(Source,false,true,PlayersEventSpectate[tostring(Source)]["EventId"])
    -- end
end)

RegisterServerEvent("event:PreviousSpectate")
AddEventHandler("event:PreviousSpectate",function()
    -- local Source = source
    -- local Passport = vRP.Passport(Source)
    -- if PlayersEvent[tostring(Source)] then
    --     NextSpectateEvent(Source,PlayersEvent[tostring(Source)],true,PlayersEvent[tostring(Source)]["EventId"])
    -- elseif PlayersEventSpectate[tostring(Source)] then
    --     NextSpectateEvent(Source,false,true,PlayersEventSpectate[tostring(Source)]["EventId"])
    -- end
end)

function NextSpectateEvent(Source,Table,Next,EventId)
    -- local Source = parseInt(Source)
    -- local Group = 1
    -- if Table and Table["Team"] then
    --     Group = Table["Team"]
    -- else
    --     Group = 1
    -- end
    -- if not Group then
    --     Group = 1
    -- end
    -- local Count = GetAmountPlayersEvent(EventId)
    -- if Count then
    --     return
    -- end
    -- if not PlayerSpectateEvent[Source] then
    --     PlayerSpectateEvent[Source] = 1
    -- else
    --     if Next then
    --         PlayerSpectateEvent[Source] = PlayerSpectateEvent[Source] + 1
    --     else
    --         PlayerSpectateEvent[Source] = PlayerSpectateEvent[Source] - 1
    --     end
    -- end
    -- if PlayerSpectateEvent[Source] > #Event[EventId]["Teams"][Group]["Players"] then
    --     PlayerSpectateEvent[Source] = 1
    --     if not Table or not Table["Team"] then
    --         Group = Group + 1
    --     end
    -- end
    -- local Spectated = Event[EventId]["Teams"][Group]["Players"][PlayerSpectateEvent[Source]]
    -- if Spectated then
    --     local Ped = GetPlayerPed(Spectated)
    --     local Bucket = GetPlayerRoutingBucket(Spectated)
    --     if Ped then
    --         SetPlayerRoutingBucket(Source,Bucket)
    --         local Name = Entity(Ped)["state"]["Name"]
    --         local Kills = PlayerKills[tostring(Spectated)]
    --         TriggerClientEvent("event:Spectate",parseInt(Source),{ name = Name, kills = Kills, Info = Event[EventId]["Info"], Source = Spectated })
    --     end
    -- end
end

function EndSpectateEvent(Source,End)
    -- if PlayerSpectateEvent[Source] then
    --     PlayerSpectateEvent[Source] = nil
    -- end
    -- TriggerClientEvent("admin:resetSpectate",Source)
end
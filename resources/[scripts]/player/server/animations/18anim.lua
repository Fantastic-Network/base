RegisterNetEvent('randallfetish:sendRequest')
AddEventHandler('randallfetish:sendRequest', function(targetId, action)
    local sourceId = source
    local Passport = vRP.Passport(sourceId)
    if not Passport then
        return
    end
    if targetId == nil or action == nil then return end
    if not targetId then
        return
    end
    TriggerClientEvent('randallfetish:receiveRequest', targetId, source, action)
    local Name = vRP.FullName(Passport) or ""
    Name = Name:sub(1, 20)
    if vRP.Request(targetId,"Deseja aceitar animação <b> x "..action.."</b> com <b>"..Name.."</b>?") then
        TriggerClientEvent('randallfetish:receiveRequest', targetId, sourceId, action)
        TriggerClientEvent('randallfetish:requestAccepted', sourceId, targetId)
        TriggerClientEvent('randallfetish:requestAccepted', targetId, sourceId)
    else
        TriggerClientEvent('randallfetish:requestDeclined', sourceId)
    end
end)

RegisterNetEvent('randallfetish:cancelRequest')
AddEventHandler('randallfetish:cancelRequest', function(sourceId)
    if sourceId == nil then return end
    if not sourceId then
        return
    end
	TriggerClientEvent('randallfetish:requestDeclined', sourceId)
end)

RegisterNetEvent('randallfetish:syncStopAnim')
AddEventHandler('randallfetish:syncStopAnim', function(playerId, action)
	if playerId == nil or action == nil then return end
    if not playerId then
        return
    end
	TriggerClientEvent('randallfetish:stopAnim', playerId, action)
end)
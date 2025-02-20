-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end
    local Victim = PlayerPedId()
    
    if args[1] ~= Victim then
        return
    end
    
    if not LocalPlayer["state"]["inWar"] then
        return
    end

    local Attacker = tonumber(args[2])
    local VictimDied = GetEntityHealth(Victim) <= 100
    local Weapon = tostring(args[7])
    if VictimDied then
        if IsEntityAPed(Victim) then
            if IsPedAPlayer(Attacker) then
                local KillerServerId = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Attacker)))
                local VictimServerId = GetPlayerServerId(PlayerId())
                local KillerCoordinate = GetEntityCoords(Attacker)
                vSERVER.WarKillFeed(KillerServerId,VictimServerId,Weapon)
            end
        end
    end
end)

RegisterNetEvent("warsystem:OpenWarForm")
AddEventHandler("warsystem:OpenWarForm",function()
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = "setVisible",
        data = "form-war"
    })
end)

RegisterNuiCallback("saveWarData",function(data,cb)
    vSERVER.StartWar(data["initDate"],data["endDate"],data["attackGroup"],data["defenseGroup"])
end)
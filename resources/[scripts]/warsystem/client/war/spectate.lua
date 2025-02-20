local SpectatingUser = false
RegisterNetEvent("warsystem:Spectate")
AddEventHandler("warsystem:Spectate",function(Table)
    SetNuiFocus(true,true)
    TriggerEvent("hud:Active",false)
    TriggerEvent("Notify:Remkey" ,true)
    TriggerEvent("safezone:remPromo",true)
    local source = Table["Source"]
    local Pid = GetPlayerFromServerId(source)
    local Ped = GetPlayerPed(Pid)
    LocalPlayer["state"]:set("Spectate",true,true)
    NetworkSetInSpectatorMode(true,Ped)
    SpectatingUser = GetPlayerPed(Pid)
    SendNUIMessage({
        action = 'setVisible',
        data = "spectate"
    })
    Wait(100)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table["Info"]
    })
    SendNUIMessage({
        action = 'UpdateSpectatingUser',
        data = Table
    })
end)

RegisterNetEvent("event:Spectate")
AddEventHandler("event:Spectate",function(Table)
    -- local Ped = PlayerPedId()
    -- SetNuiFocus(true,true)
    -- TriggerEvent("hud:Active",false)
    -- TriggerEvent("Notify:Remkey" ,true)
    -- TriggerEvent("safezone:remPromo",false)
    -- local source = Table["Source"]
    -- local Pid = GetPlayerFromServerId(source)
    -- local Ped = GetPlayerPed(Pid)
    -- if GetEntityHealth(Ped) <= 100 then
    --     Wait(1000)
    --     TriggerServerEvent("event:NextSpectate",Ped)
    -- end
    -- LocalPlayer["state"]:set("Spectate",true,true)
    -- NetworkSetInSpectatorMode(true,Ped)
    -- SpectatingUser = GetPlayerPed(Pid)
    -- SendNUIMessage({
    --     action = 'setVisible',
    --     data = "spectate"
    -- })
    -- Wait(100)
    -- SendNUIMessage({
    --     action = 'UpdateGameStats',
    --     data = Table["Info"]
    -- })
    -- SendNUIMessage({
    --     action = 'UpdateSpectatingUser',
    --     data = Table
    -- })
end)

RegisterNetEvent("event:EndSpectate")
AddEventHandler("event:EndSpectate",function(Table)
    -- local Ped = PlayerPedId()
    -- TriggerEvent("admin:resetSpectate")
    -- SetNuiFocus(false,false)
    -- Wait(100)
    -- SendNUIMessage({
    --     action = 'setVisible',
    --     data = false
    -- })
    -- TriggerEvent("Notify:Remkey",false)
    -- TriggerEvent("safezone:remPromo",true)
    -- TriggerEvent("hud:Active",true)
    -- SetEntityInvincible(Ped,false)
    -- FreezeEntityPosition(Ped, false)
    -- LocalPlayer["state"]["Invisible"] = false
    -- LocalPlayer["state"]["Invincible"] = false
    -- Wait(1000)
    -- exports["survival"]:Revive(400)
end)

RegisterNetEvent("warsystem:UpdateSpectateInfo")
AddEventHandler("warsystem:UpdateSpectateInfo",function(Table)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table
    })
end)

RegisterNetEvent("warsystem:EndSpectate")
AddEventHandler("warsystem:EndSpectate",function()
    local Ped = PlayerPedId()
    SpectatingUser = false
    SetNuiFocus(false,false)
    Wait(100)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    TriggerEvent("Notify:Remkey",false)
    TriggerEvent("safezone:remPromo",false)
    TriggerEvent("hud:Active",true)
    SetEntityInvincible(Ped,false)
    SetEntityVisible(Ped,true,false)
    SetEntityCollision(Ped,true,true)
    FreezeEntityPosition(Ped, false)
    LocalPlayer["state"]["Invisible"] = false
    LocalPlayer["state"]["Invincible"] = false
    Wait(1000)
    exports["survival"]:Revive(400)
end)

RegisterNUICallback("NextUser",function(data,cb)
    if LocalPlayer["state"]["WarSystem"] then
        TriggerServerEvent("warsystem:NextSpectate")
    else
        TriggerServerEvent("event:NextSpectate")
    end
end)

RegisterNUICallback("PreviousUser",function(data,cb)
    if LocalPlayer["state"]["WarSystem"] then
        TriggerServerEvent("warsystem:PreviousSpectate")
    else
        TriggerServerEvent("event:PreviousSpectate")
    end
end)

AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end

    if not SpectatingUser then
        return
    end
    
    local Victim = SpectatingUser

    if args[1] ~= Victim then
        return
    end
    
    local VictimDied = GetEntityHealth(Victim) <= 101
    if VictimDied then
        if IsEntityAPed(Victim) then
            Wait(1500)
            if LocalPlayer["state"]["WarSystem"] then
                TriggerServerEvent("warsystem:NextSpectate")
            else
                TriggerServerEvent("event:NextSpectate")
            end
        end
    end
end)

CreateThread(function()
    Wait(1000)
    local Ped = PlayerPedId()
    TriggerEvent("admin:resetSpectate")
    SetEntityVisible(Ped,true,false)
    SetEntityCollision(Ped,true,true)
end)
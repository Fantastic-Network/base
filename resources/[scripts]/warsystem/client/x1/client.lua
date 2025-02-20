InX1 = false
StartingX1 = false
InQueue = false
X1Spawns = {
    ["1x1"] = {
        [1] = {
            vector4(-1663.09,5864.77,210.36,34.02),
        },
        [2] = {
            vector4(-1675.43,5886.27,210.36,218.27),
        }
    },
}

RegisterNetEvent("1x1:pause")
AddEventHandler("1x1:pause",function()
    StartingX1 = false
    local Ped = PlayerPedId()
    FreezeEntityPosition(Ped,true)
end)

RegisterNetEvent("1x1:PreStart")
AddEventHandler("1x1:PreStart",function(Team,Table,TeamName,Type)
    InQueue = false
    local Ped = PlayerPedId()
    SetEntityCoords(Ped,X1Spawns[Type][Team][1]["x"],X1Spawns[Type][Team][1]["y"],X1Spawns[Type][Team][1]["z"],false,false,false,false)
    FreezeEntityPosition(Ped,true)
    TriggerEvent("Notify:Remkey",false)
end)


RegisterNetEvent("1x1:Start")
AddEventHandler("1x1:Start",function(Team,Table,TeamName,Type)
    local Ped = PlayerPedId()
    local Player = PlayerId()
    SetNuiFocus(false,false)
    TriggerEvent("admin:resetSpectate")
    SetEntityCoords(Ped,X1Spawns[Type][Team][1]["x"],X1Spawns[Type][Team][1]["y"],X1Spawns[Type][Team][1]["z"],false,false,false,false)
    FreezeEntityPosition(Ped,true)
    StartingX1 = true
    SetRunSprintMultiplierForPlayer(Player,1.15)
    if not InX1 then
        TriggerEvent("1x1:StartNui",Table)
        InX1 = true
        CreateThread(function()
            local Ped = PlayerPedId()
            while InX1 do
                local Health = parseInt(GetEntityHealth(Ped))
                SendNUIMessage({
                    action = 'UpdateHealth',
                    data = Health
                })
                Wait(250)
            end
        end)
        TriggerEvent("hud:Active",false)
        TriggerEvent("Notify:Remkey" ,true)
        TriggerEvent("safezone:remPromo",true)
    else
        TriggerEvent("1x1:NewRound",Table)
    end
    SetEntityCollision(Ped,true,true)
    Wait(100)
    exports["survival"]:Revive(400)
    Wait(100)
    ClearPedTasks(Ped)
    TriggerEvent("hud:Active",false)
    TriggerEvent("Notify:Remkey",true)
    Wait(5000)
    if StartingX1 then
        StartingX1 = false
        FreezeEntityPosition(Ped,false)
    end 
end)

RegisterNetEvent("1x1:Update")
AddEventHandler("1x1:Update",function(Table)
    SendNUIMessage({
        action = 'setVisible',
        data = "gameplay-versus"
    })
     Wait(100)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table
    })
end)

AddEventHandler("1x1:NewRound",function(Table)
    local Ped = PlayerPedId()
    TriggerEvent("admin:resetSpectate")
    SetEntityCollision(Ped,true,true)
    SendNUIMessage({
        action = 'setVisible',
        data = "countdown-versus"
    })
    Wait(5000)
    SendNUIMessage({
        action = 'setVisible',
        data = "gameplay-versus"
    })
     Wait(100)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table
    })
end)

AddEventHandler("1x1:StartNui",function(Table)
    Wait(100)
    SendNUIMessage({
        action = 'setVisible',
        data = "countdown-versus"
    })
    
    Wait(5000)

    SendNUIMessage({
        action = 'setVisible',
        data = "gameplay-versus"
    })

    Wait(100)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table
    })
end)

CreateThread(function()
    local Ped = PlayerPedId()
    while true do
        local Idle = 2500
        if InX1 then
            Idle = 250
            local Health = parseInt(GetEntityHealth(Ped))
            SendNUIMessage({
                action = 'UpdateHealth',
                data = Health
            })
        end
        Wait(Idle)
    end
end)

AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end
    local Victim = PlayerPedId()
    
    if args[1] ~= Victim then
        return
    end
    
    if not InX1 then
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
                vSERVER.killFeed1x1(KillerServerId,VictimServerId,Weapon)
            end
        end
    end
end)

RegisterNetEvent("1x1:Finish")
AddEventHandler("1x1:Finish",function()
    local Ped = PlayerPedId()
    local Player = PlayerId()
    exports["survival"]:Revive(400)
    Wait(100)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    SetPedRelationshipGroupHash(Ped,`PLAYER`)
    TriggerEvent("Notify:Remkey",false)
    TriggerEvent("safezone:remPromo",false)
    TriggerEvent("hud:Active",true)
    SetEntityCoords(Ped,-1537.06,-941.47,11.56,141.74)
    SetRunSprintMultiplierForPlayer(Player,1.10)
end)

RegisterNetEvent("1x1:KillFeed")
AddEventHandler("1x1:KillFeed",function(KillerName,VictimName,Weapon,Kills)
    SendNUIMessage({
        action = 'KillFeed',
        data = { 
            killerName = KillerName,
            victimName = VictimName,
            weapon = Weapon,
            duration = 2500,
        }
    })
    SendNUIMessage({
        action = 'UpdateKills',
        data = Kills
    })
end)


RegisterNetEvent("1x1:StartQueue")
AddEventHandler("1x1:StartQueue",function()
    SendNUIMessage({
        action = 'setVisible',
        data = "versus-queue"
    })
    InQueue = true
    CreateThread(function()
        while InQueue do
            if IsControlJustPressed(0,38) then
                InQueue = false
                SendNUIMessage({
                    action = 'setVisible',
                    data = false
                })
                TriggerServerEvent("1x1:LeaveQueue")
            end
            Wait(1)
        end
    end)
end)


RegisterNetEvent("1x1:UpdateQueue")
AddEventHandler("1x1:UpdateQueue",function(Table)
    SendNUIMessage({
        action = 'setVisible',
        data = "versus-queue"
    })
    Wait(100)
    SendNUIMessage({
        action = 'UpdateQueue',
        data = Table
    })
end)

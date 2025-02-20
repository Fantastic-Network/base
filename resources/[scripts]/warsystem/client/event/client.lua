InEvent = false
StartingEvent = false
EventSpawns = {
    ["Arena"] = {
        [1] = {
            vector4(-1895.64,5958.8,207.48,17.01),
        },
        [2] = {
            vector4(-1952.62,5927.41,207.48,119.06),
        }
    },
    ["Predio"] = {
        [1] = {
            vector4(-1543.85,5947.64,213.54,121.89),
        },
        [2] = {
            vector4(-1577.19,5928.45,213.54,300.48),
        }
    },
    ["Fazenda"] = {
        [1] = {
            vector4(-1815.79,5754.9,209.38,36.86),
        },
        [2] = {
            vector4(-1842.76,5803.05,209.38,215.44),
        }
    },
    ["Cayo"] = {
        [1] = {
            vector4(4974.47,-5785.33,20.88,343.0),
        },
        [2] = {
            vector4(5038.11,-5695.13,19.87,136.07),
        }
    },
    ["2x2"] = {
        [1] = {
            vector4(-1663.09,5864.77,211.36,34.02),
        },
        [2] = {
            vector4(-1675.43,5886.27,211.36,218.27),
        }
    },
}
local circleZone = false
function SetSameTeam(TeamName)
    local Ped = PlayerPedId()
    AddRelationshipGroup(TeamName)
    local TeamHash = GetHashKey(TeamName)
    SetPedRelationshipGroupHash(Ped,TeamHash)
    SetEntityCanBeDamagedByRelationshipGroup(Ped,false,TeamHash)
end

RegisterNetEvent("event:pause")
AddEventHandler("event:pause",function()
    StartingEvent = false
    local Ped = PlayerPedId()
    FreezeEntityPosition(Ped,true)
end)

RegisterNetEvent("event:PreStart")
AddEventHandler("event:PreStart",function(Team,Table,TeamName,Type)
    local Ped = PlayerPedId()
    SetEntityCoords(Ped,EventSpawns[Type][Team][1]["x"],EventSpawns[Type][Team][1]["y"],EventSpawns[Type][Team][1]["z"],false,false,false,false)
    FreezeEntityPosition(Ped,true)
    TriggerEvent("Notify:Remkey",false)
end)


RegisterNetEvent("event:Start")
AddEventHandler("event:Start",function(Team,Table,TeamName,Type)
    local Ped = PlayerPedId()
    local Player = PlayerId()
    SetNuiFocus(false,false)
    TriggerEvent("admin:resetSpectate")
    SetEntityCoords(Ped,EventSpawns[Type][Team][1]["x"],EventSpawns[Type][Team][1]["y"],EventSpawns[Type][Team][1]["z"],false,false,false,false)
    SetSameTeam(TeamName)
    FreezeEntityPosition(Ped,true)
    StartingEvent = true
    SetRunSprintMultiplierForPlayer(Player,1.15)
    if not InEvent then
        TriggerEvent("event:StartNui",Table)
        InEvent = true
        CreateThread(function()
            local Ped = PlayerPedId()
            while InEvent do
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
        TriggerEvent("event:NewRound",Table)
    end
    SetEntityCollision(Ped,true,true)
    Wait(100)
    exports["survival"]:Revive(400)
    Wait(100)
    ClearPedTasks(Ped)
    TriggerEvent("hud:Active",false)
    TriggerEvent("Notify:Remkey",true)
    Wait(5000)
    if StartingEvent then
        StartingEvent = false
        FreezeEntityPosition(Ped,false)
    end 
end)

RegisterNetEvent("event:Update")
AddEventHandler("event:Update",function(Table)
    SendNUIMessage({
        action = 'setVisible',
        data = "gameplay-events"
    })
     Wait(100)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table
    })
end)

AddEventHandler("event:NewRound",function(Table)
    local Ped = PlayerPedId()
    TriggerEvent("admin:resetSpectate")
    SetEntityCollision(Ped,true,true)
    SendNUIMessage({
        action = 'setVisible',
        data = "countdown"
    })
    Wait(5000)
    SendNUIMessage({
        action = 'setVisible',
        data = "gameplay-events"
    })
     Wait(100)
    SendNUIMessage({
        action = 'UpdateGameStats',
        data = Table
    })
end)

AddEventHandler("event:StartNui",function(Table)
    Wait(100)
    SendNUIMessage({
        action = 'setVisible',
        data = "countdown"
    })
    
    Wait(5000)

    SendNUIMessage({
        action = 'setVisible',
        data = "gameplay-events"
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
        if InEvent then
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
    
    if not InEvent then
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
                vSERVER.killFeedEvent(KillerServerId,VictimServerId,Weapon)
            end
        end
    end
end)

RegisterNetEvent("event:Finish")
AddEventHandler("event:Finish",function()
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

RegisterNetEvent("event:KillFeed")
AddEventHandler("event:KillFeed",function(KillerName,VictimName,Weapon,Kills)
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
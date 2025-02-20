local Arenagivewepaon
local ArenaNumber
local Team
local TeamDone
local LastCoord
local StartCoords = {
    vector3(-1605.42,-1025.47,13.08),
}

Player = GetPlayerServerId(PlayerId())

CreateThread(function()
    local Table = {}
    
    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i].x,
            StartCoords[i].y,
            StartCoords[i].z,
            2.5,
            "E",
            "Entrar na Arena",
            "Pressione para abrir",
        }
    end
    TriggerEvent("hoverfy:Insert",Table)
    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        for i=1, #StartCoords do
            if #(Coords - StartCoords[i]) <= 2.5 then
                idle = 5
                if IsControlJustPressed(0,38) and not Team and not LocalPlayer["state"]["Newbie"] then
                    local Value = vSERVER.GetArenaInfo()
                    local ArenasNumber = {}
                    for Type,Arenas in pairs(Value) do
                        for i=1,#Arenas do
                            ArenasNumber[#ArenasNumber+1] = {
                                category = Type,
                                players = #Value[Type][i]["Players"],
                            }
                        end
                    end
                    Wait(1)
                    SendNUIMessage({
                        action = 'Arenas',
                        data = ArenasNumber
                    })
                    Wait(1)
                    LastCoord = Coords
                    SendNUIMessage({
                        action = 'router',
                        data = {
                            path = "/"
                        }
                    })
                    SetNuiFocus(true,true)
                    Wait(1)
                    SendNUIMessage({
                        action = 'setVisible',
                        data = true
                    })
                end
            end
        end
        Wait(idle)
    end
end)

AddStateBagChangeHandler('Arena',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if Value then
        Arena = Value["Arena"]
        ArenaNumber = Value["Number"]
        Team = Value["Team"]
        Kills = Value["Kills"]
        if Team == 0 then
            LocalPlayer["state"]["Invisible"] = true
            SetEntityVisible(Ped,false,false)
            FreezeEntityPosition(Ped,true)
            LocalPlayer["state"]["Invincible"] = true
            SetEntityInvincible(Ped,true)
            vSERVER.enterTeam()
            TriggerEvent("hoverfy:InsertText",true,{ title = "SAIR ARENA", key = "F7", legend = "Para sair da arena" })
        elseif not TeamDone then
            SetNuiFocus(false,false)
            TriggerEvent("hoverfy:removeHoverfy")
            TriggerEvent("hoverfy:InsertText",false)
            SendNUIMessage({
                action = 'router',
                data = {
                    path = "/Arena"
                }
            })
            Wait(1)
            SendNUIMessage({
                action = 'setText',
                data = {
                    enter = "",
                    exit = "G"
                }
            })
            TeamDone = true
            TriggerEvent("Notify","verde","Você entrou na arena <b>"..Arena.."</b> Numero <b>"..ArenaNumber.."</b> no time <b>"..Team.."</b>.",5000,"Arena")
            FreezeEntityPosition(Ped,false)
            SetEntityInvincible(Ped,false)
            LocalPlayer["state"]["Invincible"] = false
            SetEntityVisible(Ped,true,false)
            LocalPlayer["state"]["Invisible"] = false
            Wait(1)
            SendNUIMessage({
                action = 'setVisible',
                data = true
            }) 
            Wait(1)
            local Random = math.random(1,#ArenaConfig[Arena][Team])
            SetEntityCoords(Ped,ArenaConfig[Arena][Team][Random]["x"],ArenaConfig[Arena][Team][Random]["y"],ArenaConfig[Arena][Team][Random]["z"],false,false,false,false)
            SetEntityHeading(Ped,ArenaConfig[Arena][Team][Random]["w"])
            CreateThread(function()
                while TeamDone do
                    if IsControlJustPressed(0,47) then
                        ExitArena()
                    end
                    Wait(5)
                end
            end)
        end
    end
end)

RegisterNetEvent("arena:Death")
AddEventHandler("arena:Death",function()
    if Arena then
        local Ped = PlayerPedId()
        local Random = math.random(1,#ArenaConfig[Arena][Team])
        SetEntityCoords(Ped,ArenaConfig[Arena][Team][Random]["x"],ArenaConfig[Arena][Team][Random]["y"],ArenaConfig[Arena][Team][Random]["z"],false,false,false,false)
        exports["survival"]:Revive(200,false)
        SetEntityHeading(Ped,ArenaConfig[Arena][Team][Random]["w"])
        TriggerServerEvent("arena:Death")
    end
end)

RegisterNetEvent("arena:KillFeed")
AddEventHandler("arena:KillFeed",function(Victim,Killer,Weapon)
    SendNUIMessage({
        action = 'killFeed',
        data = { 
            killFeed = { 
                victim = Victim,
                killer = Killer
            },
            image = Weapon,
        }
    })
end)


AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end
    local Victim = PlayerPedId()
    
    if args[1] ~= Victim then
        return
    end
    
    if not Arena then
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
                TriggerServerEvent("arena:SetKillFeed",VictimServerId,KillerServerId,Weapon)
            end
        end
    end
end)

RegisterNUICallback('hideFrame', function(_, cb)
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    Wait(1)
    SendNUIMessage({
        action = 'router',
        data = {
            path = "/"
        }
    })
    
end)

RegisterNUICallback('PlayerClickAction', function(Data, cb)
    if ArenaConfig[Data["action"]]then
        vSERVER.EnterArena(Data["action"],parseInt(Data["id"]))
        SetNuiFocus(false,false)
        Wait(1)
        SendNUIMessage({
            action = 'setVisible',
            data = false
        })
    end
end)

function ExitArena()
    local Ped = PlayerPedId()
    SetEntityVisible(Ped,true,false)
    LocalPlayer["state"]["Invisible"] = false
    FreezeEntityPosition(Ped,false)
    SetEntityInvincible(Ped,false)
    LocalPlayer["state"]["Invincible"] = false
    SetNuiFocus(false,false)
    exports["survival"]:Revive(200,false)
    vSERVER.ExitArena(Arena,ArenaNumber)
    
    SetEntityCoords(Ped,LastCoord,false,false,false,false)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    Wait(1)
    SendNUIMessage({
        action = 'router',
        data = {
            path = "/"
        }
    })
    Arena = nil
    ArenaNumber = nil
    Team = nil
    TeamDone = nil
    LastCoord = nil
    TriggerEvent("hoverfy:InsertText",false)
end


RegisterKeyMapping("exitArena","Test","keyboard","F7")
RegisterCommand("exitArena",function(source,args)
    if Team == 0 then
        ExitArena()
        TriggerEvent("hoverfy:InsertText",false)
    end
end)

CreateThread(function()
    local Ped = PlayerPedId()
    while LocalPlayer["state"]["PVP"] do
        local Health = parseInt(GetEntityHealth(Ped))
        SendNUIMessage({
            action = 'UpdateHealth',
            data = Health
        })
        Wait(250)
    end
end)
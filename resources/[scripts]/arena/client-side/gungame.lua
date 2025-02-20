-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Player = GetPlayerServerId(PlayerId())
local LastCoord
local GunGameWeapons = {}
local Players = {}
local inGunGame = false
local lastWeapons = {}
local StartCoords = {
    vector3(-1589.28,-974.26,13.08),
}
local WaitGungame = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD INIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Table = {}
    
    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i].x,
            StartCoords[i].y,
            StartCoords[i].z,
            2.5,
            "E",
            "Entrar na Corrida Armada",
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
                if IsControlJustPressed(0,38) and not inGunGame and not WaitGungame and not LocalPlayer["state"]["Newbie"] then
                    WaitGungame = true
                    LastCoord = Coords
                    vSERVER.EnterGunGame()
                    SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
                end
            end
        end
        Wait(idle)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONITORING PLAYER GUNGAME
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler('GunGame',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if Value then
        if not inGunGame then
            inGunGame = Value["Game"]
        else
            GunGameWeapons = {}
            for i=Value["Weapon"]+1,#GunGameConfigWeapons do
                GunGameWeapons[#GunGameWeapons+1] = GunGameConfigWeapons[i]
            end
            SendNUIMessage({
                action = 'gunGameChallenges',
                data = {
                    challenges = {
                        guns = GunGameWeapons,
                        activeGun = GetSelectedPedWeapon(Ped)
                    }
                }
            })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- START GUNGAME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gungame:startGunGame")
AddEventHandler("gungame:startGunGame",function(GunGame,GunGames)
    local Ped = PlayerPedId()
    if inGunGame == GunGame then
        WaitGungame = false
        TriggerEvent("hud:Active",false)
        FreezeEntityPosition(Ped,true)
        LocalPlayer["state"]["Invincible"] = true
        SetEntityInvincible(Ped,true)
        DisablePlayerFiring(Ped,true)
        
        SendNUIMessage({
            action = 'router',
            data = {
                path = "/GunGame"
            }
        })
        Wait(25)
        TriggerEvent("hoverfy:removeHoverfy")
        SendNUIMessage({
            action = 'setVisible',
            data = true
        })

        GunGameWeapons = {}
        for i=LocalPlayer["state"]["GunGame"]["Weapon"]+1,#GunGameConfigWeapons do
            GunGameWeapons[#GunGameWeapons+1] = GunGameConfigWeapons[i]
        end

        SendNUIMessage({
            action = 'gunGame',
            data = { 
                users = Players,
                initRound = true
            }
        }) 

        Wait(10)
        SendNUIMessage({
            action = 'gunGameChallenges',
            data = {
                challenges = {
                    guns = GunGameWeapons,
                    activeGun = GetSelectedPedWeapon(Ped)
                }
            }
        })

        CreateThread(function()
            while inGunGame do
                local Ped = PlayerPedId()
                if IsControlJustPressed(0,47) then
                    SetNuiFocus(false,false)
                    TriggerEvent("hud:Active",true)
                    exports["survival"]:Revive(200,false)
                    vSERVER.ExitGungame()
                    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
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
                    LastCoord = nil
                    GunGameWeapons = nil
                    Players = {}
                    inGunGame = false
                    lastWeapons = {}
                end
                Wait(5)
            end
        end)

        Wait(5000)
        updateWeapons(GunGames)
        FreezeEntityPosition(Ped,false)
        SetEntityInvincible(Ped,false)
        LocalPlayer["state"]["Invincible"] = false
        SetLocalPlayerAsGhost(false)
        DisablePlayerFiring(Ped,false)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end
    local Victim = PlayerPedId()


    if not inGunGame then
        return
    end
    lastWeapons[args[1]] = GetSelectedPedWeapon(args[1])

    if args[1] ~= Victim then
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
                TriggerServerEvent("gungame:SetKillFeed",VictimServerId,KillerServerId,Weapon)
                Wait(2500)
                exports["survival"]:Revive(200,false)
                GunGameDeath()
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function GunGameDeath()
	if inGunGame then
		local Ped = PlayerPedId()
        local Random = math.random(1,#GunGameCoords)
		SetEntityCoords(Ped,GunGameCoords[Random]["x"],GunGameCoords[Random]["y"],GunGameCoords[Random]["z"],false,false,false,false)
        SetEntityHeading(Ped,GunGameCoords[Random]["w"])
        TriggerServerEvent("gungame:Death")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILLFEED EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gungame:KillFeed")
AddEventHandler("gungame:KillFeed",function(Victim,Killer,Weapon,GunGames)
    SendNUIMessage({
        action = 'killFeedGunGame',
        data = { 
            killFeed = { 
                victim = Victim,
                killer = Killer
            },
        image = Weapon,
        }
    })

    Wait(500)
    updateWeapons(GunGames)

end)

RegisterNetEvent("gungame:EndGunGame")
AddEventHandler("gungame:EndGunGame",function()
    local Ped = PlayerPedId()
    SetNuiFocus(false,false)
    WaitGungame = false
    exports["survival"]:Revive(200,false)
    TriggerEvent("hud:Active",true)
    Wait(1)
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
    LastCoord = nil
    GunGameWeapons = nil
    Players = {}
    inGunGame = false
    lastWeapons = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
function updateWeapons(GunGames)
    if inGunGame then
        local NewPlayers = {}
        for i=1,#GunGames[inGunGame]["Players"] do
            local PlayerServer = GetPlayerFromServerId(GunGames[inGunGame]["Players"][i]["Source"])
            local PlayerPed = GetPlayerPed(PlayerServer)
            if GetEntityHealth(PlayerPed) <= 100 then
                NewPlayers[#NewPlayers+1] = { 
                    Ped = PlayerPed,
                    name = GunGames[inGunGame]["Players"][i]["Name"],
                    gun = lastWeapons[PlayerPed],
                }
            else
                NewPlayers[#NewPlayers+1] = { 
                    Ped = PlayerPed,
                    name = GunGames[inGunGame]["Players"][i]["Name"],
                    gun = GetSelectedPedWeapon(PlayerPed),
                }
            end
            SendNUIMessage({
                action = 'gunGame',
                data = { 
                    users = NewPlayers,
                    initRound = false
                }
            })
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gungame:BeforeStart")
AddEventHandler("gungame:BeforeStart",function()
    SetNuiFocus(false,false)
    Wait(1)
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
    Wait(1)
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
    Wait(10000)
    while not inGunGame do
        if IsControlJustPressed(0,47) then
            SetNuiFocus(false,false)
            vSERVER.ExitGungame()
            Wait(1)
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
        end
        Wait(5)
    end
end)
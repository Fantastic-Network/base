local StartCoords = {
    vector3(-1615.85,-1037.55,13.14)
}
local Ball = false
local LastCoord = nil
local StartBallCoords = vector3(-4908.63,-1072.97,630.86)
local InAimLabs = false
local BallCoords = {
    vector3(-4909.65,-1055.56,633.17),
    vector3(-4909.91,-1055.55,633.53),
    vector3(-4912.94,-1055.55,634.12),
    vector3(-4913.2,-1055.56,632.93),
    vector3(-4912.95,-1055.57,631.88),
    vector3(-4912.73,-1055.57,631.38),
    vector3(-4909.44,-1055.57,631.09),
    vector3(-4906.87,-1055.57,630.97),
    vector3(-4905.32,-1055.57,630.9),
    vector3(-4905.57,-1055.56,632.8),
    vector3(-4905.28,-1055.55,634.5),
    vector3(-4907.66,-1055.55,634.45),
    vector3(-4907.37,-1055.56,633.02),
    vector3(-4910.19,-1055.55,634.47),
    vector3(-4911.13,-1055.56,632.68),
    vector3(-4909.08,-1055.57,631.77)
}

local Score = 0
Player = GetPlayerServerId(PlayerId())
local PlayerScore = { 
    points = 0,
    time = "00:00",
    timer = 240
}


CreateThread(function()
    local Table = {}
    
    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i].x,
            StartCoords[i].y,
            StartCoords[i].z,
            2.0,
            "E",
            "Entrar no AimLabs",
            "Pressione para abrir",
        }
    end
    TriggerEvent("hoverfy:Insert",Table)
    
    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        for i=1, #StartCoords do
            if #(Coords - StartCoords[i]) <= 2.0 then
                idle = 5
                if IsControlJustPressed(0,38) and not LocalPlayer["state"]["Newbie"] then
                    vSERVER.StartAimLabs()
                    LastCoord = Coords
                end
            end
        end
        Wait(idle)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDAMAGED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("entityDamaged",function(Entity,Player)
    if LocalPlayer["state"]["AimLabs"] and Entity == Ball then
        CreateBall("v_ilev_exball_blue")
        PlayerScore["points"] = PlayerScore["points"] + 1
        SendNUIMessage({
            action = 'aimLabsScore',
            data = { 
                initRound = false,
                buttons = { 
                    enter = {
                        text = "SAIR",
                        control = "E"
                    },
                },
                score = PlayerScore
            }
        })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEBALL
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateBall(Hash)
    if LoadModel(Hash) then
        if DoesEntityExist(Ball) then
            DeleteEntity(Ball)
        end
        
        local Random = math.random(#BallCoords)
        Ball = CreateObject(Hash,BallCoords[Random]["x"],BallCoords[Random]["y"],BallCoords[Random]["z"],false,false,false)
        SetEntityAsMissionEntity(Ball,true,true)
        FreezeEntityPosition(Ball,true)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEBALL
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler('AimLabs',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if Value then
        SetEntityCoords(Ped,StartBallCoords)
        Wait(100)
        TriggerEvent("hoverfy:removeHoverfy")
        Wait(100)
        TriggerEvent("hud:Active",false)
        
        SendNUIMessage({
            action = 'router',
            data = {
                path = "/AimLabs"
            }
        })
        
        Wait(10)
        
        SendNUIMessage({
            action = 'setVisible',
            data = true
        })
        
        SendNUIMessage({
            action = 'aimLabsScore',
            data = { 
                initRound = true,
                buttons = { 
                    enter = {
                        text = "SAIR",
                        control = "E"
                    },
                },
                score = PlayerScore
            }
        })
        FreezeEntityPosition(Ped,true)
        Wait(10000)
        FreezeEntityPosition(Ped,false)
        Wait(1000)
        CreateBall("v_ilev_exball_grey")
        InAimLabs = true
        
        CreateThread(function()
            Wait(10000)
            while InAimLabs do
                if IsControlJustPressed(0,38) then
                    SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
                    InAimLabs = false
                    vSERVER.ExitAimLabs(PlayerScore)
                    SetEntityCoords(Ped,LastCoord)
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
                    TriggerEvent("hud:Active",true)
                    PlayerScore = { 
                        points = 0,
                        time = "00:00",
                        timer = 240
                    }
                    break
                end
                Wait(5) 
            end
        end)
        CreateThread(function()
            while InAimLabs do
                PlayerScore["timer"] = PlayerScore["timer"] - 1
                PlayerScore["time"] = SecondsToMinutes(PlayerScore["timer"])
                SendNUIMessage({
                    action = 'aimLabsScore',
                    data = { 
                        initRound = false,
                        buttons = { 
                            enter = {
                                text = "SAIR",
                                control = "E"
                            },
                        },
                        score = PlayerScore
                    }
                })
                SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),250)
                if PlayerScore["timer"] <= 0 then
                    vSERVER.ExitAimLabs(PlayerScore)
                    PlayerScore = { 
                        points = 0,
                        time = "00:00",
                        timer = 240
                    }
                    break
                end
                Wait(1000) 
            end
        end)
    end
end)

AddStateBagChangeHandler('PVP',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    Wait(100)
    if Value then
        SetRunSprintMultiplierForPlayer(Player,1.40)
        PVP = true
        CreateThread(function()
            local Ped = PlayerPedId()
            while PVP do
                local Health = parseInt(GetEntityHealth(Ped))
                SendNUIMessage({
                    action = 'UpdateHealth',
                    data = Health
                })
                Wait(250)
            end
        end)
        CreateThread(function()
            while PVP do
                SetPedInfiniteAmmoClip(Ped, true)
                TriggerEvent("hud:Active",false)
                Wait(250)
            end
        end)
        TriggerEvent("hud:Active",false)
        TriggerEvent("Notify:Remkey",true)
        TriggerEvent("safezone:remPromo",true)
        
    else
        PVP = false
        SetPedInfiniteAmmoClip(Ped, false)
        SetRunSprintMultiplierForPlayer(Player,1.0)
        Wait(500)
        TriggerEvent("Notify:Remkey",false)
        TriggerEvent("safezone:remPromo",false)
        TriggerEvent("hud:Active",true)
    end
end)

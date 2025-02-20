Player = GetPlayerServerId(PlayerId())
local lastCoord
local StartCoords = {
    vector3(-1607.73,-1028.09,13.09),
}

CreateThread(function()
    local Table = {}

    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i].x,
            StartCoords[i].y,
            StartCoords[i].z,
            2.5,
            "E",
            "Entrar no Rolamento",
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
                if IsControlJustPressed(0,38) and not LocalPlayer["state"]["Newbie"] then
                    vSERVER.StartAimNPC()
                    lastCoord = Coords
                end
            end
        end
        Wait(idle)
    end
end)

local Teleport = vector3(-4972.21,-1077.52,630.86)

local PedSpawn = {
    vector3(-4968.67,-1062.64,630.86),
    vector3(-4973.12,-1063.43,630.86),
    vector3(-4974.1,-1058.57,630.86),
    vector3(-4978.48,-1057.01,630.86),
    vector3(-4978.36,-1059.61,630.86),
    vector3(-4975.35,-1061.96,630.86),
    vector3(-4971.79,-1062.9,630.86),
    vector3(-4968.17,-1063.31,630.86),
    vector3(-4973.85,-1058.29,630.86),
    vector3(-4977.86,-1058.45,630.86),
    vector3(-4981.83,-1058.0,630.86),
    vector3(-4984.35,-1058.76,630.86),
    vector3(-4985.76,-1061.4,630.86),
    vector3(-4982.92,-1062.72,630.86),
    vector3(-4980.39,-1060.33,630.86),
    vector3(-4977.7,-1062.25,630.86),
    vector3(-4975.54,-1060.82,630.86),
    vector3(-4973.01,-1062.8,630.86),
    vector3(-4969.96,-1060.81,630.86),
    vector3(-4966.31,-1062.4,630.86),
    vector3(-4964.08,-1061.03,630.86),
    vector3(-4960.98,-1061.88,630.86),
    vector3(-4980.13,-1060.93,630.86)
}

local PlayerScore = { 
    points = 0,
    headshots = 0,
    time = "00:00",
    timer = 240
}

local shooted = false
local NPC = false
local NPCModel = `mp_m_freemode_01`
local selectedAnim
local Dict = "move_strafe@roll_fps"
local PedSpeed = 2.0
local StateNPC = false

local Anims = {
    "combatroll_bwd_p1_135",
    "combatroll_bwd_p1_180",
    "combatroll_bwd_p1_135",
    "combatroll_fwd_p1_00",
    "combatroll_fwd_p1_135",
    "combatroll_fwd_p1_45",
    "combatroll_fwd_p1_90"
}

function StartAimNPC()
    local Ped = PlayerPedId()
    RequestModel(NPCModel)

    while not HasModelLoaded(NPCModel) do
        Wait(1)
    end

    RequestAnimDict(Dict)

    while not HasAnimDictLoaded(Dict) do 
        Wait(10) 
    end

    SpawnNPC()
end

function SpawnNPC()
    if NPC then
        DeleteEntity(NPC)
        NPC = nil
    end
    local random = math.random(1,#PedSpawn)

    NPC = CreatePed(4,NPCModel,PedSpawn[random],0.0,false,true)
    SetEntityHealth(NPC,102)
    SetBlockingOfNonTemporaryEvents(NPC,true)
    SetEntityVisible(NPC,false,false)
    shooted = false
    StartNPCAnim()
end

function SecondsToMinutes(seconds)
    local minutes = math.floor(seconds / 60)
    local seconds = seconds % 60
    return string.format("%02d:%02d", minutes, seconds)
end

local bones = {
    [31086] = true,
    [39317] = true,
}

AddEventHandler("entityDamaged",function(Entity,Player)
	if Player == PlayerPedId() and Entity == NPC then
        local Bone1,Bone2 = GetPedLastDamageBone(NPC)
        if IsEntityPlayingAnim(NPC,Dict,selectedAnim,3) == 1 then
            if bones[Bone1] or bones[Bone2] then
                shooted = true
                PlayerScore["points"] = PlayerScore["points"] + 10
                PlayerScore["headshots"] = PlayerScore["headshots"] + 1
                return
            else
                shooted = true
                PlayerScore["points"] = PlayerScore["points"] + 1
                return
            end
        end
        shooted = true
	end
end)

function StartNPCAnim()
    local Random
    selectedAnim = Anims[math.random(1,#Anims)]

    while true do
        Random = math.random(1,#PedSpawn)
        local Coords = GetEntityCoords(NPC)
        local Distance = #(Coords - PedSpawn[Random])
        if Distance >= 2.0 and Distance <= 8.0 then
            break
        end

        Wait(0)
    end
    SetEntityVisible(NPC,true,false)
    TaskGoToCoordWhileAimingAtCoord(NPC, PedSpawn[Random], -4973.12,-1076.36,630.86, 10.0, 0, 0.0, 0.0, 0, 0, 0, 0, 0, 0, 0)
    while true do
        local Coords = GetEntityCoords(NPC)

        if #(Coords - PedSpawn[Random]) <= 0.5 or shooted then
            SetEntityHeading(NPC,GetEntityHeading(NPC) + math.random(1,180))
            TaskPlayAnim(NPC,Dict,selectedAnim,8.0,-8.0,-1,0,0, nil,nil,nil)
            local Timer = GetGameTimer() + 900
            while Timer >= GetGameTimer() and not shooted do
                Wait(5)
            end
            SpawnNPC()
            break
        end
        Wait(0)
    end
end

RegisterNetEvent("rolling:Close")
AddEventHandler("rolling:Close",function()
    local Ped = PlayerPedId()
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

    SetEntityCoords(Ped,lastCoord)
    if NPC and DoesEntityExist(NPC) then
        DeleteEntity(NPC)
        NPC = false
    end
    selectedAnim = nil
    StateNPC = false
    lastCoord = nil
    PlayerScore = { 
        points = 0,
        headshots = 0,
        time = "00:00",
        timer = 240
    }
    SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
    RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
    TriggerEvent("hud:Active",true)
end)

AddStateBagChangeHandler('Rolling',('player:%s'):format(Player) , function(_, _, Value)
    if Value then
        local Ped = PlayerPedId()
        TriggerEvent("hud:Active",false)
        SetEntityCoords(Ped,Teleport)
        FreezeEntityPosition(Ped,true)
        
        SendNUIMessage({
            action = 'router',
            data = {
                path = "/AimLabs"
            }
        })
        TriggerEvent("hoverfy:removeHoverfy")
        Wait(10)

        SendNUIMessage({
            action = 'setVisible',
            data = true
        })

        Wait(10)

        SendNUIMessage({
            action = 'aimLabsScore',
            data = { 
                initRound = false,
                buttons = { 
                    enter = {
                        text = "ENTRAR",
                        control = "E"
                    },
                    exit = {
                        text = "SAIR",
                        control = "G"
                    }, 
                },
                score = PlayerScore
            }
        })
        Wait(1)
        while true do
            
            if IsControlJustPressed(0,38) then
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
                Wait(10000)
                FreezeEntityPosition(Ped,false)
                SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
                StateNPC = true
                break
            end

            if IsControlJustPressed(0,47) then
                vSERVER.exitAimNPC(PlayerScore)
                SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
                StateNPC = false
                FreezeEntityPosition(Ped,false)
                break
            end

            Wait(1)
        end


        if not StateNPC then
            return
        end


        CreateThread(function()
            while StateNPC do
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
                if PlayerScore["timer"] <= 0 then
                    vSERVER.exitAimNPC(PlayerScore)
                    SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                    RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                    break
                end
                Wait(1000)
            end
        end)

        CreateThread(function()
            while StateNPC do
                RefillAmmoInstantly(Ped)
                if IsControlJustPressed(0,38) then
                    vSERVER.exitAimNPC(PlayerScore)
                end
                Wait(0)
            end
        end)

        StartAimNPC()
    end
end)
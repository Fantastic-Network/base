-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("admin",Creative)
vSERVER = Tunnel.getInterface("admin")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVISIBLABLES
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]:set("Spectate",false,true)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECORDINGROCKSTAR
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.recordingRockstar()
    if IsRecording() then
        StopRecordingAndSaveClip()
    else
        StartRecording(1)
    end
end

function Creative.GetModelDimensions(models)
    local response = {}
    for i = 1, #models do
        local model = models[i]
        local min, max = GetModelDimensions(model) 
        local size_vec = max - min
        size = size_vec.x + size_vec.y + size_vec.z
        response[model] = size
    end
    return response
end

function Creative.GetCoords()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    return coords
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUPERPOWER
-----------------------------------------------------------------------------------------------------------------------------------------
local jump = false
function Creative.superPower()
    if not jump then
        jump = true
        TriggerEvent("Notify2","#jumpIn")
        while jump do
            SetSuperJumpThisFrame(PlayerId(),1000)
            Wait(0)
        end
    else
        jump = false
        TriggerEvent("Notify2","#jumpOut")
        SetSuperJumpThisFrame(PlayerId(),0)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APAGAO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(15000)
    if GlobalState["Blackout"] and GlobalState["Blackout"] == 1 then
        SetArtificialLightsState(true)
    end
end)

RegisterNetEvent("SetBlackout")
AddEventHandler("SetBlackout", function(cond)
    local status = false
    if cond == 1 then
        status = true
    end
    SetArtificialLightsState(status)
end)

RegisterNetEvent("SetFreeze")
AddEventHandler("SetFreeze", function()
    local Ped = PlayerPedId()
    if IsEntityPositionFrozen(Ped) then
        FreezeEntityPosition(Ped,false)
    else
        FreezeEntityPosition(Ped,true)
    end
end)
RegisterNetEvent("RemFreeze")
AddEventHandler("RemFreeze", function()
    local Ped = PlayerPedId()
    FreezeEntityPosition(Ped,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportWay()
    local Ped = PlayerPedId()
    if IsPedInAnyVehicle(Ped) then
        Ped = GetVehiclePedIsUsing(Ped)
    end

    local waypointBlip = GetFirstBlipInfoId(8)
    local x,y,z = table.unpack(GetBlipInfoIdCoord(waypointBlip,Citizen.ResultAsVector()))

    local ground
    local groundFound = false
    local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

    for i,height in ipairs(groundCheckHeights) do
        SetEntityCoordsNoOffset(Ped,x,y,height,false,false,false)

        RequestCollisionAtCoord(x,y,z)
        while not HasCollisionLoadedAroundEntity(Ped) do
            Wait(1)
        end

        Wait(20)

        ground,z = GetGroundZFor_3dCoord(x,y,height)
        if ground then
            z = z + 1.0
            groundFound = true
            break;
        end
    end

    if not groundFound then
        z = 1200
        GiveDelayedWeaponToPed(Ped,0xFBAB5776,1,0)
    end

    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(Ped) do
        Wait(1)
    end

    SetEntityCoordsNoOffset(Ped,x,y,z,false,false,false)

    return GetEntityCoords(Ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportLimbo()
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    local _,xCoords = GetNthClosestVehicleNode(Coords["x"],Coords["y"],Coords["z"],1,0,0,0)

    SetEntityCoordsNoOffset(Ped,xCoords["x"],xCoords["y"],xCoords["z"] + 1,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:vehicleTuning")
AddEventHandler("admin:vehicleTuning",function()
    local Ped = PlayerPedId()
    if IsPedInAnyVehicle(Ped) then
        local vehicle = GetVehiclePedIsUsing(Ped)

        SetVehicleModKit(vehicle,0)
        SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11) - 1,false)
        SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12) - 1,false)
        SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13) - 1,false)
        SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15) - 1,false)
        ToggleVehicleMod(vehicle,18,true)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			vSERVER.buttonTxt()
-- 		end
-- 		Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONMAKERACE
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			local Ped = PlayerPedId()
-- 			local vehicle = GetVehiclePedIsUsing(Ped)
-- 			local vehCoords = GetEntityCoords(vehicle)
-- 			local leftCoords = GetOffsetFromEntityInWorldCoords(vehicle,5.0,0.0,0.0)
-- 			local rightCoords = GetOffsetFromEntityInWorldCoords(vehicle,-5.0,0.0,0.0)

-- 			vSERVER.raceCoords(vehCoords,leftCoords,rightCoords)
-- 		end

-- 		Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:INITSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetAimRotation(player)
    local entity = GetPlayerPed(player)
    local success, target = GetEntityPlayerIsFreeAimingAt(PlayerId())

    if success and target == entity then
        -- Get the target entity's rotation
        local rotation = GetEntityRotation(target)

        -- Calculate the yaw, pitch, and roll angles from the rotation
        local yaw = rotation.z
        local pitch = rotation.x
        local roll = rotation.y

        -- Return the rotation angles
        return yaw, pitch, roll
    end

    -- If the player is not aiming at the entity, return nil
    return nil
end


RegisterNetEvent("admin:initSpectate")
AddEventHandler("admin:initSpectate",function(source)
    if not NetworkIsInSpectatorMode() then
        local Pid = GetPlayerFromServerId(source)
        local Ped = GetPlayerPed(Pid)

        LocalPlayer["state"]:set("Spectate",true,true)
        NetworkSetInSpectatorMode(true,Ped)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:resetSpectate")
AddEventHandler("admin:resetSpectate",function()
    if NetworkIsInSpectatorMode() then
        NetworkSetInSpectatorMode(false)
        LocalPlayer["state"]:set("Spectate",false,true)
    end
end)

AddStateBagChangeHandler("Quake",nil,function(Name,Key,Value)
    ShakeGameplayCam("SKY_DIVING_SHAKE",0.0)
end)

local enable = false
local aPed =  false
local FF = false
function openWeaponWheel()
    if enable then
        aPed = not aPed
    end
end
RegisterCommand("+useless",openWeaponWheel)
RegisterCommand("-useless",openWeaponWheel)
RegisterKeyMapping("+useless","Useless","MOUSE_BUTTONANY","MOUSE_EXTRABTN5")
local Friends = {}
function Creative.spawnPeds(Spawn,Boolean)
    FF = Boolean or false
    enable = not enable
    local FOV = 60
    if Spawn then
        FOV = Spawn
    end
    local Ped = PlayerPedId()
    local Player = PlayerId()
    while true do
        if enable then
            local Distance = 425
            local Peds = GetGamePool('CPed')
            local Coords = GetEntityCoords(Ped)
            local ped
            local resX,resY = GetActiveScreenResolution()

            for i = 1, #Peds do
                if Ped ~= Peds[i] and IsEntityVisible(Peds[i]) then
                    if IsPedAPlayer(Peds[i]) and HasEntityClearLosToEntity(Ped,Peds[i],17) then
                        local Source = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Peds[i])))
                        if Friends[tostring(Source)] then
                            goto Next
                        end
                        if GetEntityHealth(Peds[i]) > 100 and IsEntityOnScreen(Peds[i]) then
                            local PedCoords = GetEntityCoords(Peds[i])
                            local PedDistance = #(Coords - PedCoords)
                            local MinDistance = PedDistance <= 425
                            if MinDistance and PedDistance < Distance then
                                local boneCDS = GetPedBoneCoords(Peds[i], 31086)
                                local _, x, y = GetScreenCoordFromWorldCoord(boneCDS["x"],boneCDS["y"],boneCDS["z"])
                                if inFOV(x,y,resX,resY,FOV) then
                                    Distance = PedDistance
                                    ped = Peds[i]
                                end
                            end
                        end
                    end
                end
                ::Next::
            end
            
            if IsAimCamActive() and aPed then
                local c = GetPedBoneCoords(ped, 31086)
                local _, _x, _y = GetScreenCoordFromWorldCoord(c["x"],c["y"],c["z"])
                local selfpos, rot = GetFinalRenderedCamCoord(), GetEntityRotation(Ped, 2)
                local angleX, angleY, angleZ = (c - selfpos).x, (c - selfpos).y, (c - selfpos).z
                local roll, pitch, yaw = -math.deg(math.atan2(angleX, angleY)) - rot.z, math.deg(math.atan2(angleZ+0.08, #vector3(angleX, angleY, 0.0))), 1.0
                roll = 0.0+(roll-0.0)*(1.0)
                if inFOV(_x,_y,resX,resY,FOV) then
                    SetGameplayCamRelativeRotation(roll, pitch, yaw)
                end
            end
        else
            break
        end
        Wait(1)
    end
end

function inFOV(_x,_y,resX,resY,FOV)
    if (_x > 0.5 - ((FOV / 2)/resX) and _x < 0.5 + ((FOV / 2)/resX) and _y > 0.5 - ((FOV / 2)/resY) and _y < 0.5 + ((FOV / 2)/resY)) then
        return true
    end
    return false
end


CreateThread(function()
    RegisterFontFile('Poppins')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z,distance)
    ClearAreaOfVehicles(x,y,z,distance + 0.0,false,false,false,false,false)
    ClearAreaOfEverything(x,y,z,distance + 0.0,false,false,false,false)
end)



RegisterNetEvent("admin:AddFriends")
AddEventHandler("admin:AddFriends",function(Table)
    Friends = Table
end)

local banMode = "ADV"
RegisterNetEvent("admin:OpenBanMenu")
AddEventHandler("admin:OpenBanMenu",function(mode,Passport)
    banMode = mode
    SendNUIMessage({
        action = "setMode",
        data = {
            title = banConfig[mode]["Heading"],
            info = banConfig[mode]["Info"],
            button = banConfig[mode]["Button"],
            passport = Passport
        }
    })
    Wait(100)
    SendNUIMessage({
        action = "setVisible",
        data = true
    })
    SetNuiFocus(true,true)
end)


RegisterNUICallback("UserBan",function(data,cb)
    local time = parseInt(data["time"])
    if data["time"] == "" then
        time = 1
    end
    local text = banConfig[banMode]["Info"][time]["name"]
    vSERVER.applyBan(parseInt(data["id"]),data["reason"],banConfig[banMode]["Info"][time]["value"],banMode,text)
    Wait(50)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
    SetNuiFocus(false,false)
end)


RegisterNUICallback('hideFrame', function(_, cb)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
    SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SANGUE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sangue",function(source,args)
    local ped = PlayerPedId()
    ClearPedBloodDamage(ped)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PISCAR GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:Piscar")
AddEventHandler("admin:Piscar",function()
    LocalPlayer["state"]["Invisible"] = true
    SetEntityVisible(PlayerPedId(),false,false)

    SetTimeout(1000,function()
        SetEntityVisible(PlayerPedId(),true,false)
        LocalPlayer["state"]["Invisible"] = false
    end)
end)

RegisterNetEvent("admin:Mute")
AddEventHandler("admin:Mute",function(Mute)
    local Ped = PlayerPedId()
    if Mute then
        exports['pma-voice']:overrideProximityCheck(function(player)
            return false
        end)
        Entity(Ped)["state"]:set("Muted",true,true)
    else
        exports['pma-voice']:resetProximityCheck()
        Entity(Ped)["state"]:set("Muted",false,true)
    end
end)
------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
------------------------------------------------------------------------------------------------------------------------------
local dickheaddebug = false
local inFreeze = false
RegisterNetEvent("ToggleDebug")
AddEventHandler("ToggleDebug",function()
    dickheaddebug = not dickheaddebug
    if dickheaddebug then
        TriggerEvent("chatMessage","DEBUG",{255,0,0},"ON")
    else
        TriggerEvent("chatMessage","DEBUG",{255,0,0},"OFF")
    end
    CreateThread(function()
        while dickheaddebug do
            local idle = 1
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            
            local forPos = GetOffsetFromEntityInWorldCoords(ped,0,1.0,0.0)
            local backPos = GetOffsetFromEntityInWorldCoords(ped,0,-1.0,0.0)
            local LPos = GetOffsetFromEntityInWorldCoords(ped,1.0,0.0,0.0)
            local RPos = GetOffsetFromEntityInWorldCoords(ped,-1.0,0.0,0.0)
            
            local forPos2 = GetOffsetFromEntityInWorldCoords(ped,0,2.0,0.0)
            local backPos2 = GetOffsetFromEntityInWorldCoords(ped,0,-2.0,0.0)
            local LPos2 = GetOffsetFromEntityInWorldCoords(ped,2.0,0.0,0.0)
            local RPos2 = GetOffsetFromEntityInWorldCoords(ped,-2.0,0.0,0.0)
            
            local x, y, z = table.unpack(GetEntityCoords(ped,true))
            local currentStreetHash,intersectStreetHash = GetStreetNameAtCoord(x,y,z,currentStreetHash,intersectStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
            
            drawTxtS(0.8, 0.50, 0.4,0.4,0.30, "~g~HEADING: ~r~"..GetEntityHeading(ped))
            drawTxtS(0.8, 0.52, 0.4,0.4,0.30, "~g~COORDS: ~r~"..pos)
            drawTxtS(0.8, 0.54, 0.4,0.4,0.30, "~g~ATTACHED ENT: ~r~"..GetEntityAttachedTo(ped))
            drawTxtS(0.8, 0.56, 0.4,0.4,0.30, "~g~HEALTH: ~r~"..GetEntityHealth(ped))
            drawTxtS(0.8, 0.58, 0.4,0.4,0.30, "~g~H a G: ~r~"..GetEntityHeightAboveGround(ped))
            drawTxtS(0.8, 0.60, 0.4,0.4,0.30, "~g~HASH: ~r~"..GetEntityModel(ped))
            drawTxtS(0.8, 0.62, 0.4,0.4,0.30, "~g~SPEED: ~r~"..GetEntitySpeed(ped))
            drawTxtS(0.8, 0.64, 0.4,0.4,0.30, "~g~FRAME TIME: ~r~"..GetFrameTime())
            drawTxtS(0.8, 0.66, 0.4,0.4,0.30, "~g~STREET: ~r~"..currentStreetName)
            
            DrawLine(pos,forPos,255,0,0,115)
            DrawLine(pos,backPos,255,0,0,115)
            
            DrawLine(pos,LPos,255,255,0,115)
            DrawLine(pos,RPos,255,255,0,115)
            
            DrawLine(forPos,forPos2,255,0,255,115)
            DrawLine(backPos,backPos2,255,0,255,115)
            
            DrawLine(LPos,LPos2,255,255,255,115)
            DrawLine(RPos,RPos2,255,255,255,115)
            
            local nearped = getNPC()
            local veh = GetVehicle()
            local nearobj = GetObject()
            if IsControlJustReleased(0,38) and IsInputDisabled(0) then
                if inFreeze then
                    inFreeze = false
                    TriggerEvent("Notify2","#freezeIn")
                else
                    inFreeze = true
                    TriggerEvent("Notify2","#freezeOut")
                end
            end
            Wait(Idle)
        end
    end)
end)

function GetVehicle()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords,pos,true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
            FreezeEntityPosition(ped, inFreeze)
            if IsEntityTouchingEntity(playerped,ped) then
                DrawText3Ds(pos["x"],pos["y"],pos["z"]+1,"~g~VEHICLE: ~w~"..ped.." ~g~HASH: ~w~"..GetEntityModel(ped).." ~r~IN CONTACT",350)
            else
                DrawText3Ds(pos["x"],pos["y"],pos["z"]+1,"~g~VEHICLE: ~w~"..ped.." ~g~HASH: ~w~"..GetEntityModel(ped).."",350)
            end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords,pos,true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            FreezeEntityPosition(ped,inFreeze)
            if IsEntityTouchingEntity(playerped,ped) then
                DrawText3Ds(pos["x"],pos["y"],pos["z"]+1,"~g~OBJECT: ~w~"..ped.." ~g~HASH: ~w~"..GetEntityModel(ped).." ~r~IN CONTACT",350)
            else
                DrawText3Ds(pos["x"],pos["y"],pos["z"]+1,"~g~OBJECT: ~w~"..ped.." ~g~HASH: ~w~"..GetEntityModel(ped).."",350)
            end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords,pos,true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
            
            if IsEntityTouchingEntity(playerped,ped) then
                DrawText3Ds(pos["x"],pos["y"],pos["z"],"~g~PED: ~w~"..ped.." ~g~HASH: ~w~"..GetEntityModel(ped).." ~g~RELATIONSHIP HASH: ~w~"..GetPedRelationshipGroupHash(ped).." ~r~IN CONTACT",350)
            else
                DrawText3Ds(pos["x"],pos["y"],pos["z"],"~g~PED: ~w~"..ped.." ~g~HASH: ~w~"..GetEntityModel(ped).." ~g~RELATIONSHIP HASH: ~w~"..GetPedRelationshipGroupHash(ped),350)
            end
            
            FreezeEntityPosition(ped,inFreeze)
        end
        success,ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == PlayerPedId() then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

function drawTxtS(x,y,width,height,scale,text)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25,0.25)
    SetTextDropShadow(0,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x-width/2,y-height/3)
end

function DrawText3Ds(x,y,z,text,size)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    SetTextFont(4)
    SetTextScale(0.35,0.35)
    SetTextColour(255,255,255,150)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text))/size
    DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

local StateBlips = false
PlayersBlips = {}

local players = {}
local updateEventCookie = nil
local lastUpdate = 0
local elapsedTime = 0

local function RemoveBlips()
    for _,Info in pairs(players) do
        RemoveBlip(Info["blip"])
    end
    players = {}
    lastUpdate = 0
    elapsedTime = 0
    StateBlips = false
end

local function CreatePlayerBlip(serverId, coords, number)
    local blip = AddBlipForCoord(coords.x, coords.y, 0.0)

    SetBlipSprite(blip,1)
    SetBlipAsShortRange(blip,true)
    SetBlipColour(blip,GetBlipColor(number))
    SetBlipScale(blip,0.7)

    players[serverId] = { blip = blip, start = coords, current = coords, destination = coords }
end

local function UpdatePlayerBlip(serverId, coords)
    local player = players[serverId]
    player.destination = coords
    player.start = player.current
end

local function UpdatePlayersCoords(playersCoords)
    local gameTimer = GetGameTimer()
    elapsedTime = gameTimer - lastUpdate
    lastUpdate = gameTimer
    local Done = {}
    for serverId, Info in pairs(playersCoords) do
        local serverId = tostring(serverId)
        local Coords = vector3(Info[1][1],Info[1][2],0.0)
        if players[serverId] then
            UpdatePlayerBlip(serverId, Coords, Info[2])
            Done[serverId] = true
        else
            Done[serverId] = true
            CreatePlayerBlip(serverId, Coords, Info[2])
        end
    end
    for serverId, Info in pairs(players) do
        if not Done[serverId] then
            UpdatePlayerBlip(serverId, Info.current)
        end
    end
end

function PlayersBlips:start()
    
end

function PlayersBlips:tick()
    local gameTimer = GetGameTimer()
    local timeFactor = Clamp((gameTimer - lastUpdate) / elapsedTime, 0, 1)

    for _, player in pairs(players) do
        local x = Lerp(player.start.x, player.destination.x, timeFactor)
        local y = Lerp(player.start.y, player.destination.y, timeFactor)

        player.current = vector3(x, y, player.current.z)

        SetBlipCoords(player.blip, player.current)
    end
end

function GetPlayers2()
	local Selected = {}
    local Peds = GetGamePool("CPed")
    for i=1,#Peds do
        local SelectedPed = Peds[i]
        if IsPedAPlayer(SelectedPed) then
            local Coords = GetEntityCoords(SelectedPed)
            local Player = NetworkGetPlayerIndexFromPed(SelectedPed)
            local serverId = tostring(GetPlayerServerId(Player))
            if players[serverId] then
                UpdatePlayerBlip(serverId, Coords)
            end
        end
    end
	return Selected
end

CreateThread(function()
    updateEventCookie = RegisterNetEvent("Blips:Update", UpdatePlayersCoords)
end)

RegisterNetEvent("Admin:Blips",function(Boolean)
    if Boolean then
        PlayersBlips:start()
        StateBlips = true
        CreateThread(function()
            while StateBlips do
                Wait(250)
                PlayersBlips:tick()
            end
        end)
        CreateThread(function()
            while StateBlips do
                GetPlayers2()
                Wait(250)
            end
        end)
    else
        RemoveBlips()
    end
end)

RegisterNetEvent("Blips:Disconnect",function(serverId)
    if players[tostring(serverId)] then
        RemoveBlip(players[tostring(serverId)]["blip"])
        players[tostring(serverId)] = nil
    end
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)
RegisterNetEvent("admin:Teleport")
AddEventHandler("admin:Teleport",function(Coords,Spawn)
    local Ped = PlayerPedId()
    if Ped then
        SetEntityCoords(Ped,Coords.x + 0.0001,Coords.y + 0.0001,Coords.z + 0.0001,false,false,false,false)
        if Spawn then
            local Timer = GetGameTimer() + 5000
            while Timer > GetGameTimer() do
                Wait(1)
                FreezeEntityPosition(Ped,true)
            end
            FreezeEntityPosition(Ped,false)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONMAKERACE
-----------------------------------------------------------------------------------------------------------------------------------------
local CustomBlips = {}
RegisterNetEvent("blips:LoadBlips")
AddEventHandler("blips:LoadBlips",function(Table)
    for k,v in pairs(Table) do
        local Coords = toVector3(v["coordinates"])
        local blip = AddBlipForCoord(Coords)
        SetBlipSprite(blip,v["blip_id"])
        SetBlipColour(blip,v["color"])
        SetBlipAsShortRange(blip,true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v["name"])
        EndTextCommandSetBlipName(blip)
        CustomBlips[v["id"]] = blip
    end
end)

RegisterNetEvent("blips:NewBlip")
AddEventHandler("blips:NewBlip",function(Table)
    local Coords = toVector3(Table["coordinates"])
    local blip = AddBlipForCoord(Coords)
    SetBlipSprite(blip,Table["blip_id"])
    SetBlipColour(blip,Table["color"])
    SetBlipAsShortRange(blip,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Table["name"])
    EndTextCommandSetBlipName(blip)
    CustomBlips[Table["id"]] = blip
end)

RegisterNetEvent("blips:RemoveBlip")
AddEventHandler("blips:RemoveBlip",function(id)
    if CustomBlips[id] then
        RemoveBlip(CustomBlips[id])
        CustomBlips[id] = nil
    end
end)

RegisterNetEvent("blips:UpdateBlip")
AddEventHandler("blips:UpdateBlip",function(Table)
    if CustomBlips[Table["id"]] then
        RemoveBlip(CustomBlips[Table["id"]])
        local Coords = toVector3(Table["coordinates"])
        local blip = AddBlipForCoord(Coords)
        SetBlipSprite(blip,Table["blip_id"])
        SetBlipColour(blip,Table["color"])
        SetBlipAsShortRange(blip,true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Table["name"])
        EndTextCommandSetBlipName(blip)
        CustomBlips[Table["id"]] = blip
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RGBC
-----------------------------------------------------------------------------------------------------------------------------------------
local isRGB = false
RegisterNetEvent("admin:RGB")
AddEventHandler("admin:RGB",function()
    isRGB = not isRGB
    CreateThread(function()
        while isRGB do
            Wait(10)
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
                ChangeCarColorRainbow(vehicle)
            end
        end
    end)
end)

function ChangeCarColorRainbow(vehicle)
    local currentTime = GetGameTimer()
    local hue = (currentTime % 30000) / 30000.0
    local r, g, b = HSVToRGB(hue, 1, 1)
    SetVehicleCustomPrimaryColour(vehicle, r, g, b)
    SetVehicleCustomSecondaryColour(vehicle, r, g, b)
end

function HSVToRGB(h, s, v)
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    if i % 6 == 0 then
        r, g, b = v, t, p
    elseif i % 6 == 1 then
        r, g, b = q, v, p
    elseif i % 6 == 2 then
        r, g, b = p, v, t
    elseif i % 6 == 3 then
        r, g, b = p, q, v
    elseif i % 6 == 4 then
        r, g, b = t, p, v
    else
        r, g, b = v, p, q
    end

    return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPUNCH/PUNCH
-----------------------------------------------------------------------------------------------------------------------------------------
function RotationToDirection(Rotation)
    local X = math.rad(Rotation.x)
    local Z = math.rad(Rotation.z)
    local AbsCosX = math.abs(math.cos(X))
    return vector3(-math.sin(Z) * AbsCosX, math.cos(Z) * AbsCosX, math.sin(X))
end

local Punch = false
local PunchForce
RegisterNetEvent("admin:Punch")
AddEventHandler("admin:Punch",function(Force)
    Punch = not Punch
    PunchForce = Force
end)


local SuperPunch = false
local SForce = 0
local sDistance = 0
RegisterNetEvent("admin:SPunch")
AddEventHandler("admin:SPunch",function(Force,Distance)
    SuperPunch = not SuperPunch
    SForce = Force
    sDistance = Distance or 10
end)

function SPunch(Spawn)
    if SuperPunch then
        local Vehicle = vRP.ClosestVehicle(sDistance)
        if IsEntityAVehicle(Vehicle) then
            local Rotation = GetGameplayCamRot()
            local Direction = RotationToDirection(Rotation)
            TriggerServerEvent("admin:PunchAdd",VehToNet(Vehicle),Direction,SForce)
        end
    end
end

RegisterCommand("5562",SPunch)
RegisterKeyMapping("5562","Spunch","MOUSE_BUTTONANY","MOUSE_EXTRABTN5")
AddEventHandler('gameEventTriggered', function(event, data)
	if event == 'CEventNetworkEntityDamage' and Punch then
        local Ped = PlayerPedId()
        local Entity, Attacker, Died, Weapon = data[1], data[2], data[4], data[7]
        if IsEntityAVehicle(Entity) and Weapon == `WEAPON_UNARMED` and Attacker == Ped then
            local Rotation = GetGameplayCamRot()
            local Direction = RotationToDirection(Rotation)
            TriggerServerEvent("admin:PunchAdd",VehToNet(Entity),Direction,PunchForce)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:neymar")
AddEventHandler("admin:neymar",function(ForwardVectorX,ForwardVectorY,ForwardVectorZ,Tackler)
    SetPedCanRagdoll(PlayerPedId(), true)
    SetPedToRagdollWithFall(PlayerPedId(),1500,2000,0,ForwardVector,1.0,0.0,0.0,0.0,0.0,0.0,0.0)
    Wait(35000)
    SetPedCanRagdoll(PlayerPedId(), false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GODMODE
-----------------------------------------------------------------------------------------------------------------------------------------
local GodMode = false
RegisterNetEvent("admin:GodMode")
AddEventHandler("admin:GodMode",function()
    GodMode = not GodMode
    LocalPlayer["state"]["Invincible"] = GodMode

    local Msg = GodMode and "ativado" or "desativado"
    local MsgType = GodMode and "verde" or "vermelho"
    if GodMode then
        TriggerEvent("Notify2","#godModeIn",{ Msg = Msg })
    else
        TriggerEvent("Notify2","#godModeOut",{ Msg = Msg })
    end

    local Ped = PlayerPedId()
    while GodMode do
        Wait(3000)
        SetEntityInvincible(Ped,GodMode)
    end
end)

-- CreateThread(function() 
--     while true do
--         GetSoundId()
--         Wait(1000)
--     end
-- end)

local bullying = false
RegisterNetEvent("admin:bullying2")
AddEventHandler("admin:bullying2", function(boolean)
    bullying = boolean
    CreateThread(function()
        while bullying do
            local Ped = PlayerPedId()
            if IsPedRunning(Ped) and not IsPedRagdoll(Ped) then
                TriggerServerEvent("admin:Bullying")
            end
            Wait(100)
        end
    end)
end)


function Creative.SelectedWeapon()
    local Ped = PlayerPedId()
    local Selected = GetSelectedPedWeapon(Ped)
    return Selected
end

local PickUpList = {
    `PICKUP_WEAPON_BULLPUPSHOTGUN`,
    `PICKUP_WEAPON_ASSAULTSMG`,
    `PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,
    `PICKUP_WEAPON_PISTOL50`,
    `PICKUP_VEHICLE_WEAPON_PISTOL50`,
    `PICKUP_AMMO_BULLET_MP`,
    `PICKUP_AMMO_MISSILE_MP`,
    `PICKUP_AMMO_GRENADELAUNCHER_MP`,
    `PICKUP_WEAPON_ASSAULTRIFLE`,
    `PICKUP_WEAPON_CARBINERIFLE`,
    `PICKUP_WEAPON_ADVANCEDRIFLE`,
    `PICKUP_WEAPON_MG`,
    `PICKUP_WEAPON_COMBATMG`,
    `PICKUP_WEAPON_SNIPERRIFLE`,
    `PICKUP_WEAPON_HEAVYSNIPER`,
    `PICKUP_WEAPON_MICROSMG`,
    `PICKUP_WEAPON_SMG`,
    `PICKUP_ARMOUR_STANDARD`,
    `PICKUP_WEAPON_RPG`,
    `PICKUP_WEAPON_MINIGUN`,
    `PICKUP_HEALTH_STANDARD`,
    `PICKUP_WEAPON_PUMPSHOTGUN`,
    `PICKUP_WEAPON_SAWNOFFSHOTGUN`,
    `PICKUP_WEAPON_ASSAULTSHOTGUN`,
    `PICKUP_WEAPON_GRENADE`,
    `PICKUP_WEAPON_MOLOTOV`,
    `PICKUP_WEAPON_SMOKEGRENADE`,
    `PICKUP_WEAPON_STICKYBOMB`,
    `PICKUP_WEAPON_PISTOL`,
    `PICKUP_WEAPON_COMBATPISTOL`,
    `PICKUP_WEAPON_APPISTOL`,
    `PICKUP_WEAPON_GRENADELAUNCHER`,
    `PICKUP_MONEY_VARIABLE`,
    `PICKUP_GANG_ATTACK_MONEY`,
    `PICKUP_WEAPON_STUNGUN`,
    `PICKUP_WEAPON_PETROLCAN`,
    `PICKUP_WEAPON_KNIFE`,
    `PICKUP_WEAPON_NIGHTSTICK`,
    `PICKUP_WEAPON_HAMMER`,
    `PICKUP_WEAPON_BAT`,
    `PICKUP_WEAPON_GolfClub`,
    `PICKUP_WEAPON_CROWBAR`,
    `PICKUP_CUSTOM_SCRIPT`,
    `PICKUP_CAMERA`,
    `PICKUP_PORTABLE_PACKAGE`,
    `PICKUP_PORTABLE_CRATE_UNFIXED`,
    `PICKUP_PORTABLE_PACKAGE_LARGE_RADIUS`,
    `PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,
    `PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS`,
    `PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS_UPRIGHT`,
    `PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS`,
    `PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS`,
    `PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL`,
    `PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,
    `PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,
    `PICKUP_MONEY_CASE`,
    `PICKUP_MONEY_WALLET`,
    `PICKUP_MONEY_PURSE`,
    `PICKUP_MONEY_DEP_BAG`,
    `PICKUP_MONEY_MED_BAG`,
    `PICKUP_MONEY_PAPER_BAG`,
    `PICKUP_MONEY_SECURITY_CASE`,
    `PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,
    `PICKUP_VEHICLE_WEAPON_APPISTOL`,
    `PICKUP_VEHICLE_WEAPON_PISTOL`,
    `PICKUP_VEHICLE_WEAPON_GRENADE`,
    `PICKUP_VEHICLE_WEAPON_MOLOTOV`,
    `PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,
    `PICKUP_VEHICLE_WEAPON_STICKYBOMB`,
    `PICKUP_VEHICLE_HEALTH_STANDARD`,
    `PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,
    `PICKUP_VEHICLE_ARMOUR_STANDARD`,
    `PICKUP_VEHICLE_WEAPON_MICROSMG`,
    `PICKUP_VEHICLE_WEAPON_SMG`,
    `PICKUP_VEHICLE_WEAPON_SAWNOFF`,
    `PICKUP_VEHICLE_CUSTOM_SCRIPT`,
    `PICKUP_VEHICLE_CUSTOM_SCRIPT_NO_ROTATE`,
    `PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,
    `PICKUP_VEHICLE_MONEY_VARIABLE`,
    `PICKUP_SUBMARINE`,
    `PICKUP_HEALTH_SNACK`,
    `PICKUP_PARACHUTE`,
    `PICKUP_AMMO_PISTOL`,
    `PICKUP_AMMO_SMG`,
    `PICKUP_AMMO_RIFLE`,
    `PICKUP_AMMO_MG`,
    `PICKUP_AMMO_SHOTGUN`,
    `PICKUP_AMMO_SNIPER`,
    `PICKUP_AMMO_GRENADELAUNCHER`,
    `PICKUP_AMMO_RPG`,
    `PICKUP_AMMO_MINIGUN`,
    `PICKUP_WEAPON_BOTTLE`,
    `PICKUP_WEAPON_SNSPISTOL`,
    `PICKUP_WEAPON_HEAVYPISTOL`,
    `PICKUP_WEAPON_SPECIALCARBINE`,
    `PICKUP_WEAPON_BULLPUPRIFLE`,
    `PICKUP_WEAPON_RAYPISTOL`,
    `PICKUP_WEAPON_RAYCARBINE`,
    `PICKUP_WEAPON_RAYMINIGUN`,
    `PICKUP_WEAPON_BULLPUPRIFLE_MK2`,
    `PICKUP_WEAPON_DOUBLEACTION`,
    `PICKUP_WEAPON_MARKSMANRIFLE_MK2`,
    `PICKUP_WEAPON_PUMPSHOTGUN_MK2`,
    `PICKUP_WEAPON_REVOLVER_MK2`,
    `PICKUP_WEAPON_SNSPISTOL_MK2`,
    `PICKUP_WEAPON_SPECIALCARBINE_MK2`,
    `PICKUP_WEAPON_PROXMINE`,
    `PICKUP_WEAPON_HOMINGLAUNCHER`,
    `PICKUP_AMMO_HOMINGLAUNCHER`,
    `PICKUP_WEAPON_GUSENBERG`,
    `PICKUP_WEAPON_DAGGER`,
    `PICKUP_WEAPON_VINTAGEPISTOL`,
    `PICKUP_WEAPON_FIREWORK`,
    `PICKUP_WEAPON_MUSKET`,
    `PICKUP_AMMO_FIREWORK`,
    `PICKUP_AMMO_FIREWORK_MP`,
    `PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,
    `PICKUP_WEAPON_HATCHET`,
    `PICKUP_WEAPON_RAILGUN`,
    `PICKUP_WEAPON_HEAVYSHOTGUN`,
    `PICKUP_WEAPON_MARKSMANRIFLE`,
    `PICKUP_WEAPON_CERAMICPISTOL`,
    `PICKUP_WEAPON_HAZARDCAN`,
    `PICKUP_WEAPON_NAVYREVOLVER`,
    `PICKUP_WEAPON_COMBATSHOTGUN`,
    `PICKUP_WEAPON_GADGETPISTOL`,
    `PICKUP_WEAPON_MILITARYRIFLE`,
    `PICKUP_WEAPON_FLAREGUN`,
    `PICKUP_AMMO_FLAREGUN`,
    `PICKUP_WEAPON_KNUCKLE`,
    `PICKUP_WEAPON_MARKSMANPISTOL`,
    `PICKUP_WEAPON_COMBATPDW`,
    `PICKUP_PORTABLE_CRATE_FIXED_INCAR`,
    `PICKUP_WEAPON_COMPACTRIFLE`,
    `PICKUP_WEAPON_DBSHOTGUN`,
    `PICKUP_WEAPON_MACHETE`,
    `PICKUP_WEAPON_MACHINEPISTOL`,
    `PICKUP_WEAPON_FLASHLIGHT`,
    `PICKUP_WEAPON_REVOLVER`,
    `PICKUP_WEAPON_SWITCHBLADE`,
    `PICKUP_WEAPON_AUTOSHOTGUN`,
    `PICKUP_WEAPON_BATTLEAXE`,
    `PICKUP_WEAPON_COMPACTLAUNCHER`,
    `PICKUP_WEAPON_MINISMG`,
    `PICKUP_WEAPON_PIPEBOMB`,
    `PICKUP_WEAPON_POOLCUE`,
    `PICKUP_WEAPON_WRENCH`,
    `PICKUP_WEAPON_ASSAULTRIFLE_MK2`,
    `PICKUP_WEAPON_CARBINERIFLE_MK2`,
    `PICKUP_WEAPON_COMBATMG_MK2`,
    `PICKUP_WEAPON_HEAVYSNIPER_MK2`,
    `PICKUP_WEAPON_PISTOL_MK2`,
    `PICKUP_WEAPON_SMG_MK2`,
    `PICKUP_WEAPON_STONE_HATCHET`,
    `PICKUP_WEAPON_METALDETECTOR`,
    `PICKUP_WEAPON_TACTICALRIFLE`,
    `PICKUP_WEAPON_PRECISIONRIFLE`,
    `PICKUP_WEAPON_EMPLAUNCHER`,
    `PICKUP_AMMO_EMPLAUNCHER`,
    `PICKUP_WEAPON_HEAVYRIFLE`,
    `PICKUP_WEAPON_PETROLCAN_SMALL_RADIUS`,
    `PICKUP_WEAPON_FERTILIZERCAN`,
    `PICKUP_WEAPON_STUNGUN_MP`,
}

CreateThread(function()
    while true do
        for i=1,#PickUpList do
            RemoveAllPickupsOfType(PickUpList[i])
        end
        Wait(1500)
    end
end)


RegisterNetEvent("admin:VIPBoost")
AddEventHandler("admin:VIPBoost", function(VipBoost)
    local Ped = PlayerPedId()
    local Vehicle = GetVehiclePedIsIn(Ped,false)
    if Vehicle and Vehicle ~= 0 then
        local Init = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveForce")
        SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fInitialDriveForce",Init + VipBoost)
        SetVehicleModKit(Vehicle,0)
        SetVehicleMod(Vehicle,11,GetVehicleMod(Vehicle,11),true)
        TriggerEvent("Notify","verde","Boost aplicado com sucesso.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("player",Creative)
vSERVER = Tunnel.getInterface("player")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drunk = 0
local Energetic = 0
local Residuals = nil
LocalPlayer["state"]["Tea"] = 3600
LocalPlayer["state"]["Handcuff"] = false
LocalPlayer["state"]["Commands"] = false
local cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Commands")
AddEventHandler("player:Commands",function(status)
    LocalPlayer["state"]["Commands"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PLAYERCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = false
RegisterNetEvent("player:playerCarry")
AddEventHandler("player:playerCarry",function(entity,mode)
    if playerCarry then
        DetachEntity(PlayerPedId(),false,false)
        playerCarry = false
    else
        if mode == "handcuff" then
            AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),11816,0.0,0.5,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
        else
            AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
        end
        CreateThread(function()
            while playerCarry do
                DisableControlAction(0,245,true)
                DisableControlAction(0,309,true)
                DisableControlAction(0,1,true)
                DisableControlAction(0,2,true)
                DisableControlAction(0,24,true)
                DisableControlAction(0,257,true)
                DisableControlAction(0,25,true)
                DisableControlAction(0,263,true)
                DisableControlAction(0,32,true)
                DisableControlAction(0,34,true)
                DisableControlAction(0,31,true)
                DisableControlAction(0,30,true)
                DisableControlAction(0,45,true)
                DisableControlAction(0,22,true)
                DisableControlAction(0,44,true)
                DisableControlAction(0,37,true)
                DisableControlAction(0,23,true)
                DisableControlAction(0,288,true)
                DisableControlAction(0,289,true)
                DisableControlAction(0,170,true)
                DisableControlAction(0,167,true)
                DisableControlAction(0,0,true)
                DisableControlAction(0,26,true)
                DisableControlAction(0,73,true)
                DisableControlAction(2,199,true)
                DisableControlAction(0,59,true)
                DisableControlAction(0,71,true)
                DisableControlAction(0,72,true)
                DisableControlAction(2,36,true)
                DisableControlAction(0,47,true)
                DisableControlAction(0,264,true)
                DisableControlAction(0,257,true)
                DisableControlAction(0,140,true)
                DisableControlAction(0,141,true)
                DisableControlAction(0,142,true)
                DisableControlAction(0,143,true)
                DisableControlAction(0,75,true)
                DisableControlAction(27,75,true)
                DisableFirstPersonCamThisFrame()
                Wait(1)
            end
        end)
        
        playerCarry = true
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROPECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local ropeCarry = false
RegisterNetEvent("player:ropeCarry")
AddEventHandler("player:ropeCarry",function(entity)
    ropeCarry = not ropeCarry
    
    if not ropeCarry then
        DetachEntity(PlayerPedId(),false,false)
        ropeCarry = false
    else
        AttachEntityToEntity(PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(entity)),0,0.20,0.12,0.63,0.5,0.5,0.0,false,false,false,false,2,false)
        ropeCarry = true
        CreateThread(function()
            while ropeCarry do
                DisableControlAction(0,245,true)
                DisableControlAction(0,309,true)
                DisableControlAction(0,1,true)
                DisableControlAction(0,2,true)
                DisableControlAction(0,24,true)
                DisableControlAction(0,257,true)
                DisableControlAction(0,25,true)
                DisableControlAction(0,263,true)
                DisableControlAction(0,32,true)
                DisableControlAction(0,34,true)
                DisableControlAction(0,31,true)
                DisableControlAction(0,30,true)
                DisableControlAction(0,45,true)
                DisableControlAction(0,22,true)
                DisableControlAction(0,44,true)
                DisableControlAction(0,37,true)
                DisableControlAction(0,23,true)
                DisableControlAction(0,288,true)
                DisableControlAction(0,289,true)
                DisableControlAction(0,170,true)
                DisableControlAction(0,167,true)
                DisableControlAction(0,0,true)
                DisableControlAction(0,26,true)
                DisableControlAction(0,73,true)
                DisableControlAction(2,199,true)
                DisableControlAction(0,59,true)
                DisableControlAction(0,71,true)
                DisableControlAction(0,72,true)
                DisableControlAction(2,36,true)
                DisableControlAction(0,47,true)
                DisableControlAction(0,264,true)
                DisableControlAction(0,257,true)
                DisableControlAction(0,140,true)
                DisableControlAction(0,141,true)
                DisableControlAction(0,142,true)
                DisableControlAction(0,143,true)
                DisableControlAction(0,75,true)
                DisableControlAction(27,75,true)
                DisableFirstPersonCamThisFrame()
                Wait(1)
            end
        end)
    end
end)

function Creative.CheckCarry()
    if playerCarry or ropeCarry then
        return true
    end
    
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADROPEANIM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        if ropeCarry then
            TimeDistance = 1
            local Ped = PlayerPedId()
            if not IsEntityPlayingAnim(Ped,"nm","firemans_carry",3) then
                vRP.playAnim(false,{"nm","firemans_carry"},true)
            end
            
            DisableControlAction(1,23,true)
        end
        
        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        if IsPedInAnyVehicle(Ped) then
            TimeDistance = 100
            
            if not GetPedConfigFlag(Ped,184,true) then
                SetPedConfigFlag(Ped,184,true)
            end
            
            local Vehicle = GetVehiclePedIsIn(Ped)
            if GetPedInVehicleSeat(Vehicle,0) == Ped then
                if GetIsTaskActive(Ped,165) then
                    SetPedIntoVehicle(Ped,Vehicle,0)
                end
            end
        else
            if GetPedConfigFlag(Ped,184,true) then
                SetPedConfigFlag(Ped,184,false)
            end
        end
        
        Wait(100)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local AdminEnergetic = false
RegisterNetEvent("setEnergetic")
AddEventHandler("setEnergetic",function(Timer,Number,Bool)
    Energetic = Timer
    SetRunSprintMultiplierForPlayer(PlayerId(),Number)
    AdminEnergetic = Bool or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetEnergetic")
AddEventHandler("resetEnergetic",function()
    if Energetic > 0 then
        SetRunSprintMultiplierForPlayer(PlayerId(),1.10)
        Energetic = 0
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if Energetic > 0 then
            Energetic = Energetic - 1
            RestorePlayerStamina(PlayerId(),1.0)
            
            if not AdminEnergetic then
                if Energetic <= 0 or GetEntityHealth(PlayerPedId()) <= 100 then
                    SetRunSprintMultiplierForPlayer(PlayerId(),1.10)
                    Energetic = 0
                end
            end
        end
        
        Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUGEFFECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:setDrugEffect")
AddEventHandler("player:setDrugEffect",function(Timer)
    drugThread(Timer)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRUGEFFECT
-----------------------------------------------------------------------------------------------------------------------------------------
local DRUG_ANIM_SET = "move_m@drunk@verydrunk"

local DRUG_DRIVING_EFFECTS = {
	1, -- brake
	7, --turn left + accelerate
	8, -- turn right + accelerate
	23, -- accelerate
	4, -- turn left 90 + braking
	5, -- turn right 90 + braking
}

local function getRandomDrunkCarTask()
	math.randomseed(GetGameTimer())

	return DRUG_DRIVING_EFFECTS[math.random(#DRUG_DRIVING_EFFECTS)]
end

-- NOTE: We might want to check if a player already has an effect
function drugThread(Timer)
	local playerPed = PlayerPedId()
	local isDrug = true

	LoadMovement(DRUG_ANIM_SET)

	SetPedMovementClipset(playerPed, DRUG_ANIM_SET)
	ShakeGameplayCam("DRUNK_SHAKE", 3.0)
	SetPedIsDrunk(playerPed, true)
	SetTransitionTimecycleModifier("spectator5", 10.00)

	CreateThread(function()
		while isDrug do
			local vehPedIsIn = GetVehiclePedIsIn(playerPed)
			local isPedInVehicleAndDriving = (vehPedIsIn ~= 0) and (GetPedInVehicleSeat(vehPedIsIn, -1) == playerPed)

			if isPedInVehicleAndDriving then
				local randomTask = getRandomDrunkCarTask()
				TaskVehicleTempAction(playerPed, vehPedIsIn, randomTask, 500)
			end

            if not IsEntityPlayingAnim(playerPed, DRUG_ANIM_SET, "idle", 3) then
                SetPedMovementClipset(playerPed, DRUG_ANIM_SET)
            end

			Wait(3000)
		end
	end)

	Wait(Timer * 1000)
	isDrug = false
	SetTransitionTimecycleModifier("default", 10.00)
	StopGameplayCamShaking(true)
	ResetPedMovementClipset(playerPed)
	RemoveAnimSet(DRUG_ANIM_SET)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setDrunkTime")
AddEventHandler("setDrunkTime",function(Timer)
    Drunk = Drunk + Timer
    
    LocalPlayer["state"]["Drunk"] = true
    
    if LoadMovement("move_m@drunk@verydrunk") then
        SetPedMovementClipset(PlayerPedId(),"move_m@drunk@verydrunk",0.25)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if Drunk > 0 then
            Drunk = Drunk - 1
            
            if Drunk <= 0 or GetEntityHealth(PlayerPedId()) <= 100 then
                ResetPedMovementClipset(PlayerPedId(),0.25)
                LocalPlayer["state"]["Drunk"] = false
            end
        end
        
        Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCHOODOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncHoodOptions")
AddEventHandler("player:syncHoodOptions",function(Network,Active)
    if NetworkDoesNetworkIdExist(Network) then
        local Vehicle = NetToEnt(Network)
        if DoesEntityExist(Vehicle) then
            if Active == "open" then
                SetVehicleDoorOpen(Vehicle,4,0,0)
            elseif Active == "close" then
                SetVehicleDoorShut(Vehicle,4,0)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORSOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoorsOptions")
AddEventHandler("player:syncDoorsOptions",function(Network,Active)
    if NetworkDoesNetworkIdExist(Network) then
        local Vehicle = NetToEnt(Network)
        if DoesEntityExist(Vehicle) then
            if Active == "open" then
                SetVehicleDoorOpen(Vehicle,5,0,0)
            elseif Active == "close" then
                SetVehicleDoorShut(Vehicle,5,0)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncWins")
AddEventHandler("player:syncWins",function(Network,Active)
    if NetworkDoesNetworkIdExist(Network) then
        local Vehicle = NetToEnt(Network)
        if DoesEntityExist(Vehicle) then
            if Active == "1" then
                RollUpWindow(Vehicle,0)
                RollUpWindow(Vehicle,1)
                RollUpWindow(Vehicle,2)
                RollUpWindow(Vehicle,3)
            else
                RollDownWindow(Vehicle,0)
                RollDownWindow(Vehicle,1)
                RollDownWindow(Vehicle,2)
                RollDownWindow(Vehicle,3)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doorStatus = { ["1"] = 0, ["2"] = 1, ["3"] = 2, ["4"] = 3, ["5"] = 5, ["6"] = 4 }
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors",function(Network,Active)
    if NetworkDoesNetworkIdExist(Network) then
        local v = NetToEnt(Network)
        if DoesEntityExist(v) and GetVehicleDoorLockStatus(v) == 1 then
            if doorStatus[Active] then
                if GetVehicleDoorAngleRatio(v,doorStatus[Active]) == 0 then
                    SetVehicleDoorOpen(v,doorStatus[Active],0,0)
                else
                    SetVehicleDoorShut(v,doorStatus[Active],0)
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer",function(Index)
    local Ped = PlayerPedId()
    if IsPedInAnyVehicle(Ped) then
        local Vehicle = GetVehiclePedIsUsing(Ped)
        
        if Index == "0" then
            if IsVehicleSeatFree(Vehicle,-1) then
                SetPedIntoVehicle(Ped,Vehicle,-1)
            end
        elseif Index == "1" then
            if IsVehicleSeatFree(Vehicle,0) then
                SetPedIntoVehicle(Ped,Vehicle,0)
            end
        else
            for Seat = 1,10 do
                if IsVehicleSeatFree(Vehicle,Seat) then
                    SetPedIntoVehicle(Ped,Vehicle,Seat)
                    break
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 100
        if LocalPlayer["state"]["Handcuff"] or LocalPlayer["state"]["Target"] then
            TimeDistance = 1
            DisableControlAction(1,18,true)
            DisableControlAction(1,21,true)
            DisableControlAction(1,55,true)
            DisableControlAction(1,102,true)
            DisableControlAction(1,179,true)
            DisableControlAction(1,203,true)
            DisableControlAction(1,76,true)
            DisableControlAction(1,23,true)
            DisableControlAction(1,24,true)
            DisableControlAction(1,25,true)
            DisableControlAction(1,140,true)
            DisableControlAction(1,142,true)
            DisableControlAction(1,143,true)
            DisableControlAction(1,75,true)
            DisableControlAction(1,22,true)
            DisableControlAction(1,243,true)
            DisableControlAction(1,257,true)
            DisableControlAction(1,263,true)
            DisableControlAction(1,311,true)
            DisablePlayerFiring(PlayerPedId(),true)
        end
        
        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        local Ped = PlayerPedId()
        if LocalPlayer["state"]["Handcuff"] and GetEntityHealth(Ped) > 100 and not ropeCarry and not playerCarry then
            if not IsEntityPlayingAnim(Ped,"mp_arresting","idle",3) then
                if LoadAnim("mp_arresting") then
                    TaskPlayAnim(Ped,"mp_arresting","idle",8.0,8.0,-1,49,0,0,0,0)
                end
                
                TimeDistance = 1
            end
        end
        
        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local losSantos = PolyZone:Create({
    vector2(-2153.08,-3131.33),
    vector2(-1581.58,-2092.38),
    vector2(-3271.05,275.85),
    vector2(-3460.83,967.42),
    vector2(-3202.39,1555.39),
    vector2(-1642.50,993.32),
    vector2(312.95,1054.66),
    vector2(1313.70,341.94),
    vector2(1739.01,-1280.58),
    vector2(1427.42,-3440.38),
    vector2(-737.90,-3773.97)
},{ name = "santos" })

local sandyShores = PolyZone:Create({
    vector2(-375.38,2910.14),
    vector2(307.66,3664.47),
    vector2(2329.64,4128.52),
    vector2(2349.93,4578.50),
    vector2(1680.57,4462.48),
    vector2(1570.01,4961.27),
    vector2(1967.55,5203.67),
    vector2(2387.14,5273.98),
    vector2(2735.26,4392.21),
    vector2(2512.33,3711.16),
    vector2(1681.79,3387.82),
    vector2(258.85,2920.16)
},{ name = "sandy" })

local paletoBay = PolyZone:Create({
    vector2(-529.40,5755.14),
    vector2(-234.39,5978.46),
    vector2(278.16,6381.84),
    vector2(672.67,6434.39),
    vector2(699.56,6877.77),
    vector2(256.59,7058.49),
    vector2(17.64,7054.53),
    vector2(-489.45,6449.50),
    vector2(-717.59,6030.94)
},{ name = "paleto" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local ShotDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local GridSize = 256
function gridChunk(x)
    return math.floor((x + 8192) / GridSize)
end

function toChannel(v)
    return (v["x"] << 8) | v["y"]
end

function getGridzone(x,y)
    local gridChunk = vector2(gridChunk(x),gridChunk(y))
    return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        if LocalPlayer["state"]["Route"] < 900000 then
            local Ped = PlayerPedId()
            if IsPedArmed(Ped,6) and GetGameTimer() >= ShotDelay then
                TimeDistance = 1
                
                if IsPedShooting(Ped) then
                    ShotDelay = GetGameTimer() + 60000
                    --TriggerEvent("player:Residuals","Resíduo de Pólvora.")
                    
                    local Vehicle = false
                    local Coords = GetEntityCoords(Ped)
                    local Grid = getGridzone(Coords["x"],Coords["y"])
                    if not IsPedCurrentWeaponSilenced(Ped) then
                        -- if (losSantos:isPointInside(Coords) or sandyShores:isPointInside(Coords) or paletoBay:isPointInside(Coords)) and not LocalPlayer["state"]["Policia"] then
                        -- 	TriggerServerEvent("evidence:dropEvidence","blue")
                        if LocalPlayer["state"]["Policia"] then return end
                        if IsPedInAnyVehicle(Ped) then
                            Vehicle = true
                        end
                        
                        vSERVER._shotsFired(Vehicle,Grid)
                        -- end
                    else
                        if math.random(40) >= 20 then
                            -- if (losSantos:isPointInside(Coords) or sandyShores:isPointInside(Coords) or paletoBay:isPointInside(Coords)) and not LocalPlayer["state"]["Policia"] then
                            -- 	TriggerServerEvent("evidence:dropEvidence","blue")
                            if LocalPlayer["state"]["Policia"] then return end
                            if IsPedInAnyVehicle(Ped) then
                                Vehicle = true
                            end
                            
                            vSERVER._shotsFired(Vehicle,Grid)
                            -- end
                        end
                    end
                end
            end
        end
        
        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKESHOTTING
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        local Ped = PlayerPedId()
        if IsPedInAnyVehicle(Ped) and IsPedArmed(Ped,6) then
            TimeDistance = 1
            
            local Vehicle = GetVehiclePedIsUsing(Ped)
            if IsPedShooting(Ped) and (GetVehicleClass(Vehicle) ~= 15 and GetVehicleClass(Vehicle) ~= 16) then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE",0.05)
            end
        end
        
        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSOAP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkSoap()
    return Residuals
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RESIDUALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Residuals")
AddEventHandler("player:Residuals",function(Informations)
    if Informations then
        if not Residuals then
            Residuals = {}
        end
        
        Residuals[Informations] = true
    else
        Residuals = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:inBennys")
AddEventHandler("player:inBennys",function(status)
    inBennys = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.removeVehicle()
    if not inBennys then
        local Ped = PlayerPedId()
        if IsPedInAnyVehicle(Ped) then
            TaskLeaveVehicle(Ped,GetVehiclePedIsUsing(Ped),16)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.putVehicle(Network)
    if NetworkDoesNetworkIdExist(Network) then
        local Vehicle = NetToEnt(Network)
        if DoesEntityExist(Vehicle) then
            local vehSeats = 10
            local Ped = PlayerPedId()
            
            repeat
                vehSeats = vehSeats - 1
                
                if IsVehicleSeatFree(Vehicle,vehSeats) then
                    ClearPedTasks(Ped)
                    ClearPedSecondaryTask(Ped)
                    SetPedIntoVehicle(Ped,Vehicle,vehSeats)
                    
                    vehSeats = true
                end
            until vehSeats == true or vehSeats == 0
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,Message)
    local Ped = PlayerPedId()
    if IsPedInAnyVehicle(Ped) then
        local Vehicle = GetVehiclePedIsUsing(Ped)
        if GetPedInVehicleSeat(Vehicle,-1) == Ped and not IsEntityInAir(Vehicle) then
            local speed = GetEntitySpeed(Vehicle) * 3.6
            
            if speed >= 10 then
                if not Message[1] then
                    SetEntityMaxSpeed(Vehicle,GetVehicleEstimatedMaxSpeed(Vehicle))
                    TriggerEvent("Notify","amarelo","Controle de cruzeiro desativado.",3000)
                    -- TriggerEvent("Notify2","#controleCruzeiroDesativado")
                else
                    if parseInt(Message[1]) > 10 then
                        SetEntityMaxSpeed(Vehicle,0.28 * Message[1])
                        TriggerEvent("Notify","verde","Controle de cruzeiro ativado.",3000)
                        -- TriggerEvent("Notify2","#controleCruzeiroAtivado")
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(Name,Message)
    if Name == "CEventNetworkEntityDamage" then
        local Ped = PlayerPedId()
        local OtherPed = Message[2]
        if Message[1] == Ped and GetEntityHealth(Ped) <= 100 and IsEntityAPed(Ped) and IsPedAPlayer(OtherPed) then
            local Index = NetworkGetPlayerIndexFromPed(OtherPed)
            local PedIndex = GetPlayerServerId(PlayerId())
            local OtherIndex = GetPlayerServerId(Index)
            local Weapon = tostring(Message[7])
            local MurderWeapon = tostring(Message[7])
            if Weapons[Weapon] then
                MurderWeapon = Weapons[Weapon]
            end
            TriggerServerEvent("player:Death",PedIndex,OtherIndex,MurderWeapon)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrunk")
AddEventHandler("player:enterTrunk",function(Entitys)
    if not inTrunk and not Entity(Entitys[3])["state"]["inTrunk"] then
        LocalPlayer["state"]["Commands"] = true
        LocalPlayer["state"]["Invisible"] = true
        SetEntityVisible(PlayerPedId(),false,false)
        Entity(Entitys[3])["state"]:set("inTrunk",true,true)
        AttachEntityToEntity(PlayerPedId(),Entitys[3],-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
        inTrunk = true
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
    if inTrunk then
        local Ped = PlayerPedId()
        local Vehicle = GetEntityAttachedTo(Ped)
        if DoesEntityExist(Vehicle) then
            inTrunk = false
            local VSpeed = GetEntitySpeed(Vehicle) * 3.6
            if not VSpeed or VSpeed <= 20 then
                DetachEntity(Ped,false,false)
                SetEntityVisible(Ped,true,false)
                LocalPlayer["state"]["Invisible"] = false
                LocalPlayer["state"]["Commands"] = false
                Entity(Vehicle)["state"]:set("inTrunk",nil,true)
                SetEntityCoords(Ped,GetOffsetFromEntityInWorldCoords(Ped,0.0,-1.25,-0.25),false,false,false,false)
                LocalPlayer["state"]["Commands"] = true
                Wait(2000)
                LocalPlayer["state"]["Commands"] = false
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        
        if inTrunk then
            local Ped = PlayerPedId()
            local Vehicle = GetEntityAttachedTo(Ped)
            if DoesEntityExist(Vehicle) then
                TimeDistance = 1
                
                DisablePlayerFiring(Ped,true)
                
                if IsEntityVisible(Ped) then
                    LocalPlayer["state"]["Invisible"] = true
                    SetEntityVisible(Ped,false,false)
                end
                
                if IsControlJustPressed(1,38) then
                    inTrunk = false
                    DetachEntity(Ped,false,false)
                    SetEntityVisible(Ped,true,false)
                    LocalPlayer["state"]["Invisible"] = false
                    LocalPlayer["state"]["Commands"] = false
                    Entity(Vehicle)["state"]:set("inTrunk",nil,true)
                    SetEntityCoords(Ped,GetOffsetFromEntityInWorldCoords(Ped,0.0,-1.25,-0.25),false,false,false,false)
                end
            else
                inTrunk = false
                DetachEntity(Ped,false,false)
                SetEntityVisible(Ped,true,false)
                LocalPlayer["state"]["Invisible"] = false
                LocalPlayer["state"]["Commands"] = false
                Entity(Vehicle)["state"]:set("inTrunk",nil,true)
                SetEntityCoords(Ped,GetOffsetFromEntityInWorldCoords(Ped,0.0,-1.25,-0.25),false,false,false,false)
            end
        end
        
        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ancorar",function()
    local Ped = PlayerPedId()
    if IsPedInAnyBoat(Ped) then
        local Vehicle = GetVehiclePedIsUsing(Ped)
        if CanAnchorBoatHere(Vehicle) then
            TriggerEvent("Notify","verde","Embarcação desancorada.",5000)
            -- TriggerEvent("Notify2","#embarcDesancorada")
            SetBoatAnchor(Vehicle,false)
        else
            TriggerEvent("Notify","verde","Embarcação ancorada.",5000)
            -- TriggerEvent("Notify2","#embarcAncorada")
            SetBoatAnchor(Vehicle,true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COWCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Cows = {
    { 2440.58,4736.35,34.29 },
    { 2432.5,4744.58,34.31 },
    { 2424.47,4752.37,34.31 },
    { 2416.28,4760.8,34.31 },
    { 2408.6,4768.88,34.31 },
    { 2400.32,4777.48,34.53 },
    { 2432.46,4802.66,34.83 },
    { 2440.62,4794.22,34.66 },
    { 2448.65,4786.57,34.64 },
    { 2456.88,4778.08,34.49 },
    { 2464.53,4770.04,34.37 },
    { 2473.38,4760.98,34.31 },
    { 2495.03,4762.77,34.37 },
    { 2503.13,4754.08,34.31 },
    { 2511.34,4746.04,34.31 },
    { 2519.56,4737.35,34.29 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    for Index,v in pairs(Cows) do
        exports["target"]:AddCircleZone("Cows:"..Index,vec3(v[1],v[2],v[3]),0.5,{
            name = "Cows:"..Index,
            heading = 3374176
        },{
            Distance = 1.25,
            options = {
                {
                    event = "inventory:MakeProducts",
                    label = "Retirar Leite",
                    tunnel = "products",
                    service = "milkBottle"
                }
            }
        })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrash = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrash")
AddEventHandler("player:enterTrash",function(Entity)
    if not inTrash then
        LocalPlayer["state"]["Commands"] = true
        
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped,true)
        LocalPlayer["state"]["Invisible"] = true
        SetEntityVisible(Ped,false,false)
        SetEntityCoords(Ped,Entity[4],false,false,false,false)
        
        inTrash = GetOffsetFromEntityInWorldCoords(Entity[1],0.0,-1.5,0.0)
        
        while inTrash do
            Wait(1)
            
            if IsControlJustPressed(1,38) then
                FreezeEntityPosition(Ped,false)
                SetEntityVisible(Ped,true,false)
                LocalPlayer["state"]["Invisible"] = false
                SetEntityCoords(Ped,inTrash,false,false,false,false)
                LocalPlayer["state"]["Commands"] = false
                
                inTrash = false
            end
        end
    end
end)

function Creative.inTrash()
    return inTrash
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
    if inTrash then
        local Ped = PlayerPedId()
        FreezeEntityPosition(Ped,false)
        SetEntityVisible(Ped,true,false)
        LocalPlayer["state"]["Invisible"] = false
        SetEntityCoords(Ped,inTrash,false,false,false,false)
        LocalPlayer["state"]["Commands"] = false
        
        inTrash = false
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
local Megaphone = false
RegisterNetEvent("player:Megaphone")
AddEventHandler("player:Megaphone",function()
    Megaphone = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if Megaphone then
            local Ped = PlayerPedId()
            if not IsEntityPlayingAnim(Ped,"anim@random@shop_clothes@watches","base",3) then
                TriggerServerEvent("pma-voice:Megaphone",false)
                TriggerEvent("pma-voice:Megaphone",false)
                Megaphone = false
            end
        end
        
        Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DUIVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local DuiTextures = {}
local InnerTexture = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DUITABLE
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("player:DuiTable")
-- AddEventHandler("player:DuiTable",function(Table)
--     DuiTextures = Table
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
--     while true do
--         local Ped = PlayerPedId()
--         if not IsPedInAnyVehicle(Ped) then
--             local Coords = GetEntityCoords(Ped)

--             for Line,v in pairs(DuiTextures) do
--                 if #(Coords - v["Coords"]) <= 15 then
--                     if not InnerTexture[Line] then
--                         InnerTexture[Line] = true

--                         local Texture = CreateRuntimeTxd("Texture"..Line)
--                         local TextureObject = CreateDui(v["Link"],v["Width"],v["Weight"])
--                         local TextureHandle = GetDuiHandle(TextureObject)

--                         CreateRuntimeTextureFromDuiHandle(Texture,"Back"..Line,TextureHandle)
--                         AddReplaceTexture(v["Dict"],v["Texture"],"Texture"..Line,"Back"..Line)

--                         exports["target"]:AddCircleZone("Texture"..Line,v["Coords"],v["Dimension"],{
--                             name = "Texture"..Line,
--                             heading = 3374176
--                         },{
--                             shop = Line,
--                             Distance = v["Distance"],
--                             options = {
--                                 {
--                                     event = "player:Texture",
--                                     label = v["Label"],
--                                     tunnel = "server"
--                                 }
--                             }
--                         })
--                     end
--                 else
--                     if InnerTexture[Line] then
--                         exports["target"]:RemCircleZone("Texture"..Line)
--                         RemoveReplaceTexture(v["Dict"],v["Texture"])
--                         InnerTexture[Line] = nil
--                     end
--                 end
--             end
--         end

--         Wait(1000)
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DUIUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterNetEvent("player:DuiUpdate")
-- AddEventHandler("player:DuiUpdate",function(Name,Table)
--     DuiTextures[Name] = Table

--     local Ped = PlayerPedId()
--     local Fast = DuiTextures[Name]
--     local Coords = GetEntityCoords(Ped)
--     if #(Coords - Fast["Coords"]) <= 15 then
--         local Texture = CreateRuntimeTxd("Texture"..Name)
--         local TextureObject = CreateDui(Fast["Link"],Fast["Width"],Fast["Weight"])
--         local TextureHandle = GetDuiHandle(TextureObject)

--         CreateRuntimeTextureFromDuiHandle(Texture,"Back"..Name,TextureHandle)
--         AddReplaceTexture(Fast["Dict"],Fast["Texture"],"Texture"..Name,"Back"..Name)
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RELATIONSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Relationship")
AddEventHandler("player:Relationship",function(Group)
    if Group == "Ballas" then
        SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_BALLAS"),GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_BALLAS"))
    elseif Group == "Families" then
        SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_FAMILY"),GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_FAMILY"))
    elseif Group == "Vagos" then
        SetRelationshipBetweenGroups(1,GetHashKey("AMBIENT_GANG_MEXICAN"),GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(1,GetHashKey("PLAYER"),GetHashKey("AMBIENT_GANG_MEXICAN"))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARWASH
-----------------------------------------------------------------------------------------------------------------------------------------
local WashProgress = false
local Wash = {
    { 24.27,-1391.96,28.7 },
    { 170.59,-1718.43,28.66 },
    { 167.69,-1715.92,28.66 },
    { -699.86,-932.84,18.38 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCARWASH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        local Ped = PlayerPedId()
        if IsPedInAnyVehicle(Ped) and not WashProgress then
            local Coords = GetEntityCoords(Ped)
            local Vehicle = GetVehiclePedIsUsing(Ped)
            if GetPedInVehicleSeat(Vehicle,-1) == Ped then
                for _,v in pairs(Wash) do
                    local Distance = #(Coords - vec3(v[1],v[2],v[3]))
                    if Distance <= 2.5 then
                        TimeDistance = 1
                        
                        if IsControlJustPressed(1,38) then
                            WashProgress = true
                            
                            FreezeEntityPosition(Vehicle,true)
                            
                            UseParticleFxAssetNextCall("core")
                            local Particle01 = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p",v[1],v[2],v[3],0.0,0.0,0.0,1.0,false,false,false,false)
                            
                            UseParticleFxAssetNextCall("core")
                            local Particle02 = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p",v[1] + 2.5,v[2],v[3],0.0,0.0,0.0,1.0,false,false,false,false)
                            
                            SetTimeout(15000,function()
                                TriggerServerEvent("CleanVehicle",VehToNet(Vehicle))
                                
                                FreezeEntityPosition(Vehicle,false)
                                StopParticleFxLooped(Particle01,0)
                                StopParticleFxLooped(Particle02,0)
                                WashProgress = false
                            end)
                        end
                    end
                end
            end
        end
        
        Wait(TimeDistance)
    end
end)

RegisterCommand("cv",function(source,args)
    if LocalPlayer["state"]["InSafeZone"] then
        return
    end
    TriggerServerEvent("player:cvFunctions","cv")
end)

RegisterCommand("rv",function(source,args)
    TriggerServerEvent("player:cvFunctions","rv")
end)

RegisterCommand("carry",function(source,args)
    TriggerServerEvent("player:carryPlayer")
end)
RegisterKeyMapping("carry", "Carry Player", "keyboard", "H")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CL
-----------------------------------------------------------------------------------------------------------------------------------------
local inCL = false
local ProximityCL = {}
local CLCooldown = GetGameTimer()

RegisterCommand("cl",function(source)
    if GetGameTimer() > CLCooldown then
        if not inCL then
            CLCooldown = GetGameTimer() + 5000
            ProximityCL = vSERVER.GetProximityCL()
            inCL = true
            CreateThread(function()
                while inCL do
                    for i=1,#ProximityCL do
                        local Coords = GetEntityCoords(PlayerPedId())
                        if #(Coords - ProximityCL[i]["Coords"]) <= 25.0 then
                            DrawText(ProximityCL[i]["Coords"]["x"],ProximityCL[i]["Coords"]["y"],ProximityCL[i]["Coords"]["z"],"<b>Passaporte:</b> "..ProximityCL[i]["Player"].."<br><b>Motivo:</b> "..ProximityCL[i]["Reason"])
                        end
                    end
                    Wait(1)
                end
            end)
        else
            ProximityCL = {}
            inCL = false
        end
    else
        if not inCL then
            TriggerEvent("Notify","vermelho","Aguarde <b>"..math.ceil((CLCooldown - GetGameTimer())/1000).."</b> segundos para usar o comando novamente.",5000,"CombatLog")
            -- TriggerEvent("Notify2","#esperaComando",{msg=math.ceil((CLCooldown - GetGameTimer())/1000)})
        else
            ProximityCL = {}
            inCL = false
        end
    end
end)

function DrawText(x,y,z,Message)
    local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
    
    if onScreen then
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringKeyboardDisplay(Message)
        SetTextColour(255,255,255,150)
        SetTextScale(0.35,0.35)
        SetTextFont(4)
        SetTextCentre(1)
        EndTextCommandDisplayText(_x,_y)
        
        local width = string.len(Message) / 160 * 0.45
        DrawRect(_x,_y + 0.025,width/2,width/3,15,15,15,175)
    end
end

local StoreURL = {
    ["Base"] = "SEU LINK AQUI"
}

local discordURL = {
    ["Base"] = "SEU LINK AQUI"
}

RegisterNetEvent("player:OpenURL")
AddEventHandler("player:OpenURL",function(url)
    SendNUIMessage({ url = url })
end)

RegisterNetEvent("player:MarkWayPoint")
AddEventHandler("player:MarkWayPoint",function(Coords)
    TriggerEvent("talknpc:closeTalk")
    SetNewWaypoint(Coords["x"] + 0.0001,Coords["y"] + 0.0001)
    Wait(500)
    ExecuteCommand("Map")
end)

RegisterCommand("lojavip",function(source,args)
    SendNUIMessage({ url = StoreURL[cityName] })
end)

RegisterCommand("discord",function(source,args)
    SendNUIMessage({ url = discordURL[cityName] })
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

function DrawText(x,y,z,text,color)
    local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
    
    if onScreen then
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringKeyboardDisplay(text)
        
        if color then
            SetTextColour(150,196,172,255)
        else
            SetTextColour(204,204,204,175)
        end
        
        SetTextScale(0.35,0.35)
        SetTextFont(4)
        SetTextCentre(1)
        EndTextCommandDisplayText(_x,_y)
        
        local width = string.len(text) / 300
        
        if color then
            DrawRect(_x,_y + 0.0125,width,0.03,162,124,219,200)
        else
            DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,200)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CROUCH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Crouch","Agachar.","keyboard","LCONTROL")
local Crouch = false

RegisterCommand("Crouch",function()
    DisableControlAction(0,36,true)
    
    local Ped = PlayerPedId()
    local PlayerId = PlayerId()
    if not LocalPlayer["state"]["Buttons"] and not IsPedInAnyVehicle(Ped) and GetEntityHealth(Ped) > 100 and not IsPedReloading(Ped) then
        RequestAnimSet("move_ped_crouched")
        while not HasAnimSetLoaded("move_ped_crouched") do
            Wait(1)
        end
        
        if Crouch then
            ResetPedMovementClipset(Ped,0.25)
            ResetPedStrafeClipset(Ped)
            Crouch = false
        else
            SetPedUsingActionMode(Ped, false, -1, 0)
            SetPedMovementClipset(Ped,"move_ped_crouched",0.25)
            SetPedStrafeClipset(Ped,"move_ped_crouched_strafing")
            Crouch = true
        end
        
        CreateThread(function()
            while Crouch do
                DisablePlayerFiring(PlayerId,true)
                Wait(1)
            end
        end)
    end
end)


CreateThread(function()
    while true do
        Wait(15000)
        if LocalPlayer["state"]["Active"] then
            local WrongCoords = vector3(0,0,0)
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Distance = #(Coords - WrongCoords)
            if Distance <= 30.0 then
                TriggerEvent("admin:Teleport",vector3(-1607.34,-1054.58,13.02))
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local InSpectate = false
local OldCoords = false
local Spectated = false
local LoadingNext = false

function spectatePlayer(targetPed,target,Boolean)
    print("spectatePlayer",targetPed,target)
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCollision(playerPed, false, false)
    SetEntityInvincible(playerPed, true)
    NetworkSetEntityInvisibleToNetwork(playerPed, true)
    Wait(200)
    if targetPed == playerPed then
        Wait(500)
        targetPed = GetPlayerPed(target)
    end
    local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
    RequestCollisionAtCoord(targetx,targety,targetz)
    if not Boolean then
        Spectated = targetPed
    end
    FreezeEntityPosition(playerPed,true)
    NetworkSetInSpectatorMode(true, targetPed)
    LocalPlayer["state"]:set("Spectate",true,true)
end


RegisterKeyMapping("Next","Next Spectate","MOUSE_BUTTONANY","MOUSE_LEFT")
RegisterKeyMapping("Previous","Previous Spectate","MOUSE_BUTTONANY","MOUSE_RIGHT")

RegisterCommand("Next",function()
    if not InSpectate then
        return
    end
    -- print("Click Next")
    -- if not LoadingNext then
    LoadingNext = true
    vSERVER._Spectate("Next")
    --     LoadingNext = false
    -- else
    --     TriggerEvent("Notify","vermelho","Aguarde o carregamento",5000,"Spectate")
    -- end
end)

RegisterCommand("Previous",function()
    print("Click Previous")
    if not InSpectate then
        return
    end
    -- if not LoadingNext then
    --     LoadingNext = true
    vSERVER._Spectate("Previous")
    --     LoadingNext = false
    -- else
    --     TriggerEvent("Notify","vermelho","Aguarde o carregamento",5000,"Spectate")
    -- end
end)

AddEventHandler("actions:Cancel",function()
    local Ped = PlayerPedId()
    if InSpectate then
        print("ExitSpectate")
        TriggerServerEvent("player:ExitSpectateServer")
        TriggerEvent("player:ExitSpectate")
        TriggerEvent("Notify:Text","")
        InSpectate = false
        Spectated = false
        FreezeEntityPosition(Ped,false)
        SetEntityCoords(Ped, OldCoords)
    end
end)


RegisterNetEvent("player:StartSpectate")
AddEventHandler("player:StartSpectate",function(Coords)
    InSpectate = true
    local Ped = PlayerPedId()
    OldCoords = GetEntityCoords(Ped)
    while InSpectate do
        if Spectated then
            local Coords = GetEntityCoords(Spectated)
            SetEntityCoords(Ped, Coords.x, Coords.y, Coords.z + 99.0, 0, 0, 0, false)
        end
        Wait(1)
    end
end)

RegisterNetEvent("player:Spectate")
AddEventHandler("player:Spectate",function(playerServerId, Name, tgtCoords,Boolean)
    print("player:Spectate",playerServerId, Name, tgtCoords)
    Spectated = false
    local localPlayerPed = PlayerPedId()
    TriggerEvent("Notify:Text","")
    Wait(100)
    if not Boolean then
        SetEntityCoords(localPlayerPed, tgtCoords.x, tgtCoords.y, tgtCoords.z + 99.0, 0, 0, 0, false)
    end
    local playerId = GetPlayerFromServerId(playerServerId)
    repeat
        Wait(200)
        playerId = GetPlayerFromServerId(playerServerId)
    until ((GetPlayerPed(playerId) > 0) and (playerId ~= -1))
    spectatePlayer(GetPlayerPed(playerId),playerId,Boolean)
    TriggerEvent("Notify:Text",Name)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:ExitSpectate")
AddEventHandler("player:ExitSpectate",function()
    NetworkSetInSpectatorMode(false)
    LocalPlayer["state"]:set("Spectate",false,true)
end)

function Creative.GetCoords()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    return coords
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local LastVDM = GetGameTimer()
local VDMCount = 0
-- AddEventHandler("entityDamaged", function(entity, attacker, weapon, damage)
--     if IsEntityAPed(entity) and attacker == PlayerPedId() then
--         if weapon == 0 or weapon == -1553120962 then
--             if IsPedInAnyVehicle(attackerPed, false) and GetPedInVehicleSeat(attackerPed, -1) then
--                 if GetGameTimer() - LastVDM < 60000 then
--                     VDMCount = VDMCount + 1
--                 else
--                     VDMCount = 0
--                 end
--                 LastVDM = GetGameTimer()
--                 if VDMCount == 5 then
--                     TriggerServerEvent("nova_antivdm:warn")
--                 end
--             end
--         end
--     end
-- end)

local inAutoPilot = false
local CoordsAutoPilot = false
RegisterNetEvent("player:AutomaticPilot")
AddEventHandler("player:AutomaticPilot",function()
    inAutoPilot = not inAutoPilot
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player,false)
    local model = GetEntityModel(vehicle)
    local displaytext = GetDisplayNameFromVehicleModel(model)
    local waypointBlip = GetFirstBlipInfoId(8)
    if not IsWaypointActive() then
        TriggerEvent("Notify","vermelho","Marque um local no GPS.",5000)
        ClearPedTasks(player)
        return
    end
    CoordsAutoPilot = GetBlipInfoIdCoord(waypointBlip,Citizen.ResultAsVector())
    TaskVehicleDriveToCoordLongrange(player, vehicle, CoordsAutoPilot.x, CoordsAutoPilot.y, CoordsAutoPilot.z, 3516854.5, 32, 5.0)
    TriggerEvent("Notify:Text","Pressione E para desligar Piloto Automatico")
end)

CreateThread(function()
    local player = GetPlayerPed(-1)
    ClearPedTasks(player)
    while true do
        local Idle =500
        if inAutoPilot then
            Idle = 1
            if IsControlJustPressed(1,38) then
                local player = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(player,false)
                ClearPedTasks(player)
                inAutoPilot = false
                CoordsAutoPilot = false
                TriggerEvent("Notify:Text","")
            end
            local blip = GetFirstBlipInfoId(8)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local dist = #(vector3(coords.x, coords.y, coords.z) - vector3(CoordsAutoPilot.x, CoordsAutoPilot.y, coords.z))
            if dist <= 10 then
                local player = GetPlayerPed(-1)
                local vehicle = GetVehiclePedIsIn(player,false)
                ClearPedTasks(player)
                
                SetVehicleForwardSpeed(vehicle,19.0)
                Wait(200)
                SetVehicleForwardSpeed(vehicle,15.0)
                Wait(200)
                SetVehicleForwardSpeed(vehicle,11.0)
                Wait(200)
                SetVehicleForwardSpeed(vehicle,6.0)
                Wait(200)
                SetVehicleForwardSpeed(vehicle,0.0)
                inAutoPilot = false
                CoordsAutoPilot = false
                TriggerEvent("Notify:Text","")
            end
        end
        Wait(Idle)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANCASH
-----------------------------------------------------------------------------------------------------------------------------------------
local CleanCashCoords = {
    vector3(-1037.58,-2737.58,20.17),
}

local Table = {}
CreateThread(function()

    for i=1, #CleanCashCoords do
        Table[i] = {
            CleanCashCoords[i].x,
            CleanCashCoords[i].y,
            CleanCashCoords[i].z,
            5.0,
            "E",
            "Lavar Dinheiro",
            "Pressione para abrir",
        }
    end

    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        for i=1, #CleanCashCoords do
            if #(Coords - CleanCashCoords[i]) <= 5.0 then
                idle = 5
                if IsControlJustPressed(0,38) then
                    vSERVER.StartCleanCash()
                    LastCoord = Coords
                end
            end
        end
        Wait(idle)
    end
end)
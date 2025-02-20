-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Fuel = 0
local Speed = 0
local Locked = false
local Headlights = false
local ActualVehicle = nil
cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
local SeatbeltSpeed = 0
local SeatbeltLock = false
local SeatbeltVelocity = vec3(0,0,0)
local VehicleWeapons = {
    "VEHICLE_WEAPON_ROTORS", 
    "VEHICLE_WEAPON_TANK", 
    "VEHICLE_WEAPON_SEARCHLIGHT",
    "VEHICLE_WEAPON_RADAR",
    "VEHICLE_WEAPON_PLAYER_BULLET",
    "VEHICLE_WEAPON_PLAYER_LAZER",
    "VEHICLE_WEAPON_ENEMY_LASER",
    "VEHICLE_WEAPON_PLAYER_BUZZARD",
    "VEHICLE_WEAPON_PLAYER_HUNTER",
    "VEHICLE_WEAPON_PLANE_ROCKET",
    "VEHICLE_WEAPON_SPACE_ROCKET",
    "VEHICLE_WEAPON_TURRET_INSURGENT",
    "VEHICLE_WEAPON_PLAYER_SAVAGE",
    "VEHICLE_WEAPON_TURRET_TECHNICAL",
    "VEHICLE_WEAPON_NOSE_TURRET_VALKYRIE",
    "VEHICLE_WEAPON_TURRET_VALKYRIE",
    "VEHICLE_WEAPON_CANNON_BLAZER",
    "VEHICLE_WEAPON_TURRET_BOXVILLE",
    "VEHICLE_WEAPON_RUINER_BULLET",
    "VEHICLE_WEAPON_RUINER_ROCKET",
    "VEHICLE_WEAPON_HUNTER_MG",
    "VEHICLE_WEAPON_HUNTER_MISSILE",
    "VEHICLE_WEAPON_HUNTER_CANNON",
    "VEHICLE_WEAPON_HUNTER_BARRAGE",
    "VEHICLE_WEAPON_TULA_NOSEMG",
    "VEHICLE_WEAPON_TULA_MG",
    "VEHICLE_WEAPON_TULA_DUALMG",
    "VEHICLE_WEAPON_TULA_MINIGUN",
    "VEHICLE_WEAPON_SEABREEZE_MG",
    "VEHICLE_WEAPON_MICROLIGHT_MG",
    "VEHICLE_WEAPON_DOGFIGHTER_MG",
    "VEHICLE_WEAPON_DOGFIGHTER_MISSILE",
    "VEHICLE_WEAPON_MOGUL_NOSE",
    "VEHICLE_WEAPON_MOGUL_DUALNOSE",
    "VEHICLE_WEAPON_MOGUL_TURRET",
    "VEHICLE_WEAPON_MOGUL_DUALTURRET",
    "VEHICLE_WEAPON_ROGUE_MG",
    "VEHICLE_WEAPON_ROGUE_CANNON",
    "VEHICLE_WEAPON_ROGUE_MISSILE",
    "VEHICLE_WEAPON_BOMBUSHKA_DUALMG",
    "VEHICLE_WEAPON_BOMBUSHKA_CANNON",
    "VEHICLE_WEAPON_HAVOK_MINIGUN",
    "VEHICLE_WEAPON_VIGILANTE_MG",
    "VEHICLE_WEAPON_VIGILANTE_MISSILE",
    "VEHICLE_WEAPON_TURRET_LIMO",
    "VEHICLE_WEAPON_DUNE_MG",
    "VEHICLE_WEAPON_DUNE_GRENADELAUNCHER",
    "VEHICLE_WEAPON_DUNE_MINIGUN",
    "VEHICLE_WEAPON_TAMPA_MISSILE",
    "VEHICLE_WEAPON_TAMPA_MORTAR",
    "VEHICLE_WEAPON_TAMPA_FIXEDMINIGUN",
    "VEHICLE_WEAPON_TAMPA_DUALMINIGUN",
    "VEHICLE_WEAPON_HALFTRACK_DUALMG",
    "VEHICLE_WEAPON_HALFTRACK_QUADMG",
    "VEHICLE_WEAPON_APC_CANNON",
    "VEHICLE_WEAPON_APC_MISSILE",
    "VEHICLE_WEAPON_APC_MG",
    "VEHICLE_WEAPON_ARDENT_MG",
    "VEHICLE_WEAPON_TECHNICAL_MINIGUN",
    "VEHICLE_WEAPON_INSURGENT_MINIGUN",
    "VEHICLE_WEAPON_TRAILER_QUADMG",
    "VEHICLE_WEAPON_TRAILER_MISSILE",
    "VEHICLE_WEAPON_TRAILER_DUALAA",
    "VEHICLE_WEAPON_NIGHTSHARK_MG",
    "VEHICLE_WEAPON_OPPRESSOR_MG",
    "VEHICLE_WEAPON_OPPRESSOR_MISSILE",
    "VEHICLE_WEAPON_MOBILEOPS_CANNON",
    "VEHICLE_WEAPON_AKULA_TURRET_SINGLE",
    "VEHICLE_WEAPON_AKULA_MISSILE",
    "VEHICLE_WEAPON_AKULA_TURRET_DUAL",
    "VEHICLE_WEAPON_AKULA_MINIGUN",
    "VEHICLE_WEAPON_AKULA_BARRAGE",
    "VEHICLE_WEAPON_AVENGER_CANNON",
    "VEHICLE_WEAPON_BARRAGE_TOP_MG",
    "VEHICLE_WEAPON_BARRAGE_TOP_MINIGUN",
    "VEHICLE_WEAPON_BARRAGE_REAR_MG",
    "VEHICLE_WEAPON_BARRAGE_REAR_MINIGUN",
    "VEHICLE_WEAPON_BARRAGE_REAR_GL",
    "VEHICLE_WEAPON_CHERNO_MISSILE",
    "VEHICLE_WEAPON_COMET_MG",
    "VEHICLE_WEAPON_DELUXO_MG",
    "VEHICLE_WEAPON_DELUXO_MISSILE",
    "VEHICLE_WEAPON_KHANJALI_CANNON",
    "VEHICLE_WEAPON_KHANJALI_CANNON_HEAVY",
    "VEHICLE_WEAPON_KHANJALI_MG",
    "VEHICLE_WEAPON_KHANJALI_GL",
    "VEHICLE_WEAPON_REVOLTER_MG",
    "VEHICLE_WEAPON_WATER_CANNON",
    "VEHICLE_WEAPON_SAVESTRA_MG",
    "VEHICLE_WEAPON_SUBCAR_MG",
    "VEHICLE_WEAPON_SUBCAR_MISSILE",
    "VEHICLE_WEAPON_SUBCAR_TORPEDO",
    "VEHICLE_WEAPON_THRUSTER_MG",
    "VEHICLE_WEAPON_THRUSTER_MISSILE",
    "VEHICLE_WEAPON_VISERIS_MG",
    "VEHICLE_WEAPON_VOLATOL_DUALMG"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(eventName,args)
    if eventName ~= "CEventNetworkPlayerEnteredVehicle" then
        return
    end

    local Ped = PlayerPedId()
    
    if tonumber(args[1]) ~= PlayerId() or not LocalPlayer["state"]["Active"] then
        return
    end
    
    SetPedConfigFlag(Ped,35,false)

    -- Wait(100)
    -- if IsPedOnAnyBike(Ped) then
    --     SetPedCanBeKnockedOffVehicle(Ped,false)
    -- end

    CreateThread(function()
        while true do 
            if Display then
                local Ped = PlayerPedId()
                if IsPedInAnyVehicle(Ped) then
                    TimeDistance = 100
        
                    if not IsMinimapRendering() then
                        SetBigmapActive(false,false)
                        DisplayRadar(true)
                    end
        
                    local Vehicle = GetVehiclePedIsUsing(Ped)
                    local Rpm = GetVehicleCurrentRpm(Vehicle)
                    local VFuel = GetVehicleFuelLevel(Vehicle)
                    local VSpeed = GetEntitySpeed(Vehicle) * 3.6
                    local Plate = GetVehicleNumberPlateText(Vehicle)
                    local VLocked = GetVehicleDoorLockStatus(Vehicle)
                    local _,_,VHeadlight = GetVehicleLightsState(Vehicle)
        
                    if ActualVehicle ~= Vehicle then
                        SendNUIMessage({ Action = "Vehicle", Status = true })
                        ActualVehicle = Vehicle
                    end
        
                    if Locked ~= VLocked then
                        SendNUIMessage({ Action = "Locked", Status = VLocked })
                        Locked = VLocked
                    end
        
                    if Headlights ~= VHeadlight then
                        SendNUIMessage({ Action = "Headlight", Status = VHeadlight })
                        Headlights = VHeadlight
                    end
        
                    if Fuel ~= VFuel then
                        SendNUIMessage({ Action = "Fuel", Number = VFuel })
                        Fuel = VFuel
                    end
        
                    if Speed ~= VSpeed then
                        SendNUIMessage({ Action = "Speed", Number = VSpeed })
                        Speed = VSpeed
                    end
        
                    SendNUIMessage({ Action = "Rpm", Number = Rpm })
                else
                    if ActualVehicle then
                        ActualVehicle = nil
                        SendNUIMessage({ Action = "Vehicle", Status = false })
        
                        Drift = false
                        SendNUIMessage({ Action = "Drift", Status = false })
        
                        Locked = false
                        SendNUIMessage({ Action = "Locked", Status = false })
        
                        Headlights = false
                        SendNUIMessage({ Action = "Headlight", Status = 0, Beam = 0 })
        
                        Speed = 0
                        SendNUIMessage({ Action = "Speed", Number = 0 })
        
                        if IsMinimapRendering() then
                            DisplayRadar(false)
                        end
                        break
                    end
                end
            end
            Wait(1)
        end
    end)

    CreateThread(function()
        while true do
            if IsPedInAnyVehicle(Ped) then
                local veh = GetVehiclePedIsUsing(Ped)
                if DoesVehicleHaveWeapons(veh) then
                    for i=1, #VehicleWeapons do
                        local Weapon = GetHashKey(VehicleWeapons[i])
                        local atual_veh = GetPlayersLastVehicle()
                        if not IsVehicleModel(atual_veh,GetHashKey("firetruk")) then
                            DisableVehicleWeapon(true, Weapon, veh, Ped)	
                        end
                    end
                end
            else
                break
            end
            Wait(500)
        end
    end)


    CreateThread(function()
        while true do
            if IsPedInAnyVehicle(Ped) then
                wait = 0
                local veh = GetVehiclePedIsUsing(Ped)
                if DoesVehicleHaveWeapons(veh) == 1 and vehicleweaponhash ~= 1422046295 then
                    vehicleweapon, vehicleweaponhash = GetCurrentPedVehicleWeapon(Ped)
                    if vehicleweapon == 1 then
                        local atual_veh = GetPlayersLastVehicle()

                        if not IsVehicleModel(atual_veh,GetHashKey("firetruk")) then
                            DisableVehicleWeapon(true, vehicleweaponhash, veh, Ped)
                        end
                    end
                end
            else
                break
            end
            Wait(500)
        end
    end)

    if not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyPlane(Ped) then
        CreateThread(function()
            while true do
                if IsPedInAnyVehicle(Ped) then
                    local Vehicle = GetVehiclePedIsUsing(Ped)
                    local Speed = GetEntitySpeed(Vehicle) * 3.6

                    if Speed ~= SeatbeltSpeed then
                        if (SeatbeltSpeed - Speed) >= 60 and not SeatbeltLock then
                            SmashVehicleWindow(Vehicle,6)
                            SetEntityNoCollisionEntity(Ped,Vehicle,false)
                            SetEntityNoCollisionEntity(Vehicle,Ped,false)
                            TriggerServerEvent("hud:VehicleEject",SeatbeltVelocity)

                            Wait(500)

                            SetEntityNoCollisionEntity(Ped,Vehicle,true)
                            SetEntityNoCollisionEntity(Vehicle,Ped,true)
                        end

                        SeatbeltVelocity = GetEntityVelocity(Vehicle)
                        SeatbeltSpeed = Speed
                    end
                else
                    if SeatbeltSpeed ~= 0 then
                        SeatbeltSpeed = 0
                    end
    
                    if SeatbeltLock then
                        SendNUIMessage({ Action = "Seatbelt", Status = false })
                        SeatbeltLock = false
                    end

                    break
                end
                Wait(1)
            end
        end)
    end

    -- CreateThread(function()
    --     while true do
    --         if IsPedInAnyVehicle(Ped) then
    --             if IsPedOnAnyBike(Ped) then
    --                 SetPedConfigFlag(Ped, 32, false)
    --                 SetPedCanBeKnockedOffVehicle(Ped,true)
    --             end
    --         else
    --             SetPedCanBeKnockedOffVehicle(Ped,false)
    --             break
    --         end
    --         Wait(1)
    --     end
    -- end)

    if GlobalState["DriveBy"] then 
        CreateThread(function()
            local Player = PlayerId()
            while true do
                if IsPedInAnyVehicle(Ped) then
                    local Vehicle = GetVehiclePedIsUsing(Ped)
                    local Speed = GetEntitySpeed(Vehicle) * 3.6
                    if Speed < 150 then
                        DisablePlayerFiring(Ped, true)
                        DisableControlAction(0, 24,  true)
                        DisableControlAction(0, 92,  true)
                    end
                else
                    break
                end
                Wait(1)
            end
        end)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Betzado",function(source)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyPlane(Ped) then
        if SeatbeltLock then
            TriggerEvent("sounds:Private","unbelt",0.5)
            SendNUIMessage({ Action = "Seatbelt", Status = false })
            SeatbeltLock = false
        else
            TriggerEvent("sounds:Private","belt",0.5)
            SendNUIMessage({ Action = "Seatbelt", Status = true })
            SeatbeltLock = true
        end
	end
end)

RegisterKeyMapping("Betzado","Cinto de segurança.","keyboard","G")
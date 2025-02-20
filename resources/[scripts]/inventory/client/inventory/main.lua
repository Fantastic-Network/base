-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local ClientInventory = {}
Tunnel.bindInterface("inventory",ClientInventory)
local vGARAGE = Tunnel.getInterface("garages")
local vSERVER = Tunnel.getInterface("inventory")
local Player = GetPlayerServerId(PlayerId())
local SafeMode = GetConvar("SafeMode", "")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Types = ""
local Weapon = ""
local UseSlots = 1
local Actived = false
local Backpack = false
local TakeWeapon = false
local StoreWeapon = false
local UseCooldown = GetGameTimer()
local Skins = {}
local Attachs = false

local gIsReloading = false

LocalPlayer["state"]["Buttons"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Weapons",function()
	return Weapon
end)

local Components = {
    ["WEAPON_COMBATPISTOL"] = {
        "COMPONENT_AT_PI_FLSH",
        "COMPONENT_COMBATPISTOL_CLIP_02",
        "COMPONENT_AT_AR_AFGRIP"
    },
    ["WEAPON_APPISTOL"] = {
        "COMPONENT_APPISTOL_CLIP_02",
        "COMPONENT_AT_PI_FLSH",
    },
    ["WEAPON_PISTOL50"] = {
        "COMPONENT_PISTOL50_CLIP_02",
        "COMPONENT_AT_PI_FLSH",
    },
    ["WEAPON_SNSPISTOL"] = {
        "COMPONENT_SNSPISTOL_CLIP_02",
    },
    ["WEAPON_HEAVYPISTOL"] = {
        "COMPONENT_AT_PI_FLSH_03",
        "COMPONENT_AT_PI_COMP_02",
    },
    ["WEAPON_REVOLVER_MK2"] = {
        "COMPONENT_AT_SCOPE_MACRO_MK2",
        "COMPONENT_AT_PI_FLSH",
        "COMPONENT_AT_PI_COMP_03",
    },
    ["WEAPON_SNSPISTOL_MK2"] = {
        "COMPONENT_SNSPISTOL_MK2_CLIP_02",
        "COMPONENT_AT_PI_FLSH_03",
        "COMPONENT_AT_PI_RAIL_02",
        "COMPONENT_AT_PI_COMP_02",
    },
    ["WEAPON_PISTOL_MK2"] = {
        "COMPONENT_PISTOL_MK2_CLIP_02",
        "COMPONENT_AT_PI_RAIL",
        "COMPONENT_AT_PI_FLSH_02",
        "COMPONENT_AT_PI_COMP"
    },
    ["WEAPON_VINTAGEPISTOL"] = {
        "COMPONENT_VINTAGEPISTOL_CLIP_02"
    },
    ["COMPONENT_CERAMICPISTOL_CLIP_02"] = {
        "COMPONENT_CERAMICPISTOL_CLIP_02"
    },
    ["WEAPON_SMG"] = {
        "COMPONENT_SMG_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MACRO_02",
    },
    ["WEAPON_ASSAULTSMG"] = {
        "COMPONENT_ASSAULTSMG_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MACRO",
    },
    ["WEAPON_MINISMG"] = {
        "COMPONENT_MINISMG_CLIP_02",
    },
	["WEAPON_TECPISTOL"] = {
        "COMPONENT_TECPISTOL_CLIP_02",
        "COMPONENT_AT_SCOPE_MACRO",
    },
    ["WEAPON_SMG_MK2"] = {
        "COMPONENT_SMG_MK2_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
        "COMPONENT_AT_MUZZLE_07",
        "COMPONENT_AT_SB_BARREL_02",
    },
    ["WEAPON_COMBATPDW"] = {
        "COMPONENT_COMBATPDW_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_AR_AFGRIP",
        "COMPONENT_AT_SCOPE_SMALL",
    },
    ["WEAPON_PUMPSHOTGUN"] = {
        "COMPONENT_AT_AR_FLSH"
    },
    ["WEAPON_ASSAULTSHOTGUN"] = {
        "COMPONENT_ASSAULTSHOTGUN_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_AR_AFGRIP",
    },
    ["WEAPON_BULLPUPSHOTGUN"] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_AR_AFGRIP",
    },
    ["WEAPON_PUMPSHOTGUN_MK2"] = {
        "COMPONENT_AT_SCOPE_SMALL_MK2",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_MUZZLE_08",
    },
    ["WEAPON_HEAVYSHOTGUN"] = {
        "COMPONENT_HEAVYSHOTGUN_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_AR_AFGRIP",
    },
    ["WEAPON_COMBATSHOTGUN"] = {
        "COMPONENT_AT_AR_FLSH"
    },
    ["WEAPON_ASSAULTRIFLE"] = {
        "COMPONENT_ASSAULTRIFLE_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MACRO",
        "COMPONENT_AT_AR_AFGRIP",
    },
    ["WEAPON_CARBINERIFLE"] = {
        "COMPONENT_CARBINERIFLE_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MEDIUM",
        "COMPONENT_AT_AR_AFGRIP",
    },
    ["WEAPON_ADVANCEDRIFLE"] = {
        "COMPONENT_ADVANCEDRIFLE_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_SMALL",
    },
    ["WEAPON_SPECIALCARBINE"] = {
        "COMPONENT_SPECIALCARBINE_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MEDIUM",
        "COMPONENT_AT_AR_AFGRIP_02",
        "COMPONENT_AT_SC_BARREL_02",
        "COMPONENT_AT_MUZZLE_07",
    },
	["WEAPON_SPECIALCARBINE_MK2"] = {
        "COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MEDIUM",
    },
    ["WEAPON_ASSAULTRIFLE_MK2"] = {
        "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
        "COMPONENT_AT_AR_AFGRIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MEDIUM_MK2",
        "COMPONENT_AT_AR_BARREL_02",
        "COMPONENT_AT_MUZZLE_07",
    },
    ["WEAPON_CARBINERIFLE_MK2"] = {
        "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
        "COMPONENT_AT_AR_AFGRIP_02",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MEDIUM_MK2",
        "COMPONENT_AT_CR_BARREL_02",
        "COMPONENT_AT_MUZZLE_07",
    },
    ["WEAPON_MICROSMG"] = {
        "COMPONENT_MICROSMG_CLIP_02",
        "COMPONENT_AT_PI_FLSH",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_SCOPE_MACRO",
    },
    ["WEAPON_COMPACTRIFLE"] = {
        "COMPONENT_COMPACTRIFLE_CLIP_02"
    },
    ["WEAPON_MILITARYRIFLE"] = {
        "COMPONENT_MILITARYRIFLE_CLIP_02",
        "COMPONENT_MILITARYRIFLE_SIGHT_01",
        "COMPONENT_AT_SCOPE_SMALL",
        "COMPONENT_AT_AR_FLSH",
    },
	["WEAPON_TACTICALRIFLE"] = {
        "COMPONENT_TACTICALRIFLE_CLIP_02",
        "COMPONENT_AT_AR_FLSH_REH",
        "COMPONENT_AT_AR_AFGRIP",
    },
    ["WEAPON_MG"] = {
        "COMPONENT_MG_CLIP_02",
        "COMPONENT_AT_SCOPE_SMALL_02",
    },
    ["WEAPON_COMBATMG"] = {
        "COMPONENT_COMBATMG_CLIP_02",
        "COMPONENT_AT_SCOPE_MEDIUM",
        "COMPONENT_AT_AR_AFGRIP",
    },
    ["WEAPON_COMBATMG_MK2"] = {
        "COMPONENT_COMBATMG_MK2_CLIP_02",
        "COMPONENT_AT_AR_AFGRIP_02",
        "COMPONENT_AT_SCOPE_MEDIUM_MK2",
        "COMPONENT_AT_MUZZLE_07",
        "COMPONENT_AT_MG_BARREL_02",
    },
    ["WEAPON_GUSENBERG"] = {
        "COMPONENT_GUSENBERG_CLIP_02"
    },
    -- ["WEAPON_SNIPERRIFLE"] = {
    --     "COMPONENT_SNIPERRIFLE_CLIP_01",
    --     "COMPONENT_AT_SCOPE_MAX",
    -- },
    ["WEAPON_HEAVYSNIPER"] = {
        "COMPONENT_AT_SCOPE_MAX"
    },
    ["WEAPON_MARKSMANRIFLE_MK2"] = {
        "COMPONENT_MARKSMANRIFLE_MK2_CLIP_02",
        "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_AR_AFGRIP_02",
        "COMPONENT_AT_MRFL_BARREL_02",
        "COMPONENT_AT_MUZZLE_07",
    },
    ["WEAPON_HEAVYSNIPER_MK2"] = {
        "COMPONENT_HEAVYSNIPER_MK2_CLIP_02",
        "COMPONENT_AT_SCOPE_MAX",
        "COMPONENT_AT_SR_BARREL_02",
        "COMPONENT_AT_MUZZLE_09",
    },
    ["WEAPON_MARKSMANRIFLE"] = {
        "COMPONENT_MARKSMANRIFLE_CLIP_02",
        "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM",
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_AR_AFGRIP",
    },
    ["WEAPON_GRENADELAUNCHER"] = {
        "COMPONENT_AT_AR_FLSH",
        "COMPONENT_AT_AR_AFGRIP",
        "COMPONENT_AT_SCOPE_SMALL",
    },
    ["WEAPON_MACHINEPISTOL"] = {
        "COMPONENT_MACHINEPISTOL_CLIP_02"
    }
}

RegisterNetEvent("inventory:UpdateSkins")
AddEventHandler("inventory:UpdateSkins",function(Data)
    SetResourceKvp("Skins",json.encode(Data) or '{}')
    print(GetResourceKvpString("Skins"))
    Skins = json.decode(GetResourceKvpString("Skins") or '{}') or {}
end)

RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function()
    Attachs = GetResourceKvpInt("Attachs")
    if Attachs == 1 then
        TriggerEvent("Notify2","#attachsActivated")
        Attachs = true
    end
    Skins = json.decode(GetResourceKvpString("Skins") or '{}') or {}
    for Weapon,Model in pairs(Skins) do
        if Weapon and Model then
            CreateThread(function()
                local Hash = GetHashKey(Model)
                if Hash then
                    RequestModel(Hash)
                    local Count = 0
                    while not HasModelLoaded(Hash) do
                        Count += 1
                        if Count == 1000 then
                            break
                        end
                        Wait(10)
                    end
                end
            end)
        end
    end
end)

AddEventHandler("onClientResourceStart",function(Resource)
    if GetCurrentResourceName() == Resource then
        Attachs = GetResourceKvpInt("Attachs")
        if Attachs == 1 then
            Attachs = true
        end
        Skins = json.decode(GetResourceKvpString("Skins") or '{}') or {}
        for Weapon,Model in pairs(Skins) do
            if Weapon and Model then
                CreateThread(function()
                    local Hash = GetHashKey(Model)
                    if Hash then
                        RequestModel(Hash)
                        local Count = 0
                        while not HasModelLoaded(Hash) do
                            Count += 1
                            if Count == 1000 then
                                break
                            end
                            Wait(10)
                        end
                    end
                end)
            end
        end
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
--------------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Attachs")
AddEventHandler("inventory:Attachs",function()
    if Attachs == false then
		TriggerEvent("Notify2","#attachsActivated")
        Attachs = true
        SetResourceKvpInt("Attachs", true)
    else
        Attachs = false
		TriggerEvent("Notify2","#attachsDisabled")
        SetResourceKvpInt("Attachs", false)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	vSERVER.Cancel()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:VerifyObjects")
AddEventHandler("inventory:VerifyObjects",function(Entity,Service)
	vSERVER.VerifyObjects(Entity,Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Loot")
AddEventHandler("inventory:Loot",function(Entity,Service)
	vSERVER.Loot(Entity,Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:StealTrunk")
AddEventHandler("inventory:StealTrunk",function(Entity)
	vSERVER.StealTrunk(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STOREOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:StoreObjects")
AddEventHandler("inventory:StoreObjects",function(Number)
	vSERVER.StoreObjects(Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:MakeProducts")
AddEventHandler("inventory:MakeProducts",function(Service)
	vSERVER.MakeProducts(Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Dismantle")
AddEventHandler("inventory:Dismantle",function(entity)
    if not entity or not type(entity) == "table" or not entity[3] then
        return
    end
    if not DoesEntityExist(entity[3]) then
        return 
    end
    if LocalPlayer["state"]["InSafeZone"] or LocalPlayer["state"]["inSafeMode"] or LocalPlayer["state"]["PVP"] then
        return
    end
    if LocalPlayer["state"]["Route"] == 7 then
        TriggerEvent("Notify","vermelho","Você não pode desmanchar se estiver no mundo safe",5000,"MODO SAFE")
		-- TriggerEvent("Notify2","#cantDismantle")
        return
    end
    vSERVER.Dismantle(entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RemoveTyres")
AddEventHandler("inventory:RemoveTyres",function(Entity)
	vSERVER.RemoveTyres(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:WEAPONCOLOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:WeaponColor")
AddEventHandler("inventory:WeaponColor",function(Color)
	if Weapon ~= "" then
		SetPedWeaponTintIndex(PlayerPedId(),Weapon,Color)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CleanWeapons")
AddEventHandler("inventory:CleanWeapons",function()
	if Weapon ~= "" then
		RemoveAllPedWeapons(PlayerPedId(),true)
	end

	TriggerEvent("hud:Weapon",false)
	Actived = false
	Weapon = ""
	Types = ""
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()

		if LocalPlayer["state"]["Buttons"] then
			TimeDistance = 1
			DisableControlAction(1,75,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(Ped,true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	Backpack = false
	toggleInventory(nil)
end)

AddEventHandler("inventory:CloseAll", function()
	TriggerEvent("inventory:Close")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Craft",function(Data,Callback)
  if not LocalPlayer["state"]["Active"] then
    return
  end

	TriggerEvent("inventory:Close")
	TriggerEvent("crafting:Inventory")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Slot")
AddEventHandler("inventory:Slot",function(Number,Amount)
	UseSlots = parseInt(Number)
	vSERVER.UseItem(Number,Amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deliverItem",function(Data,Callback)
	local item = Data["item"]
	if not LocalPlayer["state"]["Active"] then
		return
	end
	vSERVER.Deliver(item["slot"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(Data,Callback)
	local item = Data["item"]
	if LocalPlayer["state"]["Active"] and GetGameTimer() >= UseCooldown then
		TriggerEvent("inventory:Slot",item["slot"],item["amount"])
		UseCooldown = GetGameTimer() + 1000
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(Data,Callback)
	local item = Data["item"]
    if not LocalPlayer["state"]["Active"] then
        return
    end
	vSERVER.SendItem(item["slot"],item["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlotMain",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
	vRPS.invUpdate(Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("destructItem",function(Data,Callback)
	local item = Data["item"]
    if not LocalPlayer["state"]["Active"] then
        return
    end
	vSERVER.RemoveItem(item["key"], item["slot"],item["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(action)
	SendNUIMessage({ action = "updateInventory" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon",function(Item)
	local Split = splitString(Item,"-")
	local Name = Split[1]

	if Weapon == Name then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
		if not vSERVER.verifyWeapon(Weapon,Ammo) then
			TriggerEvent("inventory:CleanWeapons")
		end
	else
		if Weapon == "" then
			vSERVER.verifyWeapon(Name)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:preventWeapon")
AddEventHandler("inventory:preventWeapon",function()
	if Weapon ~= "" then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

		TriggerEvent("inventory:CreateWeapon",Weapon)
		vSERVER.preventWeapon(Weapon,Ammo)
		TriggerEvent("hud:Weapon",false)
		RemoveAllPedWeapons(Ped,true)

		Actived = false
		Weapon = ""
		Types = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("inv",function()
  if not LocalPlayer["state"]["Active"] then
    return
  end
    if GlobalState["Restarting"] then
        return false
    end
	if not Backpack and not IsPauseMenuActive() and GetEntityHealth(PlayerPedId()) > 100 and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) then
		Backpack = true
		toggleInventory("ground")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("inv","Manusear a mochila.","keyboard","OEM_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				local vehTyres = {}

				for i = 0,7 do
					local Status = false

					-- if GetTyreHealth(Vehicle,i) ~= 1000.0 then
					-- 	Status = true
					-- end

					-- vehTyres[i] = Status
				end

				local Fuel = GetVehicleFuelLevel(Vehicle)

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				SetVehicleFuelLevel(Vehicle,Fuel)

				-- for Tyre,Burst in pairs(vehTyres) do
				-- 	if Burst then
				-- 		SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
				-- 	end
				-- end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRTYRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTyre")
AddEventHandler("inventory:repairTyre",function(Vehicle,Tyres,Plate)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				for i = 0,7 do
					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						SetVehicleTyreBurst(Vehicle,i,true,1000.0)
					end
				end

				SetVehicleTyreFixed(Vehicle,Tyres)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairPlayer")
AddEventHandler("inventory:repairPlayer",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleEngineHealth(Vehicle,1000.0)
				SetVehicleBodyHealth(Vehicle,1000.0)
				SetEntityHealth(Vehicle,1000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				local Fuel = GetVehicleFuelLevel(Vehicle)

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)
                SetVehicleOnGroundProperly(Vehicle)
				SetVehicleFuelLevel(Vehicle,Fuel)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEALARM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:vehicleAlarm")
AddEventHandler("inventory:vehicleAlarm",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleAlarm(Vehicle,true)
				StartVehicleAlarm(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.parachuteColors()
	GiveWeaponToPed(PlayerPedId(),"GADGET_PARACHUTE",1,false,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local fishCoords = PolyZone:Create({
    vector2(1318.18, 6687.12),
    vector2(1555.30, 6695.45),
    vector2(1534.09, 6847.73),
    vector2(1315.15, 6849.24)
   },{ name = "Pescaria",
   debugGrid=false, }
)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.fishingCoords()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	if fishCoords:isPointInside(Coords) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.fishingAnim()
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.returnWeapon()
	if Weapon ~= "" then
		return Weapon
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.checkWeapon(Hash)
	if Weapon == Hash then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAttachs = {
	["attachsFlashlight"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_M9A3"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_03",
		["WEAPON_PISTOL50"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_NSR"] = "COMPONENT_NSR_AT_AR_FLSH",
		["WEAPON_SCARH"] = "COMPONENT_SCARH_AT_AR_FLSH",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_TACTICALRIFLE"] = "COMPONENT_AT_AR_FLSH_REH",
		["WEAPON_MILITARYRIFLE"] = "COMPONENT_AT_AR_FLSH",
	},
	["attachsCrosshair"] = {
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_RAIL",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_RAIL_02",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_MP9"] = "COMPONENT_MP9_AT_SCOPE_MACRO",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_SCOPE_SMALL",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MACRO_02_MK2",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_NAVYCARBINE"] = "COMPONENT_NAVYCARBINE_SIGHT_01",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SCOPE_SMALL_MK2",
		["WEAPON_SMG"] = "COMPONENT_AT_SCOPE_MACRO_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_SCARH"] = "COMPONENT_SCARH_AT_SCOPE_MEDIUM",
		["WEAPON_SCARH"] = "COMPONENT_SCARH_AT_SCOPE_MACRO",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_MILITARYRIFLE"] = "COMPONENT_MILITARYRIFLE_SIGHT_01",
		["WEAPON_TECPISTOL"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_SNIPERRIFLE"] = "COMPONENT_AT_SCOPE_MAX",
	},
	["attachsMagazine"] = {
		["WEAPON_PISTOL"] = "COMPONENT_PISTOL_CLIP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_PISTOL_MK2_CLIP_02",
		["WEAPON_COMPACTRIFLE"] = "COMPONENT_COMPACTRIFLE_CLIP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_APPISTOL_CLIP_02",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_HEAVYPISTOL_CLIP_02",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_MACHINEPISTOL_CLIP_02",
		["WEAPON_MICROSMG"] = "COMPONENT_MICROSMG_CLIP_02",
		["WEAPON_MINISMG"] = "COMPONENT_MINISMG_CLIP_02",
		["WEAPON_MP9"] = "COMPONENT_MP9_CLIP_02",
		["WEAPON_SNSPISTOL"] = "COMPONENT_SNSPISTOL_CLIP_02",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_SNSPISTOL_MK2_CLIP_02",
		["WEAPON_VINTAGEPISTOL"] = "COMPONENT_VINTAGEPISTOL_CLIP_02",
		["WEAPON_PISTOL50"] = "COMPONENT_PISTOL50_CLIP_02",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_COMBATPISTOL_CLIP_02",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_CARBINERIFLE_CLIP_02",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
		["WEAPON_ADVANCEDRIFLE"] = "COMPONENT_ADVANCEDRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_BULLPUPRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_SPECIALCARBINE_CLIP_02",
		["WEAPON_SMG"] = "COMPONENT_SMG_CLIP_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_SMG_MK2_CLIP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_ASSAULTRIFLE_CLIP_02",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
		["WEAPON_SCARH"] = "COMPONENT_SCARH_CLIP_02",
		["WEAPON_SCORPIONEVO"] = "COMPONENT_SCORPIONEVO_CLIP_02",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_ASSAULTSMG_CLIP_02",
		["WEAPON_GUSENBERG"] = "COMPONENT_GUSENBERG_CLIP_02",
		["WEAPON_TACTICALRIFLE"] = "COMPONENT_TACTICALRIFLE_CLIP_02",
		["WEAPON_MILITARYRIFLE"] = "COMPONENT_MILITARYRIFLE_CLIP_02",
		["WEAPON_TECPISTOL"] = "COMPONENT_TECPISTOL_CLIP_02",
	},
	["attachsSilencer"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_M9A3"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SR_SUPP_03",
		["WEAPON_SMG"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_MP9"] = "COMPONENT_MP9_AT_AR_SUPP_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_SCARH"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_NSR"] = "COMPONENT_NSR_AT_AR_SUPP",
		["WEAPON_COLTXM177"] = "COMPONENT_COLTXM177_SUPP",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_TACTICALRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_MILITARYRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_TECPISTOL"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_SNIPERRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
	},
	["attachsGrip"] = {
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_MUZZLE_08",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_SCARH"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02",
		["WEAPON_TACTICALRIFLE"] = "COMPONENT_AT_AR_AFGRIP",
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.checkAttachs(nameItem,nameWeapon)
	return weaponAttachs[nameItem][nameWeapon]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.putAttachs(nameItem,nameWeapon)
	GiveWeaponComponentToPed(PlayerPedId(),nameWeapon,weaponAttachs[nameItem][nameWeapon])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Rifles = {
    ["WEAPON_SPECIALCARBINE_MK2"] = true,
	["WEAPON_SPECIALCARBINE"] = true,
	["WEAPON_CARBINERIFLE_MK2"] = true,
	["WEAPON_CARBINERIFLE"] = true,
	["WEAPON_ASSAULTRIFLE"] = true,
	["WEAPON_ASSAULTRIFLE_MK2"] = true,
	["WEAPON_TACTICALRIFLE"] = true,
	["WEAPON_PUMPSHOTGUN_MK2"] = true,
	["WEAPON_PUMPSHOTGUN"] = true,
	["WEAPON_SNIPERRIFLE"] = true,
}
function ClientInventory.putWeaponHands(weaponName,weaponAmmo,attachs,weaponType)
    local Ped = PlayerPedId()
    if LocalPlayer["state"]["Route"] == 7 then
        TriggerEvent("Notify","vermelho","Você não pode equipar armas no mundo safe",5000,"MODO SAFE")
		-- TriggerEvent("Notify2","#cannotEquipWeaponOnSafe")
        return
    end
    if SafeMode == "true" then
        if GlobalState["WarMode"] then
            if LocalPlayer["state"]["InSafeZone"] then
                TriggerEvent("Notify","vermelho","Você precisa entrar no <b>Modo Guerra</b> para poder usar armas -> F9/Outros/Modo Guerra",5000,"MODO GUERRA")
				-- TriggerEvent("Notify2","#enterWarModeToWeapon")
                return
            else
                if not Entity(Ped)["state"]["WarMode"] then
                    TriggerEvent("Notify","vermelho","Você precisa entrar no <b>Modo Guerra</b> para poder usar armas -> F9/Outros/Modo Guerra",5000,"MODO GUERRA")
					-- TriggerEvent("Notify2","#enterWarModeToWeapon")
                    return
                end
            end
        else
            if LocalPlayer["state"]["InSafeZone"] or LocalPlayer["state"]["Newbie"] then
                TriggerEvent("Notify","vermelho","Você não pode fazer isso dentro de uma safezone.",5000,"SAFEZONE")
				-- TriggerEvent("Notify2","#cantInSafe")
                return
            end
        end
    end
	if type(weaponName) ~= "string" then
		weaponName = GetWeapontypeModel(weaponName)
	end
	if not TakeWeapon then
		if not weaponAmmo then
			weaponAmmo = 0
		end

		if weaponAmmo > 0 then
			Actived = true
		end

		TakeWeapon = true
		LocalPlayer["state"]["Cancel"] = true
        local coords = GetEntityCoords(Ped)
        local pickupObject = CreateWeaponObject(weaponName, 0, coords.x, coords.y, coords.z - 500, true, 1.0, 0)
        local Hash = GetHashKey(weaponName)

        if Attachs then
            SetAttachs(weaponName,pickupObject)
        end
        print(weaponName,Skins[weaponName])
        if Skins[weaponName] then
            print(Skins[weaponName])
            Wait(10)
            GiveWeaponComponentToWeaponObject(pickupObject,GetHashKey(Skins[weaponName]))
            Wait(10)
        end

		if not IsPedInAnyVehicle(Ped) then
            if Rifles[weaponName] then
                if LoadAnim("reaction@intimidation@1h") then
                    TaskPlayAnim(Ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                end
                Wait(1200)
                vRP._giveWeapons({[weaponName] = {ammo = weaponAmmo}})
                GiveWeaponToPed(Ped,weaponName,weaponAmmo,false,false)
                GiveWeaponObjectToPed(pickupObject,Ped)
                SetPedAmmo(Ped,weaponName,weaponAmmo)
                SetCurrentPedWeapon(Ped,Hash,true)
                SetPedCurrentWeaponVisible(Ped, true, false, false, false)
                SetWeaponsNoAutoswap(true)
                Wait(400)
            else
                if LoadAnim("rcmjosh4") then
                    TaskPlayAnim(Ped,"rcmjosh4","josh_leadout_cop2",8.0,8.0,-1,48,0,0,0,0)
                end
                Wait(200)
                vRP._giveWeapons({[weaponName] = {ammo = weaponAmmo}})
                GiveWeaponToPed(Ped,weaponName,weaponAmmo,false,false)
                GiveWeaponObjectToPed(pickupObject,Ped)
                SetPedAmmo(Ped,weaponName,weaponAmmo)
                SetCurrentPedWeapon(Ped,Hash,true)
                SetPedCurrentWeaponVisible(Ped, true, false, false, false)
                SetWeaponsNoAutoswap(true)
            end
			Weapon = weaponName
			Wait(300)
			ClearPedTasks(Ped)
		else
			Weapon = weaponName
            vRP._giveWeapons({[weaponName] = {ammo = weaponAmmo}})
			GiveWeaponToPed(Ped,weaponName,weaponAmmo,false,false)
            GiveWeaponObjectToPed(pickupObject,Ped)
            SetPedAmmo(Ped,weaponName,weaponAmmo)
            SetCurrentPedWeapon(Ped,Hash,true)
            SetPedCurrentWeaponVisible(Ped, true, false, false, false)
            SetWeaponsNoAutoswap(true)
		end

		if weaponType then
			Types = weaponType
		end

		TakeWeapon = false
		LocalPlayer["state"]["Cancel"] = false

		if itemAmmo(weaponName) then
			TriggerEvent("hud:Weapon",true,weaponName)
		end

		if vSERVER.dropWeapons(weaponName) then
			TriggerEvent("inventory:CleanWeapons")
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.storeWeaponHands()
	if not StoreWeapon then
		StoreWeapon = true

		local Last = Weapon
		local Ped = PlayerPedId()
		LocalPlayer["state"]["Cancel"] = true

		if not IsPedInAnyVehicle(Ped) then
			if LoadAnim("weapons@pistol@") then
				TaskPlayAnim(Ped,"weapons@pistol@","aim_2_holster",8.0,8.0,-1,48,0,0,0,0)
			end

			Wait(450)

			ClearPedTasks(Ped)
		end

		local Ammos = GetAmmoInPedWeapon(Ped,Weapon)

		StoreWeapon = false
		LocalPlayer["state"]["Cancel"] = false
		TriggerEvent("inventory:CleanWeapons")

		return true,Ammos,Last
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONAMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAmmos = {
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_M9A3",
		"WEAPON_PISTOL_MK2",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_COMBATPISTOL",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL"
	},
	["WEAPON_NAIL_AMMO"] = {
		"WEAPON_NAILGUN"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_MP5K",
		"WEAPON_MP9",
		"WEAPON_SCORPIONEVO",
		"WEAPON_SMG_MK2",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL",
		"WEAPON_TECPISTOL"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_SCARH",
		"WEAPON_PARAFAL",
		"WEAPON_NSR",
		"WEAPON_NAVYCARBINE",
		"WEAPON_COLTXM177",
		"WEAPON_COMPACTRIFLE",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_BULLPUPRIFLE",
		"WEAPON_BULLPUPRIFLE_MK2",
		"WEAPON_ADVANCEDRIFLE",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTSMG",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SPECIALCARBINE_MK2",
		"WEAPON_COMBATMG_MK2",
		"WEAPON_TACTICALRIFLE",
		"WEAPON_MILITARYRIFLE"
	},
	["WEAPON_SNIPER_AMMO"] = {
		"WEAPON_SNIPERRIFLE",
	},
	["WEAPON_RPG_AMMO"] = {
		"WEAPON_GRENADELAUNCHER",
		"WEAPON_HOMINGLAUNCHER",
		"WEAPON_RAILGUN",
		"WEAPON_RAYPISTOL",
		"WEAPON_RAYCARBINE",
		"WEAPON_RAYMINIGUN",
		"WEAPON_RPG"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_PUMPSHOTGUN_MK2",
		"WEAPON_SAWNOFFSHOTGUN"
	},
	["WEAPON_MUSKET_AMMO"] = {
		"WEAPON_MUSKET"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGECHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.rechargeCheck(ammoType)
	local weaponAmmo = 0
	local weaponHash = nil
	local Ped = PlayerPedId()
	local weaponStatus = false

	if weaponAmmos[ammoType] then
		weaponAmmo = GetAmmoInPedWeapon(Ped,Weapon)

		for _,v in pairs(weaponAmmos[ammoType]) do
			if Weapon == v then
				weaponHash = Weapon
				weaponStatus = true
				break
			end
		end
	end

	return weaponStatus,weaponHash,weaponAmmo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.rechargeWeapon(Hash,Ammo)
	if type(Hash) == "string" then
		Hash = GetHashKey(Hash)
	end
	local ammoType 		= GetPedAmmoTypeFromWeapon(PlayerPedId(), Hash)
	local currentAmmo 	= GetPedAmmoByType(PlayerPedId(),ammoType)
	SetPedAmmo(PlayerPedId(), Hash, currentAmmo + Ammo)
	Actived = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		if LocalPlayer["state"]["GunGame"] or LocalPlayer["state"]["Arena"] or LocalPlayer["state"]["Rolling"] or LocalPlayer["state"]["Domination"] or LocalPlayer["state"]["DropKill"] or LocalPlayer["state"]["FFA"] then
			return
		end

		if Actived and Weapon ~= "" then
			TimeDistance = 10

			local Ped = PlayerPedId()
			local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

			local isReloadingThisFrame = IsPedReloading(Ped)

			local changedIsReloadingStateThisFrame = isReloadingThisFrame ~= gIsReloading

			if changedIsReloadingStateThisFrame then
				gIsReloading = isReloadingThisFrame

				-- print( gIsReloading and 'Starting reloading!' or 'Stopped reloading!' )

				if gIsReloading then
					TriggerServerEvent('requestPreventWeapon', Weapon, Ammo)
				end
			end

			if Ammo <= 0 or (Weapon == "WEAPON_PETROLCAN" and Ammo <= 135 and IsPedShooting(Ped)) or IsPedSwimming(Ped) then
				if Types ~= "" then
					vSERVER.removeThrowing(Types)
				else
					TriggerServerEvent('requestPreventWeapon', Weapon, Ammo)
				end

				TriggerEvent("inventory:CleanWeapons")
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local Firecracker = GetGameTimer() + (5 * 60000)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.checkCracker()
	if GetGameTimer() <= Firecracker then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker",function()
	if LoadPtfxAsset("scr_indep_fireworks") then
        if GetGameTimer() <= Firecracker then
            return true
        end
        Firecracker = GetGameTimer() + (5 * 60000)
		local Explosive = 25
		local Ped = PlayerPedId()
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,0.6,0.0)
		local Progression,Network = vRPS.CreateObject("ind_prop_firework_03",Coords["x"],Coords["y"],Coords["z"])
		if Progression then
			local Entity = LoadNetwork(Network)
			FreezeEntityPosition(Entity,true)
			PlaceObjectOnGroundProperly(Entity)
			SetModelAsNoLongerNeeded("ind_prop_firework_03")

			Wait(8000)

			repeat
				Wait(2000)
				Explosive = Explosive - 1
				UseParticleFxAssetNextCall("scr_indep_fireworks")
				StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",Coords["x"],Coords["y"],Coords["z"],0.0,0.0,0.0,2.5,false,false,false,false)
			until Explosive <= 0

			TriggerServerEvent("DeleteObject",Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.checkWater()
	return IsPedSwimming(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupSlotGround",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
	vSERVER.Pickup(Data["id"],Data["amount"],Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestUpgradeMain",function(Data,Callback)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropSlotGround",function(Data,Callback)
    if Data then
        TriggerEvent("Notify","vermelho","Você não pode dropar itens no momento.",5000,"DROP")
		-- TriggerEvent("Notify2","#cantDropItem")
        return
    end
	if not LocalPlayer["state"]["Active"] or TakeWeapon or StoreWeapon then
		return
	end

	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,Z = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

	vSERVER.Drops(Data["item"],Data["slot"],Data["amount"],Coords["x"],Coords["y"],Z)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Table")
AddEventHandler("drops:Table",function(Table)
    for Number,Info in pairs(Table) do
        local Item = Info["key"]
        Table[Number]["name"] = itemName(Item)
        Table[Number]["weight"] = itemWeight(Item)
        Table[Number]["index"] = itemIndex(Item)
    end
	Drops = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Adicionar")
AddEventHandler("drops:Adicionar",function(Number,Table)
    local Item = Table["key"]
    Table["name"] = itemName(Item)
    Table["weight"] = itemWeight(Item)
    Table["index"] = itemIndex(Item)
	Drops[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Remover")
AddEventHandler("drops:Remover",function(Number)
	if Drops[Number] then
		Drops[Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ATUALIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Atualizar")
AddEventHandler("drops:Atualizar",function(Number,Amount)
	if Drops[Number] then
		Drops[Number]["amount"] = Amount
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for _,v in pairs(Drops) do
				local Distance = #(Coords - vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3]))
				if Distance <= 50 then
					TimeDistance = 1
					DrawMarker(21,v["Coords"][1],v["Coords"][2],v["Coords"][3] + 0.25,0.0,0.0,0.0,0.0,180.0,0.0,0.25,0.35,0.25,162,124,219,200,0,0,0,1)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
local Inventario = {}
local Updated = false

RegisterNetEvent("inventory:HasToUpdate")
AddEventHandler("inventory:HasToUpdate",function()
    Updated = false
end)

RegisterNUICallback("requestInventory",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if not Updated then
        local inventario,invPeso,invMaxpeso = vSERVER.requestInventory()
        if not inventario then
            return
        end
        Inventario = { inventario, invPeso, invMaxpeso }
        Updated = true
    end
    for k,v in pairs(Inventario[1]) do
        Inventario[1][k]["name"] = itemName(v["item"])
        Inventario[1][k]["weight"] = itemWeight(v["item"])
        Inventario[1][k]["index"] = itemIndex(v["item"])
        Inventario[1][k]["max"] = itemMaxAmount(v["item"])
        Inventario[1][k]["desc"] = v["desc"] or itemDescription(v["item"])
        Inventario[1][k]["economy"] = itemEconomy(v["item"])
				Inventario[1][k]["premium"] = IsPremiumItem(v["item"])
    end
	Callback({ items = Inventario[1], type="main", weight = {
		current = Inventario[2],
		max = Inventario[3]
	}})
end)

RegisterNUICallback("requestDrop",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
	if LocalPlayer["state"]["Route"] > 900000 then
        return
	end

	local Items = {}
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,Z = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

	for Index,v in pairs(Drops) do
        local Distance = #(vec3(Coords["x"],Coords["y"],Z) - vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3]))
        if Distance <= 0.9 then
            local Number = #Items + 1

            Items[Number] = v
            Items[Number]["id"] = Index
            Items[Number]["slot"] = Number
        end
	end

    Callback({ items = Items, type = "ground", name = "Proximidade" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.wheelChair(Plate)
	local Ped = PlayerPedId()
	local heading = GetEntityHeading(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,0.75,0.0)
	local myVehicle = vGARAGE.ServerVehicle(LocalPlayer["state"]["Passport"],"wheelchair",Coords["x"],Coords["y"],Coords["z"],heading,Plate,nil,1000)

	if NetworkDoesNetworkIdExist(myVehicle) then
		local vehicleNet = NetToEnt(myVehicle)
		if NetworkDoesNetworkIdExist(vehicleNet) then
			SetVehicleOnGroundProperly(vehicleNet)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELTREADS
-----------------------------------------------------------------------------------------------------------------------------------------
local Wheelchair = false
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Model = GetEntityModel(Vehicle)
			if Model == -1178021069 then
				if not IsEntityPlayingAnim(Ped,"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester",3) then
					vRP.playAnim(true,{"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester"},true)
					Wheelchair = true
				end
			end
		else
			if Wheelchair then
				vRP.removeObjects("one")
				Wheelchair = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARISCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
local scanTable = {}
local initSounds = {}
local SoundScanner = 999
local InitScanner = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local scanCoords = {
	{ -1811.94,-968.5,1.72,357.17 },
	{ -1788.29,-958.0,3.35,328.82 },
	{ -1756.9,-942.98,6.91,311.82 },
	{ -1759.97,-910.12,7.58,334.49 },
	{ -1791.44,-904.11,5.12,39.69 },
	{ -1827.87,-900.32,2.48,68.04 },
	{ -1840.76,-882.39,2.81,51.03 },
	{ -1793.4,-819.9,7.73,328.82 },
	{ -1737.69,-791.3,9.44,317.49 },
	{ -1714.6,-784.61,9.82,306.15 },
	{ -1735.88,-757.92,10.11,2.84 },
	{ -1763.22,-764.65,9.49,65.2 },
	{ -1786.23,-782.4,8.71,99.22 },
	{ -1809.5,-798.29,7.89,104.89 },
	{ -1816.35,-827.68,6.44,141.74 },
	{ -1833.23,-856.58,3.52,147.41 },
	{ -1842.88,-869.45,2.98,144.57 },
	{ -1865.34,-858.4,2.12,99.22 },
	{ -1868.01,-835.58,3.0,51.03 },
	{ -1860.76,-810.59,4.04,8.51 },
	{ -1848.85,-790.99,6.3,348.67 },
	{ -1834.31,-767.03,8.17,337.33 },
	{ -1819.3,-742.04,8.85,331.66 },
	{ -1804.76,-713.39,9.76,331.66 },
	{ -1805.32,-695.22,10.23,348.67 },
	{ -1824.32,-685.97,10.23,36.86 },
	{ -1849.16,-699.25,9.45,85.04 },
	{ -1868.9,-716.3,8.86,110.56 },
	{ -1890.07,-736.57,6.27,124.73 },
	{ -1909.8,-759.44,3.52,130.4 },
	{ -1920.19,-782.25,2.8,144.57 },
	{ -1939.84,-765.34,1.99,85.04 },
	{ -1932.96,-746.47,3.05,8.51 },
	{ -1954.69,-722.8,3.03,28.35 },
	{ -1954.53,-688.85,4.06,11.34 },
	{ -1939.8,-651.94,8.74,351.5 },
	{ -1926.48,-627.37,10.67,348.67 },
	{ -1920.73,-615.67,10.95,340.16 },
	{ -1924.48,-596.03,11.56,51.03 },
	{ -1952.53,-597.0,11.02,70.87 },
	{ -1972.12,-609.32,8.73,102.05 },
	{ -1989.01,-629.48,5.21,124.73 },
	{ -2002.97,-659.48,3.03,141.74 },
	{ -2028.03,-658.61,1.82,107.72 },
	{ -2045.57,-637.91,2.02,65.2 },
	{ -2031.42,-618.65,3.23,0.0 },
	{ -2003.74,-603.38,6.3,328.82 },
	{ -1982.79,-588.43,10.01,317.49 },
	{ -1968.4,-565.72,11.42,323.15 },
	{ -1980.98,-545.43,11.58,5.67 },
	{ -1996.36,-552.72,11.68,17.01 },
	{ -2013.33,-573.78,8.95,102.05 },
	{ -2030.05,-604.62,3.93,133.23 },
	{ -2035.79,-626.99,3.0,150.24 },
	{ -2053.05,-626.67,2.31,113.39 },
	{ -2062.58,-596.05,3.03,45.36 },
	{ -2096.8,-579.13,2.75,53.86 },
	{ -2116.49,-559.09,2.29,48.19 },
	{ -2093.8,-539.57,3.74,22.68 },
	{ -2067.11,-526.37,6.98,328.82 },
	{ -2049.71,-516.4,9.13,308.98 },
	{ -2029.87,-507.17,11.49,300.48 },
	{ -2049.27,-492.94,11.17,11.34 },
	{ -2073.38,-483.05,9.13,42.52 },
	{ -2102.99,-470.71,6.52,56.7 },
	{ -2119.62,-451.87,6.67,48.19 },
	{ -2134.43,-460.37,5.24,93.55 },
	{ -1805.06,-936.1,2.53,189.93 },
	{ -1786.4,-932.99,4.38,269.3},
	{ -1744.87,-926.96,7.65,269.3 },
	{ -1763.18,-925.72,6.99,104.89 },
	{ -1773.65,-895.76,7.35,357.17 },
	{ -1750.28,-883.7,7.75,277.8 },
	{ -1733.24,-862.29,8.17,311.82 },
	{ -1703.01,-838.56,9.03,300.48 },
	{ -1720.85,-834.19,8.95,31.19 },
	{ -1747.12,-839.86,8.39,138.9 },
	{ -1764.27,-856.95,7.75,147.41 },
	{ -1776.27,-868.44,7.78,119.06 },
	{ -1803.86,-872.72,5.34,93.55 },
	{ -1744.12,-901.55,7.7,79.38 },
	{ -1765.09,-808.12,8.58,31.19 },
	{ -1773.17,-728.07,10.01,8.51 },
	{ -1849.14,-729.09,8.85,136.07 },
	{ -1866.65,-758.66,6.96,150.24 },
	{ -1886.42,-794.12,3.25,158.75 },
	{ -1795.97,-748.07,9.17,297.64 },
	{ -1915.8,-682.79,8.0,62.37 },
	{ -1911.86,-651.71,10.26,0.0 },
	{ -1899.29,-623.49,11.34,345.83 },
	{ -1847.11,-670.69,10.45,17.01 },
	{ -1874.69,-647.34,10.92,39.69 },
	{ -1958.9,-629.78,8.34,73.71 },
	{ -1951.39,-575.59,11.53,343.0 },
	{ -1991.28,-569.55,10.72,164.41 },
	{ -2056.68,-569.32,4.57,99.22 },
	{ -2088.29,-560.62,3.27,87.88 },
	{ -2042.45,-542.51,8.46,308.98 },
	{ -2020.91,-528.58,11.12,306.15 },
	{ -2092.91,-499.58,5.37,79.38 },
	{ -2113.6,-521.59,2.27,147.41 },
	{ -2139.09,-496.06,2.27,48.19 },
	{ -2122.44,-486.23,3.56,280.63 },
	{ -2034.27,-577.42,6.74,294.81 },
	{ -2003.72,-536.62,11.78,320.32 },
	{ -2023.41,-551.31,9.59,255.12 },
	{ -2014.0,-626.04,3.76,189.93 },
	{ -1967.67,-656.53,5.24,255.12 },
	{ -1878.77,-672.36,9.76,257.96 },
	{ -1827.96,-702.26,9.67,240.95 },
	{ -1855.87,-771.67,6.94,164.41 },
	{ -1846.08,-830.98,3.79,175.75 },
	{ -1830.72,-804.5,6.67,334.49 },
	{ -1770.76,-835.92,7.84,311.82 },
	{ -1724.61,-812.2,9.25,303.31 },
	{ -1828.9,-719.11,9.3,65.2 },
	{ -1893.81,-707.65,7.73,110.56 },
	{ -1921.84,-716.82,5.22,212.6 },
	{ -1891.7,-756.03,4.95,218.27 },
	{ -1890.51,-818.0,2.95,303.31 },
	{ -1806.69,-770.32,8.29,306.15 },
	{ -1763.57,-747.01,9.81,303.31 },
	{ -1980.27,-691.34,3.02,189.93 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATESCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateScanner")
AddEventHandler("inventory:updateScanner",function(Status)
	InitScanner = Status
	SoundScanner = 999
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if InitScanner then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for k,v in pairs(scanTable) do
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 7.25 then
						SoundScanner = 1000

						if not initSounds[k] then
							initSounds[k] = true
						end

						if Distance <= 1.25 then
							TimeDistance = 1
							SoundScanner = 250

							if IsControlJustPressed(1,38) then
								TriggerEvent("inventory:MakeProducts","scanner")

								local rand = math.random(#scanCoords)
								scanTable[k] = scanCoords[rand]
								initSounds[k] = nil
								SoundScanner = 999
							end
						end
					else
						if initSounds[k] then
							initSounds[k] = nil
							SoundScanner = 999
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNERSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if InitScanner and (SoundScanner == 1000 or SoundScanner == 250) then
			PlaySoundFrontend(-1,"MP_IDLE_TIMER","HUD_FRONTEND_DEFAULT_SOUNDSET")
		end

		Wait(SoundScanner)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:EXPLODETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:explodeTyres")
AddEventHandler("inventory:explodeTyres",function(Network,Plate,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.tyreStatus()
	local Ped = PlayerPedId()
	if not IsPedInAnyVehicle(Ped) then
		local Vehicle = vRP.ClosestVehicle(7)
		if IsEntityAVehicle(Vehicle) then
			local Coords = GetEntityCoords(Ped)

			for Index,Tyre in pairs(tyreList) do
				local Selected = GetEntityBoneIndexByName(Vehicle,Index)
				if Selected ~= -1 then
					local CoordsWheel = GetWorldPositionOfEntityBone(Vehicle,Selected)
					local Distance = #(Coords - CoordsWheel)
					if Distance <= 1.0 then
						return true,Tyre,VehToNet(Vehicle),GetVehicleNumberPlateText(Vehicle)
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.tyreHealth(Network,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			return GetTyreHealth(Vehicle,Tyre)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOESOBJECTEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.objectExist(Coords,Hash)
	return DoesObjectOfTypeExistAtCoords(Coords["x"],Coords["y"],Coords["z"],0.35,Hash,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local ATMList = {
	["1"] = { 121.17,-3019.62,7.04 },
	["2"] = { 797.69,-767.52,26.77 },
	["3"] = { -1431.17,-447.73,35.91 },
	["4"] = { 168.55,6636.81,31.69 },
	["5"] = { -32.08,-1104.32,27.26 },
	["6"] = { 228.18,338.4,105.56 },
	["7"] = { 158.63,234.22,106.63 },
	["8"] = { -57.67,-92.62,57.78 },
	["9"] = { 356.97,173.54,103.07 },
	["10"] = { -1415.94,-212.03,46.51 },
	["11"] = { -1430.2,-211.08,46.51 },
	["12"] = { -1282.54,-210.9,42.44 },
	["13"] = { -1286.25,-213.44,42.44 },
	["14"] = { -1289.32,-226.82,42.44 },
	["15"] = { -1285.58,-224.28,42.44 },
	["16"] = { -1109.8,-1690.82,4.36 },
	["17"] = { 1686.85,4815.82,42.01 },
	["18"] = { 1701.21,6426.57,32.76 },
	["19"] = { 1171.56,2702.58,38.16 },
	["20"] = { 1172.5,2702.59,38.16 },
	["21"] = { -1091.49,2708.66,18.96 },
	["22"] = { -3144.38,1127.6,20.86 },
	["23"] = { 527.36,-160.69,57.09 },
	["24"] = { 285.45,143.39,104.17 },
	["25"] = { -846.27,-341.28,38.67 },
	["26"] = { -846.85,-340.2,38.67 },
	["27"] = { -721.06,-415.56,34.98 },
	["28"] = { -1410.34,-98.75,52.42 },
	["29"] = { -1409.78,-100.49,52.39 },
	["30"] = { -712.9,-818.92,23.72 },
	["31"] = { -710.05,-818.9,23.72 },
	["32"] = { -660.71,-854.07,24.48 },
	["33"] = { -594.58,-1161.29,22.33 },
	["34"] = { -596.09,-1161.28,22.33 },
	["35"] = { -821.64,-1081.91,11.12 },
	["36"] = { 155.93,6642.86,31.59 },
	["37"] = { 174.14,6637.94,31.58 },
	["38"] = { -283.01,6226.11,31.49 },
	["39"] = { -95.55,6457.19,31.46 },
	["40"] = { -97.3,6455.48,31.46 },
	["41"] = { -132.93,6366.52,31.48 },
	["42"] = { -386.74,6046.08,31.49 },
	["43"] = { 24.47,-945.96,29.35 },
	["44"] = { 5.24,-919.83,29.55 },
	["45"] = { 295.77,-896.1,29.22 },
	["46"] = { 296.47,-894.21,29.23 },
	["47"] = { 1138.22,-468.93,66.73 },
	["48"] = { 1166.97,-456.06,66.79 },
	["49"] = { 1077.75,-776.54,58.23 },
	["50"] = { 289.1,-1256.8,29.44 },
	["51"] = { 288.81,-1282.37,29.64 },
	["52"] = { -1571.05,-547.38,34.95 },
	["53"] = { -1570.12,-546.72,34.95 },
	["54"] = { -1305.4,-706.41,25.33 },
	["55"] = { -2072.36,-317.28,13.31 },
	["56"] = { -2295.48,358.13,174.6 },
	["57"] = { -2294.7,356.46,174.6 },
	["58"] = { -2293.92,354.8,174.6 },
	["59"] = { 2558.75,351.01,108.61 },
	["60"] = { 89.69,2.47,68.29 },
	["61"] = { -866.69,-187.75,37.84 },
	["62"] = { -867.62,-186.09,37.84 },
	["63"] = { -618.22,-708.89,30.04 },
	["64"] = { -618.23,-706.89,30.04 },
	["65"] = { -614.58,-704.83,31.24 },
	["66"] = { -611.93,-704.83,31.24 },
	["67"] = { -537.82,-854.49,29.28 },
	["68"] = { -526.62,-1222.98,18.45 },
	["69"] = { -165.15,232.7,94.91 },
	["70"] = { -165.17,234.78,94.91 },
	["71"] = { -303.25,-829.74,32.42 },
	["72"] = { -301.7,-830.01,32.42 },
	["73"] = { -203.81,-861.37,30.26 },
	["74"] = { 119.06,-883.72,31.12 },
	["75"] = { 112.58,-819.4,31.34 },
	["76"] = { 111.26,-775.25,31.44 },
	["77"] = { 114.43,-776.38,31.41 },
	["78"] = { -256.23,-715.99,33.53 },
	["79"] = { -258.87,-723.38,33.48 },
	["80"] = { -254.42,-692.49,33.6 },
	["81"] = { -28.0,-724.52,44.23 },
	["82"] = { -30.23,-723.69,44.23 },
	["83"] = { -1315.75,-834.69,16.95 },
	["84"] = { -1314.81,-835.96,16.95 },
	["85"] = { -2956.86,487.64,15.47 },
	["86"] = { -2958.98,487.73,15.47 },
	["87"] = { -3043.97,592.42,7.9 },
	["88"] = { -3241.17,997.6,12.55 },
	["89"] = { -1205.78,-324.79,37.86 },
	["90"] = { -1205.02,-326.3,37.84 },
	["91"] = { 147.58,-1035.77,29.34 },
	["92"] = { 146.0,-1035.17,29.34 },
	["93"] = { 33.55,-1345.0,29.49 },
	["94"] = { 2555.28,389.99,108.61 },
	["95"] = { 1153.65,-326.78,69.2 },
	["96"] = { -717.71,-915.66,19.21 },
	["97"] = { -56.98,-1752.09,29.42 },
	["98"] = { 381.93,326.43,103.56 },
	["99"] = { -3243.78,1009.24,12.82 },
	["100"] = { 1737.02,6413.25,35.03 },
	["101"] = { 540.4,2667.86,42.16 },
	["102"] = { 1966.81,3746.52,32.33 },
	["103"] = { 2680.45,3288.48,55.23 },
	["104"] = { 1703.0,4933.6,42.06 },
	["105"] = { -1827.3,784.88,138.3 },
	["106"] = { -3043.91,592.48,7.9 },
	["107"] = { 238.61,212.44,106.27 },
	["108"] = { 239.06,213.67,106.27 },
	["109"] = { 239.5,214.88,106.27 },
	["110"] = { 239.94,216.15,106.27 },
	["111"] = { 241.01,219.02,106.27 },
	["112"] = { 241.43,220.24,106.27 },
	["113"] = { 241.89,221.49,106.27 },
	["114"] = { 242.35,222.7,106.27 },
	["115"] = { 264.02,203.62,106.27 },
	["116"] = { 264.48,204.89,106.27 },
	["117"] = { 264.94,206.14,106.27 },
	["118"] = { 265.38,207.34,106.27 },
	["119"] = { 126.82,-1296.6,29.27 },
	["120"] = { 127.81,-1296.03,29.27 },
	["121"] = { -248.04,6327.51,32.42 },
	["122"] = { 315.09,-593.68,43.29 },
	["123"] = { -677.36,5834.58,17.32 },
	["124"] = { 472.3,-1001.57,30.68 },
	["125"] = { 468.52,-990.55,26.27 },
	["126"] = { 349.86,-594.51,28.8 },
	["127"] = { -556.12,-205.21,38.22 },
	["128"] = { 560.5,2742.61,42.87 },
	["129"] = { 2564.5,2584.79,38.08 },
	["130"] = { -1200.76,-885.44,13.26 },
	["131"] = { 821.54,-780.27,26.17 },
	["132"] = { -1243.12,-1455.52,4.31 },
	["133"] = { -1242.01,-1454.75,4.31 },
	["134"] = { -1240.89,-1453.96,4.31 },
	["135"] = { 822.93,-825.94,26.32 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATM
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.checkAtm(Coords)
	local BombZone = false
	local AtmSelected = false

	for Number,v in pairs(ATMList) do
		local Distance = #(vec3(Coords["x"],Coords["y"],Coords["z"]) - vec3(v[1],v[2],v[3]))
		if Distance <= 1.0 then
			BombZone = vec3(v[1],v[2],v[3] - 1)
			AtmSelected = Number
			break
		end
	end

	return BombZone,AtmSelected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKARMS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.CheckArms()
	return exports["player"]:Arms()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local disSelect = 1
local disPlate = nil
local disModel = nil
local disActive = false
local disVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local disCoords = {
	{ 1222.5,-704.47,60.46,280.63 },
	{ -750.75,-2596.36,13.83,147.41 }, -- Outlaws
	{ 929.65,-2383.12,22.33,357.17 }, -- Topgear
	{ 1130.51,-485.59,65.38,73.71 },
	{ 1145.64,-275.44,68.73,87.88 },
	{ 870.49,-36.63,78.54,56.7 },
	{ 686.17,270.39,93.18,240.95 },
	{ 424.75,248.87,102.97,252.29 },
	{ 320.31,344.97,104.97,164.41 },
	{ -305.23,379.3,110.1,14.18 },
	{ -585.54,526.74,107.3,215.44 },
	{ -141.85,-1415.44,30.26,119.06 },
	{ 78.27,-1442.22,29.08,323.15 },
	{ 37.9,-1627.08,29.05,320.32 },
	{ 8.93,-1758.65,29.07,48.19 },
	{ -57.56,-1845.21,26.25,320.32 },
	{ 165.33,-1862.16,23.88,155.91 },
	{ 281.15,-2081.27,16.58,110.56 },
	{ 273.47,-2569.7,5.48,204.1 },
	{ 879.22,-2174.3,30.28,172.92 },
	{ 1116.02,-1502.53,34.46,272.13 },
	{ 1318.13,-534.38,71.83,158.75 },
	{ 1272.4,-353.88,68.85,110.56 },
	{ 653.32,176.89,94.78,68.04 },
	{ 638.88,285.34,102.97,150.24 },
	{ 320.97,495.35,152.24,286.3 },
	{ -74.63,495.95,144.22,8.51 },
	{ 176.89,483.66,141.99,351.5 },
	{ 181.24,380.51,108.55,0.0 },
	{ -398.45,337.43,108.48,0.0 },
	{ -472.76,353.61,103.64,337.33 },
	{ -947.26,574.26,100.76,343.0 },
	{ -1093.13,597.22,102.83,212.6 },
	{ -1271.82,452.79,94.8,19.85 },
	{ -1452.14,533.73,118.98,243.78 },
	{ -1507.85,429.28,110.84,45.36 },
	{ -1945.59,461.12,101.76,96.38 },
	{ -2001.96,368.42,94.24,184.26 },
	{ -1325.69,275.44,63.19,221.11 },
	{ -1281.53,251.9,63.1,0.0 },
	{ -905.31,-161.16,41.65,25.52 },
	{ -1023.98,-889.95,5.43,28.35 },
	{ -1318.87,-1141.38,4.26,90.71 },
	{ -1311.98,-1262.24,4.33,17.01 },
	{ -1297.72,-1316.22,4.5,0.0 },
	{ -1245.66,-1408.65,4.08,306.15 },
	{ -1092.76,-1595.64,4.31,306.15 },
	{ -963.01,-1592.08,4.79,19.85 },
	{ -915.94,-1541.24,4.79,17.01 },
	{ -1612.04,172.37,59.56,206.93 },
	{ -1242.87,381.54,75.12,14.18 },
	{ -1486.76,40.22,54.19,345.83 },
	{ -1576.99,-81.09,53.9,272.13 },
	{ -1391.2,75.67,53.46,130.4 },
	{ -1371.61,-26.18,53.01,0.0 },
	{ -1643.74,-232.78,54.63,252.29 },
	{ -1656.27,-379.46,45.09,232.45 },
	{ -1591.38,-643.5,29.93,232.45 },
	{ -1486.49,-735.27,25.29,181.42 },
	{ -1423.37,-963.41,7.03,56.7 },
	{ -1277.8,-1149.11,6.08,113.39 },
	{ -1070.8,-1424.54,5.12,257.96 },
	{ -1069.67,-1250.98,5.49,119.06 },
	{ -1610.2,-812.21,9.81,138.9 },
	{ -2061.94,-455.86,11.44,320.32 },
	{ -2981.69,83.31,11.29,147.41 },
	{ -3045.4,111.55,11.32,320.32 },
	{ -2960.51,368.42,14.54,31.19 },
	{ -3052.28,599.99,7.11,289.14 },
	{ -3253.1,987.45,12.23,0.0 },
	{ -3236.9,1038.27,11.42,266.46 },
	{ -3156.21,1153.75,20.83,246.62 },
	{ -1819.34,785.21,137.68,223.94 },
	{ -1749.7,366.06,89.47,116.23 },
	{ -1194.9,322.62,70.48,17.01 },
	{ -1207.54,272.21,69.3,286.3 },
	{ -722.21,-76.25,37.31,243.78 },
	{ -475.64,-218.96,36.16,212.6 },
	{ -532.25,-270.6,34.98,110.56 },
	{ -465.2,-451.88,33.97,82.21 },
	{ -391.09,-456.15,30.72,127.56 },
	{ -357.4,-767.63,38.55,272.13 },
	{ -330.9,-935.02,30.85,68.04 },
	{ -27.99,-2547.6,5.78,53.86 },
	{ -140.18,-2506.08,5.76,53.86 },
	{ -168.21,-2583.56,5.76,0.0 },
	{ -219.34,-2488.65,5.76,87.88 },
	{ -340.93,-2430.9,5.76,138.9 },
	{ -434.24,-2441.94,5.76,232.45 },
	{ 124.19,-2898.73,5.76,0.0 },
	{ 237.55,-3315.73,5.56,201.26 },
	{ -556.86,-1694.1,19.23,25.52 }, -- overdrive
	{ -1153.05,-1563.71,4.36,215.44 }, -- DriftKing
	{ 150.76,-3184.91,5.63,178.59 }
}
if cityName == "Base" then
	disCoords[#disCoords+1] = { -339.34,-135.91,39.01 } -- redline
	disCoords[#disCoords+1] = { -386.08,-92.33,54.42 } -- redline
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLECATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
local DismantleCategory = {
	["B"] = {
		"panto","prairie","rhapsody","blista","dilettante","emperor2","emperor","bfinjection","ingot","regina"
	},
	["B+"] = {
		"asbo","brioso","club","weevil","felon","felon2","jackal","oracle","zion","zion2","buccaneer","virgo",
		"voodoo","bifta","rancherxl","bjxl","cavalcade","gresley","habanero","rocoto","primo","stratum","pigalle",
		"peyote","manana","streiter"
	},
	["A"] = {
		"exemplar","windsor","windsor2","blade","clique","dominator","faction2","gauntlet","moonbeam","nightshade",
		"sabregt2","tampa","rebel","baller","cavalcade2","fq2","huntley","landstalker","patriot","radi","xls","blista2",
		"retinue","stingergt","surano","specter","sultan","schwarzer","schafter2","ruston","rapidgt","raiden","ninef",
		"ninef2","omnis","massacro","jester","feltzer2","futo","carbonizzare"
	},
	["A+"] = {
		"voltic","sc1","sultanrs","tempesta","nero","nero2","reaper","gp1","infernus","bullet","banshee2","turismo2","retinue",
		"mamba","infernus2","feltzer3","coquette2","futo2","zr350","tampa2","sugoi","sultan2","schlagen","penumbra","pariah",
		"paragon","jester3","gb200","elegy","furoregt"
	},
	["S"] = {
		"zentorno","xa21","visione","vagner","vacca","turismor","t20","osiris","italigtb","entityxf","cheetah","autarch","sultan3",
		"cypher","vectre","growler","comet6","jester4","euros","calico","neon","kuruma","issi7","italigto","komoda","elegy2","coquette4"
	},
	["S+"] = {
		"mazdarx72","rangerover","civictyper","subaruimpreza","corvettec7","mustang1969","vwtouareg",
		"mercedesg65","bugattiatlantic","m8competition","audirs6","audir8","silvias15","camaro","mercedesamg63",
		"dodgechargerrt69","astonmartindbs","panameramansory","lamborghinihuracanlw","lancerevolutionx",
		"porsche911","jeepcherokee","dodgecharger1970","golfgti","subarubrz","nissangtr","mustangfast","golfmk7",
		"lancerevolution9","shelbygt500","bmwm4gts","bmwm5e34","toyotasupra2","escalade2021",
		"fordmustang","mclarensenna","lamborghinihuracan","acuransx","toyotasupra","escaladegt900","bentleybacalar"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.Dismantle(Experience)
	if not disActive then
		disActive = true
		disSelect = math.random(#disCoords)
		disPlate = "DISM"..(1000 + LocalPlayer["state"]["Passport"])

		local Category = ClassCategory(Experience)
		local ModelRandom = math.random(#DismantleCategory[Category])
		disModel = DismantleCategory[Category][ModelRandom]

		local RandomX = math.random(25,100)
		local RandomY = math.random(25,100)

		if math.random(2) >= 2 then
			TriggerEvent("NotifyPush",{ code = "QRU", title = "Veículo", x = disCoords[disSelect][1], y = disCoords[disSelect][2], z = disCoords[disSelect][3], vehicle = VehicleName(disModel).." - "..disPlate, blipColor = 60 })
		else
			TriggerEvent("NotifyPush",{ code = "QRU", title = "Veículo", x = disCoords[disSelect][1], y = disCoords[disSelect][2], z = disCoords[disSelect][3], vehicle = VehicleName(disModel).." - "..disPlate, blipColor = 60 })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.DismantleStatus()
	return disActive
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Disreset")
AddEventHandler("inventory:Disreset",function()
	disSelect = 1
	disPlate = nil
	disModel = nil
	disActive = false
	disVehicle = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if disActive and not disVehicle then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Distance = #(Coords - vec3(disCoords[disSelect][1],disCoords[disSelect][2],disCoords[disSelect][3]))

			if Distance <= 125 then
				disVehicle = vGARAGE.ServerVehicle(LocalPlayer["state"]["Passport"],disModel,disCoords[disSelect][1],disCoords[disSelect][2],disCoords[disSelect][3],disCoords[disSelect][4],disPlate,nil,1000)

				if NetworkDoesNetworkIdExist(disVehicle) then
					local Network = NetToEnt(disVehicle)
					if NetworkDoesNetworkIdExist(Network) then
						SetVehicleOnGroundProperly(Network)
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local disPeds = {
	"ig_abigail","a_m_m_afriamer_01","ig_mp_agent14","csb_agent","ig_amandatownley","s_m_y_ammucity_01","u_m_y_antonb","g_m_m_armboss_01",
	"g_m_m_armgoon_01","g_m_m_armlieut_01","ig_ashley","s_m_m_autoshop_01","ig_money","g_m_y_ballaeast_01","g_f_y_ballas_01","g_m_y_ballasout_01",
	"s_m_y_barman_01","u_m_y_baygor","a_m_o_beach_01","ig_bestmen","a_f_y_bevhills_01","a_m_m_bevhills_02","u_m_m_bikehire_01","u_f_y_bikerchic",
	"mp_f_boatstaff_01","s_m_m_bouncer_01","ig_brad","ig_bride","u_m_y_burgerdrug_01","a_m_m_business_01","a_m_y_business_02","s_m_o_busker_01",
	"ig_car3guy2","cs_carbuyer","g_m_m_chiboss_01","g_m_m_chigoon_01","g_m_m_chigoon_02","u_f_y_comjane","ig_dale","ig_davenorton","s_m_y_dealer_01",
	"ig_denise","ig_devin","a_m_y_dhill_01","ig_dom","a_m_y_downtown_01","ig_dreyfuss"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local disWeapons = { "WEAPON_HEAVYPISTOL","WEAPON_APPISTOL" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DisPed")
AddEventHandler("inventory:DisPed",function()
local Ped = PlayerPedId()
	local Rand = math.random(#disPeds)
	local Coords = GetEntityCoords(Ped)
	local Weapon = math.random(#disWeapons)
	local cX = Coords["x"] + math.random(-25.0,25.0)
	local cY = Coords["y"] + math.random(-25.0,25.0)
	local Hit,EntCoords = GetSafeCoordForPed(cX,cY,Coords["z"],false,16)
	local Entity = CreatePed(4,disPeds[Rand],EntCoords["x"],EntCoords["y"],EntCoords["z"],3374176)
	if Entity then
		Wait(1000)

		local NetEntity = Entity

		SetPedArmour(NetEntity,99)
		SetPedAccuracy(NetEntity,35)
		SetPedRelationshipGroupHash(NetEntity,GetHashKey("HATES_PLAYER"))
		SetPedKeepTask(NetEntity,true)
		SetCanAttackFriendly(NetEntity,false,true)
		TaskCombatPed(NetEntity,Ped,0,16)
		SetPedCombatAttributes(NetEntity,46,true)
		SetPedCombatAbility(NetEntity,0)
		SetPedCombatAttributes(NetEntity,0,true)
		GiveWeaponToPed(NetEntity,disWeapons[Weapon],-1,false,true)
		SetPedDropsWeaponsWhenDead(NetEntity,false)
		SetPedCombatRange(NetEntity,2)
		SetPedFleeAttributes(NetEntity,0,0)
		SetPedConfigFlag(NetEntity,58,true)
		SetPedConfigFlag(NetEntity,75,true)
		SetPedFiringPattern(NetEntity,-957453492)
		SetBlockingOfNonTemporaryEvents(NetEntity,true)

		SetModelAsNoLongerNeeded(disPeds[Rand])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.CheckMods(Vehicle,Mod)
	return GetNumVehicleMods(Vehicle,Mod) - 1
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCAR
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.CheckCar(Vehicle)
	local Model = GetEntityModel(Vehicle)
	return IsThisModelACar(Model)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.ActiveMods(Vehicle,Plate,Mod,Number)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleMod(Vehicle,Mod,Number)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BURGERSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
local BurgerShot = PolyZone:Create({
	vector2(-1174.21,-898.17),
	vector2(-1188.63,-908.10),
	vector2(-1198.07,-906.52),
	vector2(-1208.42,-891.13),
	vector2(-1188.37,-877.37)
},{ name = "BurgerShot" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- PIZZATHIS
-----------------------------------------------------------------------------------------------------------------------------------------
local PizzaThis = PolyZone:Create({
	vector2(793.94,-747.72),
	vector2(794.00,-768.85),
	vector2(814.90,-768.82),
	vector2(814.93,-747.62),
	vector2(812.48,-739.99),
	vector2(794.07,-740.05)
},{ name = "PizzaThis" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEANMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
local BeanMachine = PolyZone:Create({
	vector2(129.73,-1029.63),
	vector2(118.45,-1025.35),
	vector2(110.82,-1046.34),
	vector2(122.31,-1050.47)
},{ name = "BeanMachine" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- UWUCOFFEE
-----------------------------------------------------------------------------------------------------------------------------------------
local UwUCoffee = PolyZone:Create({
	vector2(-565.30,-1071.24),
	vector2(-575.38,-1070.52),
	vector2(-601.44,-1069.51),
	vector2(-601.53,-1046.78),
	vector2(-565.33,-1047.50)
},{ name = "UwUCoffee" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTAURANT
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientInventory.Restaurant(Name)
	local Return = false
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	if Name == "BurgerShot" then
		if BurgerShot:isPointInside(Coords) then
			Return = true
		end
	elseif Name == "PizzaThis" then
		if PizzaThis:isPointInside(Coords) then
			Return = true
		end
	elseif Name == "BeanMachine" then
		if BeanMachine:isPointInside(Coords) then
			Return = true
		end
	elseif Name == "UwuCoffee" then
		if UwUCoffee:isPointInside(Coords) then
			Return = true
		end
	end

	return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local amountCoords = 0
	repeat
		amountCoords = amountCoords + 1
		local rand = math.random(#scanCoords)
		scanTable[amountCoords] = scanCoords[rand]
		Wait(1)
	until amountCoords == 25
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ISONLINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("isOnline",function(Data,Callback)
    if not Data["online"] then
        TriggerEvent("all:CloseNuis")
    end
    LocalPlayer["state"]["Active"] = Data["online"]
end)

AddEventHandler("gameEventTriggered",function(eventName,args)
    if eventName ~= "CEventNetworkPlayerEnteredVehicle" then
        return
    end

    local Ped = PlayerPedId()
    
    if tonumber(args[1]) ~= PlayerId() or not LocalPlayer["state"]["Active"] then
        return
    end

    if Skins then
        CreateThread(function()
            while true do
                if not IsPedInAnyVehicle(Ped) then
                    break
                end
                Wait(100)
            end
            Wait(1000)
            GiveWeaponComponentToPed(Ped,Skins["name"],Skins["skin"])
        end)
    end
end)

function SetAttachs(WeaponName,pickupObject)
    if not Components[WeaponName] then
        return
    end
    if pickupObject then
        for i=1,#Components[WeaponName] do
            GiveWeaponComponentToWeaponObject(pickupObject,GetHashKey(Components[WeaponName][i]))
        end
    else
        for i=1,#Components[WeaponName] do
            GiveWeaponComponentToPed(PlayerPedId(),GetHashKey(Components[WeaponName][i]))
        end
    end
end

-- local StartCoords = {
--     vector3(1408.13,6715.32,14.37)
-- }

-- local Fishing = false

-- CreateThread(function()
--     LocalPlayer["state"]:set("Buttons",false,true)
--     while true do
--         local Idle = 2500
--         local Ped = PlayerPedId()
--         local Coords = GetEntityCoords(Ped)
--         local Inside = false
--         if fishCoords:isPointInside(Coords) then
--             if not InZone then
--                 InZone = true
--             end
--             Inside = true
--         end
--         if not Inside then
--             InZone = false
--         end
--         Wait(Idle)
--     end
-- end)


-- CreateThread(function()
--     local Table = {}
--     for i=1, #StartCoords do
--         Table[i] = {
--             StartCoords[i]["x"],
--             StartCoords[i]["y"],
--             StartCoords[i]["z"],
--             50.0,
--             "E",
--             "Iniciar PESCA",
--             "Pressione para iniciar",
--         }
--     end
--     TriggerEvent("hoverfy:Insert",Table)
--     while true do 
--         local idle = 2500
--         local Ped = PlayerPedId()
--         local Coords = GetEntityCoords(Ped)
--         if InZone then
--             idle = 1
--             if InZone and IsControlJustPressed(0,38) and not Fishing then
--                 Fishing = true
--                 TriggerServerEvent("player:Fishing")
--                 TriggerEvent("Notify:Text","F6 Para Cancelar Pesca")
--             end
--         end
--         Wait(idle)
--     end
-- end)

-- AddEventHandler("actions:Cancel",function()
--     if Fishing then
--         LocalPlayer["state"]:set("Buttons",false,true)
--         LocalPlayer["state"]:set("Cancel",false,true)
--         TriggerEvent("Progress","Cancelando",0)
--         TriggerEvent("hoverfy:returnHoverfy")
--         TriggerEvent("Notify:Text","")
--         Fishing = false
--         InZone = false
--         TriggerServerEvent("player:CancelFishing")
--     end
-- end)

-- RegisterNetEvent("inventory:NewFishing")
-- AddEventHandler("inventory:NewFishing",function()
--     if Fishing then
--         TriggerServerEvent("player:Fishing")
--     end
-- end)

-- RegisterNetEvent("inventory:CancelFishing")
-- AddEventHandler("inventory:CancelFishing",function()
--     if Fishing then
--         LocalPlayer["state"]:set("Buttons",false,true)
--         LocalPlayer["state"]:set("Cancel",false,true)
--         TriggerEvent("Progress","Cancelando",0)
--         TriggerEvent("hoverfy:returnHoverfy")
--         TriggerEvent("Notify:Text","")
--         Fishing = false
--         InZone = false
--         TriggerServerEvent("player:CancelFishing")
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local FPS = {}
LocalPlayer["state"]["Name"] = ""
LocalPlayer["state"]["Active"] = false
cityName = GetConvar("cityName", "Base")
cityDiscord = GetConvar("cityDiscord", "")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.SetHealth(Health)
	local Ped = PlayerPedId()
	SetEntityHealth(Ped,Health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updateHealth(Number)
	local Ped = PlayerPedId()
	local Health = GetEntityHealth(Ped)
	if Health > 100 then
		SetEntityHealth(Ped,Health + Number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.downHealth(Number)
	local Ped = PlayerPedId()
	local Health = GetEntityHealth(Ped)

	SetEntityHealth(Ped,Health - Number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.PlayingAnim(Dict,Name)
	return IsEntityPlayingAnim(PlayerPedId(),Dict,Name,3)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Skin(Hash)
	if LoadModel(Hash) then
		local Pid = PlayerId()
		local Ped = PlayerPedId()

		SetPlayerModel(Pid,Hash)
		SetPedComponentVariation(Ped,5,0,0,1)
		SetModelAsNoLongerNeeded(Hash)

		ReloadCharacter(Pid,Ped)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local CitysDiscord = {
    ["Base"] = {
        ["Discord"] = "SEU LINK AQUI",
        ["Connect"] = "SEU LINK AQUI",
        ["DiscordID"] = 0,
    },
}
RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function(Passport,Name)
    NetworkEndTutorialSession()
	TriggerEvent("hud:Passport",Passport)
	LocalPlayer["state"]["Name"] = Name
	LocalPlayer["state"]["Active"] = true
	LocalPlayer["state"]["Invincible"] = true
	LocalPlayer["state"]["Passport"] = Passport
    LocalPlayer["state"]["Loading"] = false

	CreateThread(function()
		while true do
			local Count = GetFrameCount()
			Wait(1000)
			local fps = GetFrameCount() - Count
			setFPS(fps)
		end
	end)

	SetDiscordAppId(CitysDiscord[cityName]["DiscordID"])
	SetDiscordRichPresenceAsset("Base")
	SetRichPresence("#"..Passport.." "..Name)
	SetDiscordRichPresenceAssetSmall("Base")
	SetDiscordRichPresenceAssetText("Cidade "..cityName)
	SetDiscordRichPresenceAssetSmallText("Cidade "..cityName)
    SetDiscordRichPresenceAction(0,"Entrar em nosso discord",CitysDiscord[cityName]["Discord"])
	SetDiscordRichPresenceAction(1,"Conecte na cidade",CitysDiscord[cityName]["Connect"])

	local Pid = PlayerId()
	local Ped = PlayerPedId()

	ReloadCharacter(Pid,Ped)
	SetEntityInvincible(Ped,true)
	FreezeEntityPosition(Ped,false)
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(Ped,true,false)
	Entity(Ped)["state"]:set("Passport",Passport,true)
    local Player = PlayerId()
    SetRunSprintMultiplierForPlayer(Player,1.10)
    TriggerEvent("hud:Toggle", true)
	SetTimeout(10000,function()
		SetEntityInvincible(Ped,false)
		LocalPlayer["state"]["Invincible"] = false
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()
		if GetEntityMaxHealth(Ped) ~= 400 then
			SetEntityMaxHealth(Ped,400)
			SetPedMaxHealth(Ped,400)
		end

		if GetPlayerMaxArmour(Pid) ~= 200 then
			SetPlayerMaxArmour(Pid,200)
		end

		if GetPlayerMaxStamina(Pid) ~= 100.0 then
			SetPlayerMaxStamina(Pid,100.0)
		end
		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		local Pid = PlayerId()
		local Ped = PlayerPedId()
		SetPlayerHealthRechargeMultiplier(Pid,0.0)
		SetPlayerHealthRechargeLimit(Pid,0.0)
		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RELOADCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function ReloadCharacter(Pid,Ped)
    if cityDiscord and cityDiscord ~= "" then
        AddTextEntry("FE_THDR_GTAO",cityDiscord)
    end
	-- StopAudioScenes()
	RemovePickups(Pid)
	SetMaxWantedLevel(0)
	SetRandomBoats(false)
	SetRandomTrains(false)
	SetGarbageTrucks(false)
	SetPedHelmet(Ped,false)
	SetDeepOceanScaler(0.0)
	SetPlayerTargetingMode(0)
	SetRandomEventFlag(false)
	SetPoliceRadarBlips(false)
	DistantCopCarSirens(false)
	SetWeaponsNoAutoswap(true)
	ClearPlayerWantedLevel(Pid)
	SetPoliceIgnorePlayer(Ped,true)
	SetArtificialLightsState(false)
	SetPlayerCanUseCover(Pid,false)
	SetPedSteersAroundPeds(Ped,true)
	DisableVehicleDistantlights(true)
	SetDispatchCopsForPlayer(Ped,false)
	SetAllVehicleGeneratorsActive(true)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(Ped,false)
	SetPedCanLosePropsOnDamage(Ped,false,0)
	-- SetPedCanBeKnockedOffVehicle(Ped,false)
	-- SetPedCanRagdollFromPlayerImpact(Ped,false)
	-- SetPedCanRagdoll(Ped,false)

	SetPedConfigFlag(Ped,48,true)
	SetPedConfigFlag(Ped,33,false)
	SetPedConfigFlag(Ped,461,true)
	SetPedConfigFlag(Ped,438,true)
	SetPedConfigFlag(Ped,434,true)

	SetBlipAlpha(GetNorthRadarBlip(),0)
    -- ReplaceHudColourWithRgba(242,THEME.rgb.r,THEME.rgb.g,THEME.rgb.b, 255)
    -- ReplaceHudColourWithRgba(116,THEME.rgb.r,THEME.rgb.g,THEME.rgb.b, 255)

	ClearAmbientZoneState("collision_ybmrar",false)
    SetAmbientZoneState("collision_ybmrar",false,false)
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	StartAudioScene("FBI_HEIST_H5_MUTE_AMBIENCE_SCENE")
	StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
	SetAudioFlag("DisableFlightMusic",false)
	SetAudioFlag("PoliceScannerDisabled",false)
	SetScenarioGroupEnabled("Heist_Island_Peds",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_DRIVE_SOLO",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG",true)
	SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL",true)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_01_STAGE",true)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM",true)
	SetStaticEmitterEnabled("LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM",true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones",true,true)
	SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones",true,true)

	SetWeaponDamageModifierThisFrame("WEAPON_BAT",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_KATANA",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_HAMMER",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_WRENCH",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_UNARMED",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_HATCHET",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_CROWBAR",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_MACHETE",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_POOLCUE",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_KNUCKLE",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_KARAMBIT",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_GOLFCLUB",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_BATTLEAXE",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_FLASHLIGHT",0.25)
	SetWeaponDamageModifierThisFrame("WEAPON_NIGHTSTICK",0.35)
	SetWeaponDamageModifierThisFrame("WEAPON_SMOKEGRENADE",0.0)
	SetWeaponDamageModifierThisFrame("WEAPON_STONE_HATCHET",0.25)

	for Number = 0,121 do
		EnableDispatchService(Number,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPICKUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function RemovePickups(Pid)
	local Pickups = {
		`PICKUP_AMMO_BULLET_MP`,
		`PICKUP_AMMO_FIREWORK`,
		`PICKUP_AMMO_FLAREGUN`,
		`PICKUP_AMMO_GRENADELAUNCHER`,
		`PICKUP_AMMO_GRENADELAUNCHER_MP`,
		`PICKUP_AMMO_HOMINGLAUNCHER`,
		`PICKUP_AMMO_MG`,
		`PICKUP_AMMO_MINIGUN`,
		`PICKUP_AMMO_MISSILE_MP`,
		`PICKUP_AMMO_PISTOL`,
		`PICKUP_AMMO_RIFLE`,
		`PICKUP_AMMO_RPG`,
		`PICKUP_AMMO_SHOTGUN`,
		`PICKUP_AMMO_SMG`,
		`PICKUP_AMMO_SNIPER`,
		`PICKUP_ARMOUR_STANDARD`,
		`PICKUP_CAMERA`,
		`PICKUP_CUSTOM_SCRIPT`,
		`PICKUP_GANG_ATTACK_MONEY`,
		`PICKUP_HEALTH_SNACK`,
		`PICKUP_HEALTH_STANDARD`,
		`PICKUP_MONEY_CASE`,
		`PICKUP_MONEY_DEP_BAG`,
		`PICKUP_MONEY_MED_BAG`,
		`PICKUP_MONEY_PAPER_BAG`,
		`PICKUP_MONEY_PURSE`,
		`PICKUP_MONEY_SECURITY_CASE`,
		`PICKUP_MONEY_VARIABLE`,
		`PICKUP_MONEY_WALLET`,
		`PICKUP_PARACHUTE`,
		`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,
		`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,
		`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,
		`PICKUP_PORTABLE_PACKAGE`,
		`PICKUP_SUBMARINE`,
		`PICKUP_VEHICLE_ARMOUR_STANDARD`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT`,
		`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,
		`PICKUP_VEHICLE_HEALTH_STANDARD`,
		`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,
		`PICKUP_VEHICLE_MONEY_VARIABLE`,
		`PICKUP_VEHICLE_WEAPON_APPISTOL`,
		`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,
		`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,
		`PICKUP_VEHICLE_WEAPON_GRENADE`,
		`PICKUP_VEHICLE_WEAPON_MICROSMG`,
		`PICKUP_VEHICLE_WEAPON_MOLOTOV`,
		`PICKUP_VEHICLE_WEAPON_PISTOL`,
		`PICKUP_VEHICLE_WEAPON_PISTOL50`,
		`PICKUP_VEHICLE_WEAPON_SAWNOFF`,
		`PICKUP_VEHICLE_WEAPON_SMG`,
		`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,
		`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_ADVANCEDRIFLE`,
		`PICKUP_WEAPON_APPISTOL`,
		`PICKUP_WEAPON_ASSAULTRIFLE`,
		`PICKUP_WEAPON_ASSAULTSHOTGUN`,
		`PICKUP_WEAPON_ASSAULTSMG`,
		`PICKUP_WEAPON_AUTOSHOTGUN`,
		`PICKUP_WEAPON_BAT`,
		`PICKUP_WEAPON_BATTLEAXE`,
		`PICKUP_WEAPON_BOTTLE`,
		`PICKUP_WEAPON_BULLPUPRIFLE`,
		`PICKUP_WEAPON_BULLPUPSHOTGUN`,
		`PICKUP_WEAPON_CARBINERIFLE`,
		`PICKUP_WEAPON_COMBATMG`,
		`PICKUP_WEAPON_COMBATPDW`,
		`PICKUP_WEAPON_COMBATPISTOL`,
		`PICKUP_WEAPON_COMPACTLAUNCHER`,
		`PICKUP_WEAPON_COMPACTRIFLE`,
		`PICKUP_WEAPON_CROWBAR`,
		`PICKUP_WEAPON_DAGGER`,
		`PICKUP_WEAPON_DBSHOTGUN`,
		`PICKUP_WEAPON_FIREWORK`,
		`PICKUP_WEAPON_FLAREGUN`,
		`PICKUP_WEAPON_FLASHLIGHT`,
		`PICKUP_WEAPON_GRENADE`,
		`PICKUP_WEAPON_GRENADELAUNCHER`,
		`PICKUP_WEAPON_GUSENBERG`,
		`PICKUP_WEAPON_GOLFCLUB`,
		`PICKUP_WEAPON_HAMMER`,
		`PICKUP_WEAPON_HATCHET`,
		`PICKUP_WEAPON_HEAVYPISTOL`,
		`PICKUP_WEAPON_HEAVYSHOTGUN`,
		`PICKUP_WEAPON_HEAVYSNIPER`,
		`PICKUP_WEAPON_HOMINGLAUNCHER`,
		`PICKUP_WEAPON_KNIFE`,
		`PICKUP_WEAPON_KNUCKLE`,
		`PICKUP_WEAPON_MACHETE`,
		`PICKUP_WEAPON_MACHINEPISTOL`,
		`PICKUP_WEAPON_MARKSMANPISTOL`,
		`PICKUP_WEAPON_MARKSMANRIFLE`,
		`PICKUP_WEAPON_MG`,
		`PICKUP_WEAPON_MICROSMG`,
		`PICKUP_WEAPON_MINIGUN`,
		`PICKUP_WEAPON_MINISMG`,
		`PICKUP_WEAPON_MOLOTOV`,
		`PICKUP_WEAPON_MUSKET`,
		`PICKUP_WEAPON_NIGHTSTICK`,
		`PICKUP_WEAPON_PETROLCAN`,
		`PICKUP_WEAPON_PIPEBOMB`,
		`PICKUP_WEAPON_PISTOL`,
		`PICKUP_WEAPON_PISTOL50`,
		`PICKUP_WEAPON_POOLCUE`,
		`PICKUP_WEAPON_PROXMINE`,
		`PICKUP_WEAPON_PUMPSHOTGUN`,
		`PICKUP_WEAPON_RAILGUN`,
		`PICKUP_WEAPON_REVOLVER`,
		`PICKUP_WEAPON_RPG`,
		`PICKUP_WEAPON_RAYPISTOL`,
		`PICKUP_WEAPON_RAYCARBINE`,
		`PICKUP_WEAPON_RAYMINIGUN`,
		`PICKUP_WEAPON_SAWNOFFSHOTGUN`,
		`PICKUP_WEAPON_SMG`,
		`PICKUP_WEAPON_SMOKEGRENADE`,
		`PICKUP_WEAPON_SNIPERRIFLE`,
		`PICKUP_WEAPON_SNSPISTOL`,
		`PICKUP_WEAPON_SPECIALCARBINE`,
		`PICKUP_WEAPON_TACTICALRIFLE`,
		`PICKUP_WEAPON_MILITARYRIFLE`,
		`PICKUP_WEAPON_COMBATMG_MK2`,
		`PICKUP_WEAPON_TECPISTOL`,
		`PICKUP_WEAPON_STICKYBOMB`,
		`PICKUP_WEAPON_STUNGUN`,
		`PICKUP_WEAPON_SWITCHBLADE`,
		`PICKUP_WEAPON_VINTAGEPISTOL`,
		`PICKUP_WEAPON_WRENCH`,
		`PICKUP_WEAPON_RAYCARBINE`
	}

	for Number = 1,#Pickups do
		ToggleUsePickupsForPlayer(Pid,Pickups[Number],false)
	end
end

function getAverageFPS()
	local Total = 0
	for i=1,#FPS do
		Total = Total + FPS[i]
	end

	return math.floor(Total/#FPS)
end

function setFPS(fps)
	table.insert(FPS,fps)

	if #FPS > 60 then
		table.remove(FPS,1)
		-- LocalPlayer.state:set("FPS",getAverageFPS(), true) 
	end
end

local LastCoordinate = false
local AFKtimer = 0
CreateThread(function()
    while true do
        Wait(60000)
        local Ped = PlayerPedId()
        if LastCoordinate then
            local Coords = GetEntityCoords(Ped)
            local Distance = #(LastCoordinate - Coords)
            if Distance <= 5 then
                AFKtimer = AFKtimer + 1
            else
                AFKtimer = 0
                if LocalPlayer["state"]["AFK"] then
                    TriggerServerEvent("vRP:ChangeAFK",false)
                end
            end
            if AFKtimer > 15 then
                TriggerServerEvent("vRP:ChangeAFK",true)
                TriggerEvent("Notify","azul","Você está AFK.",8000,"AFK")
				-- TriggerEvent("Notify2","#AFK")
            end
        else
            LastCoordinate = GetEntityCoords(Ped)
        end
    end
end)
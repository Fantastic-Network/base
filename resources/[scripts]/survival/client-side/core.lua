-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("survival",Creative)
local Server = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Death = false
local DeathTimer = GlobalState["DeathTimer"]
local Cooldown = GetGameTimer()
cityName = GetConvar("cityName", "Base")
local VIP = false
local Admin = false
local Vip = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(1000)
	while true do
		local TimeDistance = 999

		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			if GetEntityHealth(Ped) <= 100 then
				if not Death then
					Death = true

					local Coords = GetEntityCoords(Ped)
					NetworkResurrectLocalPlayer(Coords,0.0)

					NetworkSetFriendlyFireOption(false)
					LocalPlayer["state"]["Invincible"] = true
					SetEntityInvincible(Ped,true)
					SetEntityHealth(Ped,100)

					if LocalPlayer["state"]["Route"] < 900000 then
						DeathTimer = GlobalState["DeathTimer"]
                        if LocalPlayer["state"]["Iniciante"] then
                            DeathTimer = 10
                            TriggerEvent("Notify","azul","Putzz, você acabou desmaiando né? Fica tranquilo que cuidei das suas coisas! Tome mais cuidado da próxima vez e tente não se meter em encrencas.",28000,"Iniciante")
							-- TriggerEvent("Notify2","#deathWarning")
                        end

                        if LocalPlayer["state"]["VIPDeathTimer"] then
                            DeathTimer = LocalPlayer["state"]["VIPDeathTimer"] 
                        end
                        if LocalPlayer["state"]["AdminDeathTimer"] then
                            if LocalPlayer["state"]["AdminDeathTimer"] < DeathTimer then
                                DeathTimer = LocalPlayer["state"]["AdminDeathTimer"]
                            end
                        end

						TriggerEvent("hud:RemoveHood")
						TriggerEvent("hud:ScubaRemove")
						TriggerEvent("radio:RadioClean")
						TriggerEvent("inventory:Cancel")
						TriggerEvent("inventory:CleanWeapons")
						TriggerServerEvent("paramedic:bloodDeath")
                        exports['pma-voice']:overrideProximityCheck(function(player)
                            return false
                        end)
                        Vip = Server.GetUserVip()
					else
						DeathTimer = 5
					end

                    if not LocalPlayer["state"]["Arena"] and not LocalPlayer["state"]["FFA"] and not LocalPlayer["state"]["PVP"] and not LocalPlayer["state"]["WarSystemSpec"] and not LocalPlayer["state"]["Event"] and not LocalPlayer["state"]["1x1"] then
                        TriggerEvent("hud:Active",false)
                        SendNUIMessage({ action = "setVisible", data = true })
                        VIP = Server.GroupVIP()
                    end

					TriggerEvent("inventory:preventWeapon",false)
					vRP.playAnim(false,{"misstrevor3_beatup","guard_beatup_exit_dockworker"},true)
					TriggerEvent("inventory:Close")
				else
					TimeDistance = 1
					SetEntityHealth(Ped,100)

					DisableControlAction(1,18,true)
					DisableControlAction(1,22,true)
					DisableControlAction(1,24,true)
					DisableControlAction(1,25,true)
					DisableControlAction(1,68,true)
					DisableControlAction(1,70,true)
					DisableControlAction(1,91,true)
					DisableControlAction(1,69,true)
					DisableControlAction(1,75,true)
					DisableControlAction(1,140,true)
					DisableControlAction(1,142,true)
					DisableControlAction(1,257,true)
					DisablePlayerFiring(Ped,true)

					if not IsEntityPlayingAnim(Ped,"misstrevor3_beatup","guard_beatup_exit_dockworker",3) and not IsPedInAnyVehicle(Ped) and not IsEntityPlayingAnim(Ped,"nm","firemans_carry",3) then
						vRP.playAnim(false,{"misstrevor3_beatup","guard_beatup_exit_dockworker"},true)
					end

					if IsPedInAnyVehicle(Ped) then
						local Vehicle = GetVehiclePedIsUsing(Ped)
						if GetPedInVehicleSeat(Vehicle,-1) == Ped then
							SetVehicleEngineOn(Vehicle,false,true,true)
						end
					end
                    
                    if LocalPlayer["state"]["Arena"] then
                        TriggerEvent("arena:Death")
                    end

                    if LocalPlayer["state"]["FFA"] then
                        TriggerEvent("freeforall:Death")
                    end

                    if LocalPlayer["state"]["GunGame"] then
                        TriggerEvent("gungame:Death")
                    end

					if not LocalPlayer["state"]["Arena"] and LocalPlayer["state"]["Route"] > 900000 then
						TriggerEvent("arena:ResetStreek")
						TriggerEvent("arena:Respawn")
					end
                    
                    local inSquad = PlayerSquads()
                    
                    if inSquad then
                        DeathTimer = inSquad
                    end

					if GetGameTimer() >= Cooldown then
						Cooldown = GetGameTimer() + 1000

						if DeathTimer > 0 then
							DeathTimer = DeathTimer - 1

							if LocalPlayer["state"]["Route"] < 900000 then
                                local KillerName = LocalPlayer["state"]["Name"]
                                local KillerID = LocalPlayer["state"]["Passport"]
                                if Entity(Ped)["state"]["Killer"] then
                                    KillerName = Entity(Ped)["state"]["Killer"]["Name"]
                                    KillerID = Entity(Ped)["state"]["Killer"]["User"]
                                end

                                local ListVIP = {}

                                for vipName, vipTimer in pairs(DeathTimerVips) do
                                    local CharVipTimer = LocalPlayer["state"]["VIPDeathTimer"]
                                    if (not CharVipTimer) then
                                        ListVIP[vipName] = DeathTimer - (GlobalState["DeathTimer"] - vipTimer)
                                    elseif ((CharVipTimer - vipTimer) >= vipTimer) then
                                        ListVIP[vipName] = DeathTimer - (GlobalState["DeathTimer"] - vipTimer)
                                    end
                                end

                                if DeathTimer <= 0 then
                                    ListVIP = {}
                                    SetNuiFocus(true,true)
                                end

                                SendNUIMessage({
                                    action = "Time",
                                    data = {
                                        name = KillerName,
                                        time = DeathTimer,
                                        id = KillerID,
                                        list = ListVIP
                                    }
                                })
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)

local Locations = {
	["Pier"] = vec3(-1643.64,-1010.26,13.01),
	["Dp"] = vec3(2504.85,-384.38,94.12),
	["Norte"] = vec3(1428.27,6518.05,18.85)
}

RegisterNUICallback('Locations',function(Data,CallBack)
    local Callbuttons = {}
    VIP = Server.GroupVIP()
    for Index,v in pairs(Locations) do
        Callbuttons[#Callbuttons + 1] = { name = Index }
    end
	
	Callbuttons[#Callbuttons + 1] = { name = "Facção", vip = VIP }
    local hasCustom = LocalPlayer["state"]["CustomSpawn"] and LocalPlayer["state"]["CustomSpawn"] ~= ""
    Callbuttons[#Callbuttons + 1] = { name = "Personalizado", vip = hasCustom }

    CallBack(Callbuttons)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Spawn",function(Data,Callback)
    if (Data == "Facção") and (not VIP) then
        return
    end
    if (Data == "Custom") and (not LocalPlayer["state"]["CustomSpawn"]) then
        return
    end

	if (Data == "Facção") then
        vRPS.GG2()
    elseif Data == "Custom" then
		vRPS.GG2(true)
    else
		vRPS.GG(Data)
	end

	Callback("Ok")
end)

function PlayerSquads()
    local Timer = false
    if LocalPlayer["state"]["Squads"] then
        if #LocalPlayer["state"]["Squads"] > 1 then
            local Table = LocalPlayer["state"]["Squads"]
            for Group,Time in pairs(Table) do
                if GlobalState["SquadsDT"][Group] then
                    Timer = GlobalState["SquadsDT"][Group] 
                end
            end
        end
    end
    return Timer
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckDeath()
	if Death and DeathTimer >= 0 then
		return DeathTimer
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETSECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ResetSeconds()
	DeathTimer = 60
end

local RiskArea = {
    ["Base"] = {
        {vec3(1215.54,-288.4,68.16),"Franca"}, -- Franca
		{vec3(2204.27,5573.37,53.72),"Amarelos"}, -- Amarelos
		{vec3(1939.72,-970.37,89.49),"AlcateiaHsT"}, -- AlcateiaHsT
		{vec3(-582.72,-1589.24,26.74),"Overdrive"}, -- Overdrive
		{vec3(1301.08,1424.76,103.86),"Cartel"}, -- Cartel
		{vec3(2567.52,2748.36,42.6),"Sindicato"}, -- Sindicato
		{vec3(1117.26,3515.41,34.96),"Umbrella"}, -- Umbrella
		{vec3(2092.03,3862.58,33.58),"Verdes"}, -- Verdes
		{vec3(3053.95,5047.51,25.27),"China"}, -- China
		{vec3(1305.97,-720.01,64.84),"Brancos"}, -- Brancos
		{vec3(103.47,-1938.9,20.79),"Ballas"}, -- Ballas
		{vec3(306.44,-2016.92,19.7),"Vagos"}, -- Vagos
		{vec3(-1563.63,-414.13,42.38),"Laranjas"}, -- Laranjas
		{vec3(2177.44,5132.88,58.81),"Russia"}, -- Russia
		{vec3(-304.32,2048.77,144.03),"Triade"}, -- Triade
		{vec3(918.3,48.78,81.13),"Bellagios"}, -- Bellagio
		-- {vec3(-1381.02,-579.73,30.13),"Bahamas"}, -- Bahamas
		{vec3(-293.59,234.77,88.46),"Luxor"}, -- Luxor
		{vec3(-174.51,-1669.87,33.8),"Groove"}, -- Groove
		{vec3(-357.58,-122.1,38.69),"Redline"}, -- Redline
		{vec3(-252.6,-1305.52,32.22),"Bennys"}, -- Bennys
		{vec3(-1136.84,-1590.48,5.36),"DriftKing"}, -- DriftKing
		{vec3(135.71,583.94,185.13),"Crips"}, -- Crips
		{vec3(-301.89,1541.9,387.01),"Tropadu7"}, -- Tropadu7
		{vec3(247.44,1178.42,225.5),"SonsofAnarchy"}, -- SonsofAnarchy
		{vec3(995.53,-2458.23,28.63),"HellsAngels"}, -- HellsAngels
		{vec3(616.59,-2748.68,6.05),"Yakuza"}, -- Yakuza
		{vec3(302.19,-2732.79,7.38),"Warlocks"}, -- Warlocks
		{vec3(-2305.33,452.8,174.46),"Bloods"}, -- Bloods
		{vec3(-2916.68,51.28,12.27),"Mercenarios"}, -- Mercenarios
		-- {vec3(-1805.61,457.11,128.28),}, -- Franca
		{vec3(403.53,-1502.24,29.28),"Italia"}, -- Italia
		{vec3(465.64,-3084.21,6.07),"Israel"}, -- Israel
		{vec3(-1553.93,350.92,86.98),"Playboy"}, -- Playboy
		{vec3(-1487.15,877.85,182.89),"Mexico"}, -- Mexico
		{vec3(1068.39,-1898.45,31.64),"Gringa"}, -- Gringa
		{vec3(835.44,-2361.77,30.36),"TopGear"}, -- TopGear
		{vec3(-815.02,-2606.61,13.93),"Outlaws"}, -- Outlaws
		{vec3(2068.44,12.27,214.23),"Vermelhos"}, -- Vermelhos
		{vec3(1836.03,429.97,166.63),"Sinaloa"}, -- Sinaloa
		{vec3(1276.12,-1734.34,52.13),"LosAztecas"}, -- LosAztecas
		{vec3(531.41,2602.95,42.5),"Azuis"}, -- Azuis
		{vec3(531.78,361.43,147.2),"Roxos"}, -- Roxos
		{vec3(2236.07,3275.31,47.68),"Cinzas"}, -- Cinzas
		{vec3(818.73,1159.1,320.23),"Marrons"}, -- Marrons
		{vec3(1366.26,-2263.29,61.37),"Rosas"}, -- Rosas
		{vec3(-2756.25,2267.33,22.39),"Bopegg"}, -- Bopegg
		{vec3(-1524.07,122.46,75.74),"LaMafia"}, -- LaMafia
    },
}

local Blips = {}
function MakeBlips(Facs)
    if cityName == "Test" then
        return
    end
    for k,v in pairs(Blips) do
        RemoveBlip(v)
    end
    for k,v in pairs(RiskArea[cityName]) do
		Blips[k] = AddBlipForCoord(v[1]["x"],v[1]["y"],v[1]["z"])
		SetBlipSprite(Blips[k],429)
        if not Facs[v[2]] then
		    SetBlipColour(Blips[k],69)
        else
		    SetBlipColour(Blips[k],6)
        end
		SetBlipScale(Blips[k],0.4)
        BeginTextCommandSetBlipName("STRING")
        if not Facs[v[2]] then
            AddTextComponentString("Fac Livre - Assuma no Discord")
        else
            if type(Facs[v[2]]) == "string" then
                AddTextComponentString(Facs[v[2]])
            else
                AddTextComponentString("Fac Ativa")
            end
        end
        EndTextCommandSetBlipName(Blips[k])
        SetBlipAsShortRange(Blips[k],true)
	end
end

local BlipRadius = {}
local StartColor = 0
RegisterCommand("TestRadius",function(_,args)
    if args[1] and args[1] == "clear" then
        StartColor = 0
        for i=1,#BlipRadius do
            RemoveBlip(BlipRadius[i])
        end
    elseif args[2] and args[2] == "risk" then
        local SelectedCity = cityName
        if args[3] then
            SelectedCity = args[3]
        end
        if not RiskArea[SelectedCity][1] then
            return
        end
        for i=1,#RiskArea[SelectedCity][1] do
            local CacheBlip = AddBlipForRadius(RiskArea[SelectedCity][1][i],parseInt(args[1])+0.001)
            StartColor = StartColor + 1
            SetBlipAlpha(CacheBlip,100)
            SetBlipColour(CacheBlip,StartColor)
            table.insert(BlipRadius,CacheBlip)
        end
    else
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        local CacheBlip = AddBlipForRadius(Coords,parseInt(args[1])+0.001)
        SetBlipAlpha(CacheBlip,100)
        StartColor = StartColor + 1
    	SetBlipColour(CacheBlip,StartColor)
        table.insert(BlipRadius,CacheBlip)
    end
end)

local Mansions = {
    ["Mansao01"] = vector3(0,0,0)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Respawn(Group,Locate,Mansion,Custom)
	Death = false
	DeathTimer = GlobalState["DeathTimer"]

	ClearPedTasks(PlayerPedId())
	NetworkSetFriendlyFireOption(true)
	ClearPedBloodDamage(PlayerPedId())
	SetEntityHealth(PlayerPedId(),400)
	SetEntityInvincible(PlayerPedId(),false)
	LocalPlayer["state"]["Invincible"] = false

	TriggerEvent("paramedic:Reset")
	TriggerEvent("inventory:CleanWeapons")
	LocalPlayer["state"]["Handcuff"] = false
	exports['pma-voice']:resetProximityCheck()

	DoScreenFadeOut(0)
    if Locate == "PERSONALIZADO" then
        if LocalPlayer["state"]["CustomSpawn"] then
            SetEntityCoords(PlayerPedId(),LocalPlayer["state"]["CustomSpawn"])
        end
    else
        if Mansion then
            SetEntityCoords(PlayerPedId(),Mansions[Mansion])
        else
            if Group and GROUP_COORDS[Group] then
                SetEntityCoords(PlayerPedId(),GROUP_COORDS[Group])
            else
                SetEntityCoords(PlayerPedId(),Locations[Locate] or vec3(-1643.64,-1010.26,13.01))
            end
        end
    end
    TriggerEvent("survival:GhostSpawn")

    SetNuiFocus(false,false)
    if not LocalPlayer["state"]["Arena"] then
        TriggerEvent("hud:Active",true)
    end
	SendNUIMessage({ action = "setVisible", data = false })
	Wait(1000)
	DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Revive",function(Health,Arena)
	local Ped = PlayerPedId()

	SetEntityHealth(Ped,Health)
	SetEntityInvincible(Ped,false)
	LocalPlayer["state"]["Invincible"] = false

	if Arena then
		SetPedArmour(Ped,99)
	end

	if Death then
		Death = false
		DeathTimer = GlobalState["DeathTimer"]

		ClearPedTasks(Ped)
		NetworkSetFriendlyFireOption(true)

		SetNuiFocus(false,false)
		TriggerEvent("hud:Active",true)
		SendNUIMessage({ action = "setVisible", data = false })

		if LocalPlayer["state"]["Route"] < 900000 then
			TriggerEvent("paramedic:Reset")
			exports['pma-voice']:resetProximityCheck()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Revive(Health,Arena)
	exports["survival"]:Revive(Health,Arena)
end

RegisterNetEvent("vrp:removeMute")
AddEventHandler("vrp:removeMute",function()
    exports['pma-voice']:resetProximityCheck()
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

RegisterNetEvent("survival:Facs")
AddEventHandler("survival:Facs",function(Facs)
    MakeBlips(Facs)
end)

RegisterNetEvent("survival:GhostSpawn")
AddEventHandler("survival:GhostSpawn",function()
    SetLocalPlayerAsGhost(true)
    SetGhostedEntityAlpha(254)
    Wait(15000)
    SetLocalPlayerAsGhost(false)
end)

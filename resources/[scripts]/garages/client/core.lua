-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("garages",Creative)
vSERVER = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECOR
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("PlayerVehicle",3)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Opened = "1"
local Searched = nil
local Cooldown = GetGameTimer()
local Anim = "machinic_loop_mechandplayer"
local Dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
local cityName = GetConvar("cityName","Base")
local Updated = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Garages = exports["variables"]:GetGarages()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleMods(Vehicle,Customize)
	if Customize then
		SetVehicleModKit(Vehicle,0)

		if Customize["wheeltype"] ~= nil then
			SetVehicleWheelType(Vehicle,Customize["wheeltype"])
		end

		if Customize["mods"] then
			for i = 0,16 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end

			for i = 17,22 do
				if Customize["mods"][tostring(i)] ~= nil then
					ToggleVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end

			for i = 23,24 do
				if Customize["mods"][tostring(i)] ~= nil then
					if not Customize["var"] then
						Customize["var"] = {}
						Customize["var"][tostring(i)] = 0
					end

					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)],Customize["var"][tostring(i)])
				end
			end

			for i = 25,48 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end
		end

		if Customize["neon"] ~= nil then
			for i = 0,3 do
				SetVehicleNeonLightEnabled(Vehicle,i,Customize["neon"][tostring(i)])
			end
		end

		if Customize["extras"] ~= nil then
			for i = 1,12 do
				local onoff = tonumber(Customize["extras"][i])
				if onoff == 1 then
					SetVehicleExtra(Vehicle,i,0)
				else
					SetVehicleExtra(Vehicle,i,1)
				end
			end
		end

		if Customize["liverys"] ~= nil and Customize["liverys"] ~= 24  then
			SetVehicleLivery(Vehicle,Customize["liverys"])
		end

		if Customize["plateIndex"] ~= nil and Customize["plateIndex"] ~= 4 then
			SetVehicleNumberPlateTextIndex(Vehicle,Customize["plateIndex"])
		end

		SetVehicleXenonLightsColour(Vehicle,Customize["xenonColor"])
		SetVehicleColours(Vehicle,Customize["colors"][1],Customize["colors"][2])
		SetVehicleExtraColours(Vehicle,Customize["extracolors"][1],Customize["extracolors"][2])
		SetVehicleNeonLightsColour(Vehicle,Customize["lights"][1],Customize["lights"][2],Customize["lights"][3])
		SetVehicleTyreSmokeColor(Vehicle,Customize["smokecolor"][1],Customize["smokecolor"][2],Customize["smokecolor"][3])

		if Customize["tint"] ~= nil then
			SetVehicleWindowTint(Vehicle,Customize["tint"])
		end

		if Customize["dashColour"] ~= nil then
			SetVehicleInteriorColour(Vehicle,Customize["dashColour"])
		end

		if Customize["interColour"] ~= nil then
			SetVehicleDashboardColour(Vehicle,Customize["interColour"])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SpawnPosition(Select)
	local Slot = "0"
	local Checks = 0
	local Selected = {}
	local Position = nil
	repeat
		Checks = Checks + 1

		Slot = Checks
		if Garages[Select]["Spawns"]["Positions"][Slot] ~= nil then
			local _,Groundz = GetGroundZAndNormalFor_3dCoord(Garages[Select]["Spawns"]["Positions"][Slot]["x"],Garages[Select]["Spawns"]["Positions"][Slot]["y"],Garages[Select]["Spawns"]["Positions"][Slot]["z"])
			Selected = { Garages[Select]["Spawns"]["Positions"][Slot]["x"],Garages[Select]["Spawns"]["Positions"][Slot]["y"],Groundz,Garages[Select]["Spawns"]["Positions"][Slot]["w"] }
			Position = GetClosestVehicle(Selected["x"],Selected["y"],Selected["z"],2.501,0,71)
		end
	until not DoesEntityExist(Position) or not Garages[Select]["Spawns"]["Positions"][Slot]

	if not Garages[Select]["Spawns"]["Positions"][Checks] then
		TriggerEvent("Notify","amarelo","Todas as vagas estão ocupadas.",5000,"GARAGEM")
		-- TriggerEvent("Notify2","#vagaFull")
		return false
	end

	return Selected
end


local function UnpackVehicleCustomization(data)
	local unpacked = { }

	do
		unpacked['neon'] = { }

		local enabledNeonLightsFlag = data[eVehicleCustomizationPart.NeonLightsFlag] or 0

		for neonIndex = 0, 3 do
			local isEnabled = ( enabledNeonLightsFlag & (1 << (neonIndex)) ) ~= 0

			unpacked['neon'][neonIndex] = isEnabled
		end
	end

	do
		unpacked['xenonColor'] = data[eVehicleCustomizationPart.XenonColor]
	end

	do
		unpacked['lights'] = { }

		if data[eVehicleCustomizationPart.NeonLightsColor] then
			local r, g, b = Int2rgb(data[eVehicleCustomizationPart.NeonLightsColor])

			unpacked['lights'][1] = r
			unpacked['lights'][2] = g
			unpacked['lights'][3] = b
		end
	end

	do
		unpacked['colors'] = data[eVehicleCustomizationPart.Colors] or { }
	end

	do
		unpacked['extracolors'] = data[eVehicleCustomizationPart.ExtraColors] or { }
	end

	do
		unpacked['smokecolor'] = { }

		if data[eVehicleCustomizationPart.TyreSmokeColor] then
			local r, g, b = Int2rgb(data[eVehicleCustomizationPart.TyreSmokeColor])

			unpacked['smokecolor'][1] = r
			unpacked['smokecolor'][2] = g
			unpacked['smokecolor'][3] = b
		end
	end

	do
		unpacked['tint'] = data[eVehicleCustomizationPart.Tint]
	end

	do
		unpacked['dashColour'] = data[eVehicleCustomizationPart.DashboardColour]
	end

	do
		unpacked['interColour'] = data[eVehicleCustomizationPart.InteriorColour]
	end

	do
		unpacked['wheeltype'] = data[eVehicleCustomizationPart.WheelType]
	end

	if unpacked['extras'] then

		local enabledExtrasFlag = data[eVehicleCustomizationPart.ExtrasFlag] or 0

		for extraIndex = 1, 12 do
			local isEnabled = ( enabledExtrasFlag & (1 << (extraIndex)) ) ~= 0

			local isEnabledAsInteger = isEnabled and 1 or 0

			unpacked['extras'][extraIndex] = isEnabledAsInteger
		end
	end

	do
		unpacked['liverys'] = data[eVehicleCustomizationPart.Livery]
	end

	do
		unpacked['plateIndex'] = data[eVehicleCustomizationPart.NumberPlateTextIndex]
	end

	do
		unpacked['mods'] = data[eVehicleCustomizationPart.Mods]
	end

	do
		unpacked['var'] = { }

		unpacked['var'][23] = data[eVehicleCustomizationPart.ModWheelsVariation]
		unpacked['var'][23] = data[eVehicleCustomizationPart.ModRearWheelsVariation]
	end

	-- print('unpacked', json.encode(unpacked, { indent = true }))

	return unpacked
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateClientVehicle(Network,Engine,Health, packedCustomization, brokenWindowsFlag, burstTyresFlag,Degrade,Owner, Model)

    local Count = 0
    local VipBoost = 0
    local Player = GetPlayerServerId(PlayerId())
    if Owner and Player == Owner then
        while not NetworkDoesNetworkIdExist(Network) do
            Count = Count + 1
            if Count >= 1000 then
                Count = 0
                break
            end
            Wait(10)
        end
        local Vehicle = NetToEnt(Network)
        while not DoesEntityExist(Vehicle) do
            Count = Count + 1
            if Count >= 1000 then
                Count = 0
                break
            end
            Wait(10)
        end
        local Vehicle = NetToEnt(Network)
        SetVehicleFuelLevel(Vehicle,100.0)
        VipBoost = vSERVER.HasVipBooster()
    end
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then

			if packedCustomization ~= nil then
				local Customize = UnpackVehicleCustomization(packedCustomization)
				
				VehicleMods(Vehicle, Customize)
			end

            SetVehicleFuelLevel(Vehicle,100.0)
			SetVehicleEngineHealth(Vehicle,Engine + 0.0)
			SetEntityHealth(Vehicle,Health)

			local Model = GetEntityModel(Vehicle)

			-- print('brokenWindowsFlag', brokenWindowsFlag)

			for doorIndex = 0, GetNumberOfVehicleDoors(Vehicle) - 1 do
				local isBroken = ( brokenWindowsFlag & (1 << (doorIndex)) ) ~= 0

				-- print('isBroken', doorIndex, isBroken)

				if isBroken then
					RemoveVehicleWindow(Vehicle, doorIndex)
				end
			end

			-- print('burstTyresFlag', burstTyresFlag)

			for tyreIndex = 0, 7 do
				local isBurst = ( burstTyresFlag & (1 << (tyreIndex)) ) ~= 0

				-- print('isBurst', tyreIndex, isBurst)

				if isBurst then
					SetVehicleTyreBurst(Vehicle, tyreIndex, true, 1000.0)
				end
			end

			if Model == `maverick2` then
				if LocalPlayer["state"]["Policia"] then
					SetVehicleLivery(Vehicle,0)
				elseif LocalPlayer["state"]["Paramedic"] then
					SetVehicleLivery(Vehicle,1)
				end
			end

            -- if VehicleVip(Model) then
            --     ModifyVehicleTopSpeed(Vehicle,30.0)
            -- end
            --if GetVehicleClass(Vehicle) ~= 18 then
                if Degrade ~= 0 then
                    local Init = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
                    local Result = Init / 100 * Degrade

                    SetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveMaxFlatVel",Init - Result + 0.0)
                    SetVehicleModKit(Vehicle,0)
                    SetVehicleMod(Vehicle,11,GetVehicleMod(Vehicle,11),true)
                end
            --end
            local BoostList = exports['variables']:GetVariable('variables','BoostList') or {}
            if BoostList[Model] then
                local Init = GetVehicleHandlingFloat(vehDrive,"CHandlingData","fInitialDriveForce")
                SetVehicleHandlingFloat(vehDrive, "CHandlingData", "fInitialDriveForce",Init + BoostList[Model])
                SetVehicleModKit(vehDrive,0)
                SetVehicleMod(vehDrive,11,GetVehicleMod(vehDrive,11),true)
            end
            --if GetVehicleClass(Vehicle) ~= 18 then
            if isModelNative(Model) then
                local Init = GetVehicleHandlingFloat(Vehicle,"CHandlingData","fInitialDriveForce")
                SetVehicleHandlingFloat(Vehicle, "CHandlingData", "fInitialDriveForce",Init + 0.12)
                SetVehicleModKit(Vehicle,0)
                SetVehicleMod(Vehicle,11,GetVehicleMod(Vehicle,11),true)
            end
            --end
            SetVehicleDirtLevel(Vehicle,0.0)
			if not DecorExistOn(Vehicle,"PlayerVehicle") then
				DecorSetInt(Vehicle,"PlayerVehicle",-1)
			end
			if Owner and GetPlayerServerId(PlayerId()) == Owner then
				SetPedIntoVehicle(PlayerPedId(),Vehicle,-1)
			end

            SetVehicleFuelLevel(Vehicle,100.0)
		end
	end
end

RegisterNetEvent('garage:createVehicle', CreateClientVehicle)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Vehicle,Admin)
	if not Vehicle or Vehicle == "" then
		Vehicle = vRP.ClosestVehicle(15)
	end

	if IsEntityAVehicle(Vehicle) then
		local Tyres = {}
		local Doors = {}
		local Windows = {}

		for i = 0,5 do
			Doors[i] = IsVehicleDoorDamaged(Vehicle,i)
		end

		for i = 0,5 do
			Windows[i] = IsVehicleWindowIntact(Vehicle,i)
		end

		for i = 0,7 do
			local Status = false

			if GetTyreHealth(Vehicle,i) ~= 1000.0 then
				Status = true
			end

			Tyres[i] = Status
		end

		if DecorExistOn(Vehicle,"PlayerVehicle") then
			DecorRemove(Vehicle,"PlayerVehicle")
		end

		if Admin then
			TriggerServerEvent("garages:Dv",GetVehicleNumberPlateText(Vehicle))
		end

		vSERVER.Delete(VehToNet(Vehicle),GetEntityHealth(Vehicle),GetVehicleEngineHealth(Vehicle),GetVehicleBodyHealth(Vehicle),GetVehicleFuelLevel(Vehicle),Doors,Windows,Tyres,GetVehicleNumberPlateText(Vehicle))
	end
end)
RegisterNetEvent("garages:Delete2")
AddEventHandler("garages:Delete2",function(Area)
    local Range = Area or 15
    local vehiclePool = GetGamePool('CVehicle')
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    for i = 1, #vehiclePool do 
        local Vehicle = vehiclePool[i]
        local VehCoords = GetEntityCoords(Vehicle) 
        local Distance = #(Coords - VehCoords)
        if Distance <= Range then
            TriggerServerEvent("garages:Dv2",GetVehicleNumberPlateText(Vehicle))
            DeleteEntity(Vehicle)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SearchBlip(Coords)
	if DoesBlipExist(Searched) then
		RemoveBlip(Searched)
		Searched = nil
	end

	Searched = AddBlipForCoord(Coords["x"],Coords["y"],Coords["z"])
	SetBlipSprite(Searched,225)
	SetBlipColour(Searched,2)
	SetBlipScale(Searched,0.6)
	SetBlipAsShortRange(Searched,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(Searched)

	SetTimeout(30000,function()
		RemoveBlip(Searched)
		Searched = nil
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Impound")
AddEventHandler("garages:Impound",function()
	local Impound = vSERVER.Impound()
	if parseInt(#Impound) > 0 then
		for k,v in pairs(Impound) do
			exports["dynamic"]:AddButton(v["name"],"Clique para iniciar a liberação.","garages:Impound",v["Model"],false,true)
		end

		exports["dynamic"]:openMenu()
	else
		TriggerEvent("Notify","amarelo","Não possui veículos apreendidos.",5000)
		-- TriggerEvent("Notify2","#semCarroApreendido")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Propertys")
AddEventHandler("garages:Propertys",function(Table)
    Garages[Table[1]] = {
        ["Spawns"] = {
            ["Open"] = Table[2],
            ["Positions"] = {
                Table[3],
            }
        } 
    }
end)

RegisterNetEvent("garages:RemProperty")
AddEventHandler("garages:RemProperty",function(Number)
    Garages[Number] = {}
end)

RegisterNetEvent("garages:AllPropertys")
AddEventHandler("garages:AllPropertys",function(Table)
    for Name,Info in pairs(Table) do
        Garages[Info[1]] = {
            ["Spawns"] = {
                ["Open"] = Info[2],
                ["Positions"] = {
                    Info[3],
                }
            } 
        }
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Table = {}
    for i=1,#Garages do
        if Garages[i] and Garages[i]["Spawns"] then
            local Spawn = Garages[i]["Spawns"]["Open"]
            table.insert(Table,{ Spawn["x"],Spawn["y"],Spawn["z"],1.25,"E","Garagem","Pressione para abrir" })
        end
    end

    TriggerEvent("hoverfy:Insert",Table)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
local NearGarage = false
local LastDistance = 999
CreateThread(function()
	while true do
		local TimeDistance = 999
        local Ped = PlayerPedId()
		if LocalPlayer["state"]["Route"] < 900000 and NearGarage then
            -- local Info = Garages[NearGarage]
            local Info = Garages[NearGarage]["Spawns"]["Open"]
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)
                local Distance = #(Coords - vec3(Info["x"],Info["y"],Info["z"]))
                if Distance <= 20.0 then
                    LastDistance = 20
                    TimeDistance = 5
                    DrawMarker(36,Info["x"],Info["y"],Info["z"],0,0,0,vec3(0.0, 0.0, 0.0),vec3(1.0, 1.0, 1.0),THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 94,false,false,2,true,nil,nil,false)
                    if Distance <= 1.25 then
                        if IsControlJustPressed(1,38) then
                            local garagem = vSERVER.Vehicles(NearGarage)
                            if garagem then
                                Opened = NearGarage
                                SetNuiFocus(true,true)
                                SendNUIMessage({ action = "Visible", data = true })
                                SendNUIMessage({ action = "OpenGarage", data = garagem })
                            end
                        end
                    end
                else
                    NearGarage = false
                    LastDistance = 999
                end
			end
		end
		Wait(TimeDistance)
	end
end)

CreateThread(function()
    while true do
        local idle = 1500
        local ped = PlayerPedId()
        local Coords = GetEntityCoords(ped)
        for i=1,#Garages do
            if Garages[i] and Garages[i]["Spawns"] then
                local Info = Garages[i]["Spawns"]["Open"]
                local Distance = #(Coords - vec3(Info["x"],Info["y"],Info["z"]))
                if Distance <= 20 then
                    if LastDistance > Distance then
                        NearGarage = i
                        LastDistance = Distance
                    end
                end
            end
        end
        Wait(idle)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Close")
AddEventHandler("garages:Close",function()
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeVehicle",function(Data,Callback)
	if GetGameTimer() >= Cooldown then
		Cooldown = GetGameTimer() + 5000
		vSERVER.Spawn(Data["model"],Opened)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeVehicle",function(Data,Callback)
	if GetGameTimer() >= Cooldown then
		Cooldown = GetGameTimer() + 5000
		TriggerEvent("garages:Delete")
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellVehicle",function(Data,Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false,false)

	vSERVER.Sell(Data["model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("transferVehicle",function(Data,Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false,false)

	vSERVER.Transfer(Data["model"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("taxVehicle",function(Data,Callback)
	SendNUIMessage({ action = "Visible", data = false })
	SetNuiFocus(false,false)

	vSERVER.Tax(Data["model"])

	Callback("Ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatePeds()
    for i=1,#Garages do
        if Garages[i] and Garages[i]["Ped"] then
            local TablePed = Garages[i]["Ped"]
            local TableSpawn = Garages[i]["Spawns"]["Open"]
            TablePed["Coords"] = {TableSpawn["x"],TableSpawn["y"],TableSpawn["z"],TableSpawn["w"]}
            exports["player"]:AddPedToList(TablePed)
        end
    end
end

CreateThread(function()
    CreatePeds()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		local Vehicle = GetVehiclePedIsIn(Ped)

        if IsEntityVisible(Ped) and Coords["z"] < -100 then
            --  ()
            if Vehicle and Vehicle ~= 0 then
                TriggerEvent("garages:Delete",Vehicle)
            end
        end
		
		Wait(1000)
	end
end)

function teleportProximityLimbo()
    local Ped = PlayerPedId()
    local AvailableGarages = Garages
    local InitialCoords = GetEntityCoords(Ped)
    local Coords = vector2(InitialCoords["x"],InitialCoords["y"])
    local Selected = false
    local Closest = 750
    for i=1,#Garages do
        if Garages[i] and Garages[i]["Spawns"] and not Garages[i]["Teleport"] then
            if not Garages[Number]["Info"]["Perm"] then
                local Info = Garages[i]["Spawns"]["Open"]
                local GarageCoords = vector2(Info["x"],Info["y"])
                local Distance = #(Coords - GarageCoords)
                if Distance <= Closest then
                    Closest = Distance
                    Selected = vector3(Info["x"],Info["y"],Info["z"])
                end
            end
        end
    end
    if Selected then
        DoScreenFadeOut(2500)
        while not IsScreenFadedOut() do 
            Wait(5) 
        end
        SetEntityCoords(Ped,Selected)
        FreezeEntityPosition(Ped,true)
        RequestCollisionAtCoord(Selected.x,Selected.y,Selected.z)
        while not HasCollisionLoadedAroundEntity(Ped) do
            Wait(1)
        end
        FreezeEntityPosition(Ped,false)
        DoScreenFadeIn(5000)
        TriggerEvent("Notify","vermelho","Você caiu no limbo e foi teleportado para a garagem mais próxima.",10000,"LIMBO")
    end
	-- TriggerEvent("Notify2","#tpGaragem")
end

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

function LoadModel(Hash)
	local Hash = GetHashKey(Hash)

	while not HasModelLoaded(Hash) do
		RequestModel(Hash)
		Wait(1)
	end

	return true
end

RegisterCommand("generateconfig",function()
    local models = GetAllVehicleModels()
    local Message = ""
    for i=1,#models do
        local Hash = GetHashKey(models[i])
        local vType = ""
        --if LoadModel(Hash) then
            if IsThisModelACar(Hash) then
                vType = 'automobile'
            elseif IsThisModelABicycle(Hash) then
                vType = 'bicycle'
            elseif IsThisModelABike(Hash) then
                vType = 'bike'
            elseif IsThisModelABoat(Hash) then
                vType = 'boat'
            elseif IsThisModelAHeli(Hash) then
                vType = 'heli'
            elseif IsThisModelAPlane(Hash) then
                vType = 'plane'
            elseif IsThisModelAQuadbike(Hash) then
                vType = 'quadbike'
            elseif IsThisModelAnAmphibiousCar(Hash) then
                vType = 'amphibious_automobile'
            elseif IsThisModelAnAmphibiousQuadbike(Hash) then
                vType = 'amphibious_quadbike'
            elseif IsThisModelATrain(Hash) then
                vType = 'train'
            else
                vType = (class == 5 and 'submarinecar') or (class == 14 and 'submarine') or (class == 16 and 'blimp') or 'trailer'
            end
            Message = Message .. "['"..models[i]:lower().."'] = { ['type'] = '"..vType.."' },\n"
        --end
    end
    print(Message)

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = "Santos"
local cityName = GetConvar("cityName", "Base")
local Discount = 1
local InitVehicles = {}
local Vehicles = exports["variables"]:GetStaticVehicles()
local Logos = {
	["Base"] = "SEU LINK AQUI",

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Open")
AddEventHandler("tablet:Open",function(Select)
	if LocalPlayer["state"]["Route"] < 900000 then
		local Ped = PlayerPedId()
        local VipDiscount = vSERVER.TabletHasVip()
        Discount = VipDiscount
		if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and GetEntityHealth(Ped) > 100 then
			Open = Select
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({
                action = 'setVisible',
                data = 'cars'
            })
            TriggerEvent("talknpc:closeTalk")
		end
	end
end)

local StartCoords = {
    vector3(-43.09,-1104.63,26.42),
	vector3(-55.85,-1098.48,26.42),
	vector3(-30.39,-1104.88,26.42),
	vector3(-37.71,-1097.57,26.4),
	vector3(-49.85,-1093.29,26.42),

}

CreateThread(function()
    local Table = {}
    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i]["x"],
            StartCoords[i]["y"],
            StartCoords[i]["z"],
            3.0,
            "E",
            "Concessionaria",
            "Pressione para abrir",
        }
    end

    TriggerEvent("hoverfy:Insert",Table)

    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        for i=1, #StartCoords do
            if #(Coords - StartCoords[i]) <= 3.0 then
                idle = 1
                if IsControlJustPressed(0,38) then
                    TriggerEvent("tablet:Open")
                end
            end
        end
        Wait(idle)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:LOGO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getLogoUrl", function(data, cb)
    cb(Logos[cityName])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("hideFrame",function(Data,Callback)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getCars",function(Data,Callback)
    local Data = GlobalState["Cars"]
    for i=1,#Data do
        local Info = VehicleInfo(Data[i]["k"])
        if Info["Mode"] == "rental" then
            Discount = 1
        end
        Data[i]["price"] = Data[i]["price"] * Discount
    end
	Callback(Data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getMotorcycles",function(Data,Callback)
    local Data = GlobalState["Bikes"]
    for i=1,#Data do
        local Info = VehicleInfo(Data[i]["k"])
        if Info["Mode"] == "rental" then
            Discount = 1
        end
        Data[i]["price"] = Data[i]["price"] * Discount
    end
	Callback(Data)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getVips",function(Data,Callback)
    -- local Data = GlobalState["Rental"]
    -- for i=1,#Data do
    --     Data[i]["price"] = Data[i]["price"] * Discount
    -- end
	Callback(GlobalState["Rental"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyVehicle",function(Data,Callback)
    print(Data["spawn"])
	vSERVER.Buy(Data["spawn"])
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyVIP",function(Data,Callback)
	--vSERVER.Rental(Data["spawn"])
    TriggerEvent("player:OpenURL", StoreLink[cityName])
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyVehicleWithDiamonds",function(Data,Callback)
	vSERVER.RentalDiamonds(Data["spawn"])
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Close")
AddEventHandler("tablet:Close",function()
    SetNuiFocus(false,false)
    SetCursorLocation(0.5,0.5)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVEABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehDrive = nil
local benDrive = false
local benCoords = { 0.0,0.0,0.0 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("testDrive",function(Data,Callback)
    SetNuiFocus(false,false)
    SetCursorLocation(0.5,0.5)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
	if vSERVER.startDrive() then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		benCoords = { Coords["x"],Coords["y"],Coords["z"] }

		LocalPlayer["state"]["Race"] = true
		LocalPlayer["state"]["Commands"] = true
		TriggerEvent("Notify","azul","Teste iniciado, para finalizar saia do veículo.",5000)
        -- TriggerEvent("Notify2","#testDrive")

		Wait(1000)

		vehCreate(Data["spawn"])
		benDrive = true
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName)
    local BoostList = exports['variables']:GetVariable('variables','BoostList') or {}
    local Ped = PlayerPedId()
	if LoadModel(vehName) then
		if Open == "Santos" then
			vehDrive = CreateVehicle(vehName,-53.28,-1110.93,26.47,68.04,false,false)
		elseif Open == "Sandy" then
			vehDrive = CreateVehicle(vehName,1209.74,2713.49,37.81,175.75,false,false)
        else
            vehDrive = CreateVehicle(vehName,-53.28,-1110.93,26.47,68.04,false,false)
		end
		SetModelAsNoLongerNeeded(vehName)
		SetEntityInvincible(vehDrive,true)
		SetPedIntoVehicle(Ped,vehDrive,-1)
        SetVehicleModKit(veh,0)
        TriggerServerEvent("CleanVehicle",VehToNet(vehDrive))
        if isModelNative(vehName) then
            local Init = GetVehicleHandlingFloat(vehDrive,"CHandlingData","fInitialDriveForce")
            SetVehicleHandlingFloat(vehDrive, "CHandlingData", "fInitialDriveForce",Init + 0.12)
            SetVehicleModKit(vehDrive,0)
            SetVehicleMod(vehDrive,11,GetVehicleMod(vehDrive,11),true)
        end
        if BoostList[vehName] then
            local Init = GetVehicleHandlingFloat(vehDrive,"CHandlingData","fInitialDriveForce")
            SetVehicleHandlingFloat(vehDrive, "CHandlingData", "fInitialDriveForce",Init + BoostList[vehName])
            SetVehicleModKit(vehDrive,0)
            SetVehicleMod(vehDrive,11,GetVehicleMod(vehDrive,11),true)
        end
        if VehicleVip(vehName) then
            SetVehicleMod(vehDrive,0,GetNumVehicleMods(vehDrive,0)-1,false)
            SetVehicleMod(vehDrive,1,GetNumVehicleMods(vehDrive,1)-1,false)
            SetVehicleMod(vehDrive,2,GetNumVehicleMods(vehDrive,2)-1,false)
            SetVehicleMod(vehDrive,3,GetNumVehicleMods(vehDrive,3)-1,false)
            SetVehicleMod(vehDrive,4,GetNumVehicleMods(vehDrive,4)-1,false)
            SetVehicleMod(vehDrive,5,GetNumVehicleMods(vehDrive,5)-1,false)
            SetVehicleMod(vehDrive,6,GetNumVehicleMods(vehDrive,6)-1,false)
            SetVehicleMod(vehDrive,7,GetNumVehicleMods(vehDrive,7)-1,false)
            SetVehicleMod(vehDrive,8,GetNumVehicleMods(vehDrive,8)-1,false)
            SetVehicleMod(vehDrive,9,GetNumVehicleMods(vehDrive,9)-1,false)
            SetVehicleMod(vehDrive,10,GetNumVehicleMods(vehDrive,10)-1,false)
            SetVehicleMod(vehDrive,11,GetNumVehicleMods(vehDrive,11)-1,false)
            SetVehicleMod(vehDrive,12,GetNumVehicleMods(vehDrive,12)-1,false)
            SetVehicleMod(vehDrive,13,GetNumVehicleMods(vehDrive,13)-1,false)
            SetVehicleMod(vehDrive,14,16,false)
            SetVehicleMod(vehDrive,15,GetNumVehicleMods(vehDrive,15)-2,false)
            SetVehicleMod(vehDrive,16,GetNumVehicleMods(vehDrive,16)-1,false)
            ToggleVehicleMod(vehDrive,17,true)
            ToggleVehicleMod(vehDrive,18,true)
            ToggleVehicleMod(vehDrive,19,true)
            ToggleVehicleMod(vehDrive,20,true)
            ToggleVehicleMod(vehDrive,21,true)
            ToggleVehicleMod(vehDrive,22,true)
            SetVehicleMod(vehDrive,25,GetNumVehicleMods(vehDrive,25)-1,false)
            SetVehicleMod(vehDrive,27,GetNumVehicleMods(vehDrive,27)-1,false)
            SetVehicleMod(vehDrive,28,GetNumVehicleMods(vehDrive,28)-1,false)
            SetVehicleMod(vehDrive,30,GetNumVehicleMods(vehDrive,30)-1,false)
            SetVehicleMod(vehDrive,33,GetNumVehicleMods(vehDrive,33)-1,false)
            SetVehicleMod(vehDrive,34,GetNumVehicleMods(vehDrive,34)-1,false)
            SetVehicleMod(vehDrive,35,GetNumVehicleMods(vehDrive,35)-1,false)
            SetVehicleMod(vehDrive,38,GetNumVehicleMods(vehDrive,38)-1,true)
            SetVehicleTyreSmokeColor(vehDrive,155,0,0)
            SetVehicleWindowTint(vehDrive,1)
            SetVehicleTyresCanBurst(vehDrive,false)
            SetVehicleNumberPlateTextIndex(vehDrive,5)
            SetVehicleModColor_1(vehDrive,155,0,0)
            SetVehicleModColor_2(vehDrive,135,135)
            SetVehicleColours(vehDrive,1,0)
            SetVehicleExtraColours(vehDrive,1,0)
            SetVehicleNeonLightEnabled(vehDrive,0,true)
            SetVehicleNeonLightEnabled(vehDrive,1,true)
            SetVehicleNeonLightEnabled(vehDrive,2,true)
            SetVehicleNeonLightEnabled(vehDrive,3,true)
            SetVehicleNeonLightsColour(vehDrive,155,0,0)
        end
        benDrive = true
        local TestDriveTimer = GetGameTimer() + 1000*60*5
        CreateThread(function()
            while benDrive do
                DisableControlAction(1,69,false)
                if GetGameTimer() >= TestDriveTimer then
                    Wait(100)
                    benDrive = false
                    vSERVER.removeDrive()
                    LocalPlayer["state"]["Race"] = false
                    LocalPlayer["state"]["Commands"] = false
                    SetEntityCoords(Ped,benCoords[1],benCoords[2],benCoords[3],false,false,false,false)
    
                    if DoesEntityExist(vehDrive) then
                        DeleteEntity(vehDrive)
                    end
                end
                if not IsPedInAnyVehicle(Ped) then
                    Wait(100)
                    benDrive = false
                    vSERVER.removeDrive()
                    LocalPlayer["state"]["Race"] = false
                    LocalPlayer["state"]["Commands"] = false
                    SetEntityCoords(Ped,benCoords[1],benCoords[2],benCoords[3],false,false,false,false)
    
                    if DoesEntityExist(vehDrive) then
                        DeleteEntity(vehDrive)
                    end
                end
                Wait(1)
            end
        end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
        local Idle = 1000
        if Vehicles then
            for i=1,#Vehicles do
                local Distance = #(Coords - Vehicles[i]["Coords"])
                if Distance <= Vehicles[i]["Distance"] then
                    if not InitVehicles[i] then
                        if LoadModel(Vehicles[i]["Model"]) then
                            local Colors = Vehicles[i]["Colors"] or vector3(0,0,0)
                            InitVehicles[i] = CreateVehicle(Vehicles[i]["Model"],Vehicles[i]["Coords"],Vehicles[i]["Heading"],false,false)
                            SetVehicleCustomPrimaryColour(InitVehicles[i],Colors)
                            SetVehicleCustomSecondaryColour(InitVehicles[i],Colors)
                            SetVehicleNumberPlateText(InitVehicles[i],"BASE")
                            FreezeEntityPosition(InitVehicles[i],true)
                            SetVehicleDoorsLocked(InitVehicles[i],2)
                            SetModelAsNoLongerNeeded(Vehicles[i]["Model"])
                            SetVehicleEngineOn(InitVehicles[i],false,false,true)

                            if Vehicles[i]["Rotation"] then
                                SetEntityRotation(InitVehicles[i],Vehicles[i]["Rotation"],2,true)
                            end

                            if Vehicles[i]["Color"] then
                                SetVehicleCustomPrimaryColour(InitVehicles[i],Vehicles[i]["Color"][1],Vehicles[i]["Color"][2],Vehicles[i]["Color"][3])
                            end

                            -- Verifica se o veículo deve ter a sirene ligada
                            if Vehicles[i]["Siren"] then
                                SetVehicleSiren(InitVehicles[i], Vehicles[i]["Siren"])
                            end
                        end
                    else
                        if Vehicles[i]["Rotate"] then
                            Idle = 5
                            SetEntityHeading(InitVehicles[i],GetEntityHeading(InitVehicles[i])+0.10)
                        end
                    end
                else
                    if InitVehicles[i] then
                        if DoesEntityExist(InitVehicles[i]) then
                            DeleteEntity(InitVehicles[i])
                            InitVehicles[i] = nil
                        end
                    end
                end
            end
        end

		Wait(Idle)
	end
end)

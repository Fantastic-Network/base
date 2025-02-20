Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
vSERVER = Tunnel.getInterface("farmer")
Creative = {}
Tunnel.bindInterface("farmer",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Displayed = {}
LocalPlayer["state"]["AnyJob"] = false
LocalPlayer["state"]["JobAutoPilot"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INPUTTARGETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function InputTargetPosition(Number,v)
	if v["Model"] == "prop_money_bag_01" then
		exports["target"]:AddBoxZone("Farmer:"..Number,v["Coords"],v["Width"],v["Width"],{
			name = "Farmer:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 1.0,
			maxZ = v["Coords"]["z"] - 0.5
		},{
			shop = Number,
			Distance = v["Distance"],
			options = {
				{
					event = v["Event"],
					label = v["Label"],
					tunnel = "server"
				}
			}
		})
	else
		exports["target"]:AddCircleZone("Farmer:"..Number,v["Coords"],v["Width"],{
			name = "Farmer:"..Number,
			heading = v["Heading"]
		},{
			shop = Number,
			Distance = v["Distance"],
			options = {
				{
					event = v["Event"],
					label = v["Label"],
					tunnel = "server"
				}
			}
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number,v in pairs(Objects) do
			if #(Coords - v["Coords"]) <= v["Show"] then
                async(function()
                    Wait(5000)
                    if not Displayed[Number] and LoadModel(v["Model"]) then
                        Displayed[Number] = CreateObjectNoOffset(v["Model"],v["Coords"]["x"],v["Coords"]["y"],v["Coords"]["z"] - v["Height"],false,false,false)
                        SetEntityHeading(Displayed[Number],v["Heading"])
                        FreezeEntityPosition(Displayed[Number],true)
                        SetModelAsNoLongerNeeded(v["Model"])
                        InputTargetPosition(Number,v)
                    end
                end)
			else
				if Displayed[Number] then
					exports["target"]:RemCircleZone("Farmer:"..Number)

					if DoesEntityExist(Displayed[Number]) then
						DeleteEntity(Displayed[Number])
						Displayed[Number] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FARMER:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("farmer:Remover")
AddEventHandler("farmer:Remover",function(Number,Timers)
	if Objects[Number] then
		Objects[Number]["Time"] = Timers

		if Displayed[Number] then
			exports["target"]:RemCircleZone("Farmer:"..Number)

			if DoesEntityExist(Displayed[Number]) then
				DeleteEntity(Displayed[Number])
				Displayed[Number] = nil
			end
		end
	end
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)



local CowZone = PolyZone:Create({
    vector2(2071.21, 5001.52),
    vector2(2116.67, 5051.52),
    vector2(2557.58, 4725.76),
    vector2(2463.64, 4648.48)
   }, {
    name="CowZone",
})

function Creative.milkingCoords()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	if CowZone:isPointInside(Coords) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
local Milking = false

CreateThread(function()
    LocalPlayer["state"]:set("Buttons",false,true)
    while true do
        local Idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        local Inside = false
        if CowZone:isPointInside(Coords) then
            if not InZone then
                InZone = true
            end
            Inside = true
        end
        if not Inside then
            InZone = false
        end
        Wait(Idle)
    end
end)


CreateThread(function()
    local Table = {}
    for i=1, #Cows do
        Table[i] = {
            Cows[i]["x"],
            Cows[i]["y"],
            Cows[i]["z"],
            5.0,
            "E",
            "Iniciar Coleta",
            "Pressione para iniciar",
        }
    end
    TriggerEvent("hoverfy:Insert",Table)
    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        if InZone then
            idle = 1
            if InZone and IsControlJustPressed(0,38) and not Milking then
                Milking = true
                TriggerServerEvent("farmer:Milking")
                TriggerEvent("Notify:Text","F6 Para Cancelar Coleta")
            end
        end
        Wait(idle)
    end
end)

AddEventHandler("actions:Cancel",function()
    if Milking then
        LocalPlayer["state"]:set("Buttons",false,true)
        LocalPlayer["state"]:set("Cancel",false,true)
        TriggerEvent("hoverfy:returnHoverfy")
        TriggerEvent("Notify:Text","")
        Milking = false
        InZone = false
        TriggerServerEvent("farmer:CancelMilking")
        TriggerEvent("Progress","Cancelando",0)
    end
end)

RegisterNetEvent("farmer:NewMilking")
AddEventHandler("farmer:NewMilking",function()
    if Milking then
        TriggerServerEvent("farmer:Milking")
    end
end)


local JobVehicles = {
    [tostring(GetHashKey("onibussanta"))] = true,
    [tostring(GetHashKey("tractor2"))] = true,
    [tostring(GetHashKey("sprinter211"))] = true,
    [tostring(GetHashKey("sprinter2112"))] = true,
}

AddEventHandler("gameEventTriggered",function(eventName,args)
    if eventName ~= "CEventNetworkPlayerEnteredVehicle" then
        return
    end

    local Ped = PlayerPedId()
    
    if tonumber(args[1]) ~= PlayerId() or not LocalPlayer["state"]["Active"] then
        return
    end

    if not LocalPlayer["state"]["AnyJob"] then
        return
    end

    Wait(250)

    local Vehicle = GetVehiclePedIsIn(Ped,false)
    local Model = GetEntityModel(Vehicle)

    if not JobVehicles[tostring(Model)] then
        return
    end

    SetLocalPlayerAsGhost(true)
    SetGhostedEntityAlpha(254)

    CreateThread(function()
        while true do
            if not IsPedInAnyVehicle(Ped) then
                SetLocalPlayerAsGhost(false)
                break
            end
            if not LocalPlayer["state"]["AnyJob"] then
                SetLocalPlayerAsGhost(false)
                break
            end
            Wait(500)
        end
    end)
end)


RegisterKeyMapping("autopilot","Cancelar todas as ações.","keyboard","H")
RegisterCommand("autopilot",function()
    -- if not LocalPlayer["state"]["AnyJob"] then
    --     return
    -- end
    Wait(100)
    if LocalPlayer["state"]["JobAutoPilot"] then
        EndJobAutoPilot()
    else
        StartJobAutoPilot(LocalPlayer["state"]["AnyJob"])
    end
end)

function StartJobAutoPilot(Coords)
    LocalPlayer["state"]["JobAutoPilot"] = true
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player)
    if Coords then
        SetEntityMaxSpeed(vehicle,0.28 * 20)
        TaskVehicleDriveToCoordLongrange(player, vehicle, Coords.x, Coords.y, Coords.z, 3516854.5, 32, 5.0)
    end
end

function EndJobAutoPilot()
    LocalPlayer["state"]["JobAutoPilot"] = false
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player)
    SetEntityMaxSpeed(vehicle,0.28 * 500)
    local player = GetPlayerPed(-1)
    ClearPedTasks(player)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
local Harvesting = false
local NearHarvest = false
CreateThread(function()
    while true do
        local Idle = 1000
        if not InJob then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Near = 5
            local isNear = false
            for i=1,#FruitCoords do
                local Start = vector3(FruitCoords[i]["x"],FruitCoords[i]["y"],FruitCoords[i]["z"])
                local Distance = #(Coords - Start)
                if Distance < Near then
                    Near = Distance
                    NearHarvest = i
                    isNear =  true
                end
            end
            if not isNear then
                NearHarvest = false
            end
        end
        Wait(Idle)
    end
end)

CreateThread(function()
    local Table = {}
    for i=1, #FruitCoords do
        Table[i] = {
            FruitCoords[i]["x"],
            FruitCoords[i]["y"],
            FruitCoords[i]["z"],
            5.0,
            "E",
            "Iniciar Coleta",
            "Pressione para iniciar",
        }
    end
    TriggerEvent("hoverfy:Insert",Table)
    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        if NearHarvest then
            idle = 1
            if NearHarvest and IsControlJustPressed(0,38) and not Harvesting then
                Harvesting = true
                TriggerServerEvent("farmer:Harvesting")
                TriggerEvent("Notify:Text","F6 Para Cancelar Coleta")
            end
        end
        Wait(idle)
    end
end)

AddEventHandler("actions:Cancel",function()
    if Harvesting then
        LocalPlayer["state"]:set("Buttons",false,true)
        LocalPlayer["state"]:set("Cancel",false,true)
        TriggerEvent("hoverfy:returnHoverfy")
        TriggerEvent("Notify:Text","")
        Harvesting = false
        InZone = false
        TriggerServerEvent("farmer:CancelHarvesting")
        TriggerEvent("Progress","Cancelando",0)
    end
end)

RegisterNetEvent("farmer:NewHarvesting")
AddEventHandler("farmer:NewHarvesting",function()
    if Harvesting then
        TriggerServerEvent("farmer:Harvesting")
    end
end)


function Creative.GetCoords()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    return coords
end
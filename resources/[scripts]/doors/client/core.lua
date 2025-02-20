-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
local vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("doors")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Display = {}
local Doors = {}
local Cooldown = GetGameTimer()
local DoorsConfig = exports["variables"]:GetDoors()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Doors",function()
	if LocalPlayer["state"]["Route"] < 900000 and GetGameTimer() >= Cooldown then
		Cooldown = GetGameTimer() + 10000

		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		for Number,v in pairs(DoorsConfig) do
			local Distance = #(Coords - v["Coords"])
			if Distance <= v["Distance"] then
				if vSERVER.DoorsPermission(Number) then
					if not Display[Number] then
						TriggerEvent("hoverfy:toggle", true, { title = Doors[Number] and "Trancado" or "Destrancado", key = "E", legend = Doors[Number] and "Para destrancar" or "Para trancar" })
						Display[Number] = true
					end

					vRP.playAnim(true,{"anim@heists@keycard@","exit"},true)
					Wait(350)
					vRP.stopAnim()
				end

				break
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	local Unlocked = vSERVER.Unlocked()

-- 	for Number,v in pairs(DoorsConfig) do
-- 		if IsDoorRegisteredWithSystem(Number) then
-- 			RemoveDoorFromSystem(Number)
-- 		end
-- 		AddDoorToSystem(Number,v["Hash"],v["Coords"],false,false,true)

-- 		DoorSystemSetOpenRatio(Number,0.0,false,false)
-- 		DoorSystemSetAutomaticRate(Number,2.0,false,false)

-- 		local Locked = 1

-- 		for _, Id in ipairs(Unlocked) do
-- 			if Id == Number then
-- 				Locked = 0
-- 				break
-- 			end
-- 		end
-- 		Doors[Number] = Locked == 1
-- 		DoorSystemSetDoorState(Number, Locked, true)
-- 	end
-- end)

RegisterNetEvent("Doors", function(Number, Status)
	DoorSystemSetOpenRatio(Number,0.0,false,false)
	DoorSystemSetAutomaticRate(Number,2.0,false,false)
	DoorSystemSetDoorState(Number,Status and 1 or 0,true)

	Doors[Number] = Status

	local Second = DoorsConfig[Number]["Other"]

	if Second ~= nil then
		Doors[Second] = Status
		DoorSystemSetDoorState(Second, Status and 1 or 0, true)
	end

	if Display[Number] then
		TriggerEvent("hoverfy:toggle", true, { title = Status and "Trancado" or "Destrancado", key = "E", legend = Status and "Para destrancar" or "Para trancar" })
	end
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

CreateThread(function()
    -- for i=1,5000 do
    --     DoorSystemSetOpenRatio(i, 0.0, false --[[ network ]], false --[[ flushState ]])
    --     DoorSystemSetAutomaticRate(i, 2.0, false --[[ network ]], false --[[ flushState ]])
    --     DoorSystemSetDoorState(i, true, false --[[ network ]], true --[[ flushState ]])
    -- end
    while true do
        if LocalPlayer["state"]["Route"] > 1 then
            for i=1,5000 do
                DoorSystemSetOpenRatio(i, 0.0, false --[[ network ]], false --[[ flushState ]])
                DoorSystemSetAutomaticRate(i, 2.0, false --[[ network ]], false --[[ flushState ]])
                DoorSystemSetDoorState(i, false, false --[[ network ]], true --[[ flushState ]])
            end
        end
        Wait(500)
    end
end)
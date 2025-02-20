-----------------------------------------------------------------------------------------------------------------------------------------
-- ENGINE
-----------------------------------------------------------------------------------------------------------------------------------------
local Engine = {
	["Delta"] = 0.0,
	["Scale"] = 0.0,
	["New"] = 1000.0,
	["Last"] = 1000.0,
	["Current"] = 1000.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BODY
-----------------------------------------------------------------------------------------------------------------------------------------
local Body = {
	["Delta"] = 0.0,
	["Scale"] = 0.0,
	["New"] = 1000.0,
	["Last"] = 1000.0,
	["Current"] = 1000.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
local Health = {
	["Delta"] = 0,
	["Scale"] = 0,
	["New"] = 1000,
	["Last"] = 1000,
	["Current"] = 1000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Last = nil
local Same = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASS
-----------------------------------------------------------------------------------------------------------------------------------------
local Class = {
	[0] = 1.5,
	[1] = 1.5,
	[2] = 1.5,
	[3] = 1.5,
	[4] = 1.5,
	[5] = 1.5,
	[6] = 1.5,
	[7] = 1.5,
	[8] = 1.5,
	[9] = 1.5,
	[10] = 1.5,
	[11] = 1.5,
	[12] = 1.5,
	[13] = 1.5,
	[14] = 0.0,
	[15] = 0.5,
	[16] = 0.5,
	[17] = 1.5,
	[18] = 1.5,
	[19] = 1.5,
	[20] = 1.5,
	[21] = 1.5,
	[22] = 1.5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTHVEH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Classes = GetVehicleClass(Vehicle)
			if Classes ~= 13 and Classes ~= 14 then
				TimeDistance = 1

				if Same then
					local Torque = 1.0
					if Engine["New"] < 900 then
						Torque = (Engine["New"] + 200.0) / 1100
					end

					SetVehicleEngineTorqueMultiplier(Vehicle,Torque)
				end

				if GetPedInVehicleSeat(Vehicle,-1) == Ped then
					local Roll = GetEntityRoll(Vehicle)
					if Roll > 75.0 or Roll < -75.0 then
						DisableControlAction(1,59,true)
						DisableControlAction(1,60,true)
					end
				end

				Engine["Current"] = GetVehicleEngineHealth(Vehicle)
				if Engine["Current"] >= 1000 then
					Engine["Last"] = 1000.0
				end

				Engine["New"] = Engine["Current"]
				Engine["Delta"] = Engine["Last"] - Engine["Current"]
				Engine["Scale"] = Engine["Delta"] * 0.6 * Class[Classes + 1]

				Body["Current"] = GetVehicleBodyHealth(Vehicle)
				if Body["Current"] >= 1000 then
					Body["Last"] = 1000.0
				end

				Body["New"] = Body["Current"]
				Body["Delta"] = Body["Last"] - Body["Current"]
				Body["Scale"] = Body["Delta"] * 0.6 * Class[Classes + 1]

				Health["Current"] = GetEntityHealth(Vehicle)
				if Health["Current"] >= 1000 then
					Health["Last"] = 1000
				end

				Health["New"] = Health["Current"]
				Health["Delta"] = Health["Last"] - Health["Current"]
				Health["Scale"] = Health["Delta"] * 0.6 * Class[Classes + 1]

				if Vehicle ~= Last then
					Same = false
				end

				if Same then
					if Engine["Current"] ~= 1000.0 or Body["Current"] ~= 1000.0 then
						local Combine = math.max(Engine["Scale"],Body["Scale"])
						if Combine > (Engine["Current"] - 100.0) then
							Combine = Combine * 0.7
						end

						if Combine > Engine["Current"] then
							Combine = Engine["Current"] - (210.0 / 5)
						end

						Engine["New"] = Engine["Last"] - Combine

						if Engine["New"] > 210.0 and Engine["New"] < 350.0 then
							Engine["New"] = Engine["New"] - (0.038 * 7.4)
						end

						if Engine["New"] < 210.0 then
							Engine["New"] = Engine["New"] - (0.1 * 1.5)
						end

						if Body["New"] < 0 then
							Body["New"] = 0.0
						end

						if Engine["New"] < 0 then
							Engine["New"] = 0.0
						end
					end
				else
					Same = true
				end

				if Health["Current"] < 100 then
					Health["New"] = 100
				end

				if Body["Current"] < 100.0 then
					Body["New"] = 100.0
				end

				if Engine["Current"] < 100.0 then
					Engine["New"] = 100.0
				end

				if Engine["New"] ~= Engine["Current"] then
					SetVehicleEngineHealth(Vehicle,Engine["New"])
				end

				if Body["New"] ~= Body["Current"] then
					SetVehicleBodyHealth(Vehicle,Body["New"])
				end

				if Health["New"] ~= Health["Current"] then
					SetEntityHealth(Vehicle,Health["New"])
					SetVehiclePetrolTankHealth(Vehicle,Health["New"] + 0.0)
				end

				Last = Vehicle
				Body["Last"] = Body["New"]
				Health["Last"] = Health["New"]
				Engine["Last"] = Engine["New"]
			end
		else
			if Same then
				Same = false
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREEXPLOSION
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped then
				local Roll = GetEntityRoll(Vehicle)
				if Roll > 75.0 or Roll < -75.0 then
					if math.random(100) <= 15 and GetVehicleClass(Vehicle) ~= 8 and GetVehicleClass(Vehicle) ~= 13 and GetVehicleClass(Vehicle) ~= 14 and GetVehicleClass(Vehicle) ~= 15 and GetVehicleClass(Vehicle) ~= 16 then
						local Tyre = math.random(4)

						if Tyre == 1 then
							if GetTyreHealth(Vehicle,0) == 1000.0 then
								SetVehicleTyreBurst(Vehicle,0,true,1000.0)
							end
						elseif Tyre == 2 then
							if GetTyreHealth(Vehicle,1) == 1000.0 then
								SetVehicleTyreBurst(Vehicle,1,true,1000.0)
							end
						elseif Tyre == 3 then
							if GetTyreHealth(Vehicle,4) == 1000.0 then
								SetVehicleTyreBurst(Vehicle,4,true,1000.0)
							end
						elseif Tyre == 4 then
							if GetTyreHealth(Vehicle,5) == 1000.0 then
								SetVehicleTyreBurst(Vehicle,5,true,1000.0)
							end
						end
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStop",function(Resource)
	TriggerServerEvent("AnyResourceStop",Resource)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
        local idle = 1500
        if Distance < 10.0 and not IsPedInAnyVehicle(ped) then
            idle = 500
            if Distance < 3.9 then
                Vehicle.Coords = GetEntityCoords(closestVehicle)
                Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
                Vehicle.Vehicle = closestVehicle
                Vehicle.Distance = Distance
                if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
                    Vehicle.IsInFront = false
                else
                    Vehicle.IsInFront = true
                end
            else
                Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
            end
        end
		Wait(idle)
	end
end)

CreateThread(function()
	while Vehicle.Vehicle ~= nil do
		Wait(500)
		if Vehicle.Vehicle ~= nil and GetVehicleDoorLockStatus(Vehicle.Vehicle) == 1 then
			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityInWater(ped) and not IsEntityInAir(ped) and not IsPedBeingStunned(ped) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				Wait(1000)
				if IsControlPressed(0,244) and IsInputDisabled(0) then
					RequestAnimDict('missfinale_c2ig_11')
					TaskPlayAnim(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0,-8.0,-1,35,0,0,0,0)
					NetworkRequestControlOfEntity(Vehicle.Vehicle)

					if Vehicle.IsInFront then
						AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
					else
						AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
					end

					while true do
						Wait(5)
						if IsDisabledControlPressed(0,34) then
							TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
						end

						if IsDisabledControlPressed(0,9) then
							TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
						end

						if Vehicle.IsInFront then
							SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
						else
							SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
						end

						if not IsDisabledControlPressed(0,244) then
							DetachEntity(ped,false,false)
							StopAnimTask(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0)
							break
						end
					end
				end
			end
		end
	end
end)
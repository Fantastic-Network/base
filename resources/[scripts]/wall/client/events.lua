RegisterNetEvent("admin:changeVehiclePlate", function(EntityId, NewPlate)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) or EntityId then
		local vehicle = GetVehiclePedIsUsing(ped)

		if EntityId then
			vehicle = NetworkGetEntityFromNetworkId(EntityId)
		end

		if not DoesEntityExist(vehicle) then return end
		SetVehicleNumberPlateText(vehicle, NewPlate)
	end
end)

RegisterNetEvent("admin:tpInVehicle", function(EntityId)
	if EntityId then
		local Ped = PlayerPedId()
		local Vehicle = NetworkGetEntityFromNetworkId(EntityId)
		if not DoesEntityExist(Vehicle) then return end

		local MaxSeats = GetVehicleMaxNumberOfPassengers(Vehicle)
		for i = -1, MaxSeats do
			local PedInSeat = GetPedInVehicleSeat(Vehicle, i)
			if not PedInSeat or parseInt(PedInSeat) == 0 then
				TaskWarpPedIntoVehicle(Ped, Vehicle, i)
				return
			end
		end
	end
end)

RegisterNetEvent("admin:driveVehicle", function(EntityId)
	if EntityId then
		local Ped = PlayerPedId()
		local Vehicle = NetworkGetEntityFromNetworkId(EntityId)
		if not DoesEntityExist(Vehicle) then return end

		Wait(200)

		CreateThread(function()

			local FirstNotify = true

			while true do
				local threadDelay = 1

				Vehicle = NetworkGetEntityFromNetworkId(EntityId)
				if not DoesEntityExist(Vehicle) then return end

				local DriverPed = GetPedInVehicleSeat(Vehicle, -1)
				if not DoesEntityExist(DriverPed) or parseInt(DriverPed) == 0 or IsPedAPlayer(DriverPed) then return end

				if not NetworkHasControlOfEntity(DriverPed) then
					NetworkRequestControlOfEntity(DriverPed)
				end

				if not NetworkHasControlOfEntity(Vehicle) then
					NetworkRequestControlOfEntity(Vehicle)
				end

				if IsControlPressed(0, 23) then
					ClearPedTasks(DriverPed)
					ClearPedSecondaryTask(DriverPed)
					SetBlockingOfNonTemporaryEvents(DriverPed, false)
					TaskVehicleDriveWander(DriverPed, Vehicle, 20.0, 387)
					return
				end

				if NetworkHasControlOfEntity(DriverPed) and NetworkHasControlOfEntity(Vehicle) then

					if FirstNotify then
						FirstNotify = false
						SetEntityAsMissionEntity(Vehicle, true, true)
						SetEntityAsMissionEntity(DriverPed, true, true)
						TriggerEvent("Notify","verde","Você assumiu o controle do veículo. Pressione <green>F</green> para sair.",8000)
					end

					local VehicleCoords = GetEntityCoords(Vehicle)
					local FrontVector = GetEntityForwardVector(Vehicle)
					SetEntityCoords(Ped, VehicleCoords.x - (FrontVector.x * 3), VehicleCoords.y - (FrontVector.y * 3), VehicleCoords.z + 0.6)

					ClearPedTasks(DriverPed)
					ClearPedSecondaryTask(DriverPed)
					SetBlockingOfNonTemporaryEvents(DriverPed, true)

					if IsControlPressed(0, 72) and IsControlPressed(0, 71) then
						TaskVehicleTempAction(DriverPed, Vehicle, 30, 1)
					end

					if IsControlPressed(0, 72) and not IsControlPressed(0, 71) then
						TaskVehicleTempAction(DriverPed, Vehicle, 22, 1)
					end

					if IsControlPressed(0, 64) and IsControlPressed(0, 72) then
						TaskVehicleTempAction(DriverPed, Vehicle, 14, 1)
					end

					if IsControlPressed(0, 63) and IsControlPressed(0, 72) then
						TaskVehicleTempAction(DriverPed, Vehicle, 13, 1)
					end

					if IsControlPressed(0, 71) then
						TaskVehicleTempAction(DriverPed, Vehicle, 32, 1)
					end

					if IsControlPressed(0, 63) then
						if IsControlPressed(0, 71) then
							TaskVehicleTempAction(DriverPed, Vehicle, 7, 1)
						else
							TaskVehicleTempAction(DriverPed, Vehicle, 4, 1)
						end
					end

					if IsControlPressed(0, 64) then
						if IsControlPressed(0, 71) then
							TaskVehicleTempAction(DriverPed, Vehicle, 8, 1)
						else
							TaskVehicleTempAction(DriverPed, Vehicle, 5, 1)
						end
					end
				end

				Wait(threadDelay)
			end
		end)
	end
end)

RegisterNetEvent("admin:moveVehicle", function(EntityId)
	if EntityId then
		local Ped = PlayerPedId()
		local Vehicle = NetworkGetEntityFromNetworkId(EntityId)
		if not DoesEntityExist(Vehicle) then return end

		Wait(200)

		CreateThread(function()

			local FirstNotify = true
			local Heading = 0.0

			while true do
				local threadDelay = 1

				Vehicle = NetworkGetEntityFromNetworkId(EntityId)
				if not DoesEntityExist(Vehicle) then return end

				local DriverPed = GetPedInVehicleSeat(Vehicle, -1)
				if DoesEntityExist(DriverPed) and IsPedAPlayer(DriverPed) then return end

				if DoesEntityExist(DriverPed) and not NetworkHasControlOfEntity(DriverPed) then
					NetworkRequestControlOfEntity(DriverPed)
				end

				if not NetworkHasControlOfEntity(Vehicle) then
					NetworkRequestControlOfEntity(Vehicle)
				end

				if IsControlPressed(0, 23) then
					ClearPedTasks(DriverPed)
					ClearPedSecondaryTask(DriverPed)
					SetBlockingOfNonTemporaryEvents(DriverPed, false)
					TaskVehicleDriveWander(DriverPed, Vehicle, 20.0, 387)
					return
				end

				if FirstNotify then
					FirstNotify = false
					SetEntityAsMissionEntity(Vehicle, true, true)
					if DoesEntityExist(DriverPed) then
						SetEntityAsMissionEntity(DriverPed, true, true)
					end
					TriggerEvent("Notify","verde","Você assumiu o controle do veículo. Pressione <green>F</green> para sair.",8000)
				end

				if (not DoesEntityExist(DriverPed) or NetworkHasControlOfEntity(DriverPed)) and NetworkHasControlOfEntity(Vehicle) then
					local _,entCoords,_ = RayCastGamePlayCamera(99999.0)
					SetEntityCoords(Vehicle, entCoords.x, entCoords.y, entCoords.z)
					SetEntityHeading(Vehicle, Heading)

					if IsControlPressed(0, 45) then
						Heading = Heading + 2.0
					end
				end

				Wait(threadDelay)
			end
		end)
	end
end)

RegisterNetEvent("admin:vehicleTuning")
AddEventHandler("admin:vehicleTuning",function(EntityId)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) or EntityId then
		local vehicle = GetVehiclePedIsUsing(ped)

		if EntityId then
			vehicle = NetworkGetEntityFromNetworkId(EntityId)
		end

		if not DoesEntityExist(vehicle) then return end

		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-1,false)
		ToggleVehicleMod(vehicle,18,true)
	end
end)

RegisterNetEvent("admin:knockPlayer")
AddEventHandler("admin:knockPlayer", function(TimeKnocked)
    TimeKnocked = TimeKnocked and parseInt(TimeKnocked * 1000) or 1000
    local Ped = PlayerPedId()
	SetPedCanRagdoll(PlayerPedId(), true)
    SetPedToRagdoll(Ped, TimeKnocked, TimeKnocked, 0, 0, 0, 0)
end)

RegisterNetEvent("admin:explodePlayer")
AddEventHandler("admin:explodePlayer", function()
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    AddExplosion(Coords.x, Coords.y, Coords.z, 4, 0.0, true, false, 3.0)
end)

RegisterNetEvent("admin:explodeVehicle", function(EntityId)
	if EntityId then
		local Vehicle = NetworkGetEntityFromNetworkId(EntityId)
		if not DoesEntityExist(Vehicle) then return end
		local Coords = GetEntityCoords(Vehicle)
		AddExplosion(Coords.x, Coords.y, Coords.z, 4, 20.0, true, false, 1.5)
	end
end)
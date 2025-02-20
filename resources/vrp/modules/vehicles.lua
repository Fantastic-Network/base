-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("CleanVehicle")
AddEventHandler("CleanVehicle",function(Index)
	local Network = NetworkGetEntityFromNetworkId(Index)
	if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
		SetVehicleDirtLevel(Network,0.0)
	end
end)
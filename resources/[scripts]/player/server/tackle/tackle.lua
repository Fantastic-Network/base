-----------------------------------------------------------------------------------------------------------------------------------------
-- TACKLE:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tackle:Update")
AddEventHandler("tackle:Update",function(source,Coords)
	local ped = GetPlayerPed(source)
	if ped and #(GetEntityCoords(ped) - Coords) > 6.0 then
		return false
	end
	if vRP.Passport(source) then
		TriggerClientEvent("tackle:Player",source,Coords)
	end
end)
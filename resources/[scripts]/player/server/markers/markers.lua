-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.UsersMarkers()
	local Markers = {}

	for Index,v in pairs(Players) do
		local Ped = GetPlayerPed(Index)
		if DoesEntityExist(Ped) then
			Markers[Index] = {
				["Coords"] = GetEntityCoords(Ped),
				["Service"] = v
			}
		end
	end

	return Markers
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
exports("EnterMarkers",function(source,Permission)
	-- if not Players[source] then
	-- 	Players[source] = Permission

	-- 	local Service = vRP.NumPermission("Emergency")
	-- 	for _,Sources in pairs(Service) do
	-- 		async(function()
	-- 			TriggerClientEvent("markers:Add",Sources,source,Permission)
	-- 		end)
	-- 	end
	-- end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXIT
-----------------------------------------------------------------------------------------------------------------------------------------
exports("ExitMarkers",function(source)
	-- if Players[source] then
	-- 	Players[source] = nil

	-- 	local Service = vRP.NumPermission("Emergency")
	-- 	for _,Sources in pairs(Service) do
	-- 		async(function()
	-- 			TriggerClientEvent("markers:Remove",Sources,source)
	-- 		end)
	-- 	end
	-- end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	--exports["player"]:ExitMarkers(source)
end)
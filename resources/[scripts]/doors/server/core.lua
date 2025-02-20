-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("doors",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Doors = {}
local DoorsConfig = exports["variables"]:GetDoors()

for k,v in pairs(DoorsConfig) do
	Doors[k] = v["Lock"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DoorsPermission(Number)
	local source = source
	local Passport = vRP.Passport(source)
	local Entry = DoorsConfig[Number]

	if not Passport or not Entry then
		return
	end

	if Entry["Perm"] ~= nil then
		if vRP.HasGroup(Passport,Entry["Perm"]) then
			Doors[Number] = not Doors[Number]
			if Entry["Other"] ~= nil then
				Doors[Entry["Other"]] = Doors[Number]
			end
			
			TriggerClientEvent('Doors', -1, Number, Doors[Number])
			return true
		end
	end
end

function Creative.Unlocked()
	local Ids = {}

	for Number, Door in pairs(DoorsConfig) do
		if not Door["Lock"] then
			table.insert(Ids, Number)
		end
	end

	return Ids
end
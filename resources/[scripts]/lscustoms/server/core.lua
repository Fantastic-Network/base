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
Tunnel.bindInterface("lscustoms",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkPermission(hasPerm)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not hasPerm then
			return true
		else
			if vRP.HasGroup(Passport,hasPerm) then
				return true
			end
		end
	end

	return false
end

RegisterCommand("vehedit",function(source,args,rawCommand)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) then
            TriggerClientEvent("lscustoms:openMenu",source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:attemptPurchase")
AddEventHandler("lscustoms:attemptPurchase",function(type,mod)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if type == "engines" or type == "brakes" or type == "transmission" or type == "suspension" or type == "shield" then
			local Price = vehicleCustomisationPrices[type][mod]

			if vRP.PaymentFull(Passport,Price) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		else
			if vRP.PaymentFull(Passport,vehicleCustomisationPrices[type]) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:updateVehicle")
AddEventHandler("lscustoms:updateVehicle",function(Mods,Plate,vehName)
	local Passport = vRP.PassportPlate(Plate)
	if Passport then
        Passport =  {Passport = Passport }
		vRP.Query("entitydata/SetData",{ dkey = "Mods:"..Passport["Passport"]..":"..vehName, dvalue = json.encode(Mods) })
        -- local PlayerAchievement = vRP.GetPlayerAchievements(Passport["Passport"])
        -- if not PlayerAchievement[15] or not PlayerAchievement[15]["completed"] then
        --     vRP.UpdateAchievement(Passport["Passport"],15,1)
        -- end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local inVehicle = {}
RegisterServerEvent("lscustoms:inVehicle")
AddEventHandler("lscustoms:inVehicle",function(Network,Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Network then
			if inVehicle[Passport] then
				inVehicle[Passport] = nil
			end
		else
			inVehicle[Passport] = { Network,Plate }
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if inVehicle[Passport] then
		Wait(1000)
		TriggerEvent("garages:deleteVehicle",inVehicle[Passport][1],inVehicle[Passport][2])
		inVehicle[Passport] = nil
	end
end)
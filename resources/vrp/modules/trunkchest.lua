local VehicleChests = {}
local VehicleUpdate = {}
local TimeToUpdate = 60*3

function vRP.SpawnVehicle(Passport,Plate)
    local Query = vRP.Query("vehicles/rGetChest",{ Plate })
    if Query and Query[1] then
        local Chest = json.decode(Query[1]["chest"]) or {}
        local Plate = Query[1]["plate"]
        local Model = Query[1]["vehicle"]
        VehicleChests[Plate] = { Chest = Chest, Model = Model, Owner = Passport }
        exports["inventory"]:UpdateChests(Plate,VehicleChests[Plate])
    end
end

function vRP.DeleteVehicle(Plate)
    if VehicleChests[Plate] then
        if VehicleUpdate[Plate] then
            local Chest = json.encode(VehicleChests[Plate]["Chest"])
            vRP.Query("vehicles/rUpdateChest",{ Chest,Plate })
            exports["inventory"]:UpdateChests(Plate,nil)
            VehicleChests[Plate] = nil
            VehicleUpdate[Plate] = nil
        end
    end
end

function GetVehicleChests()
    return VehicleChests
end
exports("GetVehicleChests",GetVehicleChests)

CreateThread(function()
    while true do
        for Plate,Time in pairs(VehicleUpdate) do
            if os.time() >= Time then
                VehicleUpdate[Plate] = nil
                local Chest = json.encode(VehicleChests[Plate]["Chest"])
                vRP.Query("vehicles/rUpdateChest",{ Chest,Plate })
            end
        end
        Wait(60000*5)
    end
end)

function vRP.StoreTrunk(Passport,Plate,Amount,Weight,Slot,Target)
	local Returned = true
	local Amount = parseInt(Amount)
    local source = vRP.Source(Passport)
	if source and Amount > 0 then
		local Slot = tostring(Slot)
		local Target = tostring(Target)

		local Inv = vRP.Inventory(Passport)

		if Inv[Slot] and VehicleChests[Plate] and VehicleChests[Plate]["Chest"] then
			local Item = Inv[Slot]["item"]
			local Consult = VehicleChests[Plate]["Chest"]

			if (vRP.ChestWeight(Consult) + (itemWeight(Item) * Amount)) <= Weight then
				if Consult[Target] and Inv[Slot] then
					if Item == Consult[Target]["item"] then
						if Inv[Slot]["amount"] >= Amount then
							Consult[Target]["amount"] = Consult[Target]["amount"] + Amount
							Inv[Slot]["amount"] = Inv[Slot]["amount"] - Amount

							if Inv[Slot]["amount"] <= 0 then
								if itemType(Item) == "Armamento" or itemType(Item) == "Throwing" then
									TriggerClientEvent("inventory:verifyWeapon",source,Item)
								end
                                vRP.TakeItem(Passport,Inv[Slot]["item"],Inv[Slot]["amount"],true,Slot)
								Inv[Slot] = nil
							end
                            
							Returned = false
						end
					end
				else
					if Inv[Slot] then
						if Inv[Slot]["amount"] >= Amount then
							Consult[Target] = { item = Item, amount = Amount }
							Inv[Slot]["amount"] = Inv[Slot]["amount"] - Amount

							if Inv[Slot]["amount"] <= 0 then
								if itemType(Item) == "Armamento" or itemType(Item) == "Throwing" then
									TriggerClientEvent("inventory:verifyWeapon",source,Item)
								end
                                
								Inv[Slot] = nil
							end
							Returned = false
						end
					end
				end
                VehicleChests[Plate]["Chest"] = Consult
                VehicleUpdate[Plate] = os.time() + TimeToUpdate
                exports["inventory"]:UpdateChests(Plate,VehicleChests[Plate])
                SendWebHook("colocar-bau-carro","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Colocou: **"..Amount.." "..Item.."\n**Carro: **"..Plate..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
			end
		end
        TriggerClientEvent("inventory:HasToUpdate",source)
	end

	return Returned
end

function vRP.TakeTrunk(Passport,Plate,Amount,Slot,Target)
	local Returned = true
	local Amount = parseInt(Amount)
    local source = vRP.Source(Passport)
	if source and Amount > 0 and VehicleChests[Plate] then
		local Slot = tostring(Slot)
		local Consult = VehicleChests[Plate]["Chest"]

		if Consult[Slot] then
			local Item = Consult[Slot]["item"]

			if (vRP.InventoryWeight(Passport) + itemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
				local Target = tostring(Target)
				local Inv = vRP.Inventory(Passport)

				if Inv[Target] and Consult[Slot] then
					if Inv[Target]["item"] == Item and Consult[Slot]["amount"] >= Amount then
						Inv[Target]["amount"] = Inv[Target]["amount"] + Amount
						Consult[Slot]["amount"] = Consult[Slot]["amount"] - Amount

						if Consult[Slot]["amount"] <= 0 then
							Consult[Slot] = nil
						end
						Returned = false
					end
				else
					if Consult[Slot] and Consult[Slot]["amount"] >= Amount then
						Inv[Target] = { item = Item, amount = Amount }
						Consult[Slot]["amount"] = Consult[Slot]["amount"] - Amount

						if Consult[Slot]["amount"] <= 0 then
							Consult[Slot] = nil
						end
						Returned = false
					end
				end
                VehicleChests[Plate]["Chest"] = Consult
                VehicleUpdate[Plate] = os.time() + TimeToUpdate
                exports["inventory"]:UpdateChests(Plate,VehicleChests[Plate])
			end
			SendWebHook("retirar-bau-carro","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**retirar: **"..Amount.." "..Item.."\n**Carro: **"..Plate..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
		end
        TriggerClientEvent("inventory:HasToUpdate",source)
	end

	return Returned
end
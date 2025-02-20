local TrunkChestAPI = {}
Tunnel.bindInterface("inventory/trunkchest",TrunkChestAPI)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicle = {}
local VehicleChests = {}

CreateThread(function()
    VehicleChests = exports["vrp"]:GetVehicleChests()
end)

function UpdateChests(Plate,Data)
    VehicleChests[Plate] = Data
end
exports("UpdateChests",UpdateChests)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function TrunkChestAPI.openChest()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] and VehicleChests[Vehicle[Passport]["Plate"]] then
        local vehInfos = {}
        local Plate = Vehicle[Passport]["Plate"]
        local Result = VehicleChests[Plate]["Chest"]
        for k,v in pairs(Result) do
            v["amount"] = parseInt(v["amount"])
            v["key"] = v["item"]
            v["slot"] = tonumber(k)
            
            local splitName = splitString(v["item"],"-")
            if splitName[2] ~= nil then
                if itemDurability(v["item"]) then
                    v["durability"] = parseInt(os.time() - splitName[2])
                    v["days"] = itemDurability(v["item"])
                else
                    v["durability"] = 0
                    v["days"] = 1
                end
            else
                v["durability"] = 0
                v["days"] = 1
            end

            table.insert(vehInfos,v)
        end
        if Vehicle[Passport] then
            return vehInfos,vRP.ChestWeight(VehicleChests[Plate]["Chest"]),Vehicle[Passport]["Weight"] or 0
        end
        return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREVEHS
-----------------------------------------------------------------------------------------------------------------------------------------
local storeVehs = {
	["ratloader"] = {
		["woodlog"] = true
	},
	["trash"] = {
		["glassbottle"] = true,
		["plasticbottle"] = true,
		["elastic"] = true,
		["metalcan"] = true,
		["battery"] = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function TrunkChestAPI.updateChest(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if Amount <= 0 then Amount = 1 end
        TriggerClientEvent("trunkchest:Update",source,"requestChest")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function TrunkChestAPI.storeItem(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
        local Plate = Vehicle[Passport]["Plate"]
		if Amount <= 0 then Amount = 1 end
		local vehName = Vehicle[Passport]["Model"]
        if IsBlackListed(Item) then
            TriggerClientEvent("Notify",source,"vermelho","Você não pode guardar esse item.",5000,"PORTA MALAS")
			-- TriggerClientEvent("Notify2",source,"#cantStoreItem")
            return
        end

		if (itemType(Item) == "Armamento" or itemType(Item) == "Munição") and vRP.HasGroup(Passport,"Policia") then
            TriggerClientEvent("Notify",source,"vermelho","Você não pode colocar esse item.",5000,"PORTA MALAS")
			-- TriggerClientEvent("Notify2",source,"#cannotPutItem")
            return
        end

		if (storeVehs[vehName] and not storeVehs[vehName][Item]) or Item == "dollars" or itemBlock(Item) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
			TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
			-- TriggerClientEvent("Notify2",source,"#noStorage")
			goto scapeInventory
		end

		if vRP.StoreTrunk(Passport,Vehicle[Passport]["Plate"],Amount,Vehicle[Passport]["Weight"],Slot,Target) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
		else
            if Passport then
                if Vehicle[Passport] then
                    local VehicleOwner = VehicleChests[Plate]["Owner"]
                    local Result = VehicleChests[Plate]["Chest"]
                    TriggerClientEvent("trunkchest:UpdateWeight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Vehicle[Passport]["Weight"])
                    --exports["vrp"]:SendWebHook("colocar-bau-carro","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Colocou: **"..Amount.." "..Item.."\n**Carro: **"..Vehicle[Passport]["Model"].."\n**Dono:**"..VehicleOwner.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                end
            end
		end
	end

	::scapeInventory::
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function TrunkChestAPI.takeItem(Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		if Amount <= 0 then Amount = 1 end
        local Plate = Vehicle[Passport]["Plate"]
		if vRP.TakeTrunk(Passport,Plate,Amount,Slot,Target) then
			TriggerClientEvent("trunkchest:Update",source,"requestChest")
		else
			if Vehicle[Passport] then
				local Result = VehicleChests[Plate]["Chest"]
				TriggerClientEvent("trunkchest:UpdateWeight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Vehicle[Passport]["Weight"])
				-- exports["vrp"]:SendWebHook("retirar-bau-carro","**Passaporte:** "..Passport.."\n**retirou: **"..Amount.." \n**Carro: **"..Vehicle[Passport]["Model"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function TrunkChestAPI.TakeAll(filtered)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport or not Vehicle[Passport] then
        return
	end
    local Plate = Vehicle[Passport]["Plate"]
    local userItems = vRP.Inventory(Passport)
    local MaxSlots = 50

    local nextTrunkSlot = 0
	for i = 1,MaxSlots do
		if not userItems[tostring(i)] then
            nextTrunkSlot = nextTrunkSlot + 1
            local items = VehicleChests[Plate]["Chest"]
            local item = items[tostring(nextTrunkSlot)]
            if not (item) then
                goto skip
            end
            local tag = SplitOne(item.item)
            if (filtered and (not PoliceCleaner[tag])) then
                goto skip
            end

            if not vRP.TakeTrunk(Passport,Plate, item.amount, nextTrunkSlot, i) then
                goto skip
            end
            Wait(250)
        end
        ::skip::
    end

    TriggerClientEvent("Notify",source,"sucesso","Itens coletados.",5000)
	-- TriggerClientEvent("Notify2",source,"#itensCollected")
    TriggerClientEvent("trunkchest:Update",source,"requestChest")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function TrunkChestAPI.chestClose()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Vehicle[Passport] then
		TriggerClientEvent("player:syncDoorsOptions",source,Vehicle[Passport]["Net"],"close")
		Vehicle[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:OPENTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		for _,v in pairs(Vehicle) do
			if v["Plate"] == Entity[1] then
				return
			end
		end

		if VehicleChest(Entity[2]) > 0 then
			local PassportPlate = vRP.PassportPlate(Entity[1])
            if PassportPlate ~= Passport then
                local PlateSource = vRP.Source(PassportPlate)
                local Identity = vRP.Identity(Passport)
                if PlateSource and DoesPlayerExist(PlateSource) and Identity and Identity["name"] then
                    TriggerClientEvent("Notify",source,"amarelo","Aguarde o dono do veículo abrir o porta-malas.",5000,"PORTA MALAS")
                    if not vRP.Request(PlateSource,"<b>"..Identity["name"].."</b> deseja abrir o porta-malas do veiculo <b>"..tostring(VehicleName(Entity[2])).."</b> voce autoriza?",30) then
                        TriggerClientEvent("Notify",source,"vermelho","Você não é o dono do veículo.",5000,"PORTA MALAS")
                        return
                    end
                else
                    TriggerClientEvent("Notify",source,"vermelho","Você não é o dono do veículo.",5000,"PORTA MALAS")
                    return
                end
            end
			if PassportPlate then
                PassportPlate =  {Passport = PassportPlate }
				Vehicle[Passport] = {
					["Net"] = Entity[4],
					["Plate"] = Entity[1],
					["Model"] = Entity[2],
					["User"] = PassportPlate["Passport"],
					["Weight"] = vRP.GetVehicleChest(Passport,Entity[2]),
				}
                if not VehicleChests[Entity[1]] then
                    vRP.SpawnVehicle(Passport,Entity[1])
                end
				local Network = NetworkGetEntityFromNetworkId(Vehicle[Passport]["Net"])

				if GetVehicleDoorLockStatus(Network) <= 1 then
					TriggerClientEvent("trunkchest:Open",source)
					TriggerClientEvent("player:syncDoorsOptions",source,Vehicle[Passport]["Net"],"open")
				else
					TriggerClientEvent("Notify",source,"amarelo","Veículo trancado.",5000)
					-- TriggerClientEvent("Notify2",source,"#lockVeic")
					Vehicle[Passport] = nil
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Vehicle[Passport] then
		Vehicle[Passport] = nil
	end
end)
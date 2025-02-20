-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Entitys = {}
ItemId = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTITEM
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRP.ConsultItem(Passport,Item,Amount)
	if vRP.Source(Passport) then
		local Consult = vRP.InventoryItemAmount(Passport,Item)
		if Consult[1] < Amount then
			return false
		else
			if vRP.CheckDamaged(Consult[2]) then
				return false
			end
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEIGHTS
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRP.GetWeight(Passport)
	if vRP.Source(Passport) then
		local Datatable = vRP.Datatable(Passport)
		if Datatable then
			if not Datatable["Weight"] then
				Datatable["Weight"] = 90
			end

			local Weight = Datatable["Weight"]

            if Weight <= 500 then
                if vRP.HasPermission(Passport,"Premium",1) then
                    Weight = Weight + 90
                elseif vRP.HasPermission(Passport,"Premium",2) then
                    Weight = Weight + 90
                elseif vRP.HasPermission(Passport,"Premium",3) then
                    Weight = Weight + 60
                elseif vRP.HasPermission(Passport,"Premium",4) then
                    Weight = Weight + 30
                elseif vRP.HasGroup(Passport,"Lancamento",1) then
                    Weight = Weight + 150
                elseif vRP.HasGroup(Passport,"VipLancamento",1) then
                    Weight = Weight + 150
                elseif vRP.HasGroup(Passport,"Blacks",1) then
                    Weight = Weight + 500
                elseif vRP.HasGroup(Passport,"Blacks",2) then
                    Weight = Weight + 200

				elseif vRP.HasGroup(Passport,"Black",1) then
                    Weight = Weight + 200
				elseif vRP.HasGroup(Passport,"Ouro",1) then
                    Weight = Weight + 120
				elseif vRP.HasGroup(Passport,"Prata",1) then
                    Weight = Weight + 80
				elseif vRP.HasGroup(Passport,"Bronze",1) then
                    Weight = Weight + 50
                end
            end

			return Weight
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWEIGHTS
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRP.SetWeight(Passport,Amount)
	if vRP.Source(Passport) then
		local Datatable = vRP.Datatable(Passport)
		if Datatable then
			if not Datatable["Weight"] then
				Datatable["Weight"] = 90
			end

			Datatable["Weight"] = Datatable["Weight"] + parseInt(Amount)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWEIGHTS
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRP.SetExpWeight(Passport,Amount)
    local Source = vRP.Source(Passport)
	if Source then
		local Datatable = vRP.Datatable(Passport)
		if Datatable then
			Datatable["Weight"] = Amount
            TriggerClientEvent("Notify",Source,"verde","Peso alterado.",5000,"PESO")
			-- TriggerClientEvent("Notify2",Source,"#weightChange")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWAPSLOT	
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRP.SwapSlot(Passport,Slot,Target)
	if vRP.Source(Passport) then
		local Slot = tostring(Slot)
		local Target = tostring(Target)
		local source = vRP.Source(Passport)
		local Inv = vRP.Inventory(Passport)

		if Inv then
			local TempSlot,TempTarget = Inv[Slot],Inv[Target]
			Inv[Slot] = Inv[Target]
			Inv[Target] = TempSlot
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICECLEAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PoliceClean(Passport)
	if vRP.Source(Passport) then
		local Inv = vRP.Inventory(Passport)

		for Slot,v in pairs(Inv) do
			local Item = splitString(v["item"],"-")[1]
			if PoliceCleaner[Item] then
				vRP.RemoveItem(Passport,v["item"],v["amount"])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryWeight(Passport)
	local Weight = 0

	if vRP.Source(Passport) then
		local Inv = vRP.Inventory(Passport)

		for _,v in pairs(Inv) do
			if itemBody(v["item"]) then
				Weight = Weight + itemWeight(v["item"]) * v["amount"]
			end
		end
	end

	return Weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDAMAGED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CheckDamaged(Item)
	local Split = splitString(Item,"-")
	if itemDurability(Item) and Split[2] then
		local Max = 86400 * itemDurability(Item)
		local Actual = parseInt(os.time() - Split[2])
		local New = (Max - Actual) / Max
		local Percent = parseInt(New * 100)

		if Percent <= 1 then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChestWeight(Data)
	local Weight = 0

	for _,v in pairs(Data) do
		if itemBody(v["item"]) then
			Weight = Weight + itemWeight(v["item"]) * v["amount"]
		end
	end

	return Weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryItemAmount(Passport,Item)
	if vRP.Source(Passport) then
		local Inv = vRP.Inventory(Passport)

		for _,v in pairs(Inv) do
			local Split = splitString(Item,"-")
			local Split2 = splitString(v["item"],"-")
			if Split[1] == Split2[1] then
				return { v["amount"],v["item"] }
			end
		end
	end

	return { 0,"" }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryFull(Passport,Item)
	if vRP.Source(Passport) then
		local Inv = vRP.Inventory(Passport)

		for _,v in pairs(Inv) do
			if v["item"] == Item then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ItemAmount(Passport,Item)
	local Amount = 0

	if vRP.Source(Passport) then
		local Split = splitString(Item,"-")
		local Inv = vRP.Inventory(Passport)

		for _,v in pairs(Inv) do
			local Split2 = splitString(v["item"],"-")
			if Split2[1] == Split[1] then
				Amount = Amount + v["amount"]
			end
		end
	end

	return Amount
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveItem(Passport,Item,Amount,Notify,Slot)
	local Amount = parseInt(Amount)
	if vRP.Source(Passport) and Amount > 0 then
		local source = vRP.Source(Passport)
		local Inv = vRP.Inventory(Passport)

		if not Slot then
			local Selected = "6"
			local MaxSlots = vRP.GetWeight(Passport)

			if MaxSlots > 100 then
				MaxSlots = 100
			end

			for i = 6,MaxSlots do
				if not Inv[tostring(i)] or (Inv[tostring(i)] and Inv[tostring(i)]["item"] == Item) then
					Selected = tostring(i)
					break
				end
			end

			if not Inv[Selected] then
				Inv[Selected] = { item = Item, amount = Amount }
			elseif Inv[Selected] and Inv[Selected]["item"] == Item then
				Inv[Selected]["amount"] = Inv[Selected]["amount"] + Amount
			end

			if Notify and itemBody(Item) then
				TriggerClientEvent("itensNotify",source,{ "added",itemIndex(Item),Amount,itemName(Item) })
			end
            TriggerClientEvent("inventory:HasToUpdate",source)
		else
			local Slot = tostring(Slot)
			if Inv[Slot] and Inv[Slot]["item"] == Item then
				Inv[Slot]["amount"] = Inv[Slot]["amount"] + Amount
			else
				Inv[Slot] = { item = Item, amount = Amount }
			end

			if Notify and itemBody(Item) then
				TriggerClientEvent("itensNotify",source,{ "added",itemIndex(Item),Amount,itemName(Item) })
			end
            TriggerClientEvent("inventory:HasToUpdate",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateItem(Passport,Item,Amount,Notify,Slot,FunctionCall,FunctionSource)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
    if IsPremiumItem(Item) then
        if not FunctionSource then
            FunctionSource = Passport
        end
        if FunctionCall then
            SendWebHook("premiumlog2","**Cidade: "..cityName.."**\n**Passaporte Recebido:** "..Passport.."**\n**Passaporte Enviado:** "..FunctionSource.."\n**Item:** "..Item.."\n**Quantidade: "..Amount.."**\n**Chamado em:** "..FunctionCall..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        else
            FunctionCall = "Untracked"
            SendWebHook("premiumlog2","**Cidade: "..cityName.."**\n**Passaporte Recebido:** "..Passport.."**\n**Passaporte Enviado:** "..FunctionSource.."\n**Item:** "..Item.."\n**Quantidade: "..Amount.."**\n**Chamado em:** "..FunctionCall..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
        end
    end
	if Amount > 0 then
        if Amount > 1 then
            if itemType(Item) == "Armamento" then
                Amount = parseInt(Amount * GlobalState["EconomyWeapon"])
            end
            if itemClass(Item) == "Drogas" then
                Amount = parseInt(Amount * GlobalState["EconomyDrugs"])
            end
        end
		if vRP.Source(Passport) then
			local source = vRP.Source(Passport)
			local Inv = vRP.Inventory(Passport)

			if itemDurability(Item) then
				Item = Item.."-"..os.time()
			elseif itemCharges(Item) then
				Item = Item.."-"..itemCharges(Item)
			end

			if not Slot then
				local Selected = "6"
				local MaxSlots = vRP.GetWeight(Passport)

				if MaxSlots > 100 then
					MaxSlots = 100
				end

				for i = 6,MaxSlots do
					if not Inv[tostring(i)] or (Inv[tostring(i)] and Inv[tostring(i)]["item"] == Item) then
						Selected = tostring(i)
						break
					end
				end

				if not Inv[Selected] then
					Inv[Selected] = { item = Item, amount = Amount }
				elseif Inv[Selected] and Inv[Selected]["item"] == Item then
					Inv[Selected]["amount"] = Inv[Selected]["amount"] + Amount
				end

				if Notify and itemBody(Item) then
					TriggerClientEvent("itensNotify",source,{ "added",itemIndex(Item),Amount,itemName(Item) })
				end
			else
				local Slot = tostring(Slot)
				if Inv[Slot] and Inv[Slot]["item"] == Item then
					Inv[Slot]["amount"] = Inv[Slot]["amount"] + Amount
				else
					Inv[Slot] = { item = Item, amount = Amount }
				end

				if Notify and itemBody(Item) then
					TriggerClientEvent("itensNotify",source,{ "added",itemIndex(Item),Amount,itemName(Item) })
				end
			end
            if Item and ItemId[Item] and ItemId[Item]["Id"] then
                exports["inventory"]:CreateItem(ItemId[Item]["Id"],Amount)
            end
            TriggerClientEvent("inventory:HasToUpdate",source)
		else
			local Datatable = vRP.UserData(Passport,"Datatable")
			if Datatable and Datatable["Inventory"] then
				if itemDurability(Item) then
					Item = Item.."-"..os.time()
				elseif itemCharges(Item) then
					Item = Item.."-"..itemCharges(Item)
				end

				if not Slot then
					local Selected = "1"

					for i = 6,100 do
						if not Datatable["Inventory"][tostring(i)] or (Datatable["Inventory"][tostring(i)] and Datatable["Inventory"][tostring(i)]["item"] == Item) then
							Selected = tostring(i)
							break
						end
					end

					if not Datatable["Inventory"][Selected] then
						Datatable["Inventory"][Selected] = { item = Item, amount = Amount }
					elseif Datatable["Inventory"][Selected] and Datatable["Inventory"][Selected]["item"] == Item then
						Datatable["Inventory"][Selected]["amount"] = Datatable["Inventory"][Selected]["amount"] + Amount
					end
				else
					local Slot = tostring(Slot)
					if Datatable["Inventory"][Slot] and Datatable["Inventory"][Slot]["item"] == Item then
						Datatable["Inventory"][Slot]["amount"] = Datatable["Inventory"][Slot]["amount"] + Amount
					else
						Datatable["Inventory"][Slot] = { item = Item, amount = Amount }
					end
				end
                if Item and ItemId[Item] and ItemId[Item]["Id"] then
                    exports["inventory"]:CreateItem(ItemId[Item]["Id"],Amount)
                end
                vRP.Query("playerdata/UpdateData",{ 
                    json.encode(Datatable),
                    Passport,
                    "Datatable"
                })
			end
		end
	end
end

CreateThread(function()
    Wait(1000)
    vRP.GenerateItem(1047,"water",10)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.MaxItens(Passport,Item,Amount)
	if itemBody(Item) and vRP.Source(Passport) then
		if itemMaxAmount(Item) ~= nil then
			local Amount = parseInt(Amount)
			if (vRP.ItemAmount(Passport,Item) + Amount) > itemMaxAmount(Item) then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.TakeItem(Passport,Item,Amount,Notify,Slot)
	local Returned = false
	local Amount = parseInt(Amount)
    local source = vRP.Source(Passport)
    if GlobalState["Restarting"] then
        return
    end
	if source and Amount > 0 then
		local Inv = vRP.Inventory(Passport)

		if not Slot then
			for Index,v in pairs(Inv) do
				if v["item"] == Item and v["amount"] >= Amount then
					v["amount"] = v["amount"] - Amount

					if v["amount"] <= 0 then
						if itemType(Item) == "Armamento" or itemType(Item) == "Throwing" then
							TriggerClientEvent("inventory:verifyWeapon",source,Item)
						end

						Inv[Index] = nil
					end

					if Notify and itemBody(Item) then
						TriggerClientEvent("itensNotify",source,{ "removeu",itemIndex(Item),Amount,itemName(Item) })
					end

					Returned = true

					break
				end
			end
		else
			local Slot = tostring(Slot)
			if Inv[Slot] and Inv[Slot]["item"] == Item and Inv[Slot]["amount"] >= Amount then
				Inv[Slot]["amount"] = Inv[Slot]["amount"] - Amount

				if Inv[Slot]["amount"] <= 0 then
					if itemType(Item) == "Armamento" or itemType(Item) == "Throwing" then
						TriggerClientEvent("inventory:verifyWeapon",source,Item)
					end

					Inv[Slot] = nil
				end

				if Notify and itemBody(Item) then
					TriggerClientEvent("itensNotify",source,{ "removeu",itemIndex(Item),Amount,itemName(Item) })
				end

				Returned = true
			end
		end
        TriggerClientEvent("inventory:HasToUpdate",source)
	end

	return Returned
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveItem(Passport,Item,Amount,Notify)
	local Amount = parseInt(Amount)
    local source = vRP.Source(Passport)
    if GlobalState["Restarting"] then
        return
    end
	if source and Amount > 0 then
		local Inv = vRP.Inventory(Passport)

		for Index,v in pairs(Inv) do
			if v["item"] == Item and v["amount"] >= Amount then
				v["amount"] = v["amount"] - Amount

				if v["amount"] <= 0 then
					if itemType(Item) == "Armamento" or itemType(Item) == "Throwing" then
						TriggerClientEvent("inventory:verifyWeapon",source,Item)
					end

					Inv[Index] = nil
				end

				if Notify and itemBody(Item) then
					TriggerClientEvent("itensNotify",source,{ "removeu",itemIndex(Item),Amount,itemName(Item) })
				end

				break
			end
		end
        TriggerClientEvent("inventory:HasToUpdate",source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetSrvData(Key,Save)
	if not Entitys[Key] then
		local Consult = vRP.Query("entitydata/GetData",{ dkey = Key })
		if parseInt(#Consult) > 0 then
			Entitys[Key] = { data = json.decode(Consult[1]["dvalue"]), timer = os.time() + 60*5, save = Save or true }
		else
			Entitys[Key] = { data = {}, timer = os.time() + 60*5, save = Save or true }
		end
	end

	return Entitys[Key]["data"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetSrvData(Key,Data,Save)
	Entitys[Key] = { data = Data, timer = os.time() + 60*5, save = Save or true }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemSrvData(Key,Save)
	Entitys[Key] = { data = {}, timer = os.time() + 60*5, save = Save or true }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADENTITYS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do

		local now = os.time()

		for Data,v in pairs(Entitys) do
			if now >= v["timer"] and v["save"] then
				if type(v["data"]) == "string" then
					vRP.Query("entitydata/SetData",{ dkey = Data, dvalue = v["data"] })
				else
					vRP.Query("entitydata/SetData",{ dkey = Data, dvalue = json.encode(v["data"]) })
				end

				Entitys[Data] = nil
			end
		end

		Wait(60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer",function(Silenced)
	for Line,v in pairs(Entitys) do
		if v["save"] then
			vRP.Query("entitydata/SetData",{ dkey = Line, dvalue = json.encode(v["data"]) })
		end
        Wait(10)
	end
    ExecuteCommand("savegroups")
	if not Silenced then
		print("O resource vRP salvou os dados.")
	end
end)

-- CreateThread(function()
--     while true do
--         Wait(1000*60*30)
--         TriggerEvent("SaveServer",true)
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.invUpdate(Passport, source, Slot, Target, Amount)
	local Amount = parseInt(Amount)
    if GlobalState["Restarting"] then
        return
    end
	if Passport and Amount > 0 then
		local Returned = true
		local Slot = tostring(Slot)
		local Inv = vRP.Inventory(Passport)

		if Inv[Slot] then
			local Item = Inv[Slot]["item"]
			local Target = tostring(Target)

			if Inv[Target] then
				if Inv[Slot] and Inv[Target] then
					if Item == Inv[Target]["item"] then
						if Inv[Slot]["amount"] >= Amount then
							Inv[Slot]["amount"] = Inv[Slot]["amount"] - Amount
							Inv[Target]["amount"] = Inv[Target]["amount"] + Amount

							if Inv[Slot]["amount"] <= 0 then
								Inv[Slot] = nil
							end

							Returned = false
						end
					else
						local Split = splitString(Inv[Target]["item"],"-")
						if (Item == "dollars" and Split[1] == "suitcase") or (Item == "drugtoy" and (Split[1] == "burgershot3" or Split[1] == "pizzathis3" or Split[1] == "uwucoffee3" or Split[1] == "beanmachine3")) or (Item == "repairkit0"..string.sub(Item,11,12) and vRP.CheckDamaged(Inv[Target]["item"])) then
							if Inv[Target]["amount"] == 1 then
								if Item == "repairkit0"..string.sub(Item,11,12) then
									if itemRepair(Inv[Target]["item"]) then
										local iRepair = itemRepair(Inv[Target]["item"])

										if iRepair == Item then
											if vRP.TakeItem(Passport,Item,1,false,Slot) then
												Inv[Target]["item"] = Split[1].."-"..os.time()
												TriggerClientEvent("Notify",source,"verde","Reparado.",5000)
												-- TriggerClientEvent("Notify2",source,"#repaired")
											end
										else
											TriggerClientEvent("Notify",source,"amarelo","Só pode ser reparado com <b>"..itemName(iRepair).."</b>.",5000)
											-- TriggerClientEvent("Notify2",source,"#repairWith",{msg=itemName(iRepair)})
										end
									end
								elseif Item == "dollars" then
									if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
										if Split[2] then
											Inv[Target]["item"] = "suitcase-"..(Split[2] + Amount)
										else
											Inv[Target]["item"] = "suitcase-"..Amount
										end
									end
								elseif Item == "drugtoy" then
									local Box = "burgershot4"
									if Split[1] == "pizzathis3" then
										Box = "pizzathis4"
									elseif Split[1] == "uwucoffee3" then
										Box = "uwucoffee4"
									elseif Split[1] == "beanmachine3" then
										Box = "beanmachine4"
									end

									-- if not vRP.MaxItens(Passport,Box,1) then
										if vRP.TakeItem(Passport,Item,1,false,Slot) then
											Inv[Target]["item"] = Box
										end
									-- else
									-- 	TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
									-- end
								end
							end
						else
							local TempSlot,TempTarget = Inv[Slot],Inv[Target]
							Inv[Slot] = Inv[Target]
							Inv[Target] = TempSlot

							Returned = false
						end
					end
				end
			else
				if Inv[Slot] and Inv[Slot]["amount"] >= Amount then
					Inv[Target] = { item = Item, amount = Amount }
					Inv[Slot]["amount"] = Inv[Slot]["amount"] - Amount

					if Inv[Slot]["amount"] <= 0 then
						Inv[Slot] = nil
					end

					Returned = false
				end
			end
		end

        TriggerClientEvent("inventory:HasToUpdate",source)
		if Returned then
			TriggerClientEvent("inventory:Update",source,"Backpack")
		end
	end
end

function tvRP.invUpdate(Slot, Target, Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	vRP.invUpdate(Passport, source, Slot, Target, Amount)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.TakeChest(Passport,Data,Amount,Slot,Target)
	local Returned = true
	local Amount = parseInt(Amount)
    if GlobalState["Restarting"] then
        return
    end
	if vRP.Source(Passport) and Amount > 0 then
		local Slot = tostring(Slot)
		local source = vRP.Source(Passport)
		local Consult = vRP.GetSrvData(Data)

		if Consult[Slot] then
			local Item = Consult[Slot]["item"]

			-- if vRP.MaxItens(Passport,Item,Amount) then
			-- 	TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)

			-- 	return Returned
			-- end

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
			end
            TriggerClientEvent("inventory:HasToUpdate",source)
			SendWebHook("retirar-item-bau","**Passaporte:** "..Passport.. " ".. vRP.FullName(Passport) .. "\n**Retirou: **"..Item.."\n**Quantidade: **"..Amount.."\n**Casa: **"..Data..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
			-- print("bau-casa")
		end
	end

	return Returned
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.StoreChestManual(Chest,Item,Amount)
    local Consult = vRP.GetSrvData(Chest)
    local MaxSlots = 100
    local Target = false

    for i = 1, MaxSlots do
        if not Consult[tostring(i)] or (Consult[tostring(i)] and Consult[tostring(i)]["item"] == Item) then
            Target = tostring(i)
            break
        end
    end

    if Consult[Target] and Item == Consult[Target]["item"] then
        Consult[Target]["amount"] = Consult[Target]["amount"] + Amount
    else
        Consult[Target] = { item = Item, amount = Amount }
    end
end

function vRP.StoreChest(Passport,Data,Amount,Weight,Slot,Target)
	local Returned = true
	local Amount = parseInt(Amount)
    if GlobalState["Restarting"] then
        return false
    end
	if vRP.Source(Passport) and Amount > 0 then
		local Slot = tostring(Slot)
		local Target = tostring(Target)
		local source = vRP.Source(Passport)
		local Inv = vRP.Inventory(Passport)

		if Inv[Slot] then
			local Item = Inv[Slot]["item"]
			local Consult = vRP.GetSrvData(Data)

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
			end
            TriggerClientEvent("inventory:HasToUpdate",source)
		end
	end

	return Returned
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateChest(Passport,Data,Slot,Target,Amount)
	local Returned = true
	local Amount = parseInt(Amount)
    if GlobalState["Restarting"] then
        return false
    end
	if vRP.Source(Passport) and Amount > 0 then
		local Slot = tostring(Slot)
		local Target = tostring(Target)
		local Consult = vRP.GetSrvData(Data)

		if Consult[Slot] then
			if Consult[Target] and Consult[Slot] then
				if Consult[Slot]["item"] == Consult[Target]["item"] then
					if Consult[Slot]["amount"] >= Amount then
						Consult[Slot]["amount"] = Consult[Slot]["amount"] - Amount

						if Consult[Slot]["amount"] <= 0 then
							Consult[Slot] = nil
						end

						Consult[Target]["amount"] = Consult[Target]["amount"] + Amount

						Returned = false
					end
				else
					local Temp = Consult[Slot]
					Consult[Slot] = Consult[Target]
					Consult[Target] = Temp

					Returned = false
				end
			else
				if Consult[Slot] then
					if Consult[Slot]["amount"] >= Amount then
						Consult[Slot]["amount"] = Consult[Slot]["amount"] - Amount
						Consult[Target] = { item = Consult[Slot]["item"], amount = Amount }

						if Consult[Slot]["amount"] <= 0 then
							Consult[Slot] = nil
						end

						Returned = false
					end
				end
			end
            if source and DoesPlayerExist(source) then
                TriggerClientEvent("inventory:HasToUpdate",source)
            end
		end
	end

	return Returned
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIRECTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DirectChest(Chest,Slot,Amount)
	local Amount = parseInt(Amount)
	local Consult = vRP.GetSrvData("Chest:"..Chest)
	if Consult[Slot] then
		if Consult[Slot]["item"] == "dollars" then
			Consult[Slot]["amount"] = Consult[Slot]["amount"] + Amount
		else
			Consult[Slot] = { item = "dollars", amount = Amount }
		end
	else
		Consult[Slot] = { item = "dollars", amount = Amount }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIRECTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CompareWeight(Passport,Item,Amount)
    if (vRP.InventoryWeight(Passport) + (itemWeight(Item) * Amount)) <= vRP.GetWeight(Passport) then
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
-- AddEventHandler("Connect",function(Passport,source)
--     for i=1,#PremiumItems do
--         local Consult = vRP.InventoryItemAmount(Passport,PremiumItems[i])
--         if Consult[1] >= 2 then
--             exports["vrp"]:SendWebHook("premiumlog","**Cidade: "..cityName.."**\n**Passaporte:** "..Passport.."\n**Item:** "..Consult[2].."\n**Quantidade: "..Consult[1].."**"..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
--         end
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIP CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
local VipChest = {
    ["Black"] = 300,
    ["VipLancamento"] = 150,
    ["Ouro"] = 100,
    ["Prata"] = 50,
    ["Bronze"] = 30,
}

function vRP.GetVehicleChest(Passport,Vehicle)
    local BaseChest = VehicleChest(Vehicle)
    local BaseValue = 0
    for Group,Value in pairs(VipChest) do
        if vRP.HasGroup(Passport,Group) then
            if Value > BaseValue then
                BaseValue = BaseValue + Value
            end
        end
    end
    BaseChest = BaseChest + BaseValue
    return BaseChest
end

-- vRP.Prepare("item_economy/AddItemEconomy","INSERT IGNORE INTO item_economy (item,worth) VALUES (@Item,@Worth)")
-- function FormatItemList()
--     for Item,Table in pairs(itemList()) do
--         vRP.Query("item_economy/AddItemEconomy",{ Item = Item, Worth = Table["Economy"] or 1 })
--     end
-- end

-- CreateThread(function()
--     Wait(1000)
--     FormatItemList()
-- end)

vRP.Prepare("item_list/AddItem","INSERT INTO item_list(item,Name,Type,Weight,Block,Economy,Class) VALUES(@item,@Name,@Type,@Weight,@Block,@Economy,@Class) ON DUPLICATE KEY UPDATE Name = @Name, Type = @Type, Weight = @Weight, Block = @Block, Economy = @Economy, Class = @Class")
vRP.Prepare("item_list/GetAll","SELECT id,item FROM item_list")
vRP.Prepare("item_spawn/CreateItem","INSERT INTO `item_spawn`(`itemId`,`Amount`) VALUES(?, ?)")
vRP.Prepare("item_spawn/GetItemCountByDays",[[
    SELECT item_spawn.itemId, item_list.Name, item_list.Type, SUM(item_spawn.Amount) AS SpawnCount
    FROM item_spawn
    JOIN item_list ON item_spawn.itemId = item_list.id
    WHERE DATE(item_spawn.date) >= DATE(NOW()) - INTERVAL @Days DAY
    GROUP BY item_spawn.itemId, item_list.Name
    ORDER BY item_list.Type;
]])

vRP.Prepare("item_spawn/GetTypeSpawned",[[
    SELECT item_list.Type, SUM(item_spawn.Amount) AS SpawnCount
    FROM item_spawn
    JOIN item_list ON item_spawn.itemId = item_list.id
    WHERE DATE(item_spawn.date) >= DATE(NOW()) - INTERVAL @Days DAY
    GROUP BY item_list.Type;
]])

CreateThread(function()
    for Item,Table in pairs(itemList()) do
        vRP.Query("item_list/AddItem",{ item = Item, Name = Table["Name"], Type = Table["Type"], Weight = Table["Weight"], Block = Table["Block"] or 0, Economy = Table["Economy"], Class = Table["Class"] or "usavel" })
    end
    local Query = vRP.Query("item_list/GetAll")
    for i=1,#Query do
        local Table = Query[i]
        ItemId[Table["item"]] = { Id = Table["id"], Name = Table["Name"] } 
    end
end)


function vRP.GetItemCreateCount(Days)
    local Query = vRP.Query("item_spawn/GetItemCountByDays",{ Days = Days })
    local ItemCount = {}
    for i=1,#Query do
        local Table = Query[i]
        ItemCount[Table["itemId"]] = { Name = Table["Name"], Type = Table["Type"], Count = Table["SpawnCount"] }
    end
    return ItemCount
end

function vRP.GetCreatedByType(Days)
    local Query = vRP.Query("item_spawn/GetTypeSpawned",{ Days = Days })
    local ItemCount = {}
    for i=1,#Query do
        local Table = Query[i]
        ItemCount[Table["Type"]] = { Count = Table["SpawnCount"] }
    end
    return ItemCount
end
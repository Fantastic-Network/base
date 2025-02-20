Inventory = {}
Tunnel.bindInterface("inventory",Inventory)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Drops = {}
Carry = {}
Ammos = {}
Loots = {}
Boxes = {}
Active = {}
Trashs = {}
Armors = {}
Plates = {}
Trunks = {}
Healths = {}
Drugs = {}
Attachs = {}
Scanners = {}
Property = {}
Temporary = {}
atmTimers = {}
Dismantle = {}
verifyObjects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS
-----------------------------------------------------------------------------------------------------------------------------------------
Buffs = {
	["Dexterity"] = {},
	["Luck"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
Objects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
Products = {
	["paper"] = {
		{ ["timer"] = 20, ["need"] = {
			{ ["item"] = "woodlog", ["amount"] = 3 }
		}, ["needAmount"] = 1, ["item"] = "paper", ["itemAmount"] = 1 }
	},
	["tablecoke"] = {
		{ ["timer"] = 20, ["need"] = {
			{ ["item"] = "sulfuric", ["amount"] = 1 },
			{ ["item"] = "cokeleaf", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "cocaine", ["itemAmount"] = 3 }
	},
	["tablemeth"] = {
		{ ["timer"] = 20, ["need"] = {
			{ ["item"] = "saline", ["amount"] = 1 },
			{ ["item"] = "acetone", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "meth", ["itemAmount"] = 3 }
	},
	["tableweed"] = {
		{ ["timer"] = 20, ["need"] = {
			{ ["item"] = "silk", ["amount"] = 1 },
			{ ["item"] = "weedleaf", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "joint", ["itemAmount"] = 1 }
	},
	["burgershot1"] = {
		{ ["timer"] = 10, ["item"] = "burgershot1", ["itemAmount"] = 1 }
	},
	["burgershot2"] = {
		{ ["timer"] = 10, ["item"] = "burgershot2", ["itemAmount"] = 1 }
	},
	["burgershot3"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "burgershot2", ["amount"] = 1 },
			{ ["item"] = "burgershot1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "burgershot3", ["itemAmount"] = 1 }
	},
	["pizzathis1"] = {
		{ ["timer"] = 10, ["item"] = "pizzathis1", ["itemAmount"] = 1 }
	},
	["pizzathis2"] = {
		{ ["timer"] = 10, ["item"] = "pizzathis2", ["itemAmount"] = 1 }
	},
	["pizzathis3"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "pizzathis2", ["amount"] = 1 },
			{ ["item"] = "pizzathis1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "pizzathis3", ["itemAmount"] = 1 }
	},
	["uwucoffee1"] = {
		{ ["timer"] = 10, ["item"] = "uwucoffee1", ["itemAmount"] = 1 }
	},
	["uwucoffee2"] = {
		{ ["timer"] = 10, ["item"] = "uwucoffee2", ["itemAmount"] = 1 }
	},
	["uwucoffee3"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "uwucoffee2", ["amount"] = 1 },
			{ ["item"] = "uwucoffee1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "uwucoffee3", ["itemAmount"] = 1 }
	},
	["beanmachine1"] = {
		{ ["timer"] = 10, ["item"] = "beanmachine1", ["itemAmount"] = 1 }
	},
	["beanmachine2"] = {
		{ ["timer"] = 10, ["item"] = "beanmachine2", ["itemAmount"] = 1 }
	},
	["beanmachine3"] = {
		{ ["timer"] = 10, ["need"] = {
			{ ["item"] = "beanmachine2", ["amount"] = 1 },
			{ ["item"] = "beanmachine1", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "beanmachine3", ["itemAmount"] = 1 }
	},
	["milkBottle"] = {
		{ ["timer"] = 10, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "milkbottle", ["itemAmount"] = 1 }
	},
	["scanner"] = {
		{ ["timer"] = 5, ["item"] = "sheetmetal", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "roadsigns", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "syringe", ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "fishingrod", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "plate", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "aluminum", ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "battery", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "metalcan", ["itemAmount"] = 1 }
	},
	["cemitery"] = {
		{ ["timer"] = 5, ["item"] = "silk", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cotton", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "plaster", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "switchblade", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "joint", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "acetone", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "slipper", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "water", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cigarette", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "elastic", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "rose", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "teddy", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "binoculars", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "camera", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "silvercoin", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "goldcoin", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "watch", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "bracelet", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "WEAPON_BRICK", ["itemAmount"] = 3 },
		{ ["timer"] = 5, ["item"] = "WEAPON_SHOES", ["itemAmount"] = 2 },
		{ ["timer"] = 5, ["item"] = "dices", ["itemAmount"] = 1 },
		{ ["timer"] = 5, ["item"] = "cup", ["itemAmount"] = 1 }
	},
	["fishfillet"] = {
		{ ["timer"] = 10, ["need"] = "fishfillet", ["needAmount"] = 1, ["item"] = "cookedfishfillet", ["itemAmount"] = 1 }
	},
	["marshmallow"] = {
		{ ["timer"] = 10, ["need"] = "sugar", ["needAmount"] = 4, ["item"] = "marshmallow", ["itemAmount"] = 1 }
	},
	["emptybottle"] = {
		{ ["timer"] = 3, ["need"] = "emptybottle", ["needAmount"] = 1, ["item"] = "water", ["itemAmount"] = 1 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALITENS
-----------------------------------------------------------------------------------------------------------------------------------------
StealItens = {
	{ ["item"] = "pendrive", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	{ ["item"] = "slipper", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "soap", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "pliers", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "deck", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "floppy", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "domino", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "brush", ["min"] = 1, ["max"] = 4, ["rand"] = 225 },
	{ ["item"] = "rimel", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	{ ["item"] = "WEAPON_SHOES", ["min"] = 2, ["max"] = 2, ["rand"] = 225 },
	{ ["item"] = "dices", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	{ ["item"] = "spray04", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "spray03", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "spray02", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "spray01", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "bracelet", ["min"] = 2, ["max"] = 4, ["rand"] = 200 },
	{ ["item"] = "xbox", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	{ ["item"] = "playstation", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	{ ["item"] = "watch", ["min"] = 2, ["max"] = 3, ["rand"] = 200 },
	{ ["item"] = "goldcoin", ["min"] = 4, ["max"] = 6, ["rand"] = 175 },
	{ ["item"] = "silvercoin", ["min"] = 4, ["max"] = 8, ["rand"] = 175 },
	{ ["item"] = "oxy", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	{ ["item"] = "analgesic", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "firecracker", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	{ ["item"] = "pager", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	{ ["item"] = "GADGET_PARACHUTE", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 1, ["rand"] = 50 },
	{ ["item"] = "WEAPON_WRENCH", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	{ ["item"] = "WEAPON_POOLCUE", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	{ ["item"] = "WEAPON_BAT", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	{ ["item"] = "card02", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "camera", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "binoculars", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "hennessy", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "dewars", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "teddy", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	{ ["item"] = "chocolate", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	{ ["item"] = "lighter", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	{ ["item"] = "cellphone", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	{ ["item"] = "tyres", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "notepad", ["min"] = 1, ["max"] = 5, ["rand"] = 225 },
	{ ["item"] = "plate", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "emptybottle", ["min"] = 2, ["max"] = 5, ["rand"] = 225 },
	{ ["item"] = "bait", ["min"] = 1, ["max"] = 6, ["rand"] = 225 },
	{ ["item"] = "switchblade", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	{ ["item"] = "card01", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "card02", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "card03", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "card04", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	{ ["item"] = "card05", ["min"] = 1, ["max"] = 1, ["rand"] = 200 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOTITENS
-----------------------------------------------------------------------------------------------------------------------------------------
LootItens = {
	["Medic"] = {
		["Cooldown"] = 3600,
		["List"] = {
			{ ["item"] = "alcohol", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "syringe", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "codeine", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "amphetamine", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "acetone", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "cotton", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "plaster", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "saline", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "sulfuric", ["min"] = 1, ["max"] = 3 }
		}
	},
	["Weapons"] = {
		["Cooldown"] = 7200,
		["List"] = {
			{ ["item"] = "roadsigns", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "techtrash", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "pistolbody", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "smgbody", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "riflebody", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "sheetmetal", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "explosives", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "aluminum", ["min"] = 2, ["max"] = 3 },
			{ ["item"] = "copper", ["min"] = 2, ["max"] = 3 }
		}
	},
	["Supplies"] = {
		["Cooldown"] = 3600,
		["List"] = {
			{ ["item"] = "tarp", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "sheetmetal", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "roadsigns", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "leather", ["min"] = 1, ["max"] = 3 },
			{ ["item"] = "cotton", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "plaster", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "sulfuric", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "saline", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "alcohol", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "syringe", ["min"] = 2, ["max"] = 3 },
			{ ["item"] = "card01", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "card02", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "card03", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "card04", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "card05", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "silk", ["min"] = 1, ["max"] = 3 }
		}
	}
}

function Inventory.RemoveItem(Item,Slot,Amount)
    local source = source
    local Passport = vRP.Passport(source)
    local Slot = tostring(Slot)
    if Passport then
        vRP.TakeItem(Passport,Item,Amount,true,Slot)
        TriggerClientEvent("inventory:Update",source,"Backpack")
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.requestInventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GetPlayerRoutingBucket(source) < 900000 then
			if vRP.CheckRolepass(source) then
				TriggerEvent("vRP:Rewards",source)
			end
		end

		local Inv = {}
		local Inventory = vRP.Inventory(Passport)
		for Index,v in pairs(Inventory) do
			if (parseInt(v["amount"]) <= 0 or not itemBody(v["item"])) then
				vRP.RemoveItem(Passport,v["item"],parseInt(v["amount"]),false)
			else
				v["amount"] = parseInt(v["amount"])
				v["key"] = v["item"]
				v["slot"] = tonumber(Index)

				local Split = splitString(v["item"],"-")
				if Split[2] ~= nil then
                    if Split[1] == "identity" or Split[1] == "fidentity" or string.sub(v["item"],1,5) == "badge" then
                        local Number = parseInt(Split[2])
                        local Identity = vRP.Identity(Number)
                        
                        if Split[1] == "fidentity" then
                            Identity = vRP.FalseIdentity(Number)
                        end
                        local _,_,_,vip = vRP.UserGroupByType(Passport,"Premium")
                        if Identity then
                            v["idPhone"] = Identity["phone"]
                            v["idName"] = Identity["name"].." "..Identity["name2"]
                            v["idRolepass"] = "Inativo"
                            v["idAge"] = Identity["age"] or 18  
                            v["idPassport"] = Passport
                            if vip then
                                v["idPremium"] = vip
                            else
                                v["idPremium"] = "Inativo"
                            end
                            if vRP.HasPassPremium(Passport) then
                                v["idRolepass"] = "Ativo"
                            end
						end
					end

					if Split[1] == "vehkey" then
						v["Vehkey"] = Split[2]
					end

					if Split[1] == "notepad" and Split[2] then
						v["desc"] = vRP.GetSrvData(v["item"])
					end

					if Split[1] == "suitcase" then
						v["Suitcase"] = parseFormat(Split[2])
					end

					if itemCharges(v["item"]) then
						v["charges"] = parseInt(Split[2] * 33)
					end

					if itemDurability(v["item"]) then
						v["durability"] = parseInt(os.time() - Split[2])
						v["days"] = itemDurability(v["item"])
					else
						v["durability"] = 0
						v["days"] = 1
					end
				else
					v["durability"] = 0
					v["days"] = 1
				end

				if Split[1] == "weedclone" or Split[1] == "weedleaf" or Split[1] == "joint" then
					local Item = "da clonagem"
					if Split[1] == "weedleaf" then
						Item = "da folha"
					elseif Split[1] == "joint" then
						Item = "do baseado"
					end

					v["desc"] = "A pureza "..Item.." se encontra em <green>"..(Split[2] or 0).."%</green>."
				end

				table.insert(Inv,v)
			end
		end

		return Inv,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.DropServer(Coords,Item,Amount)
	local Number = 0

	repeat
		Number = Number + 1
	until not Drops[tostring(Number)]

	Drops[tostring(Number)] = {
		["key"] = Item,
		["amount"] = Amount,
		["Coords"] = { Coords["x"],Coords["y"],Coords["z"] },
		["days"] = 1,
		["durability"] = 0,
		["charges"] = nil
	}

	TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.Drops(Item,Slot,Amount,x,y,z)
	local source = source
	local Slot = tostring(Slot)
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] and not Player(source)["state"]["Handcuff"] and not exports["hud"]:Wanted(Passport) and not vRP.InsideVehicle(source) and GetPlayerRoutingBucket(source) < 900000 then
			if itemBlock(Item) then
				TriggerClientEvent("inventory:Update",source,"Backpack")
				return
			end

            if (itemType(Item) == "Armamento" or itemType(Item) == "Munição") and vRP.HasGroup(Passport,"Policia") then
                TriggerClientEvent("Notify",source,"vermelho","Você não pode dropar esse item.",5000,"DROP")
				-- TriggerClientEvent("Notify2",source,"#cantDropThisItemMuni")
                return
            end

			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				local Days = 1
				local Number = 0
				local Charges = nil
				local Durability = 0
				local Split = splitString(Item,"-")

				repeat
					Number = Number + 1
				until not Drops[tostring(Number)]

				if Split[2] ~= nil then
					if itemCharges(Item) then
						Charges = parseInt(Split[2] * 33)
					end

					if itemDurability(Item) then
						Durability = parseInt(os.time() - Split[2])
						Days = itemDurability(Item)
					end
				end

				Drops[tostring(Number)] = {
					["key"] = Item,
					["amount"] = Amount,
					["Coords"] = { x,y,z },
					["days"] = Days,
					["durability"] = Durability,
					["charges"] = Charges
				}

				Player(source)["state"]["Buttons"] = true
				Player(source)["state"]["Cancel"] = true

				if not vRP.InsideVehicle(source) then
					vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)
					Active[Passport] = os.time() + 100

					SetTimeout(1000,function()
						vRPC.DestroyObjects(source)
						Active[Passport] = nil
					end)
				end

				TriggerClientEvent("drops:Adicionar",-1,tostring(Number),Drops[tostring(Number)])
				TriggerClientEvent("inventory:Update",source,"Backpack")
				exports["vrp"]:SendWebHook("drop-item","**Passaporte:** "..Passport.."\n**Dropou:** "..Amount.." "..Item.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
				Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
			end
		else
			TriggerClientEvent("inventory:Update",source,"Backpack")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.Pickup(Number,Amount,Slot)
	local source = source
	local Slot = tostring(Slot)
	local Number = tostring(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] and GetPlayerRoutingBucket(source) < 900000 then
			if not Drops[Number] then
				TriggerClientEvent("inventory:Update",source,"Backpack")
				return
			else
				if (vRP.InventoryWeight(Passport) + itemWeight(Drops[Number]["key"]) * Amount) <= vRP.GetWeight(Passport) then
					if not Drops[Number] or Drops[Number]["amount"] < Amount then
						TriggerClientEvent("inventory:Update",source,"Backpack")
						return
					end

					-- if vRP.MaxItens(Passport,Drops[Number]["key"],Amount) then
					-- 	TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					-- 	TriggerClientEvent("inventory:Update",source,"Backpack")
					-- 	return
					-- end

					if Drops[Number] then
						local inventory = vRP.Inventory(Passport)
						if inventory[Slot] and Drops[Number]["key"] then
							if inventory[Slot]["item"] == Drops[Number]["key"] then
								vRP.GiveItem(Passport,Drops[Number]["key"],Amount,false,Slot)
							else
								vRP.GiveItem(Passport,Drops[Number]["key"],Amount,false)
							end
						else
							if Drops[Number] then
								vRP.GiveItem(Passport,Drops[Number]["key"],Amount,false,Slot)
							end
						end

						Drops[Number]["amount"] = Drops[Number]["amount"] - Amount
						if Drops[Number]["amount"] <= 0 then
							TriggerClientEvent("drops:Remover",-1,Number)
							Drops[Number] = nil
						else
							TriggerClientEvent("drops:Atualizar",-1,Number,Drops[Number]["amount"])
						end

						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						if not vRP.InsideVehicle(source) then
							vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)
							Active[Passport] = os.time() + 100

							SetTimeout(1000,function()
								vRPC.DestroyObjects(source)
								Active[Passport] = nil
							end)
						end

						TriggerClientEvent("inventory:Update",source,"Backpack")
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						exports["vrp"]:SendWebHook("pegar-item","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Pegou:** "..Amount.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
					else
						TriggerClientEvent("inventory:Update",source,"Backpack")
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					-- TriggerClientEvent("Notify2",source,"#mochilaFull")
					TriggerClientEvent("inventory:Update",source,"Backpack")
					return
				end
			end
		else
			TriggerClientEvent("inventory:Update",source,"Backpack")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.SendItem(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and GetPlayerRoutingBucket(source) < 900000 then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			Active[Passport] = os.time() + 100

			local inventory = vRP.Inventory(Passport)
			if not inventory[Slot] or not inventory[Slot]["item"] then
				Active[Passport] = nil
				return
			end

			if Amount <= 0 then Amount = 1 end
			local Item = inventory[Slot]["item"]

            local OtherPassport = vRP.Passport(ClosestPed)

			if vRP.CheckDamaged(Item) or itemBlock(Item) then
				Active[Passport] = nil
				return
			end

            if (itemType(Item) == "Armamento" or itemType(Item) == "Munição") and vRP.HasGroup(Passport,"Policia") and not vRP.HasGroup(OtherPassport,"Policia") then
                TriggerClientEvent("Notify",source,"vermelho","Você não pode enviar esse item.",5000,"ENVIAR")
				-- TriggerClientEvent("Notify2",source,"#cannotSendItem")
                return
            end

			if not vRP.MaxItens(OtherPassport,Item,Amount) then
				if (vRP.InventoryWeight(OtherPassport) + itemWeight(Item) * Amount) <= vRP.GetWeight(OtherPassport) then
					Active[Passport] = os.time() + 3
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					Player(ClosestPed)["state"]["Cancel"] = true
					Player(ClosestPed)["state"]["Buttons"] = true
					vRPC.playAnim(source,true,{"mp_common","givetake1_a"},false)
					vRPC.playAnim(ClosestPed,true,{"mp_common","givetake1_a"},false)

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.stopAnim(source,false)
							vRPC.stopAnim(ClosestPed,false)
							Player(source)["state"]["Cancel"] = false
							Player(source)["state"]["Buttons"] = false
							Player(ClosestPed)["state"]["Cancel"] = false
							Player(ClosestPed)["state"]["Buttons"] = false


							if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
								vRP.GiveItem(OtherPassport,Item,Amount,true)
								TriggerClientEvent("inventory:Update",source,"Backpack")
								TriggerClientEvent("inventory:Update",ClosestPed,"Backpack")
								exports["vrp"]:SendWebHook("enviou-item","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Enviou:** "..Item..""..Amount.."\n**Para id:** " ..OtherPassport.." ".. vRP.FullName(OtherPassport) .."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					-- TriggerClientEvent("Notify2",source,"#mochilaFull")
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				-- TriggerClientEvent("Notify2",source,"#limitReached")
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.Deliver(Slot)
	local source = source
	local Slot = tostring(Slot)
	local Passport = vRP.Passport(source)
	if Passport then
		local Inventory = vRP.Inventory(Passport)
		if not Inventory[Slot] or not Inventory[Slot]["item"] then
			return
		end
        local Ped = GetPlayerPed(source)
        local Coords = GetEntityCoords(Ped)

		local Split = splitString(Inventory[Slot]["item"],"-")
		local Full = Inventory[Slot]["item"]
		local Item = Split[1]
		if Item == "joint" or Item == "meth" or Item == "cocaine" then
            if vDELIVER.Deliver(source,"Drugsmansouth") or vDELIVER.Deliver(source,"Drugsmannorth") then
                local DeliverAmounts = 0
                local Drugs = {
                    { ["Item"] = "joint", ["Min"] = 11000, ["Max"] = 12000 },
                    { ["Item"] = "meth", ["Min"] = 11000, ["Max"] = 12000 },
                    { ["Item"] = "cocaine", ["Min"] = 11000, ["Max"] = 12000 }
                }
                local Service,Total = vRP.NumPermission("Policia")

                if math.random(100) > 25 then
                    TriggerClientEvent("Notify",source,"amarelo","Você sabia que é possível vender os 03 tipos de droga ao mesmo tempo? Que tal ir negociar algumas?!",5000)
					-- TriggerClientEvent("Notify2",source,"#sellDrugWarning")
                end

                if Coords then
                    if math.random(100) >= 50 then
                        for Passports,Sources in pairs(Service) do
                            async(function()
                                TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "Venda de drogas", x = Coords["x"], y = Coords["y"], z = Coords["z"], blipColor = 44 })
                                --TriggerClientEvent("NotifyPolice",Sources,"Venda de drogas")
                                -- vRPC.PlaySound(Sources,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
                            end)
                        end
                    end
                end
				for Number = 1,#Drugs do
					if vRP.TakeItem(Passport,Drugs[Number]["Item"],1,true) then
						vRP.GenerateItem(Passport,"dinheirosujo",math.random(Drugs[Number]["Min"],Drugs[Number]["Max"]),true)
						DeliverAmounts = DeliverAmounts + 1
					end
				end

				if DeliverAmounts >= #Drugs then
					vRP.GenerateItem(Passport,"dollars",100,true)
                    --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = "Delivery"})
				end

				if DeliverAmounts > 0 then
					vDELIVER.Update(source)
				end
			end
		elseif Item == "woodlog" then
			if not vRPC.LastVehicle(source,"ratloader") then
				TriggerClientEvent("Notify",source,"amarelo","Precisa utilizar o veículo do <b>Lenhador</b>.",3000)
				-- TriggerClientEvent("Notify2",source,"#attVeicLumber")
				return
			end

			if vDELIVER.Deliver(source,"Lumberman") then
				if vRP.TakeItem(Passport,Full,3,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Lumberman")
					local Category = ClassCategory(Experience)
					local Valuation = 100

					if Category == "B+" then
						Valuation = Valuation + 20
					elseif Category == "A" then
						Valuation = Valuation + 40
					elseif Category == "A+" then
						Valuation = Valuation + 60
					elseif Category == "S" then
						Valuation = Valuation + 80
					elseif Category == "S+" then
						Valuation = Valuation + 100
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"Backpack")
					vRP.GenerateItem(Passport,"dollars",Valuation,true)
                    --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Valuation, Type = "Lumber"})
					vRP.PutExperience(Passport,"Lumberman",1)
					vDELIVER.Update(source)
				end
			end
		elseif Item == "burgershot3" or Item == "burgershot4" then
			if vDELIVER.Deliver(source,"BurgerShot") then
				if vRP.TakeItem(Passport,Full,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Delivery")
					local Category = ClassCategory(Experience)
					local Valuation = 200

					if Item == "burgershot4" then
						Valuation = 350
					end

					if Category == "B+" then
						Valuation = Valuation + 15
					elseif Category == "A" then
						Valuation = Valuation + 30
					elseif Category == "A+" then
						Valuation = Valuation + 45
					elseif Category == "S" then
						Valuation = Valuation + 60
					elseif Category == "S+" then
						Valuation = Valuation + 75
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"Backpack")
					vRP.GenerateItem(Passport,"dollars",Valuation,true)
                    --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Valuation, Type = "BurgerShot"})
					vRP.DirectChest("BurgerShot",Valuation * 0.05)
					vRP.PutExperience(Passport,"Delivery",1)
					vDELIVER.Update(source)
				end
			end
		elseif Item == "pizzathis3" or Item == "pizzathis4" then
			if vDELIVER.Deliver(source,"PizzaThis") then
				if vRP.TakeItem(Passport,Full,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Delivery")
					local Category = ClassCategory(Experience)
					local Valuation = 200

					if Item == "pizzathis4" then
						Valuation = 350
					end

					if Category == "B+" then
						Valuation = Valuation + 15
					elseif Category == "A" then
						Valuation = Valuation + 30
					elseif Category == "A+" then
						Valuation = Valuation + 45
					elseif Category == "S" then
						Valuation = Valuation + 60
					elseif Category == "S+" then
						Valuation = Valuation + 75
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"Backpack")
					vRP.GenerateItem(Passport,"dollars",Valuation,true)
                    --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Valuation, Type = "Pizza"})
					vRP.DirectChest("PizzaThis",Valuation * 0.05)
					vRP.PutExperience(Passport,"Delivery",1)
					vDELIVER.Update(source)
				end
			end
		elseif Item == "uwucoffee3" or Item == "uwucoffee4" then
			if vDELIVER.Deliver(source,"UwuCoffee") then
				if vRP.TakeItem(Passport,Full,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Delivery")
					local Category = ClassCategory(Experience)
					local Valuation = 200

					if Item == "uwucoffee4" then
						Valuation = 350
					end

					if Category == "B+" then
						Valuation = Valuation + 15
					elseif Category == "A" then
						Valuation = Valuation + 30
					elseif Category == "A+" then
						Valuation = Valuation + 45
					elseif Category == "S" then
						Valuation = Valuation + 60
					elseif Category == "S+" then
						Valuation = Valuation + 75
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"Backpack")
					vRP.GenerateItem(Passport,"dollars",Valuation,true)
                    --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Valuation, Type = "Coffee"})
					vRP.DirectChest("UwuCoffee",Valuation * 0.05)
					vRP.PutExperience(Passport,"Delivery",1)
					vDELIVER.Update(source)
				end
			end
		elseif Item == "beanmachine3" or Item == "beanmachine4" then
			if vDELIVER.Deliver(source,"BeanMachine") then
				if vRP.TakeItem(Passport,Full,1,false,Slot) then
					local Experience = vRP.GetExperience(Passport,"Delivery")
					local Category = ClassCategory(Experience)
					local Valuation = 200

					if Item == "beanmachine4" then
						Valuation = 350
					end

					if Category == "B+" then
						Valuation = Valuation + 15
					elseif Category == "A" then
						Valuation = Valuation + 30
					elseif Category == "A+" then
						Valuation = Valuation + 45
					elseif Category == "S" then
						Valuation = Valuation + 60
					elseif Category == "S+" then
						Valuation = Valuation + 75
					end

					if Buffs["Dexterity"][Passport] then
						if Buffs["Dexterity"][Passport] > os.time() then
							Valuation = Valuation + (Valuation * 0.1)
						end
					end

					TriggerClientEvent("inventory:Update",source,"Backpack")
					vRP.GenerateItem(Passport,"dollars",Valuation,true)
                    --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Valuation, Type = "Bean"})
					vRP.DirectChest("BeanMachine",Valuation * 0.05)
					vRP.PutExperience(Passport,"Delivery",1)
					vDELIVER.Update(source)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.UseItem(Slot,Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if Amount <= 0 then Amount = 1 end

		local Inventory = vRP.Inventory(Passport)
		if not Inventory[Slot] or not Inventory[Slot]["item"] then
			return
		end

		local Split = splitString(Inventory[Slot]["item"],"-")
		local Full = Inventory[Slot]["item"]
		local Item = Split[1]

		if itemDurability(Full) then
			if vRP.CheckDamaged(Full) then
				TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(Item).."</b> danificado.",5000)
				-- TriggerClientEvent("Notify2",source,"#damagedItem",{msg=itemName(Item)})
				return
			end
		end

		if (vCLIENT.checkWater(source) and Item ~= "soap") or (not vCLIENT.checkWater(source) and Item == "soap") then
			return
		end

		--if itemType(Full) == "Armamento" and parseInt(Slot) <= 5 then
		if itemType(Full) == "Armamento" then
			-- if vCLIENT.CheckArms(source) then
			-- 	TriggerClientEvent("Notify",source,"amarelo","Mão machucada.",5000)
			-- 	return
			-- end

			if vRP.InsideVehicle(source) then
				if not itemVehicle(Full) then
					return
				end
			end

			if vCLIENT.returnWeapon(source) then
				local Check,Ammo,Hash = vCLIENT.storeWeaponHands(source)

				if Check then
					local wHash = itemAmmo(Hash)
					if wHash then
						if Ammo > 0 then
							if not Ammos[Passport] then
								Ammos[Passport] = {}
							end

							Ammos[Passport][wHash] = Ammo
						else
							if Ammos[Passport] and Ammos[Passport][wHash] then
								Ammos[Passport][wHash] = nil
							end
						end
					end

					TriggerClientEvent("itensNotify",source,{ "updated",itemIndex(Hash),1,itemName(Hash) })
					CleanWeapons(Passport,false)
				end
			else
				Ammo = 0
				local wHash = itemAmmo(Item)
				if wHash then
					if not Ammos[Passport] then
						Ammos[Passport] = {}
					end

					if not Ammos[Passport][wHash] then
						Ammos[Passport][wHash] = 0
					else
						Ammo = Ammos[Passport][wHash]
					end
				end

				if not Attachs[Passport] then
					Attachs[Passport] = {}
				end

				if not Attachs[Passport][Item] then
					Attachs[Passport][Item] = {}
				end
                local Skin = false

                if GetResourceState("skinweapon") ~= "stopped" then
                    local skinWeapon = exports["skinweapon"]:GetSkins(Item,Passport)
                    if skinWeapon then
                        Skin = skinWeapon
                    end
                end
                
				if vCLIENT.putWeaponHands(source,Item,Ammo,Attachs[Passport][Item],false,Skin) then
					-- if not vRP.HasAchievement(Passport,11) then
					-- 	vRP.UpdateAchievement(Passport,11,1)
					-- end

					TriggerClientEvent("itensNotify",source,{ "updated",itemIndex(Full),1,itemName(Full) })
				end
			end
		elseif itemType(Full) == "Munição" then
			local Weapon,Hash,Ammo = vCLIENT.rechargeCheck(source,Item)

			if Weapon then
                if not Ammo or Ammo == nil then
                    Ammo = 0
                end
				if Hash == "WEAPON_PETROLCAN" then
					if (Ammo + Amount) > 4500 then
						Amount = 4500 - Ammo
					end
				else
					if (Ammo + Amount) > 250 then
						Amount = 250 - Ammo
					end
				end

				if Item ~= itemAmmo(Hash) or Amount <= 0 then
					return
				end

				if vRP.TakeItem(Passport,Full,Amount,false,Slot) then
					if not Ammos[Passport] then
						Ammos[Passport] = {}
					end

					Ammos[Passport][Item] = Ammo + Amount

					TriggerClientEvent("itensNotify",source,{ "updated",itemIndex(Full),Amount,itemName(Full) })
					TriggerClientEvent("inventory:Update",source,"Backpack")
					vCLIENT.rechargeWeapon(source,Hash,Amount)
				end
			end
		elseif itemType(Full) == "Throwing" then
			if vCLIENT.returnWeapon(source) then
				local Check,Ammo,Hash = vCLIENT.storeWeaponHands(source)

				if Check then
					local wHash = itemAmmo(Hash)
					if wHash then
						if Ammo > 0 then
							if not Ammos[Passport] then
								Ammos[Passport] = {}
							end

							Ammos[Passport][wHash] = Ammo
						else
							if Ammos[Passport] and Ammos[Passport][wHash] then
								Ammos[Passport][wHash] = nil
							end
						end
					end

					TriggerClientEvent("itensNotify",source,{ "updated",itemIndex(Hash),1,itemName(Hash) })
					CleanWeapons(Passport,false)
				end
			else
				if vCLIENT.putWeaponHands(source,Item,1,nil,Full) then
					TriggerClientEvent("itensNotify",source,{ "updated",itemIndex(Full),1,itemName(Full) })
				end
			end
		elseif Item == "attachsFlashlight" or Item == "attachsCrosshair" or Item == "attachsSilencer" or Item == "attachsMagazine" or Item == "attachsGrip" then
			local Weapon = vCLIENT.returnWeapon(source)
			if Weapon then
				--if vCLIENT.checkAttachs(source,Item,Weapon) then
					if not Attachs[Passport] then
						Attachs[Passport] = {}
					end

					if not Attachs[Passport][Weapon] then
						Attachs[Passport][Weapon] = {}
					end

					--if not Attachs[Passport][Weapon][Item] then
						if vRP.TakeItem(Passport,Full,1,false,Slot) then
							TriggerClientEvent("itensNotify",source,{ "updated",itemIndex(Full),1,itemName(Full) })
							TriggerClientEvent("inventory:Update",source,"Backpack")
							Attachs[Passport][Weapon][Item] = true
							vCLIENT.putAttachs(source,Item,Weapon)
						end
					-- else
					-- 	TriggerClientEvent("Notify",source,"amarelo","O armamento não possui suporte ao componente.",5000)
					-- 	-- TriggerClientEvent("Notify2",source,"#unsuppWeaponry")
					-- end
				-- else
				-- 	TriggerClientEvent("Notify",source,"amarelo","O armamento já possui o componente equipado.",5000)
				-- 	-- TriggerClientEvent("Notify2",source,"#weaponHasComponentEquipped")
				-- end
			end
		elseif InventoryUse[Item] then
			InventoryUse[Item](source,Passport,Amount,Slot,Full,Item,Split)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SAVETEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
local TypeWeapons = {
    ["Pistol"] = {
        ["Attachs"] = {
			["WEAPON_COMBATPISTOL"] = {
				["attachsFlashlight"] = true
			},
			["WEAPON_PISTOL_MK2"] = {
				["attachsFlashlight"] = true,
				["attachsCrosshair"] = true
			},
		},
        ["Ammos"] = {
            ["WEAPON_PISTOL_AMMO"] = 250,
        }
    },
    ["AimNPC"] = {
        ["Attachs"] = {
			["WEAPON_PISTOL"] = {
				["attachsFlashlight"] = true
			},
		},
        ["Ammos"] = {
            ["WEAPON_PISTOL_AMMO"] = 250,
        }
    },
    ["AimLabs"] = {
        ["Attachs"] = {
			["WEAPON_PISTOL"] = {
				["attachsFlashlight"] = true
			},
		},
        ["Ammos"] = {
            ["WEAPON_PISTOL_AMMO"] = 250,
        }
    },
    ["Rifle"] = {
        ["Attachs"] = {
			["WEAPON_COMBATPISTOL"] = {
				["attachsFlashlight"] = true
			},
			["WEAPON_PISTOL_MK2"] = {
				["attachsFlashlight"] = true,
				["attachsCrosshair"] = true
			},
		},
        ["Ammos"] = {
            ["WEAPON_PISTOL_AMMO"] = 250,
        }
    },
    ["DropKill"] = {
        ["Attachs"] = {
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["attachsFlashlight"] = true
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["attachsFlashlight"] = true,
				["attachsCrosshair"] = true
			},
			["WEAPON_PISTOL_MK2"] = {
				["attachsFlashlight"] = true,
				["attachsCrosshair"] = true
			},
		},
        ["Ammos"] = {
            ["WEAPON_PISTOL_AMMO"] = 250,
            ["WEAPON_RIFLE_AMMO"] = 250,
        }
    },
    ["FFAPistola"] = {
        ["Attachs"] = {
			["WEAPON_PISTOL_MK2"] = {
				["attachsFlashlight"] = true
			},
			["WEAPON_COMBATPISTOL"] = {
				["attachsFlashlight"] = true,
				["attachsCrosshair"] = true
			},
		},
        ["Ammos"] = {
            ["WEAPON_PISTOL_AMMO"] = 250,
        }
    },
    ["Event_Pistol"] = {
        ["Attachs"] = {
			["WEAPON_PISTOL_MK2"] = {
				["attachsFlashlight"] = true
			},
		},
        ["Ammos"] = {
            ["WEAPON_PISTOL_AMMO"] = 250,
        }
    },
    ["FFAFuzil"] = {
        ["Attachs"] = {
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["attachsFlashlight"] = true
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["attachsFlashlight"] = true,
				["attachsCrosshair"] = true
			},
		},
        ["Ammos"] = {
            ["WEAPON_RIFLE_AMMO"] = 250,
        }
    }
}

AddEventHandler("inventory:saveTemporary",function(Passport,Type)
	CleanWeapons(Passport,false)

	if not Temporary[Passport] and Ammos[Passport] and Attachs[Passport] then
		if not Type or Type == nil then
			Type = "Pistol"
		end

		Temporary[Passport] = {
			["Ammos"] = Ammos[Passport],
			["Attachs"] = Attachs[Passport]
		}

		if TypeWeapons[Type] then
			Attachs[Passport] = TypeWeapons[Type]["Attachs"] or {}
			Ammos[Passport] = TypeWeapons[Type]["Ammos"] or {}
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYTEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:applyTemporary",function(Passport)
	CleanWeapons(Passport,true)

	if Temporary[Passport] and Ammos[Passport] and Attachs[Passport] then
		Attachs[Passport] = Temporary[Passport]["Attachs"]
		Ammos[Passport] = Temporary[Passport]["Ammos"]
		Temporary[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] then
			Player(source)["state"]["Buttons"] = false
			TriggerClientEvent("Progress",source,"Cancelando",0)

			if verifyObjects[Passport] then
				local Model = verifyObjects[Passport][1]
				local Hash = verifyObjects[Passport][2]

				if Trashs[Model] and Trashs[Model][Hash] then
					Trashs[Model][Hash] = nil
				end

				verifyObjects[Passport] = nil
			end

			if Loots[Passport] then
				local myLoots = Loots[Passport]
				if Boxes[myLoots] and Boxes[myLoots][Passport] then
					Boxes[myLoots][Passport] = nil
				end

				Loots[Passport] = nil
			end

			Active[Passport] = nil
		end

		if Carry[Passport] then
			TriggerClientEvent("player:ropeCarry",Carry[Passport],source)
			TriggerClientEvent("player:Commands",Carry[Passport],false)
			Player(source)["state"]["Carregar"] = false
			vRPC.DestroyObjects(Carry[Passport])
			Carry[Passport] = nil
		end

		if Scanners[Passport] then
			TriggerClientEvent("inventory:updateScanner",source,false)
			Player(source)["state"]["Buttons"] = false
			Scanners[Passport] = nil
		end

		if Player(source)["state"]["Camera"] then
			TriggerClientEvent("inventory:Camera",source)
		end

		-- if GetPlayerRoutingBucket(source) > 900000 then
		-- 	TriggerEvent("arena:Cancel",source,Passport)
		-- end

		vRPC.DestroyObjects(source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.checkInventory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Active[Passport] ~= nil then
		return false
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.verifyWeapon(Item,Ammo)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Ammos[Passport] and Attachs[Passport] then
		if not vRP.ConsultItem(Passport,Item,1) then
			local Hash = itemAmmo(Item)

			if Hash and Ammos[Passport][Hash] then
				if Ammo and Ammo > 0 then
                    if Ammo > Ammos[Passport][Hash] then
                        Ammos[Passport][Hash] = 0
                    else
                        Ammos[Passport][Hash] = parseInt(Ammo)
                    end
				end

				if Attachs[Passport][Item] then
					for Name,_ in pairs(Attachs[Passport][Item]) do
						vRP.GenerateItem(Passport,Name,1)
					end

					Attachs[Passport][Item] = nil
				end

				if Ammos[Passport][Hash] > 0 then
					vRP.GenerateItem(Passport,Hash,Ammos[Passport][Hash])
					Ammos[Passport][Hash] = nil
				end

				TriggerClientEvent("inventory:Update",source,"Backpack")
			end

			CleanWeapons(Passport,false)

			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.dropWeapons(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
        
        if Player(source)["state"]["GunGame"] or Player(source)["state"]["FFA"] then
            return
        end

		if not vRP.ConsultItem(Passport,Item,1) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWING
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.removeThrowing(Item)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Item ~= "" and Item ~= nil then
		vRP.TakeItem(Passport,Item,1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------

--[[
	WARNING: Essa função é um exploit, o client pode
	definir um número de munições e o server aceita e
	salva no banco de dados sem nenhuma verificação!

	-slashkeyvalue
]]
local function InternalPreventWeapon(source, Item, Ammo)
	local Passport = vRP.Passport(source)
	if Passport and Ammos[Passport] then
		local Hash = itemAmmo(Item)

		if Hash and Ammos[Passport][Hash] then
			if Ammo > 0 then
				Ammos[Passport][Hash] = Ammo
			else
				Ammos[Passport][Hash] = nil
				CleanWeapons(Passport,false)
			end
		end
	end
end

function Inventory.preventWeapon(Item, Ammo)
	local source = source

	InternalPreventWeapon(source, Item, Ammo)
end

--[[
	Só um wrapper sobre a função `Inventory.preventWeapon`
	para melhorar a otimização da network, já que não tem necessidade
	da gente usar essa função via Tunnel.

	Ainda estou matendo o `Inventory.preventWeapon` porque tem outros
	scripts que dependem dessa função

	-slashkeyvalue
]]
RegisterNetEvent('requestPreventWeapon', function(Item, Ammo)
	local source = source

	InternalPreventWeapon(source, Item, Ammo)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CleanWeapons",function(Passport)
	CleanWeapons(Passport,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.VerifyObjects(Entity,Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if Entity[1] ~= nil and Entity[2] ~= nil and Entity[4] ~= nil then
			local Hash = Entity[1]
			local Model = Entity[2]
			local Coords = Entity[4]

			if not verifyObjects[Passport] then
				if not Trashs[Model] then
					Trashs[Model] = {}
				end

				for k,v in pairs(Trashs[Model]) do
					if #(v["Coords"] - Coords) <= 0.75 and os.time() <= v["timer"] then
						local Cooldown = parseInt(v["timer"] - os.time())
						TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos.",5000)
						-- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Cooldown})
						return
					end
				end

				Active[Passport] = os.time() + 5
				TriggerClientEvent("Progress",source,"Vasculhando",5000)
				vRPC.playAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)

				verifyObjects[Passport] = { Model,Hash }
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				Trashs[Model][Hash] = { ["Coords"] = Coords, ["timer"] = os.time() + 3600 }

				repeat
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC.stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						local itemSelect = { "",1 }

						if itemSelect[1] == "" then
							TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
							-- TriggerClientEvent("Notify2",source,"#nothingFound")
						else
							if (vRP.InventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.GetWeight(Passport) then
								vRP.GenerateItem(Passport,itemSelect[1],itemSelect[2],true)
							else
								TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
								-- TriggerClientEvent("Notify2",source,"#mochilaFull")
								Trashs[Model][Hash] = nil
							end
						end

						verifyObjects[Passport] = nil
					end

					Wait(100)
				until not Active[Passport]
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
			-- TriggerClientEvent("Notify2",source,"#nothingFound")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.Loot(Entity,Service)
	local source = source
	local Entity = tostring(Entity)
	local Passport = vRP.Passport(source)
	if Passport and LootItens[Service] then
		if not Loots[Passport] and not Active[Passport] then
			if not Boxes[Entity] then
				Boxes[Entity] = {}
			end

			if Boxes[Entity][Passport] then
				if os.time() <= Boxes[Entity][Passport] then
					local Cooldown = parseInt(Boxes[Entity][Passport] - os.time())
					TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos.",5000)
					-- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Cooldown})
					return
				end
			end

			if Objects[Entity]["perm"] then
				if not vRP.HasGroup(Passport,Objects[Entity]["perm"]) then
					return
				end
			end

			Loots[Passport] = Entity
			Active[Passport] = os.time() + 5
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Vasculhando",5000)
			Boxes[Entity][Passport] = os.time() + LootItens[Service]["Cooldown"]
			vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC.stopAnim(source,false)
					Player(source)["state"]["Buttons"] = false

					local randItem = math.random(#LootItens[Service]["List"])
					local randAmount = math.random(LootItens[Service]["List"][randItem]["min"],LootItens[Service]["List"][randItem]["max"])
					local itemSelect = { LootItens[Service]["List"][randItem]["item"],randAmount }

					if (vRP.InventoryWeight(Passport) + itemWeight(itemSelect[1]) * itemSelect[2]) <= vRP.GetWeight(Passport) then
						vRP.GenerateItem(Passport,itemSelect[1],itemSelect[2],true)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
						-- TriggerClientEvent("Notify2",source,"#mochilaFull")
						Boxes[Entity][Passport] = nil
					end

					Loots[Passport] = nil
				end

				Wait(100)
			until not Active[Passport]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:applyPlate")
AddEventHandler("inventory:applyPlate",function(Entity)
	local source = source
	local consultItem = {}
	local Plate = Entity[1]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not Plates[Plate] then
			consultItem = vRP.InventoryItemAmount(Passport,"plate")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("plate").."</b>.",5000)
				-- TriggerClientEvent("Notify2",source,"#precisaGauze",{itemName("plate")})
				return
			end
		end

		local consultPliers = vRP.InventoryItemAmount(Passport,"pliers")
		if consultPliers[1] <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("pliers").."</b>.",5000)
			-- TriggerClientEvent("Notify2",source,"#precisaGauze",{itemName("pliers")})
			return
		end

		if Plates[Plate] ~= nil then
			if os.time() < Plates[Plate][1] then
				local plateTimers = parseInt(Plates[Plate][1] - os.time())
				if plateTimers ~= nil then
					TriggerClientEvent("Notify",source,"azul","Aguarde "..CompleteTimers(plateTimers)..".",5000)
					-- TriggerClientEvent("Notify2",source,"#aguarde",{msg=CompleteTimers(plateTimers)})
				end

				return
			end
		end

		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("Progress",source,"Trocando",10000)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.stopAnim(source,false)
				Player(source)["state"]["Buttons"] = false

				if not Plates[Plate] then
					if vRP.TakeItem(Passport,consultItem[2],1,true) then
						local newPlate = vRP.GeneratePlate()
						TriggerEvent("plateEveryone",newPlate)
						Plates[newPlate] = { os.time() + 3600,Plate }

						local Network = NetworkGetEntityFromNetworkId(Entity[4])
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							SetVehicleNumberPlateText(Network,newPlate)
						end
					end
				else
					local Network = NetworkGetEntityFromNetworkId(Entity[4])
					if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
						SetVehicleNumberPlateText(Network,Plates[Plate][2])
					end

					if math.random(100) >= 50 then
						vRP.GenerateItem(Passport,"plate",1,true)
					else
						TriggerClientEvent("Notify",source,"azul","Após remove-la a mesma quebrou.",5000)
						-- TriggerClientEvent("Notify2",source,"#brokeAfterRemoving")
					end

					TriggerEvent("plateReveryone",Plate)
					Plates[Plate] = nil
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.StealTrunk(Entity)
	local source = source
	local Plate = Entity[1]
	local Network = Entity[4]
	local vehModels = Entity[2]
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		if not vCLIENT.checkWeapon(source,"WEAPON_CROWBAR") then
			TriggerClientEvent("Notify",source,"amarelo","<b>Pé de Cabra</b> não encontrado.",5000)
			-- TriggerClientEvent("Notify2",source,"#crowbarNotFound")
			return
		end

		if not vRP.PassportPlate(Plate) then
			if not Trunks[Plate] then
				Trunks[Plate] = os.time()
			end

			if os.time() >= Trunks[Plate] then
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
				Active[Passport] = os.time() + 100

				if vRP.Task(source,5,1500) then
					Active[Passport] = os.time() + 20
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("Progress",source,"Vasculhando",20000)
					TriggerClientEvent("player:Residuals",source,"Resíduo de Ferro.")
					TriggerClientEvent("player:syncDoorsOptions",source,Network,"open")

					repeat
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							vRPC.stopAnim(source,false)
							Player(source)["state"]["Buttons"] = false
							TriggerClientEvent("player:syncDoorsOptions",source,Network,"close")

							if os.time() >= Trunks[Plate] then
								local randItens = math.random(#StealItens)
								if math.random(250) <= StealItens[randItens]["rand"] then
									local randAmounts = math.random(StealItens[randItens]["min"],StealItens[randItens]["max"])

									if (vRP.InventoryWeight(Passport) + itemWeight(StealItens[randItens]["item"]) * randAmounts) <= vRP.GetWeight(Passport) then
										vRP.GenerateItem(Passport,StealItens[randItens]["item"],randAmounts,true)
										Trunks[Plate] = os.time() + 3600
									else
										TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
										-- TriggerClientEvent("Notify2",source,"#mochilaFull")
									end
								else
									TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
									-- TriggerClientEvent("Notify2",source,"#nothingFound")
									Trunks[Plate] = os.time() + 3600
								end
							end
						end

						Wait(100)
					until not Active[Passport]
				else
					TriggerClientEvent("inventory:vehicleAlarm",source,Network,Plate)
					vRPC.stopAnim(source,false)
					Active[Passport] = nil

					local Coords = vRP.GetEntityCoords(source)
					local Service = vRP.NumPermission("Policia")
					for Passports,Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "155", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(vehModels).." - "..Plate, blipColor = 44 })
						end)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
				-- TriggerClientEvent("Notify2",source,"#nothingFound")
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Veículo protegido pela seguradora.",1000)
			-- TriggerClientEvent("Notify2",source,"#protectedVeic")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.StoreObjects(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Objects[Number] then
			if (vRP.InventoryWeight(Passport) + itemWeight(Objects[Number]["item"])) <= vRP.GetWeight(Passport) then
				vRP.GiveItem(Passport,Objects[Number]["item"],1,true)

				local Players = vRPC.Players(source)
				for _,v in ipairs(Players) do
					async(function()
						TriggerClientEvent("objects:Remover",v,Number)
					end)
				end
				
				Objects[Number] = nil
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				-- TriggerClientEvent("Notify2",source,"#mochilaFull")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.MakeProducts(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		local Split = splitString(Table,"-")
		local Selected = Split[1]

		if Products[Selected] then
			if Selected == "cemitery" then
				if not vRP.Task(source,3,1000) then
					local Coords = vRP.GetEntityCoords(source)
					local Service = vRP.NumPermission("Policia")
					for Passports,Sources in pairs(Service) do
						async(function()
							-- vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "155", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 16 })
						end)
					end
				end
			end

			local Need = {}
			local Consult = {}
			local Number = math.random(#Products[Selected])

			if Products[Selected][Number]["item"] then
				-- if vRP.MaxItens(Passport,Products[Selected][Number]["item"],Products[Selected][Number]["itemAmount"]) then
				-- 	TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				-- 	return
				-- end

				if (vRP.InventoryWeight(Passport) + itemWeight(Products[Selected][Number]["item"]) * Products[Selected][Number]["itemAmount"]) > vRP.GetWeight(Passport) then
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					-- TriggerClientEvent("Notify2",source,"#mochilaFull")
					return
				end
			end

			if Products[Selected][Number]["need"] then
				local needItem = Products[Selected][Number]["need"]

				if type(needItem) == "table" then
					for k,v in pairs(needItem) do
						Consult = vRP.InventoryItemAmount(Passport,v["item"])
						if Consult[1] < v["amount"] then
							TriggerClientEvent("Notify",source,"amarelo","Necessário possuir <b>"..v["amount"].."x "..itemName(v["item"]).."</b>.",5000)
							-- TriggerClientEvent("Notify2",source,"#needItemQnt",{msg=v["amount"],msg2=itemName(v["item"])})
							return
						end

						Need[k] = { Consult[2],v["amount"] }
					end
				else
					needAmount = Products[Selected][Number]["needAmount"]
					Consult = vRP.InventoryItemAmount(Passport,needItem)
					if Consult[1] < needAmount then
						TriggerClientEvent("Notify",source,"amarelo","Necessário possuir <b>"..needAmount.."x "..itemName(needItem).."</b>.",5000)
						-- TriggerClientEvent("Notify2",source,"#needItemQnt",{msg=needAmount,msg2=itemName(needItem)})
						return
					end
				end
			end

			Player(source)["state"]["Buttons"] = true
			Active[Passport] = os.time() + Products[Selected][Number]["timer"]
			TriggerClientEvent("Progress",source,"Produzindo",Products[Selected][Number]["timer"] * 1000)

			if Selected == "tablecoke" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "paper" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "tablemeth" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "tableweed" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "burgershot1" or Selected == "pizzathis1" or Selected == "uwucoffee1" or Selected == "beanmachine1" then
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			elseif Selected == "burgershot2" or Selected == "pizzathis2" or Selected == "uwucoffee2" or Selected == "beanmachine2" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "burgershot3" or Selected == "pizzathis3" or Selected == "uwucoffee3" or Selected == "beanmachine3" then
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			elseif Selected == "milkBottle" then
				vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
			elseif Selected == "cemitery" then
				vRPC.playAnim(source,false,{"amb@medic@standing@tendtodead@idle_a","idle_a"},true)
			elseif Selected == "fishfillet" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "marshmallow" then
				vRPC.playAnim(source,false,{"anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter"},true)
			elseif Selected == "emptybottle" then
				vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
			end

			repeat
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Player(source)["state"]["Buttons"] = false
					Active[Passport] = nil
					local Points = 0

					if Selected ~= "scanner" then
						vRPC.stopAnim(source,false)
					end

					if Products[Selected][Number]["need"] then
						if type(Products[Selected][Number]["need"]) == "table" then
							for k,v in pairs(Need) do
								local Split = splitString(v[1],"-")
								if Split[1] == "weedleaf" and Split[2] ~= nil then
									Points = Split[2]
								end

								vRP.RemoveItem(Passport,v[1],v[2],false)
							end
						else
							vRP.RemoveItem(Passport,Consult[2],needAmount,false)
						end
					end

					if Products[Selected][Number]["item"] then
						if Selected == "tableweed" then
							vRP.GenerateItem(Passport,Products[Selected][Number]["item"].."-"..Points,Products[Selected][Number]["itemAmount"],true)
						else
							vRP.GenerateItem(Passport,Products[Selected][Number]["item"],Products[Selected][Number]["itemAmount"],true)
						end
					end
				end

				Wait(100)
			until not Active[Passport]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
local Perm = {
    ["Groove"] = true,
    ["Outlaws"] = true,
    ["TopGear"] = true,
    ["Redline"] = true,
    ["Bennys"] = true,
    ["DriftKing"] = true,
    ["Forza"] = true,
    ["Overdrive"] = true
}
function HasPermDismantle(Passport)
    local HasPerm = false
    for k,v in pairs(Perm) do
        if vRP.HasGroup(Passport,k) then
            HasPerm = true
        end
    end
    return HasPerm
end

local VehMantle = {}
local PlateCooldown = {}
--vRP.StoreChestManual("Chest:Mansao33","joint",200)
function Inventory.Dismantle(Entity)
	local source = source
	local Plate = Entity[1]
	local Passport = vRP.Passport(source)
    local Plates = exports["garages"]:GetPlates()
	if Passport and not Active[Passport] and not VehMantle[Plate] then
        if PlateCooldown[Plate] and os.time() <= parseInt(PlateCooldown[Plate]) then
            TriggerClientEvent("Notify",source,"amarelo","Placa invalida.",5000,"Desmanche")
            return
        end
        if not HasPermDismantle(Passport) then
            TriggerClientEvent("Notify",source,"amarelo","Sem permissão.",5000)
			-- TriggerClientEvent("Notify2",source,"#noPermission")
            return false
        end
        
		local OtherPassport = vRP.PassportPlate(Plate)
        if OtherPassport == Pasport then
            return
        end
        OtherPassport =  {Passport = OtherPassport }
		if OtherPassport then
		else
			if string.sub(Plate,1,4) ~= "DISM" then
				return false
			end
		end
        
        local Vehicle,Network,Plate1 = vRPC.VehicleList(source,5)

        if Plate1 then
            if Plate ~= Plate1 then
                TriggerClientEvent("Notify",source,"amarelo","Placa invalida.",5000,"Desmanche")
				-- TriggerClientEvent("Notify2",source,"#invalidPlate")
                return false
            end
        else
            return false
        end
        
        if not Plates[Plate] then
            TriggerClientEvent("Notify",source,"amarelo","Veículo não encontrado.",5000,"Desmanche")
			-- TriggerClientEvent("Notify2",source,"#veicNotFound")
            return false
        end

		VehMantle[Plate] = true
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Desmanchando",10000)
		vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
        local Name = vRPC.VehicleModel(source,Vehicle)
		Wait(10500)
        if Active[Passport] and os.time() >= parseInt(Active[Passport]) and Name then
            Active[Passport] = nil
            vRPC.DestroyObjects(source)
            Player(source)["state"]["Buttons"] = false
            TriggerEvent("garages:deleteVehicle",Network,Plate)
            TriggerClientEvent("player:Residuals",source,"Resíduo de Metal.")
            TriggerClientEvent("player:Residuals",source,"Resíduo de Alumínio.")
            VehMantle[Plate] = nil
            PlateCooldown[Plate] = os.time() + 60*60
            local Job = vRP.UserGroupByType(Passport,'Job')
            local OtherPassport = vRP.PassportPlate(Plate)
            if OtherPassport then
                OtherPassport =  {Passport = OtherPassport }
                local GroupBuff = exports["crafting"]:getGroupBuff(Job) or 1
                local Amount = (VehiclePrice(Name) * 0.15) * GroupBuff 
                if GlobalState["Dismantle"] then
                    local NewAmount = Amount * GlobalState["Dismantle"]
                    local RemoveToChest = Amount - (NewAmount)
                    local Chest = "Chest:"..Job.."-99"
                    Amount = NewAmount
                    vRP.StoreChestManual(Chest,"dinheirosujo",RemoveToChest)
                    exports["vrp"]:SendWebHook("Desmanche-Chest","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Veículo:** "..Name.."\n**Do:** "..OtherPassport["Passport"].." ".. vRP.FullName(OtherPassport["Passport"]) .."\n**Valor:** "..Amount.."\n**Valor Depositado:** "..RemoveToChest.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)
                end
                vRP.GenerateItem(Passport,"dinheirosujo",parseInt(Amount),true)
                vRP.Query("vehicles/arrestVehicles",{ Passport = OtherPassport["Passport"], vehicle = Name })
                exports["vrp"]:SendWebHook("Desmanche","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Veículo:** "..Name.."\n**Do:** "..OtherPassport["Passport"].." ".. vRP.FullName(OtherPassport["Passport"]) .."\n**Valor:** "..Amount.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)
            end

            if math.random(1000) <= 100 then
                vRP.GenerateItem(Passport,"plate",1,true)
            end
        end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
function Inventory.RemoveTyres(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Entity[2] ~= "veto" and Entity[2] ~= "veto2" then
		if not vCLIENT.checkWeapon(source,"WEAPON_WRENCH") then
			TriggerClientEvent("Notify",source,"amarelo","<b>Chave Inglesa</b> não encontrada.",5000)
			-- TriggerClientEvent("Notify2",source,"#spannerNotFound")
			return
		end

		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source,Entity[4],Entity[5]) == 1000.0 then
				-- if vRP.MaxItens(Passport,"tyres",1) then
				-- 	TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				-- 	return
				-- end

				if vRP.PassportPlate(Entity[1]) then
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

					if vRP.Task(source,3,1000) then
						Active[Passport] = os.time() + 10
						TriggerClientEvent("Progress",source,"Removendo",10000)

						repeat
							if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil

								local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
								if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
									if vCLIENT.tyreHealth(source,Entity[4],Entity[5]) == 1000.0 then
										TriggerClientEvent("inventory:explodeTyres",source,Entity[4],Entity[1],Entity[5])
										vRP.GenerateItem(Passport,"tyres",1,true)
									end
								end
							end

							Wait(100)
						until not Active[Passport]
					end

					Player(source)["state"]["Buttons"] = false
					vRPC.DestroyObjects(source)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drink")
AddEventHandler("inventory:Drink",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 5
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",5000)
        vRPC.playAnim(source,false,{"amb@world_human_drinking@coffee@male@idle_a","idle_c"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.stopAnim(source,false)
				Player(source)["state"]["Buttons"] = false
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 60
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Desvirando",60000)
		vRPC.playAnim(source,false,{"mini@repair","fixing_a_player"},true)

		repeat
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC.DestroyObjects(source)
				Player(source)["state"]["Buttons"] = false

				local Players = vRPC.Players(source)
				for _,v in ipairs(Players) do
					async(function()
						TriggerClientEvent("target:RollVehicle",v,Entity[4])
					end)
				end
			end

			Wait(100)
		until not Active[Passport]
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUFFSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:BuffServer",function(source,Passport,Name,Amount)
	if not Buffs[Name][Passport] then
		Buffs[Name][Passport] = 0
	end

	if os.time() >= Buffs[Name][Passport] then
		Buffs[Name][Passport] = os.time() + Amount
	else
		Buffs[Name][Passport] = Buffs[Name][Passport] + Amount

		if (Buffs[Name][Passport] - os.time()) >= 3600 then
			Buffs[Name][Passport] = os.time() + 3600
		end
	end

	TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Ammos[Passport] and Attachs[Passport] then
		if Temporary[Passport] then
			Ammos[Passport] = Temporary[Passport]["Ammos"]
			Attachs[Passport] = Temporary[Passport]["Attachs"]
			Temporary[Passport] = nil
		end

		vRP.Query("playerdata/InsertUpdate",{ Passport = Passport, dkey = "Attachs", dvalue = json.encode(Attachs[Passport]) })
		vRP.Query("playerdata/InsertUpdate",{ Passport = Passport, dkey = "Ammos", dvalue = json.encode(Ammos[Passport]) })

		Attachs[Passport] = nil
		Ammos[Passport] = nil
	end

	if Active[Passport] then
		Active[Passport] = nil
	end

	if verifyObjects[Passport] then
		verifyObjects[Passport] = nil
	end

	if Loots[Passport] then
		Loots[Passport] = nil
	end

	if Healths[Passport] then
		Healths[Passport] = nil
	end

	if Armors[Passport] then
		Armors[Passport] = nil
	end

	if Scanners[Passport] then
		Scanners[Passport] = nil
	end

	if Carry[Passport] then
		TriggerClientEvent("player:Commands",Carry[Passport],false)
		vRPC.DestroyObjects(Carry[Passport])
		Carry[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	Ammos[Passport] = vRP.UserData(Passport,"Ammos")
	Attachs[Passport] = vRP.UserData(Passport,"Attachs")

	TriggerClientEvent("objects:Table",source,Objects)
	-- TriggerClientEvent("drops:Table",source,Drops)

	for Name,_ in pairs(Buffs) do
		if Buffs[Name][Passport] then
			if os.time() < Buffs[Name][Passport] then
				TriggerClientEvent("hud:"..Name,source,Buffs[Name][Passport] - os.time())
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("putWeaponHands",function(Source,weaponName,weaponAmmo,attachs,weaponType)
    local Skin = false
    local Passport = vRP.Passport(Source)
    if GetResourceState("skinweapon") ~= "stopped" then
        local skinWeapon = exports["skinweapon"]:GetSkins(weaponName,Passport)
        if skinWeapon then
            Skin = skinWeapon
        end
    end
    vCLIENT.putWeaponHands(Source,weaponName,weaponAmmo,attachs,weaponType,Skin)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
local CarregarCooldown = {}
RegisterCommand("carregar",function(source,Message,History)
	local Passport = vRP.Passport(source)
    local Health = vRP.GetHealth(source)
	if Passport and Health and vRP.GetHealth(source) > 100 then
        local Ped = GetPlayerPed(source)
        if CarregarCooldown[Passport] and os.time() <= CarregarCooldown[Passport] then
            TriggerClientEvent("Notify",source,"vermelho","Aguarde <b>"..parseInt(CarregarCooldown[Passport] - os.time()).." segundos</b> para carregar alguém.",5000,"carregar")
			-- TriggerClientEvent("Notify2",source,"#waitToCarrySomeone",{msg=parseInt(CarregarCooldown[Passport] - os.time())})
            return
        end
        CarregarCooldown[Passport] = os.time() + 5
        if SafeZone == "true" then
            if not Entity(Ped)["state"]["WarMode"] then
                return
            end
        end
        if not vRP.InsideVehicle(source) then
            if Carry[Passport] then
                TriggerClientEvent("player:ropeCarry",Carry[Passport],source)
                TriggerClientEvent("player:Commands",Carry[Passport],false)
                Player(source)["state"]["Carregar"] = false
				vRPC.DestroyObjects(Carry[Passport])
                vRPC.DestroyObjects(source)
                if Carry[Passport] and Player(Carry[Passport])["state"] and Player(Carry[Passport])["state"]["Carry"] then
                    Player(Carry[Passport])["state"]["Carry"] = false
                end
                Carry[Passport] = nil
            else
                local ClosestPed = vRPC.ClosestPed(source,3)
                if ClosestPed and not vPLAYER.inTrash(ClosestPed) then
                    if vRP.GetHealth(ClosestPed) <= 100 or Player(ClosestPed)["state"]["Handcuff"] then
                        Carry[Passport] = ClosestPed

                        TriggerClientEvent("player:ropeCarry",Carry[Passport],source)
                        TriggerClientEvent("player:Commands",Carry[Passport],true)
                        TriggerClientEvent("inventory:Close",Carry[Passport])
                        Player(source)["state"]["Carregar"] = true
                        Player(Carry[Passport])["state"]["Carry"] = true
                        vRPC.playAnim(source,true,{"missfinale_c2mcs_1","fin_c2_mcs_1_camman"},true)
                        vRPC.playAnim(ClosestPed,false,{"nm","firemans_carry"},true)
                    else
                        if vRP.Request(ClosestPed,"Deseja ser carregado ?") and not vPLAYER.inTrash(ClosestPed) then
                            Carry[Passport] = ClosestPed

                            TriggerClientEvent("player:ropeCarry",Carry[Passport],source)
                            TriggerClientEvent("player:Commands",Carry[Passport],true)
                            TriggerClientEvent("inventory:Close",Carry[Passport])
                            Player(source)["state"]["Carregar"] = true
                            Player(Carry[Passport])["state"]["Carry"] = true
    
                            vRPC.playAnim(source,true,{"missfinale_c2mcs_1","fin_c2_mcs_1_camman"},true)
                            vRPC.playAnim(ClosestPed,false,{"nm","firemans_carry"},true)
                        end
                    end
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------

function CleanWeapons(Passport,Clean)
    local source = vRP.Source(Passport)
    if source then
        local Ped = GetPlayerPed(source)
        local Weapon = GetSelectedPedWeapon(Ped)

        RemoveWeaponFromPed(Ped,Weapon)
        RemoveAllPedWeapons(Ped,false)
        SetPedAmmo(Ped,Weapon,0)

        if Clean then
            Attachs[Passport] = {}
            Ammos[Passport] = {}
        end
    end
end

exports("CleanWeapons", CleanWeapons)

RegisterCommand("barreira", function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Policia", 3) then
            local Hash = "prop_mp_barrier_02b"
            local application,Coords,heading = vRPC.objectCoords(source,Hash)
            if application then
                if not vCLIENT.objectExist(source,Coords,Hash) then
                    local Number = 0
        
                    repeat
                        Number = Number + 1
                    until not Objects[tostring(Number)]
        
                    Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 150, mode = "3" }
                    TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
                    exports["vrp"]:SendWebHook("barreira","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .."\n**Criou Barreira:** "..Coords.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
					exports["vrp"]:SendWebHook("barreira2","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .."\n**Criou Barreira:** "..Coords.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
				end
            end
		end
	end
end)

local PlayerFishing = {}
local TimeFishing = {}
RegisterServerEvent("player:Fishing")
AddEventHandler("player:Fishing",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local sPassport = tostring(Passport)
        if vCLIENT.fishingCoords(source) then
			Player(source)["state"]["Buttons"] = true
            TriggerClientEvent("hoverfy:removeHoverfy",source)
			if not vCLIENT.fishingAnim(source) then
                vRPC.CreateObjects(source,"amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",49,60309)
			end
            if not TimeFishing[Passport] then
                TimeFishing[sPassport] = os.time()
            end
            local Members = exports["party"]:Room(Passport,source,10)
            local fishList = { "octopus","shrimp","carp","horsefish","tilapia","codfish","catfish" }
            
            if parseInt(#Members) >= 4 then
                fishList = { "octopus","shrimp","carp","horsefish","tilapia","codfish","catfish","goldenfish","pirarucu","pacu","tambaqui" }
            end
            
            local fishRandom = math.random(#fishList)
            local fishSelects = fishList[fishRandom]
            if os.time() - TimeFishing[sPassport] >= 60*60 then
                PlayerFishing[sPassport] = os.time() + 60*25
                TriggerClientEvent("Progress",source,"Mundo",60000*25)
            else
                PlayerFishing[sPassport] = os.time() + 60*5
                TriggerClientEvent("Progress",source,"Mundo",60000*5)
            end
            
            Wait(100)
            repeat
                Wait(1000)
            until not PlayerFishing[sPassport] or os.time() >= parseInt(PlayerFishing[sPassport])
            if not vCLIENT.fishingCoords(source) then
                TriggerClientEvent("inventory:CancelFishing",source)
                Player(source)["state"]["Buttons"] = false
                PlayerFishing[sPassport] = nil
                TimeFishing[sPassport] = nil
                return
            end
            if PlayerFishing[sPassport] and os.time() >= parseInt(PlayerFishing[sPassport]) then
                vRP.GenerateItem(Passport,fishSelects,1,true)
                TriggerClientEvent("inventory:NewFishing",source)
                Player(source)["state"]["Buttons"] = false
            end
        else
            TriggerClientEvent("inventory:CancelFishing",source)
            Player(source)["state"]["Buttons"] = false
            PlayerFishing[sPassport] = nil
            TimeFishing[sPassport] = nil
            return
		end
    end
end)

RegisterServerEvent("player:CancelFishing")
AddEventHandler("player:CancelFishing",function()
    local source = source
    local Passport = vRP.Passport(source)
    local sPassport = tostring(Passport)
    if Passport then
        PlayerFishing[sPassport] = nil
        TimeFishing[sPassport] = nil
    end
end)
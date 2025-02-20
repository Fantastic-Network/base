-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Shops = {}
Tunnel.bindInterface("inventory/shops",Shops)
local vCLIENT = Tunnel.getInterface("inventory/shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------
local nameMale = { "James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio" }
local nameFemale = { "Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna","Rebecca","Virginia","Kathleen","Pamela","Martha","Debra","Amanda","Stephanie","Carolyn","Christine","Marie","Janet","Catherine","Frances","Ann","Joyce","Diane","Alice","Julie","Heather","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred","Katherine","Joan","Ashley","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly","Denise","Tammy","Irene","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Louise","Sara","Anne","Jacqueline","Wanda","Bonnie","Julia","Ruby","Lois","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian","Emily","Robin" }
local userName2 = { "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes" }

local EconomyVar = 1.0
CreateThread(function()
    Wait(1000)
    EconomyVar = exports['variables']:GetVariable('variables','ShopBuy') or 1.0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function Shops.requestPerm(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if ShopsConfig[Type]["perm"] ~= nil then
			if not vRP.HasGroup(Passport,ShopsConfig[Type]["perm"],ShopsConfig[Type]["level"] or 1) then
				return false
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Shops.requestShop(name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and name and ShopsConfig[name] and ShopsConfig[name]["List"] then
		local shopSlots = 20
		local inventoryShop = {}
		for k,v in pairs(ShopsConfig[name]["List"]) do
            table.insert(inventoryShop,{
                key = k,
                price = parseInt(v)
            })
		end

		if parseInt(#inventoryShop) > 20 then
			shopSlots = parseInt(#inventoryShop)
		end

		return inventoryShop, shopSlots
	end
end
-- vRP.Prepare("shops_stock/GetStock","SELECT * FROM shops_stock")
-- vRP.Prepare("shops_stock/UpdateStock","INSERT INTO shops_stock (store, item, stock) VALUES (@store, @item, @amount) ON DUPLICATE KEY UPDATE stock = @amount;")
-- ShopStock = {}
-- CreateThread(function()
--     local result = vRP.Query("shops_stock/GetStock")
--     if result then
--         for k,v in pairs(result) do
--             local Store = v["store"]
--             local Item = v["item"]
--             local Stock = v["stock"]
--             if not ShopStock[Store] then
--                 ShopStock[Store] = {}
--             end
--             ShopStock[Store][Item] = Stock
--         end
--     end
-- end)

-- function CheckStock(Store,Item,Amount)
--     if ShopStock[Store] then
--         if ShopStock[Store][Item] then
--             if ShopStock[Store][Item] >= Amount then
--                 return true
--             end
--         end
--     end
-- end

-- function RemStock(Store,Item,Amount)
--     if ShopStock[Store] then
--         if ShopStock[Store][Item] then
--             if ShopStock[Store][Item] >= Amount then
--                 ShopStock[Store][Item] = ShopStock[Store][Item] - Amount
--                 vRP.Query("shops_stock/UpdateStock",{ item = Item, amount = ShopStock[Store][Item], store = Store })
--                 return true
--             end
--         end
--     end
-- end

-- function AddStock(Store,Item,Amount)
--     if ShopStock[Store] then
--         if ShopStock[Store][Item] then
--             ShopStock[Store][Item] = ShopStock[Store][Item] + Amount
--             vRP.Query("shops_stock/UpdateStock",{ item = Item, amount = ShopStock[Store][Item], store = Store })
--             return true
--         end
--     end
-- end

-- function Shops.GetShopStock(Type)
--     local Store = ShopsConfig[Type]["name"]
--     if ShopStock[Store] then
--         return ShopStock[Store]
--     end
-- end

CreateThread(function()
    Wait(1000)
    local ModifiedStores = exports['variables']:GetVariable('variables','ModifiedStores') or {}
    for Shop,Data in pairs (ModifiedStores) do
        ShopsConfig[Shop] = Data
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function Shops.getShopType(Type)
    return ShopsConfig[Type]["mode"]
end---------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Shops.functionShops(Type,Item,Amount,Slot)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if ShopsConfig[Type] then
			if Amount <= 0 then Amount = 1 end

            if ShopsConfig[Type]["perm"] and (not vRP.HasGroup(Passport,ShopsConfig[Type]["perm"],ShopsConfig[Type]["level"] or 1)) then
				return false
			end

            if ShopsConfig[Type]["type"] == "Dirty" then
                if vRP.HasGroup(Passport,"Policia") then
                    TriggerClientEvent("Notify",source,"vermelho","<b>Policial</b> não pode comprar/vender <b>Itens</b> nessa loja.",5000)
                    vCLIENT.updateShops(source,"requestShop")
                    return
                end
            end

			local inventory = vRP.Inventory(Passport)
			if (inventory[tostring(Slot)] and inventory[tostring(Slot)]["item"] == Item) or not inventory[tostring(Slot)] then
				if ShopsConfig[Type]["mode"] == "Buy" then
					-- if vRP.MaxItens(Passport,Item,Amount) then
					-- 	TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
					-- 	vCLIENT.updateShops(source,"requestShop")
					-- 	return
					-- end
                    local itemPrice = ShopsConfig[Type]["List"][Item] * EconomyVar
					if (vRP.InventoryWeight(Passport) + itemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
						if ShopsConfig[Type]["type"] == "Cash" then
							if ShopsConfig[Type]["List"][Item] then
                                
								if vRP.PaymentFull(Passport,parseInt(itemPrice*Amount)) then
									if Item == "identity" or string.sub(Item,1,5) == "badge" then
										vRP.GiveItem(Passport,Item.."-"..Passport,Amount,false,Slot)
									elseif Item == "fidentity" then
										local Identity = vRP.Identity(Passport)
										if Identity then
											if Identity["sex"] == "M" then
												vRP.Query("fidentity/NewIdentity",{ name = nameMale[math.random(#nameMale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											else
												vRP.Query("fidentity/NewIdentity",{ name = nameFemale[math.random(#nameFemale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											end

											local Identity = vRP.Identity(Passport)
											local consult = vRP.Query("fidentity/GetIdentity")
											if consult[1] then
												vRP.GiveItem(Passport,Item.."-"..consult[1]["id"],Amount,false,Slot)

											end
										end
									else
										vRP.GenerateItem(Passport,Item,Amount,false,Slot)

										if Item == "WEAPON_PETROLCAN" then
											vRP.GenerateItem(Passport,"WEAPON_PETROLCAN_AMMO",4500,false)
											
										end
									end

									TriggerClientEvent("sounds:Private",source,"cash",0.1)
									if Type == "Policia" then
										exports["vrp"]:SendWebHook("arsenal-policia", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Comprou:** " .. itemName(Item) .. " \n**Quantidade:** " .. Amount .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
										exports["vrp"]:SendWebHook("arsenal-policia-2", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Comprou:** " .. itemName(Item) .. " \n**Quantidade:** " .. Amount .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
									-- elseif Type == "SellDirty" then
									-- 	print (Item)
									end
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
									-- TriggerClientEvent("Notify2",source,"#semdoletas")
								end
							end
						elseif ShopsConfig[Type]["type"] == "Consume" then
                            local Price = (ShopsConfig[Type]["List"][Item] * EconomyVar) * Amount
							if vRP.TakeItem(Passport,ShopsConfig[Type]["item"],parseInt(itemPrice * Amount)) then
								vRP.GenerateItem(Passport,Item,Amount,false,Slot)
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(ShopsConfig[Type]["item"]).."</b> insuficiente.",5000)
								-- TriggerClientEvent("Notify2",source,"#shopInsuf",{msg=itemName(ShopsConfig[Type]["item"])})
							end
                        elseif ShopsConfig[Type]["type"] == "Dirty" then
                            if CheckStock(ShopsConfig[Type]["name"],Item,Amount) then
                                if vRP.TakeItem(Passport,"dinheirosujo",parseInt(itemPrice * Amount)) then
                                    vRP.GenerateItem(Passport,Item,Amount,false,Slot)
                                    TriggerClientEvent("sounds:Private",source,"cash",0.1)
									exports["vrp"]:SendWebHook("mercado-negro", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Comprou:** " .. itemName(Item) .. " \n**Quantidade:** " .. Amount .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
                                    RemStock(ShopsConfig[Type]["name"],Item,Amount)
                                else
                                    TriggerClientEvent("Notify",source,"vermelho","<b>Dinheiro Sujo</b> insuficiente.",5000)
                                    -- TriggerClientEvent("Notify2",source,"#shopInsuf",{msg=itemName(ShopsConfig[Type]["item"])})
                                end
                            else
                                TriggerClientEvent("Notify",source,"vermelho","<b>Estoque</b> insuficiente.",5000)
                                -- TriggerClientEvent("Notify2",source,"#shopInsuf",{msg=itemName(ShopsConfig[Type]["item"])})
                            end
						elseif ShopsConfig[Type]["type"] == "Premium" then
                            local Price = (ShopsConfig[Type]["List"][Item] * EconomyVar) * Amount
							if ShopsConfig[Type]["List"] and ShopsConfig[Type]["List"][Item] and vRP.PaymentGems(Passport,Price) then
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
								vRP.GenerateItem(Passport,Item,Amount,false,Slot)
								TriggerClientEvent("Notify",source,"verde","Comprou <b>"..Amount.."x "..itemName(Item).."</b> por <b>"..ShopsConfig[Type]["List"][Item] * Amount.." Diamantes</b>.",5000)
								-- TriggerClientEvent("Notify2",source,"#shopWithDiamond",{msg=Amount,msg2=itemName(Item),msg3=ShopsConfig[Type]["List"][Item] * Amount})
								exports["vrp"]:SendWebHook("lojadimas", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Comprou:** " .. itemName(Item) .. " \n**Quantidade:** " .. Amount .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)

							else
								TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.",5000)
								-- TriggerClientEvent("Notify2",source,"#notEnoughDiamond")
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
						-- TriggerClientEvent("Notify2",source,"#mochilaFull")
					end
				elseif ShopsConfig[Type]["mode"] == "Sell" then
					local splitName = splitString(Item,"-")

                    local itemPrice = ShopsConfig[Type]["List"][splitName[1]] * EconomyVar
					if itemPrice then
						if itemPrice > 0 then
							if vRP.CheckDamaged(Item) then
								TriggerClientEvent("Notify",source,"vermelho","Itens danificados não podem ser vendidos.",5000)
								-- TriggerClientEvent("Notify2",source,"#damagedItemCannotSell")
								vCLIENT.updateShops(source,"requestShop")
								return
							end
						end

						if ShopsConfig[Type]["type"] == "Cash" then
							if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
								if itemPrice > 0 then
                                    local Valuation = parseInt(itemPrice * Amount)
									vRP.GenerateItem(Passport,"dollars",Valuation,false)
                                    --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Valuation, Type = "Shop Cash"})
									TriggerClientEvent("sounds:Private",source,"cash",0.1)
								end
							end
                        elseif ShopsConfig[Type]["type"] == "Dirty" then
							if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
								if itemPrice > 0 then
									vRP.GenerateItem(Passport,"dinheirosujo",parseInt(itemPrice * Amount),false)
                                    AddStock(ShopsConfig[Type]["name"],Item,Amount)
									TriggerClientEvent("sounds:Private",source,"cash",0.1)
									exports["vrp"]:SendWebHook("mercado-negro", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Vendeu:** " .. itemName(Item) .. " \n**Quantidade:** " .. Amount .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
								end
							end
						end
					end
				end
			end
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			vRP.GiveItem(Passport,Item,Amount,false,Target)
			vCLIENT.updateShops(source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		local inventory = vRP.Inventory(Passport)
		if inventory[tostring(Slot)] and inventory[tostring(Target)] and inventory[tostring(Slot)]["item"] == inventory[tostring(Target)]["item"] then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GiveItem(Passport,Item,Amount,false,Target)
			end
		else
			vRP.SwapSlot(Passport,Slot,Target)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end)
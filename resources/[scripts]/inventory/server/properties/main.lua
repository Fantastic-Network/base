local PropertiesAPI = {}
Tunnel.bindInterface("inventory/properties", PropertiesAPI)
local vKEYBOARD = Tunnel.getInterface("keyboard")
local vSKINSHOP = Tunnel.getInterface("skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("propertys/All","SELECT `id`,`Name`,`Interior`,`Keys`,`Passport`,`Serial`,`Vault`,`Fridge`,UNIX_TIMESTAMP(`Tax`) AS Tax FROM propertys")
vRP.Prepare("propertys/GetAppartments","SELECT `id`,`Name`,`Interior`,`Keys`,`Passport`,`Serial`,`Vault`,`Fridge`,UNIX_TIMESTAMP(`Tax`) AS Tax, `Number` FROM propertys WHERE Name LIKE CONCAT('%', @Name, '%') ORDER BY NUMBER DESC")
vRP.Prepare("propertys/GetMaxAppartments","SELECT `Number` FROM propertys WHERE Name LIKE CONCAT('%', @Name, '%') ORDER BY `Number` DESC LIMIT 1")
vRP.Prepare("propertys/AllWithGarages","SELECT `id`,`Name`,`Interior`,`Keys`,`Passport`,`Serial`,`Vault`,`Fridge`,UNIX_TIMESTAMP(`Tax`) AS Tax,`Garage` FROM propertys WHERE `Garage` <> '{}'")
vRP.Prepare("propertys/Sell","DELETE FROM propertys WHERE Name = @name")
vRP.Prepare("propertys/Exist","SELECT `id`,`Name`,`Interior`,`Keys`,`Passport`,`Serial`,`Vault`,`Fridge`,UNIX_TIMESTAMP(`Tax`) AS Tax FROM propertys WHERE Name = @name")
vRP.Prepare("propertys/Serial","SELECT `id`,`Name`,`Interior`,`Keys`,`Passport`,`Serial`,`Vault`,`Fridge`,UNIX_TIMESTAMP(`Tax`) AS Tax FROM propertys WHERE Serial = @serial")
vRP.Prepare("propertys/User","SELECT `id`,`Name`,`Interior`,`Keys`,`Passport`,`Serial`,`Vault`,`Fridge`,UNIX_TIMESTAMP(`Tax`) AS Tax FROM propertys WHERE Passport = @Passport")
vRP.Prepare("propertys/Garages","SELECT `id`,`Name`,`Interior`,`Keys`,`Passport`,`Serial`,`Vault`,`Fridge`,UNIX_TIMESTAMP(`Tax`) AS Tax FROM propertys WHERE Garage IS NOT NULL")
vRP.Prepare("propertys/Garage","UPDATE propertys SET Garage = @garage WHERE Name = @name")
vRP.Prepare("propertys/Keys","UPDATE propertys SET Keys = Keys + @keys WHERE Name = @name")
vRP.Prepare("propertys/Credentials","UPDATE propertys SET Serial = @serial WHERE Name = @name")
vRP.Prepare("propertys/Vault","UPDATE propertys SET Vault = Vault + @weight WHERE Name = @name")
vRP.Prepare("propertys/Fridge","UPDATE propertys SET Fridge = Fridge + @weight WHERE Name = @name")
vRP.Prepare("propertys/Check","SELECT `id`,`Name`,`Interior`,`Keys`,`Passport`,`Serial`,`Vault`,`Fridge`,UNIX_TIMESTAMP(`Tax`) AS Tax FROM propertys WHERE Name = @name AND Passport = @passport")
vRP.Prepare("propertys/Tax","UPDATE propertys SET Tax = DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + @Tax DAY) WHERE Name = @name")
vRP.Prepare("propertys/Buy","INSERT INTO propertys(Name,Interior,Passport,Serial,Vault,Fridge,Tax,Number) VALUES(@name,@interior,@passport,@serial,@vault,@fridge,DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + @Tax DAY),@Number)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Lock = {}
local Inside = {}
local Actived = {}
local Robbery = {}
local Markers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local ItemList = {
    { ["Item"] = "keyboard", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "xbox", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "mouse", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "playstation", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "dish", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "pan", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "fan", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "blender", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "switch", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "cup", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "watch", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "bracelet", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "dildo", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "spray01", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "spray02", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "spray03", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "spray04", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "rimel", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "brush", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "soap", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "erases", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "legos", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "ominitrix", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "dices", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "domino", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "floppy", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "horseshoe", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "deck", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "goldbar", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "pliers", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "pager", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "card01", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "card03", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "card04", ["Min"] = 1, ["Max"] = 3 },
    { ["Item"] = "card05", ["Min"] = 1, ["Max"] = 3 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.Robbery(Name,Number)
	local source = source
	if not Robbery[Name] then
		Robbery[Name] = {}
	end

	if not Robbery[Name][Number] then
		Robbery[Name][Number] = 0
	end

	if Robbery[Name] and os.time() < Robbery[Name][Number] then
		return false
	end

	vRPC.playAnim(source,false,{"missfbi_s4mop","clean_mop_back_player"},true)
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.Police(Coords)
	local Service = vRP.NumPermission("Policia")
	for Passports,Sources in pairs(Service) do
		async(function()
			TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "150", x = Coords["x"], y = Coords["y"], z = Coords["z"], blipColor = 44 })
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYBERRY
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.Paybbery(Name,Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Robbery[Name] and os.time() >= Robbery[Name][Number] then
		local Random = math.random(#ItemList)
		local Amount = math.random(ItemList[Random]["Min"],ItemList[Random]["Max"])

		if (vRP.InventoryWeight(Passport) + itemWeight(ItemList[Random]["Item"]) * Amount) <= vRP.GetWeight(Passport) then
			vRP.GenerateItem(Passport,ItemList[Random]["Item"],Amount,true)
			Robbery[Name][Number] = os.time() + 3600
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.HasOwner(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
        if Consult[1] then
            return true
        end
        return false
    end
end
function PropertiesAPI.Propertys(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if Consult[1]["Passport"] == Passport or vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) or Lock[Name] then
				if os.time() > Consult[1]["Tax"] then
					if vRP.Request(source,"Hipoteca atrasada, deseja efetuar o pagamento?","Sim, concluir pagamento","Não, pago depois") then
                        local PlayerHomes = vRP.Query("propertys/User",{ Passport = Passport })
                        TriggerClientEvent("dynamic:closeSystem",source)
                        local Vip = vRP.UserGroupByType(Passport,'Premium')
                        local Max = 1
                        if Vip then
                            Max = 4  
                        end
						if vRP.PaymentFull(Passport,Informations[Consult[1]["Interior"]]["Price"] * 0.1) then
							TriggerClientEvent("Notify",source,"amarelo","Pagamento concluído.",5000)
							-- TriggerClientEvent("Notify2",source,"#pagamentoConcluido")
							vRP.Query("propertys/Tax",{ name = Name, Tax = 15 })
						end
					end
				else
                    Consult[1]["Price"] = Informations[Consult[1]["Interior"]]["Price"] * 0.1
					Consult[1]["Tax"] = MinimalTimers(Consult[1]["Tax"] - os.time())
					return Consult[1]
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.Toggle(Name,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        if GetPlayerRoutingBucket(source) == 12 then
            return
        end
		if Mode == "Exit" then
			Inside[Passport] = nil
            exports["vrp"]:ChangePlayerBucket(source,1)
		else
			Inside[Passport] = Name
            exports["vrp"]:ChangePlayerBucket(source,Route(Name))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckAppartment(Name)
    if string.find(Name,"Apartments") then
        return true
    end
    return false
end

RegisterServerEvent("propertys:Buy")
AddEventHandler("propertys:Buy",function(Name)
	local source = source
	local Split = splitString(Name,"-")
	local Passport = vRP.Passport(source)
	if Passport then
		local Name = Split[1]
		local Interior = Split[2]
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if not Consult[1] then
            local PlayerHomes = vRP.Query("propertys/User",{ Passport = Passport })
			TriggerClientEvent("dynamic:closeSystem",source)
            local Vip1 = vRP.UserGroupByType(Passport,'Premium')
			local Vip2 = vRP.UserGroupByType(Passport,'VIP')
			local Vip = Vip1 or Vip2
            local Max = 1
            if Vip then
                Max = 4  
            end
            if PlayerHomes then
                if #PlayerHomes >= Max then
                    TriggerClientEvent("Notify",source,"vermelho","Você já possui o limite de casas.",5000,"casas")
					-- TriggerClientEvent("Notify2",source,"#houseLimit")
                    return
                end
            end
			if vRP.Request(source,"Deseja comprar a propriedade?","Sim, assinar papelada","Não, mudei de ideia") then
				if Gemstone[Name] then
					if vRP.TakeItem(Passport,"valemansao",1,true) or vRP.PaymentGems(Passport,Informations[Interior]["Gemstone"]) then
                        if CheckAppartment(Name) then
                            Name = GenerateAppartment(Name)
                        end
                        local Split = splitString(Name,"|")
						local Serial = PropertysSerials()
						vRP.GiveItem(Passport,"propertys-"..Serial,3,true)
						vRP.Query("propertys/Buy",{ name = Name, interior = Interior, passport = Passport, serial = Serial, vault = Informations[Interior]["Vault"], fridge = Informations[Interior]["Fridge"], Tax = 15, Number = Split[2] })
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.",5000)
						-- TriggerClientEvent("Notify2",source,"#notEnoughDiamond")
					end
				else
					if vRP.TakeItem(Passport,"valecasa",1,true) or vRP.PaymentFull(Passport,Informations[Interior]["Price"]) then
                        if CheckAppartment(Name) then
                            Name = GenerateAppartment(Name)
                        end
                        local Split = splitString(Name,"|")
						local Serial = PropertysSerials()
						vRP.GiveItem(Passport,"propertys-"..Serial,3,true)
						vRP.Query("propertys/Buy",{ name = Name, interior = Interior, passport = Passport, serial = Serial, vault = Informations[Interior]["Vault"], fridge = Informations[Interior]["Fridge"], Tax = 15, Number = Split[2] })
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						-- TriggerClientEvent("Notify2",source,"#semdoletas")
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Lock")
AddEventHandler("propertys:Lock",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if Consult[1]["Passport"] == Passport or vRP.InventoryFull(Passport,"propertys-"..Consult[1]["Serial"]) then
				if Lock[Name] then
					Lock[Name] = nil
					TriggerClientEvent("Notify",source,"verde","Propriedade trancada.",5000)
					-- TriggerClientEvent("Notify2",source,"#lockedProperty")
				else
					Lock[Name] = true
					TriggerClientEvent("Notify",source,"amarelo","Propriedade destrancada.",5000)
					-- TriggerClientEvent("Notify2",source,"#unlockedProperty")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Sell")
AddEventHandler("propertys:Sell",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Actived[Passport] then
		Actived[Passport] = true

		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] and Consult[1]["Passport"] == Passport then
			TriggerClientEvent("dynamic:closeSystem",source)
            local Price = 0
            if Gemstone[Name] then
                Price = 100
            else
                Price = Informations[Consult[1]["Interior"]]["Price"] * 0.75
            end
			if vRP.Request(source,"Deseja vender a propriedade por <b>"..nonSpecifiedFormatter(Price).."</b> Dolares?","Sim, concluir a venda","Não, mudei de ideia") then
				if Markers[Name] then
					Markers[Name] = nil
				end

				vRP.RemSrvData("Vault:"..Name)
				vRP.RemSrvData("Fridge:"..Name)

				vRP.Query("propertys/Sell",{ name = Name })
				TriggerClientEvent("Notify",source,"amarelo","Venda concluída.",5000)
				-- TriggerClientEvent("Notify2",source,"#completedSale")

				if Gemstone[Name] then
					--vRP.GiveBank(Passport,100,"Property Sell")
                    vRP.GenerateMoney(Passport,100,"Property Sell")
				else
                    local Price = Informations[Consult[1]["Interior"]]["Price"] * 0.75
					--vRP.GiveBank(Passport,Price,"Property Sell")
                    vRP.GenerateMoney(Passport,Price,"Property Sell")
				end
			end
		end

		Actived[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CREDENTIALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Credentials")
AddEventHandler("propertys:Credentials",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] and Consult[1]["Passport"] == Passport then
			TriggerClientEvent("dynamic:closeSystem",source)

			if vRP.Request(source,"Você escolheu reconfigurar todos os cartões de segurança, lembrando que ao prosseguir todos os cartões vão deixar de funcionar, deseja prosseguir?","Sim, prosseguir","Não, outra hora") then
				local Serial = PropertysSerials()
				vRP.Query("propertys/Credentials",{ name = Name, serial = Serial })
				vRP.GiveItem(Passport,"propertys-"..Serial,Consult[1]["Keys"],true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.Clothes()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Clothes = {}
		local Consult = vRP.GetSrvData("Wardrobe:"..Passport)

		for Table,_ in pairs(Consult) do
			Clothes[#Clothes + 1] = { ["name"] = Table }
		end

		return Clothes
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("propertys:Clothes")
AddEventHandler("propertys:Clothes",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Split = splitString(Mode,"-")
		local Consult = vRP.GetSrvData("Wardrobe:"..Passport)
		local Name = Split[2]

		if Split[1] == "save" then
			local Keyboard = vKEYBOARD.keySingle(source,"Salvar como:")
			if Keyboard then
				local Name = Keyboard[1]

				if not Consult[Name] then
					Consult[Name] = vSKINSHOP.Customization(source)
					vRP.SetSrvData("Wardrobe:"..Passport,Consult)
					TriggerClientEvent("propertys:ClothesReset",source)
					TriggerClientEvent("Notify",source,"verde","<b>"..Name.."</b> adicionado.",5000)
					-- TriggerClientEvent("Notify2",source,"#cloAdd",{msg=Name})
				else
					TriggerClientEvent("Notify",source,"amarelo","Nome escolhido já existe em seu armário.",5000)
					-- TriggerClientEvent("Notify2",source,"#nameAELocker")
				end
			end
		elseif Split[1] == "delete" then
			if Consult[Name] ~= nil then
				Consult[Name] = nil
				vRP.SetSrvData("Wardrobe:"..Passport,Consult)
				TriggerClientEvent("propertys:ClothesReset",source)
				TriggerClientEvent("Notify",source,"verde","<b>"..Name.."</b> removido.",5000)
				-- TriggerClientEvent("Notify2",source,"#cloRemoved",{msg=Name})
			else
				TriggerClientEvent("Notify",source,"amarelo","A vestimenta salva não se encontra mais em seu armário.",5000)
				-- TriggerClientEvent("Notify2",source,"#cloGonne")
			end
		elseif Split[1] == "apply" then
			if Consult[Name] ~= nil then
				TriggerClientEvent("skinshop:Apply",source,Consult[Name])
				TriggerClientEvent("Notify",source,"verde","<b>"..Name.."</b> aplicado.",5000)
				-- TriggerClientEvent("Notify2",source,"#skinApllyed",{msg=Name})
			else
				TriggerClientEvent("Notify",source,"amarelo","A vestimenta salva não se encontra mais em seu armário.",5000)
				-- TriggerClientEvent("Notify2",source,"#cloGonne")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYSSERIALS
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertysSerials()
	local Serial = vRP.GenerateString("LDLDLDLDLD")
	local Consult = vRP.Query("propertys/Serial",{ serial = Serial })
	if Consult[1] then
		PropertysSerials()
	end

	return Serial
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.OpenChest(Name,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Chest = {}
		local Consult = vRP.GetSrvData(Mode..":"..Name)

		for Index,v in pairs(Consult) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["weight"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = tonumber(Index)

			local Split = splitString(v["item"],"-")
			if Split[2] ~= nil then
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

			table.insert(Chest,v)
		end

		local Exist = vRP.Query("propertys/Exist",{ name = Name })
		if Exist[1] then
			return Chest,vRP.ChestWeight(Consult),Exist[1][Mode]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.Store(Item,Slot,Amount,Target,Name,Mode)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

        if IsBlackListed(Item) then
            TriggerClientEvent("Notify",source,"vermelho","Você não pode guardar esse item.",5000,"BAU")
			-- TriggerClientEvent("Notify2",source,"#cantStoreItem")
            return
        end

        if (itemType(Item) == "Armamento" or itemType(Item) == "Munição") and vRP.HasGroup(Passport,"Policia") then
            TriggerClientEvent("Notify",source,"vermelho","Você não pode retirar item.",5000,"CHEST")
			-- TriggerClientEvent("Notify2",source,"#noPermissionWithdrawItem")
            return
        end

		if itemBlock(Item) or (Mode == "Vault" and BlockChest(Item)) or (Mode == "Fridge" and not BlockChest(Item)) then
			TriggerClientEvent("propertys:Update",source)
			return
		end

		local Consult = vRP.Query("propertys/Exist",{ name = Name })
		if Consult[1] then
			if Item == "diagram" then
				if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
					vRP.Query("propertys/"..Mode,{ name = Name, weight = 10 * Amount })
					TriggerClientEvent("propertys:Update",source)
				end
			else
				if vRP.StoreChest(Passport,Mode..":"..Name,Amount,Consult[1][Mode],Slot,Target) then
					TriggerClientEvent("propertys:Update",source)
				else
					local Result = vRP.GetSrvData(Mode..":"..Name)
					TriggerClientEvent("propertys:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Consult[1][Mode])
					exports["vrp"]:SendWebHook("bau-casa", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Colocou:** " .. Item .. " \n**Quantidade:** " .. Amount .. "\n**Casa:** " .. Name .. "\n**Data:** " .. os.date("%d/%m/%Y - %H:%M:%S"), 9317187)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.Take(Slot,Amount,Target,Name,Mode)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeChest(Passport,Mode..":"..Name,Amount,Slot,Target) then
			TriggerClientEvent("propertys:Update",source)
		else
			local Consult = vRP.Query("propertys/Exist",{ name = Name })
			if Consult[1] then
				local Result = vRP.GetSrvData(Mode..":"..Name)
				TriggerClientEvent("propertys:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Consult[1][Mode])
				-- exports["vrp"]:SendWebHook("bau-casa", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Retirou o Item:** " .. Item .. " \n**Quantidade:** " .. Amount .. "\n**Casa:** " .. Name .. "\n**Data:** " .. os.date("%d/%m/%Y - %H:%M:%S"), 9317187)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function PropertiesAPI.Update(Slot,Target,Amount,Name,Mode)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.UpdateChest(Passport,Mode..":"..Name,Slot,Target,Amount) then
			TriggerClientEvent("propertys:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function Route(Name)
    if CheckAppartment(Name) then
        local Split = splitString(Name,"|")
        return parseInt(100000 + Split[2])
    end
	local Split = splitString(Name,"propertys")

	return parseInt(100000 + Split[2])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Inside[Passport] then
		vRP.InsidePropertys(Passport,Propertys[Inside[Passport]])
		Inside[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local Consult = vRP.Query("propertys/User",{ Passport = Passport })
	if parseInt(#Consult) > 0 then
		TriggerClientEvent("propertys:HomeBlips",source,Consult)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Consult = vRP.Query("propertys/All")
	for Index,v in pairs(Consult) do
        local Name = v["Name"]
        local Tax = v["Tax"]
		Markers[Name] = true
        if os.time() > Tax + 86400 then
            vRP.RemSrvData("Vault:"..Name)
            vRP.RemSrvData("Fridge:"..Name)
            vRP.Query("propertys/Sell",{ name = Name })
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
local Pelado = {
    ["mp_m_freemode_01"] = {
        ["pants"] = { item = 131, texture = 0 },      
        ["vest"] = { item = 0, texture = 0 },       
        ["decals"] = { item = 0, texture = 0 },     
        ["shoes"] = { item = 34, texture = 0 },      
        ["tshirt"] = { item = 6, texture = 0 }, 
		["accessory"] = { item = 0, texture = 0 }, 
		["torso"] = { item = 15, texture = 0 },    
        ["watch"] = { item = -1, texture = 0 },
        ["arms"] = { item = 15, texture = 0 }
    },
    ["mp_f_freemode_01"] = {
		["pants"] = { item = 21, texture = 0 },      
        ["decals"] = { item = 0, texture = 0 },     
        ["shoes"] = { item = 35, texture = 0 }, 
		["vest"] = { item = 0, texture = 0 }, 
		["accessory"] = { item = 0, texture = 0 },     
        ["torso"] = { item = 82, texture = 0 },    
        ["tshirt"] = { item = 3, texture = 0 },    
        ["watch"] = { item = -1, texture = 0 },
        ["arms"] = { item = 15, texture = 0 }
    }
}

RegisterCommand("pelado",function(source,Message,History)
	local Passport = vRP.Passport(source)
    if Passport then
        if Inside[Passport] then
            local Model = vRP.ModelPlayer(source)
			if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,Pelado[Model])
            else
                TriggerClientEvent("Notify",source,"vermelho","Modelo invalido.",5000,"casas")
				-- TriggerClientEvent("Notify2",source,"#invalidModel")
			end
        else
            TriggerClientEvent("Notify",source,"vermelho","Voce precisa estar dentro de uma residencia para realizar este comando.",5000,"casas")
			-- TriggerClientEvent("Notify2",source,"#insideHouseCommand")
        end
    end
end)

function PropertiesAPI.GetMarkers()
    return Markers
end

function GenerateAppartment(Name)
    local Query = vRP.Query("propertys/GetAppartments", { Name = Name })
    local NewName = ""
    if Query[1] then
        local Number = Query[1]["Number"]
        NewName = Name .. "|" .. Number + 1
        return NewName
    else
        NewName = Name .. "|1"
    end
    return NewName
end

function PropertiesAPI.GetAppartments(Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
        local Consult = vRP.Query("propertys/GetMaxAppartments",{ Name = Name })
        if Consult[1] then
            return Consult[1]["Number"]
        end
	end
end

function PropertiesAPI.GetAppartmentInterior(Name)
    local Query = vRP.Query("propertys/Exist", { name = Name })
    if Query and Query[1] then
        return Query[1]["Interior"]
    end
end
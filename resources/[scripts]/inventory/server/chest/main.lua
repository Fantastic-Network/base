local ChestAPI = {}
Tunnel.bindInterface("inventory/chest", ChestAPI)
local vKEYBOARD = Tunnel.getInterface("keyboard")
vCLIENTCHEST = Tunnel.getInterface("inventory/chest")
cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = {}
local CustomChests = {}
local CustomPerm = {}
local CityRequests = {
    ["Base"] = "SEU LINK AQUI",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function ChestAPI.Permissions(Name,Mode,Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Wanted(Passport) then
		if Mode == "Personal" then
			Open[Passport] = { ["Name"] = Passport, ["Weight"] = 50, ["Logs"] = false, ["Save"] = true, ["Number"] = Number }
			return true
		elseif Mode == "Evidences" and vRP.HasGroup(Passport,"Policia") then
			local Keyboard = vKEYBOARD.keySingle(source,"Passaporte:")
			if Keyboard then
				Open[Passport] = { ["Name"] = "Evidences:"..Keyboard[1], ["Weight"] = 50, ["Logs"] = false, ["Save"] = true, ["Number"] = Number  }
				return true
			end
		elseif Mode == "Custom" then
            if hasPermissionChest(Passport,Name) then
                local Info = getCustomChest(Name)
                if Info and Info["Weight"] then
                    Open[Passport] = { ["Name"] = Name, ["Weight"] = Info["Weight"], ["Logs"] = false, ["Save"] = false, ["Number"] = Number }
                    return true
                end
            end
		else
			if Name == "trayShot" or Name == "trayDesserts" or Name == "trayPizza" or Name == "trayBean" then
				Open[Passport] = { ["Name"] = Name, ["Weight"] = 15, ["Logs"] = false, ["Save"] = true, ["Number"] = Number }
				return true
			end

			local Split = splitString(Name,"-")
			local Consult = vRP.Query("chests/GetChests",{ name = Split[1] })
			if not Consult[1] then
				vRP.Query("chests/InsertChest",{ name = Split[1], weight = 5000, perm = Split[1], logs = 1 })
				Consult = vRP.Query("chests/GetChests",{ name = Split[1] })
			end

			if Split[2] and not (vRP.HasPermission(Passport,Consult[1]["perm"],parseInt(Split[2])) or vRP.HasGroup(Passport,"Admin",3)) then
				return false
			end

			if Consult[1] and vRP.HasGroup(Passport,Consult[1]["perm"]) or vRP.HasGroup(Passport,"Admin",3) then
				local TotalWeight = Consult[1]["weight"]

				local Consult = vRP.Query("painel/getallVip",{ name = Split[1] })
				if Consult[1] and parseInt(Consult[1]["level"]) >= 1 then
					if parseInt(Consult[1]["level"]) == 1 then
						TotalWeight = TotalWeight + 20000
					elseif parseInt(Consult[1]["level"]) == 2 then
						TotalWeight = TotalWeight + 15000
					else
						TotalWeight = TotalWeight + 10000
					end
				end
                if string.find(Name,"Mansao") then
                    TotalWeight = 20000
                end
				Open[Passport] = { ["Name"] = Name, ["Weight"] = TotalWeight, ["Logs"] = true, ["Save"] = true, ["Number"] = Number }
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function ChestAPI.Chest()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		local Chest = {}
		local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
		for Index,v in pairs(Result) do
			v["amount"] = parseInt(v["amount"])
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

		return Chest,vRP.ChestWeight(Result),Open[Passport]["Weight"]	
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local OpenItens = {
	["mechanicpass"] = {
		["Open"] = "Mechanic",
		["Table"] = {
			{ ["Item"] = "advtoolbox", ["Amount"] = 1 },
			{ ["Item"] = "toolbox", ["Amount"] = 2 },
			{ ["Item"] = "tyres", ["Amount"] = 4 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["uwucoffeepass"] = {
		["Open"] = "UwuCoffee",
		["Table"] = {
			{ ["Item"] = "nigirizushi", ["Amount"] = 3 },
			{ ["Item"] = "sushi", ["Amount"] = 3 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["pizzathispass"] = {
		["Open"] = "PizzaThis",
		["Table"] = {
			{ ["Item"] = "nigirizushi", ["Amount"] = 3 },
			{ ["Item"] = "sushi", ["Amount"] = 3 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["burgershotpass"] = {
		["Open"] = "BurgerShot",
		["Table"] = {
			{ ["Item"] = "hamburger2", ["Amount"] = 1 },
			{ ["Item"] = "cookedfishfillet", ["Amount"] = 1 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["paramedicpass"] = {
		["Open"] = "Paramedic",
		["Table"] = {
			{ ["Item"] = "gauze", ["Amount"] = 3 },
			{ ["Item"] = "medkit", ["Amount"] = 1 },
			{ ["Item"] = "analgesic", ["Amount"] = 4 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function ChestAPI.Store(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end

		if itemBlock(Item) then
			TriggerClientEvent("chest:Update",source,"Refresh")

			return true
		end

        if IsBlackListed(Item) then
            TriggerClientEvent("Notify",source,"vermelho","Você não pode guardar esse item.",5000,"BAU")
			-- TriggerClientEvent("Notify2",source,"#cantStoreItem")
            return
        end

        if Open[Passport] and Open[Passport]["Number"] then
            local Selected = Open[Passport]["Number"]
            if Chests[Selected] and Chests[Selected]["Perms"] then
                local Split = splitString(Open[Passport]["Name"],"-")
                local Number = vRP.HasPermission(Passport,Split[1])
                if Chests[Selected]["Perms"] and Chests[Selected]["Perms"]["Store"] then
                    if Number > Chests[Selected]["Perms"]["Store"] then
                        TriggerClientEvent("chest:Update",source,"Refresh")
                        TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para retirar esse item.",5000,"BAU")
                        -- TriggerClientEvent("Notify2",source,"#noPermissionWithdrawItem")
                        return
                    end
                end
            end
        end

		if OpenItens[Item] and OpenItens[Item]["Open"] == Open[Passport]["Name"] then
			if vRP.TakeItem(Passport,Item,1) then
				for _,v in pairs(OpenItens[Item]["Table"]) do
					vRP.GenerateItem(Passport,v["Item"],v["Amount"])
				end
			end

			TriggerClientEvent("chest:Update",source,"Refresh")

			return true
		end

        if (itemType(Item) == "Armamento" or itemType(Item) == "Munição") and vRP.HasGroup(Passport,"Policia") and splitString(Open[Passport]["Name"],"-")[1] == "POLICIA" then
            TriggerClientEvent("Notify",source,"vermelho","Você não pode colocar esse item nesse bau.",5000,"BAU")
			-- TriggerClientEvent("Notify2",source,"#cantStoreItemInChest")
            return true
        end

		if vRP.StoreChest(Passport,"Chest:"..Open[Passport]["Name"],Amount,Open[Passport]["Weight"],Slot,Target) then
			TriggerClientEvent("chest:Update",source,"Refresh")
		else
			local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
			TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])
			exports["vrp"]:SendWebHook("colocar-item-bau","**Passaporte:** "..Passport.. " ".. vRP.FullName(Passport) .. "\n**Guardou:** "..Amount.."x "..itemName(Item).. "\n**Baú:** "..Open[Passport]["Name"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187,{Passport})
            local Chest = Open[Passport]["Name"]
            if CustomPerm[Chest] then
				exports["vrp"]:SendWebHook(Open[Passport]["Name"],"**Passaporte:** "..Passport.. " " .. vRP.FullName(Passport) .."\n**Guardou:** "..Amount.."x "..itemName(Item).. "\n**Baú:** "..Open[Passport]["Name"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187,{Passport})
            end
			if Open[Passport]["Logs"] then
				exports["vrp"]:SendWebHook(Open[Passport]["Name"],"**Passaporte:** "..Passport.. " " .. vRP.FullName(Passport) .."\n**Guardou:** "..Amount.."x "..itemName(Item).. "\n**Baú:** "..Open[Passport]["Name"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187,{Passport})
			end
            local Identity = vRP.Identity(Passport)
            if Identity then
                local Account = vRP.Account(Identity["license"])
                if Account["discord"] then
                    PerformHttpRequest(CityRequests[cityName],function(err,text,headers)
                        --
                    end,"POST",json.encode({
                        ID = Passport.. " " ..vRP.FullName(Passport),
                        Acao = "Colocado",
                        Item = Amount.."x "..itemName(Item),
                        Bau = Open[Passport]["Name"],
                        Discord = Account["discord"],
                        Cidade = cityName,
                    }),{ ["Content-Type"] = "application/json" })
                end
            end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function ChestAPI.Take(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end
        if Open[Passport] and Open[Passport]["Number"] then
            local Selected = Open[Passport]["Number"]
            if Chests[Selected] and Chests[Selected]["Perms"] then
                local Split = splitString(Open[Passport]["Name"],"-")
                local Number = vRP.HasPermission(Passport,Split[1])
                if Chests[Selected]["Perms"] and Chests[Selected]["Perms"]["Take"] then
                    if Number > Chests[Selected]["Perms"]["Take"] then
                        TriggerClientEvent("chest:Update",source,"Refresh")
                        TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para retirar esse item.",5000,"BAU")
                        -- TriggerClientEvent("Notify2",source,"#noPermissionWithdrawItem")
                        return
                    end
                end
            end
        end
		if vRP.TakeChest(Passport,"Chest:"..Open[Passport]["Name"],Amount,Slot,Target) then
			TriggerClientEvent("chest:Update",source,"Refresh")
		else
			local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
			TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])

			if string.sub(Open[Passport]["Name"],1,9) == "Helicrash" and vRP.ChestWeight(Result) <= 0 then
				TriggerClientEvent("chest:Close",source)
				exports["helicrash"]:Box()
			end
			exports["vrp"]:SendWebHook("retirar-item-bau","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .."\n**Retirou:** "..Amount.."x "..itemName(Item).. "\n**Baú:** "..Open[Passport]["Name"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187,{Passport})
            local Chest = Open[Passport]["Name"]
            if CustomPerm[Chest] then
				exports["vrp"]:SendWebHook(Open[Passport]["Name"],"**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .."\n**Retirou:** "..Amount.."x "..itemName(Item).. "\n**Baú:** "..Open[Passport]["Name"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187,{Passport})
            end
			if Open[Passport]["Logs"] then
				exports["vrp"]:SendWebHook(Open[Passport]["Name"],"**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .."\n**Retirou:** "..Amount.."x "..itemName(Item).. "\n**Baú:** "..Open[Passport]["Name"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187,{Passport})
			end
            local Identity = vRP.Identity(Passport)
            if Identity then
                local Account = vRP.Account(Identity["license"])
                if Account["discord"] then
                    PerformHttpRequest(CityRequests[cityName],function(err,text,headers)
                        --
                    end,"POST",json.encode({
                        ID = Passport.. " " ..vRP.FullName(Passport),
                        Acao = "Retirado",
                        Item = Amount.."x "..itemName(Item),
                        Bau = Open[Passport]["Name"],
                        Discord = Account["discord"],
                        Cidade = cityName,
                    }),{ ["Content-Type"] = "application/json" })
                end
            end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function ChestAPI.Update(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end

		if vRP.UpdateChest(Passport,"Chest:"..Open[Passport]["Name"],Slot,Target,Amount) then
			TriggerClientEvent("chest:Update",source,"Refresh")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPGRADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chest:Upgrade")
AddEventHandler("chest:Upgrade",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,Name) then
			if vRP.Request(source,"Aumentar <b>10Kg</b> por <b>$200.000</b> dólares?","Sim, efetuar pagamento","Não, decido depois") then
				if vRP.PaymentFull(Passport,200000) then
					vRP.Query("chests/UpdateChests",{ name = Name })
					TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
					-- TriggerClientEvent("Notify2",source,"#completedPurchase")
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					-- TriggerClientEvent("Notify2",source,"#semdoletas")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Open[Passport] then
		Open[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
--{ ["Name"] = "Policia-1", ["Coords"] = vec3(437.49,-994.6,30.68), ["Mode"] = "1" },
RegisterCommand("newchest",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin", 3) then
            local Keyboard = vKEYBOARD.keyTriple(source,"Nome do baú:","Dono:","Peso:")
            if Keyboard and Keyboard[1] then
                Wait(250)
                local Ped = GetPlayerPed(source)
                local Coords = GetEntityCoords(Ped)
                Coords = tD(Coords.x)..","..tD(Coords.y)..","..tD(Coords.z)
                vRP.Query("chests/InsertCustomChest",{ name = Keyboard[1], owner = parseInt(Keyboard[2]), weight = parseInt(Keyboard[3]), coords = Coords })
                local Table = {
                    ["Name"] = Keyboard[1],
                    ["Coords"] = Coords,
                    ["Weight"] = parseInt(Keyboard[3]),
                    ["Mode"] = "Custom",
                    ["Owner"] = parseInt(Keyboard[2])
                }
                CustomPerm[Keyboard[1]] = {}
                table.insert(CustomChests,Table)
                TriggerClientEvent("Notify",source,"verde","Baú criado com sucesso.",5000,"Bau")
				-- TriggerClientEvent("Notify2",source,"#chestCreated")
                TriggerClientEvent("chest:Add",-1,Table)
                TriggerEvent("mansion_alarm:Add")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("removechest",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keySingle(source,"Nome do baú:")
            if Keyboard and Keyboard[1] then
                vRP.Query("chests/RemoveCustomChest",{ name = Keyboard[1] })
                for k,v in pairs(CustomChests) do
                    if v.Name == Keyboard then
                        table.remove(CustomChests,k)
                        TriggerClientEvent("chest:Remove",-1,Keyboard[1])
                        TriggerClientEvent("Notify",source,"verde","Baú removido com sucesso.",5000,"Bau")
						-- TriggerClientEvent("Notify2",source,"#chestRemoved")
                        break
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("getperm",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        local Keyboard = vKEYBOARD.keySingle(source,"Nome do baú:")
        if Keyboard and Keyboard[1] then
            local ChestInfo = getCustomChest(Keyboard[1])
            if ChestInfo then
                if vRP.HasGroup(Passport,"Admin",3) or ChestInfo["Owner"] == Passport then
                    local Message = "Permissões do baú: "..Keyboard[1]
                    print(json.encode(CustomPerm[Keyboard[1]]))
                    for k,v in pairs(CustomPerm[Keyboard[1]]) do
                        Message = Message.."<br> Passaporte: "..k
                    end
                    TriggerClientEvent("Notify",source,"verde",Message,5000,"Bau")
					-- TriggerClientEvent("Notify2",source,"#msgChest",{msg=Message})
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addperm",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        local Keyboard = vKEYBOARD.keySingle(source,"Nome do baú:")
        if Keyboard and Keyboard[1] then
            local ChestInfo = getCustomChest(Keyboard[1])
            if ChestInfo then
                if vRP.HasGroup(Passport,"Admin",3) or ChestInfo["Owner"] == Passport then
                    Wait(250)
                    local Keyboard2 = vKEYBOARD.keySingle(source,"Passaporte:")
                    if Keyboard2 and Keyboard2[1] then
                        CustomPerm[Keyboard[1]][tostring(Keyboard2[1])] = true
                        Wait(100)
                        vRP.Query("chests/UpdatePermChests",{ name = Keyboard[1], permission = json.encode(CustomPerm[Keyboard[1]]) })
                        TriggerClientEvent("Notify",source,"verde","Permissão adicionada com sucesso.",5000,"Bau")
						-- TriggerClientEvent("Notify2",source,"#addedPermission")
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remperm",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        local Keyboard = vKEYBOARD.keySingle(source,"Nome do baú:")
        if Keyboard and Keyboard[1] then
            local ChestInfo = getCustomChest(Keyboard[1])
            if ChestInfo then
                if vRP.HasGroup(Passport,"Admin",3) or ChestInfo["Owner"] == Passport then
                    Wait(250)
                    local Keyboard2 = vKEYBOARD.keySingle(source,"Passaporte:")
                    if Keyboard2 and Keyboard2[1] then
                        CustomPerm[Keyboard[1]][tostring(Keyboard2[1])] = nil
                        Wait(100)
                        vRP.Query("chests/UpdatePermChests",{ name = Keyboard[1], permission = json.encode(CustomPerm[Keyboard[1]]) })
                        TriggerClientEvent("Notify",source,"verde","Permissão removida com sucesso.",5000,"Bau")
						-- TriggerClientEvent("Notify2",source,"#removedPermission")
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- clearperm
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearperm",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        local Keyboard = vKEYBOARD.keySingle(source,"Nome do baú:")
        if Keyboard and Keyboard[1] then
            local ChestInfo = getCustomChest(Keyboard[1])
            if ChestInfo then
                if vRP.HasGroup(Passport,"Admin",3) or ChestInfo["Owner"] == Passport then
                    Wait(250)
                    CustomPerm[Keyboard[1]] = {}
                    Wait(100)
                    vRP.Query("chests/UpdatePermChests",{ name = Keyboard[1], permission = json.encode(CustomPerm[Keyboard[1]]) })
                    TriggerClientEvent("Notify",source,"verde","Permissões resetadas com sucesso.",5000,"Bau")
						-- TriggerClientEvent("Notify2",source,"#removedPermission")
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,Source)
    TriggerClientEvent("chest:Load",Source,CustomChests)
end)
--------------------------------2---------------------------------------------------------------------------------------------------------
-- GET CHEST INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function getCustomChest(Name)
    for i=1,#CustomChests do
        if CustomChests[i]["Name"] == Name then
            return CustomChests[i]
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET CHEST INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function hasPermissionChest(Passport,Name)
    local Permission = false
    if vRP.HasGroup(Passport,"Admin",3) then
        Permission = true
        return true
    end
    for i=1,#CustomChests do
        if CustomChests[i]["Name"] == Name then
            if CustomChests[i]["Owner"] == Passport or CustomPerm[Name][tostring(Passport)] then
                Permission = true
            end
        end
    end
    return Permission
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD CUSTOM CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Query = vRP.Query("chests/GetCustomChests")
    for i=1,#Query do
        local Table = {
            ["Name"] = Query[i]["Name"],
            ["Coords"] = Query[i]["Coords"],
            ["Weight"] = Query[i]["Weight"],
            ["Mode"] = "Custom",
            ["Owner"] = Query[i]["Owner"],
        }
        table.insert(CustomChests,Table)
        CustomPerm[Query[i]["Name"]] = json.decode(Query[i]["permission"])
    end
    Wait(500)
    TriggerClientEvent("chest:Load",-1,CustomChests)
end)

vRP.Prepare("custom_logs/InsertChest","INSERT INTO custom_logs (hook,link) VALUES (@hook,@link) ON DUPLICATE KEY UPDATE link = @link")
vRP.Prepare("custom_logs/GetChests","SELECT * FROM custom_logs")

RegisterCommand("changechestlog",function(source,Message)
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",3) then
        local Chest = vCLIENTCHEST.GetClosestChest(source)
        if Chest then
            if vRP.Request(source,"Deseja alterar a log do bau "..Chest.." ?","Sim, Desejo alterar","Não, decido depois") then
                local Keyboard = vKEYBOARD.keySingle(source,"Link da Log:")
                if Keyboard and Keyboard[1]  then
                    -- vRP.Query("custom_logs/InsertChest",{ hook = Chest, link = Keyboard[1] })
                    exports["vrp"]:UpdateWebHook(Chest,Keyboard[1])
                    TriggerClientEvent("Notify2",source,"#ChangeChestLog")
                end
            end
        end
    end
end)

-- CreateThread(function()
--     Wait(2500)
--     local Query = vRP.Query("custom_logs/GetChests")
--     for i=1,#Query do
--         exports["vrp"]:UpdateWebHook(Query[i]["hook"],Query[i]["link"])
--     end
-- end)
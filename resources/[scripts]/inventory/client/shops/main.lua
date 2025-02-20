-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local ClientShops = {}
Tunnel.bindInterface("inventory/shops",ClientShops)
local vSERVER = Tunnel.getInterface("inventory/shops")
local ShoppingAt = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(1000)
    ModifiedStores = exports['variables']:GetVariable('variables','ModifiedStores') or {}
    for Shop,Data in pairs (ModifiedStores) do
        ShopsConfig[Shop] = Data
    end
    EconomyVar = exports['variables']:GetVariable('variables','ShopBuy') or 1.0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('inventory:CloseAll', function()
	TriggerEvent("inventory:Close")
end)

RegisterNetEvent('register:Open')
AddEventHandler('register:Open', function()
	TriggerEvent("inventory:Close")
	SetNuiFocus(false,false)
end)

local function openShop(shop)
	ShoppingAt = shop
	toggleInventory("shop")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(Data,Callback)
	if not ShoppingAt then
		return
	end
    local inventoryShop = {}
    local shopSlots = ShopsConfig[ShoppingAt["tag"]]["Slots"] or 20
    local shopStock = false
    if ShopsConfig[ShoppingAt["tag"]]["name"] then
        shopStock = vSERVER.GetShopStock(ShoppingAt["tag"])
    end
    for k,v in pairs(ShopsConfig[ShoppingAt["tag"]]["List"]) do
        if shopStock then
            table.insert(inventoryShop,{
                key = k,
                price = parseInt(v*EconomyVar),
                stock = shopStock[k] or 0
            })
        else
            table.insert(inventoryShop,{
                key = k,
                price = parseInt(v*EconomyVar)
            })
        end
    end
	for k,v in pairs(inventoryShop) do
		inventoryShop[k]["slot"] = k
		inventoryShop[k]["amount"] = 1
		inventoryShop[k]["name"] = itemName(v["key"])
		inventoryShop[k]["weight"] = itemWeight(v["key"])
		inventoryShop[k]["index"] = itemIndex(v["key"])
		inventoryShop[k]["max"] = itemMaxAmount(v["key"])
		inventoryShop[k]["desc"] = v["desc"] or itemDescription(v["key"])
		inventoryShop[k]["economy"] = itemEconomy(v["key"])
		-- 
		inventoryShop[k]["premium"] = ShoppingAt["tag"] == "Premium" or ShoppingAt["tag"] == "Premium2"
	end
	Callback({ items = inventoryShop, type = "shop", slots = shopSlots })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupSlotShop",function(Data, Callback)
	vSERVER._functionShops(ShoppingAt.tag, Data["item"], Data["amount"], Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropSlotShop",function(Data, Callback)
	vSERVER._functionShops(ShoppingAt.tag, Data["item"], Data["amount"], Data["slot"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlotShops",function(Data,Callback)
	--TriggerServerEvent("shops:populateSlot",Data["item"],Data["slot"],Data["target"],Data["amount"])
	--
	--Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlotShop",function(Data,Callback)
	--TriggerServerEvent("shops:updateSlot",Data["item"],Data["slot"],Data["target"],Data["amount"])
	--
	--Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function ClientShops.updateShops(action)
	SendNUIMessage({ action = "updateInventory" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPLIST
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Table = {}

    for _,v in pairs(shopList) do
        table.insert(Table,{ v[1],v[2],v[3],1.25,"E","Loja","Pressione para abrir" })
    end

    TriggerEvent("hoverfy:Insert",Table)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()

			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for _,v in pairs(shopList) do
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 1.25 then
						TimeDistance = 1
                        --and not exports["hud"]:Wanted()
						if IsControlJustPressed(1,38)  then
                            if ShopsConfig[v[4]]["perm"] ~= nil then
                                if not vSERVER.requestPerm(v[4]) then
                                    return
                                end
                            end
							openShop({
								tag = v[4],
								type = ShopsConfig[v[4]]["Type"]
							})

							if v[5] then
								TriggerEvent("sounds:Private","shop",0.5)
							end
						end
					end
				end
			end

		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:openSystem:NPC",function(Perm)
	if LocalPlayer["state"]["Route"] < 900000 then
		if not exports["hud"]:Wanted() and vSERVER.requestPerm(Perm) then
			openShop({
				tag = Perm,
				type = ShopsConfig[Perm]["Type"]
			})
		end
        TriggerEvent("talknpc:closeTalkWSound")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = "coffeeMachine",
			type = "Buy"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = "sodaMachine",
			type = "Buy"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = "donutMachine",
			type = "Buy"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = "burgerMachine",
			type = "Buy"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = "hotdogMachine",
			type = "Buy"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:CHIHUAHUA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Chihuahua",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = "Chihuahua",
			type = "Buy"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = "waterMachine",
			type = "Buy"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEDICBAG
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:medicBag",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		if not exports["hud"]:Wanted() and vSERVER.requestPerm("Paramedic") then
			openShop({
				tag = "Paramedic",
				type = "Buy"
			})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Fuel",function()
	openShop({
		tag = "Fuel",
		type = "Buy"
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:Diamantes
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:OpenShop",function(tag)
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = tag,
			type = "Buy"
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAMANTES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("diamantes",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		openShop({
			tag = "Premium",
			type = "Buy"
		})
	end
end)

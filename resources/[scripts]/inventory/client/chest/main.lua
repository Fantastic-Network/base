local vSERVER = Tunnel.getInterface("inventory/chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Labels = {
	["1"] = {
		{
			event = "chest:Open",
			label = "Compartimento Geral",
			tunnel = "shop",
			service = "Normal"
		},{
			event = "chest:Upgrade",
			label = "Aumentar",
			tunnel = "server"
		}
	},
	["2"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "shop",
			service = "Normal"
		},{
			event = "chest:Upgrade",
			label = "Aumentar",
			tunnel = "server"
		}
	},
	["3"] = {
		{
			event = "chest:Open",
			label = "Bandeja",
			tunnel = "shop",
			service = "Normal"
		}
	},
	["4"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "shop",
			service = "Custom"
		}
	},
	["Custom"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "shop",
			service = "Custom"
		}
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Chests = exports["variables"]:GetChests()
	for Name,v in pairs(Chests) do
		exports["target"]:AddCircleZone("Chest:"..Name,v["Coords"],1.0,{
			name = "Chest:"..Name,
			heading = 3374176
		},{
			Distance = 1.5,
			shop = {v["Name"],Name},
			options = Labels[v["Mode"]],
            number = Name
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:Open",function(Name,Init,Number)
    if LocalPlayer["state"]["PVP"] then
        return
    end
    if GlobalState["Restarting"] then
        return false
    end
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.Permissions(Name[1],Init,Name[2]) then
			toggleInventory("chest")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CloseAll",function()
	TriggerEvent("inventory:Close")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupSlotChest",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
	vSERVER.Take(Data["item"],Data["slot"],Data["amount"],Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropSlotChest",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
	vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlotChest",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
	vSERVER.Update(Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestUpgradeChest",function(Data,Callback)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if GlobalState["Restarting"] then
        return false
    end
    local Chest,chestPeso,chestMaxpeso = vSERVER.Chest()
    if not Chest then
        return
    end
    for k,v in pairs(Chest) do
        Chest[k]["name"] = itemName(v["item"])
        Chest[k]["weight"] = itemWeight(v["item"])
        Chest[k]["index"] = itemIndex(v["item"])
        Chest[k]["max"] = itemMaxAmount(v["item"])
        Chest[k]["economy"] = parseFormat(itemEconomy(v["item"]))
        Chest[k]["desc"] = itemDescription(v["item"])
    end
	Callback({ items = Chest, type = "chest", weight = {
		current = chestPeso,
		max = chestMaxpeso
	}})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Update")
AddEventHandler("chest:Update",function(action,invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ action = "updateInventory" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Close")
AddEventHandler("chest:Close",function(Action)
	toggleInventory(nil)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:LOAD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Load")
AddEventHandler("chest:Load",function(Table)
    local Hoverfy = {}
    for i=1,#Table do
        Table[i]["Coords"] = toVector3(Table[i]["Coords"])
        exports["target"]:AddCircleZone("Chest:"..Table[i]["Name"],Table[i]["Coords"],1.0,{
            name = "Chest:"..Table[i]["Name"],
            heading = 3374176
        },{
            Distance = 1.5,
            shop = {Table[i]["Name"]},
            options = Labels[Table[i]["Mode"]]
        })
        table.insert(Hoverfy,{ Table[i]["Coords"]["x"],Table[i]["Coords"]["y"],Table[i]["Coords"]["z"],1.25,"Alt","Baú","Utilize o target" })
        table.insert(Chests,Table[i])
    end
    TriggerEvent("hoverfy:Insert",Hoverfy)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Add")
AddEventHandler("chest:Add",function(Table)
    local Hoverfy = {}
    Table["Coords"] = toVector3(Table["Coords"])
    table.insert(Chests,Table)
    exports["target"]:AddCircleZone("Chest:"..Table["Name"],Table["Coords"],1.0,{
        name = "Chest:"..Table["Name"],
        heading = 3374176
    },{
        Distance = 1.5,
        shop = {Table["Name"]},
        options = Labels[Table["Mode"]]
    })
    table.insert(Hoverfy,{ Table["Coords"][1],Table["Coords"][2],Table["Coords"][3],1.25,"Alt","Baú","Utilize o target" })
    TriggerEvent("hoverfy:Insert",Hoverfy)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Remove")
AddEventHandler("chest:Remove",function(Name)
    for k,v in pairs(Chests) do
        if v["Name"] == Name then
            table.remove(Chests,k)
            exports["target"]:RemoveCircleZone("Chest:"..Name)
            break
        end
    end
end)


function GetClosestChest()
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    local Closest = nil
    local ClosestDistance = 100
	for Name,v in pairs(Chests) do
        local Distance = #(Coords - v["Coords"])
        if Distance < ClosestDistance then
            Closest = v["Name"]
            ClosestDistance = Distance
        end
    end
    return Closest
end

function GetClosestChestTable(Table)
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    local Closest = nil
    local ClosestDistance = 100
	for _,Number in pairs(Table) do
        local v = Chests[Number]
        local Distance = #(Coords - v["Coords"])
        if Distance < ClosestDistance then
            Closest = Number
            ClosestDistance = Distance
        end
    end
    return Closest
end


function GetClosestChests()
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    local Closest = {}
    local ClosestDistance = 50
	for Name,v in pairs(Chests) do
        local Distance = #(Coords - v["Coords"])
        if Distance < ClosestDistance then
            table.insert(Closest,Name)
        end
    end
    return Closest
end

RegisterCommand("bau",function()
    local ClosestChests = GetClosestChests()
    local Cached = ClosestChests
    if GlobalState["Restarting"] then
        return false
    end
    for i=1,#ClosestChests do
        local Number = ClosestChests[i]
        local Selected = GetClosestChestTable(Cached)
		if vSERVER.Permissions(Chests[Selected]["Name"],Init,Selected) then
			toggleInventory("chest")
            return
        else
            table.remove(Cached,Number)
		end
    end
end)

function CreativeChest.GetClosestChest()
    return GetClosestChest()
end
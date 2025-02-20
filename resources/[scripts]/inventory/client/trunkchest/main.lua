-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local vSERVER = Tunnel.getInterface("inventory/trunkchest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Trunk",function()
    local Vehicle,Network,Plate = vRP.VehicleList(3)
    local Ped = PlayerPedId()
    if GlobalState["Restarting"] then
        return false
    end
    if LocalPlayer["state"]["PVP"] then
        return
    end
    if GetEntityHealth(Ped) <= 101 then
        return
    end
    if Network and not IsPedInAnyVehicle(Ped) then
        vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
        TriggerServerEvent("trunkchest:openTrunk",{ Plate,vRP.VehicleModel(Vehicle),Vehicle,Network })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Trunk","Abrir o porta-malas.","keyboard","PAGEUP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CloseAll", function(Tag)
	TriggerEvent("inventory:Close")
    if Open == "trunk" then
	    vSERVER.chestClose()
        Open = false
    end
    vRP.stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:Open")
AddEventHandler("trunkchest:Open",function()
    if LocalPlayer["state"]["PVP"] then
        return
    end
    -- if not LocalPlayer["state"]["Active"] then
    --     return
    -- end
    -- if LocalPlayer["state"]["InSafeZone"] or LocalPlayer["state"]["PVP"] then
    --     TriggerEvent("Notify","vermelho","Não é possivel abrir o porta-malas em safezones.",5000,"porta-mala")
    --     return
    -- end
    vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
    toggleInventory("trunk")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupSlotTrunk",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end

	vSERVER.takeItem(Data["slot"],Data["amount"],Data["target"])
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropSlotTrunk",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end

	vSERVER.storeItem(Data["item"],Data["slot"],Data["amount"],Data["target"])
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlotTrunk",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end

	vSERVER.updateChest(Data["slot"],Data["target"],Data["amount"])
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestTrunk",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] or LocalPlayer["state"]["PVP"] then
        return
    end
	local myChest,chestPeso,chestMaxpeso = vSERVER.openChest()
	if not myChest then
        return 
	end
    for k,v in pairs(myChest) do
        myChest[k]["name"] = itemName(v["item"])
        myChest[k]["weight"] = itemWeight(v["item"])
        myChest[k]["index"] = itemIndex(v["item"])
        myChest[k]["max"] = itemMaxAmount(v["item"])
        myChest[k]["economy"] = parseFormat(itemEconomy(v["item"]))
        myChest[k]["desc"] = itemDescription(v["item"])
    end
	Callback({ items = myChest, type = "trunk", slots = 100, weight = {
        current = chestPeso,
        max = chestMaxpeso
    }})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- collectAllInspect
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("collectAllTrunk",function(Data,Callback)
	vSERVER.TakeAll()
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("collectSomeTrunk",function(Data,Callback)
	vSERVER.TakeAll(true)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:Update")
AddEventHandler("trunkchest:Update",function(action)
    if not LocalPlayer["state"]["Active"] then
        return
    end
	SendNUIMessage({ action = "updateInventory" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:UpdateWeight")
AddEventHandler("trunkchest:UpdateWeight",function(invPeso,invMaxpeso,chestPeso,chestMaxpeso)
    if not LocalPlayer["state"]["Active"] then
        return
    end
	SendNUIMessage({ action = "updateInventory" })
end)
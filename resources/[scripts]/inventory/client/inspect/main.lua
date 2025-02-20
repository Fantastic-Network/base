-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local vSERVER = Tunnel.getInterface("inventory/inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CloseAll",function()
	TriggerEvent("inventory:Close")
   --if Open == "inspect" then
        vSERVER.resetInspect()
       -- Open = false
    --end
	Open = false
    vRP.stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestInspect",function(Data,Callback)
	local myChest,chestPeso,chestMaxpeso = vSERVER.openChest()
	if not myChest then
        return
	end
    if GlobalState["Restarting"] then
        return false
    end
    for k,v in pairs(myChest) do
        myChest[k]["name"] = itemName(v["item"])
        myChest[k]["weight"] = itemWeight(v["item"])
        myChest[k]["index"] = itemIndex(v["item"])
        myChest[k]["max"] = itemMaxAmount(v["item"])
        myChest[k]["economy"] = parseFormat(itemEconomy(v["item"]))
        myChest[k]["desc"] = itemDescription(v["item"])
    end
	Callback({ items = myChest, type="inspect", weight = {
		current = chestPeso,
		max = chestMaxpeso
	}})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupSlotInspect",function(Data,Callback)
	vSERVER.takeItem(Data["item"],Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlotInspect",function(Data,Callback)
	vSERVER.updateChest(Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- collectAllInspect
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("collectAllInspect",function(Data,Callback)
	vSERVER.collectAllInspect()
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("collectSomeInspect",function(Data,Callback)
	vSERVER.collectAllInspect(true)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSPECT:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:Open")
AddEventHandler("inspect:Open",function(Entity)
	Open = Entity[2]
	toggleInventory("inspect")
    if LocalPlayer["state"]["Newbie"] then
        TriggerEvent("Notify","vermelho","Você não pode fazer isso no momento.",8000)
		-- TriggerEvent("Notify2","#cantDoAgain")
        return
    end
	CreateThread(function()
		while Open do
			local Return = false
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for _,source in pairs(GetPlayers()) do
				local Player = GetPlayerFromServerId(source)
				if Player ~= PlayerId() and NetworkIsPlayerConnected(Player) then
					local OtherPed = GetPlayerPed(Player)
					if OtherPed == Open then
						local OtherCoords = GetEntityCoords(OtherPed)

						if #(Coords - OtherCoords) <= 1 then
							Return = true
						end
					end
				end
			end

            if not Return then
                toggleInventory(nil)
                vSERVER.resetInspect()
                Open = false
                vRP.stopAnim(false)
            end

			Wait(0)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSPECT:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:Update")
AddEventHandler("inspect:Update",function(Action)
	SendNUIMessage({ action = "updateInventory" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSPECT:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:Close")
AddEventHandler("inspect:Close",function(Action)
	SendNUIMessage({ action = "setVisible", data = false })
	SetNuiFocus(false,false)
	TriggerEvent("hud:Active", true)
	Open = false
    vRP.stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function GetPlayers()
	local Players = {}

	for _,v in ipairs(GetActivePlayers()) do
		Players[#Players + 1] = GetPlayerServerId(v)
	end

	return Players
end
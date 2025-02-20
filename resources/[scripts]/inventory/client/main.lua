Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
cityName = GetConvar("cityName", "Base")
Open = false

CreativeChest = {}
Tunnel.bindInterface("inventory/chest",CreativeChest)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

RegisterNUICallback("hideFrame",function(Data,Callback)
    TriggerEvent("hud:Active",true)
	TriggerEvent("inventory:CloseAll")
	Callback("Ok")
end)

function toggleInventory(tag)
    local toggle = (tag ~= nil)
    if (toggle) then
        Open = tag
        SetCursorLocation(0.5,0.5)
    end
    SendNUIMessage({
        action = "setVisible",
        data = tag or false
    })
	SetNuiFocus(toggle, toggle)
    TriggerEvent("hud:Active", not toggle)
end

RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(status)
	SendNUIMessage({
        action = "addItemNotify",
        data = {
            mode = status[1],
            item = status[2],
            amount = status[3],
            name = status[4]
        }
    })
end)
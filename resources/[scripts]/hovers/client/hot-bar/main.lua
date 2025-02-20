local HotbarAPI = Tunnel.getInterface("inventory/hotbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENHOTBAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+openHotbar",function()
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if not IsPauseMenuActive() and GetEntityHealth(PlayerPedId()) > 100 and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) then
        SendNUIMessage({ page = "hot-bar", action = "showHotbar" })
    end
end)

RegisterCommand("-openHotbar",function()
    SendNUIMessage({ page = "hot-bar", action = "hideHotbar" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("+openHotbar","Manusear a hotbar.","keyboard","TAB")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('getHotbar',function(data,cb)
    local rawData = HotbarAPI.getHotbar()
    local data = {}
    for i=1,#rawData do
        local v = rawData[i]
        data[i] = v
        if (not v["item"]) then
            goto skip
        end
        data[i]["name"] = itemName(v["item"])
        data[i]["peso"] = itemWeight(v["item"])
        data[i]["index"] = itemIndex(v["item"])
        data[i]["max"] = itemMaxAmount(v["item"])
        data[i]["desc"] = itemDescription(v["item"])
        data[i]["economy"] = parseFormat(itemEconomy(v["item"]))
        ::skip::
    end
    async(function()
        cb(data)
    end)
end)
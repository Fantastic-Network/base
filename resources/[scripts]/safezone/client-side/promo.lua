
local info = false
local HidePromo = false
NewbiePromo = false
RegisterNetEvent("Promo")
AddEventHandler("Promo",function(Table)
    info = Table
    SendNUIMessage({
        action = "setVisible",
        data = "safezone"
    })
    Wait(1000)
    SendNUIMessage({ action = "Alerts", data  = { info = info}})
end)

RegisterNetEvent("Promo_newbie")
AddEventHandler("Promo_newbie",function(data)
    if not GlobalState["HasPromo"] then
        NewbiePromo = data
        SendNUIMessage({
            action = "setVisible",
            data = "safezone"
        })
        Wait(1000)
        SendNUIMessage({
            action = "DescriptableAlert",
            data = NewbiePromo
        })
    end
end)

local HelpOpen = true
AddEventHandler("help:open",function()
    if not HidePromo then 
        HelpOpen = not HelpOpen
        if HelpOpen then
            Wait(750)
        end
        if not HelpOpen then
            SendNUIMessage({
                action = "setVisible",
                data = false
            })
        else
            SendNUIMessage({
                action = "setVisible",
                data = "safezone"
            })
        end
    end
end)

RegisterNetEvent("safezone:remPromo")
AddEventHandler("safezone:remPromo",function(Status)
    HidePromo = Status
    if HidePromo then
        SendNUIMessage({
            action = "setVisible",
            data = false
        })
    else
        SendNUIMessage({
            action = "setVisible",
            data = "safezone"
        })
    end
end)

RegisterNetEvent("hud2:remPromo")
AddEventHandler("hud2:remPromo",function()
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
end)



RegisterCommand("hidepromo",function()
    HidePromo = not HidePromo
    if HidePromo then
        SendNUIMessage({
            action = "setVisible",
            data = false
        })
    else
        SendNUIMessage({
            action = "setVisible",
            data = "safezone"
        })
    end
end)

RegisterNUICallback('hideCoupon', function(_, cb)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
end)

RegisterNUICallback('showCoupon', function(_, cb)
    if not HidePromo then
        SendNUIMessage({
            action = "setVisible",
            data = "safezone"
        })
    end
end)
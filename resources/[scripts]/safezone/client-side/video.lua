--RegisterNUICallback("openAdvertisement",function(Data,Callback)
--    if NewbiePromo then
--        return
--    end
--    SendNUIMessage({
--        action = "setVisible",
--        data = "safezone",
--    })
--    SetNuiFocus(false,false)
--end)

local cityName = GetConvar("cityName", "Base")

RegisterNetEvent("promotion_button:open")
AddEventHandler("promotion_button:open",function(URL,Image)
    SendNUIMessage({
        action = "setVisible",
        data = "video",
    })
    SendNUIMessage({
        action = "lockVisibility",
        data = true,
    })
    SendNUIMessage({
        action = "getAdvertisement",
        data = { image = { type = URL, image = Image } },
    })
    SetNuiFocus(true,true)
end)

RegisterNUICallback("openAdvertisement",function(Data,Callback)
    SendNUIMessage({
        action = "lockVisibility",
        data = false,
    })
    Wait(250)
    SendNUIMessage({
        action = "setVisible",
        data = false,
    })
    SetNuiFocus(false,false)
    TriggerEvent("player:OpenURL",Data["type"])
end)

RegisterNUICallback("hideFrame",function(Data,Callback)
    LocalPlayer["state"]["isPlayingRandomPromoVideo"] = false
    SendNUIMessage({
        action = "lockVisibility",
        data = false,
    })
    Wait(250)
    SendNUIMessage({
        action = "setVisible",
        data = false,
    })
    SetNuiFocus(false,false)
end)

RegisterNetEvent("promotion_button:openAdvertisement")
AddEventHandler("promotion_button:openAdvertisement",function(url, isOnlyAtSafezone)
    TriggerEvent("player:OpenURL", 'SEU LINK AQUI')
    -- SendNUIMessage({
    --     action = "setVideo",
    --     data = nil
    -- })
    -- Wait(200)
    -- SendNUIMessage({
    --     action = "setVisible",
    --     data = false,
    -- })
    -- LocalPlayer["state"]["isPlayingRandomPromoVideo"] = false
end)

RegisterNetEvent("promotion_button:OpenAudio")
AddEventHandler("promotion_button:OpenAudio",function(url)
    SendNUIMessage({
        action = "setVisible",
        data = "audio",
    })
    Wait(100)
    SendNUIMessage({
        action = "setAudio",
        data = {
            url = url,
        },
    })
end)
RegisterNetEvent("promotion_button:OpenVideo")
AddEventHandler("promotion_button:OpenVideo",function(url, isOnlyAtSafezone)
    LocalPlayer["state"]["isPlayingRandomPromoVideo"] = true
    local Ped = PlayerPedId()
    local Vehicle = IsPedInAnyVehicle(Ped)
    if LocalPlayer["state"]["InSafeZone"] and not Vehicle then
        SendNUIMessage({
            action = "setVisible",
            data = "video",
        })
        Wait(100)
        SendNUIMessage({
            action = "setVideo",
            data = {
                url = url,
            },
        })
    elseif not isOnlyAtSafezone then
        if exports["request"]:Request("Gostaria de assistir o video?", 30) then
            SendNUIMessage({
                action = "setVisible",
                data = "video",
            })
            Wait(100)
            SendNUIMessage({
                action = "setVideo",
                data = {
                    url = url,
                }
            })
        end
    elseif isOnlyAtSafezone then
        SendNUIMessage({
            action = "setVisible",
            data = "video",
        })
        Wait(100)
        SendNUIMessage({
            action = "setVideo",
            data = {
                url = url,
            }
        })
    end
    SendNUIMessage({
        action = "lockVisibility",
        data = true,
    })
end)
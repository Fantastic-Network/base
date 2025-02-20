-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Client = {}
Tunnel.bindInterface("promoter_score",Client)
vSERVER = Tunnel.getInterface("promoter_score")
vKEYBOARD = Proxy.getInterface("keyboard")
cityName = GetConvar("cityName", "Base")
REQUEST = Proxy.getInterface("request")
FinishPromoter = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local firstActvation = 0
local Timer = GetGameTimer()
function openNui()
    SendNUIMessage({
        action = 'router',
        data = {
            path = '/'
        }
    })
    Wait(1000)
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
end

RegisterNetEvent("promoter_score:Open")
AddEventHandler("promoter_score:Open",function(Type)
    if cityName == "Test" then
        return
    end
    if LocalPlayer["state"]["temporaryBanned"] then
        return
    end
    if not Type then
        firstActivation = 1
        Timer = GetGameTimer()
        CreateThread(function()
            while true do
                if FinishPromoter then
                    break
                end
                if LocalPlayer["state"]["temporaryBanned"] then
                    break
                end
                if firstActivation == 1 and Timer <= GetGameTimer() then
                    local Ok = exports["request"]:Request("Gostaria de avaliar a cidade?", 30)
                    if Ok then
                        Wait(100)
                        openNui()
                    else
                        Timer = GetGameTimer() + 60000*15000
                    end
                end
                Wait(5000)
            end
        end)
    else
        local Ok = exports["request"]:Request("Gostaria de avaliar a cidade?", 30)
        if Ok then
            Wait(100)
            openNui()
        end
    end
end)

RegisterNUICallback('setRate', function(data, cb)
    local Rate = parseInt(data)
    FinishPromoter = true
    if Rate then
        local FeedBack = false
        Wait(2000)
        SendNUIMessage({
            action = 'setVisible',
            data = false
        })
        SetNuiFocus(false,false)
        Wait(1000)
        if Rate >= 9 or Rate <= 6 then
            local Keyboard = exports["keyboard"]:keySingle("Digite Seu FeedBack:")
            if Keyboard then
                FeedBack = Keyboard[1]
            end
        end
        vSERVER.setRate(Rate,firstActivation,FeedBack)
        firstActivation = 0
    end
    SendNUIMessage({
        action = 'router',
        data = {
            path = '/'
        }
    })
    Wait(1000)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    SetNuiFocus(false,false)
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("vipvehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local ThreadNotify = false
Player = GetPlayerServerId(PlayerId())
cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("GetPlayerVehicles",function(data,cb)
    local PlayerVehicles = vSERVER.GetPlayerVehicles()
    if PlayerVehicles then
        cb(FormatList(PlayerVehicles))
    end
end)

RegisterNuiCallback("testDrive",function(data,cb)
    TestDrive(data)
end)

RegisterNuiCallback("hideFrame",function(data,cb)
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
end)

RegisterNuiCallback("redeemCars",function(data,cb)
    local Cache = {}
    for i=1,#data do
        table.insert(Cache,data[i]["spawn"])
    end
    vSERVER.GivePlayerVehicles(Cache)
end)

RegisterNetEvent("vipvehicle:Open")
AddEventHandler("vipvehicle:Open",function()
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = "setVisible",
        data = ""
    })
end)

RegisterNetEvent("vipvehicle:Close")
AddEventHandler("vipvehicle:Close",function()
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
end)

AddStateBagChangeHandler('VehicleVip',('player:%s'):format(Player),function(_, _, Value)
    if Value then
        if not ThreadNotify then
            ThreadNotify = true
            local StartAt = GetGameTimer()
            CreateThread(function()
                while ThreadNotify do
                    if GetGameTimer() > StartAt then
                        StartAt = GetGameTimer() + 1000*30
                        TriggerEvent("Notify","wheel","Você ainda tem veículos para resgatar utilize o comando /carrosvip para resgatar.",15000,"VEICULOS")
                        -- TriggerEvent("Notify2","#rescueVeicVip")
                    end
                    Wait(1000)
                end
            end)
        end
    else
        ThreadNotify = false
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG CODE
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
--     TriggerEvent("Notify","wheel","Você ainda tem veículos para resgatar utilize o comando /carrosvip para resgatar.",15000,"VEICULOS")
-- end)
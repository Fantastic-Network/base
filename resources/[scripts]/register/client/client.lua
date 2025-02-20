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
sRP = {}
Tunnel.bindInterface("register",sRP)
vSERVER = Tunnel.getInterface("register")
cityName = GetConvar("cityName", "Base")
Player = GetPlayerServerId(PlayerId())
local InRegister = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Step1",function(data,cb)
    if not data["gender"] then
        data["gender"] = "masculino"
    end
    
    if not data["foundUs"] then
        data["foundUs"] = "Season"
    end

    if data["email"] and data["date"] and data["name"] and data["foundUs"] and data["gender"] and data["whatsapp"] then
        if #data["email"] > 255 or #data["date"] > 255 or #data["name"] > 255 or #data["foundUs"] > 255 or #data["gender"] > 255 or #data["whatsapp"] > 255 then
            TriggerEvent("Notify","vermelho","A descrição não pode ultrapassar 255 caracteres.",5000,"REGISTRO")
            -- TriggerEvent("Notify2","#maxCaracter")
            SetRoute("/")
            return
        end

        local Date = formatDate(data["date"])

        if not isdatevalid(Date) then
            SetRoute("/")
            return
        end
        local name = data["name"] or ""
        local surname = data["surname"] or ""
        local Name = name.." "..surname
        local validate = vSERVER.setAccountInfo(Name,data["email"],data["gender"],data["foundUs"],Date,data["whatsapp"])
        if not validate then
            SetRoute("/")
            return
        end
        local sex = "f"
        if data["gender"] == "masculino" then
            sex = "m"
        end
        if not LocalPlayer["state"]["Token"] then
            SetNuiFocus(false,false)
            TransitionFromBlurred(1000)
            local Ped = PlayerPedId()
            SendNUIMessage({ 
                action = "setVisible",
                data = false 
            })
        end
        local Data = {
            ["nome"] = data["name"],
            ["nome2"] = data["surname"],
            ["sexo"] = sex,
            ["idade"] = Date,
        }
        TriggerEvent("spawn:NameInfo",Data)
        TriggerServerEvent("register:AddAction",2)
    else

        SetRoute("/")
    end
    cb("Ok")
end)

RegisterNUICallback("Step2",function(data,cb)
    local Ped = PlayerPedId()
    if true then
        Wait(4500)
        SetRoute("/step2")
    else
        if InToken then
            -- SetNuiFocus(false,false)
            -- FreezeEntityPosition(PlayerPedId(),false)
            -- SendNUIMessage({
            --     action = 'setVisible',
            --     data = "step4"
            -- })
            -- TransitionFromBlurred(1000)
            -- Wait(2000)
            -- SendNUIMessage({ 
            --     action = "setVisible",
            --     data = false 
            -- })
            -- TransitionFromBlurred(1000)
            -- TriggerEvent("hud:Active",true)
            -- FreezeEntityPosition(Ped,false)
        else
            -- SendNUIMessage({
            --     action = 'setVisible',
            --     data = "step3"
            -- })
        end
        TriggerServerEvent("register:AddAction",3)
    end

    cb("Ok")
end)

RegisterNUICallback("carSelected",function(data,cb)
    if data and data ~= "" then
        vSERVER.giveVehicle(data)
    else
        SetRoute("/step3")
    end

    cb("Ok")
end)

RegisterNUICallback("getCars",function(Data,CallBack)
    CallBack({ 
        recommendation = infoLogin[cityName]["Recommendation"], 
        cars = infoLogin[cityName]["Cars"] 
    })
end)

RegisterNUICallback("getID",function(Data,CallBack)
    CallBack(LocalPlayer["state"]["Token"])
end)

RegisterNUICallback("getDiscord",function(Data,CallBack)
    CallBack(infoLogin[cityName]["Discord"])
end)

RegisterNUICallback("getInfo",function(Data,CallBack)
    CallBack({recommendation = infoLogin[cityName]["Recommendation"]})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATEBAGS
-----------------------------------------------------------------------------------------------------------------------------------------
local RegisterTimer = GetGameTimer()
-- AddStateBagChangeHandler('Register',('player:%s'):format(Player) , function(_, _, Value)
--     if Value then
--         Wait(100)
--         RegisterTimer = GetGameTimer() + 30000
--         CreateThread(function()
--             while LocalPlayer["state"]["Register"] do
--                 if GetGameTimer() >= RegisterTimer then
--                     RegisterTimer = GetGameTimer() + 30000
--                     if not LocalPlayer["state"]["Character"] and not InRegister then
--                         TriggerEvent("register:Open")
--                     end
--                     return
--                 end
--                 Wait(1000)
--             end
--         end)
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function SetRoute(route)
    if route == "/" then
        SendNUIMessage({
            action = 'setVisible',
            data = ""
        })
    elseif route == "/step2" then
        SendNUIMessage({
            action = 'setVisible',
            data = "step2"
        })
    elseif route == "/step3" then
        SendNUIMessage({
            action = 'setVisible',
            data = "step3"
        })
    end
end

function isdatevalid(date)
    local year,month,day = string.match(date,"(%d+)-(%d+)-(%d+)")
    if day and month and year then
        if tonumber(day) > 0 and tonumber(day) <= 31 and tonumber(month) > 0 and tonumber(month) <= 12 and tonumber(year) > 1900 and tonumber(year) <= 2022 then
            return true
        end
    end
    return false
end

function formatDate(date)
    local day,month,year = string.match(date,"(%d+)/(%d+)/(%d+)")
    return string.format("%s-%s-%s",year,month,day)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("register:Close")
AddEventHandler("register:Close",function()
    SetNuiFocus(false,false)
    TransitionFromBlurred(1000)
    local Ped = PlayerPedId()
    SendNUIMessage({ 
        action = "setVisible",
        data = false 
    })
    TriggerEvent("hud:Active",true)
    TransitionFromBlurred(1000)
    FreezeEntityPosition(Ped,false)
    SetEntityVisible(Ped,true,false)
    FreezeEntityPosition(PlayerPedId(),false)
end)

RegisterNetEvent('register:Open')
AddEventHandler('register:Open', function()
    local Ped = PlayerPedId()
    FreezeEntityPosition(Ped,true)
    TriggerEvent("talknpc:closeTalk")
    TriggerEvent("hud:Active",false)
    TransitionToBlurred(1000)
    Wait(500)
    SetNuiFocus(true, true)
    FreezeEntityPosition(PlayerPedId(),true)
    SendNUIMessage({
        action = "setVisible",
        data = true
    })
    InRegister = true
end)

RegisterNetEvent('register:OpenToken')
AddEventHandler('register:OpenToken', function(validate)
    InToken = validate
    TriggerEvent("hud:Active",false)
    TransitionToBlurred(1000)
    SendNUIMessage({
        action = 'setVisible',
        data = "step2"
    })
    SetNuiFocus(true, true)
    FreezeEntityPosition(PlayerPedId(),true)
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

function sRP.CheckRegister()
    return true
end
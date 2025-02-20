-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("skinweapon")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponZoomed = false
local weaponObject = nil
local weaponRotation = nil
local weaponBox = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
    if GetCurrentResourceName() == Resource then
        SetNuiFocus(false,false)
        --vSERVER.RequestSkins()
        
        exports["target"]:AddCircleZone("skinweapon",vec3(10.73,-1111.41,29.92),0.5,{
            -- debugPoly = true,
            name = "skinweapon",
            heading = 3374176
        },{
            Distance = 1.75,
            options = {
                {
                    event = "skinweapon:OpenClient",
                    label = "Abrir",
                    tunnel = "client"
                }
            }
        })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINWEAPON:OPENCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinweapon:OpenClient")
AddEventHandler("skinweapon:OpenClient",function()
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and GetEntityHealth(Ped) > 100 then
        TriggerEvent("hud:Active",false)
        TriggerEvent("vrp:removeObjects")
        SetNuiFocus(true,true)
        SetCursorLocation(0.5,0.5)
        zoomWeapon(nil,true,true)
        SendNUIMessage({ action = "Open" })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
    zoomWeapon(nil,false,false)
    TriggerEvent("hud:Active",true)
    local Ped = PlayerPedId()
    TriggerEvent("vrp:removeObjects")
    SetNuiFocus(false,false)
    SetCursorLocation(0.5,0.5)
    SendNUIMessage({ action = "Close" })
    TriggerEvent("hud:Active",true)
    TriggerEvent("Notify:Remkey",false)
    TriggerEvent("safezone:remPromo",false)
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPISTOL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestPistol",function(Data,Callback)
    Callback({ result = GlobalState["Pistol"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTRIFLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestRifle",function(Data,Callback)
    Callback({ result = GlobalState["Rifle"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestPossuidas",function(Data,Callback)
    Callback({ result = vSERVER.RequestPossuidas() })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestBuy",function(Data,Callback)
    vSERVER.RequestBuy(Data["name"])
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTEQUIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestEquip",function(Data,Callback)
    if Data["name"] then
        vSERVER.RequestEquip(Data["name"])
    end
    
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestWeapon",function(Data,Callback)
    if Data["component"] and Data["weapon"] then
        zoomWeapon(Data,true,false)
    end
    
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTUNEQUIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestUnequip",function(Data,Callback)
    if Data["name"] then
        vSERVER.RequestUnequip(Data["name"])
    end
    
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTRANSF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestTransf",function(Data,Callback)
    vSERVER.RequestTransf(Data["name"])
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RequestSell",function(Data,Callback)
    vSERVER.RequestSell(Data["name"])
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINWEAPON:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinweapon:Update")
AddEventHandler("skinweapon:Update",function(Action)
    SendNUIMessage({ action = Action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERMOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("RegisterMouse",function(Data,Callback)
    weaponRotation = GetEntityRotation(weaponObject)
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUSEMOVEMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("MouseMovement",function(Data,Callback)
    if weaponObject then
        local x = Data["x"] / 10
        local y = Data["y"] / 10
        SetEntityRotation(weaponObject,weaponRotation[1] + y,0.0,weaponRotation[3] - x)
    end
    
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEAPONFOV
-----------------------------------------------------------------------------------------------------------------------------------------
function getWeaponFOV(hash)
    if GetWeapontypeGroup(hash) == -957766203 then
        return 30.0
    end
    if GetWeapontypeGroup(hash) == 416676503 then
        return 20.0
    end
    if GetWeapontypeGroup(hash) == 860033945 then
        return 35.0
    end
    if GetWeapontypeGroup(hash) == 970310034 then
        return 27.0
    end
    if GetWeapontypeGroup(hash) == 1159398588 then
        return 30.0
    end
    if GetWeapontypeGroup(hash) == -1212426201 then
        return 40.0
    end
    if GetWeapontypeGroup(hash) == -1569042529 then
        return 40.0
    end
    
    return 35.0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ZOOMWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function zoomWeapon(weapon,bool,first)
    if bool then
        local lastRotation = vector3(0.0,0.0,230.0)
        local Coords = vector3(231.42,-977.78,-98.50)
        if first then
            NewLoadSceneStartSphere(Coords, 5000, 0)

            local componentModel = GetWeaponComponentTypeModel(GetHashKey(showfirst["skin"]))
            RequestModel(componentModel)
            while not HasModelLoaded(componentModel) do
                Wait(1)
            end
            
            weaponObject = CreateObject(componentModel,Coords,false,true,0)
            -- weaponBox = CreateObject(GetHashKey("mt_boxpreta"),Coords,false,true,0)
            SendNUIMessage({ action = "playSound", sound = "construct"})
            
            SetEntityRotation(weaponObject,lastRotation)
            FreezeEntityPosition(weaponObject,true)

            local offset2 = GetOffsetFromEntityInWorldCoords(weaponObject,1.0,1.0,0.0)
            SetTimecycleModifier("METRO_Tunnels")
            SetTimecycleModifierStrength(1.0)
            
            cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",offset2,0.0,0.0,0,0.0,false,0)
            PointCamAtEntity(cam3,weaponObject,0,0,0,true)
            
            SetCamFov(cam3,getWeaponFOV(GetHashKey(showfirst["weapon"])))
            SetCamActive(cam3,true)
            RenderScriptCams(true,false,1,true,true)
            
            Wait(100)
            
            weaponZoomed = true
        else
            DeleteEntity(weaponObject)
            
            local componentModel = GetWeaponComponentTypeModel(GetHashKey(weapon["component"]))
            RequestModel(componentModel)
            while not HasModelLoaded(componentModel) do
                Wait(1)
            end
            
            weaponObject = CreateObject(componentModel,Coords,false,true,0)
            SendNUIMessage({ action = "playSound", sound = "construct"})
            
            SetEntityRotation(weaponObject,lastRotation)
            FreezeEntityPosition(weaponObject,true)
            
            PointCamAtEntity(cam3,weaponObject,0,0,0,true)
            
            SetCamFov(cam3,getWeaponFOV(GetHashKey(weapon["weapon"])))
            
            Wait(100)
        end
    else
        DeleteEntity(weaponObject)
        -- DeleteEntity(weaponBox)
        --NetworkClearClockTimeOverride()
        
        SetTimecycleModifier("default")
        DestroyCam(cam3,true)
        RenderScriptCams(false,false,1,true,true)
        weaponZoomed = false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERA LOOP
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
--     while true do
--         TimeDistance = 999
--         if weaponZoomed then
--             TimeDistance = 1
            
--             x,y,z = table.unpack(GetEntityCoords(weaponObject,true))
--             -- NetworkOverrideClockTime(1,00,00)
--             DrawSpotLight(x,y + 10.0,z + 10.2,10,-10.0,-15.0,255,255,255,25.0,4.0,2.0,20.0,0.0)
--         end
        
--         Wait(TimeDistance)
--     end
-- end)
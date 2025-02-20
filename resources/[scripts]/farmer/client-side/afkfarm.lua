local InZone = false
local Hacking = false
local LapTop = false
local Model = "xm_prop_x17_laptop_lester_01"
cityName = GetConvar("cityName", "Base")
local KeySwitch = "E"
local KeySwitchNumber = 38

if cityName == "Base" then
    KeySwitch = "Q"
    KeySwitchNumber = 44
end

local Zones = {
    PolyZone:Create({
        vector2(1497.73, 6405.30),
        vector2(1467.80, 6368.94),
        vector2(1401.52, 6389.02),
        vector2(1384.47, 6275.76),
        vector2(1546.97, 6281.82),
        vector2(1581.44, 6344.70)
    }, {
        name="HackZone",
        minZ=15,
        maxZ=30
    }),
}

local StartCoords = {
    --vector3(1531.98,6327.61,24.28),
    --vector3(1431.53,6345.75,23.98),
   -- vector3(1472.44,6359.79,23.67),
}

if cityName == "Base" then
--    StartCoords[#StartCoords+1] = vector3(902.29,-2539.81,28.26)
end

CreateThread(function()

    LocalPlayer["state"]:set("Buttons",false,true)
    while true do
        local Idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        local Inside = false
        for i=1, #Zones do
            if Zones[i]:isPointInside(Coords) then
                if not InZone then
                    InZone = true
                end
                Inside = true
            end
        end
        if not Inside then
            InZone = false
        end
        Wait(Idle)
    end
end)

local Teleport = vector3(2157.93,2921,-80.0)

CreateThread(function()

    local Table = {}
    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i]["x"],
            StartCoords[i]["y"],
            StartCoords[i]["z"],
            50.0,
            KeySwitch,
            "Iniciar FARM",
            "Pressione para abrir",
        }
    end
    TriggerEvent("hoverfy:Insert",Table)
    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        if InZone then
            idle = 1
            if InZone and IsControlJustPressed(0,KeySwitchNumber) and not Hacking then
                idle = 2500
                Hacking = true
                LocalPlayer["state"]:set("Buttons",true,true)
                LocalPlayer["state"]:set("Cancel",true,true)
                LocalPlayer["state"]:set("Farming",true,true)
                -- TriggerEvent("Notify","amarelo","Você iniciou o farm afk, basta ficar 05 minutos para receber seus itens.",30000,"FARM")
                -- TriggerEvent("Notify2","#startFarm")
                -- TriggerEvent("Notify","amarelo","Você pode farmar enquanto estiver AFK sem morrer de fome ou sede!",60000,"FARM")
                -- TriggerEvent("Notify2","#suggFarm")
                CreateThread(function()
                    StartFarming()
                end)
            end
        end
        Wait(idle)
    end
end)

local Timer = 60*5
local Animations = {
    ["bong"] = { dict = "anim@safehouse@bong", anim = "bong_stage1", prop = "prop_bong_01", flag = 49, hand = 18905, pos1 = 0.10, pos2 = -0.25, pos3 = 0.0, pos4 = 95.0, pos5 = 190.0, pos6 = 180.0 },
}

function StartFarming()
    local Ped = PlayerPedId()
    local name = "bong"
    TriggerEvent("hoverfy:removeHoverfy",Timer)
    vRP._playAnim(false,{"anim@safehouse@bong", "bong_stage1"},true)
    TriggerEvent("Progress","Minerando",1000*Timer)
    local Count = 0
    while Hacking do
        Count = Count + 1
        if Count >= Timer then
            break
        end
        Wait(1000)
    end
    if not Hacking then
        return
    end
    local Coords = GetEntityCoords(Ped)
    if InZone then
        vRP.stopAnim(false)
        TriggerServerEvent("farmer:Farming")
        -- TriggerServerEvent("DeleteObject",Network)
        LocalPlayer["state"]:set("Buttons",false,true)
        LocalPlayer["state"]:set("Cancel",false,true)
        TriggerEvent("Progress","Minerando",0)
        StartFarming()
    end
end


AddEventHandler("actions:Cancel",function()
    if Hacking then
        vRP._stopAnim(false)
        LocalPlayer["state"]:set("Buttons",false,true)
        LocalPlayer["state"]:set("Cancel",false,true)
        LocalPlayer["state"]:set("Farming",false,true)
        TriggerEvent("hoverfy:returnHoverfy")
        Hacking = false
        InZone = false
        Hacking = false
        LapTop = false
        Model = "xm_prop_x17_laptop_lester_01"
    end
end)
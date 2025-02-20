local InZone = false
local Hacking = false
local LapTop = false
local Model = "xm_prop_x17_laptop_lester_01"
local Zone = PolyZone:Create({
    vector2(1872.73, 2971.21),
    vector2(1863.64, 2862.12),
    vector2(2389.39, 2853.03),
    vector2(2386.36, 3009.09)
}, {
    name="HackZone",
    minZ=-100,
    maxZ=-75
})


local StartCoords = {
    vector3(2002.69,2925.02,-84.81),
    vector3(2117.31,2925.82,-84.11),
    vector3(2234.3,2925.8,-84.0),
    vector3(2323.28,2925.47,-84.47),
}

CreateThread(function()
    while true do
        local Idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        local BagIndex = GetPedBoneIndex(Ped,57005)
        if Zone:isPointInside(Coords) then
            if not InZone then
                InZone = true
            end
        else
            if InZone then
                InZone = false
            end
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
            70.0,
            "E",
            "Iniciar Mineração",
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
            local NewCoords = vector3(Coords["x"],Coords["y"],-80.0)
            local Distance = #(NewCoords - Teleport)
            if Distance >= 5.0 and IsControlJustPressed(0,38) and not Hacking then
                idle = 2500
                Hacking = true
                LocalPlayer["state"]:set("Buttons",true,true)
                LocalPlayer["state"]:set("Cancel",true,true)
                LocalPlayer["state"]:set("Mining",true,true)
                TriggerEvent("Notify","amarelo","Você iniciou a mineração, para finalizar pressione <b>F6</b>.",30000,"MINERAÇÃO")
                -- TriggerEvent("Notify2","#startMining")
                TriggerEvent("Notify","amarelo","Você pode minerar enquanto estiver AFK sem morrer de fome ou sede!",30000,"MINERAÇÃO")
                -- TriggerEvent("Notify2","#suggMining")
                CreateThread(function()
                    StartMining()
                end)
            end
        end
        Wait(idle)
    end
end)

local Timer = 1000*60*1

function StartMining()
    local Ped = PlayerPedId()
    TriggerEvent("hoverfy:removeHoverfy",Timer)
    vRP.playAnim(false,{"anim@heists@ornate_bank@hack","hack_loop"},true)
    Wait(500)
    local Coords = GetPedBoneCoords(Ped,18905,0,0,0)
    local _,Ground = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])
    local Heading = GetEntityHeading(Ped)
    local Offset = GetObjectOffsetFromCoords(Coords["x"],Coords["y"],Ground,Heading,0.1,0.18,0)
    _,Network = vRPS.CreateObject(Model,Offset["x"],Offset["y"],Ground,Heading)
    TriggerEvent("Progress","Minerando",Timer)
    Wait(Timer)
    if Hacking then
        vRP.playAnim(false,{"anim@heists@money_grab@briefcase","exit"},true)
        Wait(1500)
        vRP.stopAnim(false)
        TriggerServerEvent("farmer:Mining")
        TriggerServerEvent("DeleteObject",Network)
        LocalPlayer["state"]:set("Buttons",false,true)
        LocalPlayer["state"]:set("Cancel",false,true)
        StartMining()
    end
    LocalPlayer["state"]["AnyJob"] = true
end


AddEventHandler("actions:Cancel",function()
    if Hacking then
        vRP.stopAnim(false)
        TriggerServerEvent("DeleteObject",Network)
        LocalPlayer["state"]:set("Buttons",false,true)
        LocalPlayer["state"]:set("Cancel",false,true)
        LocalPlayer["state"]:set("Mining",false,true)
        TriggerEvent("Progress","Cancelando",0)
        TriggerEvent("hoverfy:returnHoverfy")
        Hacking = false
        LocalPlayer["state"]["AnyJob"] = false
    end
end)
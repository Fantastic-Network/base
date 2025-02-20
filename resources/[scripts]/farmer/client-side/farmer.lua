-----------------------------------------------------------------------------------------------------------------------------------------
-- Variables
-----------------------------------------------------------------------------------------------------------------------------------------
local InJob = false
local NearJob = false
local Selected = false
local Delivery = false
local Start = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(250)
    Start = FarmerInfo["Start"]
    CreatePeds()
    while true do
        local Idle = 1000
        if not InJob then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Near = 100
            for i=1,#Start do
                local Start = vector3(Start[i]["x"],Start[i]["y"],Start[i]["z"])
                local Distance = #(Coords - Start)
                if Distance < Near then
                    Near = Distance
                    NearJob = i
                end
            end
        end
        Wait(Idle)
    end
end)
CreateThread(function()
    while true do
        local Idle = 1000
        if NearJob and not InJob then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Start = vector3(Start[NearJob]["x"],Start[NearJob]["y"],Start[NearJob]["z"])
            local Distance = #(Coords - Start)
            if Distance < 20.0 then
                Idle = 5
                local _,Ground = GetGroundZFor_3dCoord(Start.x, Start.y, Start.z)
                DrawMarker(23, Start.x, Start.y, Ground + 0.15, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0,THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 100, 0, 0, 0, 0)
                if Distance < 5.0 then
                    Idle = 5
                    DrawText3D(Start.x, Start.y, Start.z,"[~g~E~w~] Iniciar (Agricultor)")
                    if IsControlJustReleased(0, 38) then
                        InJob = NearJob
                        Selected = 1
                        StartFarmer()
                    end
                end
            end
        end
        Wait(Idle)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
function StartFarmer()
    TriggerEvent("Notify:Text","Pressione F6 Para sair do trabalho")
    local Ped = PlayerPedId()
    CreateBlip(vector3(FarmerInfo["Routes"][Selected]["x"],FarmerInfo["Routes"][Selected]["y"],FarmerInfo["Routes"][Selected]["z"]))
    LocalPlayer["state"]["AnyJob"] = true
    CreateThread(function()
        while true do
            local Idle = 1000
            if InJob and Selected then
                if not Delivery then
                    local Coords = GetEntityCoords(Ped)
                    local SelectedCoords = FarmerInfo["Routes"][Selected]
                    local Distance = #(Coords - vector3(SelectedCoords["x"],SelectedCoords["y"],SelectedCoords["z"]))
                    if Distance < 200.0 then
                        Idle = 5
                        local _,Ground = GetGroundZFor_3dCoord(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z)
                        DrawMarker(22, SelectedCoords.x, SelectedCoords.y, Ground + 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 100, 0, 0, 0, 0)
                        if Distance < 50.5 then
                            Idle = 5
                            DrawText3D(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z +1.0,"Coletar Grãos")
                            if Distance < 5.5 then
                                if IsPedInAnyVehicle(Ped) then
                                    local vehicle = GetVehiclePedIsIn(Ped, false)
                                    local model = GetEntityModel(vehicle)
                                    local displayName = GetDisplayNameFromVehicleModel(model)
                                    SetEntityMaxSpeed(vehicle,0.28 * 20)
                                    if displayName == "TRACTOR2" then
                                        Delivery = true
                                        if Delivery then
                                            TriggerServerEvent("farmer:PaymentFarmer",Selected)
                                        end
                                    else
                                        TriggerEvent("Notify","vermelho","Você precisa estar em um trator para coletar os itens.","Agricultor")
                                        Wait(10000)
                                    end
                                end
                            end
                        end
                    end
                end
            else
                break
            end
            Wait(Idle)
        end
    end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("farmer:NextRouteFarmer")
AddEventHandler("farmer:NextRouteFarmer",function(Next)
    Selected = Next
    Delivery = false
    print(Selected)
    CreateBlip(vector3(FarmerInfo["Routes"][Selected]["x"],FarmerInfo["Routes"][Selected]["y"],FarmerInfo["Routes"][Selected]["z"]))
end)

AddEventHandler("actions:Cancel",function()
    if InJob then
        InJob = false
        NearJob = false
        Selected = false
        Delivery = false
        vRP.stopAnim(false)
        TriggerEvent("Notify:Text","")
        TriggerEvent("Notify2","#cancelWork")
        TriggerEvent("Progress","Cancelando",0)
        if blips then
            RemoveBlip(blips)
        end
        LocalPlayer["state"]["AnyJob"] = false
    end
end)

function CreateBlip(Coordinates)
    if blips then
        RemoveBlip(blips)
    end
    local Ped = PlayerPedId()
    LocalPlayer["state"]["AnyJob"] = Coordinates
    -- SetEntityCoords(Ped,Coordinates)
	blips = AddBlipForCoord(Coordinates)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.6)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta")
	EndTextCommandSetBlipName(blips)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEPARATE
-----------------------------------------------------------------------------------------------------------------------------------------

-- CreateThread(function()
--     while true do
--         local Idle = 2500
--         local Ped = PlayerPedId()
--         local Coords = GetEntityCoords(Ped)
--         local SeparateCoords = FarmerInfo["Separate"]["Start"]
--         local Close = false
--         for i=1,#SeparateCoords do
--             local SelectedCoords = vector3(SeparateCoords[i]["x"],SeparateCoords[i]["y"],SeparateCoords[i]["z"])
--             local Distance = #(Coords - SelectedCoords)
--             if Distance < 20.0 then
--                 Idle = 5
--                 local _,Ground = GetGroundZFor_3dCoord(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z)
--                 DrawMarker(23, SelectedCoords.x, SelectedCoords.y, Ground + 0.15, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5,THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 100, 0, 0, 0, 0)
--                 if Distance < 2.0 then
--                     Idle = 5
--                     DrawText3D(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z,"[~g~E~w~] Separar Graos")
--                     if IsControlJustReleased(0, 38) then
--                         TriggerServerEvent("farmer:SeparateAll")
--                     end
--                 end
--             end
--         end
--         Wait(Idle)
--     end
-- end)
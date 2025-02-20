local InJob = false
local NearJob = false
local Selected = false
local Delivery = false
local Start = {
    vector3(453.74,-600.6,28.54)
}

CreateThread(function()
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
                DrawMarker(23, Start.x, Start.y, Ground + 0.03, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5,THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 100, 0, 0, 0, 0)
                if Distance < 1.5 then
                    Idle = 5
                    DrawText3D(Start.x, Start.y, Start.z,"[~g~E~w~] Iniciar Trabalho (Motorista)")
                    if IsControlJustReleased(0, 38) then
                        InJob = NearJob
                        Selected = 1
                        StartBusJob()
                    end
                end
            end
        end
        Wait(Idle)
    end
end)


-- CreateThread(function()
--     InJob = 1
--     Selected = 1
--     StartBusJob()
-- end)

function StartBusJob()
    TriggerEvent("Notify:Text","[F6] Cancelar Emprego <br/>[H] Piloto Automático")
    local Ped = PlayerPedId()
    LocalPlayer["state"]["AnyJob"] = BusRoutes[Selected]
    CreateBlip(BusRoutes[Selected])
    CreateThread(function()
        while true do
            local Idle = 1000
            if InJob and Selected then
                if not Delivery then
                    local Coords = GetEntityCoords(Ped)
                    local SelectedCoords = BusRoutes[Selected]
                    local Distance = #(Coords - SelectedCoords)
                    if Distance < 200.0 then
                        Idle = 5
                        local _,Ground = GetGroundZFor_3dCoord(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z)
                        DrawMarker(22, SelectedCoords.x, SelectedCoords.y, Ground + 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 100, 0, 0, 0, 0)
                        if Distance < 50.5 then
                            Idle = 5
                            DrawText3D(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z +1.0 ,"[~g~E~w~] Parada (Motorista)")
                            if Distance < 20.5 then
                                if IsPedInAnyVehicle(Ped) then
                                    local vehicle = GetVehiclePedIsIn(Ped, false)
                                    local model = GetEntityModel(vehicle)
                                    local displayName = GetDisplayNameFromVehicleModel(model)
                                    if displayName == "ONIBUS SANT" then
                                        Delivery = true
                                        if Delivery then
                                            TriggerServerEvent("farmer:PaymentBus",Selected)
                                        end
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


RegisterNetEvent("farmer:NextRouteBus")
AddEventHandler("farmer:NextRouteBus",function(Next)
    Selected = Next
    Delivery = false
    CreateBlip(BusRoutes[Selected])
    if LocalPlayer["state"]["JobAutoPilot"] then
        StartJobAutoPilot(BusRoutes[Selected])
    end
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
    LocalPlayer["state"]["AnyJob"] = Coordinates
    local Ped = PlayerPedId()
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
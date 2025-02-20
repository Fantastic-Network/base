local InJob = false
local NearJob = false
local Selected = false
local Delivery = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local Idle = 1000
        if NearJob and not InJob then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Start = vector3(Jobs[NearJob]["Start"]["x"],Jobs[NearJob]["Start"]["y"],Jobs[NearJob]["Start"]["z"])
            local Distance = #(Coords - Start)
            if Distance < 20.0 then
                Idle = 5
                local _,Ground = GetGroundZFor_3dCoord(Start.x, Start.y, Start.z)
                DrawMarker(23, Start.x, Start.y, Ground + 0.03, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5,THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 100, 0, 0, 0, 0)
                if Distance < 1.5 then
                    Idle = 5
                    DrawText3D(Start.x, Start.y, Start.z,Jobs[NearJob]["Texts"]["Start"])
                    if IsControlJustReleased(0, 38) then
                        InJob = NearJob
                        Selected = 1
                        StartJob()
                    end
                end
            end
        end
        Wait(Idle)
    end
end)

CreateThread(function()
    CreatePeds()
    while true do
        local Idle = 1000
        if not InJob then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Near = 100
            for i=1,#Jobs do
                local Start = vector3(Jobs[i]["Start"]["x"],Jobs[i]["Start"]["y"],Jobs[i]["Start"]["z"])
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatePeds()
    for i=1,#Jobs do
        if Jobs[i]["Ped"] then
            exports["player"]:AddPedToList(Jobs[i]["Ped"])
        end
    end
end

local Objects = {}
function CreateObjects(Object,Coords)
    for i=1,#Objects do
        DeleteEntity(Objects[i])
    end
    Objects = {}
    local Model = GetHashKey(Object)
    local Coords = vector3(Coords["x"],Coords["y"],Coords["z"])
    local _,Ground = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])
    local Object = CreateObject(Model,Coords["x"],Coords["y"],Ground,false,true,false)
    PlaceObjectOnGroundProperly(Object)
    FreezeEntityPosition(Object,true)
    SetEntityCollision(Object,false,false)
    table.insert(Objects,Object)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTJON
-----------------------------------------------------------------------------------------------------------------------------------------
function StartJob()
    TriggerEvent("Notify:Text","")
    Wait(100)
    TriggerEvent("Notify:Text","[F6] Cancelar Emprego <br/>[H] Piloto Automático [AFK]")
    local Ped = PlayerPedId()
    CreateBlip(Jobs[InJob]["Routes"][Selected])
    CreateThread(function()
        while true do
            local Idle = 1000
            ::Init::
            if InJob and Selected then
                if not Delivery then
                    local Coords = GetEntityCoords(Ped)
                    local SelectedCoords = Jobs[InJob]["Routes"][Selected]
                    local Distance = #(Coords - SelectedCoords)
                    if Distance < 150.0 then
                        Idle = 5
                        local _,Ground = GetGroundZFor_3dCoord(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z)
                        DrawMarker(22, SelectedCoords.x, SelectedCoords.y, Ground + 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 100, 0, 0, 0, 0)
                        if Distance < 20.0 then
                            DrawText3D(SelectedCoords.x, SelectedCoords.y, SelectedCoords.z,Jobs[InJob]["Texts"]["Delivery"])
                            Idle = 5
                            --if IsControlJustReleased(0, 38) then
                            if Jobs[InJob]["Object"] then
                                for i=1,#Jobs[InJob]["Object"] do
                                    CreateObjects(Jobs[InJob]["Object"][i][1],SelectedCoords+Jobs[InJob]["Object"][i][2])
                                end
                            end
                                if not Jobs[InJob]["Vehicle"] and IsPedInAnyVehicle(Ped) then
                                    TriggerEvent("Notify","negado","Você não pode estar em um veículo para realizar a entrega.",8000,"Trabalho")
                                    -- TriggerEvent("Notify2","#condEntrega")
                                    Wait(5000)
                                    goto Init
                                end
                                if Jobs[InJob]["Vehicle"] and IsPedInAnyVehicle(Ped) then
                                    local Vehicle = GetVehiclePedIsIn(Ped)
                                    if not IsVehicleModel(Vehicle, Jobs[InJob]["Vehicle"]) then
                                        Wait(5000)
                                        goto Init
                                    end
                                end
                                Delivery = true
                                if Jobs[InJob]["Anim"] then
                                    StartAnim()
                                end
                                if Delivery then
                                    TriggerServerEvent("farmer:PaymentJob",InJob,Selected)
                                end
                            --end
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

RegisterNetEvent("farmer:NextJob")
AddEventHandler("farmer:NextJob",function(Next)
    Selected = Next
    Delivery = false
    CreateBlip(Jobs[InJob]["Routes"][Selected])
    if LocalPlayer["state"]["JobAutoPilot"] then
        StartJobAutoPilot(Jobs[InJob]["Routes"][Selected])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function StartAnim()
    local Ped = PlayerPedId()
    local Anim = Jobs[InJob]["Anim"]["Animation"]
    local Progress = Jobs[InJob]["Anim"]["Progress"]
    vRP.playAnim(false,{Anim["Dict"],Anim["Name"]},true)
    if Progress then
        TriggerEvent("Progress","Progress",Progress)
    end
    Wait(Jobs[InJob]["Anim"]["Wait"])
    vRP.stopAnim(false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("onClientResourceStart")
AddEventHandler("onClientResourceStart",function(Resource)
    if Resource == "player" then
        Wait(100)
        CreatePeds()
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("actions:Cancel",function()
    if InJob then
        InJob = false
        NearJob = false
        Selected = false
        Delivery = false
        vRP.stopAnim(false)
        TriggerEvent("Notify:Text","")
        TriggerEvent("Notify","negado","Trabalho cancelado.",8000,"Trabalho")
        -- TriggerEvent("Notify2","#cancelWork")
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
    print(Selected)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Client = {}
Tunnel.bindInterface("race/auto",Client)
local vSERVER = Tunnel.getInterface("race/auto")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RaceStarted = false
RaceId = false
SortedTable = {}
CachedTable = {}
StartTable = {}
SelectedDriver = false
SelectedVehicle = false
FinishCoords = false
RaceData = {}
blipRace = nil
Price = 0
RequestActive = false
RequestResponse = nil
WaitingRequest = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("race:Config")
AddEventHandler("race:Config",function()
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = "setVisible",
        data = "start/config"
    })
end)

RegisterNetEvent("race:Setup")
AddEventHandler("race:Setup",function(Data,Id)
    SetNuiFocus(true,true)
    RaceData = GetVehiclesRace(Data)
    RaceId = Id
    SendNUIMessage({
        action = "setVisible",
        data = "start"
    })
end)

RegisterNetEvent("race:Start")
AddEventHandler("race:Start",function(Coords,Id)
    SetNuiFocus(false,false)
    FinishCoords = Coords
    AddBlip(FinishCoords)
    SendNUIMessage({
        action = "setVisible",
        data = "gameplay"
    })
    Wait(250)
    SendNUIMessage({
        action = "startRace",
        data = GetGpsBlipRouteLength(PlayerPedId())
    })
    Wait(5000)
    RaceStarted = true
    CreateThread(function()
        while RaceStarted do
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Distance = parseInt(#(Coords - FinishCoords))
            if not IsPedInAnyVehicle(Ped) then
                vSERVER.CancelRace(RaceId)
            end
            if Distance <= 10.0 then
                vSERVER.FinishRace(RaceId)
            end
            Wait(100)
        end
    end)
end)

RegisterNetEvent("race:Finish")
AddEventHandler("race:Finish",function()
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
    RemoveBlip(blipRace)
    RaceStarted = false
    RaceId = false
    SortedTable = {}
    CachedTable = {}
    StartTable = {}
    SelectedDriver = false
    SelectedVehicle = false
    FinishCoords = false
    RaceData = {}
    blipRace = nil
    Price = 0
    RequestActive = false
    RequestResponse = nil
end)

RegisterNUICallback("hideFrame",function(data,cb)
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
end)

RegisterNetEvent("race:Update")
AddEventHandler("race:Update",function(Table)
    SendNUIMessage({
        action = "updateRanking",
        data = UpdateRankingTable(Table)
    })
end)

function Client.Distance()
    return GetGpsBlipRouteLength(PlayerPedId())
end

-- AddEventHandler("gameEventTriggered",function(eventName,args)
--     if eventName ~= "CEventNetworkPlayerEnteredVehicle" then
--         return
--     end

--     if tonumber(args[1]) ~= PlayerId() or not LocalPlayer["state"]["Active"] then
--         return
--     end

--     local Ped = PlayerPedId()
--     local Veh = GetVehiclePedIsIn(Ped)

--     CreateThread(function()
--         while true do
--             local Idle = 1000
--             if IsPedInAnyVehicle(Ped) then
--                 local vehicle = ClosestVehicle()
--                 if vehicle and Veh ~= vehicle then
--                     Idle = 5
--                     if IsEntityAVehicle(vehicle) then
--                         local Coords = GetEntityCoords(vehicle)
--                         local PlayerCoords = GetEntityCoords(Ped)
--                         local Distance = #(Coords - PlayerCoords)
--                         if Distance <= 7 then
--                             DrawText(Coords.x,Coords.y,Coords.z + 1,"Pressione [~g~H~w~] para desafiar para uma corrida")
--                             if IsControlJustPressed(0,101) and not RequestActive and not WaitingRequest then
--                                 SelectedDriver = GetDriver(vehicle)
--                                 SelectedVehicle = GetVehicleName(vehicle)
--                                 TriggerEvent("race:Config")
--                             end
--                         end
--                     end
--                 end
--             else
--                 break
--             end
--             Wait(Idle)
--         end
--     end)
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("selfData",function(data,cb)
    local Vehicle = GetVehiclePedIsIn(PlayerPedId())
    local VehicleName = GetVehicleName(Vehicle)
    local Info = {
        ["name"] = "Personagem",
        ["vehicle"] = {
            ["name"] = VehicleName["Name"],
            ["image"] = "SEU LINK AQUI"..VehicleName["Model"]..".png"
        },
        ["isManager"] =  true
    }
    cb(Info)
end)

RegisterNuiCallback("gameData",function(data,cb)
    cb(RaceData)
end)

RegisterNuiCallback("setupConfigRace",function(data,cb)
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = "setVisible",
        data = false
    })
    FinishCoords = Races[StartTable[data["distance"]]]
    Price = data["price"]

    WaitingRequest = true

    if Price > 0 then
        vSERVER.SetupRace(FinishCoords,data["distance"],SelectedDriver,Price)
    end
    WaitingRequest = false
end)

RegisterNuiCallback("startRace",function(data,cb)
    SetNuiFocus(false,false)
    vSERVER.StartRace(FinishCoords,RaceId)
end)

RegisterNuiCallback("getDisponibleValues",function(data,cb)
    cb({
        ["distances"] = GetRaces(),
        ["minPrice"] = Prices["Min"],
        ["maxPrice"] = Prices["Max"]
    })
end)

RegisterNuiCallback("askResponse",function(data,cb)
    RequestResponse = data["accepted"]
    RequestActive = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Client.Request(Data)
    RequestActive = true
    SendNUIMessage({
        action = "setVisible",
        data = true
    })
    SendNUIMessage({
        action = "addRequest",
        data = Data
    })
    while RequestActive do
        Wait(100)
    end
    return RequestResponse
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Y
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("race:PressedY",function()
	if RequestActive then
        RequestResponse = true
        RequestActive = false
        SendNUIMessage({
            action = "pressedYes",
            data = true
        })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- U
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("race:PressedU",function()
	if RequestActive then
        RequestResponse = false
        RequestActive = false
        SendNUIMessage({
            action = "pressedNo",
            data = true
        })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
sRP = {}
Tunnel.bindInterface("safezone",sRP)
vKEYBOARD = Tunnel.getInterface("keyboard")
vCLIENT = Tunnel.getInterface("safezone")
cityName = GetConvar("cityName", "Base")
SafeMode = GetConvar("SafeMode", "")

function sRP.setSafeMode(boolean)
    local source = source
    local plyState = Player(source).state
    plyState:set("inSafeMode",boolean,true)
end

function sRP.setSafeZone(boolean)
    local source = source
    Player(source)["state"]["InSafeZone"] = boolean
end

RegisterServerEvent("SafeWorld:Enter")
AddEventHandler("SafeWorld:Enter",function(Number,Server)
    local source = source
    local Bucket = GetPlayerRoutingBucket(source)
    if Player(source)["state"]["InSafeZone"] then
        if Bucket == 1 then
            exports["vrp"]:ChangePlayerBucket(source,7)
        elseif Bucket == 7 then
            local Bucket = 1
            exports["vrp"]:ChangePlayerBucket(source,Bucket)
        end
    else
        TriggerClientEvent("Notify",source,"vermelho","Você precisa estar em uma SAFEZONE para entrar/sair do mundo safe.",5000,"Mundo Safe")
        -- TriggerClientEvent("Notify2",source,"#safeZoneChange")
    end
end)

local NumberSeats = {-1,0,1,2,3,4,5,6,7,8,9,10,11,12}
local VehiclesCache = {}
RegisterServerEvent("Safe:Bucket")
AddEventHandler("Safe:Bucket",function(Number,Server)
	local source = source
    if Server then
        source = Server
    end
    local Ped = GetPlayerPed(source)
    local Vehicle = GetVehiclePedIsIn(Ped)
    local Seat = false
    local Bucket = Number
    if Vehicle and Vehicle ~= 0 and not VehiclesCache[Vehicle] then
        local AccupiedSeats = {}
        VehiclesCache[Vehicle] = true
        local Count = 0
        for _,Seat in pairs(NumberSeats) do
            local PedInVehicle = GetPedInVehicleSeat(Vehicle,Seat)
            if PedInVehicle and PedInVehicle ~= 0 then
                local Source = Entity(PedInVehicle)["state"]["Source"]
                if Source and Source ~= 0 then
                    AccupiedSeats[tostring(Seat)] = PedInVehicle
                    exports["vrp"]:ChangePlayerBucket(Source,Bucket)
                    if SafeMode == "true" then
                        if Bucket == 2 then
                            Player(Source)["state"]["GreenMode"] = false
                            Entity(PedInVehicle)["state"]:set("WarMode",true,true)
                        elseif Bucket == 1 then
                            Player(Source)["state"]["GreenMode"] = true
                            Entity(PedInVehicle)["state"]:set("WarMode",false,true)
                        end
                    end
                end
            end
        end
        exports["vrp"]:ChangePlayerBucket(source,Bucket)
        SetEntityRoutingBucket(Vehicle,Bucket)
        Wait(100)
        local Count = 0
        while GetEntityRoutingBucket(Vehicle) ~= Bucket do
            Wait(100)
            Count = Count + 1
            if Count > 1000 then
                Count = 0
                break
            end
        end
        for Seat,PedInVehicle in pairs(AccupiedSeats) do
            async(function()
                local Count = 0
                while GetEntityRoutingBucket(PedInVehicle) ~= Bucket do
                    Wait(100)
                    Count = Count + 1
                    if Count > 1000 then
                        break
                    end
                end
                SetPedIntoVehicle(parseInt(PedInVehicle),parseInt(Vehicle),parseInt(Seat))
            end)
        end
        VehiclesCache[Vehicle] = false
        exports["vrp"]:ChangePlayerBucket(source,Bucket)
    else
        exports["vrp"]:ChangePlayerBucket(source,Bucket)
    end
end)

RegisterServerEvent("Safe:VanillaBucket")
AddEventHandler("Safe:VanillaBucket",function(Leave)
    local source = source
    if not Leave then
        exports["vrp"]:ChangePlayerBucket(source,15)
    else
        exports["vrp"]:ChangePlayerBucket(source,1)
    end
end)
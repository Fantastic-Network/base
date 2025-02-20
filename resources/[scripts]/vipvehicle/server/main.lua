Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

cityName = GetConvar("cityName","Base")
vKEYBOARD = Tunnel.getInterface("keyboard")

Server = {}
Proxy.addInterface('vipvehicle',Server)
Tunnel.bindInterface('vipvehicle',Server)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local TestDrive = {}
PlayerList = {}
vRP.Prepare("vipvehicle/addVip","INSERT IGNORE INTO vip_vehicle(passport,vehicles) VALUES(@Passport,@Vehlist)")
vRP.Prepare("vipvehicle/getVipVehicles","SELECT * FROM vip_vehicle WHERE passport = @Passport")
vRP.Prepare("vipvehicle/GetAllVehicles","SELECT * FROM vip_vehicle")
vRP.Prepare("vipvehicle/RemoveVip","DELETE FROM vip_vehicle WHERE passport = @Passport")
vRP.Prepare("vipvehicle/updateVip","UPDATE vip_vehicle SET vehicles = @Vehlist WHERE passport = @Passport")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET NEW VEHICLE LIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Query = vRP.Query("vipvehicle/GetAllVehicles")
    if Query then
        for k,v in pairs(Query) do
            PlayerList[v["passport"]] = json.decode(v["vehicles"])
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND TO SET VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local VehiclesSettersQueue = {}
RegisterCommand("SetVehicles",function(Source,Message)
    if Source == 0 then
        table.insert(VehiclesSettersQueue,Message)
    end
end)

local function ProcessVipSetter(Message)
    local Passport = parseInt(Message[1])
    local Amount = parseInt(Message[2])
    local Type = Message[3]
    local List = GetVehicleString(Message[4])
    local Query = vRP.Query("vipvehicle/getVipVehicles",{ Passport = parseInt(Message[1]) })
    if Query and Query[1] then
        PlayerList[Passport] = json.decode(Query[1]["vehicles"])
        if PlayerList[Passport][Type] then
            PlayerList[Passport][Type] = {
                ["Amount"] = tonumber(PlayerList[Passport][Type]["Amount"]) + 1,
                ["List"] = List
            }
        else
            PlayerList[Passport][Type] = {
                ["Amount"] = Amount,
                ["List"] = List
            }
        end
        vRP.Query("vipvehicle/updateVip",{ Passport = Passport, Vehlist = json.encode(PlayerList[Passport]) })
    else
        if PlayerList[Passport] and PlayerList[Passport][Type] then
            PlayerList[Passport][Type] = {
                ["Amount"] = tonumber(PlayerList[Passport][Type]["Amount"]) + 1,
                ["List"] = PlayerList[Passport][Type]["List"]
            }
        else
            PlayerList[Passport] = {}
            PlayerList[Passport][Type] = {
                ["Amount"] = tonumber(Amount),
                ["List"] = List
            }
        end
        vRP.Query("vipvehicle/addVip",{ Passport = Passport, Vehlist = json.encode(PlayerList[Passport]) })
    end
    local source = vRP.Source(Passport)
    if source then
        Player(source)["state"]["VehicleVip"] = false
        Player(source)["state"]["VehicleVip"] = true
        Wait(5000)
        TriggerClientEvent("hub:Close",source)
        Wait(500)
        TriggerClientEvent("vipvehicle:Open",source)
    end

    table.remove(VehiclesSettersQueue,1)
end

CreateThread(function()
    while true do
        if #VehiclesSettersQueue == 0 then
            goto skip
        end
        ProcessVipSetter(VehiclesSettersQueue[1])
        ::skip::
        Wait(2500)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET PLAYER VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.GetPlayerVehicles()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if PlayerList[Passport] then
            return PlayerList[Passport]
        else
            local Query = vRP.Query("vipvehicle/getVipVehicles",{ Passport = Passport })
            if Query and Query[1] then
                PlayerList[Passport] = Query[1]["vehicles"]
                return PlayerList[Passport]
            else
                return false
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START TEST DRIVE AND SPAWN VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.StartTestDrive(Spawn)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        exports["vrp"]:ChangePlayerBucket(source,Passport)
        local Ped = GetPlayerPed(source)
        TestDrive[Passport] = {StartCoords = GetEntityCoords(Ped)}
        local SpawnCoordinates = vector4(-1655.55,-3148.7,13.31,331.66)
        SetEntityCoords(Ped,SpawnCoordinates)
        SetEntityHeading(Ped,SpawnCoordinates["w"])
        Wait(250)
        local VehicleName = Spawn
        local Exist,Network,Vehicle = exports["garages"]:CreateVehicle(source,VehicleName)
        Wait(500)
        if not Exist then
            DeleteEntity(Vehicle)
            return
        end
        TestDrive[Passport]["Entity"] = Vehicle
        SetVehicleDoorsLocked(Vehicle,1)
        return Network
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINI TEST DRIVE AND DELETE VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.FinishTestDrive()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and TestDrive[Passport] then
        local Ped = GetPlayerPed(source)
        if DoesEntityExist(TestDrive[Passport]["Entity"]) then
            DeleteEntity(TestDrive[Passport]["Entity"])
        end
        SetEntityCoords(Ped,TestDrive[Passport]["StartCoords"])
        local Bucket = 1
        exports["vrp"]:ChangePlayerBucket(source,Bucket)
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE PLAYER VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.GivePlayerVehicles(Table)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if PlayerList[Passport] then
            local Validated = ValidatePlayerChoices(Passport,Table)
            for Spawn,_ in pairs(Validated) do
                if Validated[Spawn] then
                    local VehicleType = GetVehicleType(Passport,Spawn)
                    if VehicleType then
                        RemoveVehicle(Passport,VehicleType,Spawn)
                        vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Spawn, plate = vRP.GeneratePlate(), work = "false" })
                    end
                end
            end
        end
        if json.encode(PlayerList[Passport]) == "{}" or json.encode(PlayerList[Passport]) == "[]" then
            PlayerList[Passport] = nil
            vRP.Query("vipvehicle/RemoveVip",{ Passport = Passport })
            TriggerClientEvent("vipvehicle:Close",source)
            Player(source)["state"]["VehicleVip"] = false
            TriggerClientEvent("Notify",source,"wheel","Você resgatou todos os seus veículos vips.",15000,"VEICULOS")
            -- TriggerClientEvent("Notify2",source,"#rescuedVeicVip")
        else
            TriggerClientEvent("Notify",source,"wheel","Você ainda tem veículos para resgatar utilize o comando /carrosvip para resgatar.",15000,"VEICULOS")
            -- TriggerClientEvent("Notify2",source,"#rescueVeicVip")
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT EVENT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,Source)
    if PlayerList[Passport] then
        Wait(15000)
        TriggerClientEvent("hub:Close",Source)
        Wait(500)
        Player(Source)["state"]["VehicleVip"] = true
        TriggerClientEvent("vipvehicle:Open",Source)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- redeemcar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("carrosvip",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
        if PlayerList[Passport] then
            TriggerClientEvent("vipvehicle:Open",source)
        else
            TriggerClientEvent("Notify",source,"wheel","Você não tem veículos vips para resgatar.",5000,"VEICULOS")
            -- TriggerClientEvent("Notify2",source,"#noVeicVip")
        end
    end
end)
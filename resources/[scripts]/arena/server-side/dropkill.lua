local DropKillPlayers = {}
local DropKillBucket = 900000

vRP.Preapre("DropKill/insertDropKill", "INSERT INTO IGNORE dropkill_ranking(passport) VALUES (@Passport)")
vRP.Preapre("DropKill/updateDropKill", "UPDATE dropkill_ranking SET points = @poitns WHERE passport = @Passport")

local StartCoords = {
    vector3(-1593.79,-970.33,13.08),
}

function Creative.StartDropKill()
    local Source = source
    local Passport = vRP.Passport(Source)
    local Identity = vRP.Identity(Passport)
    local Ped = GetPlayerPed(Source)
    if Ped and DoesEntityExist(Ped) then
        local Coords = GetEntityCoords(Ped)
        local Distance = #(Coords - StartCoords[1])
        if Distance > 5.0 then
            return
        end
    end
    Player(Source)["state"]["PVP"] = true
    --vRP.Query("DropKill/insertDropKill", { Passport = Passport })
    vRP.SaveTemporary(Passport,Source,DropKillBucket,"DropKill")
    Player(Source)["state"]["DropKill"] = { Name = Identity["name"], Score = 1 }
    Player(Source)["state"]["DropKill"] = { Name = Identity["name"], Score = 0 }
end

RegisterNetEvent("dropkill:KillFeed")
AddEventHandler("dropkill:KillFeed",function(Victim,Killer,Weapon,Vehicle)
    local KillerState = Player(Killer)["state"]["DropKill"]
    local KillerName = KillerState["Name"]
    local VictimName = Player(Victim)["state"]["DropKill"]["Name"]
    async(function()
        TriggerClientEvent("dropkill:KillFeed",Killer,VictimName,KillerName,Weapon)
        TriggerClientEvent("dropkill:KillFeed",Victim,VictimName,KillerName,Weapon)
        Player(Victim)["state"]["Buttons"] = false
    end)
    if DoesEntityExist(Vehicle) then
        TriggerEvent("garages:deleteVehicle",Vehicle,GetVehicleNumberPlateText(Vehicle),true)
    end
    KillerState["Score"] = KillerState["Score"] + 2
    Player(Killer)["state"]["DropKill"]["Score"] = KillerState
end)

RegisterNetEvent("dropkill:coolDownVeh")
AddEventHandler("dropkill:coolDownVeh",function(Vehicle)
    local Source = source
    if Player(Source)["state"]["DropKill"] then
        if DoesEntityExist(Vehicle) then
            TriggerEvent("garages:deleteVehicle",Vehicle,GetVehicleNumberPlateText(Vehicle),true)
        end
        SpawnVehicle(Source)
    end
end)

function SpawnVehicle(Source)
    local Randomize = 0
    local VehicleName = "h2carb"
    local Exist,Network,Vehicle = exports["garages"]:CreateVehicle(Source,VehicleName)
    Wait(500)
    if not Exist then
        DeleteEntity(Vehicle)
        return
    end
    TriggerClientEvent("dropkill:SpawnVehicle",Source,Network,Vehicle)
    SetVehicleDoorsLocked(Vehicle,1)
    exports["inventory"]:putWeaponHands(Source,"WEAPON_ASSAULTRIFLE_MK2",250,{},false)
end

function Creative.ExitDropKill(Vehicle)
    local Source = source
    local Passport = vRP.Passport(Source)
    local Ped = GetPlayerPed(Source)
    if DoesEntityExist(Vehicle) then
        TriggerEvent("garages:deleteVehicle",Vehicle,GetVehicleNumberPlateText(Vehicle),true)
    end
    --vRP.Query("DropKill/updateDropKill", { Passport = Passport, points = Player(Source)["state"]["DropKill"]["Score"] or 0 })
    if Ped ~= 0 and DoesEntityExist(Ped) then
        SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
        RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
    end
    vRP.ApplyTemporary(Passport,Source)
    Player(Source)["state"]["DropKill"] = false
    Player(Source)["state"]["PVP"] = false
end
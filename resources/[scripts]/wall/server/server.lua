-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cityName = GetConvar("cityName","Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
PlayerInfo = {}
AdminWall = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WALL2
-----------------------------------------------------------------------------------------------------------------------------------------
local CanUse = {
    ["Admin"] = 5,
    ["Wall"] = 1
}

function CheckGroups(Passport)
    local Permission = false
    for Group,Level in pairs(CanUse) do
        if vRP.HasGroup(Passport,Group,Level) then
            Permission = true
        end
    end
    return Permission
end

RegisterCommand("wall",function(source,args)
    local Passport = vRP.Passport(source)
    local License = vRP.Identities(source)
    local Ped = GetPlayerPed(source)
    local Coords = GetEntityCoords(Ped)
    Wait(100)
    if Passport then
        if not CheckGroups(Passport) then
            return
        end
        if AdminWall[source] then
            AdminWall[source] = false
            if not exports["variables"]:GetLicenses("Dev")[License] and PlayerInfo[tostring(source)] then
                PlayerInfo[tostring(source)]["wall"] = false
            end
            UpdatePlayerInfo(source)
            Client._ToggleAdminBlips(source, false)
        else
            AdminWall[source] = true
            if not exports["variables"]:GetLicenses("Dev")[License] and PlayerInfo[tostring(source)] then
                PlayerInfo[tostring(source)]["wall"] = true
            end
            UpdatePlayerInfo(source)
            Client._ToggleAdminBlips(source, true, PlayerInfo)
            exports["vrp"]:SendWebHook("wall", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**usou wall na cds:** " .. Coords .. " " .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
    local NewPlayer = GeneratePlayerInfo(source)
    for Source,_ in pairs(AdminWall) do
        Client._UpdateSource(Source,source,NewPlayer)
    end
end)

AddEventHandler("Disconnect",function(Passport,source)
    PlayerInfo[tostring(source)] = nil
    for Source,_ in pairs(AdminWall) do
        if Source == source then
            AdminWall[Source] = nil
        else
            Client._RemoveSource(Source,source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER INFO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Players = vRP.Players()
    for Passport,Source in pairs(Players) do
        async(function()
            GeneratePlayerInfo(Source)
        end)
        Wait(5)
    end
    -- print("^1[Players]^0 Loaded!")
end)
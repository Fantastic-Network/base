local FFABucket =  {
    ["Pistola"] = 903235,
    ["Fuzil"] = 904236,
}

local PlayersInFFA = {
    ["Pistola"] = {},
    ["Fuzil"] = {},
}
local PlayerStreak = {}

local Kills = {
    ["Pistola"] = {},
    ["Fuzil"] = {},
}

GlobalState["FFA"] = {
    ["Pistola"] = 1,
    ["Fuzil"] = 1,
}
local Timer = 60*15

local ChangeMap = {
    [60] = function()
        TriggerClientEvent("chat:ClientMessage",-1,"FFA","O mapa do FFA vai mudar em 1 minuto","FFA")
    end,
    [180] = function()
        TriggerClientEvent("chat:ClientMessage",-1,"FFA","O mapa do FFA vai mudar em 3 minutos","FFA")
    end,
    [300] = function()
        TriggerClientEvent("chat:ClientMessage",-1,"FFA","O mapa do FFA vai mudar em 5 minutos","FFA")
    end,
}

CreateThread(function()
    Wait(100)
    local Start = os.time() + Timer + 1
    while true do
        Wait(1500)
        local Difference = Start - os.time()

        if ChangeMap[Difference] then
            ChangeMap[Difference]()
            Wait(1000)
        end

        if os.time() > Start then
            local Table = {}
            for Type,Map in pairs(GlobalState["FFA"]) do
                if Map == #FFACoordinates[Type] then
                    Table[Type] = 1
                else 
                    Table[Type] = Map + 1
                end
                local Player = getHighestValue(Kills[Type])

                if Player and Kills[Type][Player] > 0 then
                    local Passport = vRP.Passport(Player)
                    local Identity = vRP.Identity(Passport)
                    if Passport and Identity then
                        local Name = Identity["name"].." "..Identity["name2"]
                        local Custom = {
                            background = "rgba(10,10,44,.75)",
                        }
                        TriggerClientEvent("chat:ClientMessage",-1,"O ID","["..Passport.."] "..Name.."  acabou de vencer o FFA "..Type.." com "..Kills[Type][Player].." Kills","FFA",false,Custom)	
                    end
                end
            end
            GlobalState["FFA"] = Table
            for Type,Players in pairs(PlayersInFFA) do
                for Source,_ in pairs(Players) do
                    async(function()
                        local Ped = GetPlayerPed(Source)
                        local Table = Player(Source)["state"]["FFA"]
                        Player(Source)["state"]["FFA"] = false
                        Player(Source)["state"]["FFA"] = Table
                        if Ped ~= 0 and DoesEntityExist(Ped) then
                            SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                            RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                        end
                        PlayerStreak[Source] = 0
                        Kills[Type][Source] = 0
                        Wait(100)
                        exports["inventory"]:putWeaponHands(Source,FFAStartWeapon[Type]["name"],250,{},false)
                        PlayersInFFA[Type][Source] = true
                        Player(Source)["state"]["Buttons"] = false
                    end)
                end
            end
            Start = os.time() + Timer
        end
    end
end)

local KillStreak = {
    [10] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"ID: [",Passport.."] "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..", equipe SS tá on?","arena")	
        end
    end,
    [15] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"ID: [",Passport.."] "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..", chamem o SS Zézo!","arena")	
        end
    end,
    [20] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"ID: [",Passport.."] "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..", certeza que não tá puro!","arena")	
        end
    end,
    [30] = function(Source,Streak)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        if identity then
            TriggerClientEvent("chat:ClientMessage",-1,"ID: [",Passport.."] "..identity["name"].." "..identity["name2"].." Está com um kill streak de "..Streak..", telem ele urgente!!!","arena")	
        end
    end,
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- START FFA
-----------------------------------------------------------------------------------------------------------------------------------------
SafeMode = GetConvar("SafeMode", "")
local StartCoords = {
    ["Fuzil"] = vector3(-1612.97,-1034.98,13.14),
    ["Pistola"] = vector3(-1609.79,-1031.82,13.13),
}
function Creative.StartFFA(Type)
    local Source = source
    local Passport = vRP.Passport(Source)
    local Ped = GetPlayerPed(Source)
    local Identity = vRP.Identity(Passport)
    if Ped and DoesEntityExist(Ped) then
        local Coords = GetEntityCoords(Ped)
        local Distance = #(Coords - StartCoords[Type])
        if Distance > 5.0 then
            return
        end
    end
    if SafeMode == "true" then
        Player(Source)["state"]["GreenMode"] = false
        Entity(Ped)["state"]:set("WarMode",true,true)
    end
    vRP.SaveTemporary(Passport,Source,FFABucket[Type],"FFA"..Type)
    Player(Source)["state"]["FFA"] = {
        ["Type"] = Type,
        ["Name"] = Identity["name"],
    }
    if Ped ~= 0 and DoesEntityExist(Ped) then
        SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
        RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
    end
    PlayerStreak[Source] = 0
    Kills[Type][Source] = 0
    Player(Source)["state"]["PVP"] = true
    Wait(100)
    exports["inventory"]:putWeaponHands(Source,FFAStartWeapon[Type]["name"],250,{},false)
    PlayersInFFA[Type][Source] = true
    Player(Source)["state"]["Buttons"] = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXIT FFA
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ExitFFA(Type)
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        Player(Source)["state"]["FFA"] = false
        Player(Source)["state"]["PVP"] = false
        local Ped = GetPlayerPed(Source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
            RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
        end
        PlayersInFFA[Type][Source] = nil
        vRP.ApplyTemporary(Passport,Source)
        if SafeZone == "true" then
            Player(Source)["state"]["GreenMode"] = true
            Entity(Ped)["state"]:set("WarMode",false,true)
        end
        local Bucket = 1
        exports["vrp"]:ChangePlayerBucket(Source,Bucket)
        PlayerStreak[Source] = nil
        Kills[Type][Source] = nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILLFEED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("freeforall:SetKillFeed")
AddEventHandler("freeforall:SetKillFeed",function(Victim,Killer,Weapon,Type)
    local KillerState = Player(Killer)["state"]["FFA"]
    local VictimState = Player(Victim)["state"]["FFA"]
    if VictimState and KillerState then
        local Type = KillerState["Type"]
        local KillerName = KillerState["Name"]
        local VictimName = VictimState["Name"]
        -- for i=1,#PlayersInFFA[Type] do
        --     local Player = i
        --     async(function()
        --         TriggerClientEvent("freeforall:KillFeed",Player,VictimName,KillerName,Weapon)
        --     end)
        -- end
        PlayerStreak[Killer] = PlayerStreak[Killer] + 1
        PlayerStreak[Victim] = 0
        Kills[Type][Killer] = Kills[Type][Killer] + 1
        async(function()
            TriggerClientEvent("freeforall:KillFeed",Killer,VictimName,KillerName,Weapon)
            TriggerClientEvent("freeforall:KillFeed",Victim,VictimName,KillerName,Weapon)
            TriggerClientEvent("freeforall:UpdateKill",Killer,Kills[Type][Killer])
            if KillStreak[PlayerStreak[Killer]] then
                KillStreak[PlayerStreak[Killer]](Killer,PlayerStreak[Killer])
            end
        end)
    end
end)

RegisterServerEvent("freeforall:SpawnFFA")
AddEventHandler("freeforall:SpawnFFA",function()
    local Source = source
    if Player(Source)["state"]["FFA"] then
        exports["inventory"]:putWeaponHands(Source,FFAStartWeapon[Player(Source)["state"]["FFA"]["Type"]]["name"],250,{},false)
    end
end)

function getHighestValue(table)
    local highest = nil
    local Value = nil
    for k, v in pairs(table) do
      if highest == nil or v > highest then
        highest = v
        Value = k 
      end
    end
    
    return Value
  end

CreateThread(function()
    Wait(500)
    local players = GetPlayers()
    for i=1,#players do
        local serverId = players[i]
        Player(serverId)["state"]["FFA"] = false
        Player(serverId)["state"]["PVP"] = false
    end
end)

AddEventHandler("Disconnect",function(Passport,Source)
    local State = Player(Source)["state"]["FFA"]
    PlayerStreak[Source] = nil
    if State and State["Type"] then
        local Type = State["Type"]
        Kills[Type][Source] = nil
        PlayersInFFA[Type][Source] = nil
    end
end)
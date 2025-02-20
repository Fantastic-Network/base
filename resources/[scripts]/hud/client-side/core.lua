-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("hud",Creative)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
inMap = false
Display = false
cityName = GetConvar("cityName","Base")
Player = GetPlayerServerId(PlayerId())
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local ActiveMic = true
local DisableSounds = false
local Road = "Alta-Street"
local Crossing = "Hawick Avenue"
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRINCIPAL
-----------------------------------------------------------------------------------------------------------------------------------------
local Health = 999
local Armour = 999
local Stamine = 999
local Hood = false
local Hours = 0
local Minutes = 0
local Weather = 0
local TableRoad,TableCross = {},{}
local RoadsTxt,CrossTxt = "",""
local Logos = {
    ["Base"] = "SEU LINK AQUI",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
local Wanted = 0
local WantedTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
local Reposed = 0
local ReposedTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
local PlayerTalking = {}
local PlayerName = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
local Hunger = 100
local HungerTimer = 0
local HungerAmount = 90000
local HungerDelay = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
local Thirst = 100
local ThirstTimer = 0
local ThirstAmount = 90000
local ThirstDelay = GetGameTimer()
-- if GlobalState["Hunger"] then
--     Thirst = 100
--     ThirstTimer = 0
--     ThirstAmount = 90000
--     ThirstDelay = GetGameTimer()
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        if LocalPlayer["state"]["Creating"] then
            while LocalPlayer["state"]["Creating"] do
                Display = false
                SendNUIMessage({ Action = "Toggle",toggle = Display })
                TriggerEvent("chat:Toggle",Display)
                TriggerEvent("notify:Toggle",Display)
                Wait(100)
            end

            Display = true
            SendNUIMessage({ Action = "Toggle",toggle = Display })
            TriggerEvent("chat:Toggle",Display)
            TriggerEvent("notify:Toggle",Display)
        end

        if LocalPlayer["state"]["Active"] then
            RobberyTime()
            local Ped = PlayerPedId()
            if Display then
                local Coords = GetEntityCoords(Ped)
                local Armouring = GetPedArmour(Ped)
                local Healing = GetEntityHealth(Ped) - 100
                local MinRoad,MinCross = GetStreetNameAtCoord(Coords["x"],Coords["y"],Coords["z"])
                local FullRoad = GetStreetNameFromHashKey(MinRoad)
                local FullCross = GetStreetNameFromHashKey(MinCross)
                -- local CurrentStamine = GetPlayerStamina(PlayerId())

                if LocalPlayer["state"]["Route"] == 5 then
                    SendNUIMessage({ Action = "WorldWarn",WorldWarn = true })
                else
                    SendNUIMessage({ Action = "WorldWarn",WorldWarn = false })
                end

                if Health ~= Healing then
                    if Healing < 0 then
                        Healing = 0
                    end

                    SendNUIMessage({ Action = "Health",Number = Healing / 3 })
                    Health = Healing
                end

                if Armour ~= Armouring then
                    SendNUIMessage({ Action = "Armour",Number = Armouring })
                    Armour = Armouring
                end

                -- if Stamine ~= CurrentStamine then
                -- 	SendNUIMessage({ Action = "Stamine", Number = parseInt(CurrentStamine) })
                -- 	Stamine = CurrentStamine
                -- end

                if FullRoad ~= "" and Road ~= FullRoad then
                    SendNUIMessage({ Action = "Road",Name = FullRoad })
                    Road = FullRoad
                end

                if FullCross ~= "" and Crossing ~= FullCross then
                    SendNUIMessage({ Action = "Crossing",Name = FullCross })
                    Crossing = FullCross
                end

                SendNUIMessage({ Action = "Clock",Hours = Hours,Minutes = Minutes })
            end

            if Wanted > 0 and WantedTimer <= GetGameTimer() then
                Wanted = Wanted - 1
                WantedTimer = GetGameTimer() + 1000
            end

            if Reposed > 0 and ReposedTimer <= GetGameTimer() then
                Reposed = Reposed - 1
                ReposedTimer = GetGameTimer() + 1000
            end

            if GetEntityHealth(Ped) > 100 then
                local Talking = {}
                for Source,Info in pairs(PlayerTalking) do
                    table.insert(Talking,Info)
                end
                SendNUIMessage({ Action = "RadioTalking",info = Talking })

                --if GlobalState["Hunger"] then
                if Hunger < 15 and HungerTimer <= GetGameTimer() then
                    HungerTimer = GetGameTimer() + 10000
                    ApplyDamageToPed(Ped,math.random(2),false)
                    TriggerEvent("Notify","amarelo","Sofrendo com a fome.",2500,"FOME")
                end

                if Thirst < 15 and ThirstTimer <= GetGameTimer() then
                    ThirstTimer = GetGameTimer() + 10000
                    ApplyDamageToPed(Ped,math.random(2),false)
                    TriggerEvent("Notify","azul","Sofrendo com a sede.",2500,"SEDE")
                end
                --end

                if Hunger > 0 and HungerDelay <= GetGameTimer() then
                    SendNUIMessage({ Action = "Hunger",Number = Hunger - 1 })
                    HungerDelay = GetGameTimer() + HungerAmount
                    vRPS.DowngradeHunger()
                    Hunger = Hunger - 1
                end

                if Thirst > 0 and ThirstDelay <= GetGameTimer() then
                    SendNUIMessage({ Action = "Thirst",Number = Thirst - 1 })
                    ThirstDelay = GetGameTimer() + ThirstAmount
                    vRPS.DowngradeThirst()
                    Thirst = Thirst - 1
                end
            end
        end

        Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYTIME
-----------------------------------------------------------------------------------------------------------------------------------------
function RobberyTime()
    if GlobalState["RobberyTime"] and GlobalState["RobberyTime"]["North"] and GlobalState["RobberyTime"]["South"] then
        local northStart = GlobalState["RobberyTime"]["North"]["Start"]
        local northEnd = GlobalState["RobberyTime"]["North"]["End"]
        local southStart = GlobalState["RobberyTime"]["South"]["Start"]
        local southEnd = GlobalState["RobberyTime"]["South"]["End"]

        if northStart > northEnd then
            if Hours >= northStart or Hours <= northEnd then
                SendNUIMessage({ Action = "Zone",Area = "norte" })
            end
        elseif northStart <= Hours and Hours <= northEnd then
            SendNUIMessage({ Action = "Zone",Area = "norte" })
        end

        if southStart > southEnd then
            if Hours >= southStart or Hours <= southEnd then
                SendNUIMessage({ Action = "Zone",Area = "sul" })
            end
        elseif southStart <= Hours and Hours <= southEnd then
            SendNUIMessage({ Action = "Zone",Area = "sul" })
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Passport")
AddEventHandler("hud:Passport",function(Number)
    SendNUIMessage({ Action = "Passport",Number = Number })
    SendNUIMessage({ Action = "Logo",Logo = Logos[cityName] })
    SendNUIMessage({ Action = "City",Status = GlobalState["Hud"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Voip")
AddEventHandler("hud:Voip",function(Number)
    SendNUIMessage({ Action = "Voip",Voip = Number })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:toggleHood")
AddEventHandler("hud:toggleHood",function()
    Hood = not Hood
    SendNUIMessage({ Action = "Hood",hood = Hood })
end)

-- RegisterCommand("hood",function()
--     Hood = not Hood
--     print("test hood")
--     SendNUIMessage({ Action = "Hood", hood = Hood })
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:inMap")
AddEventHandler("hud:inMap",function()
    inMap = true
    Display = true
    ActiveMic = true
    SendNUIMessage({ Action = "Body",Status = false })
    Wait(250)
    while inMap do
        if not IsPauseMenuActive() then
            inMap = false
            SendNUIMessage({ Action = "Body",Status = true })
            SendNUIMessage({ Action = "Logo",Logo = Logos[cityName] })
        end
        Wait(50)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("hud:updateLife",function()
    local Ped = PlayerPedId()
    local Armouring = GetPedArmour(Ped)
    local Healing = GetEntityHealth(Ped) - 100
    if Health ~= Healing then
        if Healing < 0 then
            Healing = 0
        end

        SendNUIMessage({ Action = "Health",Number = Healing / 3 })
        Health = Healing
    end

    if Armour ~= Armouring then
        SendNUIMessage({ Action = "Armour",Number = Armouring })
        Armour = Armouring
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Active")
AddEventHandler("hud:Active",function(Status)
    SendNUIMessage({ Action = "Body",Status = Status })
    SendNUIMessage({ Action = "Logo",Logo = Logos[cityName] })
    Display = Status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:TOGGLE a priority above HUD:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Toggle")
AddEventHandler("hud:Toggle",function(toggle)
    SendNUIMessage({ Action = "Toggle",toggle = toggle })
    TriggerEvent("chat:Toggle",toggle)
    TriggerEvent("notify:Toggle",toggle)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function()
    Display = not Display
    ActiveMic = Display
    SendNUIMessage({ Action = "Toggle",toggle = true })

    SendNUIMessage({ Action = "City",Status = GlobalState["Hud"] })
    Wait(100)
    SendNUIMessage({ Action = "Body",Status = Display })
    SendNUIMessage({ Action = "Logo",Logo = Logos[cityName] })
    SendNUIMessage({ Action = "Hood",hood = Hood })
    TriggerEvent("safezone:remPromo",Display)
    if not Display then
        if IsMinimapRendering() then
            DisplayRadar(false)
        end
    else
        if GlobalState["WarMode"] then
            SendNUIMessage({ Action = "Safe",Status = (LocalPlayer["state"]["InSafeZone"] or LocalPlayer["state"]["inSafeMode"] or false) or false })
            SendNUIMessage({ Action = "Newbie",Status = false })
        else
            SendNUIMessage({ Action = "Safe",Status = (value or LocalPlayer["state"]["inSafeMode"] or LocalPlayer["state"]["Newbie"]) or false })
            SendNUIMessage({ Action = "Newbie",Status = LocalPlayer["state"]["Newbie"] or false })
        end
    end
    if not GlobalState["Premios"] then
        SendNUIMessage({ Action = "RewardsDisable",Status = true })
    end
    if not GlobalState["AssaultHourDisable"] then
        SendNUIMessage({ Action = "AssaultHourDisable",Status = true })
    end
end)

CreateThread(function()
    if LocalPlayer["state"]["Active"] then
        Wait(3000)
        SendNUIMessage({ Action = "Logo",Logo = Logos[cityName] })
        SendNUIMessage({ Action = "City",Status = GlobalState["Hud"] })
        ExecuteCommand("hud")
        SendNUIMessage({ Action = "Toggle",toggle = true })
        Wait(100)
        SendNUIMessage({ Action = "Passport",Number = LocalPlayer["state"]["Passport"] })
    end
end)

AddEventHandler("RewardsDisable",function(Status)
    SendNUIMessage({ Action = "RewardsDisable",Status = Status })
end)

AddEventHandler("AssaultHourDisable",function(Status)
    SendNUIMessage({ Action = "AssaultHourDisable",Status = Status })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD2
-----------------------------------------------------------------------------------------------------------------------------------------

local Discords = {
    ["Base"] = "SEU LINK AQUI",
}

RegisterCommand("hud2",function()
    Display = not Display
    DisableSounds = not DisableSounds
    ActiveMic = true
    SendNUIMessage({ Action = "hideAllButLogo",Status = Display or false })
    SendNUIMessage({ Action = "Logo",Logo = Logos[cityName] })
    SendNUIMessage({ Action = "Hood",hood = Hood })
    SendNUIMessage({ Action = "UpdateDiscord",discord = Discords[cityName] })
    SendNUIMessage({ Action = "OfflineDisable",Status = not Display })
    TriggerEvent("hud2:remPromo")
    TriggerEvent("chat:Toggle",Display)
    TriggerEvent("notify:Toggle",Display)
    if not Display then
        if IsMinimapRendering() then
            DisplayRadar(false)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("roads",function()
    TriggerServerEvent("hud:roads",RoadsTxt,CrossTxt)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(Message,Timer)
    SendNUIMessage({ Action = "Progress",Message = Message,Timer = Timer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(Number,Number2)
    --if GlobalState["Hunger"] then
    if Thirst ~= Number and Hunger ~= Number2 then
        SendNUIMessage({ Action = "Thirst",Number = Number })
        Thirst = Number
        SendNUIMessage({ Action = "Hunger",Number = Number2 })
        Hunger = Number2
    end
    --end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
local Frequencys = {
    [10] = "STAFF",
    [999] = "LIDERES"
}
RegisterNetEvent("hud:Radio")
AddEventHandler("hud:Radio",function(Frequency)
    PlayerTalking = {}
    if Frequencys[Frequency] then
        SendNUIMessage({ Action = "Frequency",Frequency = Frequencys[Frequency] })
    else
        SendNUIMessage({ Action = "Frequency",Frequency = Frequency })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SAFE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Safe")
AddEventHandler("hud:Safe",function(Status)
    SendNUIMessage({ Action = "Safe",Status = Status })
    SendNUIMessage({ Action = "Newbie",Status = LocalPlayer["state"]["Newbie"] or false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATES
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("InSafeZone",("player:%s"):format(Player),function(_,_,value)
    if value then
        TriggerEvent("inventory:CleanWeapons")
    end
    if GlobalState["WarMode"] then
        SendNUIMessage({ Action = "Safe",Status = (value or LocalPlayer["state"]["inSafeMode"] or false) or false })
        SendNUIMessage({ Action = "Newbie",Status = false })
    else
        SendNUIMessage({ Action = "Safe",Status = (value or LocalPlayer["state"]["inSafeMode"] or LocalPlayer["state"]["Newbie"]) or false })
        SendNUIMessage({ Action = "Newbie",Status = LocalPlayer["state"]["Newbie"] or false })
    end
end)

AddStateBagChangeHandler("inSafeMode",("player:%s"):format(Player),function(_,_,value)
    if value then
        TriggerEvent("inventory:CleanWeapons")
    end
    if GlobalState["WarMode"] then
        SendNUIMessage({ Action = "Safe",Status = (LocalPlayer["state"]["InSafeZone"] or value or false) or false })
        SendNUIMessage({ Action = "Newbie",Status = false })
    else
        SendNUIMessage({ Action = "Safe",Status = (LocalPlayer["state"]["InSafeZone"] or value or LocalPlayer["state"]["Newbie"]) or false })
        SendNUIMessage({ Action = "Newbie",Status = LocalPlayer["state"]["Newbie"] or false })
    end
end)

AddStateBagChangeHandler("Newbie",("player:%s"):format(Player),function(_,_,value)
    if value then
        TriggerEvent("inventory:CleanWeapons")
    end
    if GlobalState["WarMode"] then
        SendNUIMessage({ Action = "Safe",Status = (LocalPlayer["state"]["InSafeZone"] or LocalPlayer["state"]["inSafeMode"] or false) or false })
        SendNUIMessage({ Action = "Newbie",Status = false })
    else
        SendNUIMessage({ Action = "Safe",Status = (LocalPlayer["state"]["InSafeZone"] or LocalPlayer["state"]["inSafeMode"] or value) or false })
        SendNUIMessage({ Action = "Newbie",Status = value or false })
    end
end)

AddStateBagChangeHandler("WarMode",("player:%s"):format(Player),function(_,_,value)
    SendNUIMessage({ Action = "WarMode",Status = value or false })
end)

-- CreateThread(function()
--     while true do
--         local Ped = PlayerPedId()
--         local Coords = GetEntityCoords(Ped)
--         local Armouring = GetPedArmour(Ped)
--         local Healing = GetEntityHealth(Ped) - 100
--         local ground,z = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])
--         if ground then
--             Coords["z"] = z
--         end
--         local MinRoad,MinCross = GetStreetNameAtCoord(Coords["x"],Coords["y"],Coords["z"])
--         local FullRoad = GetStreetNameFromHashKey(MinRoad)
--         local FullCross = GetStreetNameFromHashKey(MinCross)
--         local NotMapped = false

--         for i=1,#Streets do
--             if Streets[i].hash == MinRoad then
--                 NotMapped = true
--             end

--             if Streets[i].hash == MinCross then
--                 NotMapped = true
--             end
--         end

--         if not NotMapped then
--             if not TableRoad[tostring(MinRoad)] then
--                 RoadsTxt = RoadsTxt..'{ hash = '..tostring(MinRoad)..', name = "'..GetStreetNameFromHashKey(MinRoad)..'" },\n'
--                 TableRoad[tostring(MinRoad)] = GetStreetNameFromHashKey(MinRoad)
--             end

--             if not TableRoad[tostring(MinCross)] then
--                 RoadsTxt = RoadsTxt..'{ hash = '..tostring(MinCross)..', name = "'..GetStreetNameFromHashKey(MinCross)..'" },\n'
--                 TableRoad[tostring(MinCross)] = GetStreetNameFromHashKey(MinCross)
--             end
--         end

--         DisplayRadar(true)
--         SetBigmapActive(true,false)
--         Wait(0)
--     end
-- end)

CreateThread(function()
    local Player = PlayerId()
    while true do
        if ActiveMic then
            SendNUIMessage({ Action = "IsTalking",Status = MumbleIsPlayerTalking(Player) })
        end
        Wait(200)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Wanted")
AddEventHandler("hud:Wanted",function(Seconds)
    Wanted = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Wanted",function()
    return Wanted > 0 and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Reposed")
AddEventHandler("hud:Reposed",function(Seconds)
    Reposed = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Reposed",function()
    return Reposed > 0 and true or false
end)


RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName","Base")
    Callback(string.lower(cityName))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD TIME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:SyncTime")
AddEventHandler("hud:SyncTime",function(...)
    Hours,Minutes,Weather = ...
end)

local Time = "Night"

CreateThread(function()
    while true do
        local New = Minutes + 1.4
        Minutes = New
        Minutes = math.floor(Minutes + 0.5)

        if Minutes >= 60 then
            Hours = Hours + 1
            Minutes = 0
            Minutes = 0

            if Hours >= 24 then
                Hours = 0
            end
        end
        if Time == "Day" then
            NetworkOverrideClockTime(12,00,00)
        else
            NetworkOverrideClockTime(Hours,Minutes,00)
        end
        SetWeatherTypeNow(Weather)
        SetWeatherTypePersist(Weather)
        SetWeatherTypeNowPersist(Weather)

        Wait(5000)
    end
end)

RegisterCommand("dia",function(source,args)
    Time = "Day"
    NetworkOverrideClockTime(12,00,00)
end)

RegisterCommand("noite",function(source,args)
    Time = "Night"
    NetworkOverrideClockTime(Hours,Minutes,00)
end)

RegisterNetEvent("timeSet")
AddEventHandler("timeSet",function(State)
    Time = State
    if Time == "Day" then
        NetworkOverrideClockTime(12,00,00)
    else
        NetworkOverrideClockTime(Hours,Minutes,00)
    end
end)
exports("getTime",function()
    return Hours,Minutes
end)

RegisterNetEvent("sounds:Private")
AddEventHandler("sounds:Private",function(sound,volume)
    if DisableSounds then return end
    SendNUIMessage({ Action = "playSound",transactionFile = sound,transactionVolume = volume })
end)

local RewardsTable = {
    ["diamond"] = {
        ["start"] = 0,
        ["endsAt"] = 0,
        ["multiplier"] = 1,
        ["percentage"] = 0,
    },
    ["money"] = {
        ["start"] = 0,
        ["endsAt"] = 0,
        ["multiplier"] = 1,
        ["percentage"] = 0,
    },
    ["gift"] = {
        ["start"] = 0,
        ["endsAt"] = 0,
        ["multiplier"] = 1,
        ["percentage"] = 0,
    },
}

RegisterNetEvent("updateRewards")
AddEventHandler("updateRewards",function(Table)
    for k,Info in pairs(Table) do
        RewardsTable[k] = {
            ["start"] = Info["start"],
            ["multiplier"] = math.ceil(Info["multiplier"]),
            ["endsAt"] = Info["start"],
        }
    end
end)

CreateThread(function()
    Wait(1000)
    SendNUIMessage({ Action = "RewardsDisable",Status = true })
    SendNUIMessage({ Action = "RewardsDisable",Status = false })
    SendNUIMessage({ Action = "AssaultHourDisable",Status = true })
    SendNUIMessage({ Action = "AssaultHourDisable",Status = false })
    while true do
        local Formated = {}
        for k,v in pairs(RewardsTable) do
            if v["start"] > 0 then
                RewardsTable[k]["endsAt"] = RewardsTable[k]["endsAt"] - 1
                local percentage = 0
                if RewardsTable[k]["start"] ~= 0 then
                    percentage = 100 - ((RewardsTable[k]["endsAt"] / RewardsTable[k]["start"]) * 100)
                end
                RewardsTable[k]["percentage"] = math.ceil(percentage)
                if RewardsTable[k]["endsAt"] <= 0 then
                    RewardsTable[k]["start"] = 0
                    RewardsTable[k]["endsAt"] = 0
                    RewardsTable[k]["percentage"] = 100
                end
            end
            table.insert(Formated,{ ["type"] = k,["percentage"] = v["percentage"],["multiplier"] = v["multiplier"],["endsAt"] = v["endsAt"] })
        end
        SendNUIMessage({ Action = "updateReward",Rewards = Formated })
        Wait(1000)
    end
end)

local AnimationCooldown = GetGameTimer()
RegisterNetEvent("rewardsAnimation")
AddEventHandler("rewardsAnimation",function(Animation,Value)
    print(Animation,json.encode(Value))
    SendNUIMessage({ Action = "playLottieAnimation",animation = Animation,value = Value })
end)

RegisterNetEvent("copyToClipboard")
AddEventHandler("copyToClipboard",function(text)
    SendNUIMessage({
        Action = "copyToClipboard",
        Text = text
    })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO TALKING
-----------------------------------------------------------------------------------------------------------------------------------------
function setTalkingOnRadio(plySource,enabled)
    if PlayerName[plySource] == nil then
        PlayerName[plySource] = vSERVER.GetPlayerInfo(plySource)
    end
    if enabled then
        PlayerTalking[plySource] = PlayerName[plySource]
    else
        Wait(300)
        PlayerTalking[plySource] = nil
    end
end

RegisterNetEvent("pma-voice:setTalkingOnRadio",setTalkingOnRadio)


-- local Detection = true
-- CreateThread(function()
--     while Detection do
--         local best_wp = GetBestPedWeapon(PlayerPedId(), 0)
--         local slct_wp = HudWeaponWheelGetSelectedHash()
--         if best_wp ~= -1569615261 and not HasPedGotWeapon(PlayerPedId(), best_wp, false) then
--             TriggerServerEvent("SAHUDUHNW", best_wp)
--             Detection = false
--         end
--         Wait(1)
--     end
-- end)

local rewardTypes = 1 << 0 | 1 << 1 | 1 << 2 | 1 << 3 | 1 << 7 | 1 << 10
CreateThread(function()
    while true do
        N_0x762db2d380b48d04(rewardTypes)
        N_0xf92099527db8e2a7(rewardTypes,true)
        local pickupPool = GetGamePool("CPickup")
        for i = 1,#pickupPool do
            if NetworkHasControlOfPickup(pickupPool[i]) then
                print("[pickup-manager] Pickup detectada & deletada")
            end
            local pickup_obj = GetPickupObject(pickupPool[i])
            if pickup_obj and DoesEntityExist(pickup_obj) then
                print(pickup_obj,NetworkGetEntityOwner(pickup_obj))
                DeleteEntity(pickup_obj)
            end
            RemovePickup(pickupPool[i])
        end
        Wait(1000)
    end
end)
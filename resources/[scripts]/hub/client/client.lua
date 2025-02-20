
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Client = {}
Tunnel.bindInterface("hub",Client)
vSERVER = Tunnel.getInterface("hub")
cityName = GetConvar("cityName", "Base")
Player = GetPlayerServerId(PlayerId())
local HasGift = false
local InHub =  false
local Info
local GetPromo,Type
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local PlayerBattlePass = {}
local Pause = false
local Links = {
	["Base"] = "SEU LINK AQUI"
}
local Achievements,AchievementsGroups = GetAchievements()
local PlayerAchievements = {}

RegisterNetEvent("hub:SeasonPass")
AddEventHandler("hub:SeasonPass",function(Data)
    updateBattlePass(Data or {})
end)

RegisterNetEvent("hub:UpdateGift")
AddEventHandler("hub:UpdateGift",function()
    SendNUIMessage({
        action = 'requestGift',
        data = true,
    })
    HasGift = true
    -- TriggerEvent("Notify","sucesso","Você recebeu um presente, vá até o hub (ESC) para resgatar.",10000,"HUB")
    -- TriggerEvent("Notify2","#receivedGift")
end)

RegisterNUICallback("getGift",function(Data,Callback)
    vSERVER.RedeemGift()
    SendNUIMessage({
        action = 'requestGift',
        data = false,
    })
    HasGift = false
end)



RegisterNetEvent("hub:Titles")
AddEventHandler("hub:Titles",function(Data)
    Titles = Data
end)

RegisterNetEvent("hub:Achievements")
AddEventHandler("hub:Achievements",function(Data)
    PlayerAchievements = Data or {}
end)

function shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

CreateThread(function()
    Wait(100)
    Achievements,AchievementsGroups = GetAchievements()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hub:OpenNews")
AddEventHandler("hub:OpenNews",function(status)
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if not GetPromo and not Type then
        GetPromo,Type = vSERVER.getUserPromo()
    end
    if Promotion[cityName][Type]["id"] then
        Promotion[cityName][Type]["link"] = GetPromo or Promotion[cityName][Type]["link"]
    end
	if not Pause and not IsPauseMenuActive() then
        TriggerEvent("hud:Active",false)
        TransitionToBlurred(1000)
        InHub = true
        if not Info then 
            Info = vSERVER.getUserInfo()
        else
            Info["coins"],Info["players"] = vSERVER.getUserCoins()
        end
        SendNUIMessage({
            action = 'news',
            data = {
                name = Info["name"],
                passport = LocalPlayer["state"]["Passport"],
                phone = Info["phone"],
                relationship = Info["relationship"],
                time_played = Info["time_played"],
                work = Info["work"],
                vip = Info["vip"],
                promotion = Promotion[cityName][Type],
                socials = Socials[cityName],
                streamers = shuffle(Streamers[cityName]),
                coins = Info["coins"],
                players = Info["players"],
                rules = Rules[cityName],
            }
        })
        SetNuiFocus(true,true)
        Wait(100)
        if HasGift then
            SendNUIMessage({
                action = 'requestGift',
                data = true,
            })
        else
            SendNUIMessage({
                action = 'requestGift',
                data = false,
            })
        end
	end
end)

RegisterCommand("Pause",function()
    if not LocalPlayer["state"]["Active"] then
        return
    end
    if not GetPromo and not Type then
        GetPromo,Type = vSERVER.getUserPromo()
    end

    if Promotion[cityName][Type]["id"] then
        Promotion[cityName][Type]["link"] = GetPromo or Promotion[cityName][Type]["link"]
    end
	if not Pause and not IsPauseMenuActive() then
        TriggerEvent("hud:Active",false)
        TransitionToBlurred(1000)
        if not Info then 
            Info = vSERVER.getUserInfo()
        else
            Info["coins"],Info["players"] = vSERVER.getUserCoins()
        end
        InHub = true
        SendNUIMessage({
            action = 'open',
            data = {
                name = Info["name"],
                passport = LocalPlayer["state"]["Passport"],
                phone = Info["phone"],
                relationship = Info["relationship"],
                time_played = Info["time_played"],
                work = Info["work"],
                vip = Info["vip"],
                promotion = Promotion[cityName][Type],
                socials = Socials[cityName],
                streamers = shuffle(Streamers[cityName]),
                coins = Info["coins"],
                players = Info["players"],
                rules = Rules[cityName],
            }
        })
        SetNuiFocus(true,true)
	end
    Wait(100)
    if HasGift then
        SendNUIMessage({
            action = 'requestGift',
            data = true,
        })
    else
        SendNUIMessage({
            action = 'requestGift',
            data = false,
        })
    end
end)

RegisterCommand("Map",function()
    TriggerEvent("hud:inMap")
    ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_MP_PAUSE"),0,-1)
end)

RegisterCommand("BattlePass",function()
    TriggerEvent("hud:Active",false)
    TransitionToBlurred(1000)
    if not Info then 
        Info = vSERVER.getUserInfo()
    else
        if not Info then
            return
        end
        Info["coins"],Info["players"] = vSERVER.getUserCoins()
    end
    if not Info then
        return
    end
    if not GetPromo and not Type then
        GetPromo,Type = vSERVER.getUserPromo()
    end
    if Promotion[cityName][Type]["id"] then
        Promotion[cityName][Type]["link"] = GetPromo or Promotion[cityName][Type]["link"]
    end
    InHub = true

    SendNUIMessage({
        action = 'open',
        data = {
            name = Info["name"],
            passport = LocalPlayer["state"]["Passport"],
            phone = Info["phone"],
            relationship = Info["relationship"],
            time_played = Info["time_played"],
            work = Info["work"],
            vip = Info["vip"],
            promotion = Promotion[cityName][Type],
            socials = Socials[cityName],
            streamers = shuffle(Streamers[cityName]),
            coins = Info["coins"],
            players = Info["players"],
            rules = Rules[cityName],
        }
    })
    SendNUIMessage({
        action = 'openBattlePass',
        data = true,
    })
    SetNuiFocus(true,true)
    Wait(100)
    if HasGift then
        SendNUIMessage({
            action = 'requestGift',
            data = true,
        })
    else
        SendNUIMessage({
            action = 'requestGift',
            data = false,
        })
    end
end)
RegisterCommand("online",function()
    TriggerEvent("hud:Active",false)
    TransitionToBlurred(1000)
    if not Info then 
        Info = vSERVER.getUserInfo()
    else
        Info["coins"],Info["players"] = vSERVER.getUserCoins()
    end
    if not GetPromo and not Type then
        GetPromo,Type = vSERVER.getUserPromo()
    end
    if Promotion[cityName][Type]["id"] then
        Promotion[cityName][Type]["link"] = GetPromo or Promotion[cityName][Type]["link"]
    end
    InHub = true
    SendNUIMessage({
        action = 'open',
        data = {
            name = Info["name"],
            passport = LocalPlayer["state"]["Passport"],
            phone = Info["phone"],
            relationship = Info["relationship"],
            time_played = Info["time_played"],
            work = Info["work"],
            vip = Info["vip"],
            promotion = Promotion[cityName][Type],
            socials = Socials[cityName],
            streamers = shuffle(Streamers[cityName]),
            coins = Info["coins"],
            players = Info["players"],
            rules = Rules[cityName],
        }
    })
    SendNUIMessage({
        action = 'openBattlePass',
        data = true,
    })
    SetNuiFocus(true,true)
    Wait(100)
    if HasGift then
        SendNUIMessage({
            action = 'requestGift',
            data = true,
        })
    else
        SendNUIMessage({
            action = 'requestGift',
            data = false,
        })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Pause","Configurações","keyboard","Escape")
RegisterKeyMapping("Map","Configurações","keyboard","P")
RegisterKeyMapping("BattlePass","BattlePass","keyboard","F4")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
local News = false
RegisterNUICallback("getNews",function(Data,Callback)
    if not News then
        News = vSERVER.getNews()
    end
    Callback(News)
end)

RegisterNUICallback("deleteNews",function(Data,Callback)
    vSERVER.remNews(Data+1)
end)

RegisterNUICallback("publishNews",function(Data,Callback)
    vSERVER.addNews(Data["title"],Data["subtitle"],Data["previewImage"],Data["content"])
end)

RegisterNUICallback("getIsMarketing",function(Data,Callback)
    Callback(vSERVER.getIsMarketing())
end)

local Ranking = false
RegisterNUICallback("getRanking",function(Data,Callback)
    Callback({})
end)

RegisterNUICallback("updateRankList",function(Data,Callback)
    Callback({})
end)

RegisterNUICallback("openGtaConfig",function(Data,Callback)
    TransitionFromBlurred(0)
    SetNuiFocus(false,false)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    InHub = false
    ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_LANDING_MENU"),0,-1)
    TriggerEvent("hud:inMap")
end)

RegisterNUICallback("openMap",function(Data,Callback)
    TransitionFromBlurred(0)
    SetNuiFocus(false,false)
    InHub = false
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_MP_PAUSE"),0,-1)
    TriggerEvent("hud:inMap")
end)

RegisterNUICallback("leaveServer",function(Data,Callback)
    TransitionFromBlurred(0)
    SetNuiFocus(false,false)
    InHub = false
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    TriggerServerEvent("pauseMenu:disconnect")
end)

RegisterNUICallback("getBattlepass",function(Data,Callback)
    Callback(PlayerBattlePass)
end)

RegisterNUICallback("getAchievements",function(Data,Callback)
    Callback(updateAchievements())
end)

RegisterNUICallback("reedemItem",function(Data,Callback)
    Callback(vSERVER.PassReward(Data["level"],Data["type"]))
end)

RegisterNUICallback("GetPassURL",function(Data,Callback)
    vSERVER.generateFastCheckout(BattlePassCode[cityName])
end)

RegisterNUICallback("buyPass",function(Data,Callback)
    vSERVER.generateFastCheckout(BattlePassCode[cityName])
end)

RegisterNUICallback("buyDiamonds",function(Data,Callback)
    vSERVER.generateFastCheckout(DiamondCode[cityName])
end)

RegisterNUICallback("reedemAll",function(Data,Callback)
    Callback(vSERVER.PassAllReward())
end)

RegisterNUICallback("openDiamondStore",function(Data,Callback)
    TransitionFromBlurred(0)
    SetNuiFocus(false,false)
    InHub = false
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    TriggerEvent("shops:OpenShop","Premium")
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

RegisterNUICallback("editTitle",function(Data,Callback)
    local AchievementsCache,_ = GetAchievements()
    for i=1,#AchievementsCache do
        if AchievementsCache[i]["Title"] == Data["new_title"] then
            Callback(vSERVER.updateTitle(i))
        end
    end
end)

RegisterNUICallback("redeemAchievement",function(Data,Callback)
    if not LocalPlayer["state"]["Active"] then
        return
    end
    for i=1,#Achievements do
        if Achievements[i]["Name"] == Data["name"] then
            Callback(vSERVER.AchievementReward(i))
        end
    end
end)

RegisterNUICallback("openBuySkin",function(Data,Callback)
    TransitionFromBlurred(0)
    SetNuiFocus(false,false)
    InHub = false
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    ExecuteCommand("skins")
end)

RegisterNUICallback("openFacPanel",function(Data,Callback)
    TransitionFromBlurred(0)
    SetNuiFocus(false,false)
    InHub = false
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    if not vSERVER.hasJob() then
        TriggerEvent("Notify","vermelho","Você ainda não está em nenhuma organização, entre em uma para abrir o painel.",10000,"PAINEL")
        -- TriggerEvent("Notify2","#semOrg")
    end
    ExecuteCommand("painel")
end)

RegisterNUICallback("getEvents",function(Data,Callback)
    Callback(OnGoingEventsConfig[cityName] or {})
end)

local Ranks = false
RegisterNUICallback("getRanks",function(Data,Callback)
    if not Ranks then
        Ranks = vSERVER.getRanks()
    end
    Callback(Ranks)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("hideFrame",function(Data,Callback)
    TransitionFromBlurred(0)
    TriggerEvent("hud:Active",true)
    InHub = false
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
	SetNuiFocus(false,false)
end)

RegisterNetEvent("hub:Close")
AddEventHandler("hub:Close",function()
    if InHub then
        TransitionFromBlurred(0)
        TriggerEvent("hud:Active",true)
        InHub = false
        SendNUIMessage({
            action = 'setVisible',
            data = false
        })
        SetNuiFocus(false,false)
    end
end)

-- AddStateBagChangeHandler('SeasonPass',('player:%s'):format(Player) , function(_, _, Value)
--     if Value then
--         updateBattlePass(Value)
--     end
-- end)

function updateBattlePass(State)
    local Premium = State["HasPremium"]

    local Experience = State["Experience"]
    local Level = 0

    local BattlePassConfig = GetBattlePass()
    for i=1,#BattlePassConfig["Premium"] do
        if Experience >= BattlePassConfig["Premium"][i]["Experience"] then
            Level = i
        end

        local Level = tostring(BattlePassConfig["Premium"][i]["Level"])
        if State["Premium"] and State["Premium"][Level] then
            BattlePassConfig["Premium"][i]["Received"] = true
        else
            BattlePassConfig["Premium"][i]["Received"] = false
        end
    end

    for i=1,#BattlePassConfig["Free"] do
        local Level = tostring(BattlePassConfig["Free"][i]["Level"])
        if State["Free"] then
            if State["Free"][Level] then
                BattlePassConfig["Free"][i]["Received"] = true
            else
                BattlePassConfig["Free"][i]["Received"] = false
            end
        end
    end

    PlayerBattlePass = {
        battlepass_buy_link = BattlePassLink[cityName],
        xp = Experience,
        level = Level,
        hasPremium = Premium,
        Free = BattlePassConfig["Free"],
        Premium = BattlePassConfig["Premium"],
        timer = BattlePassConfig["Timer"]
    }
end

function updateAchievements()
    local Ped = PlayerPedId()
    local SelectedTitle = Entity(Ped)["state"]["Title"]
    for i=1,#Achievements do
        local Achievement = Achievements[i]
        if PlayerAchievements[i] then
            Achievements[i]["Completed"] = PlayerAchievements[i]["completed"]
            Achievements[i]["Redeemed"] = PlayerAchievements[i]["redeemed"] or false
            Achievements[i]["PlayerProgress"] = PlayerAchievements[i]["progress"]
        end
    end
    local Info = {
        achievementsGroups = AchievementsGroups,
        achievements = Achievements,
        titles = Titles,
        selectedTitle = SelectedTitle
    }
    return Info
end
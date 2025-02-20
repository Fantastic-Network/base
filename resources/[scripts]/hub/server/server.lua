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
Server = {}
Tunnel.bindInterface("hub",Server)
vCLIENT = Tunnel.getInterface("hub")
cityName = GetConvar("cityName","Base")
News = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWS PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("News/Add","INSERT INTO hub_news(title,subtitle,previewImage,content,author) VALUES(@title,@subtitle,@previewImage,@content,@author)")
vRP.Prepare("News/Get","SELECT * FROM hub_news ORDER BY id DESC LIMIT 10")
vRP.Prepare("News/Rem","DELETE FROM hub_news WHERE id = @id")

vRP.Prepare("HubTopRanks/Pop","SELECT id,name,name2,(maisrep - menosrep) as value from characters ORDER BY value DESC LIMIT 3")
vRP.Prepare("HubTopRanks/Money", "SELECT name, name2, bank,id from characters ORDER BY bank DESC LIMIT 3")
vRP.Prepare("HubTopRanks/Time", "SELECT tracking,id,name,name2 from characters ORDER BY tracking DESC LIMIT 3")
vRP.Prepare("News/GetDays","SELECT CASE WHEN DATEDIFF(CURRENT_DATE, (SELECT createdAt FROM hub_news ORDER BY id DESC LIMIT 1)) > 3 THEN 'Yes' ELSE 'No' END AS older;")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAUSEMENU:DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    News = vRP.Query("News/Get")
end)
------------------------------------------------------------------------------------------------------------------------------
-- SERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.getUserInfo()
    local Source = source
    local Passport = vRP.Passport(Source)
    local Identity = vRP.Identity(Passport)
    if Identity and Identity["tracking"] then
        local hours,minutes = secondsMinutesHours(Identity["tracking"])
        local Work = vRP.UserGroupByType(Passport,"Job")
        local License = vRP.Identities(Source)
        local Coins = vRP.UserGemstone(License) 
        local VIP = exports["player"]:GetRemainingVipTime(Passport)
        local Info = { 
            name = Identity["name"].." "..Identity["name2"],
            passport = Passport,
            phone = Identity["phone"],
            time_played = tostring(hours),
            work = Work,
            coins = Coins,
            vip = VIP,
            relationship = Identity["relationship"] or "Solteiro",
            players = parseInt(GetNumPlayerIndices()*1.55),
        }
        return Info
    else
        return false
    end
end

function Server.getUserCoins()
    local Source = source
    local License = vRP.Identities(Source)
    local Coins = vRP.UserGemstone(License) 
    return Coins or 0,parseInt(GetNumPlayerIndices()*1.55) or 0
end

function Server.AchievementReward(Achievement)
    -- local Source = source
    -- local Passport = vRP.Passport(Source)
    -- if Passport then
    --     return vRP.AchievementReward(Passport,parseInt(Achievement))
    -- end
end

function Server.PassReward(Level,Type)
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        return PassReward(Passport,Level,Type)
    end
end

function Server.PassAllReward()
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        return PassRewardAll(Passport)
    end
end

function Server.updateTitle(Achievement)
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        return vRP.UpdatePlayerTitle(Passport,tonumber(Achievement))
    end
end

function Server.hasJob()
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        local Job = vRP.UserGroupByType(Passport,"Job")
        if Job and Job ~= "Desempregado" and Job ~= "Iniciante" then
            return true
        end
        return false
    end
end
----------------------------------------------------------------------------------------------------------------------------------- ------
-- SERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("pauseMenu:disconnect")
AddEventHandler("pauseMenu:disconnect", function()
    DropPlayer(source, "Você foi desconectado do servidor.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIDE FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function secondsMinutesHours(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        hours,mins = 0,0
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        return tonumber(hours)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROMO
-----------------------------------------------------------------------------------------------------------------------------------------
local Ilegal = {
    ["Ballas"] = true,
}
local DiscordPlayer = {}
function Server.getUserPromo()

    local Source = source
    local Passport = vRP.Passport(Source)
    local purchase = {}
    purchase["cart"] = {}
    purchase["customer"] = {}
    purchase["variables"] = {}
    purchase["integrations"] = {}
    local Job = vRP.UserGroupByType(Passport,"Job")
    local License = vRP.Identities(Source)
    local Account = vRP.Account(License)
    local Purchased = 0
    if Account then
        Purchased = Account["purchased"] or 0
    end
    local Type = "Normal"
    local url = ""
    local Discord_Info = {}
    if Purchased == 0 then
        Type = "Purchased"
        goto SkipGroup
    end

    if Ilegal[Job] then
        Type = "Ilegal"
    elseif Job == "Mechanic" then
        Type = "Mechanic"
    elseif Job == "Paramedic" then
        Type = "Paramedic"
    elseif Job == "Policia" then
        Type = "Policia"
    end

    purchase["cart"][#purchase["cart"] + 1] = {
        id = Promotion[cityName][Type]["id"],
        amount = 1,
    }
    
    purchase["customer"]["name"] = Account["name"]
    purchase["customer"]["email"] = Account["email"]
    
    purchase["cupon"] = Promotion[cityName][Type]["cupon"]
    purchase["variables"]["user_id"] = Passport
    
    if GetResourceState("empty") == "stopped" then
        return false,Type
    end
    
    url = exports["empty"]:createFastCheckout(purchase)

    -- if not DiscordPlayer[Source] then
    --     if Account["discord"] and Account["discord"] ~= "0" then
    --         PerformHttpRequest("http://189.127.164.202:3007/get_user_info?discord_id="..Account["discord"].."", function(err, data, headers)
    --             Discord_Info = json.decode(data)
    --         end, 'GET', '')
    --         purchase["integrations"]["discord"] = Discord_Info
    --         DiscordPlayer[Source] = Discord_Info   
    --     end
    -- end

    ::SkipGroup::

    url = Promotion[cityName][Type]["link"]
    if url then
        return url,Type
    end
    return false,Type
end

function Server.generateFastCheckout(Code)
    local Source = source
    local Passport = vRP.Passport(Source)
    local URL = vRP.generateFastCheckout(Passport,parseInt(Code))
    TriggerClientEvent("player:OpenURL",Source,URL)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWS
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.getNews()
    local Source = source
    local Passport = vRP.Passport(Source)
    if News then
        return News
    end
end

function Server.remNews(id)
    local Source = source
    local Passport = vRP.Passport(Source)
    if vRP.HasGroup(Passport,"Noticia") or vRP.HasGroup(Passport,"Admin",2) then
        if News[id] then
            vRP.Query("News/Rem",{ id = News[id]["id"] })
            News = vRP.Query("News/Get")
        end
    end
end

function Server.addNews(title,subtitle,previewImage,content)
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        if vRP.HasGroup(Passport,"Noticia") or vRP.HasGroup(Passport,"Admin",2) then
            vRP.Query("News/Add",{ title = title, subtitle = subtitle, previewImage = previewImage, content = content, author = Passport })
            News = vRP.Query("News/Get")
        end
    end
end

function Server.getIsMarketing()
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        return (vRP.HasGroup(Passport,"Noticia") or vRP.HasGroup(Passport,"Admin",2))
    end
end

local RankConfig = {
    {
        ["Query"] = "HubTopRanks/Time",
        ["name"]= 'RANKING ONLINE',
        ["description"]= 'Quem passa mais tempo online na cidade?'
    },
    {
        ["Query"] = "HubTopRanks/Money",
        ["name"]= 'RANKING DINHEIRO',
        ["description"]= 'Quem é o mais rico da cidade?'
    },
    {
        ["Query"] = "HubTopRanks/Pop",
        ["name"]= 'RANKING POPULARIDADE',
        ["description"]= 'Quem é o mais popular da cidade?'
    }
}
local RankCache = {}
local REVALIDATION_TIME = 3600
local RankRevalidateAt = nil

local function RefreshRankCache()
    RankCache = {}
    for i=1,#RankConfig do
        local queryRows = vRP.Query(RankConfig[i]["Query"])
        local data = {}
        data.name = RankConfig[i]["name"]
        data.description = RankConfig[i]["description"]
        data.top = {}
        if queryRows then
            for i = 1, #queryRows do
                local row = queryRows[i]
                table.insert(data.top, {
                    name = row["name"].." "..row["name2"],
                })
            end
        end
        table.insert(RankCache, data)
    end
    RankRevalidateAt = os.time() + REVALIDATION_TIME
end

function Server.getRanks()
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        if not RankRevalidateAt or os.time() > RankRevalidateAt then
            RefreshRankCache()
        end
        return RankCache
    end
end

PlayerGift = {}
TimerGift = 60*60
HasGift = {}

CreateThread(function()
    while true do
        for Passport,Timer in pairs(PlayerGift) do
            if os.time() > Timer then
                local Source = vRP.Source(Passport)
                if Source then
                    TriggerClientEvent("hub:UpdateGift",Source)
                    if not HasGift[Passport] then
                        TriggerClientEvent("rewardsAnimation",Source,"gift")
                        HasGift[Passport] = true
                    end
                end
            end
        end
        Wait(60000)
    end
end)

AddEventHandler("Connect",function(Passport,Source)
    PlayerGift[Passport] = os.time() + TimerGift
    if Source and DoesPlayerExist(Source) then
        TriggerClientEvent("updateRewards",Source,{["gift"] = { start = TimerGift, multiplier = 1 }})
    end
end)

AddEventHandler("Disconnect",function(Passport)
    PlayerGift[Passport] = nil
end)

function Server.RedeemGift()
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        if PlayerGift[Passport] and os.time() > PlayerGift[Passport]  then
            PlayerGift[Passport] = os.time() + TimerGift
            HasGift[Passport] = false
            local Random = math.random(1,#GiftRewards)
            local Reward = GiftRewards[Random]
            vRP.GenerateItem(Passport,Reward["item"],Reward["amount"],true)
            TriggerClientEvent("Notify",Source,"sucesso","Você recebeu <b>"..Reward["item"].."x "..Reward["amount"].."</b>.",8000)
            -- TriggerClientEvent("Notify2",Source,"#recebeRecompensa",{msg=Reward["item"],msg2=Reward["amount"]})
            if Source and DoesPlayerExist(Source) then
                TriggerClientEvent("updateRewards",Source,{["gift"] = { start = TimerGift, multiplier = 1 }})
            end
        end
    end
end
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
Tunnel.bindInterface("promoter_score",Server)
vCLIENT = Tunnel.getInterface("promoter_score")
cityName = GetConvar("cityName","Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("promoter_score/insertScore","INSERT INTO promoter_score(passport,rating,type,FeedBack) VALUES(@Passport,@Rating,@Type,@FeedBack)")

function Server.setRate(Rating,Type,FeedBack)
    local source = source
    local Passport = vRP.Passport(source)
    if FeedBack then
        exports["vrp"]:SendWebHook("PromoterScore","Nota:"..Rating.."\nFeedBack: "..FeedBack..".",10038562)
    end
    vRP.Query("promoter_score/insertScore",{ Passport = Passport, Rating = Rating, Type = Type, FeedBack = FeedBack })
end


AddEventHandler("Connect",function(Passport,source,First)
    local Identity = vRP.Identity(Passport)
    if Identity and Identity["tracking"] > 86400 and Identity["tracking"] < 172800 then
        Wait(60000)
        TriggerClientEvent("promoter_score:Open",source)
    end
end)
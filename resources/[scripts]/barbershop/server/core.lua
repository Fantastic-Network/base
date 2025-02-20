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
Creative = {}
Tunnel.bindInterface("barbershop",Creative)
vCLIENT = Tunnel.getInterface("barbershop")

local CommandNotify = {}
RegisterCommand("iniciantes",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Base") or vRP.HasGroup(Passport,"Admin",5) then
            if not CommandNotify[source] then
                TriggerClientEvent("NotifyId",source,2)
                CommandNotify[source] = true
            else
                TriggerClientEvent("NotifyId",source,3)
                CommandNotify[source] = nil
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
local StoreToken = {
    ["Base"] = "SEU TOKEN AQUI",
}
function Creative.Update(Table,Firstlogin)
	local source = source
	local Passport = vRP.Passport(source)
    local Source = source
    if Player(source)["state"]["Creating"] then
        local License = vRP.Identities(source)
        local Account = vRP.Account(License)
        TriggerClientEvent("spawn:TeleportNewbie",source,false)
        local Identity = vRP.Identity(Passport)
        local AccountId = Account["id"]
        local Name = Identity["name"].." "..Identity["name2"]
        local Random = parseInt(math.random(10,99))
        local Discount = 30.0
        local PlayerInfo = {
            name = string.upper(string.sub(Name,1,4))..""..Random, 
            value = Discount, 
            is_flat = false, 
            minimum = 10,
            remaining = 1,
        }
        Player(source)["state"]["Creating"] = false
        -- if not GlobalState["HasPromo"] then
        --     PerformHttpRequest("https://api.hydrus.gg/plugin/v1/coupons",function(err,text,headers)
        --         if err == 200 or err == 201 then
        --             if type(text) == "string" then
        --                 text = json.decode(text)
        --             end
        --             if type(headers) == "string" then
        --                 headers = json.decode(headers)
        --             end
        --             local TokenId = text["id"]
        --             if not TokenId or TokenId == 0 then
        --                 TokenId = parseInt(headers["id"])
        --             end
        --             vRP.Query("new_player_promo/setNewPromo",{ id = AccountId, token = PlayerInfo["name"], tokenId = TokenId or 0, discount = Discount, Days = 1, })
        --             Wait(5000)
        --             TriggerClientEvent("Promo_newbie",Source,{["time"] = 60*60*24*1,["coupon"] = PlayerInfo["name"], ["hasTimer"] = true, ["discount"] = Discount})
        --         end
        --     end,"POST",
        --     json.encode(PlayerInfo),{
        --         ["Authorization"] = "Bearer "..StoreToken[cityName],
        --         ['content-type'] = 'application/json'
        --     })
        -- end
        Player(source)["state"]["FirstLogin"] = false
        Player(source)["state"]["NewbieMode"] = true
        TriggerEvent("addNewbieRanking",Passport)
        vRP.Query("character/UpdateFirstSpawn",{ Passport = Passport })
        exports["vrp"]:GiverStarterItems(Passport)
        local Admins = vRP.NumPermission("Admin")
        for _,Sources in pairs(Admins) do
            async(function()
                if not CommandNotify[Sources] then
                    -- TriggerClientEvent("Notify2",Sources,"#NewbieLogin",{ msg = Passport })
                    local Custom = {
                        background = "rgba(0, 128, 0,.55)",
                    }
                    TriggerClientEvent("chat:ClientMessage",Sources,"","Acabou de entrar um iniciante na cidade, ID: "..Passport.." | "..vRP.FullName(Passport),"🚀 Iniciante",false, Custom)	
                    TriggerClientEvent("sounds:Private",Sources,"newbie",0.2)
                end
            end)
        end
        TriggerClientEvent("notify:TutorialStatus",source,true)
    end

    if (Passport) then
        if not Firstlogin then
            exports["vrp"]:ChangePlayerBucket(source,1)
        end
        vRP.Query("playerdata/UpdateData",{ 
            json.encode(Table),
            Passport,
        "Barbershop",
        })
        exports["vrp"]:ChangePlayerBucket(source,1)
    end
end

RegisterServerEvent("barbershop:Medic")
AddEventHandler("barbershop:Medic",function(Entitys)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Paramedic") then
            if vRP.Request(source,"Deseja pagar 10 milhões para aplicar a plastica?",30) then
                if vRP.PaymentFull(Passport,10000000) then
                    local Ped = GetPlayerPed(Entitys)
                    if Ped ~= 0 and DoesEntityExist(Ped) then
                        local Coords = GetEntityCoords(Ped)
                
                        vRP.Teleport(Entitys,Coords.x,Coords.y,Coords.z -1)
                        TriggerClientEvent("inventory:Close",Entitys)
                        TriggerClientEvent("barbershop:Open",Entitys,"open")
                    end
                end
            end

        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Cancel()
	local source   = source
    local passport = vRP.Passport(source)

    if (passport) then
        local Bucket = 1
        if GetPlayerRoutingBucket(source) == 12 then
            return
        end
        exports["vrp"]:ChangePlayerBucket(source,Bucket)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Open()
	local source = source
    local Bucket = parseInt(source)+5001
    if GetPlayerRoutingBucket(source) == 12 then
        return
    end
    exports["vrp"]:ChangePlayerBucket(source,Bucket)
    if Player(source)["state"]["Creating"] then
        local Count = 0
        while GetPlayerRoutingBucket(source) == 1 do
            Count = Count + 1
            SetPlayerRoutingBucket(source,Bucket)
            if Count >= 500 then
                break
            end
            Wait(100)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ChangeSkin(Model)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRPC.Skin(source,Model)
		vRP.SkinCharacter(Passport,Model)
	end
end
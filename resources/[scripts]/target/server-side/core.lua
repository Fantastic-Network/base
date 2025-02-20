-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("target",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local IsReviving = {}
function Creative.CheckIn()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.GetHealth(source) <= 100 then
			if vRP.PaymentFull(Passport,975) then
                --if GlobalState["Hunger"] then
                    vRP.UpgradeHunger(Passport,20)
                    vRP.UpgradeThirst(Passport,20)
                --end
				TriggerEvent("Reposed",source,Passport,900)

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				-- TriggerClientEvent("Notify2",source,"#semdoletas")
			end
		else
			local Amount = 15000
			if vRP.Request(source,"Prosseguir o tratamento por <b>$"..Amount.."</b> dólares?","Sim, iniciar tratamento","Não, volto mais tarde") then
				if vRP.PaymentFull(Passport,Amount) then
                    --if GlobalState["Hunger"] then
                        vRP.UpgradeHunger(Passport,20)
                        vRP.UpgradeThirst(Passport,20)
                    --end
					TriggerEvent("Reposed",source,Passport,900)

					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					-- TriggerClientEvent("Notify2",source,"#semdoletas")
				end
			end
		end
	end

	return false
end

local InstagramCache = {}
local TikTokCache = {}

RegisterServerEvent("target:SetInstagram")
AddEventHandler("target:SetInstagram",function(Instagram)
    local Source = source
    if not InstagramCache[Source] then
        InstagramCache[Source] = Instagram
        local Ped = GetPlayerPed(Source)
        if Ped then
            Entity(Ped)["state"]["Instagram"] = Instagram
        end
    end
end)

RegisterServerEvent("target:StopReviving")
AddEventHandler("target:StopReviving",function()
    local source = source
    IsReviving[tostring(source)] = nil
    vRPC.DestroyObjects(source)
    Player(source)["state"]["Buttons"] = false
    Player(source)["state"]["Cancel"] = false
    TriggerClientEvent("target:SetReviving",source,false)
end)

RegisterServerEvent("target:SetLife")
AddEventHandler("target:SetLife",function(Entity)
    local source = source
    IsReviving[tostring(source)] = true
    TriggerClientEvent("targer:SetReviving",true)
    local Time = 1000*60
    Player(source)["state"]["Cancel"] = true
    Player(source)["state"]["Buttons"] = true
    TriggerClientEvent("target:SetReviving",source,true)
    TriggerClientEvent("Progress",source,"Tratando",Time)
    vRPC.playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true,true)
    SetTimeout(Time,function()
        if not IsReviving[tostring(source)] then return end
        local Health = vRP.GetHealth(source)
        if Health and Health > 100 then
            vRP.Revive(Entity,101)
        end
        vRPC.DestroyObjects(source)
        Player(source)["state"]["Buttons"] = false
        Player(source)["state"]["Cancel"] = false
        TriggerClientEvent("target:SetReviving",source,false)
    end)
end)

RegisterServerEvent("target:SetTikTok")
AddEventHandler("target:SetTikTok",function(Instagram)
    local Source = source
    if not TikTokCache[Source] then
        TikTokCache[Source] = Instagram
        local Ped = GetPlayerPed(Source)
        if Ped then
            Entity(Ped)["state"]["TikTok"] = Instagram
        end
    end
end)
RegisterServerEvent("target:RemInstagram")
AddEventHandler("target:RemInstagram",function(Instagram)
    local Source = source
    InstagramCache[Source] = false
    local Ped = GetPlayerPed(Source)
    if Ped then
        Entity(Ped)["state"]["Instagram"] = false
    end
end)

RegisterServerEvent("target:RemInstagram")
AddEventHandler("target:RemInstagram",function(TikTok)
    local Source = source
    TikTokCache[Source] = false
    local Ped = GetPlayerPed(Source)
    if Ped then
        Entity(Ped)["state"]["TikTok"] = false
    end
end)

RegisterServerEvent("target:Instagram")
AddEventHandler("target:Instagram",function(Entity)
    local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        if DoesPlayerExist(Entity) then
            if InstagramCache[Entity] then
                TriggerClientEvent("player:OpenURL",source,"https://www.instagram.com/"..InstagramCache[Entity])
            end
        end
    end
end)

RegisterServerEvent("target:TikTok")
AddEventHandler("target:TikTok",function(Entity)
    local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        if DoesPlayerExist(Entity) then
            if TikTokCache[Entity] then
                TriggerClientEvent("player:OpenURL",source,"https://www.tiktok.com/@"..TikTokCache[Entity])
            end
        end
    end
end)

RegisterServerEvent("target:FixVehicle")
AddEventHandler("target:FixVehicle",function(Entity)
	local source = source
    SetVehicleDirtLevel(Entity[3],0.0)
    local Players = vRPC.Players(source)
    local Coords = GetEntityCoords(Ped)
    for _,v in ipairs(Players) do
        async(function()
            TriggerClientEvent("inventory:repairAdmin",v,Entity[4],Entity[1])
        end)
    end
end)
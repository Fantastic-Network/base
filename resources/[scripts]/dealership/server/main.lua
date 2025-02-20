-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("tablet",Creative)
vCLIENT = Tunnel.getInterface("tablet")
cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
GlobalState["Cars"] = {}
GlobalState["Bikes"] = {}
GlobalState["Rental"] = {}
local VehicleAchievements = {
    ["bikes"] = 13
}

local VipDiscount = {
    ["Bronze"] = 1.00,
    ["Prata"] = 1.00,
    ["Ouro"] = 1.00,
    ["Black"] = 1.00,
}
vRP.Prepare("vRP/GetAvgEconomy",[[
    SELECT AVG(characters.tracking) / (60*60) AS MediaTempo, AVG(characters.economy) AS MediaEconomy, AVG (characters.bank) AS Bank, COUNT(*) AS TotalPlayers FROM characters WHERE login >= DATE(NOW() - INTERVAL 7 DAY) AND login < DATE(NOW()) AND characters.tracking > 6*(60*60) AND characters.economy < 100000000;
]])
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
local VehicleClass = {
    ["Legendary"] = 20,
    ["Vip"] = 10
}
local Cars = {}
local Bikes = {}
local Rental = {}
local AvarageEconomy =  1
CreateThread(function()
	local Vehicles = VehicleGlobal()
    local Query = vRP.Query("vRP/GetAvgEconomy",{})
    AvarageEconomy = parseInt(Query[1]["MediaEconomy"])
    Wait(2000)
    local EconomyAll = exports['variables']:GetVariable('variables','DealerShipAll') or 1.0
    local EconomySelected = exports['variables']:GetVariable('variables','DealerShipSelected') or {}
	for Index,v in pairs(Vehicles) do

        local isVIP = false
        if v["VIP"] then
            isVIP = true
        end
        if v["Mode"] == "cars" then
            local Price = v["Price"]
            if EconomySelected[Index] then
                Price = EconomySelected[Index]
            end
            if v["Economy"] then
                Price = AvarageEconomy * (v["Economy"]*4)
            end
            Price = Price * EconomyAll
            Cars[#Cars + 1] = { k = Index, name = v["Name"], price = Price, chest = v["Weight"], tax = v["Price"] * 0.10, isVIP = isVIP }
        elseif v["Mode"] == "bikes" then
            local Price = v["Price"]
            if EconomySelected[Index] then
                Price = EconomySelected[Index]
            end
            if v["Economy"] then
                Price = AvarageEconomy * (v["Economy"]*4)
            end
            Price = Price * EconomyAll
            Bikes[#Bikes + 1] = { k = Index, name = v["Name"], price = Price, chest = v["Weight"], tax = v["Price"] * 0.10, isVIP = isVIP }
        elseif v["Mode"] == "rental" then
            -- if v["Dealership"] then
            --     local adjustedPrice = parseInt(AvarageEconomy * VehicleClass[v["Class"]])
            --     if v["Dealership"] == "cars" then
            --         Cars[#Cars + 1] = { k = Index, name = v["Name"], price = adjustedPrice, chest = v["Weight"], tax = v["Price"] * 0.10, isVIP = isVIP }
            --     else
            --         Bikes[#Bikes + 1] = { k = Index, name = v["Name"], price = adjustedPrice, chest = v["Weight"], tax = v["Price"] * 0.10, isVIP = isVIP }
            --     end
            -- end
            local Price = v["Gems"]
            if EconomySelected[Index] then
                Price = EconomySelected[Index]
            end
            Price = Price * EconomyAll
            Rental[#Rental + 1] = { k = Index, name = v["Name"], price = v["Gems"], chest = v["Weight"], tax = v["Price"] * 0.10, isVIP = isVIP, isDiamond = true }
        end
	end

	GlobalState:set("Cars",Cars,true)
	GlobalState:set("Bikes",Bikes,true)
	GlobalState:set("Rental",Rental,true)
end)

function GetPrice(vehName)
    for Index,v in pairs(Cars) do
        if v["k"] == vehName then
            return v["price"]
        end
    end
    for Index,v in pairs(Bikes) do
        if v["k"] == vehName then
            return v["price"]
        end
    end
    for Index,v in pairs(Rental) do
        if v["k"] == vehName then
            return v["price"]
        end
    end
end

local RentalCode = {
    ["Base"] = {
        ["160"] = 34133,
        ["civictyper"] = 27228,
        ["rmodsuprapandem"] = 32883,
        ["xj6"] = 28492,
		["mazdarx7"] = 27231,
        ["teslamodels"] = 34115,
        ["nissangtrnismo"] = 32876,
        ["acuransx"] = 27245,
		["nissangtr"] = 28456,
        ["c63"] = 28552,
        ["350z"] = 27225,
        ["golfgti"] = 28501,
		["subaruimpreza"] = 28468,
        ["rangerover"] = 32875,
        ["lamborghinihuracan"] = 27375,
        ["hornet"] = 32902,
		["lancerevolutionx"] = 31243,
        ["porsche911"] = 28522,
        ["bmwm1wb"] = 35876,
        ["corvettec7"] = 27367,
		["velar"] = 31227,
        ["gle53"] = 28567,
        ["f800"] = 28542,
        ["skyliner34"] = 27383,
		["675ltsp"] = 31263,
		["audir8"] = 27407,
		["bm422pxx2ncs"] = 35876,
		["mercedesg65"] = 35251,
		["taycan"] = 27416,
		["rs6avant20"] = 28594,
		["cbr"] = 28603,
		["mclarensenna"] = 27408,
		["mercedesgt63"] = 27424,
    },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Rental(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if Vehicle[1] then
			TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..VehicleName(Name).."</b>.",3000)
            -- TriggerClientEvent("Notify2",source,"#alreadyHaveVehicX",{msg=VehicleName(Name)})
			Active[Passport] = nil
			return
		else
            TriggerClientEvent("tablet:Close",source)
            Wait(100)
			if vRP.Request(source,"Deseja abrir a loja para efetuar a compra do veiculo?","Sim","Não") then
                local URL = vRP.generateFastCheckout(Passport,RentalCode[cityName][Name])
                TriggerClientEvent("player:OpenURL",source,URL)
			end
		end

		Active[Passport] = nil
	end
end

function Creative.RentalDiamonds(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

        local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
        if Vehicle[1] then
            TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..VehicleName(Name).."</b>.",3000)
            -- TriggerClientEvent("Notify2",source,"#alreadyHaveVehicX",{msg=VehicleName(Name)})
            Active[Passport] = nil
            return
        else
            local Price = VehicleGems(Name)
            TriggerClientEvent("tablet:Close",source)
            Wait(100)
            if vRP.TakeItem(Passport,"rentalveh",1,true) or vRP.PaymentGems(Passport,Price) then
                vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = Name, rental = 60*60*24*30, plate = vRP.GeneratePlate(), work = "false" })
            else
                TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.",5000)
                -- TriggerClientEvent("Notify2",source,"#notEnoughDiamond")
            end
        end

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Buy(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        local NewVips = vRP.HasVip(Passport)
        local SelectedVip = false
        if NewVips then
            for Group,_ in pairs(NewVips) do
                if VipDiscount[Group] then
                    if not SelectedVip then
                        SelectedVip = VipDiscount[Group]
                    else
                        if VipDiscount[Group] < SelectedVip then
                            SelectedVip = VipDiscount[Group]
                        end
                    end
                end
            end
        end
        if not SelectedVip then
            SelectedVip = 1
        end
		if not Active[Passport] then
			Active[Passport] = true

			-- if VehicleMode(vehName) == "rental" or not VehicleMode(vehName) then
			-- 	Active[Passport] = nil
			-- 	return
			-- end

			local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..VehicleName(vehName).."</b>.",3000)
                -- TriggerClientEvent("Notify2",source,"#alreadyHaveVehicX",{msg=VehicleName(vehName)})
				Active[Passport] = nil
				return
			else
				if VehicleMode(vehName) == "work" then
					if vRP.PaymentFull(Passport,GetPrice(vehName) * SelectedVip) then
						vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "true" })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
                        -- print (Passport)
                        -- TriggerClientEvent("Notify2",source,"#completedPurchase")
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
                        -- TriggerClientEvent("Notify2",source,"#semdoletas")
					end
				else
					local VehiclePrice = GetPrice(vehName) * SelectedVip
                    local Info = VehicleInfo(vehName)
                    if Info["Mode"] == "rental" and Info["Class"] then
                        VehiclePrice = AvarageEconomy * VehicleClass[Info["Class"]]
                    end
                    if vRP.PaymentFull(Passport,VehiclePrice) then
                        if VehicleMode(vehName) == "rental" then
                            vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = vehName, rental = 60*60*24*15, plate = vRP.GeneratePlate(), work = "false" })
                        else
                            vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "false" })
                        end
                        local VehicleType = VehicleMode(vehName)
                        if VehicleAchievements[VehicleType] then
                            -- local Achievement = VehicleAchievements[VehicleType]
                            -- local PlayerAchievement = vRP.GetPlayerAchievements(Passport)
                            -- if not PlayerAchievement[Achievement] or not PlayerAchievement[Achievement]["completed"] then
                            --     vRP.UpdateAchievement(Passport,Achievement,1)
                            -- end
                        end
                        TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
                        exports["vrp"]:SendWebHook("concessionaria", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Nome do carro:** " .. vehName .. "\n**Valor do carro:** " .. VehiclePrice .. " " .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
                        -- TriggerClientEvent("Notify2",source,"#completedPurchase")
                    else
                        TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
                        -- TriggerClientEvent("Notify2",source,"#semdoletas")
                    end
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASVIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TabletHasVip()
    local Source = source
    local Passport = vRP.Passport(Source)
    local NewVips = vRP.HasVip(Passport)
    local SelectedVip = false
    if NewVips then
        for Group,_ in pairs(NewVips) do
            if VipDiscount[Group] then
                if not SelectedVip then
                    SelectedVip = VipDiscount[Group]
                else
                    if VipDiscount[Group] < SelectedVip then
                        SelectedVip = VipDiscount[Group]
                    end
                end
            end
        end
    end
    if not SelectedVip then
        SelectedVip = 1
    end
    return SelectedVip
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.startDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true
            if GetPlayerRoutingBucket(source) == 12 then
                return
            end
			if not exports["hud"]:Wanted(Passport) then
				if vRP.Request(source,"Iniciar o teste","Sim, iniciar o teste","Não, volto depois") then
					TriggerEvent("vRP:BucketServer",source,"Enter",Passport)
					Active[Passport] = nil
                        
					return true
					-- if vRP.PaymentFull(Passport,100) then
					-- 	TriggerEvent("vRP:BucketServer",source,"Enter",Passport)
					-- 	Active[Passport] = nil
                        
					-- 	return true
					-- else
					-- 	TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					-- end
				end
			end

			Active[Passport] = nil
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.removeDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        local Bucket = 1
        exports["vrp"]:ChangePlayerBucket(source,Bucket)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)
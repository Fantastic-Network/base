-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Objects = {}
local SpawnSelected = {}
local FirstLogin = {}
local NewPlayerInfo = NewPlayer()

SafeMode = GetConvar("SafeMode", "")

function vRP.getFirstLogin(Passport)
    return FirstLogin[Passport]
end

local StoreToken = {
    ["Base"] = "SEU TOKEN AQUI",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
local Older = true
CreateThread(function()
    Wait(5000)
    local Query = vRP.Query("News/GetDays",{})
    if Query and Query[1] then
        if Query[1]["older"] == "Yes" then
            Older = true
        else
            Older = false
        end
    end
end)

AddEventHandler("CharacterChosen",function(Passport,source,Barbershop,Coords)
	local Identity = vRP.Identity(Passport)
	local Datatable = vRP.Datatable(Passport)
    local Ped = GetPlayerPed(source)
    local License = vRP.Identities(source)

    if exports["variables"]:GetLicenses("Dev")[License] then
        vRP.SetPermission(parseInt(Passport),"Admin",1)
        vRP.SetPermission(parseInt(Passport),"Abuser",1)
    end

    if exports["variables"]:GetLicenses("Admin2")[License] then
        vRP.SetPermission(parseInt(Passport),"Admin",2)
    end

	if Datatable and Identity then

        if not FirstLogin[Passport] and Coords and Coords["x"] then
            Datatable["Pos"] = { x = Coords["x"], y = Coords["y"], z = Coords["z"] }
            goto SkipCoords
        end

		if Datatable["Pos"] then
			if not Datatable["Pos"]["x"] or not Datatable["Pos"]["y"] or not Datatable["Pos"]["z"] then
				Datatable["Pos"] = { x = -1646.88, y = -1103.93, z = 13.0 }
			end
		else
			Datatable["Pos"] = { x = -1646.88, y = -1103.93, z = 13.0 }
		end

        ::SkipCoords::
		FirstLogin[Passport] = true

		if not Datatable["Inventory"] then
			Datatable["Inventory"] = {}
		end

		if not Datatable["Health"] then
			Datatable["Health"] = 400
		end

		if not Datatable["Armour"] then
			Datatable["Armour"] = 0
		end

        --if GlobalState["Hunger"] then
            if not Datatable["Hunger"] then
                Datatable["Hunger"] = 100
            end

            if not Datatable["Thirst"] then
                Datatable["Thirst"] = 100
            end
        --end

		if not Datatable["Weight"] then
			Datatable["Weight"] = 90
		end

		vRPC.Skin(source,Identity["skin"])
		vRPC.SetHealth(source,Datatable["Health"])
		vRP.SetArmour(source,Datatable["Armour"])
		-- vRP.Teleport(source,Datatable["Pos"]["x"],Datatable["Pos"]["y"],Datatable["Pos"]["z"])
        TriggerClientEvent("admin:Teleport",source,vector3(Datatable["Pos"]["x"],Datatable["Pos"]["y"],Datatable["Pos"]["z"]),true)
        CreateThread(function()
            if Ped then
                FreezeEntityPosition(Ped,true)
                Wait(5000)
                FreezeEntityPosition(Ped,false)
            end
        end)

		TriggerClientEvent("skinshop:Apply",source,vRP.UserData(Passport,"Clothings"), true --[[ forceEmptyUpdate ]] --[[ Vai fazer com que esse evento não gere outro evento tentando salvar a roupa novamente no banco de dados! ]] )
		TriggerClientEvent("tattooshop:Apply",source,vRP.UserData(Passport,"Tattooshop"))
		TriggerClientEvent("barbershop:Apply",source,vRP.UserData(Passport,"Barbershop"))

		TriggerClientEvent("hud:Thirst",source,Datatable["Thirst"],Datatable["Hunger"])

		TriggerClientEvent("vRP:Active",source,Passport,Identity["name"].." "..Identity["name2"])

		TriggerClientEvent("spawn:Finish",source)
		TriggerEvent("Connect",Passport,source,SpawnSelected[Passport] == nil)
        exports["vrp"]:ChangePlayerBucket(source,1)
        if Ped then
            Entity(Ped)["state"]["Name"] = Identity["name"].." "..Identity["name2"]
            Entity(Ped)["state"]["Passport"] = Passport
            if vRP.HasGroup(Passport,"Iniciante") then
                Player(source)["state"]["Iniciante"] = true
                Entity(Ped)["state"]["Iniciante"] = true
            end
        end
		SpawnSelected[Passport] = true
        if Identity["tracking"] and Identity["tracking"] > 30*60 then
            Wait(5000)
            if not Older then
                TriggerClientEvent("hub:OpenNews",source)
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DeleteObject")
AddEventHandler("DeleteObject",function(Index)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Objects[Passport] and Objects[Passport][Index] then
		Objects[Passport][Index] = nil
	end

	TriggerEvent("DeleteObjectServer",Index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DebugObjectsClient")
AddEventHandler("DebugObjectsClient",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Objects[Passport] then
		for Index,_ in pairs(Objects[Passport]) do
			TriggerEvent("DeleteObjectServer",Index)
			Objects[Passport][Index] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DebugObjects",function(Passport)
	if Objects[Passport] then
		for Index,_ in pairs(Objects[Passport]) do
			TriggerEvent("DeleteObjectServer",Index)
			Objects[Passport][Index] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DeletePed")
AddEventHandler("DeletePed",function(Index)
	local Network = NetworkGetEntityFromNetworkId(Index)
	if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 1 then
		DeleteEntity(Network)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECTSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DeleteObjectServer",function(Index)
	local Network = NetworkGetEntityFromNetworkId(Index)
	if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 3 then
		DeleteEntity(Network)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
local TaxInfo = {
    ["MinBank"] = 10000000,
    ["Tax"] = 0.01,
}
function tvRP.GG(Locate)
	local source = source
	if GetPlayerRoutingBucket(source) < 900000 then
		local Passport = vRP.Passport(source)
		if Player(source)["state"]["Carry"] or PLAYER.CheckCarry(source) then
			TriggerClientEvent("Notify",source,"vermelho","Você não pode usar esse comando enquanto está sendo carregado.",5000,"GG")
            -- TriggerClientEvent("Notify2",source,"#cannotCWCarried")
			return
		end
        local Survival = SURVIVAL.CheckDeath(source)
		if Passport and Survival and Survival <= 0 then
			vRP.ClearInventory(Passport)
            -- local Bank = vRP.GetBank(source)
            -- if Bank and Bank > TaxInfo["MinBank"] then
            --     local Tax = Bank * TaxInfo["Tax"]
            --     vRP.RemoveBank(Passport,parseInt(Tax),true)
            -- end
            --if GlobalState["Hunger"] then
                vRP.UpgradeThirst(Passport,100)
                vRP.UpgradeHunger(Passport,100)
            --end

			TriggerEvent("DebugObjects",Passport)
			exports["vrp"]:SendWebHook("Airport","\n**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)

			SURVIVAL.Respawn(source,false,Locate)
			-- local PlayerAchievement = vRP.GetPlayerAchievements(Passport)
			-- if not PlayerAchievement[12] or not PlayerAchievement[12]["completed"] then
			-- 	vRP.UpdateAchievement(Passport,12,1)
			-- end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG2
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.GroupVIP()
	local source = source
    local Passport = vRP.Passport(source)
    local Job = vRP.UserGroupByType(Passport,"Job")
    if vRP.GroupVIP(nil, Job) then
        return true
    else
        local VIPs = vRP.GetGroup(Passport,"VIP")
        if VIPs and (VIPs["Premium"] and VIPs["Premium"][1] == 1) or (VIPs and VIPs["Blacks"]) then
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG2
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.GG2(Custom)
	local source = source
	if GetPlayerRoutingBucket(source) < 900000 then
		local Passport = vRP.Passport(source)
		if Player(source)["state"]["Carry"] or PLAYER.CheckCarry(source) then
			TriggerClientEvent("Notify",source,"vermelho","Você não pode usar esse comando enquanto está sendo carregado.",5000,"GG")
            -- TriggerClientEvent("Notify2",source,"#cannotCWCarried")
			return
		end
        local Survival = SURVIVAL.CheckDeath(source)
		if Passport and Survival and Survival <= 0 then
			local Group = vRP.UserGroupByType(Passport,"Job")
			local Consult = vRP.Query("painel/getallVip",{ name = Group })
            if Group ~= "Desempregado" and Group ~= "Iniciante" then
                if Custom then
                    vRP.ClearInventory(Passport)
                    --if GlobalState["Hunger"] then
                        vRP.UpgradeThirst(Passport,100)
                        vRP.UpgradeHunger(Passport,100)
                    --end
    
                    exports["vrp"]:SendWebHook("Airport","\n**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)
    
                    SURVIVAL.Respawn(source,nil,"PERSONALIZADO",nil,true)
                    --local PlayerAchievement = vRP.GetPlayerAchievements(Passport)
                    -- if not PlayerAchievement[12] or not PlayerAchievement[12]["completed"] then
                    --     vRP.UpdateAchievement(Passport,12,1)
                    -- end
                    return true
                end
                if Consult[1] and parseInt(Consult[1]["level"]) == 1 then
                    vRP.ClearInventory(Passport)
                    --if GlobalState["Hunger"] then
                        vRP.UpgradeThirst(Passport,100)
                        vRP.UpgradeHunger(Passport,100)
                    --end

                    exports["vrp"]:SendWebHook("Airport","\n**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)

                    SURVIVAL.Respawn(source,Group)
                    -- local PlayerAchievement = vRP.GetPlayerAchievements(Passport)
                    -- if not PlayerAchievement[12] or not PlayerAchievement[12]["completed"] then
                    --     vRP.UpdateAchievement(Passport,12,1)
                    -- end
                else
                    local VIPs = vRP.GetGroup(Passport,"VIP")
                    local NewVIP = vRP.HasVip(Passport)
                    local Allowed = false
                    local AllowedVips = {
                        ["Black"] = true,
                        ["Ouro"] = true,
                        ["Prata"] = true,
                        ["VipLancamento"] = true,
                    }
                    local NewVips = vRP.HasVip(Passport)
                    if NewVips then
                        for Group,_ in pairs(NewVips) do
                            if AllowedVips[Group] then
                                Allowed = true
                            end
                        end
                    end
                    if Allowed then
                        vRP.ClearInventory(Passport)
                        --if GlobalState["Hunger"] then
                            vRP.UpgradeThirst(Passport,100)
                            vRP.UpgradeHunger(Passport,100)
                        --end
        
                        exports["vrp"]:SendWebHook("Airport","\n**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)
        
                        SURVIVAL.Respawn(source,Group)
                        -- local PlayerAchievement = vRP.GetPlayerAchievements(Passport)
                        -- if not PlayerAchievement[12] or not PlayerAchievement[12]["completed"] then
                        --     vRP.UpdateAchievement(Passport,12,1)
                        -- end
                        return true
                    end
                    if VIPs and (VIPs["Premium"] and VIPs["Premium"][1] == 1) or (VIPs and VIPs["Blacks"]) then
                        vRP.ClearInventory(Passport)
                        --if GlobalState["Hunger"] then
                            vRP.UpgradeThirst(Passport,100)
                            vRP.UpgradeHunger(Passport,100)
                        --end
        
                        exports["vrp"]:SendWebHook("Airport","\n**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)
        
                        SURVIVAL.Respawn(source,Group)
                        -- local PlayerAchievement = vRP.GetPlayerAchievements(Passport)
                        -- if not PlayerAchievement[12] or not PlayerAchievement[12]["completed"] then
                        --     vRP.UpdateAchievement(Passport,12,1)
                        -- end
                    end
                end
                -- local Bank = vRP.GetBank(source)
                -- if Bank and Bank > TaxInfo["MinBank"] then
                --     local Tax = Bank * TaxInfo["Tax"]
                --     vRP.RemoveBank(Passport,parseInt(Tax),true)
                -- end
                return true
            end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBITO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ggm",function(source)
	if GetPlayerRoutingBucket(source) < 900000 then
		local Passport = vRP.Passport(source)
        local Group = vRP.UserGroupByType(Passport,"Mansao")
		if Group  then
            if Player(source)["state"]["Carry"] or PLAYER.CheckCarry(source) then
                TriggerClientEvent("Notify",source,"vermelho","Você não pode usar esse comando enquanto está sendo carregado.",5000,"GG")
                -- TriggerClientEvent("Notify2",source,"#cannotCWCarried")
                return
            end
            local Survival = SURVIVAL.CheckDeath(source)
            if Passport and Survival and Survival <= 0 then
                local Group = vRP.UserGroupByType(Passport,"Job")
                local Consult = vRP.Query("painel/getallVip",{ name = Group })
                if Consult[1] and parseInt(Consult[1]["level"]) == 1 then
                    vRP.ClearInventory(Passport)
                    --if GlobalState["Hunger"] then
                        vRP.UpgradeThirst(Passport,100)
                        vRP.UpgradeHunger(Passport,100)
                    --end
    
                    exports["vrp"]:SendWebHook("Airport","\n**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)
    
                    SURVIVAL.Respawn(source,false,false,Group)
                    -- local PlayerAchievement = vRP.GetPlayerAchievements(Passport)
                    -- if not PlayerAchievement[12] or not PlayerAchievement[12]["completed"] then
                    --     vRP.UpdateAchievement(Passport,12,1)
                    -- end
                end
            end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBITO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("obito",function(source)
	if GetPlayerRoutingBucket(source) < 900000 then
		local Passport = vRP.Passport(source)
        local VIPs = vRP.GetGroup(Passport,"VIP")
		if Passport and SURVIVAL.CheckDeath(source) and SURVIVAL.CheckDeath(source) >= 30 and VIPs then
			if VIPs and (VIPs["Premium"] and VIPs["Premium"][1] and VIPs["Premium"][1] <= 2) or (VIPs and VIPs["Blacks"]) or (VIPs and VIPs["Lancamento"]) then
				SURVIVAL.ResetSeconds(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ClearInventory(Passport)
	if vRP.Source(Passport) then
		local Passport = parseInt(Passport)
		local Datatable = vRP.Datatable(Passport)
		if Datatable["Inventory"] then
            local Iniciante = vRP.HasGroup(Passport,"Iniciante")
			for Slot,v in pairs(Datatable["Inventory"]) do
				local Item = SplitOne(v["item"])
                if Iniciante then
                    if InicianteItems[Item] then
                        Datatable["Inventory"][Slot] = nil
                    end
                else
                    if not NotCleanGG[Item] then
                        Datatable["Inventory"][Slot] = nil
                    end
                end
			end

			TriggerEvent("inventory:CleanWeapons",Passport)
		end
    else
        local Passport = parseInt(Passport)
		local Datatable = vRP.Datatable(Passport)
		if Datatable["Inventory"] then
            local Iniciante = vRP.HasGroup(Passport,"Iniciante")
			for Slot,v in pairs(Datatable["Inventory"]) do
				local Item = SplitOne(v["item"])
                if Iniciante then
                    if InicianteItems[Item] then
                        Datatable["Inventory"][Slot] = nil
                    end
                else
                    if not NotCleanGG[Item] then
                        Datatable["Inventory"][Slot] = nil
                    end
                end
			end
            vRP.Query("playerdata/UpdateData",{ 
                json.encode(Datatable),
                Passport,
                "Datatable"
            })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDAGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeThirst(Passport,Amount)
	local source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Datatable and source then
		if not Datatable["Thirst"] then
			Datatable["Thirst"] = 0
		end

		Datatable["Thirst"] = Datatable["Thirst"] + Amount

		if Datatable["Thirst"] > 100 then
			Datatable["Thirst"] = 100
		end

        TriggerClientEvent("hud:Thirst",source,Datatable["Thirst"],Datatable["Hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeHunger(Passport,Amount)
	local source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Datatable and source then
		if not Datatable["Hunger"] then
			Datatable["Hunger"] = 0
		end

		Datatable["Hunger"] = Datatable["Hunger"] + Amount

		if Datatable["Hunger"] > 100 then
			Datatable["Hunger"] = 100
		end

        TriggerClientEvent("hud:Thirst",source,Datatable["Thirst"],Datatable["Hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeThirst(Passport,Amount)
	local source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Datatable and source then
		if not Datatable["Thirst"] then
			Datatable["Thirst"] = 100
		end

		Datatable["Thirst"] = Datatable["Thirst"] - Amount

		if Datatable["Thirst"] < 0 then
			Datatable["Thirst"] = 0
		end

        TriggerClientEvent("hud:Thirst",source,Datatable["Thirst"],Datatable["Hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeHunger(Passport,Amount)
	local source = vRP.Source(Passport)
	local Datatable = vRP.Datatable(Passport)
	if Datatable and source then
		if not Datatable["Hunger"] then
			Datatable["Hunger"] = 100
		end

		Datatable["Hunger"] = Datatable["Hunger"] - Amount

		if Datatable["Hunger"] < 0 then
			Datatable["Hunger"] = 0
		end

        TriggerClientEvent("hud:Thirst",source,Datatable["Thirst"],Datatable["Hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOODS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Foods()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Datatable = vRP.Datatable(Passport)
		if Datatable then
			if not Datatable["Thirst"] then
				Datatable["Thirst"] = 100
			end

			if not Datatable["Hunger"] then
				Datatable["Hunger"] = 100
			end

			Datatable["Hunger"] = Datatable["Hunger"] - 1
			Datatable["Thirst"] = Datatable["Thirst"] - 1

			if Datatable["Thirst"] < 0 then
				Datatable["Thirst"] = 0
			end

			if Datatable["Hunger"] < 0 then
				Datatable["Hunger"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetHealth(source)
	local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        return GetEntityHealth(Ped)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ModelPlayer(source)
	local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
            return "mp_f_freemode_01"
        end

        return "mp_m_freemode_01"
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetExperience(Passport,Work)
	local Datatable = vRP.Datatable(Passport)
	if Datatable and Work then
		if not Datatable[Work] then
			Datatable[Work] = 0
		end

		return Datatable[Work]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PutExperience(Passport,Work,Number)
	local Datatable = vRP.Datatable(Passport)
	if Datatable then
		if not Datatable[Work] then
			Datatable[Work] = 0
		end

		Datatable[Work] = Datatable[Work] + Number
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetArmour(source,Amount)
	local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        local Armour = GetPedArmour(Ped)

        if (Armour + Amount) > 99 then
            Amount = 99 - Armour
        end

        SetPedArmour(Ped,Armour + Amount)
        TriggerClientEvent("forceArmValue",source, Armour + Amount)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Teleport(source,x,y,z)
	if x == nil or y == nil or z == nil then
		return
	end

	local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        -- SetEntityCoords(Ped,x + 0.0001,y + 0.0001,z + 0.0001,false,false,false,false)
        TriggerClientEvent("admin:Teleport",source,vector3(x + 0.0001,y + 0.0001,z + 0.0001))
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETENTITYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetEntityCoords(source)
	local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        return GetEntityCoords(Ped)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSIDEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InsideVehicle(source)
	local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        return GetVehiclePedIsIn(Ped) ~= 0 and true or false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveWeapons(source)
	if not source then
		return
	end

	local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        local Weapon = GetSelectedPedWeapon(Ped)

        RemoveWeaponFromPed(Ped,Weapon)
        RemoveAllPedWeapons(Ped,true)
        SetPedAmmo(Ped,Weapon,0)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPED
-----------------------------------------------------------------------------------------------------------------------------------------
-- function tvRP.CreatePed(Model,x,y,z,heading,typ)
-- 	local source = source
-- 	local mHash = GetHashKey(Model)
-- 	local Ped = CreatePed(typ,mHash,x,y,z,heading,true,false)

-- 	while not DoesEntityExist(Ped) do
-- 		Wait(1)
-- 	end

-- 	if DoesEntityExist(Ped) then
--         local Bucket = GetPlayerRoutingBucket(source)
--         SetEntityRoutingBucket(Ped,Bucket)

-- 		return true,NetworkGetNetworkIdFromEntity(Ped)
-- 	end

-- 	return false
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["CreateObject"] = true
function tvRP.CreateObject(Model,x,y,z,Heading)
    if not GlobalState["CreateObject"] then
        return false
    end
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Model then
		local mHash = GetHashKey(Model)
		local Object = CreateObject(mHash,x,y,z,true,true,false)

		while not DoesEntityExist(Object) do
			Wait(1)
		end

        if Heading then
            SetEntityHeading(Object,Heading)
        end

		if DoesEntityExist(Object) then
			local NetObjects = NetworkGetNetworkIdFromEntity(Object)

			if not Objects[Passport] then
				Objects[Passport] = {}
			end

			Objects[Passport][NetObjects] = true

			local Bucket = GetPlayerRoutingBucket(source)
			SetEntityRoutingBucket(Object,Bucket)

			return true,NetObjects
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	TriggerEvent("DebugObjects",Passport)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOODTHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
local savePlayers = os.time() + 300
local saveGroups = os.time() + 300

CreateThread(function()
    while true do
        for Passport,_ in pairs(Sources) do
            local Source = vRP.Source(Passport)
            if Characters[Source] then
                local AccountId = Characters[Source]["accountId"]
                if AccountId then
                    local inFirstActivation = firstActivation[AccountId]
                    if inFirstActivation and (os.time() - firstActivation[AccountId]) >= 1800 then
                        local Identity = vRP.Identity(Passport)
                        if Identity["name"] then
                            vRP.Query("new_player/setNewAction", { id = AccountId, action = GetNewPlayerNumber("Activation") })
                            TriggerClientEvent("promoter_score:Open", Source)
                            firstActivation[AccountId] = nil
                        end
                    end
                end
            end
        end
        Wait(60000*5)
    end
end)


CreateThread(function()
	while true do
        if os.time() >= savePlayers then
            savePlayers = os.time() + 300
            vRP.Query("players_amount/setTime",{ total = GetNumPlayerIndices() })
        end
        Wait(60000)
    end
end)

CreateThread(function()
	while true do
        if os.time() >= saveGroups then
            saveGroups = os.time() + 300
            for Permission,_ in pairs(Groups) do
                local _,total = vRP.NumPermission(Permission)
                vRP.Query("groups_amount/setTime",{ total = total, group = Permission })
                exports["painel"]:GivePointsPlayer(Permission,total)
            end
        end
		Wait(60000)
	end
end)

RegisterServerEvent("vRP:ChangeAFK")
AddEventHandler("vRP:ChangeAFK",function(Mode)
    local source = source
    Player(source)["state"]["AFK"] = Mode
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:BUCKETCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
local Working = {
    [1] = "Mining",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:BUCKETSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BucketServer")
AddEventHandler("vRP:BucketServer",function(source,Mode,Route,NewPlayer)
    local Ped = GetPlayerPed(source)
    if not Ped or Ped == 0 then 
        return
    end

    -- if NewPlayer then
    --     local RandomBucket = source+math.random(1,300000)
    --     exports["vrp"]:ChangePlayerBucket(source,RandomBucket)
    --     return
    -- end
	if Mode == "Enter" then
		if Route and Route > 1 then
            if not cityName == "Test" then
                SetRoutingBucketEntityLockdownMode(Route,"strict")
                SetRoutingBucketPopulationEnabled(Route,false)
            end
		end
        exports["vrp"]:ChangePlayerBucket(source,Route)
        if Ped then
            if Route and Route >= 900000 then
                return
            end
        end
	end
end)

vRP.Prepare("account_created/GetDaysPurchased","SELECT purchased,UNIX_TIMESTAMP(account_create) as created,discord,LA,DATEDIFF(CURDATE(), account_create) AS days FROM accounts WHERE id = @AccountId")
vRP.Prepare("account_created/UpdateLA","UPDATE accounts SET LA = 1 WHERE id = @AccountId")
function CheckPlayerPurchase(Passport,AccountId)
    local Days = 0
    local Query = vRP.Query("account_created/GetDaysPurchased",{ AccountId = AccountId })
    if Query and Query[1] then
        local Days = parseInt(Query[1]["days"])
        local Purchased = parseInt(Query[1]["purchased"])
        local Discord = Query[1]["discord"] or ""
        if Days <= 30 and Purchased >= 500 then
            local Created = os.date("%d/%m/%Y  %H:%M:%S",Query[1]["created"]) or ""
            exports["vrp"]:SendWebHook("purchased500","\n**Cidade:**"..cityName.."\n**Passaporte:** "..Passport.." "..vRP.FullName(Passport).. "\n**Total Gasto:**"..Purchased.."\n**Criação da conta:**"..Created.."\n**Discord:**<@"..Discord..">\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)
            vRP.Query("account_created/UpdateLA",{ AccountId = AccountId })
        end
    end
end

local Delivered = {}
AddEventHandler("newOrder",function(Payload,Order)
    if Order and Payload then
        if Order["user_id"] and not Delivered[Payload["id"]] then
            local Total = 0
            local Packages = {}
            local Identity = vRP.Identity(parseInt(Order["user_id"]))
            local Package
            Delivered[Payload["id"]] = true
            for i=1,#Payload["packages"] do
                Package = Payload["packages"][i]
                -- if Package["price"] then
                --     Total = Total + Package["price"] * Package["pivot"]["amount"]
                -- end
                Packages[#Packages+1] = { ["name"] = Package["name"], ["amount"] = Package["pivot"]["amount"] }
            end
            if Identity then
                for i=1,#Packages do
                    local Message = Identity["name"].." Comprou "..Packages[i]["name"].." x"..Packages[i]["amount"]
                    local Custom = {
                        background = "rgba(238,0,182,.75)",
                    }
                    TriggerClientEvent("chat:ClientMessage",-1,"",Message,"🏷️ LOJA VIP",false,Custom)
                    TriggerClientEvent("sounds:Private",-1,"compras",0.02)
                end
            end
            -- Total = Total - Payload["total"]
            Total = Payload["total"]
            if Identity then
            	local Account = vRP.Account(Identity["license"])
                local Query = vRP.Query("player_purchases/getPurchase",{ orderID = Payload["id"] })
                if not Query or not Query[1] then
                    if Identity["accountId"] then
                        vRP.Query("accounts/updateAmountPurchased",{ id = Identity["accountId"], amount = Total })
                        vRP.Query("player_purchases/setNewPurchase",{ Passport = Order["user_id"], Price = Total, Type = Payload["payment_method"], orderID = Payload["id"], Packages = json.encode(Packages), accountId = Identity["accountId"] })
                        CheckPlayerPurchase(parseInt(Order["user_id"]),Identity["accountId"])
                    else
                        vRP.Query("accounts/updateAmountPurchased",{ id = Account["id"], amount = Total })
                        vRP.Query("player_purchases/setNewPurchase",{ Passport = Order["user_id"], Price = Total, Type = Payload["payment_method"], orderID = Payload["id"], Packages = json.encode(Packages), accountId = Account["id"] })
                        CheckPlayerPurchase(parseInt(Order["user_id"]),Account["id"])
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    Wait(10000)
    Objects = {}
    while true do 
        Wait(60000*60)
        local Query = vRP.Query("new_player_promo/getAllPromo")
        for i=1,#Query do
            PerformHttpRequest("https://api.hydrus.gg/plugin/v1/coupons/"..Query[i]["tokenId"],function(err,text,headers)
                if err == 200 or err == 201 then
                    local Info = json.decode(text)
                    if Info["remaining"] == 0 then
                        vRP.Query("new_player_promo/redeemedPromo",{ tokenId = Query[i]["tokenId"] })
                    end
                end
            end,"GET",
            json.encode({}),{
                ["Authorization"] = "Bearer "..StoreToken[cityName],
                ['content-type'] = 'application/json'
            })
            Wait(500)
        end
    end
end)



function ChangePlayerBucket(Source,Bucket)
    if Source and Bucket then
        if DoesPlayerExist(Source) then
            if exports["admin"]:isPlayerToxic(Source) then
                Bucket = 5
            end
            SetPlayerRoutingBucket(Source,Bucket)
            Player(Source)["state"]["Route"] = Bucket
            if not cityName == "Test" then
                SetRoutingBucketEntityLockdownMode(Bucket,"strict")
                SetRoutingBucketEntityLockdownMode(Bucket,"strict")
            else
                SetRoutingBucketEntityLockdownMode(Bucket,"inactive")
                SetRoutingBucketEntityLockdownMode(Bucket,"inactive")
                SetRoutingBucketPopulationEnabled(Bucket,true)
                SetRoutingBucketPopulationEnabled(Bucket,true)
            end
        end
    end
end
exports("ChangePlayerBucket",ChangePlayerBucket)
-- exports["vrp"]:ChangePlayerBucket(source,Bucket)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local InspectAPI = {}
Tunnel.bindInterface("inventory/inspect", InspectAPI)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
cityName = GetConvar("cityName", "Base")
local openPlayer = {}
local openSource = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:RUNINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
local CanInspect = {
    [1] = true,
    [6] = true
}
RegisterServerEvent("police:runInspect")
AddEventHandler("police:runInspect",function(Entity,Source)
	local source = source
    if Source then
        source = Source
    end
	local Ped = GetPlayerPed(Entity[1])
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 and DoesEntityExist(Ped) then
        if Player(Entity[1])["state"]["Iniciante"] then
            TriggerClientEvent("Notify",source,"vermelho","Você não pode roubar alguém iniciante.",8000,"Revistar")
			-- TriggerClientEvent("Notify2",source,"#cantStealNewbie")
            return
        end
        if Player(Entity[1])["state"]["InSafeZone"] or Player(Entity[1])["state"]["inSafeMode"] or Player(Entity[1])["state"]["PVP"] or Player(Entity[1])["state"]["GreenMode"] or Player(source)["state"]["InSafeZone"] or Player(Entity[1])["state"]["PVP"] or Player(source)["state"]["inSafeMode"] or Player(source)["state"]["GreenMode"] then
            TriggerClientEvent("Notify",source,"negado","Você não pode roubar alguém em modo safe.",8000)
			-- TriggerClientEvent("Notify2",source,"#cantStealSafe")
            return
        end
        
        local ClosestPassport = vRP.Passport(Entity[1])
        if vRP.HasGroup(ClosestPassport, "Admin", 1) then
            return
        end

		if GetEntityHealth(Ped) > 100 and not vRP.HasGroup(Passport,"Policia") and not vRP.Request(Entity[1],"Aceita ser revistado?") then
            return
		end

        local Bucket = GetPlayerRoutingBucket(Entity[1])
        if not CanInspect[Bucket] then
            TriggerClientEvent("Notify",source,"negado","Impossibilitado de realizar a revista.",8000,"Revistar")
			-- TriggerClientEvent("Notify2","#cannotSearch")
            return
        end

		if GetEntityHealth(Ped) <= 100 then
            vRPC.playAnim(source,false,{"amb@medic@standing@tendtodead@idle_a","idle_a"},true)
		else
			vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
		end

		openSource[Passport] = Entity[1]
		openPlayer[Passport] = vRP.Passport(Entity[1])

		TriggerClientEvent("player:playerCarry",Entity[1],source,"handcuff")
		TriggerClientEvent("player:Commands",Entity[1],true)
		TriggerClientEvent("inventory:Close",Entity[1])
		TriggerClientEvent("inspect:Open",source,Entity)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function InspectAPI.openChest()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local otherInventory = {}
		local inventory = vRP.Inventory(openPlayer[Passport])
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["key"] = v["item"]
			v["slot"] = tonumber(k)

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			table.insert(otherInventory,v)
		end

		return otherInventory,vRP.InventoryWeight(openPlayer[Passport]),vRP.GetWeight(openPlayer[Passport])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
function InspectAPI.resetInspect()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if openSource[Passport] and DoesEntityExist(GetPlayerPed(openSource[Passport])) then
			TriggerClientEvent("player:Commands",openSource[Passport],false)
			TriggerClientEvent("player:playerCarry",openSource[Passport],source)
			vRPC.DestroyObjects(source)
			openSource[Passport] = nil
		end

		if openPlayer[Passport] then
			openPlayer[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function InspectAPI.storeItem(Item,Slot,Amount,Target)
	local source = source
	local Passport = vRP.Passport(source)
    if IsPremiumItem(Item) then
        TriggerClientEvent("Notify",source,"amarelo","Item bloqueado.",3000)
		-- TriggerClientEvent("Notify2",source,"#itemBlocked")
        TriggerClientEvent("inspect:Update",source,"requestChest") 
        return 
    end
	if Passport then
		if openSource[Passport] and DoesEntityExist(GetPlayerPed(openSource[Passport])) then
            if (itemType(Item) == "Armamento" or itemType(Item) == "Munição") and vRP.HasGroup(Passport,"Policia") and not vRP.HasGroup(openPlayer[Passport],"Policia") then
                TriggerClientEvent("Notify",source,"vermelho","Você não pode enviar esse item.",5000,"ENVIAR")
				-- TriggerClientEvent("Notify2",source,"#cannotSendItem")
                return
            end

			if (vRP.InventoryWeight(openPlayer[Passport]) + (itemWeight(Item) * Amount)) <= vRP.GetWeight(openPlayer[Passport]) then
				if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
					vRP.GiveItem(openPlayer[Passport],Item,Amount,true,Target)
					exports["vrp"]:SendWebHook("revistar","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Colocou:** "..Amount.." "..Item..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				-- TriggerClientEvent("Notify2",source,"#mochilaFull")
				TriggerClientEvent("inspect:Update",source,"requestChest")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local Block = {
	["WEAPON_COMBATPISTOL"] = true,
	["WEAPON_PISTOL_MK2"] = true,
	["WEAPON_CARBINERIFLE"] = true,
	["WEAPON_CARBINERIFLE_MK2"] = true,
	["WEAPON_SMG"] = true,
	["WEAPON_NIGHTSTICK"] = true,
	["WEAPON_SMG_AMMO"] = true,
	["WEAPON_PISTOL_AMMO"] = true,
	["WEAPON_RIFLE_AMMO"] = true,
	["vest"] = true,
	["handcuff"] = true,
	["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
}

local BlockPlayers = {
    ["weedleaf"] = true,
    ["amphetamine"] = true,
    ["weaponbody"] = true,
    ["capsula"] = true,
    ["cokeleaf"] = true,
    ["molas"] = true,
    ["polvora"] = true,
	["creator"] = true,
    ["acetone"] = true,
    ["sulfuric"] = true,
    ["silk"] = true,
    ["aguadestilada"] = true,
    ["cloro"] = true,
	["premium01"] = true,
    ["premium02"] = true,
    ["premium03"] = true,
    ["premium04"] = true,
    ["premium05"] = true,
	["vipsorteio"] = true,
	["kitfogueteiro"] = true,
	["kitcriminal"] = true,
	["kitmafioso"] = true,
	["kitdosraul"] = true,
	["kitboqueta"] = true,
	["gemstone"] = true,
    ["premiumplate"] = true,
	["phonechange"] = true,
    ["newchars"] = true,
    ["namechange"] = true,
    ["creditcard"] = true,
    ["vehkey"] = true,
    ["propertys"] = true,
	["money1"] = true,
	["money2"] = true,
	["money3"] = true,
	["money4"] = true,
	["money5"] = true,
	["packbasic"] = true,
	["packelite"] = true,
	["packpremium"] = true,
    ["rolepass"] = true,
    ["saline"] = true,
	["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
}

local BlockWeapons = {
    --["Base"] = true,
}

function InspectAPI.collectAllInspect(filtered)
	local source = source
	local Passport = vRP.Passport(source)
    if not Passport then
        return
    end
    if not openSource[Passport] then
        return
    end
    local OtherPed = GetPlayerPed(openSource[Passport])
    if not OtherPed then
        return
    end

    local Ped = GetPlayerPed(source)
    local Coords = GetEntityCoords(Ped)
    local OtherPassport = vRP.Passport(openSource[Passport])
    local Items = vRP.Inventory(OtherPassport)
    local isPolice = vRP.HasGroup(OtherPassport,"Policia")
    local isBagFull = false

    local itemsText = ""
    for k,v in pairs(Items) do
        local tag = SplitOne(v.item)
        if filtered and (not PoliceCleaner[tag]) then
            return
        end
        if BlockPlayers[tag] or Block[tag] or itemType(tag) == "Armamento" or IsPremiumItem(tag) then
            return
        end

        if vRP.getInventoryItemAmount(OtherPassport, tag) > 0 then
			if (vRP.InventoryWeight(Passport) + (itemWeight(tag) * v.amount)) <= vRP.GetWeight(Passport) then
                if (itemType(tag) == "Armamento" or itemType(tag) == "Munição") and vRP.HasGroup(OtherPassport,"Policia") then
                    TriggerClientEvent("Notify",source,"vermelho","Você não pode saquear item.",5000,"ENVIAR")
					-- TriggerClientEvent("Notify2",source,"#cannotLootItem")
                    return
                end
                
                if BlockWeapons[cityName] and (itemType(tag) == "Armamento" or itemType(tag) == "Munição") then
                    TriggerClientEvent("Notify",source,"vermelho","Você não pode saquear item.",5000,"ENVIAR")
                    return
                end

				if vRP.TakeItem(OtherPassport, tag, v.amount, true, v.slot) then
					vRP.GiveItem(Passport, tag, v.amount, false)
				end
			else
                isBagFull = true
                break
            end
            Wait(250)
            itemsText = itemsText .. "\n**"..vRP.format(parseInt(v.amount)).."x** "..itemName(tag)
        end
    end

    if isBagFull then
        TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		-- TriggerClientEvent("Notify2",source,"#mochilaFull")
    else
        TriggerClientEvent("Notify",source,"sucesso","Itens coletados com sucesso.",5000)
		-- TriggerClientEvent("Notify2",source,"#itensCollected")
    end
    TriggerClientEvent("inspect:Update",source)
    exports["vrp"]:SendWebHook("revistar","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Pegou:** "..itemsText.."\n**Do Passaporte:** "..OtherPassport.." ".. vRP.FullName(OtherPassport) .."\n**Cds:** "..Coords..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
end

function InspectAPI.takeItem(Item,Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
    if IsPremiumItem(Item) then
        TriggerClientEvent("Notify",source,"amarelo","Item bloqueado.",3000)
		-- TriggerClientEvent("Notify2",source,"#itemBlocked")
        TriggerClientEvent("inspect:Update",source,"requestChest") 
        return 
    end
	if Passport then
		if openSource[Passport] and DoesEntityExist(GetPlayerPed(openSource[Passport])) then
			local Split = SplitOne(Item)
            local OtherPassport = vRP.Passport(openSource[Passport])

			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)

			if vRP.HasGroup(OtherPassport,"Policia") and (Block[Split] or itemType(Split) == "Armamento") then
				TriggerClientEvent("Notify",source,"amarelo","Item bloqueado do policial.",3000)
				-- TriggerClientEvent("Notify2",source,"#itemBlockedPolice")
				TriggerClientEvent("inspect:Update",source,"requestChest") 
				return
			end

            if BlockWeapons[cityName] and (itemType(Split) == "Armamento" or itemType(Split) == "Munição") then
                TriggerClientEvent("Notify",source,"vermelho","Você não pode saquear item.",5000,"ENVIAR")
                return
            end

			if BlockPlayers[Split] then
				TriggerClientEvent("Notify",source,"amarelo","Item bloqueado de ser looteado.",3000)
				-- TriggerClientEvent("Notify2",source,"#itemLootBlocked")
				TriggerClientEvent("inspect:Update",source,"requestChest") 
				return
			end

			if (itemType(Item) == "Armamento" or itemType(Item) == "Munição") and vRP.HasGroup(OtherPassport,"Policia") then
                TriggerClientEvent("Notify",source,"vermelho","Você não pode pegar esse item.",5000,"PEGAR")
				-- TriggerClientEvent("Notify2",source,"#cannotTakeItem")
                return
            end

			-- if vRP.MaxItens(Passport,Item,Amount) then
			-- 	TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			-- 	TriggerClientEvent("inspect:Update",source,"requestChest")
			-- 	return
			-- end

			if (vRP.InventoryWeight(Passport) + (itemWeight(Item) * Amount)) <= vRP.GetWeight(Passport) then
				if vRP.TakeItem(openPlayer[Passport],Item,Amount,true,Slot) then
					vRP.GiveItem(Passport,Item,Amount,false,Target)
					TriggerClientEvent("inspect:Update",source,"requestChest")
					exports["vrp"]:SendWebHook("revistar","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Pegou:** "..Amount.." "..Item.."\n**Do Passaporte:** "..OtherPassport.." ".. vRP.FullName(OtherPassport) .."\n**Cds:** "..Coords..""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				-- TriggerClientEvent("Notify2",source,"#mochilaFull")
				TriggerClientEvent("inspect:Update",source,"requestChest")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function InspectAPI.updateChest(Slot,Target,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if openSource[Passport] and DoesEntityExist(GetPlayerPed(openSource[Passport])) then
			if vRP.invUpdate(openPlayer[Passport],Slot,Target,Amount) then
				TriggerClientEvent("inspect:Update",source,"requestChest")
			end
		end
	end
end


AddEventHandler("playerDropped",function(Reason)
    local OpenPassport
    local OpenSource
    for Pasport,Source in pairs(openSource) do
        if Source == source then
            OpenPassport = Pasport
            OpenSource = vRP.Source(OpenPassport)
        end
    end

    if openSource[OpenPassport] then
        if openSource[Passport] then
            openSource[Passport] = nil
        end
    end

    if openPlayer[Passport] then
        openPlayer[Passport] = nil
    end

    if OpenSource then
        TriggerClientEvent("inspect:Close",OpenSource)
    end
end)
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
Tunnel.bindInterface("skinshop",Creative)

vRP.Prepare("character/UpdateFirstSpawn","UPDATE characters SET firstspawn = current_timestamp() WHERE id = @Passport")
function Creative.Update(Clothes)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Tables = json.encode(Clothes)
		if Tables ~= "[]" then
			vRP.Query("playerdata/UpdateData",{ 
                Tables,
                Passport,
                "Clothings",
            })
		end
        local Quantity = GetNumPlayerIndices()
        if Player(source)["state"]["FirstLogin"] then
            -- if Quantity > 200 then
            --     TriggerClientEvent("spawn:TeleportNewbie",source,true)
            -- else
            --end
        end
	end
end


function Creative.Open()
	local Source = source
    local Bucket = parseInt(Source)+5001
    if GetPlayerRoutingBucket(Source) == 12 then
        return
    end
    exports["vrp"]:ChangePlayerBucket(Source,Bucket)
end

function Creative.Cancel()
	local Source   = source
    local passport = vRP.Passport(source)

    if (passport) then
        local Bucket = 1
        if GetPlayerRoutingBucket(Source) == 12 then
            return
        end
        exports["vrp"]:ChangePlayerBucket(Source,Bucket)
    end
end

--function Creative.tryBuyCloth(category, index, isMale)
--    local source = source
--    local data = SharedClothingData[category]
--	if (not data) then
--        return false
--    end
--
--    if ((index > data.item) or (index < data.min)) then
--        return false
--    end
--
--    local Passport = vRP.Passport(source)
--    if (not Passport) then
--        return false
--    end
--
--    local success = false
--    local mp = isMale and "mp_m_freemode_01" or "mp_f_freemode_01"
--    local isVipOrDiamond = false
--    local isDiamond = false
--    for k,v in pairs(data.diamonds[mp]) do
--        if (k == tostring(index)) then
--            if vRP.PaymentGems(Passport,ShopsConfig[Type]["List"][Item] * Amount) then
--                TriggerClientEvent("Notify",source,"sucesso","<b>Roupa</b> comprada com sucesso.",5000)
--                success = true
--                isVipOrDiamond = true
--                isDiamond = true
--                break;
--            end
--            TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.",5000)
--            return false
--        end
--    end
--
--    for k,v in pairs(data.vip) do
--        if (k == tostring(index)) then
--            if vRP.HasPermission(Passport,"Premium") then
--                success = true
--                isVipOrDiamond = true
--                break;
--            end
--            TriggerClientEvent("Notify",source,"vermelho","<b>Permissão</b> insuficiente.",5000)
--            return false
--        end
--    end
--
--    if not isVipOrDiamond then
--        local price = data.defaultPrice
--        for k,v in pairs(data.prices) do
--            if (k == tostring(index)) then
--                price = v
--                break;
--            end
--        end
--
--        if vRP.PaymentFull(Passport, price) then
--            success = true
--            TriggerClientEvent("Notify",source,"sucesso","<b>Roupa</b> comprada com sucesso.",5000)
--        else
--            TriggerClientEvent("Notify",source,"vermelho","<b>Dinheiro</b> insuficiente.",5000)
--            return false
--        end
--    end
--
--    if success and isDiamond then
--        local oldData = json.decode(vRP.UserData(Passport, 'OwnedClothes'))
--        if (not oldData) then
--            oldData = {}
--        end
--
--        if (not oldData[category]) then
--            oldData[category] = {}
--        end
--
--        if (not oldData[category][mp]) then
--            oldData[category][mp] = {}
--        end
--
--        table.insert(oldData[category][mp], index)
--        vRP.Query("playerdata/SetData",{ Passport = Passport, dkey = "OwnedClothes", dvalue = json.encode(oldData) })
--        return true
--    end
--
--    return false
--end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		if vRP.HasGroup(Passport,"Admin",3) or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) or vRP.HasGroup(Passport,"QA") then
			local ClosestPed = vRP.Source(Message[1])
            vRP.SkinCharacter(parseInt(Message[1]),Message[2])
			if ClosestPed then
				vRPC.Skin(ClosestPed,Message[2])
				exports["vrp"]:SendWebHook("skin","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Setou skin:** "..Message[2].."\n**Passaporte:** "..Message[1].." " .. vRP.FullName(Message[1]) .. ""..os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("skinshop:Remove")
AddEventHandler("skinshop:Remove",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			if vRP.HasGroup(Passport,"Policia") then
				TriggerClientEvent("skinshop:set"..Mode,ClosestPed)
			end
		end
	end
end)

-- RegisterCommand("SetSkins"),function(Source,Message)
--     if Source == 0 then
--         local ClosestPed = vRP.Source(Message[1])
--         if ClosestPed then
--             vRPC.Skin(ClosestPed,Message[2])
--             vRP.SkinCharacter(parseInt(Message[1]),Message[2])
--             print("Skin setada com sucesso!")
--         else
--             vRP.SkinCharacter(parseInt(Message[1]),Message[2])
--             print("Skin setada com sucesso!(Jogador Offline)")
--         end
--     end
-- end
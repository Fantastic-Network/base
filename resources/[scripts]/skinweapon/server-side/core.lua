-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Flexin = {}
Tunnel.bindInterface("skinweapon",Flexin)
vCLIENT = Tunnel.getInterface("skinweapon")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("skinweapon/selectskinWeapon","SELECT * FROM skinweapon WHERE user_id = @user_id and weapon = @weapon")
vRP.Prepare("skinweapon/selectallskinWeapon","SELECT * FROM skinweapon WHERE user_id = @user_id")
vRP.Prepare("skinweapon/verifyskinWeapon","SELECT * FROM skinweapon WHERE user_id = @user_id and component = @component")
vRP.Prepare("skinweapon/addskinWeapon","INSERT IGNORE INTO skinweapon(user_id,component,weapon,equip) VALUES(@user_id,@component,@weapon,@equip)")
vRP.Prepare("skinweapon/removeskinWeapon","DELETE FROM skinweapon WHERE user_id = @user_id and component = @component")
vRP.Prepare("skinweapon/moveskinWeapon","UPDATE skinweapon SET user_id = @nuser_id WHERE user_id = @user_id AND component = @component")
vRP.Prepare("skinweapon/equipskinWeapon","UPDATE skinweapon SET equip = @equip WHERE user_id = @user_id AND component = @component")
vRP.Prepare("skinweapon/getStock","SELECT stock FROM skinstock WHERE model = @model")
vRP.Prepare("skinweapon/updateStock","UPDATE skinstock SET stock = @stock WHERE model = @model")

vRP.Prepare("skinweapon/initTable","CREATE TABLE IF NOT EXISTS `skinweapon` (`user_id` int(11) NOT NULL,`component` varchar(50) NOT NULL,`weapon` varchar(50) NOT NULL,`equip` varchar(5) NOT NULL DEFAULT 'false',PRIMARY KEY (`user_id`,`component`) USING BTREE,KEY `dkey` (`user_id`,`component`) USING BTREE) ENGINE=InnoDB DEFAULT CHARSET=latin1;")
vRP.Prepare("skinweapon/removeSkinStock","DROP TABLE IF EXISTS `skinstock`;")
vRP.Prepare("skinweapon/createSkinStock","CREATE TABLE IF NOT EXISTS `skinstock` (`model` varchar(60) NOT NULL,`stock` int(11) DEFAULT 0,PRIMARY KEY (`model`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;")

vRP.Prepare("skinweapon/addskinWeaponExpires","INSERT IGNORE INTO skinweapon(user_id,component,weapon,equip,date,expirate) VALUES(@passport,@component,@weapon,@equip,DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL 30 DAY),1)")
vRP.Prepare("skinweapon/removeskinWeaponExpired","DELETE FROM skinweapon WHERE expirate = 1 AND date < CURDATE();")

local removeSkins = {
	"",
}

-- CreateThread(function()
-- 	vRP.Query("skinweapon/initTable")
-- 	vRP.Query("skinweapon/removeSkinStock")

-- 	Wait(1000)
-- 	vRP.Query("skinweapon/createSkinStock")

-- 	Wait(1000)
-- 	for k,v in pairs(skinglobal) do
-- 		vRP.Prepare("skinweapon/insertSkinStock", string.format("INSERT IGNORE INTO `skinstock` (`model`, `stock`) VALUES ('%s', %d)", k, 500))
-- 		vRP.Query("skinweapon/insertSkinStock")
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
GlobalState["Pistol"] = {}
GlobalState["Rifle"] = {}
CachedSkins = {}
PlayerSkins = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("skinweapon:Open")
AddEventHandler("skinweapon:Open",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not perm or vRP.HasGroup(Passport,perm) then
			TriggerClientEvent("skinweapon:OpenClient",source)
		end
	end
end)

RegisterCommand(command,function(source,args,rawCommand)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not perm or vRP.HasGroup(Passport,perm) then
			TriggerClientEvent("skinweapon:OpenClient",source)
            TriggerClientEvent("hud:Active",source,false)
            TriggerClientEvent("Notify:Remkey",source,true)
            TriggerClientEvent("safezone:remPromo",source,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Flexin.RequestSkins()
	local Pistol = {}
	local Rifle = {}

	for k,v in pairs(skinglobal) do
		local consult = vRP.Query("skinweapon/getStock",{ model = k })
		if v[4] == "pistol" then
			Pistol[#Pistol + 1] = { k = k, name = v[1], price = v[2], weapon = v[3], stock = consult[1]["stock"], rarity = v[5] }
		elseif v[4] == "rifle" then
			Rifle[#Rifle + 1] = { k = k, name = v[1], price = v[2], weapon = v[3], stock = consult[1]["stock"], rarity = v[5] }
		end
	end

	GlobalState:set("Pistol",Pistol,true)
	GlobalState:set("Rifle",Rifle,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDaS
-----------------------------------------------------------------------------------------------------------------------------------------
function Flexin.RequestPossuidas()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local skinList = {}
		local skinWeapon = vRP.Query("skinweapon/selectallskinWeapon",{ user_id = Passport })
		for k,v in pairs(skinWeapon) do
			local skinEquip = "Desequipada"
			local skinPrices = parseInt(skinglobal[v["component"]][2]) * 0.50

			if v["equip"] == "true" then
				skinEquip = "Equipada"
			end

			skinList[#skinList + 1] = { k = v["component"], name = skinglobal[v["component"]][1], price = parseInt(skinPrices), weapon = v["weapon"], equip = skinEquip, rarity = skinglobal[v["component"]][5] }
		end

		return skinList
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTTRANSF
-----------------------------------------------------------------------------------------------------------------------------------------
function Flexin.RequestTransf(skinName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil then
			Active[Passport] = true

			local myskinWeapon = vRP.Query("skinweapon/verifyskinWeapon",{ user_id = Passport, component = skinName })
			local minValue = parseInt(skinglobal[skinName][2] * 0.50)
			if myskinWeapon[1] then
				local Infos = vKEYBOARD.keyDouble(source,"<b>Passaporte:</b>","<b>Valor a ser cobrado:</b> (valor mínimo "..minValue.." gems, taxa de 10%)")
				if Infos then
					if parseInt(Infos[2]) < minValue then
						TriggerClientEvent("Notify",source,"vermelho","Valor abaixo do valor mínimo.",5000,"Negado")
						-- TriggerClientEvent("Notify2",source,"#belowMinValue")
						Active[Passport] = nil
						return
					end

					local OtherPassport = parseInt(Infos[1])
					local OtherSource = vRP.Source(parseInt(Infos[1]))
					local Identity = vRP.Identity(Passport)
					local OtherIdentity = vRP.Identity(OtherPassport)
					local Value = parseInt(Infos[2])
					local Tax = parseInt(Value * 0.10)
					if Identity and OtherIdentity then
						if vRP.Request(source,"Transferir a skin <b>"..skinglobal[skinName][1].."</b> para <b>"..OtherIdentity["name"].." "..OtherIdentity["name2"].."</b> no valor de "..Value.." <b>Gemas</b>?") then
							if vRP.Request(OtherSource,"Aceitar a skin <b>"..skinglobal[skinName][1].."</b> de <b>"..Identity["name"].." "..Identity["name2"].."</b> no valor de "..Value.." <b>Gemas</b>?") then
								if vRP.PaymentGems(OtherPassport,Value) then
									local skinWeapon = vRP.Query("skinweapon/verifyskinWeapon",{ user_id = parseInt(OtherPassport), component = skinName })
									if skinWeapon[1] then
										TriggerClientEvent("Notify",source,"amarelo","<b>"..OtherIdentity["name"].." "..OtherIdentity["name2"].."</b> já possui esta skin.",5000,"Aviso")
										-- TriggerClientEvent("Notify2",source,"#playerXHaveSkin",{msg=OtherIdentity["name"],msg2=OtherIdentity["name2"]})
										TriggerClientEvent("Notify",OtherSource,"amarelo","Você já possui esta skin.",5000,"Atenção")
										-- TriggerClientEvent("Notify2",OtherSource,"#playerHaveSkin")
									else
										vRP.Query("skinweapon/moveskinWeapon",{ user_id = Passport, nuser_id = parseInt(OtherPassport), component = skinName })
										vRP.Query("skinweapon/equipskinWeapon",{ user_id = OtherPassport, equip = "false", component = skinName })
										vRP.UpgradeGemstone(Passport,Value - Tax)
										TriggerClientEvent("Notify",source,"verde","Transferência concluída, você recebeu "..Value - Tax.." <b>Gemas</b>, taxa cobrada "..Tax.." <b>Gemas</b>.",5000,"Sucesso")
										exports["vrp"]:SendWebHook("skin-arma", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Vendeu:** " .. skinName .. "\n**Valor:** " .. Value .. "\n**Para Passaporte:** " .. OtherPassport .. " " .. vRP.FullName(OtherPassport) .. "" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
										-- TriggerClientEvent("Notify2",source,"#transferCTax",{msg=Value - Tax,msg2=Tax})
										TriggerClientEvent("Notify",OtherSource,"verde","Transferência concluída.",5000,"Sucesso")
										-- TriggerClientEvent("Notify2",OtherSource,"#transferC")
									end
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>"..OtherIdentity["name"].." "..OtherIdentity["name2"].." não possui <b>Gemas</b> insuficientes.",5000,"Negado")
									-- TriggerClientEvent("Notify2",source,"#dontHaveGem",{msg=OtherIdentity["name"],msg2=OtherIdentity["name2"]})
									TriggerClientEvent("Notify",OtherSource,"vermelho","<b>Gemas</b> insuficientes.",5000,"Negado")
									-- TriggerClientEvent("Notify2",OtherSource,"#notEnoughGems")
								end
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..OtherIdentity["name"].." "..OtherIdentity["name2"].." não aceitou a transferência.",5000,"Negado")
								-- TriggerClientEvent("Notify2",source,"#rejectedTransfer",{msg=OtherIdentity["name"],msg2=OtherIdentity["name2"]})
							end
						end
					end
				end
			end

			Active[Passport] = nil
		end
	end
end
CreateThread(function()
    Wait(5000)
    Flexin.RequestSkins()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
function Flexin.RequestBuy(skinName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil then
			Active[Passport] = true

			local consult = vRP.Query("skinweapon/getStock",{ model = skinName })
			if consult[1]["stock"] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Essa skin não tem mais estoque.",1000,"Aviso")
				-- TriggerClientEvent("Notify2",source,"#emptyStock")
				Active[Passport] = nil
				return
			end

			local skinWeapon = vRP.Query("skinweapon/verifyskinWeapon",{ user_id = Passport, component = skinName })
			if skinWeapon[1] then
				TriggerClientEvent("Notify",source,"amarelo","Já possui uma <b>"..skinglobal[skinName][1].."</b>.",3000,"Aviso")
				-- TriggerClientEvent("Notify2",source,"#haveXSkin",{msg=skinglobal[skinName][1]})
				Active[Passport] = nil
				return
			else
				local skinPrice = parseInt(skinglobal[skinName][2])
				if vRP.Request(source,"Comprar <b>"..skinglobal[skinName][1].."</b> por <b>$"..parseFormat(skinPrice).."</b> gemas?") then
					if vRP.PaymentGems(Passport,skinPrice) then
						vRP.Query("skinweapon/addskinWeapon",{ user_id = Passport, component = skinName, weapon = skinglobal[skinName][3], equip = "false" })
						vRP.Query("skinweapon/updateStock", { stock = parseInt(consult[1]["stock"] - 1), model = skinName })
						Flexin.RequestSkins()
						TriggerClientEvent("skinweapon:Update",source,"requestPistol")
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000,"Sucesso")
						-- TriggerClientEvent("Notify2",source,"#completedPurchase")
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000,"Negado")
						-- TriggerClientEvent("Notify2",source,"#notEnoughGems")
					end
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSELL
-----------------------------------------------------------------------------------------------------------------------------------------
function Flexin.RequestSell(skinName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil then
			Active[Passport] = true

			local consult = vRP.Query("skinweapon/getStock",{ model = skinName })
			if consult then
				local skinPrices = parseInt(skinglobal[skinName][2]) * 0.5
				local sellText = "Vender a skin <b>"..skinglobal[skinName][1].."</b> por <b>"..parseFormat(skinPrices).."</b> gemas?"

				if vRP.Request(source,sellText) then
					vRP.Query("skinweapon/removeskinWeapon",{ user_id = Passport, component = skinName })
					vRP.Query("skinweapon/updateStock", { stock = parseInt(consult[1]["stock"] + 1), model = skinName })
					Flexin.requestVehs()
					TriggerClientEvent("skinweapon:Update",source,"requestPossuidas")
					TriggerClientEvent("Notify",source,"verde","Venda concluída.",5000,"Sucesso")
					-- TriggerClientEvent("Notify2",source,"#completedSale")
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTEQUIP
-----------------------------------------------------------------------------------------------------------------------------------------
function RequestEquip(source,SkinName)
    local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil then
			Active[Passport] = true

			local skinWeapon = vRP.Query("skinweapon/selectskinWeapon",{ user_id = Passport, weapon = skinglobal[SkinName][3] })
			if skinWeapon[1] then
				for k,v in ipairs(skinWeapon) do
					if v["equip"] == "true" then
						vRP.Query("skinweapon/equipskinWeapon",{ user_id = Passport, equip = "false", component = v["component"] })
					end
				end
			end

            if not PlayerSkins[Passport] then
                PlayerSkins[Passport] = {}
            end

			vRP.Query("skinweapon/equipskinWeapon",{ user_id = Passport, equip = "true", component = SkinName })
            PlayerSkins[Passport][skinglobal[SkinName][3]] = SkinName
			Flexin.UpdateSkin(Passport,skinglobal[SkinName][3],SkinName)
			TriggerClientEvent("skinweapon:Update",source,"requestPossuidas")
			TriggerClientEvent("Notify",source,"verde","Skin equipada.",5000,"Sucesso")
			-- TriggerClientEvent("Notify2",source,"#equipskinWeapon")
            TriggerClientEvent("inventory:UpdateSkins",source,PlayerSkins[Passport])

			Active[Passport] = nil
		end
	end
end
function Flexin.RequestEquip(skinName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil then
			Active[Passport] = true

			local skinWeapon = vRP.Query("skinweapon/selectskinWeapon",{ user_id = Passport, weapon = skinglobal[skinName][3] })
			if skinWeapon[1] then
				for k,v in ipairs(skinWeapon) do
					if v["equip"] == "true" then
						vRP.Query("skinweapon/equipskinWeapon",{ user_id = Passport, equip = "false", component = v["component"] })
					end
				end
			end

            if not PlayerSkins[Passport] then
                PlayerSkins[Passport] = {}
            end

			vRP.Query("skinweapon/equipskinWeapon",{ user_id = Passport, equip = "true", component = skinName })
            PlayerSkins[Passport][skinglobal[skinName][3]] = skinName
			Flexin.UpdateSkin(Passport,skinglobal[skinName][3],skinName)
			TriggerClientEvent("skinweapon:Update",source,"requestPossuidas")
			TriggerClientEvent("Notify",source,"verde","Skin equipada.",5000,"Sucesso")
			-- TriggerClientEvent("Notify2",source,"#equipskinWeapon")

            TriggerClientEvent("inventory:UpdateSkins",source,PlayerSkins[Passport])

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTUNEQUIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Flexin.RequestUnequip(skinName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Active[Passport] == nil then
			Active[Passport] = true

			vRP.Query("skinweapon/equipskinWeapon",{ user_id = Passport, equip = "false", component = skinName })
			Flexin.UpdateSkin(Passport,skinglobal[skinName][3],nil)
			TriggerClientEvent("skinweapon:Update",source,"requestPossuidas")
			TriggerClientEvent("Notify",source,"verde","Skin desequipada.",5000,"Sucesso")
			-- TriggerClientEvent("Notify2",source,"#unequipskinWeapon")
            if PlayerSkins[Passport] and PlayerSkins[Passport][skinglobal[skinName][3]] then
                PlayerSkins[Passport][skinglobal[skinName][3]] = nil
            end
            TriggerClientEvent("inventory:UpdateSkins",source,PlayerSkins[Passport])

			Active[Passport] = nil
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function Flexin.UpdateSkin(Passport,Weapon,Component)
	if Component then
		local Skins = CachedSkins
		Skins[Weapon] = {
			[Passport] = Component
		}
        CachedSkins = Skins
	else
		local Skins = CachedSkins
		Skins[Weapon] = nil
        CachedSkins = Skins
	end
end

exports("GetSkins",function(Item,Passport)
    if CachedSkins[Item] then
        return CachedSkins[Item][Passport]
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local skinWeapon = vRP.Query("skinweapon/selectallskinWeapon",{ user_id = Passport })
	if skinWeapon[1] then
        if not PlayerSkins[Passport] then
            PlayerSkins[Passport] = {}
        end
		for k,v in ipairs(skinWeapon) do
			if v["equip"] == "true" then
				Flexin.UpdateSkin(Passport,v["weapon"],v["component"])
                PlayerSkins[Passport][v["weapon"]] = v["component"]
			end
		end
        TriggerClientEvent("inventory:UpdateSkins",source,PlayerSkins[Passport])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
    PlayerSkins[Passport] = nil
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSKINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("SetSkin",function(Source,Message)
    if Source == 0 then
        local Passport = parseInt(Message[1])
        local SkinName = Message[2]
        local Weapon = skinglobal[SkinName][3]
        local Source = vRP.Source(Passport)
        if Passport and Weapon and SkinName then
            vRP.Query("skinweapon/addskinWeaponExpires",{ Passport = Passport, Weapon = Weapon, Component = SkinName, Equip = "false" })
            if Source then
                RequestEquip(Source,SkinName)
            end
        end
    end
end)

CreateThread(function()
    vRP.Query("skinweapon/removeskinWeaponExpired",{})
end)
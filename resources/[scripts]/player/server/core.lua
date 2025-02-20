-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("player",Creative)
vCLIENT = Tunnel.getInterface("player")
vSKINSHOP = Tunnel.getInterface("skinshop")
vKEYBOARD = Tunnel.getInterface("keyboard")
vSKINSHOP = Tunnel.getInterface("skinshop")
PLAYER = Tunnel.getInterface("player")

cityName = GetConvar("cityName", "Base")
local AdminQRU = {}
local Active = {}
local Relationship = {}
SURVIVAL = Tunnel.getInterface("survival")

RegisterCommand("desistir",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
        if Player(source)["state"]["Carry"] or PLAYER.CheckCarry(source) then
			TriggerClientEvent("Notify",source,"vermelho","Você não pode usar esse comando enquanto está sendo carregado.",5000,"GG")
			return
		end
        if vRP.GetHealth(source) then
            if Passport and vRP.GetHealth(source) <= 100 then
                local Group = "Policia"
                if vRP.HasGroup(Passport,Group) then
                    local Consult = vRP.Query("painel/getallVip",{ name = Group })
                    if Consult[1] and parseInt(Consult[1]["level"]) == 1 then
                        vRP.ClearInventory(Passport)
                        --if GlobalState["Hunger"] then
                            vRP.UpgradeThirst(Passport,100)
                            vRP.UpgradeHunger(Passport,100)
                        --end
                        exports["vrp"]:SendWebHook("Airport","\n**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790)
                        SURVIVAL.Respawn(source,Group)
                    end
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RELATIONSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("separar",function(source,Message,History)
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    local Keyboard = vKEYBOARD.keySingle(source,"Passaporte do relacionado:")
    if Keyboard and Keyboard[1] then
        local OtherPassport = parseInt(string.match(Identity["relationship"], "%d+"))
        local OtherIdentity = vRP.Identity(OtherPassport)
        if OtherIdentity and vRP.Request(source,"Aceitar separação?","Sim","Não") then
            vRP.UpdateRelationship(Passport,"Solteiro")
            vRP.UpdateRelationship(OtherPassport,"Solteiro")
            TriggerClientEvent("Notify",-1,"verde","<b>"..Identity["name"].." "..Identity["name2"].."</b> e <b>"..OtherIdentity["name"].." "..OtherIdentity["name2"].."</b> se separaram, venham gados.",5000)
            -- TriggerClientEvent("Notify2",-1,"#separar",{msg=Identity["name"],msg2=Identity["name2"],msg3=OtherIdentity["name"],msg4=OtherIdentity["name2"]})
        end
    end
end)

RegisterServerEvent("player:Relationship")
AddEventHandler("player:Relationship",function(Entitys)
	local source = source
	local Passport = vRP.Passport(source)
	local OtherPassport = vRP.Passport(Entitys)
    local Custom = {
        background = "rgba(240, 118, 139,.95)",
    }
	if Passport and OtherPassport then
		if Relationship[Passport] and Relationship[Passport] > os.time() then
            TriggerClientEvent("Notify2",source,"#relationship",{msg=Relationship[Passport] - os.time()})
			return
		end

		Relationship[Passport] = os.time() + (60 * 5)

		local Identity = vRP.Identity(Passport)
		local OtherIdentity = vRP.Identity(OtherPassport)
		local Split = splitString(Identity["relationship"])
		local Splits = splitString(OtherIdentity["relationship"])

		if Identity["relationship"] == "Solteiro" and OtherIdentity["relationship"] == "Solteiro" then
			if vRP.Request(Entitys,""..Identity["name"].." "..Identity["name2"].." quer namorar com você, você aceita?","Sim","Não") then
				vRP.UpdateRelationship(Passport,"Namorando-"..OtherPassport)
				vRP.UpdateRelationship(OtherPassport,"Namorando-"..Passport)
                TriggerClientEvent("chat:ClientMessage",-1,"",Identity["name"].." "..Identity["name2"].." começou a namorar com "..OtherIdentity["name"].." "..OtherIdentity["name2"].."","❤️ Relacionamento",false,Custom)	
                TriggerClientEvent("sounds:Private",-1,"namoro",0.04)
			end
		elseif Identity["relationship"] == "Namorando-"..OtherPassport and OtherIdentity["relationship"] == "Namorando-"..Passport then
			if vRP.Request(Entitys,"Aceitar separação?","Sim","Não") then
				vRP.UpdateRelationship(Passport,"Solteiro")
				vRP.UpdateRelationship(OtherPassport,"Solteiro")
                TriggerClientEvent("chat:ClientMessage",-1,"",Identity["name"].." "..Identity["name2"].." e "..OtherIdentity["name"].." "..OtherIdentity["name2"].." se separaram, já podem mandar um Oi sumida(o)","🤲 Relacionamento",false,Custom)	
                TriggerClientEvent("sounds:Private",-1,"namoro",0.04)
			end
		elseif Split[1] == "Namorando" and parseInt(Split[2]) ~= parseInt(OtherPassport) then
			local Number = parseInt(Split[2])
			local OtherIdentity = vRP.Identity(Number)
            if OtherIdentity then
                TriggerClientEvent("chat:ClientMessage",-1,"","Alo "..OtherIdentity["name"].." "..OtherIdentity["name2"].." chifrudo(a), "..Identity["name"].." "..Identity["name2"].." ta tentando te trair.","🐂 Relacionamento",false,Custom)
                TriggerClientEvent("sounds:Private",-1,"namoro",0.04)
            end
		elseif Split[1] == "Solteiro" and Splits[1] == "Namorando" then
			local Number = parseInt(Splits[2])
			local OtherIdentity = vRP.Identity(Number)
            if OtherIdentity then
                TriggerClientEvent("chat:ClientMessage",-1,"","Alo "..OtherIdentity["name"].." "..OtherIdentity["name2"].." chifrudo(a), "..Identity["name"].." "..Identity["name2"].." tentou te meter gaia.","🐂 Relacionamento",false,Custom)
                TriggerClientEvent("sounds:Private",-1,"namoro",0.04)
            end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DESBUGAR
-----------------------------------------------------------------------------------------------------------------------------------------
local Debug = {}
RegisterServerEvent("player:Debug")
AddEventHandler("player:Debug",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Debug[Passport] or os.time() > Debug[Passport] then
		TriggerClientEvent("skinshop:Apply",source,vRP.UserData(Passport,"Clothings"))
		TriggerClientEvent("tattooshop:Apply",source,vRP.UserData(Passport,"Tattooshop"))
        TriggerClientEvent("barbershop:Apply",source,vRP.UserData(Passport,"Barbershop"))
		TriggerClientEvent("target:Debug",source)

		Debug[Passport] = os.time() + 300
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DUITEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
local DuiTextures = {
	["MRPD"] = {
		["Distance"] = 1.50,
		["Dimension"] = 1.25,
		["Label"] = "Quadro Branco",
		["Coords"] = vec3(439.47,-985.85,35.99),
		["Link"] = "https://creative-rp.com/Quadro.png",
		["Dict"] = "prop_planning_b1",
		["Texture"] = "prop_base_white_01b",
		["Width"] = 550,
		["Weight"] = 450
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:TEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterServerEvent("player:Texture")
-- AddEventHandler("player:Texture",function(Name)
-- 	local source = source
-- 	local Keyboard = vKEYBOARD.keySingle(source,"Link:")
-- 	if Keyboard and Keyboard[1] then
-- 		DuiTextures[Name]["Link"] = Keyboard[1]
-- 		--TriggerClientEvent("player:DuiUpdate",-1,Name,DuiTextures[Name])
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETREPUTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GetReputation(source)
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Query("characters/Person",{ Passport })
		if Identity[1] then
			return { Identity[1]["maisrep"],Identity[1]["menosrep"] }
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAISREPUTACAO
-----------------------------------------------------------------------------------------------------------------------------------------
local RepAmount = {
    ["Normal"] = 1,
    ["Newbie"] = 3,
    ["KillNewbie"] = 3,
}

local CashRepAmount = {
    ["Base"] = 1000,
}

RegisterServerEvent("player:MaisReputacao")
AddEventHandler("player:MaisReputacao",function(Entity,Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		local OtherPassport = vRP.Passport(Entity)
		local OtherIdentity = vRP.Identity(OtherPassport)
        local Iniciante = ""
        -- local Cash = CashRepAmount[cityName]
        if not Type then
            if Player(source)["state"]["Newbie"] then
                Type = "Newbie"
                Iniciante = " (Iniciante)"
                -- Cash = CashRepAmount[cityName] * 6
            else
                Type = "Normal"
            end
        end
		if OtherPassport then
            -- exports["painel"]:addUserPoints(OtherPassport,RepAmount[Type])
			local Consult = vRP.Query("reputacao/Check",{ Passport = Passport, other = OtherPassport })
			if Consult[1] then
				if os.time() > Consult[1]["time"] then
					vRP.Query("reputacao/Mais",{ Passport = OtherPassport, amount = RepAmount[Type] })
					vRP.Query("reputacao/Add",{ Passport = Passport, other = OtherPassport })
                    -- vRP.GiveBank(OtherPassport,Cash)
					TriggerClientEvent("Notify",source,"verde","Você deu 👍 LIKE em "..OtherIdentity["name"].." "..OtherIdentity["name2"].."!",5000)
					-- TriggerClientEvent("Notify",source,"verde","Ele ganhou R$"..Cash.." em dinheiro e pontos para trocar por itens especiais!",5000)
                    -- TriggerClientEvent("Notify2",source,"#repcheck",{msg=OtherIdentity["name"],OtherIdentity["name2"]})
					TriggerClientEvent("Notify",Entity,"verde","Você acabou de receber um 👍 LIKE de "..Identity["name"].." "..Identity["name2"]..""..Iniciante..".",5000,"REPUTAÇÃO")
                    -- TriggerClientEvent("Notify2",Entity,"#repRecived",{msg=Identity["name"],msg2=Identity["name2"],msg3=Iniciante})
                    TriggerClientEvent('sounds:Private',source,'like',0.3)
                    TriggerClientEvent('sounds:Private',Entity,'like',0.3)
				else
					TriggerClientEvent("Notify",source,"amarelo","Reputação em tempo de espera.")
                    -- TriggerClientEvent("Notify2",source,"#repEmEspera")
				end
			else
				vRP.Query("reputacao/Mais",{ Passport = OtherPassport, amount = RepAmount[Type]  })
				vRP.Query("reputacao/Add",{ Passport = Passport, other = OtherPassport })
                -- vRP.GiveBank(OtherPassport,Cash)
                TriggerClientEvent("Notify",source,"verde","Você deu 👍 LIKE em "..OtherIdentity["name"].." "..OtherIdentity["name2"]..".!",5000)
                -- TriggerClientEvent("Notify2",source,"#likeDado",{msg=OtherIdentity["name"],msg2=OtherIdentity["name2"]})
                -- TriggerClientEvent("Notify",source,"verde","Ele ganhou R$"..Cash.." em dinheiro e pontos para trocar por itens especiais!",5000)
				TriggerClientEvent("Notify",Entity,"verde","Você acabou de receber um 👍 LIKE de "..Identity["name"].." "..Identity["name2"]..""..Iniciante..".",5000,"REPUTAÇÃO")
                -- TriggerClientEvent("Notify2",Entity,"#likeRecivedFrom",{msg=Identity["name"],msg2=Identity["name2"],msg3=Iniciante})
                TriggerClientEvent('sounds:Private',source,'like',0.3)
                TriggerClientEvent('sounds:Private',Entity,'like',0.3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENOSREPUTACAO
-----------------------------------------------------------------------------------------------------------------------------------------
local KillNewbieTax = 5000
RegisterServerEvent("player:MenosReputacao")
AddEventHandler("player:MenosReputacao",function(Entity,Type)
	local source = source
	local Passport = vRP.Passport(source)
    if not Type then
        if Player(source)["state"]["Newbie"] then
            Type = "Newbie"
        else
            Type = "Normal"
        end
    end
	if Passport then
		local Identity = vRP.Identity(Passport)
		local OtherPassport = vRP.Passport(Entity)
		if OtherPassport then
            if Type == "KillNewbie" then
                vRP.PaymentFull(OtherPassport,KillNewbieTax,true)
                TriggerClientEvent("Notify",Entity,"vermelho","Você pagou uma taxa de <b>R$"..KillNewbieTax.."</b> por matar um <b>Iniciante</b>.",5000,"NOVATO")
                -- TriggerClientEvent("Notify2",Entity,"#killNewbieTax"m{msg=KillNewbieTax})
            end
			local Consult = vRP.Query("reputacao/Check",{ Passport = Passport, other = OtherPassport })
			if Consult[1] then
				if Type == "KillNewbie" or os.time() > Consult[1]["time"] then
					vRP.Query("reputacao/Menos",{ Passport = OtherPassport, amount = RepAmount[Type] })
					vRP.Query("reputacao/Add",{ Passport = Passport, other = OtherPassport })
					TriggerClientEvent("Notify",source,"verde","Reputação adicionada.",5000)
                    -- TriggerClientEvent("Notify2",source,"#repAdicionada")
					TriggerClientEvent("Notify",Entity,"vermelho","Você recebeu deslike de "..Identity["name"].." "..Identity["name2"]..".",5000)
                    -- TriggerClientEvent("Notify2",Entity,"#unlikeRecived",{msg=Identity["name"],msg2=Identity["name2"]})
                    TriggerClientEvent('sounds:source',source,'deslikeRP',0.3)
                    TriggerClientEvent('sounds:source',Entity,'deslikeRP',0.3)
				else
					TriggerClientEvent("Notify",source,"amarelo","Reputação em tempo de espera.")
                    -- TriggerClientEvent("Notify2",source,"#repEmEspera")
				end
			else
				vRP.Query("reputacao/Menos",{ Passport = OtherPassport, amount = RepAmount[Type] })
				vRP.Query("reputacao/Add",{ Passport = Passport, other = OtherPassport })
				TriggerClientEvent("Notify",source,"verde","Reputação adicionada.",5000)
                -- TriggerClientEvent("Notify2",source,"#repAdicionada")
				TriggerClientEvent("Notify",Entity,"vermelho","Você recebeu deslike de "..Identity["name"].." "..Identity["name2"]..".",5000)
                -- TriggerClientEvent("Notify2",Entity,"#unlikeRecived",{msg=Identity["name"],msg2=Identity["name2"]})
                TriggerClientEvent('sounds:source',source,'deslikeRP',0.3)
                TriggerClientEvent('sounds:source',Entity,'deslikeRP',0.3)
			end
		end
	end
end)
local CooldownME = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,Message,History)
	if Message[1] then
		local message = string.sub(History:sub(4),1,100)
        if CooldownME[source] and os.time() < CooldownME[source] then
            TriggerClientEvent("Notify",source,"negado","Aguarde <b>"..CooldownME[source] - os.time().." segundos</b> para usar novamente.")
            -- TriggerClientEvent("Notify2",source,"#me",{msg=CooldownME[source] - os.time()})
            return
        end
        CooldownME[source] = os.time() + 5
        if #message > 255 then
            TriggerClientEvent("Notify",source,"negado","Mensagem muito longa.")
            -- TriggerClientEvent("Notify2",source,"#msgLonga")
            return
        end

		local Players = vRPC.Players(source)
		for _,v in ipairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe",v,source,message,10)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- removeradv
-----------------------------------------------------------------------------------------------------------------------------------------
local RemoveADV = {
    ["Base"] = 454,
}

RegisterCommand("removeradv",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport then
        local URL = vRP.generateFastCheckout(Passport,RemoveADV[cityName])
        if URL then
            if vRP.Request(source,"Deseja abrir a loja em um link externo?") then
                TriggerClientEvent("player:OpenURL",source,URL)
            end
        end
	end
end)


local CityGroups = {
    ["Base"] = "SEU LINK AQUI",
}

RegisterCommand("grupo",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport then
        TriggerClientEvent("player:OpenURL",source,CityGroups[cityName])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			if vRP.HasGroup(Passport,"Admin",1) then
				TriggerClientEvent("emotes",ClosestPed,Message[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ej",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport and vRP.GetHealth(source) > 100 then
        if vRP.HasGroup(Passport,"Admin",1) then
            local TargetId = tonumber(Message[1])
            local Target = vRP.Source(TargetId)
            TriggerClientEvent("emotes",Target,Message[2])
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e3",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if vRP.HasGroup(Passport,"Admin",3) then
            local Range = parseInt(Message[2]) or 50
			local Players = vRPC.ClosestPeds(source,Range)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("emotes",v[2],Message[1])
				end)
			end

            TriggerClientEvent("emotes",source,Message[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Doors")
AddEventHandler("player:Doors",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicle,Network = vRPC.VehicleList(source,5)
		if Vehicle then
			local Players = vRPC.Players(source)
			for _,v in ipairs(Players) do
				async(function()
					TriggerClientEvent("player:syncDoors",v,Network,Number)
				end)
			end
		end
	end
end)

RegisterServerEvent("player:Blips")
AddEventHandler("player:Blips",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
        if vRP.HasGroup(Passport,"Admin") then
            if not AdminQRU[source] then
                AdminQRU[source] = true
                TriggerClientEvent("Notify",source,"verde","QRU ativado.",5000,"QRU")
                -- TriggerClientEvent("Notify2",source,"#qruAtivado")
            else
                AdminQRU[source] = nil
                TriggerClientEvent("Notify",source,"vermelho","QRU desativado.",5000,"QRU")
                -- TriggerClientEvent("Notify2",source,"#qruDesativado")
            end
        end      
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("qru",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
        if vRP.HasGroup(Passport,"Admin") then
            if not AdminQRU[source] then
                AdminQRU[source] = true
                TriggerClientEvent("Notify",source,"verde","QRU ativado.",5000,"QRU")
                -- TriggerClientEvent("Notify2",source,"#qruAtivado")
            else
                AdminQRU[source] = nil
                TriggerClientEvent("Notify",source,"vermelho","QRU desativado.",5000,"QRU")
                -- TriggerClientEvent("Notify2",source,"#qruDesativado")
            end
        end      
	end
end)

function tD(n)
	n = math.ceil(n * 100) / 100
	return n
end

local ShotsGrid = {}
function Creative.shotsFired(Vehicle,Grid)
	local source = source
    local Grid = tostring(Grid)
	local Passport = vRP.Passport(source)
    if ShotsGrid[Grid] and ShotsGrid[Grid] > os.time() then
        return
    end
    ShotsGrid[Grid] = os.time() + 60*1
	if Passport then
		if Vehicle then
			Vehicle = "Disparos"
		else
			Vehicle = "Disparos"
		end

		local Ped = GetPlayerPed(source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            local Coords = GetEntityCoords(Ped)
            local Service = vRP.NumPermission("Policia")
            local NewCoords = ivec3(Coords.x, Coords.y, Coords.z)
            for Passports,Sources in pairs(Service) do
                TriggerClientEvent("NotifyPushShots",Sources,NewCoords)
            end
            for Source,_ in pairs(AdminQRU) do
                TriggerClientEvent("NotifyPushShots",Source,NewCoords)
            end
        end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = {}
local CarryPermission = {
    ["Admin"] = true,
    ["Policia"] = true,
    ["Aliado"] = true,
    ["Paramedic"] = true,
}
RegisterServerEvent("player:carryPlayer")
AddEventHandler("player:carryPlayer",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        local HasGroup = false
        for Group,_ in pairs(CarryPermission) do
            if vRP.HasGroup(Passport,Group) then
                HasGroup = true
                break
            end
        end
        if HasGroup then
            if not vRP.InsideVehicle(source) then
                if playerCarry[Passport] then
                    TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
                    TriggerClientEvent("player:Commands",playerCarry[Passport],false)
                    playerCarry[Passport] = nil
                else
                    local ClosestPed = vRPC.ClosestPed(source,2)
                    if ClosestPed then
                        playerCarry[Passport] = ClosestPed

                        TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
                        TriggerClientEvent("player:Commands",playerCarry[Passport],true)
                    end
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions",function(Mode)
	local source = source
	local vehicle,Network = vRPC.VehicleList(source,10)
	if vehicle then
		TriggerClientEvent("player:syncWins",source,Network,Mode)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(Mode)
	local Distance = 1
	local source = source

	if Mode == "rv" then
		Distance = 10
	end

	local ClosestPed = vRPC.ClosestPed(source,Distance)
	if ClosestPed then
		local Passport = vRP.Passport(source)
        local Vehicle,Network,Plate,Model,Class,Speed = vRPC.VehicleList(source,5)
        if Vehicle then
            local Networked = NetworkGetEntityFromNetworkId(Network)
            local Door = GetVehicleDoorLockStatus(Networked)
            if Speed > 5.0 then
                TriggerClientEvent("Notify",source,"vermelho","O veículo está em movimento.")
                return
            end
            if parseInt(Door) <= 1 then
                if Mode == "rv" then
                    vCLIENT.removeVehicle(ClosestPed)
                elseif Mode == "cv" then
                    vCLIENT.putVehicle(ClosestPed,Network)
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Preset")
AddEventHandler("player:Preset",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Emergency") or vRP.HasGroup(Passport,"Mechanic") then
			local Model = vRP.ModelPlayer(source)

            local PlayerPresets = exports["variables"]:GetPlayerPresets()
			if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,PlayerPresets[Number][Model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrunk",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrash",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] then
			if vSKINSHOP.checkShoes(Entity) then
				vRP.GenerateItem(Passport,"WEAPON_SHOES",2,true)
				UniqueShoes[Entity] = os.time() + 300
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Outfit")
AddEventHandler("player:Outfit",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Reposed(Passport) and not exports["hud"]:Wanted(Passport) then
		if Mode == "apply" then
			local result = vRP.GetSrvData("Outfit:"..Passport)
			if result["pants"] ~= nil then
				TriggerClientEvent("skinshop:Apply",source,result)
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
                -- TriggerClientEvent("Notify2",source,"#roupaAplicada")
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
                -- TriggerClientEvent("Notify2",source,"#roupaNEncontrada")
			end
		elseif Mode == "save" then
			local custom = vSKINSHOP.Customization(source)
			if custom then
				vRP.SetSrvData("Outfit:"..Passport,custom)
				TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
                -- TriggerClientEvent("Notify2",source,"#roupaSalva")
			end
		elseif Mode == "remove" then
			local Model = vRP.ModelPlayer(source)
            local RemovePresets = exports["variables"]:GetRemovePresets()
			if Model == "mp_m_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,RemovePresets[Model])
			elseif Model == "mp_f_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,RemovePresets[Model])
			end
		else
			TriggerClientEvent("skinshop:set"..Mode,source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Death")
AddEventHandler("player:Death",function(PedSource,OtherSource,MurderWeapon)
	local Passport = vRP.Passport(PedSource)
	local OtherPassport = vRP.Passport(OtherSource)
	if Passport and OtherPassport and Passport ~= OtherPassport then
		local Identity = vRP.Identity(Passport)
		local OtherIdentity = vRP.Identity(OtherPassport)
		if Identity and OtherIdentity then
			if GetPlayerRoutingBucket(PedSource) < 900000 then
				local Ped = GetPlayerPed(PedSource)
                local OtherPed = GetPlayerPed(OtherSource)
                if DoesEntityExist(Ped) and DoesEntityExist(OtherPed) then
                    local Coords = GetEntityCoords(Ped)
                    local OtherCoords = GetEntityCoords(OtherPed)
                    Entity(Ped)["state"]["Killer"] = { Name = OtherIdentity["name"], User = OtherPassport}
                    TriggerClientEvent("Notify",PedSource,"amarelo","Você morreu para o passaporte <b>"..OtherPassport.."</b>.",60000)
                    -- TriggerClientEvent("Notify2",PedSource,"#morreuPara",{msg=OtherPassport})

                    exports["vrp"]:SendWebHook("Deaths","**Passaporte do Assassino:** "..OtherPassport.." ".. vRP.FullName(OtherPassport) .."\n**Localização do Assassino:** "..mathLength(OtherCoords["x"])..","..mathLength(OtherCoords["y"])..","..mathLength(OtherCoords["z"]).."\n**Arma Utilizada: "..MurderWeapon.."** \n\n**Passaporte da Vítima:** "..Passport.." ".. vRP.FullName(Passport) .."\n**Localização da Vítima:** "..mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"]).."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),3092790,{Passport,OtherPassport})
                end
            end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckPlayerPurchase500(Passport,AccountId)
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

function CheckPlayerPurchased(Passport,AccountId)
    local Days = 0
    local Query = vRP.Query("account_created/GetDaysPurchased",{ AccountId = AccountId })
    if Query and Query[1] then
        local Days = parseInt(Query[1]["days"])
        local Purchased = parseInt(Query[1]["purchased"])
        local Discord = Query[1]["discord"] or ""
        if Purchased >= 5000 and Purchased <= 20000 then
            vRP.SetPermission(Passport,"ClienteEspecial",1)
        elseif Purchased > 20000 then
            vRP.SetPermission(Passport,"ClienteBlack",1)
            if vRP.HasGroup(Passport, "ClienteEspecial") then
                vRP.RemovePermission(Passport,"ClienteEspecial")
            end
        end
    end
end

AddEventHandler("Connect",function(Passport,source)
    local Identity = vRP.Identity(Passport)
    if Identity and Identity["accountId"] then
        local AccountId = Identity["accountId"]
        CheckPlayerPurchase500(Passport,AccountId)
        CheckPlayerPurchased(Passport,AccountId)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if playerCarry[Passport] then
		TriggerClientEvent("player:Commands",playerCarry[Passport],false)
		playerCarry[Passport] = nil
	end

    if Active[Passport] then
        Active[Passport] = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
local FacCooldown = {}
RegisterCommand("fac",function(source)
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
        Active[Passport] = true

		if not FacCooldown[Passport] then
			FacCooldown[Passport] = os.time()
		end

		if os.time() >= FacCooldown[Passport] then
			local Group = vRP.UserGroupByType(Passport,"Job")
			local Consult = vRP.Query("painel/getallVip",{ name = Group })
			if Consult[1] and (parseInt(Consult[1]["level"]) > 0 and parseInt(Consult[1]["level"]) <= 2) then
				FacCooldown[Passport] = os.time() + 10800

				vRP.GenerateItem(Passport,"energetic",2,true)
				vRP.GenerateItem(Passport,"radio",1,true)
				vRP.GenerateItem(Passport,"bandage",2,true)
				vRP.GenerateItem(Passport,"gauze",2,true)
				vRP.GenerateItem(Passport,"vest",1,true)
				vRP.GenerateItem(Passport,"advtoolbox",1,true)
			end
		else
			local Timer = parseInt(FacCooldown[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
            -- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Timer})
		end

        Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KIT
-----------------------------------------------------------------------------------------------------------------------------------------
local kitCooldown = {}
RegisterCommand("kit",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if not kitCooldown[Passport] then
			kitCooldown[Passport] = os.time()
		end
		if os.time() >= kitCooldown[Passport] then
            local NewVIP = vRP.HasVip(Passport)
            local Allowed = false
            local AllowedVips = {
                ["Bronze"] = true,
                ["Prata"] = true,
                ["Ouro"] = true,
                ["Black"] = true,
                ["VipSorteio"] = true,
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
				kitCooldown[Passport] = os.time() + 10800
				vRP.GenerateItem(Passport,"energetic",5,true)
				vRP.GenerateItem(Passport,"radio",1,true)
				vRP.GenerateItem(Passport,"bandage",2,true)
				vRP.GenerateItem(Passport,"gauze",2,true)
				vRP.GenerateItem(Passport,"cellphone",1,true)
                return
            else
                TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
                -- TriggerClientEvent("Notify2",source,"#semPermissaoVip")
            end
		else
			local Timer = parseInt(kitCooldown[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KIT POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local pmCooldown = {}
RegisterCommand("kitpm",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if not pmCooldown[Passport] then
			pmCooldown[Passport] = os.time()
		end
		if os.time() >= pmCooldown[Passport] then
            if vRP.HasGroup(Passport,"Policia") then
                
				pmCooldown[Passport] = os.time() + 300
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",1,true)
				vRP.GenerateItem(Passport,"energetic",5,true)
				vRP.GenerateItem(Passport,"radio",1,true)
				vRP.GenerateItem(Passport,"bandage",2,true)
				vRP.GenerateItem(Passport,"gauze",2,true)
                vRP.GenerateItem(Passport,"vest",2,true)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",250,true)
                vRP.GenerateItem(Passport,"handcuff",1,true)
                vRP.GenerateItem(Passport,"WEAPON_STUNGUN",1,true)
				vRP.GenerateItem(Passport,"cellphone",1,true)
			end
		else
			local Timer = parseInt(pmCooldown[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
            -- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Timer})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KIT POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local InfluCooldown = {}
RegisterCommand("kitinflu",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if not InfluCooldown[Passport] then
			InfluCooldown[Passport] = os.time()
		end
		if os.time() >= InfluCooldown[Passport] then
            if vRP.HasGroup(Passport,"Influencer") then
                
				InfluCooldown[Passport] = os.time() + 300
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",1,true)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",1,true)
				vRP.GenerateItem(Passport,"energetic",5,true)
				vRP.GenerateItem(Passport,"radio",1,true)
				vRP.GenerateItem(Passport,"bandage",2,true)
                vRP.GenerateItem(Passport,"vest",2,true)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",250,true)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",250,true)
				vRP.GenerateItem(Passport,"cellphone",1,true)
			end
		else
			local Timer = parseInt(InfluCooldown[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
            -- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Timer})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KIT INF
-----------------------------------------------------------------------------------------------------------------------------------------
local pmCooldown = {}
RegisterCommand("kitinf",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if not pmCooldown[Passport] then
			pmCooldown[Passport] = os.time()
		end
		if os.time() >= pmCooldown[Passport] then
            if vRP.HasGroup(Passport,"InfluenciadorVerificado") then
                
				pmCooldown[Passport] = os.time() + 300
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",1,true)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",500,true)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",1,true)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",500,true)
				vRP.GenerateItem(Passport,"joint",10,true)
				vRP.GenerateItem(Passport,"cocaine",10,true)
				vRP.GenerateItem(Passport,"radio",1,true)
				vRP.GenerateItem(Passport,"cellphone",1,true)

			end
		else
			local Timer = parseInt(pmCooldown[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
            -- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Timer})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("revistar",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
        local ClosestPed = vRPC.ClosestPed(source,2)
        local ClosestPassport = vRP.Passport(ClosestPed)
        if vRP.HasGroup(ClosestPassport, "Admin", 1) then
            return
        end
        if ClosestPed then
            local Vehicle1 = GetVehiclePedIsIn(GetPlayerPed(ClosestPed),false)
            local Vehicle2 = GetVehiclePedIsIn(GetPlayerPed(source),false)
            if not Vehicle2 or Vehicle2 == 0 then
                if not Vehicle1 or Vehicle1 == 0 then
                    TriggerEvent("police:runInspect",{ClosestPed},source)
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MULTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("multar",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
        if vRP.HasGroup(Passport,"Admin",4) then
            local Keyboard = vKEYBOARD.keyTriple(source,"Passaporte:","Qual o valor da multa?","Motivo:")
            if Keyboard and Keyboard[1] then
                exports["bank"]:AddFines(parseInt(Keyboard[1]),Passport,parseInt(Keyboard[2]),Keyboard[3])
                TriggerClientEvent("Notify",source,"sucesso","Você multou em <b>$"..parseInt(Keyboard[2]).." dólares</b>.",5000,"Multa")
                exports["vrp"]:SendWebHook("multa", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Multou:** " .. Keyboard[1] .. " " .. vRP.FullName(Keyboard[1]) .. "\n**Valor:** " .. Keyboard[2] .. "\n**Motivo:** " .. Keyboard[3] .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- afk
-----------------------------------------------------------------------------------------------------------------------------------------
-- local AfkCoords = vector3(1456.36,6345.29,24.16)
-- RegisterCommand("afk",function(source)
-- 	local Passport = vRP.Passport(source)
-- 	if Passport then
--         local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
--         if Job and Job ~= "Desempregado" and Job ~= "Iniciante" then
--             local Ped = GetPlayerPed(source)
--             FreezeEntityPosition(Ped,true)
--             TriggerClientEvent("Progress",source,"Mundo",30000)
--             Wait(30000)
--             FreezeEntityPosition(Ped,false)
--             -- SetEntityCoords(Ped,AfkCoords.x,AfkCoords.y,AfkCoords.z-1)
--             TriggerClientEvent("admin:Teleport",source,AfkCoords)
--             TriggerClientEvent("Notify",source,"verde","Você foi teleportado para o farm AFK.",5000,"AFK")
--             -- TriggerClientEvent("Notify2",source,"#tpFarmAfk")
--         end
-- 	end
-- end)
-- local PoliceCoords = vector3(2507.89,-384.61,94.09)
-- RegisterCommand("dp",function(source)
-- 	local Passport = vRP.Passport(source)
-- 	if Passport then
--         local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
--         if Job and Job == "Policia" then
--             local Ped = GetPlayerPed(source)
--             FreezeEntityPosition(Ped,true)
--             TriggerClientEvent("Progress",source,"Mundo",30000)
--             Wait(30000)
--             FreezeEntityPosition(Ped,false)
--             TriggerClientEvent("admin:Teleport",source,PoliceCoords)
--             TriggerClientEvent("Notify",source,"verde","Você foi teleportado para a DP.",5000,"DP")
--         end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CL
-----------------------------------------------------------------------------------------------------------------------------------------
local CachedCL = {}
AddEventHandler("playerDropped",function(Reason)
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    local Coords = GetEntityCoords(Ped)
    if Passport and Ped and Coords then
        local NewCoords = vector3(mathLength(Coords.x),mathLength(Coords.y),mathLength(Coords.z))
        table.insert(CachedCL,{Player = Passport, Coords = NewCoords, Reason = Reason, Timer = os.time() + 300})
    end
end)

function Creative.GetProximityCL()
    local source = source
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    local Coords = GetEntityCoords(Ped)
    local ClosestCL = {}
    if Ped ~= 0 and DoesEntityExist(Ped) then
        if Passport and Ped and Coords then
            for i=1,#CachedCL do
                if CachedCL[i] then
                    if CachedCL[i]["Timer"] >= os.time() then
                        local Distance = #(Coords - CachedCL[i]["Coords"])
                        if Distance <= 100 then
                            table.insert(ClosestCL,CachedCL[i])
                        end
                    else
                        table.remove(CachedCL,i)
                    end
                end
            end
        end
    end
    return ClosestCL
end

local CooldownReport = {}
RegisterServerEvent("player:Zaralho")
AddEventHandler("player:Zaralho",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        if CooldownReport[Passport] and os.time() > CooldownReport[Passport] then
            TriggerClientEvent("Notify",source,"importante","Você reportou recentemente, aguarde <b>"..parseInt((CooldownReport[Passport] - os.time())).."</b> segundos para reportar novamente.",10000,"REPORT")
            -- TriggerClientEvent("Notify2",source,"#esperaNovoReport",{msg=parseInt((CooldownReport[Passport] - os.time()))})
            return
        end
		local Identity = vRP.Identity(Passport)
		local OtherPassport = vRP.Passport(Entity)
        if OtherPassport then
            local Service = vRP.NumPermission("Admin")
            CooldownReport[Passport] = os.time() + 30
            for Sources,_ in pairs(Service) do
                async(function()
                    TriggerClientEvent("Notify",Sources,"importante","O jogador <b>"..Passport.."</b> reportou o jogador <b>"..OtherPassport.."</b>.",10000,"REPORT")
                    -- TriggerClientEvent("Notify2",Sources,"#jogadorReportouX",{msg=Passport,msg2=OtherPassport})
                end)
            end
            TriggerClientEvent("Notify",source,"importante","Você reportou o jogador <b>"..OtherPassport.."</b>.",10000,"REPORT")
            -- TriggerClientEvent("Notify2",source,"#vcReportouX",{msg=OtherPassport})
        end
	end
end)

vRP.Prepare("characters/setCustomSpawn","UPDATE characters SET customSpawn = @CustomSpawn WHERE id = @Passport")
RegisterCommand("customspawn",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.GetHealth(source) <= 101 then
            TriggerClientEvent("Notify",source,"importante","Você não pode usar esse comando morto",10000,"SPAWN CUSTOMIZADO")
            -- TriggerClientEvent("Notify2",source,"#comandoMorto")
            return
        end
        local Allowed = false
        local AllowedVips = {
            ["Prata"] = true,
            ["Ouro"] = true,
            ["Black"] = true,
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
            local Ped = GetPlayerPed(source)
            local Coords = GetEntityCoords(Ped)
            local FormatedCoords = tD(Coords["x"])..","..tD(Coords["y"])..","..tD(Coords["z"])
            vRP.Query("characters/setCustomSpawn",{Passport = Passport, CustomSpawn = FormatedCoords})
            TriggerClientEvent("Notify",source,"verde","Você setou o spawn customizado com sucesso</b>.",10000,"SPAWN CUSTOMIZADO")
            -- TriggerClientEvent("Notify2",source,"#setCustomSpawn")
            Player(source)["state"]["CustomSpawn"] = Coords
        else
            TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",source,"#semPermissaoVip")
        end
    end
end)

vRP.Prepare("smartphone_instagram/SetFollowers","UPDATE smartphone_instagram SET followers = followers + @Amount WHERE user_id = @Passport")
RegisterCommand("SetFollowers",function(Source,Message)
    if Source == 0 then
        local Passport = parseInt(Message[1])
        local Amount = parseInt(Message[2])
        if Passport and Amount then
            vRP.Query("smartphone_instagram/SetFollowers",{Passport = Passport, Amount = Amount})
        end
    end
end)

local Groups = {}
CreateThread(function()
    Groups = vRP.Groups()
end)
local SideGroups = {
    ["Prata"] = true,
    ["Ouro"] = true,
    ["Black"] = true,
    ["VipSorteio"] = true,
}
vRP.Prepare("premium_time/SetNewVIP","INSERT INTO premium_time (passport, vip, date) VALUES (@Passport, @Group, DATE_ADD(CURRENT_TIMESTAMP(), INTERVAL @Days DAY)) ON DUPLICATE KEY UPDATE date = DATE_ADD(date, INTERVAL @Days DAY)")
vRP.Prepare("premium_time/GetPremiumTime","SELECT vip,unix_timestamp(date) as expirate, date as timestamp FROM premium_time WHERE passport = @Passport AND date >= NOW()")
vRP.Prepare("premium_time/GetPremiumExpired","SELECT id,vip,unix_timestamp(date) as expirate, date FROM premium_time WHERE passport = @Passport AND date < NOW()")
vRP.Prepare("premium_time/DeleteExpiredPremium","DELETE FROM premium_time WHERE id = @Id")

function GetExpiratedPremium(Passport)
    local Query = vRP.Query("premium_time/GetPremiumExpired",{Passport = Passport})
    if Query and Query[1] then
        local Message = ""
        for i=1,#Query do
            Message = Message.."VIP EXPIRADO <b>"..string.upper(Query[i]["vip"]).."</b> | "..os.date("%d/%m/%Y %H:%M:%S",Query[i]["expirate"]).."<br>"
            if SideGroups[Query[i]["vip"]] then
                vRP.RemovePermission(Passport,"Roupas2")
                vRP.RemovePermission(Passport,"Spotify")
            end
            vRP.RemovePermission(Passport,Query[i]["vip"])
            vRP.Query("premium_time/DeleteExpiredPremium",{Id = Query[i]["id"]})
            print("Removed "..Passport.." from "..Query[i]["vip"])
        end
        local Source = vRP.Source(Passport)
        if Source and Message ~= "" then
            TriggerClientEvent("Notify",Source,"azul",Message,60000 ,"VIP EXPIRADO")
        end
    end
end

AddEventHandler("Connect",function(Passport,Source)
    GetExpiratedPremium(Passport)
    local Query = vRP.Query("premium_time/GetPremiumTime",{Passport = Passport})
    local PremiumTime = {}
    local Message = ""
    local Selected = ""
    local Weight = 0
    for i=1,#Query do
        local Days,Hours,Minutes = GetRemainingTime(Query[i]["expirate"])
        table.insert(PremiumTime,{Vip = Query[i]["vip"], Days = Days, Hours = Hours, Minutes = Minutes})
        Message = Message.."<b>VIP: </b>"..Query[i]["vip"].." <b>Expira: </b>"..Days.." D, "..Hours.." Hr "..Minutes.." Min.<br>"
        local Group = Query[i]["vip"]
        if Groups[Group] and Groups[Group]["Weight"] ~= nil and Groups[Group]["Weight"] > Weight then
            Selected = Group
            Weight = Groups[Group]["Weight"]
        end
    end
    if Selected ~= "" then
        vRP.SetPermission(Passport,Selected,1,false,false,false,true)
        if SideGroups[Selected] then
            vRP.SetPermission(Passport,"Roupas2",1,false,false,false,true)
            vRP.SetPermission(Passport,"Spotify",1,false,false,false,true)
        end
    end
    if Message ~= "" then
        TriggerClientEvent("Notify",Source,"azul",Message,10000,"VIP")
        -- TriggerClientEvent("Notify2",Source,"#vipMessage",{msg=Message})
    end
end)

function GetRemainingTime(timestamp)
	local currentTime = os.time() 
	local remainingTime = timestamp - currentTime
	
	local remainingDays = math.floor(remainingTime / (24 * 60 * 60))
	local remainingHours = math.floor((remainingTime % (24 * 60 * 60)) / (60 * 60))
	local remainingMinutes = math.floor((remainingTime % (60 * 60)) / 60)
	
	return remainingDays, remainingHours, remainingMinutes
end

exports("GetRemainingVipTime",function(Passport)
    local Query = vRP.Query("premium_time/GetPremiumTime",{Passport = Passport})
    local PremiumTime = {}
    local Message = ""
    for i=1,#Query do
        local Days,Hours,Minutes = GetRemainingTime(Query[i]["expirate"])
        table.insert(PremiumTime,{Vip = Query[i]["vip"], Days = Days, Hours = Hours, Minutes = Minutes, TimeStamp = Query[i]["timestamp"]})
    end
    return PremiumTime
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FAKE NEWBIE RANKING
-----------------------------------------------------------------------------------------------------------------------------------------

local names = {"Claudemir","Baiano","Betin","BetinBeto","Bianca","Biel","Cassie","Cartola","Chaika","Charada","Chibau","Chico","Clara","Clarice","Dominic","Gui","Guilherme","Guizin","Isabela","Jao","Jammal","Jorge","JP","Juliana","Luiz","Mandrake","Maya","Melo","Mendy","Tulio","Tyler","Valentino","Yellow","ZePequeno","Adabaldir","Juvenal","Agatha","Bob","Calleri","LuisFabiano","Aninha","Aquiles","Teofilo","William","Frederico","Dede","Aurora","Nebulosa","Johnny Bravo", "Hera", "Thor", "Dandara", "Thanos", "Gambit", "Jax", "Brutus", "Rambo", "Hermes", "Minerva", "Eros", "Apolo", "Ajax", "Édipo", "Barbecue", "Xerife", "Sullivan", "Catatau", "Mufasa", "Pérola", "Aurora", "Mirtilo", "Luma", "Gio", "Malu", "Maggie", "Julie", "Spielberg", "Tom", "Morgan", "Russel", "Tyler"}

-- Function to shuffle players and update their score
local function shuffleAndUpdatePlayers(Name, players)
	-- Determine the new random position (1 to 3) for the player
	local player3Rank = math.random(1, 3)
	
	-- Find the index of the player whose name matches
	local player3Index = 0
	for i, player in ipairs(players) do
		if player.name == Name then
			player3Index = i
			break
		end
	end
	
	-- Swap the player to the new random position
	local temp = players[player3Rank]
	players[player3Rank] = players[player3Index]
	players[player3Index] = temp

	-- Randomly add 5-10% of the score for players above the targeted player
	for i = 1, player3Rank - 1 do
		local percentage = math.random(5, 10) / 100
		players[i].score = math.floor(players[i].score + players[i].score * percentage)
	end

    for i = player3Rank+1, #players do
		local percentage = math.random(5, 10) / 100
		players[i].score = math.floor(players[i].score - players[i].score * percentage)
	end

	-- Sort players by score
	table.sort(players, function(a, b)
		return a.score > b.score
	end)

	return players
end

function MakeNewbieRanking(Source, Name, Score)
	local Table = {}
	for i = 1, 5 do
		if i ~= 3 then
			table.insert(Table, {name = names[math.random(1, #names)], score = Score})
		else
			table.insert(Table, {name = Name, score = Score})
		end
	end
	Table = shuffleAndUpdatePlayers(Name, Table)
	TriggerClientEvent("arena:DisplayFacRank", Source, Table, "Money")
end
NewbieRanking = {}
AddEventHandler("addNewbieRanking",function(Passport)
    if GlobalState["NewbieRanking"] then
        NewbieRanking[Passport] = os.time() + 60*5
    end
end)

CreateThread(function()
    Wait(500)
    if GlobalState["NewbieRanking"] then
        while true do
            for Passport,Timer in pairs(NewbieRanking) do
                if os.time() >= Timer then
                    local Source = vRP.Source(Passport)
                    if Source then
                        local Name = vRP.FullName(Passport)
                        NewbieRanking[Passport] = os.time() + 60*90
                        PerformHttpRequest("189.127.164.202:3025/update-player",function(err,text,headers)
                            local Message = json.decode(text)["message"]
                            if Message then
                                local Score = parseInt(Message["total"])
                                MakeNewbieRanking(Source, Name, Score)
                            end
                        end,"POST",json.encode({
                            CityName = cityName,
                            PlayerId = Passport,
                        }),{ ["Content-Type"] = "application/json" })
                    end
                end
            end
            Wait(60000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/CreatedToday","SELECT COUNT(*) AS `amount` FROM `accounts` WHERE DATE(`account_create`) = CURDATE()")
vRP.Prepare("hire_history/GetHiredToday","SELECT `group`, COUNT(*) AS `amount` FROM `hire_history` WHERE `newbie` = 1 AND DATE(`date`) = CURDATE() GROUP BY `group`")
vRP.Prepare("painel/GetGroups","SELECT `name` FROM painel")
local CreatedToday = 0
local HasToHire = {}
function CheckRecruitment()
    local Players = tonumber(GetNumPlayerIndices() / 40)
    for i=1,#HasToHire do
        local Group = HasToHire[i]
        local Service,Amount = vRP.NumPermission(Group)
        if Amount < Players then
            for Passports,Sources in pairs(Service) do
                async(function()
                    if vRP.HasGroup(Passports,Group,1) then
                        TriggerClientEvent("Painel:LowRec",Sources)
                    end
                end)
            end
        else
            local Service = vRP.NumPermission(Group)
            for Passports,Sources in pairs(Service) do
                async(function()
                    TriggerClientEvent("Painel:RemLowRec",Sources)
                end)
            end
        end
    end
end

CreateThread(function()
    TriggerClientEvent("Painel:RemLowRec",-1)
    Wait(2500)
    if cityName ~= "Base" then
        local Query = vRP.Query("painel/GetGroups",{})
        for i=1,#Query do
            table.insert(HasToHire,Query[i]["name"])
        end
        if GlobalState["RecruitmentLow"] then
            while true do
                CheckRecruitment()
                Wait(60000*30)
            end
        end

    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local AdminSpectate = {}
local Groups = {}

function RemovePlayerFromGroups(Source)
    local TableRemove = {}
    for Group,Table in pairs(Groups) do
        for i=1,#Table do
            if parseInt(Groups[Group][i][2]) == parseInt(Source) then
                TableRemove[Group] = i
            end
        end
    end
    for Group,Position in pairs(TableRemove) do
        table.remove(Groups[Group],Position)
    end
    --SortAllGroups()
end

function CheckPlayerOnline(Table)
    local Passport = Table[1]
    local Source = Table[2]
    if DoesPlayerExist(Source) then
        return true
    else
        RemovePlayerFromGroups(Source)
    end
end

function SpectatePlayer(Source,pSource,Index,Group,Boolean)
    local Passport = vRP.Passport(pSource)
    if Passport then
        local Bucket = GetPlayerRoutingBucket(pSource)
        exports["vrp"]:ChangePlayerBucket(Source,Bucket)
        local Coords = vCLIENT.GetCoords(pSource)
        local Name = Passport.." | "..vRP.FullName(Passport)
        if Index and Group then
            Name = Name.." ["..Index.."/"..#Groups[Group].."]"
        end
        Wait(750)
        TriggerClientEvent("player:Spectate",Source,pSource,Name,Coords,Boolean)
        return true
    end
    return false
end
exports("SpectatePlayer",SpectatePlayer)

function Creative.Spectate(Type)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local sPassport = tostring(Passport)
        if vRP.HasGroup(Passport,"Admin") then
            if AdminSpectate[sPassport] then
                local Spectate = AdminSpectate[sPassport]
                local Group = Spectate["group"]
                local Index = Spectate["index"]
                if Type == "Next" then
                    local Count = 0
                    ::Next::
                    Count = Count+1
                    if Count >= 5 then
                        return true
                    end
                    local NewIndex = Index+1
                    if Groups[Group][NewIndex] then
                        local Next = Groups[Group][NewIndex]
                        if CheckPlayerOnline(Next) then
                            AdminSpectate[sPassport] = {group = Group,index = NewIndex}
                            if SpectatePlayer(source,Next[2],NewIndex,Group) then
                                return true
                            end
                        else
                            RemovePlayerFromGroups(Next[2])
                            Index = Index+1
                            goto Next
                        end
                    else
                        NewIndex = 1
                        local Next = Groups[Group][NewIndex]
                        if CheckPlayerOnline(Next) then
                            AdminSpectate[sPassport] = {group = Group,index = NewIndex}
                            if SpectatePlayer(source,Next[2],NewIndex,Group) then
                                return true
                            end
                        else
                            RemovePlayerFromGroups(Next[2])
                            Index = Index+1
                            goto Next
                        end
                    end
                else
                    local Count = 0
                    ::Previous::
                    Count = Count+1
                    if Count >= 5 then
                        return true
                    end
                    local NewIndex = Index-1
                    if Groups[Group][NewIndex] then
                        local Next = Groups[Group][NewIndex]
                        if CheckPlayerOnline(Next) then
                            AdminSpectate[sPassport] = {group = Group,index = NewIndex}
                            if SpectatePlayer(source,Next[2],NewIndex,Group) then
                                return true
                            end
                        else
                            RemovePlayerFromGroups(Next[2])
                            Index = Index-1
                            goto Previous
                        end
                    else
                        NewIndex = #Groups[Group]
                        local Next = Groups[Group][NewIndex]
                        if CheckPlayerOnline(Next) then
                            AdminSpectate[sPassport] = {group = Group,index = NewIndex}
                            if SpectatePlayer(source,Next[2],NewIndex,Group) then
                                return true
                            end
                        else
                            RemovePlayerFromGroups(Next[2])
                            Index = Index-1
                            goto Previous
                        end
                    end
                end
            end
        end
    end
    return false
end

RegisterServerEvent("player:ExitSpectateServer")
AddEventHandler("player:ExitSpectateServer",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local sPassport = tostring(Passport)
        if vRP.HasGroup(Passport,"Admin") then
            if AdminSpectate[sPassport] then
                AdminSpectate[sPassport] = nil
            end
            exports["vrp"]:ChangePlayerBucket(source,1)
        end
    end
end)

AddEventHandler("Connect",function(Passport,source)
    local PlayerGroups = vRP.GetUserGroups(tostring(Passport))
    for Group,_ in pairs(PlayerGroups) do
        if not Groups[Group] then
            Groups[Group] = {}
        end
        table.insert(Groups[Group],{parseInt(Passport),parseInt(source)})
    end
    SortAllGroups()
    Wait(5000)
    if not Player(source)["state"]["Creating"] then
        TriggerClientEvent("spawn:Finish",source)
    end
end)

AddEventHandler("Disconnect",function(Passport,source)
    RemovePlayerFromGroups(source)
end)

local AllowedGroupsSpectate = {
    ["Iniciante"] = true,
    ["BolsaFamilia"] = true,
}

RegisterCommand("specg",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
            if Message and Message[1] then
                local Group = Message[1]
                if Groups[Group] then
                    local Ped = GetPlayerPed(source)
                    local sPassport = tostring(Passport)
                    if DoesEntityExist(Ped) then
                        AdminSpectate[sPassport] = {group = Group, index = 1}
                        local Next = Groups[Group][1]
                        TriggerClientEvent("player:StartSpectate",source)
                        SpectatePlayer(source,Next[2],NewIndex)
                        exports["vrp"]:SendWebHook("spec2", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Deu spec no grupo:** " .. Group .. " " .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport})
                    end
                end
            end
        else
            if vRP.HasGroup(Passport,"Admin",4) then
                if Message and Message[1] then
                    local Group = Message[1]
                    if Groups[Group] and AllowedGroupsSpectate[Group] then
                        local Ped = GetPlayerPed(source)
                        local sPassport = tostring(Passport)
                        if DoesEntityExist(Ped) then
                            AdminSpectate[sPassport] = {group = Group, index = 1}
                            local Next = Groups[Group][1]
                            TriggerClientEvent("player:StartSpectate",source)
                            SpectatePlayer(source,Next[2],NewIndex)
                            exports["vrp"]:SendWebHook("spec2", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Deu spec no grupo:** " .. Group .. " " .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport})
                        end
                    end
                end
            end
        end
    end
end)

function SortAllGroups()
    for Group,_ in pairs(Groups) do
        table.sort(Groups[Group],function(a,b)
            return a[1] > b[1]
        end)
    end
end

CreateThread(function()
    local Players = vRP.Players()
    for Passport,Source in pairs(Players) do
        local PlayerGroups = vRP.GetUserGroups(tostring(Passport))
        for Group,_ in pairs(PlayerGroups) do
            if not Groups[Group] then
                Groups[Group] = {}
            end
            table.insert(Groups[Group],{parseInt(Passport),parseInt(Source)})
        end
    end
    SortAllGroups()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
RegisterCommand("spec",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil
			else
				local nsource = vRP.Source(parseInt(Message[1]))
				if nsource then
                    Spectate[Passport] = nsource
                    TriggerClientEvent("player:StartSpectate",source)
                    SpectatePlayer(source,nsource,false,false)
                    exports["vrp"]:SendWebHook("spec", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Deu spec no Passaporte:** " .. Message[1] .. " " .. vRP.FullName(Message[1]) .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport})
				end
			end
		end
	end
end)

RegisterCommand("spectate",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil
			else
				local nsource = vRP.Source(parseInt(Message[1]))
				if nsource then
                    Spectate[Passport] = nsource
                    TriggerClientEvent("player:StartSpectate",source)
                    SpectatePlayer(source,nsource,false,false,true)
                    exports["vrp"]:SendWebHook("spec", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Deu spec no Passaporte:** " .. Message[1] .. " " .. vRP.FullName(Message[1]) .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport})
				end
			end
		end
	end
end)

AddEventHandler("player:SpectatePlayer",function(source,nPlayer)
	local Passport = vRP.Passport(source)
	if Passport then
        if Spectate[Passport] then
            local Ped = GetPlayerPed(Spectate[Passport])
            TriggerClientEvent("admin:resetSpectate",source)
            Spectate[Passport] = nil
        else
            local nsource = vRP.Source(parseInt(nPlayer))
            if nsource then
                Spectate[Passport] = nsource
                TriggerClientEvent("player:StartSpectate",source)
                SpectatePlayer(source,nsource,false,false,true)
                exports["vrp"]:SendWebHook("spec", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Deu spec no Passaporte:** " .. nPlayer .. " " .. vRP.FullName(nPlayer) .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport})
            end
        end
	end
end)

RegisterServerEvent("player:ToxicVDM")
AddEventHandler("player:ToxicVDM",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Iniciante") then
            --TriggerEvent("vRP:SetToxic",parseInt(Passport),true)
        end
    end
end)

AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)

local DiamondAmount = 5
local DiamondTime = {}
local DiamondBonus = {}
local DiamondFakeBonus = {}
local FirstDiamondTime = 60*30
GlobalState["DiamondPercentage"] = 0.02

CreateThread(function()
    while true do
        for Passport,Time in pairs(DiamondTime) do
            Passport = tostring(Passport)
            local Source = vRP.Source(Passport)
            if not DiamondBonus[Passport] then
                DiamondBonus[Passport] = 0
                DiamondFakeBonus[Passport] = 0
            end
            if not Source then
                DiamondTime[Passport] = nil
                DiamondBonus[Passport] = nil
                DiamondFakeBonus[Passport] = nil
            end
            if DiamondTime[Passport] and os.time() > DiamondTime[Passport] then
                local License = vRP.Identities(Source)
                if License then
                    local bonusAmount = DiamondAmount * DiamondBonus[Passport]
                    local finalDiamondAmount = DiamondAmount + bonusAmount
                    -- print("Adding "..finalDiamondAmount.." diamonds to "..Passport)
                    vRP.Query("accounts/AddGems", { license = License, gems = finalDiamondAmount })
                    DiamondBonus[Passport] = DiamondBonus[Passport] + GlobalState["DiamondPercentage"]
                    DiamondTime[Passport] = os.time() + 60*10
                    DiamondFakeBonus[Passport] = DiamondFakeBonus[Passport] + 1
                    if Source and DoesPlayerExist(Source) then
                        local License = vRP.Identities(Source)
                        local Diamonds = vRP.UserGemstone(License) 
                        TriggerClientEvent("updateRewards",Source,{["diamond"] = { start = 60*10, multiplier = DiamondFakeBonus[Passport] }})
                        TriggerClientEvent("rewardsAnimation",Source,"diamond",finalDiamondAmount)
                    end
                end
            end
        end
        Wait(60*1000)
    end
end)

AddEventHandler("Disconnect",function(Passport)
	if DiamondTime[tostring(Passport)] then
		DiamondTime[tostring(Passport)] = nil
	end
end)

AddEventHandler("Connect",function(Passport,source)
    DiamondTime[tostring(Passport)] = os.time() + FirstDiamondTime
    TriggerClientEvent("updateRewards",source,{["diamond"] = { start = FirstDiamondTime, multiplier = DiamondBonus[Passport] or 1 }})
end)


CreateThread(function()
    local Players = GetPlayers()
    for i=1,#Players do
        local Player = Players[i]
        local Passport = tostring(vRP.Passport(parseInt(Player)))
        if Passport then
            DiamondTime[Passport] = os.time() + FirstDiamondTime
            TriggerClientEvent("updateRewards",Player,{["diamond"] = { start = FirstDiamondTime, multiplier = DiamondBonus[Passport] or 1 }})
        end
        Wait(5)
    end
    -- print("^4[Diamonds]^0 Loaded!")
end)


function GetPlayerHouses(Passport)
    local Query = vRP.Query("propertys/User",{ Passport = Passport })
    local Houses = {}
    if Query and Query[1] then
        for i=1,#Query do
            local taxExpiryTime = Query[i]["Tax"]
            local currentTime = os.time()
            local secondsRemaining = taxExpiryTime - currentTime
            local daysRemaining = math.floor(secondsRemaining / (60 * 60 * 24))
            table.insert(Houses,{
                ["address"] = Query[i]["Name"],
                ["isTaxPaid"] = taxExpiryTime <= currentTime,
                ["daysToTaxExpiry"] = daysRemaining
            })
        end
    end
    return Houses
end

AddEventHandler("Connect",function(Passport,source)
    local Houses = GetPlayerHouses(Passport)
    local Message = ""
    for i=1,#Houses do
        Message = Message.."| <b>"..Houses[i]["address"].."</b> | Pago: <b>"..(Houses[i]["isTaxPaid"] and "Sim" or "Não").."</b> | Dias: <b>"..Houses[i]["daysToTaxExpiry"].."</b> |<br>"
    end
    if Message ~= "" then
        TriggerClientEvent("Notify",source,"azul",Message,60000*1,"Taxa Casas")
    end
end)


local ConnectedDiscord = {}
local DiscordProtection = true
CreateThread(function()
    while true do
        if DiscordProtection then
            local Players = GetPlayers()
            for i=1,#Players do
                local Player = tostring(Players[i])
                if not ConnectedDiscord[Player] then
                    ConnectedDiscord[Player] = 0
                else
                    ConnectedDiscord[Player] = ConnectedDiscord[Player] + 1
                end
                if ConnectedDiscord[Player] == 8 then
                    local License = vRP.Identities(Player)
                    if License then
                        local Account = vRP.Account(License)
                        if Account and Account["discord"] then
                            if tostring(Account["discord"]) == "0" then
                                DropPlayer(Player,"Sem discord verificado")
                            end
                        end
                    else 
                        DropPlayer(Player,"Você foi desconectado.")
                    end
                end
            end
        end
        Wait(60000)
    end
end)

RegisterCommand("removediscordprotection",function(source)
    if source == 0 then
        DiscordProtection = not DiscordProtection
        if DiscordProtection then
            print("Discord Obrigatorio: ^2ATIVADO^7")
        else
            print("Discord Obrigatorio: ^1DESATIVADO^7")
        end
    end
end)

local Percent = 0.30
function Creative.GetReputation()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Keyboard = vKEYBOARD.keySingle(source,"Quantidade a ser lavada:")
        if Keyboard and Keyboard[1] then
            local Amount = parseInt(Keyboard[1])
            if Amount and Amount > 0 then
                local Consult = vRP.InventoryItemAmount(Passport,"dinheirosujo")
                if Consult[1] >= Amount then
                    local NewAmount = parseInt(Amount * Percent)
                    Amount = parseInt(Amount - NewAmount)
                    TriggerClientEvent("Progress",Source,"Mundo",60000)
                    Wait(60000)
                    vRP.GenerateItem(Passport,"dollars",parseInt(Amount),true)
                    TriggerClientEvent("Notify",source,"verde","Você lavou <b>$"..tD(Amount).."</b> e recebeu <b>$"..tD(NewAmount).."</b> de taxa.",10000,"LAVAGEM")
                end
            end
        end
    end
end
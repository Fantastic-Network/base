-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Reduces = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local Preset = {
    ["mp_m_freemode_01"] = {
        ["hat"] = { item = -1, texture = 0 },
        ["pants"] = { item = 88, texture = 2 },
        ["vest"] = { item = 0, texture = 0 },
        ["bracelet"] = { item = -1, texture = 0 },
        ["backpack"] = { item = 0, texture = 0 },
        ["decals"] = { item = -1, texture = 0 },
        ["mask"] = { item = -1, texture = 0 },
        ["shoes"] = { item = 144, texture = 0 },
        ["tshirt"] = { item = 15, texture = 0 },
        ["torso"] = { item = 73, texture = 10 },
        ["accessory"] = { item = 212, texture = 0 },
        ["watch"] = { item = -1, texture = 0 },
        ["arms"] = { item = 0, texture = 0 },
        ["glass"] = { item = 0, texture = 0 },
        ["ear"] = { item = -1, texture = 0 }
    },
    ["mp_f_freemode_01"] = {
        ["hat"] = { item = -1, texture = 0 },
        ["pants"] = { item = 91, texture = 0 },
        ["vest"] = { item = 0, texture = 0 },
        ["bracelet"] = { item = -1, texture = 0 },
        ["backpack"] = { item = 0, texture = 0 },
        ["decals"] = { item = -1, texture = 0 },
        ["mask"] = { item = -1, texture = 0 },
        ["shoes"] = { item = 141, texture = 0 },
        ["tshirt"] = { item = 10, texture = 0 },
        ["torso"] = { item = 73, texture = 0 },
        ["accessory"] = { item = 154, texture = 0 },
        ["watch"] = { item = -1, texture = 0 },
        ["arms"] = { item = 14, texture = 0 },
        ["glass"] = { item = 0, texture = 0 },
        ["ear"] = { item = -1, texture = 0 }
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:APREENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Apreender")
AddEventHandler("police:Apreender",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Policia") then
		local OtherPassport = vRP.Passport(Entity[1])

		vRP.PoliceClean(OtherPassport)

		TriggerClientEvent("Notify",source,"amarelo","Itens removidos.",5000)
		exports["vrp"]:SendWebHook("apreender", "**Passaporte:** " .. Passport .. " " ..vRP.FullName(Passport).. "\n**Apreendeu os itens do Passaporte:** " .. OtherPassport .. " " ..vRP.FullName(OtherPassport).."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport,OtherPassport})
		exports["vrp"]:SendWebHook("apreender2", "**Passaporte:** " .. Passport .. " " ..vRP.FullName(Passport).. "\n**Apreendeu os itens do Passaporte:** " .. OtherPassport .. " " ..vRP.FullName(OtherPassport).."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187,{Passport,OtherPassport})
				-- TriggerClientEvent("Notify2",source,"#removedItens")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
--local prisonClothesCD = {}
-- RegisterServerEvent("police:prisonClothes")
-- AddEventHandler("police:prisonClothes",function(entity)
	-- local source = source
	-- local Passport = vRP.Passport(source)
    -- if prisonClothesCD[source] and os.time() >= prisonClothesCD[source] then
    --     TriggerClientEvent("Notify",source,"negado","Aguarde "..parseInt(os.time() - prisonClothesCD[source]).." segundos para usar novamente.",5000,"POLICIA")
    --     return
    -- end
    -- prisonClothesCD[source] = os.time() + 60*2
	-- if Passport and vRP.GetHealth(source) > 100 then
	-- 	local mHash = vRP.ModelPlayer(entity[1])
	-- 	if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
	-- 		TriggerClientEvent("skinshop:Apply",entity[1],Preset[mHash])
	-- 	end
	-- end
--end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:REDUCES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:Reduces")
AddEventHandler("police:Reduces",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Identity = vRP.Identity(Passport)
		if parseInt(Identity["prison"]) > 0 then
			if not Reduces[Number] then
				Reduces[Number] = {}
			end

			if Reduces[Number][Passport] then
				if os.time() > Reduces[Number][Passport] then
					reduceFunction(source,Passport,Number)
				else
					TriggerClientEvent("Notify",source,"amarelo","Nada encontrado.",5000)
					-- TriggerClientEvent("Notify2",source,"#nothingFound")
				end
			else
				reduceFunction(source,Passport,Number)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEFUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function reduceFunction(source,Passport,Number)
	vRPC.playAnim(source,false,{"amb@prop_human_bum_bin@base","base"},true)
	TriggerClientEvent("Progress",source,"Vasculhando",10000)
	Reduces[Number][Passport] = os.time() + 600
	Player(source)["state"]["Buttons"] = true
	Player(source)["state"]["Cancel"] = true
	local timeProgress = 10

	repeat
		Wait(1000)
		timeProgress = timeProgress - 1
	until timeProgress <= 0

	vRP.UpdatePrison(Passport,math.random(2))
	Player(source)["state"]["Buttons"] = false
	Player(source)["state"]["Cancel"] = false
	vRPC.DestroyObjects(source)
end
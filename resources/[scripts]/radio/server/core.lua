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
Tunnel.bindInterface("radio",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESERVED
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/freeVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax,degrade) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 86000,UNIX_TIMESTAMP() + 86000,UNIX_TIMESTAMP())")
local Reserved = {
    [10] = "Admin",
    [11] = "Admin",
    [12] = "Admin",
    [13] = "Admin",
	[911] = "Policia",
	[912] = "Policia",
	[913] = "Policia",
	[914] = "Policia",
	[915] = "Policia",
	[916] = "Policia",
	[917] = "Policia",
	[918] = "Policia",
	[919] = "Policia",
	[920] = "Policia",
	[120] = "Mechanic",
	[121] = "Mechanic",
	[123] = "Mechanic",
	[112] = "Paramedic",
	[113] = "Paramedic",
	[114] = "Paramedic",
    [115] = "Bombeiros",
    [116] = "Bombeiros",
    [117] = "Bombeiros",
	[999] = "Aliado"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FACS
-----------------------------------------------------------------------------------------------------------------------------------------
local Facs = {
    [150] = "Barragem",
    [151] = "Barragem",
    [152] = "Barragem",
    [160] = "Cartel",
    [161] = "Cartel",
    [162] = "Cartel",
    [170] = "Sindicato",
    [171] = "Sindicato",
    [172] = "Sindicato",
    [180] = "Vagos",
    [181] = "Vagos",
    [182] = "Vagos",
    [200] = "Umbrella",
    [201] = "Umbrella",
    [202] = "Umbrella",
    [210] = "Azuis",
    [211] = "Azuis",
    [212] = "Azuis",
    [220] = "Vermelhos",
    [221] = "Vermelhos",
    [222] = "Vermelhos",
    [230] = "Amarelos",
    [231] = "Amarelos",
    [232] = "Amarelos",
    [240] = "Verdes",
    [241] = "Verdes",
    [242] = "Verdes",
    [250] = "Roxos",
    [251] = "Roxos",
    [252] = "Roxos",
    [260] = "Laranjas",
    [261] = "Laranjas",
    [262] = "Laranjas",
    [270] = "Brancos",
    [271] = "Brancos",
    [272] = "Brancos",
    [280] = "Marrons",
    [281] = "Marrons",
    [282] = "Marrons",
    [290] = "Cinzas",
    [291] = "Cinzas",
    [292] = "Cinzas",
    [300] = "Rosas",
    [301] = "Rosas",
    [302] = "Rosas",
    [310] = "Ballas",
    [311] = "Ballas",
    [312] = "Ballas",
    [320] = "Bellagio",
    [321] = "Bellagio",
    [322] = "Bellagio",
    -- [330] = "Vanilla",
    -- [331] = "Vanilla",
    -- [332] = "Vanilla",
    -- [340] = "Galaxy",
    -- [341] = "Galaxy",
    -- [342] = "Galaxy",
    [350] = "Bahamas",
    [351] = "Bahamas",
    [352] = "Bahamas",
    [360] = "Palazzo",
    [361] = "Palazzo",
    [362] = "Palazzo",
    [370] = "Luxor",
    [371] = "Luxor",
    [372] = "Luxor",
    [380] = "Groove",
    [381] = "Groove",
    [382] = "Groove",
    [390] = "TopGear",
    [391] = "TopGear",
    [392] = "TopGear",
    [400] = "Redline",
    [401] = "Redline",
    [402] = "Redline",
    [410] = "Bennys",
    [411] = "Bennys",
    [412] = "Bennys",
    [420] = "DriftKing",
    [421] = "DriftKing",
    [422] = "DriftKing",
    [430] = "Forza",
    [431] = "Forza",
    [432] = "Forza",
    [440] = "Overdrive",
    [441] = "Overdrive",
    [442] = "Overdrive",
    [450] = "Crips",
    [451] = "Crips",
    [452] = "Crips",
    [460] = "Outlaws",
    [461] = "Outlaws",
    [462] = "Outlaws",
    [470] = "SonsofAnarchy",
    [471] = "SonsofAnarchy",
    [472] = "SonsofAnarchy",
    [480] = "HellsAngels",
    [481] = "HellsAngels",
    [482] = "HellsAngels",
    [490] = "Triade",
    [491] = "Triade",
    [492] = "Triade",
    [500] = "Yakuza",
    [501] = "Yakuza",
    [502] = "Yakuza",
    [510] = "Warlocks",
    [511] = "Warlocks",
    [512] = "Warlocks",
    [520] = "Bloods",
    [521] = "Bloods",
    [522] = "Bloods",
    [530] = "Gringa",
    [531] = "Gringa",
    [532] = "Gringa",
    [540] = "Franca",
    [541] = "Franca",
    [542] = "Franca",
    [550] = "Italia",
    [551] = "Italia",
    [552] = "Italia",
    [560] = "Russia",
    [561] = "Russia",
    [562] = "Russia",
    [570] = "Israel",
    [571] = "Israel",
    [572] = "Israel",
    [580] = "Mexico",
    [581] = "Mexico",
    [582] = "Mexico",
    [590] = "China",
    [591] = "China",
    [592] = "China",
    [600] = "Playboy",
    [601] = "Playboy",
    [602] = "Playboy",
    [610] = "Mercenarios",
    [611] = "Mercenarios",
    [612] = "Mercenarios",
    [620] = "Sinaloa",
    [621] = "Sinaloa",
    [622] = "Sinaloa",
    [630] = "LosAztecas",
    [631] = "LosAztecas",
    [632] = "LosAztecas",
    [640] = "Tropadu7",
    [641] = "Tropadu7",
    [642] = "Tropadu7",
    [650] = "Bopegg",
    [651] = "Bopegg",
    [652] = "Bopegg",
    [660] = "AlcateiaHsT",
    [661] = "AlcateiaHsT",
    [662] = "AlcateiaHsT",
    [670] = "LaMafia",
    [671] = "LaMafia",
    [672] = "LaMafia",

    [999] = "Aliado",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Frequency(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		if Reserved[Number] then
			if vRP.HasGroup(Passport,Reserved[Number]) then
				return true
            else
                if vRP.HasGroup(Passport,"Admin") then
                    return true
                end
			end
		elseif Facs[Number] then
			if vRP.HasGroup(Passport,Facs[Number]) then
				local Consult = vRP.Query("painel/getallVip",{ name = Facs[Number] })
				if Consult[1] and parseInt(Consult[1]["level"]) <= 2 then
					return true
				end
            else
                if vRP.HasGroup(Passport,"Admin") then
                    return true
                end
			end
		else
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckRadio()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.InventoryItemAmount(Passport,"radio")
		if Consult[1] <= 0 then
			return true
		end

		return false
	end
end

-- CreateThread(function()
--     print( 'GetAllObjects ->', #GetAllObjects())
--     print( 'GetAllPeds ->', #GetAllPeds())
--     print( 'GetAllVehicles ->', #GetAllVehicles())
-- end)

Objects = {}
RegisterCommand("setprop",function(source,Message)
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",3) then
        local Keyboard = vKEYBOARD.keySingle(source,"Digite o nome do item:")
        if Keyboard and Keyboard[1] then
            local Hash = Keyboard[1]
            local application,Coords,heading = vRPC.objectCoords(source,Hash,1.0)
            if application then
                local Number = math.random(100000,999999)
                Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]) + 0.10, h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "2" }
                TriggerClientEvent("objects:Adicionar",source,tostring(Number),Objects[tostring(Number)])
            end
        end
    end
end)

local BlockModels = {
    [GetHashKey("stromberg")] = true,
    [GetHashKey("deluxo")] = true,
}

-- CreateThread(function()
--     exports["vrp"]:UpdateWebHook("entityCreating","https://discord.com/api/webhooks/11161820302322442240/icxPs3UrHWkRy6a2R9_GZyNZzejScjJmBw2TN5ay2w2sged4pb8R-DK0LbFBTTocdNg7")
-- end)

-- AddEventHandler("entityCreating", function(ent)
--     xpcall(
--         function()
--             if GetEntityType(ent) == 2 then
--                 if BlockModels[GetEntityModel(ent)] then
--                     print("Blocked entity: "..GetEntityModel(ent).." | "..ent.." | "..GetEntityScript(ent))
--                     exports["vrp"]:SendWebHook("entityCreating","Blocked entity: "..GetEntityModel(ent).." | "..ent.." \n"..GetEntityScript(ent).."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"))
--                     CancelEvent()
--                     DeleteEntity(ent)
--                 end
--             end
--         end,
--         function(err)
--             print( ('An error occurred while trying to receive and event\'! ent=%d . %s'):format(ent, err) )
--         end
--     )
-- end)

RegisterCommand("getsource2",function(source,Message)
    Wait(100)
	local Passport = vRP.Passport(source)
	if Passport then
        if Message[1] then
            if vRP.HasGroup(Passport,"Admin",1) then
                local Source = vRP.Source(parseInt(Message[1]))
                local Text = "<b>["..Source.."]</b> "..Message[1]
                TriggerClientEvent("Notify",source,"azul",Text,30000,"getsource2")
            end
        end
	end
end)
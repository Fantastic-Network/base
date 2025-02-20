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
Tunnel.bindInterface("garages",Creative)
vCLIENT = Tunnel.getInterface("garages")
vKEYBOARD = Tunnel.getInterface("keyboard")
cityName = GetConvar("cityName", "Base")
SpawnedVehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Spawn = {}
local Signal = {}
local Searched = {}
local Spawning = {}
local Plates = {}
local WithoutDamage = true
local TaxInfo = {
    ["MinBank"] = 10000000,
    ["Tax"] = 0.005,
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Garages = exports["variables"]:GetGarages()
	Vip = exports["variables"]:GetGarageVips()
	Works = exports["variables"]:GetGarageWorks()

    FreeCar = exports["variables"]:GetVariable("variables","FreeCar")
end)

local function PackVehicleCustomization(data)

	--print('PackVehicleCustomization -> data', json.encode(data, { indent = true }))

	local packed = { }

	if data['neon'] then
		local enabledNeonLightsFlag = 0

		for neonIndex, isEnabled in each(data['neon']) do
			if isEnabled then
				enabledNeonLightsFlag = enabledNeonLightsFlag | (1 << tonumber(neonIndex) )
			end
		end

		packed[eVehicleCustomizationPart.NeonLightsFlag] = enabledNeonLightsFlag
	end

	do
		packed[eVehicleCustomizationPart.XenonColor] = data['xenonColor']
	end

	if data['lights'] then
		local r = data['lights'][1]
		local g = data['lights'][2]
		local b = data['lights'][3]

		packed[eVehicleCustomizationPart.NeonLightsColor] = Rgb2Int(r, g, b)
	end

	do
		packed[eVehicleCustomizationPart.Colors] = data['colors']
	end

	do
		packed[eVehicleCustomizationPart.ExtraColors] = data['extracolors']
	end

	if data['smokecolor'] then
		local r = data['smokecolor'][1]
		local g = data['smokecolor'][2]
		local b = data['smokecolor'][3]

		packed[eVehicleCustomizationPart.TyreSmokeColor] = Rgb2Int(r, g, b)
	end

	do
		packed[eVehicleCustomizationPart.Tint] = data['tint']
	end

	do
		packed[eVehicleCustomizationPart.DashboardColour] = data['dashColour']
	end

	do
		packed[eVehicleCustomizationPart.InteriorColour] = data['interColour']
	end

	do
		packed[eVehicleCustomizationPart.WheelType] = data['wheeltype']
	end

	do
		if data['extras'] then
			local enabledExtrasFlag = 0
	
			for extraIndex, isEnabledAsInteger in each(data['extras']) do
				local isEnabled = isEnabledAsInteger == 1

				if isEnabled then
					enabledExtrasFlag = enabledExtrasFlag | (1 << extraIndex )
				end
			end
	
			packed[eVehicleCustomizationPart.ExtrasFlag] = enabledExtrasFlag
		end
	end

	do
		packed[eVehicleCustomizationPart.Livery] = data['liverys']
	end

	do
		packed[eVehicleCustomizationPart.NumberPlateTextIndex] = data['plateIndex']
	end

	do
		packed[eVehicleCustomizationPart.Mods] = data['mods']
	end

	if data['var'] then
		packed[eVehicleCustomizationPart.ModWheelsVariation	   ] = data['var'][23]
		packed[eVehicleCustomizationPart.ModRearWheelsVariation] = data['var'][24]
	end

	return packed
end

---@param to To
function SendUnmoddedVehicleToClient(to, Model, Network, Engine, Health, Customize, Windows, Tyres, Degrade, Owner)

	-- print('SendUnmoddedVehicleTo_Client -> source', source)
	-- print('SendUnmoddedVehicleTo_Client -> Model', Model)
	-- print('SendUnmoddedVehicleTo_Client -> Network', Network)
	-- print('SendUnmoddedVehicleTo_Client -> Engine', Engine)
	-- print('SendUnmoddedVehicleTo_Client -> Health', Health)
	-- print('SendUnmoddedVehicleTo_Client -> Customize', json.encode(Customize, { indent = true }))
	-- print('SendUnmoddedVehicleTo_Client -> Windows', json.encode(Windows, { indent = true }))
	-- print('SendUnmoddedVehicleTo_Client -> Tyres', json.encode(Tyres, { indent = true }))
	-- print('SendUnmoddedVehicleTo_Client -> Degrade', Degrade)
	-- print('SendUnmoddedVehicleTo_Client -> Owner', Owner)

	local brokenWindowsFlag = 0

    for doorIndex, isBroken in each( json.decode(Windows or '{}') or { } ) do
        if isBroken then
            brokenWindowsFlag = brokenWindowsFlag | (1 << tonumber(doorIndex) )
        end
    end

	local burstTyresFlag = 0


    for tyreIndex, isBurst in each( json.decode(Tyres or '{}') or { }  ) do
        if isBurst then
            burstTyresFlag = burstTyresFlag | (1 << tonumber(tyreIndex) )
        end
    end

	local packedCustomization = PackVehicleCustomization( json.decode(Customize or '{}') or { } )

	--print('packedCustomization', json.encode(packedCustomization, { indent = true }))

	Send( to , 'garage:createVehicle', Network, Engine, Health, packedCustomization, brokenWindowsFlag, burstTyresFlag, Degrade, Owner, Model )
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("CreateVehicle",function(source,VehicleName)
    local Passport = vRP.Passport(source)
    local Ped = GetPlayerPed(source)
    if Ped ~= 0 and DoesEntityExist(Ped) then
        local Coords = GetEntityCoords(Ped)
        local Heading = GetEntityHeading(Ped)
        local Plate = "VEH"..(10000 + Passport)
        local Exist,Network,Vehicle = Creative.ServerVehicle(Passport,VehicleName,Coords["x"],Coords["y"],Coords["z"],Heading,Plate,nil,1000)

        if not Exist then
            return Exist
        end

		--[[ Inclui 'source' ]]
		local Players = vRPC.Players(source)

		SendUnmoddedVehicleToClient( To.Multiple( Players ), VehicleName,Network,1000,1000,nil,false,false, source)

        Spawn[Plate] = { Passport,VehicleName,Network }
        TriggerEvent("engine:tryFuel",Plate,100)
        Plates[Plate] = Passport

        return Exist,Network,Vehicle
    end
end)

local VEHICLE_AWAIT_CREATION_TIMEOUT_SECS = 10

function Creative.ServerVehicle(Passport,Model,x,y,z,Heading,Plate,Doors,Body,Fuel)
    --local Type = VehicleType(Model)
    local Vehicle = CreateVehicle(Model,x,y,z,Heading,true,true)
    -- if Type then
    --     Vehicle = CreateVehicleServerSetter(GetHashKey(Model),Type, x,y,z,Heading)
    -- else
        --Vehicle = CreateVehicle(Model,x,y,z,Heading,true,true)
    -- end
    local source = vRP.Source(Passport)
    local Bucket = GetPlayerRoutingBucket(source)

    Spawning[Passport] = true

	local createdAt = GetGameTimer()
	local timeoutAt = (createdAt + (VEHICLE_AWAIT_CREATION_TIMEOUT_SECS * 1000))
    SpawnedVehicles[Vehicle] = true
	while ( not DoesEntityExist(Vehicle) ) and ( GetGameTimer() < timeoutAt ) do
		Wait(100)
	end

    Spawning[Passport] = false
	if DoesEntityExist(Vehicle) then
        SetEntityRoutingBucket(Vehicle,Bucket)
        Entity(Vehicle)["state"]["Spawned"] = true
		if Plate ~= nil then
			SetVehicleNumberPlateText(Vehicle,Plate)
		else
			Plate = vRP.GeneratePlate()
			SetVehicleNumberPlateText(Vehicle,Plate)
		end

        vRP.SetPlate(Plate,Passport)
		SetVehicleBodyHealth(Vehicle,Body + 0.0)

		if not Fuel then
			TriggerEvent("engine:tryFuel",Plate,100)
		end

		if Doors then
			local Doors = json.decode(Doors)
			if Doors ~= nil then
				for Number,Status in pairs(Doors) do
					if Status then
						SetVehicleDoorBroken(Vehicle,parseInt(Number),true)
					end
				end
			end
		end

		local Network = NetworkGetNetworkIdFromEntity(Vehicle)

		if Model ~= "wheelchair" then
			local Network = NetworkGetEntityFromNetworkId(Network)
			SetVehicleDoorsLocked(Network,2)
		end
    
        Spawning[Passport] = false
		return true,Network,Vehicle
	end
    Spawning[Passport] = false
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEGRADE
-----------------------------------------------------------------------------------------------------------------------------------------
function Degrade(Vehicle)
	local Percentage = 0

	if os.time() >= (Vehicle + 86400 * 60) then
		Percentage = 20
	elseif os.time() >= (Vehicle + 86400 * 45) then
		Percentage = 15
	elseif os.time() >= (Vehicle + 86400 * 30) then
		Percentage = 10
	elseif os.time() >= (Vehicle + 86400 * 15) then
		Percentage = 5
	end

	return Percentage
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("signalRemove",function(Plate)
	if not Signal[Plate] then
		Signal[Plate] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateReveryone",function(Plate)
	if Plates[Plate] then
		Plates[Plate] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateEveryone",function(Plate)
	Plates[Plate] = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("platePlayers",function(Plate,Passport)
	if not vRP.PassportPlate(Plate) then
		Plates[Plate] = Passport
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Vehicles(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Wanted(Passport) then
		if Garages[Number]["Info"]["Perm"] then
			if not vRP.HasGroup(Passport,Garages[Number]["Info"]["Perm"]) then
                TriggerClientEvent("Notify",source,"negado","Você não tem permissão para acessar esta garagem.",5000,"Garagem")
				-- TriggerClientEvent("Notify2",source,"#permisGaragem")
				return false
			end
		end
        
		if Garages[Number]["Info"]["Level"] then
			if not vRP.HasPermission(Passport,Garages[Number]["Info"]["Perm"],Garages[Number]["Info"]["Level"]) then
                TriggerClientEvent("Notify",source,"negado","Você não tem permissão para acessar esta garagem.",5000,"Garagem")
				-- TriggerClientEvent("Notify2",source,"#permisGaragem")
				return false
			end
		end

		if Garages[Number]["Info"]["House"] then
            local Name = Garages[Number]["Info"]["House"]
			local Consult = vRP.Query("propertys/Exist",{ name = Name })
			if Consult[1] then
                local Owner = Consult[1]["Passport"]
                local Tax = Consult[1]["Tax"]
                local Serial = Consult[1]["Serial"]
				if Owner == Passport or vRP.InventoryFull(Passport,"propertys-"..Serial) then
					if os.time() > Tax then
                        if source and source ~= 0 then
                            TriggerClientEvent("Notify",source,"amarelo","Aluguel atrasado, procure um <b>Corretor de Imóveis</b>.",5000,"Garagem")
							-- TriggerClientEvent("Notify2",source,"#aluguelAtrasado")
                        end
						return false
					end
				else
					return false
				end
			end
		end

		local Vehicle = {}
		local Garage = Garages[Number]["Info"]["Name"]
		if Works[Garage] then
			for _,v in pairs(Works[Garage]) do
				if VehicleExist(v) then
					local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = v })
					if Consult[1] then
                        if WithoutDamage then
                            table.insert(Vehicle,{
                                ["name"] = VehicleName(v),
                                ["model"] = v,
                                ["plate"] = Consult[1]["plate"],
                                ["chassi"] = 1000,
                                ["engine"] = 1000,
                                ["body"] = 1000,
                                ["gas"] = 100,
                                ["type"] = VehicleMode(v),
                                ["chest"] = vRP.GetVehicleChest(Passport,v),
                                ["tax"] = VehiclePrice(v) * 0.20
                            })
                        else
                            table.insert(Vehicle,{
                                ["name"] = VehicleName(v),
                                ["model"] = v,
                                ["plate"] = Consult[1]["plate"],
                                ["chassi"] = Consult[1]["health"],
                                ["engine"] = Consult[1]["engine"],
                                ["body"] = Consult[1]["body"],
                                ["gas"] = Consult[1]["fuel"],
                                ["type"] = VehicleMode(v),
                                ["chest"] = vRP.GetVehicleChest(Passport,v),
                                ["tax"] = VehiclePrice(v) * 0.20
                            })
                        end
					else
						table.insert(Vehicle,{ ["model"] = v, ["name"] = VehicleName(v) })
					end
				end
			end
		elseif Garage == "vip" then
			local Perm = vRP.HasPermission(Passport,Garages[Number]["Info"]["Perm"])
			local Consult = vRP.Query("painel/getallVip",{ name = Garages[Number]["Info"]["Perm"] })
			if Consult[1] and parseInt(Consult[1]["level"]) > 0 and Perm then
				local Number = parseInt(Consult[1]["level"])
				if Vip[Number] and Vip[Number][Perm] then
					for _,v in pairs(Vip[Number][Perm]) do
						if VehicleExist(v) then
							local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = v })
							if Consult[1] then
                                if WithoutDamage then
                                    table.insert(Vehicle,{
                                        ["name"] = VehicleName(v),
                                        ["model"] = v,
                                        ["plate"] = Consult[1]["plate"],
                                        ["chassi"] = 1000,
                                        ["engine"] = 1000,
                                        ["body"] = 1000,
                                        ["gas"] = 100,
                                        ["type"] = VehicleMode(v),
                                        ["chest"] = vRP.GetVehicleChest(Passport,v),
                                        ["tax"] = VehiclePrice(v) * 0.20
                                    })
                                else
                                    table.insert(Vehicle,{
                                        ["name"] = VehicleName(v),
                                        ["model"] = v,
                                        ["plate"] = Consult[1]["plate"],
                                        ["chassi"] = Consult[1]["health"],
                                        ["engine"] = Consult[1]["engine"],
                                        ["body"] = Consult[1]["body"],
                                        ["gas"] = Consult[1]["fuel"],
                                        ["type"] = VehicleMode(v),
                                        ["chest"] = vRP.GetVehicleChest(Passport,v),
                                        ["tax"] = VehiclePrice(v) * 0.20
                                    })
                                end
							else
								table.insert(Vehicle,{ ["model"] = v, ["name"] = VehicleName(v) })
							end
						end
					end
				else
					return false
				end
			end
		else
			local Consult = vRP.Query("vehicles/UserVehicles",{ Passport = Passport })
            local Count = 0
            if Consult and Consult[1] then
                for _,v in pairs(Consult) do
                    if VehicleExist(v["vehicle"]) then
                        if v["work"] == "false" then
                            Count = Count + 1
                            if v["expires"] and os.time() > v["expires"] then
                                TriggerClientEvent("Notify",source,"amarelo","Veículo <b>"..VehicleName(v["vehicle"]).."</b> vencido.",5000,"Garagem")
								-- TriggerClientEvent("Notify2",source,"#veiculoVencido",{msg=VehicleName(v["vehicle"])})
                                vRP.Query("vehicles/removeVehicles",{ Passport = Passport, vehicle = v["vehicle"] })
                            else
                                if WithoutDamage then
                                    table.insert(Vehicle,{
                                        ["name"] = VehicleName(v["vehicle"]),
                                        ["model"] = v["vehicle"],
                                        ["plate"] = v["plate"],
                                        ["chassi"] = 1000,
                                        ["engine"] = 1000,
                                        ["body"] = 1000,
                                        ["gas"] = 100,
                                        ["type"] = VehicleMode(v["vehicle"]),
                                        ["chest"] = vRP.GetVehicleChest(Passport,v),
                                        ["tax"] = VehiclePrice(v["vehicle"]) * 0.20
                                    })
                                else
                                    table.insert(Vehicle,{
                                        ["name"] = VehicleName(v["vehicle"]),
                                        ["model"] = v["vehicle"],
                                        ["plate"] = v["plate"],
                                        ["chassi"] = v["health"],
                                        ["engine"] = v["engine"],
                                        ["body"] = v["body"],
                                        ["gas"] = v["fuel"],
                                        ["type"] = VehicleMode(v["vehicle"]),
                                        ["chest"] = vRP.GetVehicleChest(Passport,v),
                                        ["tax"] = VehiclePrice(v["vehicle"]) * 0.20
                                    })
                                end
                            end
                        end
                    end
                end
                if Count == 0 then
                    table.insert(Vehicle,{
                        ["name"] = VehicleName(FreeCar),
                        ["model"] = FreeCar,
                        ["plate"] = vRP.GeneratePlate(),
                        ["chassi"] = 1000,
                        ["engine"] = 1000,
                        ["body"] = 1000,
                        ["gas"] = 100,
                        ["type"] = VehicleMode(FreeCar),
                        ["chest"] = vRP.GetVehicleChest(Passport,FreeCar),
                        ["tax"] = VehiclePrice(FreeCar) * 0.20
                    })
                end
            else
                table.insert(Vehicle,{
                    ["name"] = VehicleName(FreeCar),
                    ["model"] = FreeCar,
                    ["plate"] = vRP.GeneratePlate(),
                    ["chassi"] = 1000,
                    ["engine"] = 1000,
                    ["body"] = 1000,
                    ["gas"] = 100,
                    ["type"] = VehicleMode(FreeCar),
                    ["chest"] = vRP.GetVehicleChest(Passport,FreeCar),
                    ["tax"] = VehiclePrice(FreeCar) * 0.20
                })
            end
		end

		return Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vehicles/UserVehiclesImpound","SELECT id,vehicle FROM vehicles WHERE Passport = @Passport")
function Creative.Impound()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicles = {}
		local Vehicle = vRP.Query("vehicles/UserVehiclesImpound",{ Passport = Passport })

		for Number,_ in ipairs(Vehicle) do
			if v["arrest"] >= os.time() then
				table.insert(Vehicles,{ ["Model"] = Vehicle[Number]["vehicle"], ["name"] = VehicleName(Vehicle[Number]["vehicle"]) })
			end
		end

		return Vehicles
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
local DefaultTax = 0.25
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound",function(vehName,source)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local VehiclePrice = VehiclePrice(vehName)
        if source and source ~= 0 then
            TriggerClientEvent("dynamic:closeSystem",source)
        end
        local Reputation = vRP.Query("characters/Person",{ Passport })
        local SumReputation = 0

        if Reputation[1] then
            SumReputation = Reputation[1]["maisrep"] - Reputation[1]["menosrep"]
        end

        if SumReputation < 0 then
            if source and source ~= 0 then
                TriggerClientEvent("Notify",source,"vermelho","Sua reputação está <b>negativa</b>: "..SumReputation..".<br>Você irá pagar 20% a mais para a liberação.",5000,"REPUTACAO")
				-- TriggerClientEvent("Notify2",source,"#repNegativa",{msg+SumReputation})
            end
            DefaultTax = 0.22
        end
        if source and source ~= 0 then
            if vRP.Request(source,"A liberação do veículo tem o custo de <b>$"..parseFormat(VehiclePrice * DefaultTax).."</b> dólares, deseja prosseguir com a liberação do mesmo?","Sim, efetuar o pagamento","Não, decido depois") then
                TriggerClientEvent("Notify",source,"verde","Você sabia que sendo VIP voce não paga taxas de desmanche ? Adquira já em nossa loja.",5000,"Garagem")
				-- TriggerClientEvent("Notify2",source,"#suggDesmanche")
                if vRP.PaymentFull(Passport,VehiclePrice * DefaultTax) then
                    vRP.Query("vehicles/paymentArrest",{ Passport = Passport, vehicle = vehName })
                    TriggerClientEvent("Notify",source,"verde","Veículo liberado.",5000,"Garagem")
					-- TriggerClientEvent("Notify2",source,"#veiculoLiberado")
                else
                    TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000,"Garagem")
					-- TriggerClientEvent("Notify2",source,"#semdoletas")
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:TAX
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Tax(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if Consult[1] and Consult[1]["tax"] <= os.time() then
			local Price = VehiclePrice(Name) * 0.20
            local _,Level,_,_ = vRP.UserGroupByType(Passport,"Premium")

            if Level == 1 then
                vRP.Query("vehicles/updateVehiclesTax",{ Passport = Passport, vehicle = Name })
                if source and source ~= 0 then
                    TriggerClientEvent("Notify",source,"verde","Pagamento concluído.",5000,"Garagem")
					-- TriggerClientEvent("Notify2",source,"#pagamentoConcluido")
                end
                return
            end

            local Allowed = false
            local AllowedVips = {
                ["Black"] = true,
                ["Ouro"] = true,
                ["VipSorteio"] = true,
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
                vRP.Query("vehicles/updateVehiclesTax",{ Passport = Passport, vehicle = Name })
                if source and source ~= 0 then
                    TriggerClientEvent("Notify",source,"verde","Taxas renovadas(VIP) com sucesso.",5000,"Garagem")
					-- TriggerClientEvent("Notify2",source,"#taxaRenovada")
                end
                return
            end

			if vRP.PaymentFull(Passport,Price) then
				vRP.Query("vehicles/updateVehiclesTax",{ Passport = Passport, vehicle = Name })
                if source and source ~= 0 then
                    TriggerClientEvent("Notify",source,"verde","Pagamento concluído.",5000,"Garagem")
					-- TriggerClientEvent("Notify2",source,"#pagamentoConcluido")
                end
			else
                if source and source ~= 0 then
				    TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000,"Garagem")
					-- TriggerClientEvent("Notify2",source,"#semdoletas")
                end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Sell(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Mode = VehicleMode(Name)
		if Mode == nil or Mode == "rental" or Mode == "work" then
			return
		end

		local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if Consult[1] then
			local Price = VehiclePrice(Name) * 0.5
			if vRP.Request(source,"Vender o veículo <b>"..VehicleName(Name).."</b> por <b>$"..parseFormat(Price).."</b>?","Sim, concluír venda","Não, mudei de ideia") then
				local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
				if Consult[1] then
					vRP.GiveBank(Passport,Price,"Sell Vehicle")
					vRP.Query("vehicles/removeVehicles",{ Passport = Passport, vehicle = Name })
					vRP.Query("entitydata/RemoveData",{ dkey = "Mods:"..Passport..":"..Name })
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Transfer(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Mode = VehicleMode(Name)
		if Mode == nil or Mode == "rental" or Mode == "work" then
			return
		end

		local myVehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if myVehicle[1] then
            if source and source ~= 0 then
                TriggerClientEvent("dynamic:closeSystem",source)
            end

			local Keyboard = vKEYBOARD.keySingle(source,"Passaporte:")
			if Keyboard and Keyboard[1] then
				local OtherPassport = parseInt(Keyboard[1])
				local Identity = vRP.Identity(OtherPassport)
				if Identity then
					if vRP.Request(source,"Transferir o veículo <b>"..VehicleName(Name).."</b> para <b>"..Identity["name"].." "..Identity["name2"].."</b>?","Sim, transferir","Não, mudei de ideia") then
						local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = parseInt(OtherPassport), vehicle = Name })
						if Vehicle[1] then
                            if source and source ~= 0 then
                                TriggerClientEvent("Notify",source,"amarelo","<b>"..Identity["name"].." "..Identity["name2"].."</b> já possui este modelo de veículo.",5000,"Garagem")
								-- TriggerClientEvent("Notify2",source,"#jaPossuiVeiculo",{msg=Identity["name"],msg2=Identity["name2"]})
                            end
						else
							vRP.Query("vehicles/moveVehicles",{ Passport = Passport, OtherPassport = parseInt(OtherPassport), vehicle = Name })

							local Datatable = vRP.Query("entitydata/GetData",{ dkey = "Mods:"..Passport..":"..Name })
							if parseInt(#Datatable) > 0 then
								vRP.Query("entitydata/SetData",{ dkey = "Mods:"..OtherPassport..":"..Name, dvalue = Datatable[1]["dvalue"] })
								vRP.Query("entitydata/RemoveData",{ dkey = "Mods:"..Passport..":"..Name })
							end

							local Datatable = vRP.GetSrvData("Chest:"..Passport..":"..Name)
							vRP.SetSrvData("Chest:"..OtherPassport..":"..Name,Datatable)
							vRP.RemSrvData("Chest:"..Passport..":"..Name)

                            if source and source ~= 0 then
							    TriggerClientEvent("Notify",source,"verde","Transferência concluída.",5000,"Garagem")
								-- TriggerClientEvent("Notify2",source,"transfConcluida")
                            end
						end
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
local VIPBooster = {
    ["Bronze"] = 0.04,
    ["Prata"] = 0.06,
    ["Ouro"] = 0.08,
    ["Black"] = 0.12,
}

local VipPercentage = {
    ["Bronze"] = 10,
    ["Prata"] = 20,
    ["Ouro"] = 30,
    ["Black"] = 50,
}

function Creative.HasVipBooster()
    local Source = source
    local Passport = vRP.Passport(Source)
    local NewVips = vRP.HasVip(Passport)
    local Boost = 0
    local Selected = false
    if NewVips then
        for Group,_ in pairs(NewVips) do
            if VIPBooster[Group] then
                if VIPBooster[Group] > Boost then
                    Boost = VIPBooster[Group]
                    Selected = Group
                end
            end
        end
    end
    if Boost > 0 and Selected then
        if Source and Source ~= 0 then
            TriggerClientEvent("Notify",Source,"azul","Veiculo modificado em "..VipPercentage[Selected].."% a mais de velocidade, aproveite a nova maquina.",5000,"Garagem")
			-- TriggerClientEvent("Notify2",Source,"#veiculoModificado",{msg=VipPercentage[Selected]})
        end
    else
        if Source and Source ~= 0 then
            TriggerClientEvent("Notify",Source,"azul","Você não possui VIP? Você sabia que com VIP seu carro ganha até 50% a mais de velocidade? adquira já em nossa loja.",5000,"Garagem")
			-- TriggerClientEvent("Notify2",Source,"#suggCarroVelo")
        end
    end
    return Boost
end
local withoutTax = {
    ["Kakuma"] = true,
    ["Kbati"] = true,
    ["Kcarbonrs"] = true,
}

function Creative.Spawn(Name,Number)
	local source = source
	local Passport = vRP.Passport(source)
    local Police = false
    if Garages[Number]["Info"]["Perm"] and Garages[Number]["Info"]["Perm"] == "Policia" then
        Police = true
    end

	TriggerClientEvent("garages:Close",source)

    if not vRP.HasGroup(Passport, "Admin", 1) then
        local Fines = exports["bank"]:Fines(Passport)
        if Fines and Fines[1] then
            local Total = 0
            for i=1,#Fines do
                Total = Total + Fines[i]["value"]
            end
            if source and source ~= 0 then
                TriggerClientEvent("Notify",source,"negado","Você possui <b>R$"..Total.."</b> em multas para pagar, quite todas as suas dividas para conseguir retirar o veiculo.",5000,"Garagem")
				-- TriggerClientEvent("Notify2",source,"#warningMulta",{msg=Total})
            end
            return
        end
    end

	if Passport then
		local Gemstone = VehicleGems(Name)
		local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
        if Name == FreeCar then
            vehicle = json.decode('[{"engine":1000,"tyres":"","Passport":1047,"plate":"08PZE643","fuel":100,"tax":9991089383,"nitro":0,"work":"false","chest":"{}","rental":0,"id":118,"health":1000,"expires":0,"doors":"","windows":"","vehicle":"'..FreeCar..'","arrest":0,"body":1000,"degrade":1690484583}]')
        end
		if not vehicle[1] then
			if parseInt(Gemstone) > 0 then
				if vRP.Request(source,"Alugar o veículo <b>"..VehicleName(Name).."</b> por <b>"..Gemstone.."</b> Diamantes?","Sim, concluír aluguel","Não, mudei de ideia") then
					if vRP.PaymentGems(Passport,Gemstone) then
						vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
                        if source and source ~= 0 then
                            TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.",5000,"Garagem")
							-- TriggerClientEvent("Notify2",source,"#aluguelConcluido",{msg=VehicleName(Name)})
                        end
						vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
					else
                        if source and source ~= 0 then
                            TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.",5000,"Garagem")
							-- TriggerClientEvent("Notify2",source,"#semdoletas")
                        end
						return
					end
				else
					return
				end
			else
                if withoutTax[Name] then
					vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
					vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
                else
                    local VehiclePrice = VehiclePrice(Name)
                    if parseInt(VehiclePrice) > 0 then
                        if vRP.Request(source,"Comprar <b>"..VehicleName(Name).."</b> por <b>$"..parseFormat(VehiclePrice).."</b> dólares?","Sim, concluír pagamento","Não, mudei de ideia") then
                            if vRP.PaymentFull(Passport,VehiclePrice) then
                                vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
                                vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
                            else
                                if source and source ~= 0 then
                                    TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000,"Garagem")
									-- TriggerClientEvent("Notify2",source,"#semdoletas")
                                end
                            end
                        else
                            return
                        end
                    else
    					vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
					    vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
                    end
                end
			end
		end

		if vehicle[1] then
			local Plate = vehicle[1]["plate"]
            local MultiSpawnList = exports['variables']:GetVariable('variables','MultiSpawnList') or {}
			if GlobalState["BlockMultiSpawn"] and not MultiSpawnList[Name] and Spawn[Plate] then
				if not Signal[Plate] then
					if not Searched[Passport] then
						Searched[Passport] = os.time()
					end

					if os.time() >= parseInt(Searched[Passport]) then
						Searched[Passport] = os.time() + 60

						local Network = Spawn[Plate][3]
						local Network = NetworkGetEntityFromNetworkId(Network)
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							vCLIENT.SearchBlip(source,GetEntityCoords(Network))
							TriggerClientEvent("Notify",source,"amarelo","Rastreador do veículo foi ativado por <b>30</b> segundos, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.",10000)
							-- TriggerClientEvent("Notify2",source,"#rastreadorAtivado")
                            -- TriggerClientEvent("garages:Close",source)
						else
							if Spawn[Plate] then
								Spawn[Plate] = nil
							end

							if Plates[Plate] then
								Plates[Plate] = nil
							end

							TriggerClientEvent("Notify",source,"verde","A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.",5000,"Garagem")
							-- TriggerClientEvent("Notify2",source,"#resgateVeiculo")
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","Rastreador só pode ser ativado a cada <b>60</b> segundos.",5000,"Garagem")
						-- TriggerClientEvent("Notify2",source,"#esperaRastrear")
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Rastreador está desativado.",5000,"Garagem")
					-- TriggerClientEvent("Notify2",source,"#rastreadorDesativado")
				end
			else
				if vehicle[1]["tax"] <= os.time() then
                    local VIPs = vRP.GetGroup(Passport,"VIP")
                    if VIPs and VIPs["Blacks"] then
                        vRP.Query("vehicles/updateVehiclesTax",{ Passport = Passport, vehicle = Name })
                        TriggerClientEvent("Notify",source,"verde","Taxa do veículo paga automaticamente retire o veiculo da garagem novamente.",7500,"Garagem")
						-- TriggerClientEvent("Notify2",source,"#taxaAutomatica")
                        -- TriggerClientEvent("garages:Close",source)
                    else
                        TriggerClientEvent("Notify",source,"amarelo","Taxa do veículo atrasada.",7500,"Garagem")
						-- TriggerClientEvent("Notify2",source,"#taxaAtrasada")
                    end
                    -- TriggerClientEvent("garages:Close",source)
                    local NewVIP = vRP.HasVip(Passport)
                    if NewVIP and NewVIP["Black"] then
                        vRP.Query("vehicles/updateVehiclesTax",{ Passport = Passport, vehicle = Name })
                        TriggerClientEvent("Notify",source,"verde","Taxa do veículo paga automaticamente retire o veiculo da garagem novamente.",7500,"Garagem")
						-- TriggerClientEvent("Notify2",source,"#taxaAutomatica")
                        -- TriggerClientEvent("garages:Close",source)
                        return
                    end
				elseif vehicle[1]["arrest"] ~= 0 then
                    TriggerEvent("garages:Impound",Name,source)
				else
					if vehicle[1]["rental"] ~= 0 and vehicle[1]["rental"] <= os.time() then
					-- 	if Gemstone > 0 then
					-- 		if vRP.Request(source,"Atualizar o aluguel do veículo <b>"..VehicleName(Name).."</b> por <b>"..Gemstone.." diamantes</b>?","Sim, concluír pagamento","Não, mudei de ideia") then
					-- 			if vRP.PaymentGems(Passport,Gemstone) then
									--vRP.Query("vehicles/rentalVehiclesUpdate",{ Passport = Passport, vehicle = Name })
						-- 			TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(Name).."</b> atualizado.",5000,"Garagem")
						-- 		else
						-- 			TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.",5000,"Garagem")
						-- 			return
						-- 		end
						-- 	else
						-- 		return
						-- 	end
						-- else
							--vRP.Query("vehicles/rentalVehiclesUpdate",{ Passport = Passport, vehicle = Name })
						-- end
					end

					local Coords = vCLIENT.SpawnPosition(source,Number)
					if Coords then
						local Mods = nil
						local Datatable = vRP.Query("entitydata/GetData",{ dkey = "Mods:"..Passport..":"..Name })
						if parseInt(#Datatable) > 0 then
							Mods = Datatable[1]["dvalue"]
                        elseif Name == "elegy" then
                            Mods = '{"var":{"23":false,"24":false},"extracolors":[61,158],"dashColour":63,"neon":{"1":false,"2":false,"3":false,"0":false},"wheeltype":0,"interColour":134,"platestyle":1,"liverys":-1,"colors":[12,147],"plateIndex":1,"tint":1,"lights":[255,0,255],"mods":{"1":5,"2":2,"3":3,"4":6,"5":2,"6":0,"7":5,"8":2,"9":-1,"10":-1,"11":3,"12":2,"13":2,"14":-1,"15":3,"16":-1,"17":false,"18":1,"19":false,"20":false,"21":false,"22":false,"23":54,"24":-1,"25":1,"26":-1,"27":-1,"28":-1,"29":2,"30":2,"31":6,"32":0,"33":9,"34":-1,"35":-1,"36":-1,"37":-1,"38":-1,"39":-1,"40":-1,"41":-1,"42":-1,"43":-1,"44":-1,"45":-1,"46":-1,"47":-1,"48":-1,"0":16},"extras":[0,0,0,0,0,0,0,0,0,0,0,0],"xenonColor":255,"smokecolor":[255,255,255]}'
						end
                        if Police then
                            vehicle[1]["doors"] = false
                            vehicle[1]["body"] = 1000
                            vehicle[1]["engine"] = 1000
                            vehicle[1]["health"] = 1000
                            vehicle[1]["windows"] = false
                            vehicle[1]["tyres"] = false
                        end

                        if WithoutDamage then
                            vehicle[1]["doors"] = false
                            vehicle[1]["body"] = 1000
                            vehicle[1]["engine"] = 1000
                            vehicle[1]["health"] = 1000
                            vehicle[1]["windows"] = false
                            vehicle[1]["tyres"] = false
                        end

						if Garages[Number]["payment"] then
							if vRP.UserPremium(Passport) then
								TriggerClientEvent("dynamic:closeSystem",source)
								local Exist,Network = Creative.ServerVehicle(Passport,Name,Coords[1],Coords[2],Coords[3],Coords[4],Plate,vehicle[1]["doors"],vehicle[1]["body"])

								if Exist then
                                    local Bank = vRP.GetBank(source)
                                    if Bank and Bank > TaxInfo["MinBank"] then
                                        local Tax = Bank * TaxInfo["Tax"]
                                        vRP.RemoveBank(Passport,parseInt(Tax),true)
                                    end

									--[[ Inclui 'source' ]]
									local Players = vRPC.Players(source)

									SendUnmoddedVehicleToClient( To.Multiple( Players ), Name,Network,vehicle[1]["engine"],vehicle[1]["health"],Mods,vehicle[1]["windows"] or {},vehicle[1]["tyres"] or {},Degrade(vehicle[1]["degrade"]), source)
                                    if not vRP.HasGroup(Passport, "BolsaFamilia") then
									    TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),7500,"Taxa Veiculo")
                                    end
									-- TriggerClientEvent("Notify2",source,"#completeTimer",{msg=CompleteTimers(vehicle[1]["tax"] - os.time())})
									TriggerEvent("engine:tryFuel",Plate,100)
									Spawn[Plate] = { Passport,Name,Network }

									Plates[Plate] = Passport
								end
							else
								local VehiclePrice = VehiclePrice(Name)
								if vRP.Request(source,"Retirar o veículo por <b>$"..parseFormat(VehiclePrice * 0.05).."</b> dólares?","Sim, efetuar o pagamento","Não, volto depois") then
									if vRP.GetBank(source) >= parseInt(VehiclePrice * 0.05) then
										TriggerClientEvent("dynamic:closeSystem",source)
										local Exist,Network = Creative.ServerVehicle(Passport,Name,Coords[1],Coords[2],Coords[3],Coords[4],Plate,vehicle[1]["doors"],vehicle[1]["body"])
										if Exist then
                                            local Bank = vRP.GetBank(source)
                                            if Bank and Bank > TaxInfo["MinBank"] then
                                                local Tax = Bank * TaxInfo["Tax"]
                                                vRP.RemoveBank(Passport,parseInt(Tax),true)
                                            end

											--[[ Inclui 'source' ]]
											local Players = vRPC.Players(source)

											SendUnmoddedVehicleToClient( To.Multiple( Players ) ,Name,Network,vehicle[1]["engine"],vehicle[1]["health"],Mods,vehicle[1]["windows"],vehicle[1]["tyres"],Degrade(vehicle[1]["degrade"]), source)

											TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),1000)
											-- TriggerClientEvent("Notify2",source,"#completeTimer",{msg=CompleteTimers(vehicle[1]["tax"] - os.time())})
											TriggerEvent("engine:tryFuel",Plate,100)
											Spawn[Plate] = { Passport,Name,Network }
											vRP.PaymentFull(Passport,VehiclePrice * 0.05)

											Plates[Plate] = Passport
										end
									else
                                        -- TriggerClientEvent("garages:Close",source)
										TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000,"Garagem")
										-- TriggerClientEvent("Notify2",source,"#semdoletas")
									end
								end
							end
						else
							TriggerClientEvent("dynamic:closeSystem",source)
							local Exist,Network = Creative.ServerVehicle(Passport,Name,Coords[1],Coords[2],Coords[3],Coords[4],Plate,vehicle[1]["doors"],vehicle[1]["body"])

							if Exist then

								--[[ Inclui 'source' ]]
								local Players = vRPC.Players(source)

								SendUnmoddedVehicleToClient( To.Multiple( Players ),Name,Network,vehicle[1]["engine"],vehicle[1]["health"],Mods,vehicle[1]["windows"],vehicle[1]["tyres"],Degrade(vehicle[1]["degrade"]), source)

								TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),1000)
								-- TriggerClientEvent("Notify2",source,"#completeTimer",{msg=CompleteTimers(vehicle[1]["tax"] - os.time())})
								TriggerEvent("engine:tryFuel",Plate,100)
								Spawn[Plate] = { Passport,Name,Network }

								Plates[Plate] = Passport
							end
						end
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
local CarZaralho = {
    ["dick"] = true,
    ["mazdadead"] = true,
	["robertofirmino"] = true,
	["fuscaleo"] = true,
	["bbdawn"] = true,
	["bnr342"] = true,
	["mercedesgt632"] = true,
	-- carros bugados
	-- ["rvjeepcherokee"] = true,
	-- ["esc21blindado"] = true,
	-- ["unoescada"] = true,
	-- ["x6pol"] = true,
	
}

RegisterCommand("addcar",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
        
        if CarZaralho[Message[1]] and not vRP.HasGroup(Passport, "Admin", 1) then
            return
        end

		if vRP.HasGroup(Passport,"Admin",1) then
			local Keyboard = vKEYBOARD.keyDouble(source,"Passaporte","Nome do veículo:")
            if Keyboard and Keyboard[1] then
				vRP.Query("vehicles/addVehicles",{ Passport = parseInt(Keyboard[1]), vehicle = Keyboard[2], plate = vRP.GeneratePlate(), work = "false" })
				TriggerClientEvent("Notify",source,"verde","Veículo adicionado com sucesso.",5000,"ADDCAR")
				-- TriggerClientEvent("Notify2",source,"#addcar")
			end
        end
    end
end)


RegisterCommand("car",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then

        if CarZaralho[Message[1]] and not vRP.HasGroup(Passport, "Admin", 1) then
            return
        end

		if vRP.HasGroup(Passport,"Admin",3) or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) or vRP.HasGroup(Passport,"QA") or vRP.HasGroup(Passport,"Comercial") and Message[1] and VehicleExist(Message[1]) then
			
			local VehicleName = Message[1]
			local Ped = GetPlayerPed(source)
            if Ped ~= 0 and DoesEntityExist(Ped) then
                local Coords = GetEntityCoords(Ped)
                local Heading = GetEntityHeading(Ped)
                local Plate = "VEH"..(10000 + Passport)
                local Exist,Network,Vehicle = Creative.ServerVehicle(Passport,VehicleName,Coords["x"],Coords["y"],Coords["z"],Heading,Plate,nil,1000)

                if not Exist then
                    return
                end		

				--[[ Inclui 'source' ]]
                local Players = vRPC.Players(source)
				
                SendUnmoddedVehicleToClient( To.Multiple( Players ),VehicleName,Network,1000,1000,nil,false,false,0, source)
                
                Spawn[Plate] = { Passport,VehicleName,Network }
                TriggerEvent("engine:tryFuel",Plate,100)
                Plates[Plate] = Passport

                -- exports["vrp"]:SendWebHook("car","**Passaporte:** "..Passport.."\n**Spawnou:** "..VehicleName.. "\n**Cds** "..Coords.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),7419530)

				exports["vrp"]:SendWebHook("car", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Spawnou:** " .. VehicleName .. "  \n**Cds** "..Coords.."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
            end
		end
	end
end, false)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv",function(source)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin",5) or vRP.HasGroup(Passport,"Aliado") or vRP.HasGroup(Passport,"InfluenciadorVerificado",5) or vRP.HasGroup(Passport,"QA") or vRP.HasGroup(Passport,"Comercial") then
		TriggerClientEvent("garages:Delete",source,nil,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Dv")
AddEventHandler("garages:Dv",function(Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Spawn[Plate] then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
        local Info = Spawn[Plate] or {}
		-- exports["vrp"]:SendWebHook("dv","**Passaporte:** "..Passport.."\n**Cds:** "..Coords.."\n**Dono:** "..Spawn[Plate][1].."\n**Modelo:** "..Spawn[Plate][2].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
        local Name = vRP.FullName(Passport) or "Inexistente"
        Coords = Coords or vector3(0,0,0)
        local Owner = Info[1] or "1"
        local Name2 = vRP.FullName(Owner)
        local Model = Info[2] or "Inexistente"
		exports["vrp"]:SendWebHook("dv", "**Passaporte:** " .. Passport .. " " .. Name .."\n**Cds:** "..Coords.. "\n**Dono:** " .. Owner .. " " .. Name2 .."\n**Modelo:** "..Model.."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
	end
end)

RegisterServerEvent("garages:Dv2")
AddEventHandler("garages:Dv2",function(Plate)
    if Plates[Plate] then
        Plates[Plate] = nil
    end

    if Signal[Plate] then
        Signal[Plate] = nil
    end

    if Spawn[Plate] then
        Spawn[Plate] = nil
    end
end)

RegisterCommand("dvarea",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport and vRP.HasGroup(Passport,"Admin",5) then
        local Range = parseInt(Message[1]) or 15
        local Vehicles = GetAllVehicles() 
        local Ped = GetPlayerPed(source)
        local Coords = GetEntityCoords(Ped)
        if Range > 150 then
            if not vRP.HasGroup(Passport,"Admin",2) then
                Range = 500
            end
        end
        local TotalDeletedDv = 0
        TriggerClientEvent("garages:Delete2",source,parseInt(Range))
        for i=1,#Vehicles do
            local Entity = Vehicles[i]
            if DoesEntityExist(Entity) and GetEntityType(Entity) == 2 then
                local HasAnyone = false
                for i=-1,6 do
                    local Ped = GetPedInVehicleSeat(Entity,i)
                    if Ped and Ped ~= 0 then
                        HasAnyone = true
                    end
                end
                if not HasAnyone then 
                    local VehCoords = GetEntityCoords(Entity)
                    local Distance = #(Coords - VehCoords)
                    if Distance <= Range then
                        local Plate = GetVehicleNumberPlateText(Entity)
                        if Plate and Plate ~= "" then
                            TriggerEvent("garages:deleteVehicle",Entity,Plate,true)
                            TotalDeletedDv = TotalDeletedDv + 1
                        else
                            DeleteEntity(Entity)
                            TotalDeletedDv = TotalDeletedDv + 1
                        end
                    end
                end
            end
        end
        print("Total Vehicles: ^2"..#GetAllVehicles().."^7 | Total Deleted: ^1"..TotalDeletedDv.."^7")
        TriggerClientEvent("Notify",source,"verde","Total Vehicles: "..#GetAllVehicles().." | Total Deletados: "..TotalDeletedDv.."",5000)
		-- TriggerClientEvent("Notify2",source,"#totalVeD",{msg=#GetAllVehicles(),msg2=TotalDeletedDv})
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Key")
AddEventHandler("garages:Key",function(entity)
	local source = source
	local Plate = entity[1]
	local Passport = vRP.Passport(source)
	if Passport and Plates[Plate] and Plates[Plate] == Passport then
		vRP.GenerateItem(Passport,"vehkey-"..Plate,1,true,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Lock")
AddEventHandler("garages:Lock",function(Network,Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Plates[Plate] and Plates[Plate] == Passport then
		TriggerEvent("garages:LockVehicle",source,Network)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("garages:LockVehicle",function(source,Network)
	local Network = NetworkGetEntityFromNetworkId(Network)
	local Doors = GetVehicleDoorLockStatus(Network)

	if parseInt(Doors) <= 1 then
		TriggerClientEvent("Notify",source,"vermelho","Veículo trancado.",5000,"Veiculo")
		-- TriggerClientEvent("Notify2",source,"#lockVeic")
		TriggerClientEvent("sounds:Private",source,"locked",0.7)
		SetVehicleDoorsLocked(Network,2)
	else
		TriggerClientEvent("Notify",source,"verde","Veículo destrancado.",5000,"Veiculo")
		-- TriggerClientEvent("Notify2",source,"#openVeic")
		TriggerClientEvent("sounds:Private",source,"unlocked",0.7)
		SetVehicleDoorsLocked(Network,1)
	end

	if not vRP.InsideVehicle(source) then
		vRPC.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
		Wait(350)
		vRPC.stopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Delete(Network,Health,Engine,Body,Fuel,Doors,Windows,Tyres,Plate)
	if Spawn[Plate] then
		local Passport = Spawn[Plate][1]
		local vehName = Spawn[Plate][2]

		if parseInt(Engine) <= 100 then
			Engine = 100
		end

		if parseInt(Body) <= 100 then
			Body = 100
		end

		if parseInt(Fuel) >= 100 then
			Fuel = 100
		end

		if parseInt(Fuel) <= 0 then
			Fuel = 0
		end

		local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
		if vehicle[1] ~= nil then
			vRP.Query("vehicles/updateVehicles",{ Passport = Passport, vehicle = vehName, engine = parseInt(Engine), body = parseInt(Body), health = parseInt(Health), fuel = parseInt(Fuel), doors = json.encode(Doors), windows = json.encode(Windows), tyres = json.encode(Tyres) })
            vRP.DeleteVehicle(Plate)
		end
	end

	TriggerEvent("garages:deleteVehicle",Network,Plate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle",function(Network,Plate,Server)
	if Network ~= nil and Plate ~= nil then
		if Plates[Plate] then
			Plates[Plate] = nil
		end

		if Signal[Plate] then
			Signal[Plate] = nil
		end

		if Spawn[Plate] then
			Spawn[Plate] = nil
		end

		if string.sub(Plate,1,4) == "DISM" then
			local Passport = parseInt(string.sub(Plate,5,8)) - 1000
			local source = vRP.Source(Passport)
			if source then
				TriggerClientEvent("inventory:Disreset",source)
				TriggerClientEvent("Notify",source,"amarelo","O veículo do seu contrato foi encaminhado para o <b>Impound</b> e o <b>Lester</b> disse que você pode assinar um novo contrato quando quiser.",10000)
				-- TriggerClientEvent("Notify2",source,"#veiculoEncontrado")
			end
		end
        if not Server then
		    Network = NetworkGetEntityFromNetworkId(Network)
        end
		if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 and GetVehicleNumberPlateText(Network) == Plate then
			DeleteEntity(Network)
            vRP.DeleteVehicle(Plate)
            SpawnedVehicles[Network] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Signal",function(Plate)
	return Signal[Plate]
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR DV
-----------------------------------------------------------------------------------------------------------------------------------------
local CountDelete = {}
local MaxToDelete = 15
local TotalDeleted = 0

if cityName == "Base" then
    MaxToDelete = 10
end

local noCleanVehicle = {
	["Grande"] = true
}

CreateThread(function()
    if noCleanVehicle[cityName] then 
        return 
    end
    while true do
        pcall(function()
            local Vehicles = GetAllVehicles() 
            for i=1,#Vehicles do
                local Entity = Vehicles[i]
                if DoesEntityExist(Entity) and GetEntityType(Entity) == 2 then
                    -- if Entity(Entity)["state"]["lafy"] then
                    --     goto NextVehicle
                    -- end
                    if not CountDelete[Entity] then
                        CountDelete[Entity] = 0
                    end
                    local Ped = GetPedInVehicleSeat(Entity,-1)
                    if Ped and Ped > 0 then 
                        CountDelete[Entity] = 0
                        goto NextVehicle
                    end

                    CountDelete[Entity] = CountDelete[Entity] + 1
                    -- if GetEntityRoutingBucket(Entity) ~= 1 then
                    --     MaxToDelete = MaxToDelete + 90
                    -- end
                    if CountDelete[Entity] >= MaxToDelete then
                        local Plate = GetVehicleNumberPlateText(Entity)
                        if Plate and Plate ~= "" then
                            TriggerEvent("garages:deleteVehicle",Entity,Plate,true)
                            vRP.DeleteVehicle(Plate)
                            TotalDeleted += 1
                        else
                            TotalDeleted += 1
                            DeleteEntity(Entity)
                            SpawnedVehicles[Entity] = nil
                        end
                    end

                end
                ::NextVehicle::
            end
        end)
        print("Total Vehicles: ^2"..#GetAllVehicles().."^7 | Total Deleted: ^1"..TotalDeleted.."^7")
        Wait(60000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGETYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.GetGarageType(Number)
    if Garages[Number] and Garages[Number]["Info"] then
        return (Garages[Number]["Info"]["Perm"] or Garages[Number]["Info"]["House"])
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET VALID PLATES
-----------------------------------------------------------------------------------------------------------------------------------------
exports("GetPlates",function()
    return Plates
end)

AddEventHandler("entityCreating", function(ent)

    if GetEntityType(ent) == 2 then
        local createdAt = GetGameTimer()
        local timeoutAt = (createdAt + (VEHICLE_AWAIT_CREATION_TIMEOUT_SECS * 1000))
        while ( not DoesEntityExist(ent) ) and ( GetGameTimer() < timeoutAt ) do
            Wait(100)
        end
        Wait(100)
        if not SpawnedVehicles[ent] then
            if DoesEntityExist(ent) then
                local Plate = GetVehicleNumberPlateText(ent)
                if Plate then
                    TriggerEvent("garages:deleteVehicle",ent,Plate,true)
                    vRP.DeleteVehicle(Plate)
                else
                    DeleteEntity(Entity)
                    SpawnedVehicles[ent] = nil
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
Propertys = {}
PropertysOwner = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local PriceGarage = 1000
RegisterServerEvent("garages:Propertys")
AddEventHandler("garages:Propertys",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("dynamic:closeSystem",source)
		TriggerClientEvent("Notify",source,"amarelo","Selecione o local da garagem.",5000,"Garagem")
        TriggerClientEvent("Notify:Text",source,"Selecione o local da garagem.")
        TriggerClientEvent("hud:Active",source,false)
        TriggerClientEvent("safezone:remPromo",source,true)

		local Hash = "prop_offroad_tyres02"
		local Application,Coords,Heading = vRPC.objectCoords(source,Hash,3.0)
		if Application then
			if #(Coords - exports["inventory"]:PropertyCoords(Name)) <= 25 then
                TriggerClientEvent("Notify:Text",source,"")
                TriggerClientEvent("Notify:Text",source,"Selecione o local do veículo.")
				local Open = Coords
				local Hash = "patriot"
				local Application,Coords,Heading = vRPC.objectCoords(source,Hash,3.0)
				if Application then
                    local HasToPay = false
                    local Paid = false
                    if not Propertys[Name] then
                        HasToPay = true
                    end

                    if HasToPay then
                        if vRP.Request(source,"Deseja comprar uma vaga de garagem por "..PriceGarage.." Diamantes?","Sim, Pagar","Não, Mudei de ideia")  then
                            if not vRP.PaymentGems(Passport,PriceGarage) then
                                TriggerClientEvent("Notify",source,"vermelho","Você não tem "..PriceGarage.." Diamantes.",5000,"Garagem")
                                return false
                            end
                        else
                            return false
                        end
                    end

                    if #(Coords - exports["inventory"]:PropertyCoords(Name)) <= 25 then
                        local New = {
                            ["1"] = { mathLength(Open["x"]),mathLength(Open["y"]),mathLength(Open["z"] + 1) },
                            ["2"] = { mathLength(Coords["x"]),mathLength(Coords["y"]),mathLength(Coords["z"] + 1),mathLength(Heading) }
                        }
                        vRP.Query("propertys/Garage",{ name = Name, garage = json.encode(New) })
                        if Propertys[Name] and Propertys[Name][1] then
                            Garages[Propertys[Name][1]] = nil
                            TriggerClientEvent("garages:RemProperty",source,Propertys[Name][1])
                        end
                        local Number = CreateHouseGarage(New,Name)
                        TriggerClientEvent("garages:Propertys",source,Propertys[Name])
                        TriggerClientEvent("Notify",source,"verde","Garagem adicionada com sucesso.",5000,"Garagem")
                    else    
                        TriggerClientEvent("Notify",source,"amarelo","A garagem precisa ser próximo da entrada.",5000,"Garagem")
                    end

				end
			else
				TriggerClientEvent("Notify",source,"amarelo","A garagem precisa ser próximo da entrada.",5000,"Garagem")
			end
            TriggerClientEvent("hud:Active",source,true)
            TriggerClientEvent("safezone:remPromo",source,false)
            TriggerClientEvent("Notify:Text",source,"")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function SetPropertyOwner(Passport,Name)
    if not PropertysOwner[Passport] then
        PropertysOwner[Passport] = {}
    end
    table.insert(PropertysOwner[Passport],Name)
end
exports("SetPropertyOwner",SetPropertyOwner)

function GetPlayerPropertys(Passport)
    local Query = vRP.Query("propertys/User",{ Passport = Passport })
    if Query and Query[1] then
        for i=1,#Query do
            local Name = Query[i]["Name"]
            local Garage = Query[i]["Garage"] ~= "{}" and json.decode(Query[i]["Garage"]) or false
            local Serial = Query[i]["Serial"]
            if Garage then
                Garage["Serial"] = Serial
                local Number = CreateHouseGarage(Garage,Name)
                TriggerClientEvent("garages:Propertys",source,Propertys[Name])
            end
            SetPropertyOwner(Passport,Name)
        end
    end
end

function CreateHouseGarage(Table,Name)
    local Number = #Garages + 1 
    local Format = {
        ["Info"] = {
            ["Name"] = "Garage",
            ["Payment"] = false,
            ["Perm"] = nil,
            ["House"] = Name,
            ["Number"] = Number,
            ["Serial"] = Table["Serial"],
        },
        ["Spawns"] = {
            ["Open"] = vector4(Table["1"][1],Table["1"][2],Table["1"][3],0.0),
            ["Positions"] = {
                vector4(Table["2"][1],Table["2"][2],Table["2"][3] + 1,Table["2"][4]),
            }
        }
    }
    Propertys[Name] = { 
        Format["Info"]["Number"],
        Format["Spawns"]["Open"],
        Format["Spawns"]["Positions"][1],
    }
    Garages[Number] = Format
    return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD START
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(100)
    local Query = vRP.Query("propertys/AllWithGarages")
    if Query and Query[1] then
        for i=1,#Query do
            local Name = Query[i]["Name"]
            local Garage = json.decode(Query[i]["Garage"])
            local Serial = Query[i]["Serial"]
            if Garage then
                Garage["Serial"] = Serial
                local Number = CreateHouseGarage(Garage,Name)
            end
        end
    end
    TriggerClientEvent("garages:AllPropertys",-1,Propertys)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
    GetPlayerPropertys(Passport)
    TriggerClientEvent("garages:AllPropertys",source,Propertys)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Creative = {}
Tunnel.bindInterface("race/checkpoints",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Payments = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Finish(Number,Points)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local vehName = vRPC.VehicleName(source)
		local Consult = vRP.Query("races/Result",{ Race = Number, Passport = Passport })

		if Consult[1] then
			if parseInt(Points) < parseInt(Consult[1]["Points"]) then
				vRP.Query("races/Records",{ Race = Number, Passport = Passport, Vehicle = VehicleName(vehName), Points = parseInt(Points) })
			end
		else
			local Identity = vRP.Identity(Passport)
			vRP.Query("races/Insert",{ Race = Number, Passport = Passport, Name = Identity["name"].." "..Identity["name2"], Vehicle = VehicleName(vehName), Points = parseInt(Points) })
		end

		if Payments[Passport] then
            vRP.GenerateItem(Passport,"dinheirosujo",5000,true)
            TriggerClientEvent("Notify","verde","Você recebeu <b>R$5000</b> por participar da corrida.",8000,"CORRIDA")
			-- TriggerClientEvent("Notify2","#dirtyFixMoney")
            local Rand = math.random(RacesCheckpoints[Number]["Payment"][1],RacesCheckpoints[Number]["Payment"][1])
            vRP.GenerateItem(Passport,"dinheirosujo",Rand,true)
            TriggerClientEvent("Notify","verde","Você recebeu <b>R$"..Rand.." </b> por participar da corrida.",8000,"CORRIDA")
			-- TriggerClientEvent("Notify2","#dirtyMoney",{msg=Rand})

            local Ranking = vRP.Query("races/TopFive",{ Race = Number })
            if Ranking[1] then
                if parseInt(Ranking[1]["Points"]) > parseInt(Points) then
                    vRP.GenerateItem(Passport,"racetrophy",1,true)
                end
            end

            --exports["player"]:ExitMarkers(source)
            Payments[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Start(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and RacesCheckpoints[Number] then
		if not RacesCheckpoints[Number]["Cooldown"][Passport] then
			RacesCheckpoints[Number]["Cooldown"][Passport] = os.time()
		end

		if os.time() >= RacesCheckpoints[Number]["Cooldown"][Passport] then
			Payments[Passport] = false

			if vRP.TakeItem(Passport,"credential",1) then
				RacesCheckpoints[Number]["Cooldown"][Passport] = os.time() + 3600
				--exports["player"]:EnterMarkers(source,"Corredor")
				Payments[Passport] = true

				local Service = vRP.NumPermission("Policia")
				for Passports,Sources in pairs(Service) do
					async(function()
						TriggerClientEvent("Notify",Sources,"amarelo","Detectamos um corredor clandestino nas ruas.",5000)
						-- TriggerClientEvent("Notify2",Source,"#clandestineRacer")
						vRPC.PlaySound(Sources,"Beep_Red","DLC_HEIST_HACKING_SNAKE_SOUNDS")
					end)
				end
			end

			return true
		else
			local Cooldown = RacesCheckpoints[Number]["Cooldown"][Passport] - os.time()
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos.",5000)
			-- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Cooldown})
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANKING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Ranking(Number)
	local Consult = vRP.Query("races/Ranking",{ Race = Number })
	return Consult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Payments[Passport] then
			Payments[Passport] = nil
			--exports["player"]:ExitMarkers(source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Payments[Passport] then
		Payments[Passport] = nil
		--exports["player"]:ExitMarkers(source)
	end
end)

exports("GetRaces",function(Number)
  return RacesCheckpoints
end)
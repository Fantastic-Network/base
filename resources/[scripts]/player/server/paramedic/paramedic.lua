-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local bloodTimers = {}
local extractPerson = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Reposed")
AddEventHandler("paramedic:Reposed",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 and vRP.GetHealth(entity) > 100 then
		if vRP.HasGroup(Passport,"Paramedic") then
			local Keyboard = vKEYBOARD.keySingle(source,"Minutos:")
			if Keyboard then
				if parseInt(Keyboard[1]) > 0 then
					local OtherPassport = vRP.Passport(entity)
					local Identity = vRP.Identity(OtherPassport)
					local playerTimer = parseInt(Keyboard[1] * 60)
					if Identity then
						if vRP.Request(source,"Adicionar <b>"..Keyboard[1].." minutos</b> de repouso no(a) <b>"..Identity["name"].."</b>?.","Sim, aplicar repouso","Não, mudei de ideia") then
							TriggerClientEvent("Notify",source,"azul","Aplicou <b>"..Keyboard[1].." minutos</b> de repouso.",10000)
							-- TriggerClientEvent("Notify2",source,"#reposed",{msg=Keyboard[1]})
							TriggerEvent("Reposed",entity,OtherPassport,playerTimer)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Treatment")
AddEventHandler("paramedic:Treatment",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 and vRP.GetHealth(entity) > 100 then
		if vRP.Request(entity,"Pagar $10.000 pelo seu tratamento?") then
			local OtherPassport = vRP.Passport(entity)
			if vRP.PaymentFull(OtherPassport,10000) then
				if not bloodTimers[OtherPassport] then
					bloodTimers[OtherPassport] = os.time() + 1800
				end

				--vRP.GiveBank(Passport,10000,"Treatment")
                vRP.GenerateMoney(Passport,10000)
				TriggerClientEvent("target:StartTreatment",entity)
				TriggerClientEvent("Notify",source,"amarelo","Tratamento começou.",5000)
				-- TriggerClientEvent("Notify2",source,"#treatment")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:BED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Bed")
AddEventHandler("paramedic:Bed",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if vRP.HasGroup(Passport,"Paramedic") then
			TriggerClientEvent("target:BedDeitar",entity)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Revive")
AddEventHandler("paramedic:Revive",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(entity) <= 100 then
        local Policia = vRP.HasGroup(Passport,"Policia")
		if vRP.HasGroup(Passport,"Paramedic") or Policia then
            local Time = 10000
            if Policia then
                Time = 1000*60
            end
			local OtherPassport = vRP.Passport(entity)
			Player(source)["state"]["Cancel"] = true
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("Progress",source,"Tratando",Time)
			-- exports["vrp"]:SendWebHook("reanimar","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Reanimou:** "..OtherPassport.." " .. vRP.FullName(OtherPassport) .. "\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
			vRPC.playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
            
			SetTimeout(Time,function()
				vRP.Revive(entity,101)
				vRPC.DestroyObjects(source)
                --if GlobalState["Hunger"] then
                    vRP.UpgradeThirst(OtherPassport,25)
                    vRP.UpgradeHunger(OtherPassport,25)
                --end
                Player(source)["state"]["Buttons"] = false
				Player(source)["state"]["Cancel"] = false
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:BANDAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Bandage")
AddEventHandler("paramedic:Bandage",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 and vRP.GetHealth(entity) > 100 then
		if vRP.HasGroup(Passport,"Paramedic") then
			if vCLIENT.Bleeding(entity) > 0 then
				if vRP.TakeItem(Passport,"gauze",1) then
					local Bandage = vCLIENT.Bandage(entity)
					TriggerClientEvent("Progress",source,"Passando",3000)
					vRPC.playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
					SetTimeout(3000,function()
						TriggerClientEvent("Notify",source,"amarelo","Passou ataduras no(a) <b>"..Bandage.."</b>.",3000)
						-- TriggerClientEvent("Notify2",source,"#usaBandage",{msg=Bandage})
						TriggerClientEvent("sounds:Private",source,"bandage",0.5)
						vRPC.DestroyObjects(source)
					end)
				else
					TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("gauze").."</b>.",5000)
					-- TriggerClientEvent("Notify2",source,"#precisaGauze",{msg=itemName{"gauze"}})
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Nenhum ferimento encontrado.",5000)
				-- TriggerClientEvent("Notify2",source,"#semFerimento")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Diagnostic")
AddEventHandler("paramedic:Diagnostic",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if vRP.HasGroup(Passport,"Paramedic") then
			local Result = ""
			local OtherPassport = vRP.Passport(entity)
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				local Diagnostic,Bleeding = vCLIENT.Diagnostic(entity) or {},vCLIENT.Bleeding(entity) or 1

				if Bleeding <= 1 then
					Result = "<b>Sangramento:</b> Baixo<br>"
				elseif Bleeding == 2 then
					Result = "<b>Sangramento:</b> Médio<br>"
				elseif Bleeding >= 3 then
					Result = "<b>Sangramento:</b> Alto<br>"
				end

				Result = Result.."<b>Tipo Sangüíneo:</b> "..Sanguine(Identity["blood"])

				local Number = 0
				local Damaged = false
				for k,v in pairs(Diagnostic) do
					if not Damaged then
						Result = Result.."<br><br><b>Danos Superficiais:</b><br>"
						Damaged = true
					end

					Number = Number + 1
					Result = Result.."<b>"..Number.."</b>: "..Bone(k).."<br>"
				end

				TriggerClientEvent("Notify",source,"amarelo",Result,10000)
				-- TriggerClientEvent("Notify2",source,"#dmgResult",{msg=Result})
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETBURN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:presetBurn")
AddEventHandler("paramedic:presetBurn",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Emergency") then
			local Model = vRP.ModelPlayer(entity)
			local ParamedicPresets = exports["variables"]:GetParamedicPresets()
			if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("skinshop:Apply",entity,ParamedicPresets["Burn"][Model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETPLASTER
-----------------------------------------------------------------------------------------------------------------------------------------
local Plaster = {}
RegisterServerEvent("paramedic:presetPlaster")
AddEventHandler("paramedic:presetPlaster",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Emergency") then
            if not Plaster[entity] then
                local Model = vRP.ModelPlayer(entity)
				local ParamedicPresets = exports["variables"]:GetParamedicPresets()
                if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
                    TriggerClientEvent("skinshop:Apply",entity,ParamedicPresets["Plaster"][Model])
                end
                Plaster[entity] = true
                Player(entity)["state"]["Plaster"] = true
            else
                Player(entity)["state"]["Plaster"] = false
                Plaster[entity] = false
                TriggerClientEvent("Notify",entity,"amarelo","Você já pode retirar o gesso.",5000,"Hospital")
				-- TriggerClientEvent("Notify2",entity,"#removePlaster")
            end
		end
	end
end)

AddEventHandler("Connect",function(Passport,source)
    Wait(15000)
    if Plaster[source] then
        local Model = vRP.ModelPlayer(source)
		local ParamedicPresets = exports["variables"]:GetParamedicPresets()
        if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
            TriggerClientEvent("skinshop:Apply",source,ParamedicPresets["Plaster"][Model])
        end
        Player(source)["state"]["Plaster"] = true
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:EXTRACTBLOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:extractBlood")
AddEventHandler("paramedic:extractBlood",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = vRP.Passport(entity)
		if OtherPassport then
			if not extractPerson[OtherPassport] then
				extractPerson[OtherPassport] = true

				local Ped = GetPlayerPed(entity)
                if Ped ~= 0 and DoesEntityExist(Ped) then
                    if GetEntityHealth(Ped) >= 250 then
                        local Identity = vRP.Identity(OtherPassport)
                        if Identity then
                            if vRP.Request(entity,"Deseja iniciar a doação sangue?","Sim, iniciar processo","Não, tenho medo") then
                                if not bloodTimers[OtherPassport] then
                                    bloodTimers[OtherPassport] = os.time()
                                end

                                if os.time() >= bloodTimers[OtherPassport] then
                                    if vRP.TakeItem(Passport,"syringe",3) then
                                        vRPC.downHealth(entity,50)
                                        bloodTimers[OtherPassport] = os.time() + 10800
                                        vRP.GenerateItem(Passport,"syringe0"..Identity["blood"],5,true)

                                        if extractPerson[OtherPassport] then
                                            extractPerson[OtherPassport] = nil
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>3x "..itemName("syringe").."</b>.",5000)
										-- TriggerClientEvent("Notify2",source,"#needSyringe",{msg=itemName("syringe")})
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"amarelo","No momento não é possível efetuar a extração, o mesmo ainda está se recuperando ou se acidentou recentemente.",10000)
									-- TriggerClientEvent("Notify2",source,"#waitExtraction")
                                end
                            end
                        end
                    else
                        TriggerClientEvent("Notify",source,"amarelo","Sistema imunológico do paciente muito fraco.",5000)
							-- TriggerClientEvent("Notify2",source,"#weakImmuSyst")
                    end
                end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:BLOODDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:bloodDeath")
AddEventHandler("paramedic:bloodDeath",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		bloodTimers[Passport] = os.time() + 10800
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if extractPerson[Passport] then
		extractPerson[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Robberype = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:INITROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
cityName = GetConvar("cityName", "Base")
GlobalState["EconomyRobberys"] = 0.5
if cityName == "Base" then
    GlobalState["EconomyRobberys"] = 0.5
end
RobberysAll = 1.0

CreateThread(function()
    Wait(2000)
    RobberysAll = exports['variables']:GetVariable('variables','RobberysAll') or 1.0
    RobberysSelected = exports['variables']:GetVariable('variables','SelectedRobberys') or {}
    for Number,Data in pairs(Robberys) do
        if RobberysSelected[tostring(Number)] then
            Robberys[tostring(Number)]["payment"] = Data["payment"]
        end
    end
end)
function Creative.InitRobbery(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Robberys[Number] then
			if not Robberys[Number]["avaiable"] then
				if not Robberype[Robberys[Number]["type"]] then
					Robberype[Robberys[Number]["type"]] = os.time()
				end

				if os.time() >= Robberype[Robberys[Number]["type"]] then
					local Service,Total = vRP.NumPermission(Robberys[Number]["group"])
					--if Total >= Robberys[Number]["population"] then
						local Consult = vRP.InventoryItemAmount(Passport,Robberys[Number]["need"]["item"])
						if Consult[1] >= Robberys[Number]["need"]["amount"] then
							if not vRP.CheckDamaged(Consult[2]) then
                                if Robberys[Number]["custom"] then
                                    local Keyboard = vKEYBOARD.keySingle(source,"Numero de Bandidos:")
                                    if Keyboard and Keyboard[1] then
                                        if tonumber(Keyboard[1]) > 0 then
                                            TriggerEvent("robberys:AcceptPolice",source,Number,tonumber(Keyboard[1]))
                                        end
                                    else
                                        return
                                    end
                                end
								if vRP.TakeItem(Passport,Consult[2],Robberys[Number]["need"]["amount"]) then
									Robberype[Robberys[Number]["type"]] = os.time() + Robberys[Number]["cooldown"]
									Robberys[Number]["timavaiable"] = os.time() + Robberys[Number]["duration"]
									Robberys[Number]["avaiable"] = true
                                    local Type = Robberys[Number]["type"]
                                    local Name = Robberys[Number]["name"]

									for Passports,Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = Robberys[Number]["name"], x = Robberys[Number]["Coords"]["x"], y = Robberys[Number]["Coords"]["y"], z = Robberys[Number]["Coords"]["z"], blipColor = 22 })
                                            if Type == "media" or Type == "grande" then
                                                TriggerClientEvent("NotifyPolice",Sources, "Atenção roubo em adamento em <b>"..Name.."</b>.")
                                            end
											-- vRPC.PlaySound(Sources,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
										end)
									end

									TriggerClientEvent("Notify",source,"verde","Progresso de desencriptação do sistema iniciado, o mesmo vai estar concluído em <b>"..Robberys[Number]["duration"].."</b> segundos.",5000)
									-- TriggerClientEvent("Notify2",source,"#systemDecryption",{msg=Robberys[Number]["duration"]})
									exports["vrp"]:SendWebHook("roubo","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Esta roubando lojinha:** "..Robberys[Number]["name"].."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
								end	
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(Robberys[Number]["need"]["item"]).."</b> danificado.",5000)
								-- TriggerClientEvent("Notify2",source,"#damagedItem",{msg=Robberys[Number]["need"]["item"]})
							end
						else
							TriggerClientEvent("Notify",source,"vermelho","Opa, você não tem <b>"..Robberys[Number]["need"]["amount"].."x "..itemName(Robberys[Number]["need"]["item"]).."</b>.. Que tal procurar um desmanche para conseguir um e voltar aqui?",60000,"ROUBOS")
							-- TriggerClientEvent("Notify2",source,"#needItemX",{msg=Robberys[Number]["need"]["amount"],msg2=itemName(Robberys[Number]["need"]["item"])})
						end
					-- else
					-- 	TriggerClientEvent("Notify",source,"vermelho","Contingente indisponível.",5000)
					-- 	-- TriggerClientEvent("Notify2",source,"#contingentUnav")
					-- end
				else
					local Cooldown = parseInt(Robberype[Robberys[Number]["type"]] - os.time())
					TriggerClientEvent("Notify",source,"azul","Cofre está vazio, aguarde <b>"..Cooldown.."</b> segundos.",5000)
					-- TriggerClientEvent("Notify2",source,"#vaultEmpty",{msg=Cooldown})
				end
			else
				if os.time() >= Robberys[Number]["timavaiable"] then
					Robberys[Number]["avaiable"] = false

					for k,v in pairs(Robberys[Number]["payment"]) do
                        local Amount = math.random(v["min"],v["max"])
                        if Amount > 1 then
                            Amount = parseInt(Amount * GlobalState["EconomyRobberys"])
                        end
                        Amount = parseInt(Amount * RobberysAll)
						vRP.GenerateItem(Passport,v["item"],Amount,true)
					end
				else
					local Cooldown = parseInt(Robberys[Number]["timavaiable"] - os.time())
					TriggerClientEvent("Notify",source,"azul","Desencriptação em andamento, aguarde <b>"..Cooldown.."</b> segundos.",5000)
					-- TriggerClientEvent("Notify2",source,"#decryptionInProg",{msg=Cooldown})
				end
			end
		end
	end
end

AddEventHandler("robberys:AcceptPolice",function(source,Index,Number)
    TriggerEvent("notify:CreateAction",source,Robberys[Index]["custom"]["coords"],Number,Robberys[Index]["name"])
end)
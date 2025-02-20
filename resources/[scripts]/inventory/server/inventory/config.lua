-----------------------------------------------------------------------------------------------------------------------------------------
-- GEOGES
-----------------------------------------------------------------------------------------------------------------------------------------
SafeMode = GetConvar("SafeMode", "")
Geodes = {
	{ ["item"] = "emerald", ["min"] = 1, ["max"] = 1 },
	{ ["item"] = "diamond", ["min"] = 2, ["max"] = 2 },
	{ ["item"] = "ruby", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "sapphire", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "amethyst", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "amber", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "turquoise", ["min"] = 1, ["max"] = 3 },
	{ ["item"] = "aluminum", ["min"] = 1, ["max"] = 2 },
	{ ["item"] = "copper", ["min"] = 1, ["max"] = 2 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
InventoryUse = {
	["adrenaline"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		-- local Adrenaline = {
		-- 	vec3(1978.98,5171.98,47.63),
		-- 	vec3(312.47,-562.1,43.29),
		-- 	vec3(368.33,-1592.01,25.44),
		-- 	vec3(1772.18,2577.82,45.73)
		-- }

		local Ped = GetPlayerPed(source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            local Coords = GetEntityCoords(Ped)
            -- for _,v in pairs(Adrenaline) do
            --     if #(Coords - v) <= 5 then
                    local ClosestPed = vRPC.ClosestPed(source,3)
                    if ClosestPed and vRP.GetHealth(ClosestPed) <= 100 then
                        Active[Passport] = os.time() + 60
                        Player(source)["state"]["Buttons"] = true
                        TriggerClientEvent("inventory:Close",source)
                        TriggerClientEvent("Progress",source,"Reanimando",60000)
                        vRPC._playAnim(source,true,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)

                        SetTimeout(60000,function()
							if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
								Active[Passport] = nil
								vRPC._stopAnim(source,false)
								Player(source)["state"]["Buttons"] = false

								if vRP.TakeItem(Passport,Full,1,true,Slot) then
									vRP.Revive(ClosestPed,101)
								end
							end
						end)
                    end
            --     end
            -- end
        end
	end,

	["bandage"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
            local Health = vRP.GetHealth(source)
			if Health and vRP.GetHealth(source) > 1 and vRP.GetHealth(source) < 400 then

                local VIPBandage = {
                    ["Bronze"] = true,
                    ["Prata"] = true,
                    ["Ouro"] = true,
                    ["Black"] = true,
                    ["VipLancamento"] = true,
                }

                local HasVIP = false
                local NewVips = vRP.HasVip(Passport)
                if NewVips then
                    for Group,_ in pairs(NewVips) do
                        if VIPBandage[Group] then
                            HasVIP = true
                            break
                        end
                    end
                end

                if HasVIP then
                    if vRP.TakeItem(Passport,Full,1,true,Slot) then
                        TriggerClientEvent("sounds:Private",source,"bandage",0.5)
                        vRPC.updateHealth(source,80)
                        TriggerClientEvent("inventory:Close",source)
                    return
					end
                end

				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Passando",5000)
				vRPC._CreateObjects(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)

                SetTimeout(5000,function()
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC._DestroyObjects(source,"one")
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 30
							vRPC.updateHealth(source,80)
							TriggerClientEvent("sounds:Private",source,"bandage",0.5)
						end
					end
				end)
			else
				TriggerClientEvent("Notify",source,"amarelo","Não pode utilizar de vida cheia ou nocauteado.",5000)
				-- TriggerClientEvent("Notify2",source,"#fullLifeKnocked")
			end
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
			-- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Timer})
		end
	end,

	["sulfuric"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 4
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",4000)
		vRPC._playAnim(source,false,{"mp_suicide","pill"},false)

		SetTimeout(4000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				-- vRPC._stopAnim(source,false)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.Revive(Passport,100)
				end
			end
		end)
	end,

	["analgesic"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 1 and vRP.GetHealth(source) < 400 then
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Tomando",3000)
				vRPC._playAnim(source,true,{"mp_suicide","pill"},true)

                SetTimeout(3000,function()
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC._stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 15
							vRPC.updateHealth(source,80)
						end
					end
                end)
			else
				TriggerClientEvent("Notify",source,"azul","Não pode utilizar de vida cheia ou nocauteado.",5000)
				-- TriggerClientEvent("Notify2",source,"#fullLifeKnocked")
			end
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
			-- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Timer})
		end
	end,

	["oxy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 and vRP.GetHealth(source) < 400 then
				Active[Passport] = os.time() + 3
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Tomando",3000)
				vRPC._playAnim(source,true,{"mp_suicide","pill"},true)

                SetTimeout(3000,function()
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC._stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 15
							vRPC.updateHealth(source,8)
						end
					end
                end)
			else
				TriggerClientEvent("Notify",source,"azul","Não pode utilizar de vida cheia ou nocauteado.",5000)
				-- TriggerClientEvent("Notify2",source,"#fullLifeKnocked")
			end
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
			-- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Timer})
		end
	end,

	["vehkey"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Vehicle,Network,Plate = vRPC.VehicleList(source,5)
		if Vehicle then
			if Plate == Split[2] then
				TriggerEvent("garages:LockVehicle",source,Network)
			end
		end
	end,

	["suitcase"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split then
			if vRP.TakeItem(Passport,Full,1,false,Slot) then
				vRP.GiveItem(Passport,"suitcase",1,false)
				vRP.GiveItem(Passport,"dollars",Split[2],false)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		end
	end,

	["newchars"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,false,Slot) then
			vRP.UpgradeChars(source)
            TriggerClientEvent("inventory:HasToUpdate",source)
			TriggerClientEvent("inventory:Update",source,"Backpack")
			TriggerClientEvent("Notify",source,"verde","Personagem liberado.",5000)
			-- TriggerClientEvent("Notify2",source,"#playerFree")
		end
	end,

	["wheelchair"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Plate = "WCH"..math.random(10000,99999)
		TriggerEvent("plateEveryone",Plate)
		vCLIENT.wheelChair(source,Plate)
	end,

	["gemstone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,Amount,false,Slot) then
            TriggerClientEvent("inventory:HasToUpdate",source)
			TriggerClientEvent("inventory:Update",source,"Backpack")
			vRP.UpgradeGemstone(Passport,Amount)
		end
	end,

	["badge01"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
        vRPC._playAnim(source,true,{"paper_1_rcm_alt1-8","player_one_dual-8"},false)
	end,

	["badge02"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
        vRPC._playAnim(source,true,{"paper_1_rcm_alt1-8","player_one_dual-8"},false)
	end,

	["namechange"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local Keyboard = vKEYBOARD.keyDouble(source,"Nome:","Sobrenome:")
		if Keyboard and Keyboard[1] and Keyboard[2] then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				TriggerClientEvent("Notify",source,"verde","Passaporte atualizado.",5000)
				-- TriggerClientEvent("Notify2",source,"#passportAtt")
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				vRP.UpgradeNames(Passport,Keyboard[1] or " ",Keyboard[2]or " ")
			end
		end
	end,

	["phonechange"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local Keyboard = vKEYBOARD.keySingle(source,"Numero:")
		if Keyboard and Keyboard[1] then
            if string.len(Keyboard[1]) > 7 then
                TriggerClientEvent("Notify",source,"vermelho","Numero invalido.",5000)
                return
            end
            if vRP.UserPhone(Keyboard[1]) then
                TriggerClientEvent("Notify",source,"vermelho","Numero invalido.",5000)
                return
            end
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				TriggerClientEvent("Notify",source,"verde","Numero atualizado.",5000)
				-- TriggerClientEvent("Notify2",source,"#passportAtt")
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
				vRP.UpgradePhone(Passport,Keyboard[1])
			end
		end
	end,

	["dices"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Jogando",1750)
		vRPC._playAnim(source,true,{"anim@mp_player_intcelebrationmale@wank","wank"},true)

		Wait(1750)

		Active[Passport] = nil
		vRPC._stopAnim(source,false)
		Player(source)["state"]["Buttons"] = false

		local Dice = math.random(6)
		local Players = vRPC.Players(source)
		for _,v in ipairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe",v,source,"<img src='images/"..Dice..".png'>",10,true)
			end)
		end
	end,

	["deck"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)

		local card = math.random(13)
		local cards = { "A","2","3","4","5","6","7","8","9","10","J","Q","K" }

		local naipe = math.random(4)
		local naipes = { "<black>♣</black>","<red>♠</red>","<black>♦</black>","<red>♥</red>" }

		local Identity = vRP.Identity(Passport)
		TriggerClientEvent("chat:ClientMessage",source,Identity["name"].." "..Identity["name2"],"Tirou "..cards[card]..naipes[naipe].." do baralho.","jogo")

		local Players = vRPC.ClosestPeds(source,5)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("chat:ClientMessage",v[2],Identity["name"].." "..Identity["name2"],"Tirou "..cards[card]..naipes[naipe].." do baralho.","jogo")
			end)
		end
	end,

	["silvercoin"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Jogando",1750)
		vRPC._playAnim(source,true,{"anim@mp_player_intcelebrationmale@wank","wank"},true)

		Wait(1750)

		Active[Passport] = nil
		vRPC._stopAnim(source,false)
		Player(source)["state"]["Buttons"] = false

		local Coins = math.random(2)
		local Sides = { "Cara","Coroa" }
		local Identity = vRP.Identity(Passport)
		TriggerClientEvent("chat:ClientMessage",source,Identity["name"].." "..Identity["name2"],Sides[Coins],"jogo")

		local Players = vRPC.ClosestPeds(source,5)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("chat:ClientMessage",v[2],Identity["name"].." "..Identity["name2"],Sides[Coins],"jogo")
			end)
		end
	end,

	["goldcoin"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Jogando",1750)
		vRPC._playAnim(source,true,{"anim@mp_player_intcelebrationmale@wank","wank"},true)

		Wait(1750)

		Active[Passport] = nil
		vRPC._stopAnim(source,false)
		Player(source)["state"]["Buttons"] = false

		local Coins = math.random(2)
		local Sides = { "Cara","Coroa" }
		local Identity = vRP.Identity(Passport)
		TriggerClientEvent("chat:ClientMessage",source,Identity["name"].." "..Identity["name2"],Sides[Coins],"jogo")

		local Players = vRPC.ClosestPeds(source,5)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("chat:ClientMessage",v[2],Identity["name"].." "..Identity["name2"],Sides[Coins],"jogo")
			end)
		end
	end,

	["soap"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vPLAYER.checkSoap(source) ~= nil then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Usando",10000)
			vRPC._playAnim(source,true,{"amb@world_human_bum_wash@male@high@base","base"},true)

			SetTimeout(10000,function()
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC._stopAnim(source,false)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						TriggerClientEvent("player:Residuals",source)
					end
				end
            end)
		end
	end,

	["geode"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport,"WEAPON_HAMMER",1) then
			local Selected = math.random(#Geodes)
			local Rand = math.random(Geodes[Selected]["min"],Geodes[Selected]["max"])

			if (vRP.InventoryWeight(Passport) + (itemWeight(Geodes[Selected]["item"]) * Rand)) <= vRP.GetWeight(Passport) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.GenerateItem(Passport,Geodes[Selected]["item"],Rand,false)
	                TriggerClientEvent("inventory:HasToUpdate",source)
                    TriggerClientEvent("inventory:Update",source,"Backpack")
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				-- TriggerClientEvent("Notify2",source,"#mochilaFull")
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","<b>Martelo</b> não encontrado.",5000)
			-- TriggerClientEvent("Notify2",source,"#hammerNotFound")
		end
	end,

	["joint"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if (not Drugs[Passport] or os.time() > Drugs[Passport]) then
            Active[Passport] = os.time() + 10
            Player(source)["state"]["Buttons"] = true
            TriggerClientEvent("inventory:Close",source)
            TriggerClientEvent("Progress",source,"Fumando",10000)
            vRPC._CreateObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_sh_joint_01",49,28422)

            SetTimeout(10000,function()
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC._DestroyObjects(source,"one")
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						Drugs[Passport] = os.time() + 60
						vRP.DowngradeHunger(Passport,20)
						vRP.DowngradeThirst(Passport,20)
						vPLAYER.movementClip(source,"move_m@shadyped@a")
						TriggerClientEvent("paramedic:Drugs",source)
					end
				end
            end)
        else
            TriggerClientEvent("Notify",source,"amarelo","Espere <b>"..SecondsToMinutes(parseInt(Drugs[Passport]-os.time())).." Minutos</b> usar novamente.",5000,"Drogas")
			-- TriggerClientEvent("Notify2",source,"#waitUseDrug",{msg=SecondsToMinutes(parseInt(Drugs[Passport]-os.time()))})
        end
	end,

	["lanca"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        Active[Passport] = os.time() + 5
        Player(source)["state"]["Buttons"] = true
        TriggerClientEvent("inventory:Close",source)
        TriggerClientEvent("Progress",source,"Baforando",8000)
		vRPC._CreateObjects(source,"amb@incar@male@smoking@enter","enter","lanca",49,28422)

        SetTimeout(8000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeHunger(Passport,20)
					vRP.DowngradeThirst(Passport,20)
					TriggerClientEvent("player:setDrugEffect",source,60)
				end
			end
        end)
	end,

	["md"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        Active[Passport] = os.time() + 5
        Player(source)["state"]["Buttons"] = true
        TriggerClientEvent("inventory:Close",source)
        TriggerClientEvent("Progress",source,"Usando",4000)
		vRPC._playAnim(source,true,{"mp_suicide","pill"},true)

        SetTimeout(4000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._stopAnim(source)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeHunger(Passport,20)
					vRP.DowngradeThirst(Passport,20)
					TriggerClientEvent("player:setDrugEffect",source,60)
				end
			end
        end)
	end,

	["cocaine"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        Active[Passport] = os.time() + 5
        Player(source)["state"]["Buttons"] = true
        TriggerClientEvent("inventory:Close",source)
        TriggerClientEvent("Progress",source,"Cheirando",5000)
        vRPC._playAnim(source,true,{"amb@world_human_drinking@coffee@male@idle_a","idle_c"},false)

        SetTimeout(5000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._stopAnim(source)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("setEnergetic",source,30,1.30)
				end
			end
        end)
	end,

	["meth"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if (not Drugs[Passport] or os.time() > Drugs[Passport]) then
            if Armors[Passport] then
                if os.time() < Armors[Passport] then
                    local armorTimers = parseInt(Armors[Passport] - os.time())
                    TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..armorTimers.."</b> segundos.",5000)
					-- TriggerClientEvent("Notify2",source,"#waitArmor",{msg=armorTimers})
                    return
                end
            end

            Active[Passport] = os.time() + 10
            Player(source)["state"]["Buttons"] = true
            TriggerClientEvent("inventory:Close",source)
            TriggerClientEvent("Progress",source,"Inalando",10000)
            vRPC._playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)

            SetTimeout(10000,function()
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC._stopAnim(source)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						Drugs[Passport] = os.time() + 60*1
						TriggerClientEvent("paramedic:Drugs",source)
					end
				end
            end)
        else
            TriggerClientEvent("Notify",source,"amarelo","Espere <b>"..SecondsToMinutes(parseInt(Drugs[Passport]-os.time())).." Minutos</b> usar novamente.",5000,"Drogas")
			-- TriggerClientEvent("Notify2",source,"#waitUseDrug",{msg=SecondsToMinutes(parseInt(Drugs[Passport]-os.time()))})
        end
	end,

	["cigarette"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.ConsultItem(Passport,"lighter",1) then
			Active[Passport] = os.time() + 10
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Fumando",10000)
            vRPC._playAnim(source,true,{"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01"},false)

            SetTimeout(10000,function()
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC._stopAnim(source,false)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vRP.DowngradeHunger(Passport,5)
						vRP.DowngradeThirst(Passport,5)
					end
				end
            end)
		end
	end,

	["vape"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 15
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Fumando",15000)
        vRPC._CreateObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","ba_prop_battle_vape_01",49,18905,0.08,-0.00,0.03,-150.0,90.0,-10.0)

        SetTimeout(15000,function()
			Active[Passport] = nil
			vRPC._DestroyObjects(source)
			Player(source)["state"]["Buttons"] = false
        end)
	end,

	["medkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (not Healths[Passport] or os.time() > Healths[Passport]) then
			if vRP.GetHealth(source) > 100 and vRP.GetHealth(source) < 400 then
				Active[Passport] = os.time() + 10
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Passando",10000)
				vRPC._playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

                SetTimeout(10000,function()
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						vRPC._stopAnim(source,false)
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							Healths[Passport] = os.time() + 60
							vRPC.updateHealth(source,150)
						end
					end
                end)
			else
				TriggerClientEvent("Notify",source,"amarelo","Não pode utilizar de vida cheia ou nocauteado.",5000)
				-- TriggerClientEvent("Notify2",source,"#fullLifeKnocked")
			end
		else
			local Timer = parseInt(Healths[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Timer.."</b> segundos.",5000)
			-- TriggerClientEvent("Notify2",source,"#aguarde",{msg=Timer})
		end
	end,

	["gauze"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vPARAMEDIC.Bleeding(source) > 0 then
			Active[Passport] = os.time() + 3
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Passando",3000)
			vRPC._playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)

            SetTimeout(3000,function()
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC._stopAnim(source,false)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						vPARAMEDIC.Bandage(source)
					end
				end
            end)
		else
			TriggerClientEvent("Notify",source,"amarelo","Nenhum ferimento encontrado.",5000)
			-- TriggerClientEvent("Notify2",source,"#semFerimento")
		end
	end,

	["camera"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Camera"] then
			local Ped = GetPlayerPed(source)
			if Ped ~= 0 and DoesEntityExist(Ped) then
				if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_UNARMED") then
					return
				end

				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Camera",source,false)
				vRPC._CreateObjects(source,"amb@world_human_paparazzi@male@base","base","prop_pap_camera_01",49,28422)
			end
		end
	end,

	["binoculars"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Camera"] then
			local Ped = GetPlayerPed(source)
			if Ped ~= 0 and DoesEntityExist(Ped) then
				if GetSelectedPedWeapon(Ped) ~= GetHashKey("WEAPON_UNARMED") then
					return
				end

				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("inventory:Camera",source,true)
				vRPC._CreateObjects(source,"amb@world_human_binoculars@male@enter","enter","prop_binoc_01",49,28422)
			end
		end
	end,

	["evidence01"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Microscope = {
			{ 482.95,-988.61,30.68 },
			{ 312.47,-562.1,43.29 },
			{ 368.33,-1592.01,25.44 },
			{ 1772.18,2577.82,45.73 }
		}

		local Ped = GetPlayerPed(source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            local Coords = GetEntityCoords(Ped)
            for k,v in pairs(Microscope) do
                local Distance = #(Coords - vec3(v[1],v[2],v[3]))
                if Distance <= 1 then
                    local Identity = vRP.Identity(Split[2])
                    if Identity then
                        TriggerClientEvent("Notify",source,"amarelo","Evidência de <b>"..Identity["name2"].."</b>.",5000)
						-- TriggerClientEvent("Notify2",source,"#evidence",{msg=Identity["name2"]})
                        break
                    end
                end
            end
        end
	end,

	["evidence02"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Microscope = {
			{ 482.95,-988.61,30.68 },
			{ 312.47,-562.1,43.29 },
			{ 368.33,-1592.01,25.44 },
			{ 1772.18,2577.82,45.73 }
		}

		local Ped = GetPlayerPed(source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            local Coords = GetEntityCoords(Ped)
            for k,v in pairs(Microscope) do
                local Distance = #(Coords - vec3(v[1],v[2],v[3]))
                if Distance <= 1 then
                    local Identity = vRP.Identity(Split[2])
                    if Identity then
                        TriggerClientEvent("Notify",source,"amarelo","Evidência de <b>"..Identity["name2"].."</b>.",5000)
						-- TriggerClientEvent("Notify2",source,"#evidence",{msg=Identity["name2"]})
                        break
                    end
                end
            end
        end
	end,

	["evidence03"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Microscope = {
			{ 482.95,-988.61,30.68 },
			{ 312.47,-562.1,43.29 },
			{ 368.33,-1592.01,25.44 },
			{ 1772.18,2577.82,45.73 }
		}

		local Ped = GetPlayerPed(source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            local Coords = GetEntityCoords(Ped)
            for k,v in pairs(Microscope) do
                local Distance = #(Coords - vec3(v[1],v[2],v[3]))
                if Distance <= 1 then
                    local Identity = vRP.Identity(Split[2])
                    if Identity then
                        TriggerClientEvent("Notify",source,"amarelo","Evidência de <b>"..Identity["name2"].."</b>.",5000)
						-- TriggerClientEvent("Notify2",source,"#evidence",{msg=Identity["name2"]})
                        break
                    end
                end
            end
        end
	end,

	["evidence04"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local Microscope = {
			{ 482.95,-988.61,30.68 },
			{ 312.47,-562.1,43.29 },
			{ 368.33,-1592.01,25.44 },
			{ 1772.18,2577.82,45.73 }
		}

		local Ped = GetPlayerPed(source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            local Coords = GetEntityCoords(Ped)
            for k,v in pairs(Microscope) do
                local Distance = #(Coords - vec3(v[1],v[2],v[3]))
                if Distance <= 1 then
                    local Identity = vRP.Identity(Split[2])
                    if Identity then
                        TriggerClientEvent("Notify",source,"amarelo","Evidência de <b>"..Identity["name2"].."</b>.",5000)
						-- TriggerClientEvent("Notify2",source,"#evidence",{msg=Identity["name2"]})
                        break
                    end
                end
            end
        end
	end,

	["teddy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		vRPC._CreateObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","v_ilev_mr_rasberryclean",49,24817,-0.20,0.46,-0.016,-180.0,-90.0,0.0)
	end,

	["rose"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		vRPC._CreateObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","prop_single_rose",49,18905,0.13,0.15,0.0,-100.0,0.0,-20.0)
	end,

	["firecracker"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRP.InsideVehicle(source) and not vCLIENT.checkCracker(source) then
			Active[Passport] = os.time() + 3
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Acendendo",3000)
			vRPC._playAnim(source,true,{"anim@mp_fireworks","place_firework_3_box"},true)

            SetTimeout(3000,function()
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC._stopAnim(source,false)
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						TriggerClientEvent("inventory:Firecracker",source)
					end
				end
            end)
		end
	end,

	["gsrkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			Active[Passport] = os.time() + 5
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Usando",5000)

            SetTimeout(5000,function()
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					Player(source)["state"]["Buttons"] = false

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Informations = vPLAYER.checkSoap(ClosestPed)
						if Informations then
							local Number = 0
							local Message = ""

							for Value,v in pairs(Informations) do
								Number = Number + 1
								Message = Message.."<b>"..Number.."</b>: "..Value.."<br>"
							end

							TriggerClientEvent("Notify",source,"amarelo",Message,10000)
							-- TriggerClientEvent("Notify2",source,"#info",{msg=Message})
						else
							TriggerClientEvent("Notify",source,"amarelo","Nenhum resultado encontrado.",3000)
							-- TriggerClientEvent("Notify2",source,"#noResultFound")
						end
					end
                end
            end)
		end
	end,

	["gdtkit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			local OtherPassport = vRP.Passport(ClosestPed)
			local Identity = vRP.Identity(OtherPassport)
			if OtherPassport and Identity then
				Active[Passport] = os.time() + 5
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("Progress",source,"Usando",5000)

                SetTimeout(5000,function()
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false

						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							local weed = vRP.WeedReturn(OtherPassport)
							local chemical = vRP.ChemicalReturn(OtherPassport)
							local alcohol = vRP.AlcoholReturn(OtherPassport)

							local chemStr = ""
							local alcoholStr = ""
							local weedStr = ""

							if chemical == 0 then
								chemStr = "Nenhum"
							elseif chemical == 1 then
								chemStr = "Baixo"
							elseif chemical == 2 then
								chemStr = "Médio"
							elseif chemical >= 3 then
								chemStr = "Alto"
							end

							if alcohol == 0 then
								alcoholStr = "Nenhum"
							elseif alcohol == 1 then
								alcoholStr = "Baixo"
							elseif alcohol == 2 then
								alcoholStr = "Médio"
							elseif alcohol >= 3 then
								alcoholStr = "Alto"
							end

							if weed == 0 then
								weedStr = "Nenhum"
							elseif weed == 1 then
								weedStr = "Baixo"
							elseif weed == 2 then
								weedStr = "Médio"
							elseif weed >= 3 then
								weedStr = "Alto"
							end

							TriggerClientEvent("Notify",source,"azul","<b>Químicos:</b> "..chemStr.."<br><b>Álcool:</b> "..alcoholStr.."<br><b>Drogas:</b> "..weedStr,8000)
							-- TriggerClientEvent("Notify2",source,"#infoDrug",{msg=chemStr,msg2=alcoholStr,msg3=weedStr})
						end
					end
                end)
			end
		end
	end,

	["vest"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Armors[Passport] then
			if os.time() < Armors[Passport] then
				local armorTimers = parseInt(Armors[Passport] - os.time())
				TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..armorTimers.."</b> segundos.",5000)
				-- TriggerClientEvent("Notify2",source,"#waitArmor",{msg=armorTimers})
				return
			end
		end

		Active[Passport] = os.time() + 4
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Vestindo",4000)
		vRPC._playAnim(source,true,{"clothingtie","try_tie_negative_a"},true)

        SetTimeout(4000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._stopAnim(source,false)
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					Armors[Passport] = os.time() + 5
					vRP.SetArmour(source,99)
				end
			end
        end)
	end,

	["GADGET_PARACHUTE"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 3
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Usando",3000)

        SetTimeout(3000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vCLIENT.parachuteColors(source)
				end
			end
        end)
	end,

	["advtoolbox"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if Split then
			if not vRP.InsideVehicle(source) then
				local Vehicle,Network,Plate = vRPC.VehicleList(source,4)
				if Vehicle then
					vRPC.AnimActive(source)
					Active[Passport] = os.time() + 100
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("player:syncHoodOptions",source,Network,"open")
                    TriggerClientEvent("Progress",source,"Aplicando",100000)
					vRPC._playAnim(source,true,{"mini@repair","fixing_a_player"},true)

                    SetTimeout(100000,function()
						if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
							Active[Passport] = nil
							Player(source)["state"]["Buttons"] = false
							TriggerClientEvent("player:syncHoodOptions",source,Network,"close")
							vRPC._stopAnim(source,false)
							--if vRP.Task(source,3,1000) then
								if vRP.TakeItem(Passport,Full,1,true,Slot) then
									local Players = vRPC.Players(source)
									for _,v in ipairs(Players) do
										async(function()
											TriggerClientEvent("inventory:repairVehicle",v,Network,Plate)
										end)
									end

									local Number = parseInt(Split[2]) - 1

									if Number >= 1 then
										vRP.GiveItem(Passport,"advtoolbox-"..Number,1,false)
									end
								end
							--end
						end
                    end)
				end
			end
		end
	end,

	["creator"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.Request(source,"Você quer iniciar a criação?","Sim, por favor","Não, obrigado") then
			if vRP.TakeItem(Passport,Full,1) then
				local Ped = GetPlayerPed(source)
				if Ped ~= 0 and DoesEntityExist(Ped) then
					local Coords = GetEntityCoords(Ped)

					vRP.Teleport(source,Coords.x,Coords.y,Coords.z -1)
					TriggerClientEvent("inventory:Close",source)
					TriggerClientEvent("barbershop:Open",source,"open")
				end
			end
		end
	end,

	["toolbox"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if not vRP.HasGroup(Passport, "Mechanic", 5) then
            TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para fazer isso.",5000,"MECANICA")
			-- TriggerClientEvent("Notify2",source,"#noPermissionMec")
            return
        end
		if not vRP.InsideVehicle(source) then
			local Vehicle,Network,Plate = vRPC.VehicleList(source,4)
			if Vehicle then
				vRPC.AnimActive(source)
				Active[Passport] = os.time() + 100
				Player(source)["state"]["Buttons"] = true
				TriggerClientEvent("inventory:Close",source)
				TriggerClientEvent("player:syncHoodOptions",source,Network,"open")
                TriggerClientEvent("Progress",source,"Aplicando",100000)
				vRPC._playAnim(source,true,{"mini@repair","fixing_a_player"},true)

                SetTimeout(100000,function()
					if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
						Active[Passport] = nil
						Player(source)["state"]["Buttons"] = false
						TriggerClientEvent("player:syncHoodOptions",source,Network,"close")
						vRPC._stopAnim(source,false)
						--if vRP.Task(source,3,1000) then
							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _,v in ipairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairVehicle",v,Network,Plate)
									end)
								end
							end
						--end
					end
                end)
			end
		end
	end,

	["lockpick"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        local Ped = GetPlayerPed(source)
        if SafeMode == "true" then
            if GlobalState["WarMode"] and Ped then
                if not Entity(Ped)["state"]["WarMode"] then
                    TriggerClientEvent("Notify",source,"vermelho","Você não pode usar esse item fora do <b>Modo Guerra</b>.",5000,"Lockpick")
					-- TriggerClientEvent("Notify2",source,"#cannotUseItemLP")
                    return
                end
            end
        end
        if not Player(source)["state"]["Handcuff"] or not Player(source)["state"]["InSafeZone"] or not Player(source)["state"]["PVP"] or not Player(source)["state"]["inSafeMode"] or not Player(source)["state"]["GreenMode"] then
            local Vehicle,Network,Plate,vehName,vehClass = vRPC.VehicleList(source,4)
            if Vehicle then
                local Brokenpick = 950
                if vehClass == 15 or vehClass == 16 or vehClass == 19 then
                    return
                end

                if not vRP.InsideVehicle(source) then
                    vRPC.AnimActive(source)
                    Active[Passport] = os.time() + 100
                    Player(source)["state"]["Buttons"] = true
                    TriggerClientEvent("inventory:Close",source)
                    vRPC._playAnim(source,true,{"missfbi_s4mop","clean_mop_back_player"},true)

                    if string.sub(Plate,1,4) == "DISM" then
                        if vRP.Task(source,10,1000) then
                            Brokenpick = 900
                            Active[Passport] = os.time() + 30
                            TriggerClientEvent("inventory:DisPed",source)
                            TriggerClientEvent("Progress",source,"Usando",30000)
                            vRP.TakeItem(Passport,Full,1,true,Slot)

                            if math.random(100) >= 25 then
                                local Coords = vRP.GetEntityCoords(source)
                                local Service = vRP.NumPermission("Policia")
                                for Passports,Sources in pairs(Service) do
                                    async(function()
                                        TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "155", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(vehName).." - "..Plate, blipColor = 44 })
                                    end)
                                end
                            end

                            SetTimeout(30000,function()
								if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
									Active[Passport] = nil

									TriggerEvent("plateEveryone",Plate)
									TriggerClientEvent("target:Dismantles",source)
									TriggerClientEvent("inventory:vehicleAlarm",source,Network,Plate)

									local Network = NetworkGetEntityFromNetworkId(Network)
									if GetVehicleDoorLockStatus(Network) == 2 then
										SetVehicleDoorsLocked(Network,1)
									end
								end
                            end)
                        else
                            TriggerClientEvent("Notify",source,"vermelho","Você errou sua anta.",5000)
							-- TriggerClientEvent("Notify2",source,"#youMissed")
                        end
                    else
                        if vRP.Task(source,3,1000) then
                            Brokenpick = 100

                            TriggerEvent("plateEveryone",Plate)
                            TriggerClientEvent("inventory:vehicleAlarm",source,Network,Plate)
                            vRP.TakeItem(Passport,Full,1,true,Slot)
                            
                            local Network = NetworkGetEntityFromNetworkId(Network)
                            if GetVehicleDoorLockStatus(Network) == 2 then
                                SetVehicleDoorsLocked(Network,1)
                            end

                            if math.random(100) >= 25 then
                                local Coords = vRP.GetEntityCoords(source)
                                local Service = vRP.NumPermission("Policia")
                                if Coords["x"] and Coords["y"] and Coords["z"] and VehicleName(vehName) and Plate then
                                    for Passports,Sources in pairs(Service) do
                                        async(function()
                                            TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "155", x = Coords["x"], y = Coords["y"], z = Coords["z"], vehicle = VehicleName(vehName).." - "..Plate, blipColor = 44 })
                                            exports["vrp"]:SendWebHook("lockpick","**Passaporte:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Roubou:** "..vehName.." \n**Placa:** "..Plate.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                                        end)
                                    end
                                end
                            end
                        else
                            TriggerClientEvent("Notify",source,"vermelho","Você errou sua anta.",5000)
							-- TriggerClientEvent("Notify2",source,"#youMissed")
                        end
                    end

                    if math.random(1000) >= Brokenpick then
                        if vRP.TakeItem(Passport,Full,1,false) then
                            vRP.GiveItem(Passport,"lockpick-0",1,false)
                            TriggerClientEvent("itensNotify",source,{ "broke","lockpick",1,"Lockpick de Alumínio" })
                        end
                    end

                    Player(source)["state"]["Buttons"] = false
                    vRPC._stopAnim(source,false)
                    Active[Passport] = nil
                end
            else
                local Ped = GetPlayerPed(source)
                if Ped ~= 0 and DoesEntityExist(Ped) then
                    local Coords = GetEntityCoords(Ped)
                    local Name = GetNearestHouse(Coords)

                    if Name then
                        vRPC._playAnim(source,true,{"missheistfbi3b_ig7","lift_fibagent_loop"},false)

                        if vRP.Task(source,10,1000) then
                            if not Property[Name] then
                                local Consult = vRP.Query("propertys/Exist",{ name = Name })
                                if Consult[1] then
                                    Property[Name] = Consult[1]["Interior"]
                                else
                                    local Randomize = math.random(#Interiors)
                                    Property[Name] = Interiors[Randomize]
                                end
                            end

                            TriggerClientEvent("propertys:Enter",source,Name,Property[Name])
                        else
                            if math.random(100) >= 75 then
                                local Service = vRP.NumPermission("Policia")
                                for Passports,Sources in pairs(Service) do
                                    async(function()
                                        TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "150", x = Coords["x"], y = Coords["y"], z = Coords["z"], blipColor = 44 })
                                    end)
                                end
                            end
                        end
                        vRPC._stopAnim(source,false)
                    end
                end
            end
        end
	end,

	["blocksignal"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not Player(source)["state"]["Handcuff"] then
			local Vehicle,Network,Plate = vRPC.VehicleList(source,4)
			if Vehicle and vRP.InsideVehicle(source) then
				if not exports["garages"]:Signal(Plate) then
					vRPC.AnimActive(source)
					Active[Passport] = os.time() + 100
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("inventory:Close",source)

					if vRP.Task(source,3,1000) then
						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							TriggerClientEvent("Notify",source,"verde","<b>Bloqueador de Sinal</b> instalado.",5000)
							-- TriggerClientEvent("Notify2",source,"#signalBlockerInstalled")
							TriggerEvent("signalRemove",Plate)
						end
					end

					Player(source)["state"]["Buttons"] = false
					Active[Passport] = nil
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Bloqueador de Sinal</b> já instalado.",5000)
					-- TriggerClientEvent("Notify2",source,"#signalBlockerAlreadyInstalled")
				end
			end
		end
	end,

	["postit"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("postit:initPostit",source)
	end,

	["dismantle"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vCLIENT.DismantleStatus(source) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				TriggerClientEvent("inventory:Close",source)

				Dismantle[Passport] = vRP.GetExperience(Passport,"Dismantle")
				if math.random(100) <= 15 then
					Dismantle[Passport] = math.random(1000)
				end

				vCLIENT.Dismantle(source,Dismantle[Passport])
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Você possui um contrato ativo.",5000)
			-- TriggerClientEvent("Notify2",source,"#uHaveActiveContract")
		end
	end,

	["scanner"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Scanners[Passport] = true
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("inventory:updateScanner",source,true)
		vRPC._CreateObjects(source,"mini@golfai","wood_idle_a","w_am_digiscanner",49,18905,0.15,0.1,0.0,-270.0,-180.0,-170.0)
	end,

	-- BEBIDAS ALCOOLICAS
	["absolut"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
        vRPC._CreateObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_vodka_bottle",49,28422,0.0,0.0,-0.18,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeHunger(Passport,10)
					vRP.DowngradeThirst(Passport,10)
					vRP.AlcoholTimer(Passport,1)
					TriggerClientEvent("setDrunkTime",source,90)
				end
			end
		end)
	end,

	["hennessy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
        vRPC._CreateObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_bottle_richard",49,28422,0.0,0.0,-0.18,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeHunger(Passport,10)
					vRP.DowngradeThirst(Passport,10)
					vRP.AlcoholTimer(Passport,1)
					TriggerClientEvent("setDrunkTime",source,90)
				end
			end
		end)
	end,

	["chandon"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
        vRPC._CreateObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_champ_01a",49,28422,0.0,0.0,-0.18,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeHunger(Passport,10)
					vRP.DowngradeThirst(Passport,10)
					vRP.AlcoholTimer(Passport,1)
					TriggerClientEvent("setDrunkTime",source,90)
				end
			end
		end)
	end,

	["dewars"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
        vRPC._CreateObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_bottle_brandy",49,28422,0.0,0.0,-0.18,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeHunger(Passport,10)
					vRP.DowngradeThirst(Passport,10)
					vRP.AlcoholTimer(Passport,1)
					TriggerClientEvent("setDrunkTime",source,90)
				end
			end
		end)
	end,

	["sinkalmy"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","prop_cs_script_bottle",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeHunger(Passport,5)
					vRP.DowngradeThirst(Passport,5)
					vRP.ChemicalTimer(Passport,3)
				end
			end
		end)
	end,

	["ritmoneury"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","prop_cs_script_bottle",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.DowngradeHunger(Passport,5)
					vRP.DowngradeThirst(Passport,5)
					vRP.ChemicalTimer(Passport,3)
				end
			end
		end)
	end,

	-- BEBIDAS NORMAIS
	["orangejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_sucodelaranja",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,15)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["passionjuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_sucodelaranja",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,15)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["tangejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_sucodelaranja",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,15)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["grapejuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_sucodelaranja",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,15)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["strawberryjuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_sucodelaranja",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,15)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["bananajuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_sucodelaranja",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,15)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["acerolajuice"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_sucodelaranja",49,60309,0.0,0.0,0.06,0.0,0.0,130.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,15)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["water"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,10)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["milkbottle"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
        vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0)

		SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,10)
					vRP.GenerateItem(Passport,"emptybottle",1)
				end
			end
		end)
	end,

	["guarananatural"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"amb@world_human_drinking@coffee@male@idle_a","idle_c","prop_food_bs_juice02",49,28422,0.0,-0.01,-0.15,0.0,0.0,0.0)

		SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,10)
				end
			end
		end)
	end,

	["energetic"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","prop_energy_drink",49,60309,0.0,0.0,0.0,0.0,0.0,130.0)

		SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					TriggerClientEvent("setEnergetic",source,120,1.30)
				end
			end
		end)
	end,

	["cola"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_cocacola",49,60309,0.01,0.01,0.05,0.0,0.0,90.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,10)
				end
			end
		end)
	end,

	["soda"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
        vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","ng_proc_sodacan_01b",49,60309,0.01,0.01,-0.05,0.0,0.0,90.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,10)
				end
			end
		end)
	end,

	["coffeemilk"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
        vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_frapuccino",49,60309,0.01,0.01,0.05,0.0,0.0,90.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,10)
				end
			end
		end)
	end,

	["cannedsoup"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",10000)
		vRPC._CreateObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","v_res_fa_potnoodle",49,28422,0.0,0.0,0.06,0.0,0.0,130.0)

		SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
					vRP.UpgradeThirst(Passport,5)
				end
			end
		end)
	end,

	["canofbeans"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",10000)
		vRPC._CreateObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","v_res_fa_potnoodle",49,28422,0.0,0.0,0.06,0.0,0.0,130.0)

		SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
					vRP.UpgradeThirst(Passport,5)
				end
			end
		end)
	end,

	["milkshake"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",10000)
        vRPC._CreateObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","bebida_milkshake",49,28422,0.0,0.0,-0.06,0.0,0.0,130.0)

		SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
					vRP.UpgradeThirst(Passport,5)
				end
			end
		end)
	end,

	["cappuccino"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Tomando",10000)
        vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","bebida_frapuccino",49,60309,0.01,0.01,0.05,0.0,0.0,90.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
					vRP.UpgradeThirst(Passport,10)
				end
			end
		end)
	end,

	["coffee"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Bebendo",10000)
		vRPC._CreateObjects(source,"mp_player_intdrink","loop_bottle","prop_fib_coffee",49,60309,0.01,0.01,0.05,0.0,0.0,90.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeThirst(Passport,10)
				end
			end
		end)
	end,

	-- COMIDAS
	["orange"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_laranja",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["apple"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_maca",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["strawberry"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_morango",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["grape"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_laranja",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["tange"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_laranja",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["banana"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_banana",49,60309,0.0,0.0,0.0,-90.0,0.0,90.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["acerola"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_morango",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["passion"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_morango",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["tomato"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_morango",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["guarana"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_morango",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["pizzamozzarella"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_pizza",49,60309,0.0,0.0,0.0,150.0,150.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["pizzamushroom"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_pizza",49,60309,0.0,0.0,0.0,150.0,150.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["pizzabanana"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_pizza",49,60309,0.0,0.0,0.0,150.0,150.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["pizzachocolate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_pizza",49,60309,0.0,0.0,0.0,150.0,150.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["sushi"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_kiwi",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["nigirizushi"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_kiwi",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["calzone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_pizza",49,60309,0.0,0.0,0.0,150.0,150.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["chickenfries"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_coxinha",49,60309,0.0,0.0,0.0,150.0,150.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["cookies"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_cookie",49,60309,0.0,0.0,0.0,150.0,150.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["onionrings"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_cookie",49,60309,0.0,0.0,0.0,150.0,150.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["hamburger"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["hamburger2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["cookedfishfillet"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["hotdog"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_hotdog_01",49,60309,0.0,0.0,0.0,0.0,0.0,90.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["sandwich"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_sandwich_01",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["tacos"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","comida_taco",49,60309,0.0,0.0,0.0,0.0,0.0,90.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["fries"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_food_bs_chips",49,60309,0.06,0.0,0.0,0.0,250.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["applelove"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","fruta_maca",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["cupcake"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","doce_cupcake",49,60309,0.0,0.0,-0.02,45.0,-45.0,0.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["marshmallow"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","doce_brigadeiro",49,60309,0.0,0.0,-0.02,45.0,-45.0,180.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,15)
				end
			end
		end)
	end,

	["chocolate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","doce_chocolate",49,60309,0.0,0.0,-0.02,0.0,0.0,270.0)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,

	["donut"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		vRPC.AnimActive(source)
		Active[Passport] = os.time() + 10
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("Progress",source,"Comendo",10000)
		vRPC._CreateObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_amb_donut",49,60309)

        SetTimeout(10000,function()
			if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
				Active[Passport] = nil
				vRPC._DestroyObjects(source,"one")
				Player(source)["state"]["Buttons"] = false

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					vRP.UpgradeHunger(Passport,20)
				end
			end
		end)
	end,
	
	["prisaorem"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            TriggerEvent("mdt:RemovePrison",Passport)
        end
	end,

	["advrem"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            TriggerEvent("Admin:Unban",source)
        end
	end,

	--[[ ["fishingrod"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vCLIENT.fishingCoords(source) then
			Active[Passport] = os.time() + 100
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)

			if not vCLIENT.fishingAnim(source) then
				vRPC.AnimActive(source)
                vRPC._playAnim(source,true,{"amb@world_human_stand_fishing@idle_a","idle_c"},false)
			end

			--if vRP.Task(source,3,15000) then
				local Members = exports["party"]:Room(Passport,source,10)
				local fishList = { "octopus","shrimp","carp","horsefish","tilapia","codfish","catfish" }

				if parseInt(#Members) >= 4 then
					fishList = { "octopus","shrimp","carp","horsefish","tilapia","codfish","catfish","goldenfish","pirarucu","pacu","tambaqui" }
				end

				local fishRandom = math.random(#fishList)
				local fishSelects = fishList[fishRandom]

				if (vRP.InventoryWeight(Passport) + itemWeight(fishSelects)) <= vRP.GetWeight(Passport) then
					if vRP.TakeItem(Passport,"bait",1,false) then
						vRP.GenerateItem(Passport,fishSelects,1,true)
					else
						TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("bait").."</b>.",5000)
						-- TriggerClientEvent("Notify2",source,"#precisaGauze",{msg=itemName("bait")})
					end
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					-- TriggerClientEvent("Notify2",source,"#mochilaFull")
				end
			--end

			Player(source)["state"]["Buttons"] = false
			Active[Passport] = nil
		end
	end, ]]

	["tablecoke"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_coke_table01a"
		local application,Coords,heading = vRPC.objectCoords(source,Hash)
		if application then
			if not vCLIENT.objectExist(source,Coords,Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					--Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = heading, object = Hash, item = Full, Distance = 50, mode = "1" }
					--TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["tablemeth"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_meth_table01a"
		local Application,Coords,heading = vRPC.objectCoords(source,Hash)
		if Application then
			if not vCLIENT.objectExist(source,Coords,Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					--Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "1" }
					--TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["tableweed"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_table_01a"
		local application,Coords,heading = vRPC.objectCoords(source,Hash)
		if application then
			if not vCLIENT.objectExist(source,Coords,Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					-- Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "1" }
					-- TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["sprays01"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "spray_01"
		local Application,Coords,Heading = vRPC.objectCoords(source,Hash)
		if Application then
			vRPC.AnimActive(source)
			Active[Passport] = os.time() + 5
			Player(source)["state"]["Buttons"] = true
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("Progress",source,"Pichando",5000)
            vRPC._playAnim(source,true,{"switch@franklin@lamar_tagging_wall","lamar_tagging_exit_loop_lamar"},false)

			SetTimeout(5000,function()
				if Active[Passport] and os.time() >= parseInt(Active[Passport]) then
					Active[Passport] = nil
					vRPC._stopAnim(source,false)

					if vRP.TakeItem(Passport,Full,1,true,Slot) then
						local Number = 0

						repeat
							Number = Number + 1
						until not Objects[tostring(Number)]

						Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(Heading), object = Hash, item = Full, Distance = 100, mode = "Spray" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
					end
				end
			end)
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["campfire"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_beach_fire"
		local application,Coords,heading = vRPC.objectCoords(source,Hash)
		if application then
			if not vCLIENT.objectExist(source,Coords,Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]) + 0.10, h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "2" }
					TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["barrier"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_mp_barrier_02b"
		local application,Coords,heading = vRPC.objectCoords(source,Hash)
		if application then
			if not vCLIENT.objectExist(source,Coords,Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 100, mode = "3" }
					TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["medicbag"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "xm_prop_x17_bag_med_01a"
		local application,Coords,heading = vRPC.objectCoords(source,Hash)
		if application then
			if not vCLIENT.objectExist(source,Coords,Hash) then
				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					-- Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(heading), object = Hash, item = Full, Distance = 50, mode = "4" }
					-- TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["weedclone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "bkr_prop_weed_med_01a"
		local Application,Coords = vRPC.objectCoords(source,Hash)
		if Application then
			if not vCLIENT.objectExist(source,Coords,Hash) then
				if vRP.TakeItem(Passport,Full,1,false,Slot) then
					vRPC._playAnim(source,true,{"amb@prop_human_bum_bin@base","base"},true)

					if vRP.Task(source,5,750) then
						local Points = 0
						local Route = GetPlayerRoutingBucket(source)

						if Split[2] ~= nil then
							Points = parseInt(Split[2])
						end

						exports["plants"]:Plants(Coords,Route,Points)
					end

					vRPC._stopAnim(source,false)
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["medicbed"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "prop_ld_binbag_01"
		local application,Coords,heading = vRPC.objectCoords(source,Hash)
		if application then
			if not vCLIENT.objectExist(source,Coords,Hash) then
				local mHash = GetHashKey(Hash)
				local Object = CreateObject(mHash,Coords["x"],Coords["y"],Coords["z"] - 0.86,true,true,false)

				while not DoesEntityExist(Object) do
					Wait(1)
				end

				if DoesEntityExist(Object) then
					SetEntityHeading(Object,heading)
					FreezeEntityPosition(Object,true)
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["c4"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Hash = "ch_prop_ch_ld_bomb_01a"
		local Application,Coords,Heading = vRPC.objectCoords(source,Hash)
		if Application then
			local CoordsAtm,NumberAtm = vCLIENT.checkAtm(source,Coords)

			if CoordsAtm then
				if not atmTimers[NumberAtm] then
					atmTimers[NumberAtm] = os.time()
				end

				if os.time() < atmTimers[NumberAtm] then
					local Cooldown = parseInt(atmTimers[NumberAtm] - os.time())
					TriggerClientEvent("Notify",source,"azul","Policiais insuficientes.",5000)
					-- TriggerClientEvent("Notify2",source,"#notEnoughPolice")
					Player(source)["state"]["Buttons"] = false

					return
				end

				local Service,Total = vRP.NumPermission("Policia")
				if Total <= 5 then
					TriggerClientEvent("Notify",source,"azul","Policiais insuficientes.",5000)
					-- TriggerClientEvent("Notify2",source,"#notEnoughPolice")
					Player(source)["state"]["Buttons"] = false

					return
				end

				if vRP.TakeItem(Passport,Full,1,true,Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until not Objects[tostring(Number)]

					Objects[tostring(Number)] = { x = mathLength(Coords["x"]), y = mathLength(Coords["y"]), z = mathLength(Coords["z"]), h = mathLength(Heading), object = Hash, item = Full, Distance = 100 }
					TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
					TriggerClientEvent("Progress",source,"Plantando",25000)
					atmTimers[NumberAtm] = os.time() + 18000
					local explosionProgress = 25

					for Passports,Sources in pairs(Service) do
						async(function()
							-- vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush",Sources,{ code = "QRU", title = "157", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Alarme de segurança", blipColor = 16 })
						end)
					end

					repeat
						Wait(1000)
						explosionProgress = explosionProgress - 1
					until explosionProgress <= 0

					Inventory.DropServer(CoordsAtm,"dollars",math.random(45000,50000))
					TriggerClientEvent("player:Residuals",source,"Resíduo de Explosivo.")

					local Players = vRPC.Players(source)
					for _,v in ipairs(Players) do
						async(function()
							TriggerClientEvent("objects:Remover",v,tostring(Number))
						end)
					end

					TriggerClientEvent("vRP:Explosion",source,Coords)
					TriggerEvent("Wanted",source,Passport,600)
				end
			end
		end

		Player(source)["state"]["Buttons"] = false
	end,

	["carp"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	["codfish"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	["catfish"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	["goldenfish"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	["horsefish"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	["tilapia"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	["pacu"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	["pirarucu"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	["tambaqui"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if (vRP.InventoryWeight(Passport) + itemWeight("fishfillet") * 2) <= vRP.GetWeight(Passport) then
			if vRP.TakeItem(Passport,Full,1,true,Slot) then
				vRP.GenerateItem(Passport,"fishfillet",2)
                TriggerClientEvent("inventory:HasToUpdate",source)
				TriggerClientEvent("inventory:Update",source,"Backpack")
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			-- TriggerClientEvent("Notify2",source,"#mochilaFull")
		end
	end,

	--[[ ["notepad"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		Active[Passport] = os.time() + 100
		Player(source)["state"]["Buttons"] = true
		TriggerClientEvent("inventory:Close",source)

		local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
		if Keyboard then
			if vRP.TakeItem(Passport,Full,1,false,Slot) then
				if Split[2] then
					vRP.SetSrvData(Full,Keyboard[1])
					vRP.GenerateItem(Passport,Full,1,false)
				else
					local Time = os.time()
					vRP.SetSrvData("notepad-"..Time,Keyboard[1])
					vRP.GenerateItem(Passport,"notepad-"..Time,1,false)
				end
			end

			TriggerClientEvent("inventory:Update",source,"Backpack")
		end

		Player(source)["state"]["Buttons"] = false
		Active[Passport] = nil
	end, ]]

	["megaphone"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            local Keyboard = vKEYBOARD.keySingle(source,"Mensagem:")
            local Identity = vRP.Identity(Passport)
            if Keyboard and Keyboard[1] then
                local Name = Identity["name"].." "..Identity["name2"]
                TriggerClientEvent("chat:ClientMessage",-1,Name,Keyboard[1],"📢 Megaphone",true)
            end
        end
	end,

	["notebook"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("notebook:openSystem",source)
	end,

	["tyres"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRP.InsideVehicle(source) then
			if not vCLIENT.checkWeapon(source,"WEAPON_WRENCH") then
				TriggerClientEvent("Notify",source,"amarelo","<b>Chave Inglesa</b> não encontrada.",5000)
				-- TriggerClientEvent("Notify2",source,"#spannerNotFound")
				return
			end

			local tyreStatus,Tyre,Network,Plate = vCLIENT.tyreStatus(source)
			if tyreStatus then
				local Vehicle = NetworkGetEntityFromNetworkId(Network)
				if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
					if vCLIENT.tyreHealth(source,Network,Tyre) ~= 1000.0 then
						vRPC.AnimActive(source)
						Active[Passport] = os.time() + 100
						Player(source)["state"]["Buttons"] = true
						TriggerClientEvent("inventory:Close",source)
						vRPC._playAnim(source,true,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

						if vRP.Task(source,3,1000) then
							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								local Players = vRPC.Players(source)
								for _,v in ipairs(Players) do
									async(function()
										TriggerClientEvent("inventory:repairTyre",v,Network,Tyre,Plate)
									end)
								end
							end
						end

						Player(source)["state"]["Buttons"] = false
						vRPC._stopAnim(source,false)
						Active[Passport] = nil
					end
				end
			end
		end
	end,

	["premiumplate"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.InsideVehicle(source) then
			TriggerClientEvent("inventory:Close",source)

			local vehModel = vRPC.VehicleName(source)
			local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehModel })
			if vehicle[1] then
				local Keyboard = vKEYBOARD.keySingle(source,"Placa: (8 Caracteres)")
				if Keyboard then
					local namePlate = string.sub(Keyboard[1],1,8)
					local plateCheck = sanitizeString(namePlate,"abcdefghijklmnopqrstuvwxyz0123456789",true)

					if string.len(plateCheck) ~= 8 then
						TriggerClientEvent("Notify",source,"amarelo","O nome de definição para a placa inválida.",5000)
						-- TriggerClientEvent("Notify2",source,"#invalidPlateName")
						return
					else
						if vRP.PassportPlate(namePlate) then
                            PassportPlate =  {Passport = PassportPlate }
							TriggerClientEvent("Notify",source,"vermelho","A placa escolhida já possui em outro veículo.",5000)
							-- TriggerClientEvent("Notify2",source,"#plateUsed")
							return
						else
                            local Query = vRP.Query("vehicles/plateVehiclesId",{ plate = string.upper(namePlate) })
                            if Query and Query[1] then
                                TriggerClientEvent("Notify",source,"vermelho","A placa escolhida já possui em outro veículo.",5000)
								-- TriggerClientEvent("Notify2",source,"#plateUsed")
                                return
                            end
							if vRP.TakeItem(Passport,Full,1,true,Slot) then
								vRP.Query("vehicles/plateVehiclesUpdate",{ Passport = Passport, vehicle = vehModel, plate = string.upper(namePlate) })
								TriggerClientEvent("Notify",source,"verde","Placa atualizada.",5000)
								-- TriggerClientEvent("Notify2",source,"#plateAtt")
							end
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Modelo de veículo não encontrado.",5000)
				-- TriggerClientEvent("Notify2",source,"#veicModelNotFound")
			end
		end
	end,

	["radio"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("radio:RadioNui",source)
		vRPC.AnimActive(source)
	end,

	["scuba"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		TriggerClientEvent("hud:Scuba",source)
	end,

	["handcuff"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if not vRP.InsideVehicle(source) and not Player(source)["state"]["InSafeZone"] and not Player(source)["state"]["PVP"] and not Player(source)["state"]["Newbie"] then
			local ClosestPed = vRPC.ClosestPed(source,1)
			if ClosestPed and not Player(ClosestPed)["state"]["inSafeMode"] and not Player(ClosestPed)["state"]["InSafeZone"] and not Player(source)["state"]["PVP"] and not Player(ClosestPed)["state"]["GreenMode"] then
				Player(source)["state"]["Cancel"] = true
				Player(source)["state"]["Buttons"] = true

				if Player(ClosestPed)["state"]["Handcuff"] then
					Player(ClosestPed)["state"]["Handcuff"] = false
					Player(ClosestPed)["state"]["Commands"] = false
					TriggerClientEvent("sounds:Private",source,"uncuff",0.5)
					TriggerClientEvent("sounds:Private",ClosestPed,"uncuff",0.5)

					vRPC._DestroyObjects(ClosestPed)
				else
					TriggerClientEvent("hud:RadioClean",ClosestPed)
					TriggerClientEvent("player:playerCarry",ClosestPed,source,"handcuff")
					vRPC._playAnim(source,true,{"mp_arrest_paired","cop_p2_back_left"},false)
					vRPC._playAnim(ClosestPed,false,{"mp_arrest_paired","crook_p2_back_left"},false)

					Wait(3500)

					vRPC._stopAnim(source,false)
					Player(ClosestPed)["state"]["Handcuff"] = true
					Player(ClosestPed)["state"]["Commands"] = true
					TriggerClientEvent("inventory:Close",ClosestPed)
					TriggerClientEvent("sounds:Private",source,"cuff",0.5)
					TriggerClientEvent("sounds:Private",ClosestPed,"cuff",0.5)
					TriggerClientEvent("player:playerCarry",ClosestPed,source)
				end

				Player(source)["state"]["Cancel"] = false
				Player(source)["state"]["Buttons"] = false
			end
		end
	end,

	["hood"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			if Player(ClosestPed)["state"]["Handcuff"] then
				TriggerClientEvent("hud:toggleHood",ClosestPed)
				TriggerClientEvent("inventory:Close",ClosestPed)
                TriggerClientEvent("Notify",source,"verde","O Capuz foi utilizado.",5000,"CAPUZ")
				-- TriggerClientEvent("Notify2",source,"#hoodUsed")
            else
                TriggerClientEvent("Notify",source,"vermelho","A pessoa não está algemada.",5000,"CAPUZ")
				-- TriggerClientEvent("Notify2",source,"#notHandcuffed")
			end
		end
	end,

	["rolepass"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            vRP.Query("battlepass/givePremium",{ Passport = parseInt(Passport)})
            TriggerEvent("UpdatePlayerPass",Passport)
        end
	end,

	["money1"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','Money1', Passport) then
                vRP.GenerateItem(Passport,"dollars",50000000)
            end
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["money2"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','Money2', Passport) then
                vRP.GenerateItem(Passport,"dollars",25000000)
            end
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["money3"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','Money3', Passport) then
                vRP.GenerateItem(Passport,"dollars",10000000)
            end
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["money4"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','Money4', Passport) then
                vRP.GenerateItem(Passport,"dollars",1000000)
            end
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["money5"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','Money5', Passport) then
                vRP.GenerateItem(Passport,"dollars",10000000)
            end
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["packbasic"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','PackBasic', Passport, source) then
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",400)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",400)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",4000)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",100000)
                vRP.GenerateItem(Passport,"c4",40)
            end

			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["packelite"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','PackElite', Passport, source) then
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",600)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",600)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",6000)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",150000)
                vRP.GenerateItem(Passport,"c4",60)
            end

			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["packpremium"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','PackPremium', Passport, source) then
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",800)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",800)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",8000)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",200000)
                vRP.GenerateItem(Passport,"c4",80)
            end
 
			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["kitfogueteiro"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','KitFogueteiro', Passport, source) then
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",100)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",50)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",50)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",15000)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",15000)
            end
			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["kitcriminal"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','KitCriminal', Passport, source) then
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",75)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",75)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",150)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",25000)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",25000)
            end
			-- vRP.GenerateItem(Passport,"cocaine",900)
			-- vRP.GenerateItem(Passport,"joint",900)

			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["kitmafioso"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','KitMafioso', Passport, source) then
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",125)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",125)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",250)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",25000)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",25000)
            end
			-- vRP.GenerateItem(Passport,"cocaine",900)
			-- vRP.GenerateItem(Passport,"joint",900)

			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["kitdosraul"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','KitDosRaul', Passport, source) then
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",175)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",175)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",375)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",30000)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",30000)
            end
			-- vRP.GenerateItem(Passport,"cocaine",1050)
			-- vRP.GenerateItem(Passport,"joint",1050)

			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	["norrisgay"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            -- PASSPORT,GRUPO,LEVEL,false,false,TEMPO ( SE N TIVER TEMPO SO DEIXAR FALSE)
            vRP.SetPermission(Passport,"GRUPO",1,false,false,3)
        end
	end,

	["changesexm"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            vRP.SkinCharacter(Passport,"mp_m_freemode_01")
            vRPC.Skin(source,"mp_m_freemode_01")
        end
	end,
    
	["changesexf"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            vRP.SkinCharacter(Passport,"mp_f_freemode_01")
            vRPC.Skin(source,"mp_f_freemode_01")
        end
	end,

	["kitboqueta"] = function(source,Passport,Amount,Slot,Full,Item,Split)
        if vRP.TakeItem(Passport,Full,1,true,Slot) then
            if not exports['variables']:GetVariable('functions','KitBoqueta', Passport, source) then
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",25000)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",25000)
                -- vRP.GenerateItem(Passport,"cocaine",1000)
                -- vRP.GenerateItem(Passport,"joint",1000)
            end
			TriggerClientEvent("inventory:Update",source,"Backpack")
        end
	end,

	--[[ ["premium01"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			local Model = "por718gt4"
			local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Model })
			if not Vehicle[1] then
				vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Model, plate = vRP.GeneratePlate(), work = "false" })
			end

			local Model = "bmci"
			local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Model })
			if not Vehicle[1] then
				vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Model, plate = vRP.GeneratePlate(), work = "false" })
			end

			vRP.GenerateItem(Passport,"dollars",6000000)
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
			TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
			-- TriggerClientEvent("Notify2",source,"#itemUsed",{msg=itemName(Full)})

			TriggerClientEvent("inventory:Update",source,"Backpack")
			TriggerEvent("Salary:Add",Passport,"Premium")
			vRP.SetPermission(Passport,"Premium",1)
			vRP.SetPermission(Passport,"Spotify",1)
			vRP.SetPremium(source)
		end
	end, ]]

	--[[ ["premium02"] = function(source,Passport,Amount,Slot,Full,Item,Split) -- vip policia
		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			local Model = "a45policia"
			local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Model })
			if not Vehicle[1] then
				vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Model, plate = vRP.GeneratePlate(), work = "false" })
			end

			vRP.GenerateItem(Passport,"dollars",2000000)
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
			TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
			-- TriggerClientEvent("Notify2",source,"#itemUsed",{msg=itemName(Full)})

			TriggerClientEvent("inventory:Update",source,"Backpack")
			TriggerEvent("Salary:Add",Passport,"Premium")
			vRP.SetPermission(Passport,"Premium",2)
			vRP.SetPremium(source)
		end
	end, ]]

	["premium03"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			-- local Model = "m2f22"
			-- local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Model })
			-- if not Vehicle[1] then
			-- 	vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Model, plate = vRP.GeneratePlate(), work = "false" })
			-- end
            if not exports['variables']:GetVariable('functions','Premium03', Passport, source) then
                vRP.GenerateItem(Passport,"dollars",10000000)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",50)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",50)
                vRP.GenerateItem(Passport,"vest",100)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",5000)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",5000)

                TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
                -- TriggerClientEvent("Notify2",source,"#itemUsed",{msg=itemName(Full)})
                --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
                TriggerClientEvent("inventory:Update",source,"Backpack")
                ExecuteCommand("SetVehicles "..Passport.." 1 Lendário rmodp1gtr,oycdefender,mercedesgt63,taycan,r1250,x6mf16,audir8,cbr,bm422pxx2ncs,mercedesg65,mclarensenna,terzo,lancerevolution9,rs6avant20,rvgxrx7,urus,nissangtr3,skyliner34")
                ExecuteCommand("SetVehicles "..Passport.." 1 Vip saveirog7,kiagt,civictyper,mazdarx7,acuransx,nissangtrnismo,c63,nissangtr,marshall,skyliner34,lancerevolutionx,subaruimpreza,teslamodels,lamborghinihuracanlw,675ltsp,porsche911,bmwm1wb,rmodgt63mini,SC18Hartge,tesroad20,toyotasupra2,rangerover,golfgti,lx2018,corvettec7,f800,160,xj6,hornet,mp412c,lancerevolution9,rmodm4,nissangtr,fordmustang,bnr34")
                vRP.SetPermission(Passport,"Ouro",1)
                vRP.SetPermission(Passport,"Spotify",1)
                vRP.SetPermission(Passport,"Roupas2",1)
            end
			vRP.SetPremium(source)
		end
	end,

	["vipsorteio"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			-- local Model = "m2f22"
			-- local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Model })
			-- if not Vehicle[1] then
			-- 	vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Model, plate = vRP.GeneratePlate(), work = "false" })
			-- end

			-- vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",50)
			-- vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",50)
			-- vRP.GenerateItem(Passport,"vest",100)
			-- vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",5000)
			-- vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",5000)
            if not exports['variables']:GetVariable('functions','VipSorteio', Passport, source) then
                TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
                TriggerClientEvent("inventory:Update",source,"Backpack")
                ExecuteCommand("SetVehicles "..Passport.." 1 Vip saveirog7,kiagt,civictyper,mazdarx7,acuransx,nissangtrnismo,c63,nissangtr,marshall,skyliner34,lancerevolutionx,subaruimpreza,teslamodels,lamborghinihuracanlw,675ltsp,porsche911,bmwm1wb,rmodgt63mini,SC18Hartge,tesroad20,toyotasupra2,rangerover,golfgti,lx2018,corvettec7,f800,160,xj6,hornet,mp412c,lancerevolution9,rmodm4,nissangtr,fordmustang,bnr34")
                vRP.SetPermission(Passport,"VipSorteio",1)
                vRP.SetPermission(Passport,"Spotify",1)
                vRP.SetPermission(Passport,"Roupas2",1)
            end
			vRP.SetPremium(source)
			-- TriggerClientEvent("Notify2",source,"#itemUsed",{msg=itemName(Full)})
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
		end
	end,

	["premium04"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			-- local Model = "m2f22"
			-- local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Model })
			-- if not Vehicle[1] then
			-- 	vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Model, plate = vRP.GeneratePlate(), work = "false" })
			-- end

            if not exports['variables']:GetVariable('functions','Premium04', Passport, source) then
                vRP.GenerateItem(Passport,"dollars",10000000)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",20)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",20)
                vRP.GenerateItem(Passport,"vest",50)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",2000)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",2000)

                TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
                TriggerClientEvent("inventory:Update",source,"Backpack")
                ExecuteCommand("SetVehicles "..Passport.." 2 Vip saveirog7,kiagt,civictyper,mazdarx7,acuransx,nissangtrnismo,c63,nissangtr,marshall,skyliner34,lancerevolutionx,subaruimpreza,teslamodels,lamborghinihuracanlw,675ltsp,porsche911,bmwm1wb,rmodgt63mini,SC18Hartge,tesroad20,toyotasupra2,rangerover,golfgti,lx2018,corvettec7,f800,160,xj6,hornet,mp412c,lancerevolution9,rmodm4,nissangtr,fordmustang,bnr34")
                vRP.SetPermission(Passport,"Prata",1)
                vRP.SetPermission(Passport,"Spotify",1)
                vRP.SetPermission(Passport,"Roupas2",1)
            end
			vRP.SetPremium(source)
			-- TriggerClientEvent("Notify2",source,"#itemUsed",{msg=itemName(Full)})
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
		end
	end,

	["premium05"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		if vRP.TakeItem(Passport,Full,1,true,Slot) then
			-- local Model = "m2f22"
			-- local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Model })
			-- if not Vehicle[1] then
			-- 	vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Model, plate = vRP.GeneratePlate(), work = "false" })
			-- end
			-- TriggerClientEvent("Notify2",source,"#itemUsed",{msg=itemName(Full)})
            --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
            if not exports['variables']:GetVariable('functions','Premium05', Passport, source) then
                vRP.GenerateItem(Passport,"dollars",5000000)
                vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",5)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",5)
                vRP.GenerateItem(Passport,"vest",10)
                vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",500)
                vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",500)
                TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
                ExecuteCommand("SetVehicles "..Passport.." 1 Vip saveirog7,kiagt,civictyper,mazdarx7,acuransx,nissangtrnismo,c63,nissangtr,marshall,skyliner34,lancerevolutionx,subaruimpreza,teslamodels,lamborghinihuracanlw,675ltsp,porsche911,bmwm1wb,rmodgt63mini,SC18Hartge,tesroad20,toyotasupra2,rangerover,golfgti,lx2018,corvettec7,f800,160,xj6,hornet,mp412c,lancerevolution9,rmodm4,nissangtr,fordmustang,bnr34")
                TriggerClientEvent("inventory:Update",source,"Backpack")
                vRP.SetPermission(Passport,"Bronze",1)
            end
			vRP.SetPremium(source)
		end
	end,

	["pager"] = function(source,Passport,Amount,Slot,Full,Item,Split)
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			if Player(ClosestPed)["state"]["Handcuff"] then
				local OtherPassport = vRP.Passport(ClosestPed)
				if OtherPassport then
					if vRP.HasGroup(OtherPassport,"Policia") then
						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							vRP.ServiceLeave(ClosestPed,OtherPassport,"Policia",true)
							TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
							-- TriggerClientEvent("Notify2",source,"#communicationRemoved")
						end
					end

					if vRP.HasGroup(OtherPassport,"Paramedic") then
						if vRP.TakeItem(Passport,Full,1,true,Slot) then
							vRP.ServiceLeave(ClosestPed,OtherPassport,"Paramedic",true)
							TriggerClientEvent("Notify",source,"amarelo","Todas as comunicações foram retiradas.",5000)
							-- TriggerClientEvent("Notify2",source,"#communicationRemoved")
						end
					end
				end
			end
		end
	end
}
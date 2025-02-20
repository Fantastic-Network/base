-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("dynamic")
SafeMode = GetConvar("SafeMode", "")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton", function(title, description, trigger, par, id, server)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu", function(title, description, id)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = id })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("openMenu", function()
	SendNUIMessage({ show = true })
	SetNuiFocus(true, true)
	menuOpen = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked", function(Data, Callback)
	if Data["trigger"] and Data["trigger"] ~= "" then
		if Data["server"] == "true" then
			TriggerServerEvent(Data["trigger"], Data["param"])
		else
			TriggerEvent(Data["trigger"], Data["param"])
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(Data, Callback)
	SetNuiFocus(false, false)
	menuOpen = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem", function()
	if menuOpen then
		SendNUIMessage({ close = true })
		SetNuiFocus(false, false)
		menuOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions", function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and LocalPlayer["state"]["Route"] < 900000 and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

        exports["dynamic"]:AddButton("Alarme/Mansões", "Ativar/Desativar Alarme.", "mansion_alarm:ToggleAlarm", false, "others", true)

        if SafeMode == "true" then
            if LocalPlayer["state"]["Route"] == 7 then
                exports["dynamic"]:AddButton("Mundo Safe", "Sair do Mundo Safe.", "SafeWorld:Enter", false, "others", true)
            else
                exports["dynamic"]:AddButton("Mundo Safe", "Entrar no Mundo Safe.", "SafeWorld:Enter", false, "others", true)
            end
            if GlobalState["WarModeBucket"] then
                if not Entity(Ped)["state"]["WarMode"] and not LocalPlayer["state"]["InSafeZone"] then
                    if not LocalPlayer["state"]["Newbie"] then
                        exports["dynamic"]:AddButton("Modo Guerra", "Entrar no Modo Guerra.", "WarMode:Enter", false, "others", true)
                    end
                end
                -- if Entity(Ped)["state"]["WarMode"] then
                --     if LocalPlayer["state"]["InSafeZone"] or LocalPlayer["state"]["RedZone"] or LocalPlayer["state"]["inSafeMode"] then
                --         exports["dynamic"]:AddButton("Modo Guerra", "Sair do Modo Guerra.", "WarMode:Exit", true, "others", true)
                --     end
                -- end
            else
                if not Entity(Ped)["state"]["WarMode"] and not LocalPlayer["state"]["InSafeZone"] then
                    if not LocalPlayer["state"]["Newbie"] then
                        exports["dynamic"]:AddButton("Modo Guerra", "Entrar no Modo Guerra.", "WarMode:Enter", false, "others", true)
                    end
                end
            end
        end
    
		if GetEntityHealth(Ped) > 100 then
			-- exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "player:carryPlayer", "", "player", true)

            if not LocalPlayer["state"]["Plaster"] then
                exports["dynamic"]:AddButton("Chapéu", "Colocar/Retirar o chapéu.", "player:Outfit", "Hat", "clothes", true)
                exports["dynamic"]:AddButton("Máscara", "Colocar/Retirar a máscara.", "player:Outfit", "Mask", "clothes", true)
                exports["dynamic"]:AddButton("Óculos", "Colocar/Retirar o óculos.", "player:Outfit", "Glasses", "clothes", true)
                exports["dynamic"]:AddButton("Vestir", "Vestir-se com as vestimentas guardadas.", "player:Outfit", "apply", "clothes", true)
                exports["dynamic"]:AddButton("Guardar", "Salvar suas vestimentas do corpo.", "player:Outfit", "save", "clothes", true)
                exports["dynamic"]:AddButton("Remover", "Remove parcialmente suas roupas.", "player:Outfit", "remove", "clothes", true)
            end

			exports["dynamic"]:AddButton("Propriedades", "Marcar/Desmarcar propriedades no mapa.", "propertys:Blips", "", "others", false)
			exports["dynamic"]:AddButton("Ferimentos", "Verificar ferimentos no corpo.", "paramedic:Injuries", "", "others", false)
            if not GlobalState["WarMode"] and SafeMode == "true" then
                exports["dynamic"]:AddButton("Safemode", "Ativar/Desativar safemode.", "safezone:updateNewbie", "", "others", false)
            end
			exports["dynamic"]:AddButton("Desbugar", "Recarregar o personagem.", "player:Debug", "", "others", true)

			local Vehicle = vRP.ClosestVehicle(7)
			if IsEntityAVehicle(Vehicle) then
				if not IsPedInAnyVehicle(Ped) then
					exports["dynamic"]:AddButton("Rebocar", "Colocar veículo na prancha do reboque.", "towdriver:invokeTow", "", "vehicle", false)

					if vRP.ClosestPed(3) then
						exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "closestpeds", true)
						exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "closestpeds", true)

						exports["dynamic"]:SubMenu("Jogador", "Pessoa mais próxima de você.", "closestpeds")
					end
				else
					exports["dynamic"]:AddButton("Sentar no Motorista", "Sentar no banco do motorista.", "player:seatPlayer", "0", "vehicle", false)
					exports["dynamic"]:AddButton("Sentar no Passageiro", "Sentar no banco do passageiro.", "player:seatPlayer", "1", "vehicle", false)
					exports["dynamic"]:AddButton("Sentar em Outros", "Sentar no banco do passageiro.", "player:seatPlayer", "2", "vehicle", false)
					exports["dynamic"]:AddButton("Levantar Vidros", "Levantar os vidros.", "player:winsFunctions", "1", "vehicle", true)
					exports["dynamic"]:AddButton("Abaixar Vidros", "Abaixar os vidros.", "player:winsFunctions", "0", "vehicle", true)
					exports["dynamic"]:AddButton("Piloto Automatico", "Dirigir até marcação.", "player:AutomaticPilot", "0", "vehicle", false)
				end

				exports["dynamic"]:AddButton("Porta do Motorista", "Abrir porta do motorista.", "player:Doors", "1", "doors", true)
				exports["dynamic"]:AddButton("Porta do Passageiro", "Abrir porta do passageiro.", "player:Doors", "2", "doors", true)
				exports["dynamic"]:AddButton("Porta Traseira Esquerda", "Abrir porta traseira esquerda.", "player:Doors", "3", "doors", true)
				exports["dynamic"]:AddButton("Porta Traseira Direita", "Abrir porta traseira direita.", "player:Doors", "4", "doors", true)
				exports["dynamic"]:AddButton("Porta-Malas", "Abrir porta-malas.", "player:Doors", "5", "doors", true)
				exports["dynamic"]:AddButton("Capô", "Abrir capô.", "player:Doors", "6", "doors", true)

				exports["dynamic"]:SubMenu("Veículo", "Funções do veículo.", "vehicle")
				exports["dynamic"]:SubMenu("Portas", "Portas do veículo.", "doors")
			end

			-- local Experience = vSERVER.Experience()
			-- for Name, Exp in pairs(Experience) do
			-- 	exports["dynamic"]:AddButton(Name, "Você possuí <yellow>" .. Exp .. " pontos</yellow> na classe <yellow>" .. ClassCategory(Exp) .. "</yellow>.", "", "", "Experience", false)
			-- end

			exports["dynamic"]:SubMenu("Jogador", "Pessoa mais próxima de você.", "player")
			exports["dynamic"]:SubMenu("Roupas", "Colocar/Retirar roupas.", "clothes")
			-- exports["dynamic"]:SubMenu("Experiência", "Todas as suas habilidades.", "Experience")
			exports["dynamic"]:SubMenu("Outros", "Todas as funções do personagem.", "others")

			exports["dynamic"]:openMenu()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions", function()
    if LocalPlayer["state"]["PVP"] then
        TriggerEvent("matchmaking:Leave")
        return
    end
	if (LocalPlayer["state"]["Policia"] or LocalPlayer["state"]["Paramedic"] or LocalPlayer["state"]["Mechanic"]) and not IsPauseMenuActive() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and LocalPlayer["state"]["Route"] < 900000 then

			local Ped = PlayerPedId()
			if GetEntityHealth(Ped) > 100 then
				if not IsPedInAnyVehicle(Ped) then
                    exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "player:carryPlayer", "", "player", true)
					exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
					exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)

					exports["dynamic"]:SubMenu("Jogador", "Pessoa mais próxima de você.", "player")
				end

				if LocalPlayer["state"]["Policia"] then
					exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
					exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
					exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)

					exports["dynamic"]:AddButton("Computador", "Computador de bordo policial.", "police:Mdt", "", false, false)

					exports["dynamic"]:AddButton("Civil 1", "Fardamento civil 1.", "player:Preset", "civil 1", "preCivil", true)
					exports["dynamic"]:AddButton("Civil 2", "Fardamento civil 2.", "player:Preset", "civil 2", "preCivil", true)
					exports["dynamic"]:AddButton("Civil 3", "Fardamento civil 3.", "player:Preset", "civil 3", "preCivil", true)

					exports["dynamic"]:AddButton("PM 1", "Fardamento pm 1.", "player:Preset", "pm 1", "prePM", true)
					exports["dynamic"]:AddButton("PM 2", "Fardamento pm 2.", "player:Preset", "pm 2", "prePM", true)
                    exports["dynamic"]:AddButton("PM 3", "Fardamento pm 3.", "player:Preset", "pm 3", "prePM", true)

					exports["dynamic"]:AddButton("Tático 1", "Fardamento tático 1.", "player:Preset", "tático 1", "preTatico", true)
					exports["dynamic"]:AddButton("Tático 2", "Fardamento tático 2.", "player:Preset", "tático 2", "preTatico", true)
                    exports["dynamic"]:AddButton("Tático 3", "Fardamento tático 3.", "player:Preset", "tático 3", "preTatico", true)

					exports["dynamic"]:AddButton("BAEP 1", "Fardamento BAEP 1.", "player:Preset", "baep 1", "preBaep", true)
					exports["dynamic"]:AddButton("BAEP 2", "Fardamento BAEP 2.", "player:Preset", "baep 2", "preBaep", true)
                    exports["dynamic"]:AddButton("BAEP 3", "Fardamento BAEP 3.", "player:Preset", "baep 3", "preBaep", true)

					exports["dynamic"]:AddButton("ROTA 1", "Fardamento ROTA 1.", "player:Preset", "rota 1", "preRota", true)
					exports["dynamic"]:AddButton("ROTA 2", "Fardamento ROTA 2.", "player:Preset", "rota 2", "preRota", true)
					exports["dynamic"]:AddButton("ROTA 3", "Fardamento ROTA 3.", "player:Preset", "rota 3", "preRota", true)

					exports["dynamic"]:AddButton("Exército 1", "Fardamento exercito 1.", "player:Preset", "exercito 1", "preExercito", true)
					exports["dynamic"]:AddButton("Exército 2", "Fardamento exercito 2.", "player:Preset", "exercito 2", "preExercito", true)
					exports["dynamic"]:AddButton("Exército 3", "Fardamento exercito 3.", "player:Preset", "exercito 3", "preExercito", true)

					local LocationPresets = exports["variables"]:GetLocationPresets("Policia")
					if LocationPresets then
						exports["dynamic"]:SubMenu("Fardamento Civil", "Todos os fardamentos civil.", "preCivil")
						exports["dynamic"]:SubMenu("Fardamento PM", "Todos os fardamentos pm.", "prePM")
						exports["dynamic"]:SubMenu("Fardamento Tático", "Todos os fardamentos tático.", "preTatico")
						exports["dynamic"]:SubMenu("Fardamento BAEP", "Todos os fardamentos BAEP.", "preBaep")
						exports["dynamic"]:SubMenu("Fardamento ROTA", "Todos os fardamentos ROTA.", "preRota")
						exports["dynamic"]:SubMenu("Fardamento Exército", "Todos os fardamentos exército.", "preExercito")
					end
				elseif LocalPlayer["state"]["Paramedic"] then
					exports["dynamic"]:AddButton("Estagiários", "Fardamento de estagiários.", "player:Preset", "estagiários", "preMedic", true)
					exports["dynamic"]:AddButton("Paramédico 1", "Fardamento de paramédico 1.", "player:Preset", "paramédico 1", "preMedic", true)
					exports["dynamic"]:AddButton("Paramédico 2", "Fardamento de paramédico 2.", "player:Preset", "paramédico 2", "preMedic", true)
					exports["dynamic"]:AddButton("Enfermeiros", "Fardamento de enfermeiros.", "player:Preset", "enfermeiros", "preMedic", true)
					exports["dynamic"]:AddButton("Médico", "Fardamento de médico.", "player:Preset", "médico", "preMedic", true)

					local LocationPresets = exports["variables"]:GetLocationPresets("Paramedic")
					if LocationPresets then
						exports["dynamic"]:SubMenu("Fardamentos", "Todos os fardamentos médicos.", "preMedic")
					end
				elseif LocalPlayer["state"]["Mechanic"] then
					exports["dynamic"]:AddButton("Membro", "Fardamento de membro.", "player:Preset", "membro", "preMechanic", true)
					exports["dynamic"]:AddButton("Conselheiro", "Fardamento de conselheiro.", "player:Preset", "conselheiro", "preMechanic", true)
					exports["dynamic"]:AddButton("Gerente", "Fardamento de gerente.", "player:Preset", "gerente", "preMechanic", true)
					exports["dynamic"]:AddButton("Sub-Chefe", "Fardamento de sub-chefe.", "player:Preset", "sub-chefe", "preMechanic", true)
					exports["dynamic"]:AddButton("Chefe", "Fardamento de chefe.", "player:Preset", "chefe", "preMechanic", true)

					local LocationPresets = exports["variables"]:GetLocationPresets("Mechanic")
					if LocationPresets then
						exports["dynamic"]:SubMenu("Fardamentos", "Todos os fardamentos mecânicos.", "preMechanic")
					end
				end

				exports["dynamic"]:openMenu()
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions", "Abrir menu principal.", "keyboard", "F9")
RegisterKeyMapping("emergencyFunctions", "Abrir menu de emergencial.", "keyboard", "F10")

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)
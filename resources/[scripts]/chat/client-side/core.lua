-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Chat",function()
	if not IsPauseMenuActive() then
		SetNuiFocus(true,true)

		local Tags = {}
		for Index,v in pairs(ClientState) do
			if LocalPlayer["state"][Index] then
				Tags[#Tags + 1] = Index
			end
		end
		SendNUIMessage({ Action = "Chat", Data = Tags, Block = Block })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:CLIENTMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------

--[[ Evitar o servidor enviar dois eventos com as mesmas informações para o client! ]]
RegisterNetEvent( 'chat:ClientMessageWithShowMe', function( sentByServerId, title, message, mode, tag )

    TriggerEvent( 'chat:ClientMessage', title, message, mode, nil, nil, tag )

    TriggerEvent( "showme:pressMe", sentByServerId, message, 10 )
end)

RegisterNetEvent("chat:ClientMessage")
AddEventHandler("chat:ClientMessage",function(Author,Message,Mode,Special,Custom,Tag)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
	SendNUIMessage({ Action = "Message", Author = Author, Message = Message, Type = Mode, Special = Special, Custom = Custom, Vip = Tag or "" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:CLIENTMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:ClientDelete")
AddEventHandler("chat:ClientDelete",function(Message)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
	SendNUIMessage({ Action = "Delete", Message = Message})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAT:CLIENTMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chat:Toggle")
AddEventHandler("chat:Toggle",function(toggle)
    SendNUIMessage({ Action = "Toggle", toggle = toggle or false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ChatDelete",function(Data,Callback)
    TriggerServerEvent("chat:DeleteMessage",Data["message"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHATSUBMIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ChatSubmit",function(Data,Callback)
	SetNuiFocus(false,false)
	if Data["message"] ~= "" then
		if Data["message"]:sub(1,1) == "/" then
			-- print("Command run through chat ("..Data["message"]:sub(2)..")", GetInvokingResource())
			ExecuteCommand(Data["message"]:sub(2))
		else
			local Ped = PlayerPedId()
			if GetEntityHealth(Ped) > 100 then
                if #Data["message"] > 255 then
                    TriggerEvent("Notify","vermelho","Mensagem muito longa.",5000,"CHAT")
					-- TriggerEvent("Notify2","#msgLonga")
                    return
                else

                    local playerId = PlayerId()
                    local playerPedId  = PlayerPedId()
                    local playerPedPos = GetEntityCoords( playerPedId )
                
                    local routingPlayers = { } 
                
                    for _, remotePlayerId in ipairs( GetActivePlayers() ) do

                        if remotePlayerId ~= playerId then
                    
                            local remotePlayerPedId = GetPlayerPed( remotePlayerId )
                            local remotePlayerPedPos = GetEntityCoords( remotePlayerPedId )
                    
                            if #( remotePlayerPedPos - playerPedPos ) <= 10.0 then
                    
                                table.insert( routingPlayers, GetPlayerServerId( remotePlayerId ) )
                            end
                        end
                    end

                    TriggerServerEvent("chat:ServerMessage", Data["tag"], Data["message"], routingPlayers )
                end
			end
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Chat","Abrir o chat.","keyboard","T")

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)


local BlockedModels = {}
local REPORTADO = false
local REPORTADO_2 = false
local REPORTADO_3 = false
CreateThread(function() 
    local search_pools = {'CObject'}
    local founded_sizes = {}
    while true do
        for i = 1, #search_pools do
            local selected_pool = search_pools[i]
            local pool = GetGamePool(selected_pool)
            for j = 1, #pool do
                local entity_handle = pool[j]
                if NetworkHasControlOfEntity(entity_handle) and NetworkGetEntityIsNetworked(entity_handle) then
                    local model = GetEntityModel(entity_handle)
					if BlockedModels[model] then
						-- print("^1 ModelHash: "..tostring(model).." | Name: "..tostring(GetEntityArchetypeName(entity_handle)))
						DeleteEntity(entity_handle)
					else
						local size = founded_sizes[model]
						if not size then
							local min, max = GetModelDimensions(model) 
							local size_vec = max - min
							size = size_vec.x + size_vec.y + size_vec.z
							founded_sizes[model] = size
						end
						if size > 40.0 then
							print("^1Detectamos uma atitude suspeita e forçamos a remoção de algumas entidades criadas por você.^7")
							print("^1Caso acredite que isso seja um erro, envie as seguintes informações para a staff^7")
							local name = tostring(GetEntityArchetypeName(entity_handle))
							-- print("^1 ModelHash: "..tostring(model).." | S_1: "..math.floor(size).." | Name: "..name)
                            if name == "v_res_d_paddedwall" then
                                return
                            end
							BlockedModels[model] = true
							if not REPORTADO_2 then
								REPORTADO_2 = true
								TriggerServerEvent("DNASUNDWDSA", {
									type = "SIZE",
									model = tostring(model),
									archetype = tostring(GetEntityArchetypeName(entity_handle)),
									pop_type = GetEntityPopulationType(entity_handle),
									script = GetEntityScript(entity_handle),
								})
							end
							DeleteEntity(entity_handle)
						else
							local coords = GetEntityCoords(entity_handle)
							local ply_coords = GetEntityCoords(PlayerPedId())
							local popType = GetEntityPopulationType(entity_handle)
							if #(coords - ply_coords) > 40 and (popType == 7 or popType == 0) then
								-- print("^1 ModelHash: "..tostring(model).." | S_2: "..math.floor(#(coords - ply_coords)).." | Name: "..tostring(GetEntityArchetypeName(entity_handle)))
                                if tostring(GetEntityArchetypeName(entity_handle)) == "v_res_d_paddedwall" then
                                    return
                                end
								DeleteEntity(entity_handle)
							end
						end
					end
                else
                    local model = GetEntityModel(entity_handle)
                    if BlockedModels[model] then
						DeleteEntity(entity_handle)
                    else
                        local size = founded_sizes[model]
                        if not size then
                            local min, max = GetModelDimensions(model) 
                            local size_vec = max - min
                            size = size_vec.x + size_vec.y + size_vec.z
                            founded_sizes[model] = size
                        end
                        if size > 40.0 then
                            local name = tostring(GetEntityArchetypeName(entity_handle))
                            -- print("^1 ModelHash: "..tostring(model).." | S_6: "..math.floor(size).." | Name: "..name)
                            -- print(NetworkGetEntityIsNetworked(entity_handle))
                            if name == "v_res_d_paddedwall" then
                                return
                            end
                            BlockedModels[model] = true
                            DeleteEntity(entity_handle)
                        end
                    end
                end
            end
        end
        Wait(1000)
    end
end)


CreateThread(function() 
	while true do
		local pool = GetGamePool('CVehicle')
		local vehicle_count = {}
		for i = 1,#pool do
			local entity_handle = pool[i]
			if NetworkHasControlOfEntity(entity_handle) and NetworkGetEntityIsNetworked(entity_handle) then
				local model = GetEntityModel(entity_handle)
				if not vehicle_count[model] then
					vehicle_count[model] = {entity_handle}
				else
					table.insert(vehicle_count[model], entity_handle)
				end
			end
		end

		for k,v in pairs(vehicle_count) do
			if #v > 5 then
				print("^1Detectamos um spam de veículos, por segurança estamos deletando.^7")
				print("^1Caso acredite que isso seja um erro, envie as seguintes informações para a staff^7")
				-- print("^1 ModelHash: "..tostring(k).." | S_2: "..math.floor(#v).." | Name: "..tostring(GetEntityArchetypeName(v[1])))
				if not REPORTADO_3 then
					REPORTADO_3 = true
					TriggerServerEvent("DNASUNDWDSA", {
						size = "VEH",
						model = tostring(k),
						count = #v
					})
				end
				for _,i in pairs(v) do
					DeleteEntity(i)
				end
				
			end
		end
		Wait(1000)
	end
end)

CreateThread(function()
	if LocalPlayer["state"]["Active"] then
			Wait(3000)
			SendNUIMessage({ Action = "Toggle", toggle = true })
	end
end)

CreateThread(function()
    Wait(5000)
    local Scale = GlobalState["ChatScale"] or 1.0
    if Scale then
        -- print(Scale)
        SendNUIMessage({ Action = "ChatScale", scale = Scale })
    end
end)
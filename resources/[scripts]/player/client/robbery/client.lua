SafeMode = GetConvar("SafeMode", "")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
local isActivated = false
local Blips = {}
CreateThread(function()
    local Table = {}

    for _,v in pairs(Robberys) do
        table.insert(Table,{ v["Coords"][1],v["Coords"][2],v["Coords"][3],1.25,"E","Roubar","Pressione para roubar" })
    end

    TriggerEvent("hoverfy:Insert",Table)
    while true do
        local Idle = 1500
        local Ped = PlayerPedId()
        for _,v in pairs(Robberys) do
            local Coords = GetEntityCoords(Ped)
            local MarkerCoords = vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3])
            local Distance = #(Coords - MarkerCoords)
            if Distance <= 20 then
                Idle = 1
                DrawMarker(29,MarkerCoords,0,0,0,vec3(0.0, 0.0, 0.0),vec3(1.0, 1.0, 1.0),255, 0, 0, 94,false,false,2,true,nil,nil,false)
            end
        end
        Wait(Idle)
    end
end)

RegisterCommand("roubos",function(source,args,rawCommand)
    if not isActivated then
        blips["blipsCoords"] = {}
        TriggerEvent("Notify","aviso","Marcações ativadas.",3000)
        -- TriggerEvent("Notify2","#marcacaoAtivada")
        for _,v in pairs(Robberys) do
            blips["blipsCoords"][k] = AddBlipForCoord(v["Coords"][1],v["Coords"][2],v["Coords"][3])
            SetBlipSprite(blips["blipsCoords"][k],1)
            SetBlipScale(blips["blipsCoords"][k],0.5)
            SetBlipColour(blips["blipsCoords"][k],1)
            SetBlipAsShortRange(blips["blipsCoords"][k],true)
            BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Roubo")
			EndTextCommandSetBlipName(blips["blipsCoords"][k])
        end
        isActivated = true
    else
        isActivated = false
        for k,v in pairs(blips["blipsCoords"]) do
            RemoveBlip(v)
        end
        TriggerEvent("Notify","amarelo","Marcações desativadas.",3000,"Roubos")
        -- TriggerEvent("Notify2","#marcacaoDesativada")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)
				for Index,v in pairs(Robberys) do
					local Distance = #(Coords - v["Coords"])
					if Distance <= 1.25 then
						TimeDistance = 1
                        ::Back::
						if IsControlJustPressed(1,38) and not exports["hud"]:Wanted() then
                            if SafeMode == "true" then
                                if GlobalState["WarModeBucket"] and LocalPlayer["state"]["Route"] ~= 2 then
                                    TriggerEvent("Notify","vermelho","Você so pode roubar se estiver no MODO GUERRA.",8000,"Roubos")
                                    -- TriggerEvent("Notify2","#roubarModoGuerra")
                                    return
                                end
                            end
                            if LocalPlayer["state"]["Route"] ~= 1 then
                                TriggerEvent("Notify","vermelho","Você não pode roubar se estiver no mundo safe",5000,"MODO SAFE")
                                -- TriggerEvent("Notify2","#naoRoubarSafe")
                                return
                            end
							vSERVER.InitRobbery(Index)
						end
					end
				end
			end
		end
        ---
		Wait(TimeDistance)
	end
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)
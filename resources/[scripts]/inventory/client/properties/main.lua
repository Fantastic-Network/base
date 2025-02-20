-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local vSERVER = Tunnel.getInterface("inventory/properties")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = ""
local Blips = {}
local Chest = ""
local Theft = nil
local Interior = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			if Init == "" then
				for Name,v in pairs(Propertys) do
					if #(Coords - v) <= 0.75 then
						TimeDistance = 1
						if IsControlJustPressed(1,38) then
                            print(Name)
                            if CheckAppartment(Name) then
                                exports["dynamic"]:AddButton("Entrar","Entrar Apartamento.","propertys:EnterAppartment",Name,false,false)
                                exports["dynamic"]:AddButton("Comprar","Comprar Apartamento.","propertys:BuyAppartment",Name,false,false)
                                exports["dynamic"]:openMenu()
                            else
                                local Consult = vSERVER.Propertys(Name)
                                if not Consult then
                                    if not vSERVER.HasOwner(Name) then
                                        exports["dynamic"]:AddButton("Comprar","Comprar Casa.","propertys:BuyHouse",Name,false,false)
                                        exports["dynamic"]:openMenu()
                                    else
                                        TriggerEvent("Notify","vermelho","A propriedade já possui um dono.",10000)
                                    end
                                else
                                    Interior = Consult["Interior"]
    
                                    if string.sub(Name,1,9) == "Propertys" then
                                        exports["dynamic"]:AddButton("Entrar","Adentrar a propriedade.","propertys:Enter",Name,false,false)
                                        exports["dynamic"]:AddButton("Credenciais","Reconfigurar os cartões de acesso.","propertys:Credentials",Name,false,true)
                                        exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","propertys:Lock",Name,false,true)
                                        exports["dynamic"]:AddButton("Garagem","Adicionar/Reajustar a garagem.","garages:Propertys",Name,false,true)
                                        exports["dynamic"]:AddButton("Hipoteca ("..nonSpecifiedFormatter(Consult["Price"])..")","Próximo pagamento em "..Consult["Tax"]..".","","",false,false)
                                        exports["dynamic"]:AddButton("Vender","Se desfazer da propriedade.","propertys:Sell",Name,false,true)
    
                                        exports["dynamic"]:openMenu()
                                    else
                                        TriggerEvent("propertys:Enter",Name)
                                    end
                                end
                            end
						end
					end
				end
			else
				if Interiors[Interior] and Interiors[Interior]["Exit"] then
                    InitName = Init
                    if CheckAppartment(Init) then
                        local Split = splitString(Init,"|")
                        InitName = Split[1]
                    end

					SetPlayerBlipPositionThisFrame(Propertys[InitName]["x"],Propertys[InitName]["y"])

					if Coords["z"] < (Interiors[Interior]["Exit"]["z"] - 25.0) then
						SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
					end

					if Theft and Robbery[Interior]["Furniture"] then
						for Index,v in pairs(Robbery[Interior]["Furniture"]) do
							if #(Coords - v) <= 2.2 then
								TimeDistance = 1
								DrawText(v["x"],v["y"],v["z"],"~g~E~w~  ROUBAR")

								if #(Coords - v) <= 1.0 and IsControlJustPressed(1,38) and vSERVER.Robbery(Init,Index) then
									if exports["inventory"]:Task(5,1500) then
										vSERVER.Paybbery(Init,Index)
									end
									vRP.DestroyObjects()
								end
							end
						end

						if Theft < GetGameTimer() and GetEntitySpeed(Ped) > 2 then
							Theft = GetGameTimer() + 60000
							vSERVER.Police(Propertys[Init])
						end
					end

					for Line,v in pairs(Interiors[Interior]) do
						if #(Coords - v) <= 0.75 then
							TimeDistance = 1

							if Line == "Exit" and IsControlJustPressed(1,38) then
                                SetEntityCoords(Ped,Propertys[InitName],false,false,false,false)
                                vSERVER.Toggle(Init,"Exit")
                                LocalPlayer["state"]["Home"] = false
                                Interior = ""
                                Theft = nil
                                Chest = ""
                                Init = ""
							elseif not Theft and (Line == "Vault" or Line == "Fridge") and IsControlJustPressed(1,38) then
                                if LocalPlayer["state"]["PVP"] then
                                    return
                                end
								toggleInventory("property")
								Chest = Line
							elseif not Theft and Line == "Clothes" and IsControlJustPressed(1,38) then
								ClothesMenu()
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHESMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function ClothesMenu()
	exports["dynamic"]:AddButton("Guardar","Salvar suas vestimentas do corpo.","propertys:Clothes","save",false,true)
	exports["dynamic"]:AddButton("Shopping","Abrir a loja de vestimentas.","skinshop:Open","",false,false)
	exports["dynamic"]:SubMenu("Vestir","Abrir lista com todas as vestimentas.","apply")
	exports["dynamic"]:SubMenu("Remover","Abrir lista com todas as vestimentas.","delete")

	local Clothes = vSERVER.Clothes()
	if parseInt(#Clothes) > 0 then
		for _,v in pairs(Clothes) do
			exports["dynamic"]:AddButton(v["name"],"Vestir-se com as vestimentas.","propertys:Clothes","apply-"..v["name"],"apply",true)
			exports["dynamic"]:AddButton(v["name"],"Remover a vestimenta salva.","propertys:Clothes","delete-"..v["name"],"delete",true)
		end
	end

	exports["dynamic"]:openMenu()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:CLOTHESRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:ClothesReset")
AddEventHandler("propertys:ClothesReset",function()
	TriggerEvent("dynamic:closeSystem")
	ClothesMenu()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:ENTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Enter")
AddEventHandler("propertys:Enter",function(Name,Thefting)
    if LocalPlayer["state"]["PVP"] then
        return
    end
    if GlobalState["Restarting"] then
        return false
    end
    if CheckAppartment(Name) then
        local HaveInterior =  vSERVER.GetAppartmentInterior(Name)
        Interior = HaveInterior
        if not Thefting then
            local Consult = vSERVER.Propertys(Name)
            if not Consult then
                return
            end
        end
    end
	if Thefting then
		Theft = GetGameTimer() + 10000
		Interior = Thefting
	end
    LocalPlayer["state"]["Home"] = true
	Init = Name
	local Ped = PlayerPedId()
	vSERVER.Toggle(Init,"Enter")
	TriggerEvent("dynamic:closeSystem")
	SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestProperty",function(Data,Callback)
	local Chest,chestPeso,chestMaxpeso = vSERVER.OpenChest(Init,Chest)
	if not Chest then
		return
	end
	Callback({ items = Chest, type = "property", weight = {
		current = chestPeso,
		max = chestMaxpeso
	}})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("inventory:CloseAll",function()
	TriggerEvent("inventory:Close")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupSlotProperty",function(Data,Callback)
	vSERVER.Take(Data["slot"],Data["amount"],Data["target"],Init,Chest)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropSlotProperty",function(Data,Callback)
	vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"],Init,Chest)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlotProperty",function(Data,Callback)
	vSERVER.Update(Data["slot"],Data["target"],Data["amount"],Init,Chest)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestUpgradeProperty",function(Data,Callback)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Update")
AddEventHandler("propertys:Update",function()
	SendNUIMessage({ action = "updateInventory" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:WEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Weight")
AddEventHandler("propertys:Weight",function(InvPeso,InvMax,ChestPeso,ChestMax)
	SendNUIMessage({ action = "updateInventory" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}
	for _,v in pairs(Propertys) do
		Tables[#Tables + 1] = { v["x"],v["y"],v["z"],0.75,"E","Propriedade","Pressione para acessar" }
	end

	for _,Intern in pairs(Interiors) do
		for Line,v in pairs(Intern) do
			local Message = "Saída"

			if Line == "Vault" then
				Message = "Baú"
			elseif Line == "Fridge" then
				Message = "Geladeira"
			elseif Line == "Clothes" then
				Message = "Armário"
			end

			Tables[#Tables + 1] = { v["x"],v["y"],v["z"],0.75,"E",Message,"Pressione para acessar" }
		end
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("casas",function(source,args)
    TriggerEvent("propertys:Blips")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:Blips")
AddEventHandler("propertys:Blips",function()
    local Markers = vSERVER.GetMarkers()
	if json.encode(Blips) ~= "[]" then
		for _,v in pairs(Blips) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end

		Blips = {}

		TriggerEvent("Notify","verde","Marcações desativadas.",10000)
		-- TriggerEvent("Notify2","#marcacaoDesativada")

	else
		for Name,v in pairs(Propertys) do
			Blips[Name] = AddBlipForCoord(v["x"],v["y"],v["z"])
			SetBlipSprite(Blips[Name],374)
			SetBlipAsShortRange(Blips[Name],true)
			SetBlipColour(Blips[Name],Markers[Name] and 35 or 43)
			SetBlipScale(Blips[Name],0.4)
		end

		TriggerEvent("Notify","verde","Marcações ativadas.",10000)
		-- TriggerEvent("Notify2","#marcacaoAtivada")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText(x,y,z,Message)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(Message)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(Message) / 160 * 0.45
		DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS:HOMEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("propertys:HomeBlips")
AddEventHandler("propertys:HomeBlips",function(Table)
	for _,v in pairs(Table) do
		local Name = v["Name"]
        if Name and Propertys[Name] and Propertys[Name]["x"] then
            local Blip = AddBlipForCoord(Propertys[Name]["x"],Propertys[Name]["y"],Propertys[Name]["z"])
            SetBlipSprite(Blip,374)
            SetBlipDisplay(Blip,4)
            SetBlipAsShortRange(Blip,true)
            SetBlipColour(Blip,3)
            SetBlipScale(Blip,0.8)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Minha Propriedade")
            EndTextCommandSetBlipName(Blip)
        end
	end
end)

RegisterNetEvent("propertys:EnterAppartment")
AddEventHandler("propertys:EnterAppartment",function(Name)
    local Appartments = vSERVER.GetAppartments(Name)
    TriggerEvent("dynamic:closeSystem")
    if not Appartments then
        return
    end
    Wait(100)
    for i=1,Appartments do
        local Appartment = Name.."|"..i
        exports["dynamic"]:SubMenu("Apartamento "..i,"Selecionar Apartamento.",i)
        exports["dynamic"]:AddButton("Entrar","Adentrar a propriedade.","propertys:Enter",Appartment,i,false)
        exports["dynamic"]:AddButton("Credenciais","Reconfigurar os cartões de acesso.","propertys:Credentials",Appartment,i,true)
        exports["dynamic"]:AddButton("Fechadura","Trancar/Destrancar a propriedade.","propertys:Lock",Appartment,i,true)
        exports["dynamic"]:AddButton("Garagem","Adicionar/Reajustar a garagem.","garages:Propertys",Appartment,i,true)
        exports["dynamic"]:AddButton("Vender","Se desfazer da propriedade.","propertys:Sell",Appartment,i,true)
    end
    exports["dynamic"]:openMenu()
end)

RegisterNetEvent("propertys:BuyAppartment")
AddEventHandler("propertys:BuyAppartment",function(Name)
    TriggerEvent("dynamic:closeSystem")
    Wait(250)
    for Line,v in pairs(Informations) do
        exports["dynamic"]:AddButton("Comprar","Adquirir a propriedade.","propertys:Buy",Name.."-"..Line,Line,true)

        if Gemstone[Name] then
            exports["dynamic"]:AddButton("Valor","Custo de <yellow>"..parseFormat(v["Gemstone"]).."</yellow> Diamantes.","","",Line,false)
        else
            exports["dynamic"]:AddButton("Valor","Custo de <yellow>$"..parseFormat(v["Price"]).."</yellow> dólares.","","",Line,false)
        end

        exports["dynamic"]:AddButton("Compartimento","Total de <yellow>"..v["Vault"].."Kg</yellow> no baú e <yellow>"..v["Fridge"].."Kg</yellow> na geladeira.","","",Line,false)
        exports["dynamic"]:SubMenu(Line, "Interior "..Line..".", Line)
    end
    exports["dynamic"]:openMenu()
end)

function sortInformations(infos, keyToSortBy)
    local keys = {}

    -- Extract the keys from the dictionary.
    for key in pairs(infos) do
        table.insert(keys, key)
    end

    -- Sort the keys based on the values they point to in the dictionary.
    table.sort(keys, function(a, b)
        return infos[a][keyToSortBy] < infos[b][keyToSortBy]
    end)

    return keys
end

RegisterNetEvent("propertys:BuyHouse")
AddEventHandler("propertys:BuyHouse",function(Name)
    TriggerEvent("dynamic:closeSystem")
    Wait(250)
    local Table = {}
    exports["dynamic"]:SubMenu("Escolha um interior", "", "Interiores")
    local keyToSortBy = "Price"
    if Gemstone[Name] then
        keyToSortBy = "Gemstone"
    end
    
    local sortedKeys = sortInformations(Informations, keyToSortBy)
    
    for _, Line in ipairs(sortedKeys) do
        local v = Informations[Line]
    
        exports["dynamic"]:AddButton("Comprar", "Adquirir a propriedade.", "propertys:Buy", Name.."-"..Line, Line, true)
        exports["dynamic"]:AddButton("Visitar", "Visitar Interior.", "propertys:Interiors", Line, Line, false)
        local Price = ""
        if Gemstone[Name] then
            exports["dynamic"]:AddButton("Valor", "Custo de <yellow>"..parseFormat(v["Gemstone"]).."</yellow> Diamantes.", "", "", Line, false)
            Price = "💎 <yellow> "..nonSpecifiedFormatter(v["Gemstone"]).."</yellow>"
        else
            exports["dynamic"]:AddButton("Valor", "Custo de <yellow>$"..parseFormat(v["Price"]).."</yellow> Dólares.", "", "", Line, false)
            Price = "💲 <yellow> "..nonSpecifiedFormatter(v["Price"]).."</yellow> "  -- Corrected this to v["Price"]
        end
    
        exports["dynamic"]:AddButton("Compartimento", "Total de <yellow>"..v["Vault"].."Kg</yellow> no baú e <yellow>"..v["Fridge"].."Kg</yellow> na geladeira.", "", "", Line, false)
        exports["dynamic"]:SubMenu(Line.." | "..Price, "Baú: "..v["Vault"].."Kgs.", Line)
    end
    exports["dynamic"]:openMenu()
end)

local NearHome = false
local Start = {}
CreateThread(function()
    for Name,v in pairs(Propertys) do
        Start[#Start + 1] = vector3(v["x"],v["y"],v["z"])
    end
    while true do
        local Idle = 1000
        if not InJob then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Near = 100
            for i=1,#Start do
                local Start = vector3(Start[i]["x"],Start[i]["y"],Start[i]["z"])
                local Distance = #(Coords - Start)
                if Distance < Near then
                    Near = Distance
                    NearHome = i
                end
            end
        end
        Wait(Idle)
    end
end)

CreateThread(function()
    while true do
        local Idle = 1000
        if NearHome then
            local Ped = PlayerPedId()
            local Coords = GetEntityCoords(Ped)
            local Start = vector3(Start[NearHome]["x"],Start[NearHome]["y"],Start[NearHome]["z"])
            local Distance = #(Coords - Start)
            if Distance < 30.0 then
                Idle = 5
                DrawMarker(20, Start.x, Start.y, Start.z - 0.50, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0,THEME.rgb.r, THEME.rgb.g, THEME.rgb.b, 100, 0, 0, 0, 1)
            end
        end
        Wait(Idle)
    end
end)

local OldCoords = false

RegisterNetEvent("propertys:Interiors")
AddEventHandler("propertys:Interiors",function(Interior)
    local Ped = PlayerPedId()
    TriggerEvent("dynamic:closeSystem")
    local Coords = GetEntityCoords(Ped)
    local InsideInterior = true
    OldCoords = Coords
	SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
    TriggerEvent("Notify:Text","[E] Sair da visitação")
    while InsideInterior do
        local Idle = 1
        local Coords = GetEntityCoords(Ped)
        if Coords["z"] < (Interiors[Interior]["Exit"]["z"] - 25.0) then
            SetEntityCoords(Ped,Interiors[Interior]["Exit"],false,false,false,false)
        end
        if IsControlJustPressed(1,38) then
            SetEntityCoords(Ped,OldCoords,false,false,false,false)
            TriggerEvent("Notify:Text","")
            InsideInterior = false
        end
        Wait(Idle)
    end
end)

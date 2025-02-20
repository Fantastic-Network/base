-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("farmer",Creative)
vCLIENT = Tunnel.getInterface("farmer")
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FRUITMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Fruitman")
AddEventHandler("farmer:Fruitman",function(Number)
	if Objects[Number] then
		local source = source
		local Passport = vRP.Passport(source)
		if Passport and not Active[Passport] then
			Active[Passport] = true

			if vRP.ConsultItem(Passport,"WEAPON_HATCHET",1) then
				local Amount = math.random(3,5)
				local Items = { "acerola","banana","guarana","tomato","passion","grape","tange","orange","apple","strawberry","coffee2" }
				local Select = math.random(#Items)

				if (vRP.InventoryWeight(Passport) + itemWeight(Items[Select]) * Amount) <= vRP.GetWeight(Passport) then
					vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)
					TriggerClientEvent("Progress",source,"Colhendo",11000)
					Objects[Number]["Time"] = Objects[Number]["Time"] + 25
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true

					local timeProgress = 10

					repeat
						if timeProgress ~= 10 then
							Wait(400)
						end

						Wait(700)
						TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
						timeProgress = timeProgress - 1
					until timeProgress <= 0

					Wait(400)

					local Players = vRPC.Players(source)
					for _,v in ipairs(Players) do
						async(function()
							TriggerClientEvent("farmer:Remover",v,Number,Objects[Number]["Time"])
						end)
					end

					vRP.GenerateItem(Passport,Items[Select],Amount,true)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.DestroyObjects(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					-- TriggerClientEvent("Notify2",source,"#mochilaFull")
				end
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Minerman")
AddEventHandler("farmer:Minerman",function(Number)
	if Objects[Number] then
		local source = source
		local Passport = vRP.Passport(source)
		if Passport and not Active[Passport] then
			Active[Passport] = true

			if vRP.ConsultItem(Passport,"pickaxe",1) then
				local Amount = math.random(2)
				if (vRP.InventoryWeight(Passport) + itemWeight("geode") * Amount) <= vRP.GetWeight(Passport) then
					vRPC.CreateObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)
					TriggerClientEvent("Progress",source,"Minerando",10000)
					Objects[Number]["Time"] = Objects[Number]["Time"] + 15
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true
					local timeProgress = 10

					repeat
						Wait(1000)
						timeProgress = timeProgress - 1
					until timeProgress <= 0

					Wait(1000)

					local Players = vRPC.Players(source)
					for _,v in ipairs(Players) do
						async(function()
							TriggerClientEvent("farmer:Remover",v,Number,Objects[Number]["Time"])
						end)
					end

					vRP.GenerateItem(Passport,"geode",Amount,true)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.DestroyObjects(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					-- TriggerClientEvent("Notify2",source,"#mochilaFull")
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","<b>Picareta</b> não encontrada.",5000)
				-- TriggerClientEvent("Notify2",source,"#picaretaMissing")
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LUMBERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Lumberman")
AddEventHandler("farmer:Lumberman",function(Number)
	if Objects[Number] then
		local source = source
		local Passport = vRP.Passport(source)
		if Passport and not Active[Passport] then
			Active[Passport] = true

			if vRP.ConsultItem(Passport,"WEAPON_HATCHET",1) then
				local Amount = math.random(3,5)
				if (vRP.InventoryWeight(Passport) + itemWeight("woodlog") * Amount) <= vRP.GetWeight(Passport) then
					vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)
					TriggerClientEvent("Progress",source,"Cortando",11000)
					Objects[Number]["Time"] = Objects[Number]["Time"] + 15
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true
					local timeProgress = 10

					repeat
						if timeProgress ~= 10 then
							Wait(400)
						end

						Wait(700)
						TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
						timeProgress = timeProgress - 1
					until timeProgress <= 0

					Wait(400)

					local Players = vRPC.Players(source)
					for _,v in ipairs(Players) do
						async(function()
							TriggerClientEvent("farmer:Remover",v,Number,Objects[Number]["Time"])
						end)
					end

					vRP.GenerateItem(Passport,"woodlog",Amount,true)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.DestroyObjects(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					-- TriggerClientEvent("Notify2",source,"#mochilaFull")
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","<b>Machado</b> não encontrado.",5000)
				-- TriggerClientEvent("Notify2",source,"#axeMissing")
			end

			Active[Passport] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)

local MiningCooldown = {}
local PaymentMining = 1000
local ZoneMining = vector3(2002.69,2925.02,-84.81)

RegisterServerEvent("farmer:Mining")
AddEventHandler("farmer:Mining",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if not MiningCooldown[tostring(Passport)] or os.time() > MiningCooldown[tostring(Passport)] then
            MiningCooldown[tostring(Passport)] = os.time() + 60*2
            vRP.GiveBank(Passport,PaymentMining,"Mining",true)
            --vRP.GenerateMoney(Passport,PaymentMining)
            TriggerClientEvent("Notify",Passport,"verde","Você recebeu <b>R$ "..PaymentMining.."</b>.",5000,"MINERAÇÃO")
			-- TriggerClientEvent("Notify2",Passport,"#recebeMining",{msg=PaymentMining})
        end
    end
end)

local PlayerMilking = {}
RegisterServerEvent("farmer:Milking")
AddEventHandler("farmer:Milking",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vCLIENT.milkingCoords(source) then
            if vRP.TakeItem(Passport,"emptybottle",2) then
                Player(source)["state"]["Buttons"] = true
                TriggerClientEvent("hoverfy:removeHoverfy",source)

                vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

                local Members = exports["party"]:Room(Passport,source,10)
                PlayerMilking[Passport] = os.time() + 10
                Wait(100)
                TriggerClientEvent("Progress",source,"Mundo",10)
                repeat
                    Wait(1000)
                until not PlayerMilking[Passport] or os.time() >= parseInt(PlayerMilking[Passport])
                if PlayerMilking[Passport] and os.time() >= parseInt(PlayerMilking[Passport]) then
                    vRP.GenerateItem(Passport,"milkbottle",2,true)
                    TriggerClientEvent("farmer:NewMilking",source)
                    Player(source)["state"]["Buttons"] = false
                end
            else
                TriggerClientEvent("farmer:NewMilking",source)
                Player(source)["state"]["Buttons"] = false
                TriggerClientEvent("Notify",source,"vermelho","Garrafa vazia não encontrada.",5000)
            end
		end
    end
end)

RegisterServerEvent("farmer:CancelMilking")
AddEventHandler("farmer:CancelMilking",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        PlayerMilking[Passport] = nil
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- HARVESTING
-----------------------------------------------------------------------------------------------------------------------------------------
local PlayerHarvesting = {}

function CheckCoordsHarvesting(source,Ped)
    local Coords = GetEntityCoords(Ped)
    local CloseAnyCoords = false
    for i=1,#FruitCoords do
        local Distance = #(Coords - FruitCoords[i])
        if Distance <= 30.0 then
            CloseAnyCoords = true
            break
        end
    end
    if not CloseAnyCoords then
        TriggerClientEvent("Notify",source,"vermelho","Você não está no local de entrega.",5000,"Entrega")
        return false
    end
    return true
end


RegisterServerEvent("farmer:Harvesting")
AddEventHandler("farmer:Harvesting",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Ped = GetPlayerPed(source)
        if CheckCoordsHarvesting(source,Ped) then
            Player(source)["state"]["Buttons"] = true
            TriggerClientEvent("hoverfy:removeHoverfy",source)
            local Amount = math.random(3,5)
            local Items = { "acerola","banana","guarana","tomato","passion","grape","tange","orange","apple","strawberry","coffee2" }
            local Select = math.random(#Items)
            vRPC.playAnim(source,false,{"amb@world_human_gardener_plant@female@base","base_female"},true)

            local Members = exports["party"]:Room(Passport,source,10)
            PlayerHarvesting[Passport] = os.time() + 30
            Wait(100)
            TriggerClientEvent("Progress",source,"Mundo",30000)
            repeat
                Wait(1000)
            until not PlayerHarvesting[Passport] or os.time() >= parseInt(PlayerHarvesting[Passport])
            if PlayerHarvesting[Passport] and os.time() >= parseInt(PlayerHarvesting[Passport]) then
                vRP.GenerateItem(Passport,Items[Select],Amount,true)
                TriggerClientEvent("farmer:NewHarvesting",source)
                Player(source)["state"]["Buttons"] = false
            end
		end
    end
end)

RegisterServerEvent("farmer:CancelHarvesting")
AddEventHandler("farmer:CancelHarvesting",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        PlayerHarvesting[Passport] = nil
    end
end)
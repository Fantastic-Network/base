-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("crafting")
cityName = GetConvar("cityName", "Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Timer = 0
local Select = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
local Crafting = {
	-- { vec3(1272.26,-1712.57,54.76),"Lester" },
	-- { vec3(46.21,-1749.45,29.64),"Mercado" },
	-- { vec3(807.67,-757.51,26.77),"PizzaThis" },
	-- { vec3(-1198.04,-899.07,13.99),"BurgerShot" },
	-- { vec3(-590.37,-1059.77,22.34),"UwuCoffee" },
	-- { vec3(122.69,-1041.57,29.56),"BeanMachine" },
	-- { vec3(501.38,-66.92,58.15),"Razors" }
}
if cityName == "Base" then
	Crafting[#Crafting+1] = { vec3(1296.41,-257.2,96.2),"Barragem" }
	Crafting[#Crafting+1] = { vec3(1439.71,1406.13,108.65),"Cartel" }
	Crafting[#Crafting+1] = { vec3(2734.48,2753.0,46.71),"Sindicato" }
	Crafting[#Crafting+1] = { vec3(364.78,-2042.46,22.39),"Vagos" }
	Crafting[#Crafting+1] = { vec3(1064.06,3284.3,44.13),"Umbrella" }
	Crafting[#Crafting+1] = { vec3(2208.94,113.41,234.11),"Vermelhos" }
	Crafting[#Crafting+1] = { vec3(1833.57,401.77,166.66),"Amarelos" }
	Crafting[#Crafting+1] = { vec3(2261.64,3964.98,33.77),"Verdes" }
	Crafting[#Crafting+1] = { vec3(3598.94,3730.34,29.69),"Laranjas" }
	Crafting[#Crafting+1] = { vec3(1310.84,-733.55,65.09),"Brancos" }
	Crafting[#Crafting+1] = { vec3(76.19,-1944.65,20.83),"Ballas" }
	Crafting[#Crafting+1] = { vec3(944.67,9.64,75.74),"Bellagio" }
	Crafting[#Crafting+1] = { vec3(133.03,-1293.61,29.27),"Vanilla" }
	Crafting[#Crafting+1] = { vec3(110.73,-1296.89,29.27),"Vanilla" } -- segundo blip
	Crafting[#Crafting+1] = { vec3(1031.52,937.59,219.42),"Galaxy" }
	Crafting[#Crafting+1] = { vec3(815.17,1138.87,316.3),"Galaxy" }
	Crafting[#Crafting+1] = { vec3(172.48,762.9,208.62),"Bahamas" }
	Crafting[#Crafting+1] = { vec3(188.3,722.09,205.57),"Bahamas" }
	Crafting[#Crafting+1] = { vec3(157.65,673.24,207.59),"Bahamas" }
	Crafting[#Crafting+1] = { vec3(-286.31,231.67,78.82),"Luxor" }
	Crafting[#Crafting+1] = { vec3(1360.82,-2090.71,47.21),"Redline" }
	Crafting[#Crafting+1] = { vec3(-1144.91,-1549.63,7.63),"DriftKing" }
	Crafting[#Crafting+1] = { vec3(-3038.54,96.36,12.82),"Crips" }
	Crafting[#Crafting+1] = { vec3(88.55,1236.81,207.17),"SonsofAnarchy" }
	Crafting[#Crafting+1] = { vec3(2198.81,5597.37,53.8),"Sinaloa" }
	Crafting[#Crafting+1] = { vec3(1025.19,-2545.63,32.28),"HellsAngels" }
	Crafting[#Crafting+1] = { vec3(-210.81,1904.67,194.87),"Triade" }
	Crafting[#Crafting+1] = { vec3(-313.14,2033.87,147.05),"Triade" }
	Crafting[#Crafting+1] = { vec3(539.07,-2776.35,6.03),"Yakuza" }
	Crafting[#Crafting+1] = { vec3(354.2,-2704.78,1.7),"Warlocks" }
	Crafting[#Crafting+1] = { vec3(-1568.2,-416.61,48.26),"Bloods" }
	Crafting[#Crafting+1] = { vec3(-1566.8,-401.03,48.26),"Bloods" } -- segundo blip
	Crafting[#Crafting+1] = { vec3(1078.13,-2008.44,30.9),"Gringa" }
	Crafting[#Crafting+1] = { vec3(1111.14,-2030.94,43.84),"Gringa" } -- segundo blip
	Crafting[#Crafting+1] = { vec3(-1794.51,422.55,128.28),"Franca" }
	Crafting[#Crafting+1] = { vec3(417.3,-1496.9,30.14),"Italia" }
	Crafting[#Crafting+1] = { vec3(-1871.06,2056.28,140.97),"Russia" }
	Crafting[#Crafting+1] = { vec3(2530.37,4114.63,38.59),"Israel" }
	Crafting[#Crafting+1] = { vec3(-1573.67,376.13,98.66),"Playboy" }
	Crafting[#Crafting+1] = { vec3(-1509.65,847.5,181.59),"Mexico" }
	Crafting[#Crafting+1] = { vec3(3107.6,5106.47,22.76),"China" }
	Crafting[#Crafting+1] = { vec3(-1533.71,146.47,55.64),"Playboy" }
	Crafting[#Crafting+1] = { vec3(-1051.6,308.85,62.21),"Mercenarios" }
	Crafting[#Crafting+1] = { vec3(-1890.85,2058.49,140.98),"Russia" }
	Crafting[#Crafting+1] = { vec3(-1528.48,839.5,181.59),"Mexico" }
	Crafting[#Crafting+1] = { vec3(109.53,3614.05,40.49),"Israel" }
	Crafting[#Crafting+1] = { vec3(3133.01,5082.57,22.44),"China" }
	Crafting[#Crafting+1] = { vec3(-1573.67,376.13,98.66),"Franca" }
	Crafting[#Crafting+1] = { vec3(421.26,-1495.92,33.8),"Italia" }
	Crafting[#Crafting+1] = { vec3(1026.93,-2532.65,28.29),"HellsAngels" }
	Crafting[#Crafting+1] = { vec3(107.82,1212.15,207.17),"SonsofAnarchy" }
	Crafting[#Crafting+1] = { vec3(347.85,-2033.14,22.16),"Vagos" }
	Crafting[#Crafting+1] = { vec3(1421.49,1428.36,108.6),"Cartel" }
	Crafting[#Crafting+1] = { vec3(2761.22,2687.9,55.86),"Sindicato" }
	Crafting[#Crafting+1] = { vec3(2259.3,3998.7,33.68),"Verdes" }
	Crafting[#Crafting+1] = { vec3(2310.07,4015.15,41.08),"Verdes" } -- segundo blip
	Crafting[#Crafting+1] = { vec3(1366.91,-720.88,67.23),"Brancos" }
	Crafting[#Crafting+1] = { vec3(1007.08,3303.93,44.13),"Umbrella" }
	Crafting[#Crafting+1] = { vec3(1846.37,425.32,166.64),"Amarelos" }
	Crafting[#Crafting+1] = { vec3(2236.67,69.39,246.97),"Vermelhos" }
	Crafting[#Crafting+1] = { vec3(951.28,45.45,75.74),"Bellagio" }
	Crafting[#Crafting+1] = { vec3(993.46,-2360.34,21.58),"TopGear" }
	Crafting[#Crafting+1] = { vec3(-1146.96,-1559.78,7.62),"DriftKing" }
	Crafting[#Crafting+1] = { vec3(98.33,-1959.67,20.73),"Ballas" }
	Crafting[#Crafting+1] = { vec3(-763.25,-2584.52,13.58),"Outlaws" }
	Crafting[#Crafting+1] = { vec3(552.77,-2784.38,6.1),"Yakuza" }
	Crafting[#Crafting+1] = { vec3(-322.49,218.26,78.82),"Luxor" }
	Crafting[#Crafting+1] = { vec3(1306.29,-1710.43,54.86),"LosAztecas" }
	Crafting[#Crafting+1] = { vec3(1246.65,-1723.76,59.41),"LosAztecas" }
	Crafting[#Crafting+1] = { vec3(494.92,2596.55,54.36),"Bopegg" }
	Crafting[#Crafting+1] = { vec3(580.99,2462.46,60.2),"Bopegg" }
	Crafting[#Crafting+1] = { vec3(1880.33,6396.35,45.49),"Marrons" }
	Crafting[#Crafting+1] = { vec3(1813.53,6421.28,39.55),"Marrons" }
	Crafting[#Crafting+1] = { vec3(2230.67,3410.38,61.38),"Cinzas" }
	Crafting[#Crafting+1] = { vec3(2175.14,3407.17,45.8),"Cinzas" }
	Crafting[#Crafting+1] = { vec3(543.02,433.07,172.26),"Roxos" }
	Crafting[#Crafting+1] = { vec3(486.18,400.04,142.65),"Roxos" }
	Crafting[#Crafting+1] = { vec3(1432.17,-2318.18,66.86),"Rosas" }
	Crafting[#Crafting+1] = { vec3(1452.94,-2427.65,66.81),"Rosas" }
	Crafting[#Crafting+1] = { vec3(-1526.58,106.37,56.67),"Playboy" }
	Crafting[#Crafting+1] = { vec3(488.84,-1525.14,29.28),"Italia" }
	Crafting[#Crafting+1] = { vec3(12.08,3721.77,39.63),"Israel" }
	Crafting[#Crafting+1] = { vec3(-2967.19,46.15,7.95),"HellsAngels" }
	Crafting[#Crafting+1] = { vec3(-1050.54,301.46,66.99),"Mercenarios" }
	Crafting[#Crafting+1] = { vec3(311.2,5538.86,51.37),"Sinaloa" }
	Crafting[#Crafting+1] = { vec3(568.2,-2754.69,6.05),"Yakuza" }
	Crafting[#Crafting+1] = { vec3(1325.65,-149.6,116.04),"Barragem" }
	Crafting[#Crafting+1] = { vec3(2760.82,2688.3,55.86),"Sindicato" }
	Crafting[#Crafting+1] = { vec3(2691.29,2717.91,40.98),"Sindicato" }
	Crafting[#Crafting+1] = { vec3(1446.66,1572.36,110.89),"Cartel" }
	Crafting[#Crafting+1] = { vec3(1508.44,1419.58,101.65),"Cartel" }
	Crafting[#Crafting+1] = { vec3(284.44,-2054.87,18.96),"Vagos" }
	Crafting[#Crafting+1] = { vec3(-1381.79,-636.34,33.72),"bahamas" }
	Crafting[#Crafting+1] = { vec3(185.6,1214.33,225.59),"SonsofAnarchy" }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Table = {}

    for _,v in pairs(Crafting) do
        table.insert(Table,{ v[1]["x"],v[1]["y"],v[1]["z"],1.25,"E","Crafting","Pressione para abrir" })
    end

    TriggerEvent("hoverfy:Insert",Table)
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

				for _,v in pairs(Crafting) do
					local Distance = #(Coords - v[1])
					if Distance <= 1.25 then
						TimeDistance = 1
						
						if IsControlJustPressed(1,38) and not exports["hud"]:Wanted() and vSERVER.Permission(v[2]) then
							if v[2] ~= Select and GetGameTimer() < Timer then
								TriggerEvent("Notify","amarelo","ProduÃ§Ã£o em andamento.",5000)
							else
								Select = v[2]
								SetNuiFocus(true,true)
								SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request(Select) })
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
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OWNED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Owned",function(Data,Callback)
	Callback(vSERVER.Owned(Data["id"],Data["key"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Crafting",function(Data,Callback)
	if GetGameTimer() >= Timer then
		Timer = GetGameTimer() + Data["time"] * 1000

		SetTimeout(Data["time"] * 1000,function()
			vSERVER.Crafting(Data["id"],Data["key"],Data["amount"])
		end)

		Callback(true)
	else
		TriggerEvent("Notify","amarelo","ProduÃ§Ã£o em andamento.",5000)
		Callback(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:INVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Inventory")
AddEventHandler("crafting:Inventory",function()
	if "Inventory" ~= Select and GetGameTimer() < Timer then
		TriggerEvent("Notify","amarelo","ProduÃ§Ã£o em andamento.",5000)
		return
	end

	Select = "Inventory"
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "OpenCraft", data = vSERVER.Request("Inventory") })
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)
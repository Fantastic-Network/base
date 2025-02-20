-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("target")
vPLAYER = Tunnel.getInterface("player")
SafeMode = GetConvar("SafeMode", "")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local Selected = {}
local Sucess = false
local Dismantleds = 1
cityName = GetConvar("cityName", "Base")
LocalPlayer["state"]["Carregar"] = false
LocalPlayer["state"]["Target"] = false
---------------------------------------------------------------------------------------------------------------------------------------
-- TOWS
-----------------------------------------------------------------------------------------------------------------------------------------
local Tows = {
	vec3(-142.24,-1174.19,23.76)
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Dismantles = {
	vec3(943.23,-1497.87,30.11),
	vec3(-1172.57,-2037.65,13.75),
	vec3(-524.94,-1680.63,19.21),
	vec3(1358.14,-2095.41,52.0),
	vec3(602.47,-437.82,24.75),
	vec3(-413.86,-2179.29,10.31),
	vec3(146.51,320.62,112.14),
	vec3(520.91,169.14,99.36),
	vec3(1137.99,-794.32,57.59),
	vec3(-93.07,-2549.6,6.0),
	vec3(-1537.85,-577.49,25.71),
	vec3(820.07,-488.43,30.46),
	vec3(819.53,-822.27,26.18),
	vec3(1078.62,-2325.56,30.25),
	vec3(-223.39,-1699.13,34.04),
	vec3(1409.93,-2055.74,52.0),
	vec3(-182.71,-1263.57,31.29),
	vec3(-1124.2,-1611.21,4.4),
	vec3(2202.99,5557.24,54.05),
	vec3(-750.75,-2596.36,13.83), --Outlaws
	vec3(929.65,-2383.12,22.33), -- Topgear
	vec3(1204.69,-3116.71,5.54),
	vec3(-593.86,-1586.3,26.74) -- overdrive
}
if cityName == "Base" then
	Dismantles[#Dismantles+1] = vec3(-339.34,-135.91,38.93) -- redline
	Dismantles[#Dismantles+1] = vec3(-386.08,-92.33,54.42) -- redline
end

CreateThread(function()
    LocalPlayer["state"]["Buttons"] = false
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for Number,v in pairs(Dismantles) do
					if #(Coords - v) <= 50.0 then
						TimeDistance = 1
						DrawMarker(23,v["x"],v["y"],v["z"] - 0.9,0.0,0.0,0.0,0.0,0.0,0.0,5.0,5.0,0.0,46,110,76,100,0,0,0,0)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Dismantles")
AddEventHandler("target:Dismantles",function()
	Dismantleds = math.random(#Dismantles)
	TriggerEvent("NotifyPush",{ code = "QRU", title = "Desmanche", x = Dismantles[Dismantleds]["x"], y = Dismantles[Dismantleds]["y"], z = Dismantles[Dismantleds]["z"], blipColor = 60 })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Fuels = {
	{ 273.83,-1253.46,28.29 },
	{ 273.83,-1261.29,28.29 },
	{ 273.83,-1268.63,28.29 },
	{ 265.06,-1253.46,28.29 },
	{ 265.06,-1261.29,28.29 },
	{ 265.06,-1268.63,28.29 },
	{ 256.43,-1253.46,28.29 },
	{ 256.43,-1261.29,28.29 },
	{ 256.43,-1268.63,28.29 },
	{ 2680.90,3266.40,54.39 },
	{ 2678.51,3262.33,54.39 },
	{ -2104.53,-311.01,12.16 },
	{ -2105.39,-319.21,12.16 },
	{ -2106.06,-325.57,12.16 },
	{ -2097.48,-326.48,12.16 },
	{ -2096.81,-320.11,12.16 },
	{ -2096.09,-311.90,12.16 },
	{ -2087.21,-312.81,12.16 },
	{ -2088.08,-321.03,12.16 },
	{ -2088.75,-327.39,12.16 },
	{ -2551.39,2327.11,32.24 },
	{ -2558.02,2326.70,32.24 },
	{ -2558.48,2334.13,32.24 },
	{ -2552.60,2334.46,32.24 },
	{ -2558.77,2341.48,32.24 },
	{ -2552.39,2341.89,32.24 },
	{ 186.97,6606.21,31.06 },
	{ 179.67,6604.93,31.06 },
	{ 172.33,6603.63,31.06 },
	{ 818.99,-1026.24,25.44 },
	{ 810.7,-1026.24,25.44 },
	{ 810.7,-1030.94,25.44 },
	{ 818.99,-1030.94,25.44 },
	{ 818.99,-1026.24,25.44 },
	{ 827.3,-1026.24,25.64 },
	{ 827.3,-1030.94,25.64 },
	{ 1207.07,-1398.16,34.39 },
	{ 1204.2,-1401.03,34.39 },
	{ 1210.07,-1406.9,34.39 },
	{ 1212.94,-1404.03,34.39 },
	{ 1178.97,-339.54,68.37 },
	{ 1186.4,-338.23,68.36 },
	{ 1184.89,-329.7,68.31 },
	{ 1177.46,-331.01,68.32 },
	{ 1175.71,-322.3,68.36 },
	{ 1183.13,-320.99,68.36 },
	{ 629.64,263.84,102.27 },
	{ 629.64,273.97,102.27 },
	{ 620.99,273.97,102.27 },
	{ 621.0,263.84,102.27 },
	{ 612.44,263.84,102.27 },
	{ 612.43,273.96,102.27 },
	{ 2588.41,358.56,107.66 },
	{ 2588.65,364.06,107.66 },
	{ 2581.18,364.39,107.66 },
	{ 2580.94,358.89,107.66 },
	{ 2573.55,359.21,107.66 },
	{ 2573.79,364.71,107.66 },
	{ 174.99,-1568.44,28.33 },
	{ 181.81,-1561.96,28.33 },
	{ 176.03,-1555.91,28.33 },
	{ 169.3,-1562.26,28.33 },
	{ -329.81,-1471.63,29.73 },
	{ -324.74,-1480.41,29.73 },
	{ -317.26,-1476.09,29.73 },
	{ -322.33,-1467.31,29.73 },
	{ -314.92,-1463.03,29.73 },
	{ -309.85,-1471.79,29.73 },
	{ 1786.08,3329.86,40.42 },
	{ 1785.04,3331.48,40.35 },
	{ 50.31,2778.54,57.05 },
	{ 48.92,2779.59,57.05 },
	{ 264.98,2607.18,43.99 },
	{ 263.09,2606.8,43.99 },
	{ 1035.45,2674.44,38.71 },
	{ 1043.22,2674.45,38.71 },
	{ 1043.22,2667.92,38.71 },
	{ 1035.45,2667.91,38.71 },
	{ 1209.59,2658.36,36.9 },
	{ 1208.52,2659.43,36.9 },
	{ 1205.91,2662.05,36.9 },
	{ 2539.8,2594.81,36.96 },
	{ 2001.55,3772.21,31.4 },
	{ 2003.92,3773.48,31.4 },
	{ 2006.21,3774.96,31.4 },
	{ 2009.26,3776.78,31.4 },
	{ 1684.6,4931.66,41.23 },
	{ 1690.1,4927.81,41.23 },
	{ 1705.74,6414.61,31.77 },
	{ 1701.73,6416.49,31.77 },
	{ 1697.76,6418.35,31.77 },
	{ -97.06,6416.77,30.65 },
	{ -91.29,6422.54,30.65 },
	{ -1808.71,799.96,137.69 },
	{ -1803.62,794.4,137.69 },
	{ -1797.22,800.56,137.66 },
	{ -1802.31,806.12,137.66 },
	{ -1795.93,811.97,137.7 },
	{ -1790.83,806.41,137.7 },
	{ -1438.07,-268.69,45.41 },
	{ -1444.5,-274.23,45.41 },
	{ -1435.5,-284.68,45.41 },
	{ -1429.07,-279.15,45.41 },
	{ -732.64,-932.51,18.22 },
	{ -732.64,-939.32,18.22 },
	{ -724.0,-939.32,18.22 },
	{ -724.0,-932.51,18.22 },
	{ -715.43,-932.51,18.22 },
	{ -715.43,-939.32,18.22 },
	{ -532.28,-1212.71,17.33 },
	{ -529.51,-1213.96,17.33 },
	{ -524.92,-1216.15,17.33 },
	{ -522.23,-1217.42,17.33 },
	{ -518.52,-1209.5,17.33 },
	{ -521.21,-1208.23,17.33 },
	{ -525.8,-1206.04,17.33 },
	{ -528.57,-1204.8,17.33 },
	{ -72.03,-1765.1,28.53 },
	{ -69.45,-1758.01,28.55 },
	{ -77.59,-1755.05,28.81 },
	{ -80.17,-1762.14,28.8 },
	{ -63.61,-1767.93,28.27 },
	{ -61.03,-1760.85,28.31 },
	{ 814.53,-789.63,25.251 },
	{ 812.96,-789.63,25.251 },
	{ 807.00,-789.63,25.251 },
	{ 805.42,-789.63,25.251 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
local AddedZone = {}
CreateThread(function()
	RegisterCommand("+entityTarget",TargetEnable)
	RegisterCommand("-entityTarget",TargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	AddBoxZone("CallBurgerShot",vec3(-1187.86,-904.92,13.73),0.25,0.25,{
		name = "CallBurgerShot",
		heading = 3374176,
		minZ = 13.50,
		maxZ = 14.00
	},{
		shop = "BurgerShot",
		Distance = 1.0,
		options = {
			{
				event = "target:CallWorks",
				label = "Buscar Entregadores",
				tunnel = "server"
			}
		}
	})

	AddBoxZone("CallUwuCoffee",vec3(-584.09,-1061.45,22.37),0.25,0.25,{
		name = "CallUwuCoffee",
		heading = 3374176,
		minZ = 22.25,
		maxZ = 22.50
	},{
		shop = "UwU Café",
		Distance = 1.0,
		options = {
			{
				event = "target:CallWorks",
				label = "Buscar Entregadores",
				tunnel = "server"
			}
		}
	})

	AddBoxZone("CallPizzaThis",vec3(811.28,-750.61,26.85),0.25,0.25,{
		name = "CallPizzaThis",
		heading = 3374176,
		minZ = 26.50,
		maxZ = 27.00
	},{
		shop = "Pizza This",
		Distance = 1.0,
		options = {
			{
				event = "target:CallWorks",
				label = "Buscar Entregadores",
				tunnel = "server"
			}
		}
	})

	AddBoxZone("CallBeanMachine",vec3(122.22,-1036.56,29.44),0.25,0.25,{
		name = "CallBeanMachine",
		heading = 3374176,
		minZ = 29.25,
		maxZ = 29.75
	},{
		shop = "Bean Machine",
		Distance = 1.0,
		options = {
			{
				event = "target:CallWorks",
				label = "Buscar Entregadores",
				tunnel = "server"
			}
		}
	})

	AddBoxZone("CallParamedic",vec3(311.83,-593.31,43.08),0.25,0.25,{
		name = "CallParamedic",
		heading = 3374176,
		minZ = 43.00,
		maxZ = 43.25
	},{
		shop = "Paramedic",
		Distance = 2.0,
		options = {
			{
				event = "target:CallWorks",
				label = "Buscar Entregadores",
				tunnel = "server"
			}
		}
	})

	AddTargetModel({ -2007231801,1339433404,1694452750,1933174915,-462817101,-469694731,-164877493,486135101 },{
		options = {
			{
				event = "shops:Fuel",
				label = "Combustível",
				tunnel = "client"
			}
		},
		Distance = 0.75
	})

	AddCircleZone("makePaper",vec3(-533.18,5292.15,74.17),0.5,{
		name = "makePaper",
		heading = 3374176
	},{
		Distance = 0.75,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Produzir",
				tunnel = "products",
				service = "paper"
			}
		}
	})

	AddCircleZone("Yoga01",vec3(-492.83,-217.31,35.61),0.5,{
		name = "Yoga01",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga02",vec3(-492.87,-219.03,36.55),0.5,{
		name = "Yoga02",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga03",vec3(-492.89,-220.68,36.51),0.5,{
		name = "Yoga03",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga04",vec3(-490.21,-220.91,36.51),0.5,{
		name = "Yoga04",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga05",vec3(-490.18,-219.24,36.58),0.5,{
		name = "Yoga05",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("Yoga06",vec3(-490.16,-217.33,36.63),0.5,{
		name = "Yoga06",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	AddTargetModel({ 654385216,161343630,-430989390,1096374064,-1519644200,-1932041857,207578973,-487222358 },{
		options = {
			{
				event = "slotmachine:Init",
				label = "Caça-Níqueis",
				tunnel = "client"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ -1691644768,-742198632 },{
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher",
				tunnel = "products",
				service = "emptybottle"
			},
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			}
		},
		Distance = 0.75
	})

	AddTargetModel({ -935625561 },{
		options = {
			{
				event = "target:BedDeitar",
				label = "Deitar",
				tunnel = "client"
			},{
				event = "target:BedPickup",
				label = "Pegar",
				tunnel = "client"
			},{
				event = "target:BedDestroy",
				label = "Destruir",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:coffeeMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:donutMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:sodaMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:burgerMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:hotdogMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -272361894 },{
		options = {
			{
				event = "shops:Chihuahua",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:waterMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ 1281992692,1158960338,1511539537,-78626473,-429560270 },{
		options = {
			{
				event = "hup:phoneObject",
				label = "Ligar",
				tunnel = "client"
			}
		},
		Distance = 1.0
	})

	AddTargetModel({ -206690185,666561306,218085040,-58485588,1511880420,682791951 },{
		options = {
			{
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			},{
				event = "player:checkTrash",
				label = "Verificar",
				tunnel = "server"
			},{
				event = "chest:Open",
				label = "Abrir",
				tunnel = "entity",
				service = "Custom"
			}
		},
		Distance = 0.75
	})

	AddCircleZone("Juice01",vec3(-1189.37,-905.32,14.53),0.5,{
		name = "Juice01",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher Copo",
				tunnel = "products",
				service = "burgershot1"
			}
		}
	})

	AddCircleZone("Burger01",vec3(-1202.74,-897.66,13.93),0.5,{
		name = "Burger01",
		heading = 3374176
	},{
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Lanche",
				tunnel = "products",
				service = "burgershot2"
			}
		}
	})

	AddCircleZone("Box01",vec3(-1198.27,-892.84,14.31),0.5,{
		name = "Box01",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Combo",
				tunnel = "products",
				service = "burgershot3"
			}
		}
	})

	AddCircleZone("Juice02",vec3(810.69,-764.58,26.77),0.5,{
		name = "Juice02",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher Copo",
				tunnel = "products",
				service = "pizzathis1"
			}
		}
	})

	AddCircleZone("Burger02",vec3(807.68,-762.3,26.77),0.5,{
		name = "Burger02",
		heading = 3374176
	},{
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Lanche",
				tunnel = "products",
				service = "pizzathis2"
			}
		}
	})

	AddCircleZone("Box02",vec3(809.87,-761.15,26.77),0.5,{
		name = "Box02",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Combo",
				tunnel = "products",
				service = "pizzathis3"
			}
		}
	})

	AddCircleZone("Juice03",vec3(-590.36,-1058.54,22.34),0.5,{
		name = "Juice03",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher Copo",
				tunnel = "products",
				service = "uwucoffee1"
			}
		}
	})

	AddCircleZone("Burger03",vec3(-590.49,-1056.51,22.36),0.5,{
		name = "Burger03",
		heading = 3374176
	},{
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Lanche",
				tunnel = "products",
				service = "uwucoffee2"
			}
		}
	})

	AddCircleZone("Box03",vec3(-590.5,-1063.02,22.36),0.5,{
		name = "Box03",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Combo",
				tunnel = "products",
				service = "uwucoffee3"
			}
		}
	})

	AddCircleZone("Juice04",vec3(126.28,-1035.83,29.27),0.5,{
		name = "Juice04",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Encher Copo",
				tunnel = "products",
				service = "beanmachine1"
			}
		}
	})

	AddCircleZone("Burger04",vec3(122.31,-1038.35,29.27),0.5,{
		name = "Burger04",
		heading = 3374176
	},{
		Distance = 1.0,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Lanche",
				tunnel = "products",
				service = "beanmachine2"
			}
		}
	})

	AddCircleZone("Box04",vec3(122.79,-1044.03,29.27),0.5,{
		name = "Box04",
		heading = 3374176
	},{
		Distance = 1.25,
		options = {
			{
				event = "inventory:MakeProducts",
				label = "Montar Combo",
				tunnel = "products",
				service = "beanmachine3"
			}
		}
	})

	AddCircleZone("tabletVehicles01",vec3(-38.9,-1100.22,27.26),0.5,{
		name = "tabletVehicles01",
		heading = 3374176
	},{
		shop = "Santos",
		Distance = 1.0,
		options = {
			{
				event = "tablet:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles02",vec3(-40.37,-1094.57,27.26),0.5,{
		name = "tabletVehicles02",
		heading = 3374176
	},{
		shop = "Santos",
		Distance = 1.0,
		options = {
			{
				event = "tablet:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles03",vec3(-46.87,-1095.5,27.26),0.5,{
		name = "tabletVehicles03",
		heading = 3374176
	},{
		shop = "Santos",
		Distance = 1.0,
		options = {
			{
				event = "tablet:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles04",vec3(-51.59,-1094.98,27.26),0.5,{
		name = "tabletVehicles04",
		heading = 3374176
	},{
		shop = "Santos",
		Distance = 1.0,
		options = {
			{
				event = "tablet:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles05",vec3(-51.15,-1087.13,27.26),0.5,{
		name = "tabletVehicles05",
		heading = 3374176
	},{
		shop = "Santos",
		Distance = 1.0,
		options = {
			{
				event = "tablet:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("tabletVehicles06",vec3(1224.78,2728.01,38.0),0.5,{
		name = "tabletVehicles06",
		heading = 3374176
	},{
		shop = "Sandy",
		Distance = 2.0,
		options = {
			{
				event = "tablet:Open",
				label = "Abrir",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("cemiteryMan",vec3(-1745.57,-205.19,57.37),0.5,{
		name = "cemiteryMan",
		heading = 3374176
	},{
		Distance = 1.0,
		options = {
			{
				event = "cemitery:initBody",
				label = "Conversar",
				tunnel = "client"
			}
		}
	})

	AddCircleZone("CassinoWheel",vec3(988.37,43.06,71.3),0.5,{
		name = "CassinoWheel",
		heading = 3374176
	},{
		Distance = 1.5,
		options = {
			{
				event = "luckywheel:Target",
				label = "Roda da Fortuna",
				tunnel = "client"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local CooldownWarMode = GetGameTimer()
local AddedBox = {}
function TargetEnable()
    LocalPlayer["state"]["Target"] = true
    local inWarMode = false
    local Ped = PlayerPedId()
    AddedBox = {}
    if not GlobalState["Premios"] then
        TriggerEvent("RewardsDisable",false)
    end
    if not GlobalState["AssaultHourDisable"] then
        TriggerEvent("AssaultHourDisable",false)
    end
    while true do
        local BoxProps = GetGamePool("CObject")
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        for i=1,#BoxProps do
            local Prop = BoxProps[i]
            if not LocalPlayer["state"]["GreenMode"] then
                if GetEntityModel(Prop) == `p_secret_weapon_02` and not AddedZone[Prop] then
                    local PropCoords = GetEntityCoords(Prop)
                    local Distance = #( Coords - PropCoords)
                    if Distance <= 50 then
                        local Name = "Airdrop:"..Prop
                        AddedZone[Prop] = Name
                        AddBoxZone(Name,PropCoords,2.5,2.5,{
                            name = Name,
                            heading = 3374176,
                            minZ = PropCoords["z"] - 2.0,
                            maxZ = PropCoords["z"] + 2.0
                        },{
                            shop = Prop,
                            Distance = 5.25,
                            options = {
                                {
                                    event = "Airdrop:TryToOpen",
                                    label = "Lootear",
									tunnel = "client",
                                }
                            }
                        })
                    end
                end
            end
            if GetEntityModel(Prop) == `ch_prop_box_ammo01b` and not AddedZone[Prop] then
                local PropCoords = GetEntityCoords(Prop)
                local Distance = #( Coords - PropCoords)
                if Distance <= 50 then
                    local objNet = 0
                    if NetworkGetEntityIsNetworked(Prop) then
                        objNet = ObjToNet(Prop)
                    end
                    local Id = Entity(tonumber(Prop))["state"]["User"] or Entity(tonumber(objNet))["state"]["User"] or "0"
                    local Name = "Box:"..Prop
                    AddedZone[Prop] = Name
                    table.insert(AddedBox,{Prop,PropCoords})
                    AddBoxZone(Name,PropCoords,0.75,0.75,{
                        name = Name,
                        heading = 3374176,
                        minZ = PropCoords["z"] - 0.30,
                        maxZ = PropCoords["z"] + 0.30
                    },{
                        shop = Prop,
                        Distance = 5.25,
                        options = {
                            {
                                event = "admin:Report",
                                label = Id.." Reportar",
                                tunnel = "reportBox"
                            }
                        }
                    })
                end
            end
        end
        break
    end

    CreateThread(function()
        while LocalPlayer["state"]["Target"] do
            local Peds = GetGamePool("CPed")
            for i=1,#Peds do
                local SelectedPed = Peds[i]
                if IsPedAPlayer(SelectedPed) then
                    local Newbie = Entity(SelectedPed)["state"]["Newbie"]
                    local Coords = GetEntityCoords(SelectedPed)
                    local Distance = #(GetEntityCoords(Ped) - Coords)
                    if Newbie and Distance <= 20 then
                        DrawMarker(23,Coords["x"],Coords["y"],Coords["z"] - 0.97,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,46,110,76,100,0,0,0,0)
                    end
                end
            end
            Wait(1)
        end
        if not GlobalState["Premios"] then
            TriggerEvent("RewardsDisable",true)
        end
        if not GlobalState["AssaultHourDisable"] then
            TriggerEvent("AssaultHourDisable",true)
        end
    end)

    CreateThread(function()
        while LocalPlayer["state"]["Target"] do
            local Players = GetActivePlayers()
            for i=1,#Players do
                local SelectedPlayer = Players[i]
                if NetworkIsPlayerTalking(SelectedPlayer) then
                    local PlayerPed = GetPlayerPed(SelectedPlayer)
                    local Coords = GetEntityCoords(PlayerPed)
                    local Distance = #(GetEntityCoords(Ped) - Coords)
                    if Distance <= 20 then
                        DrawMarker(23,Coords["x"],Coords["y"],Coords["z"] - 0.97,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,0.0,46,110,76,100,0,0,0,0)
                    end
                end
            end
            Wait(1)
        end
    end)

    -- CreateThread(function()
    --     while LocalPlayer["state"]["Target"] do
    --         for i=1,#AddedBox do
    --             if AddedBox[i][1] and AddedBox[i][2] then
    --                 local Coords = AddedBox[i][2]    
    --                 local Id = Entity(Selected)["state"]["User"]
    --                 local Distance = #(GetEntityCoords(Ped) - Coords)
    --                 if Distance <= 20 then
    --                     DrawText(Coords["x"],Coords["y"],Coords["z"]+1.0,Id)
    --                 end
    --             end
    --         end
    --         Wait(1)
    --     end
    -- end)

    if GlobalState["WarMode"] then
        local Ped = PlayerPedId()
        inWarMode = Entity(Ped)["state"]["WarMode"]
        CreateThread(function()
            while LocalPlayer["state"]["Target"] do
                local Peds = GetGamePool("CPed")
                for i=1,#Peds do
                    local SelectedPed = Peds[i]
                    if IsPedAPlayer(SelectedPed) then
                        local Distance = #(GetEntityCoords(Ped) - GetEntityCoords(SelectedPed))
                        local WarMode = Entity(SelectedPed)["state"]["WarMode"]
                        local Muted = Entity(SelectedPed)["state"]["Muted"]
                        if IsEntityVisible(SelectedPed) and HasEntityClearLosToEntity(Ped,SelectedPed,17) then
                            if Distance <= 50.0 and WarMode or Muted then
                                local Coords = GetEntityCoords(SelectedPed)
                                if WarMode then
                                    DrawText(Coords["x"],Coords["y"],Coords["z"]+1.1,"🔻")
                                end
                                if Muted then
                                    DrawText(Coords["x"],Coords["y"],Coords["z"]+0.95,"🔇")
                                end
                            end
                        end
                    end
                end
                Wait(1)
            end
        end)
    end

	if LocalPlayer["state"]["Active"] and not IsPauseMenuActive() and not LocalPlayer["state"]["Carregar"] then
		local Ped = PlayerPedId()

		if GetEntityHealth(Ped) <= 100 or LocalPlayer["state"]["Buttons"] or LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or Sucess or IsPedInAnyVehicle(Ped) or LocalPlayer["state"]["Route"] > 900000 then
			return
		end

		SendNUIMessage({ Action = "Open" })

        CreateThread(function()
            while LocalPlayer["state"]["Target"] do
                local Peds = GetGamePool("CPed")
                for i=1,#Peds do
                    local SelectedPed = Peds[i]
                    if IsPedAPlayer(SelectedPed) then
                        local Newbie = Entity(SelectedPed)["state"]["Newbie"]
                        local Title = Entity(SelectedPed)["state"]["Title"]
                        local VIP = Entity(SelectedPed)["state"]["VipEmote"]
                        if Newbie then
                            Title = "Iniciante"
                        end
                        local Distance = #(GetEntityCoords(Ped) - GetEntityCoords(SelectedPed))
                        if Distance <= 5.0 and IsEntityVisible(SelectedPed) and HasEntityClearLosToEntity(Ped,SelectedPed,17) and Entity(SelectedPed)["state"]["Title"] then
                            local Coords = GetEntityCoords(SelectedPed)
                            DrawText(Coords["x"],Coords["y"],Coords["z"]+1.0,Title)
                        end
                        if VIP and Distance <= 5.0 and IsEntityVisible(SelectedPed) and HasEntityClearLosToEntity(Ped,SelectedPed,17) then
                            local Coords = GetEntityCoords(SelectedPed)
                            DrawText(Coords["x"],Coords["y"],Coords["z"]+1.11,VIP)
                        end
                    end
                end
                Wait(1)
            end
        end)

		while LocalPlayer["state"]["Target"] do
			local hitZone,entCoords,entity = RayCastGamePlayCamera()

			if hitZone == 1 then
				local Coords = GetEntityCoords(Ped)

				for k,v in pairs(Zones) do
					if Zones[k]:isPointInside(entCoords) then
						if #(Coords - Zones[k]["center"]) <= v["targetoptions"]["Distance"] then

							if v["targetoptions"]["shop"] ~= nil then
								Selected = v["targetoptions"]["shop"]
							end

							SendNUIMessage({ Action = "Valid", data = Zones[k]["targetoptions"]["options"] })

							Sucess = true
							while Sucess do
								local Ped = PlayerPedId()
								local Coords = GetEntityCoords(Ped)
								local _,entCoords = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if not Zones[k]:isPointInside(entCoords) or #(Coords - Zones[k]["center"]) > v["targetoptions"]["Distance"] then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ Action = "Left" })
						end
					end
				end

				if GetEntityType(entity) ~= 0 then
					--print(GetEntityModel(entity),entCoords) -- Hash da porta
					if IsEntityAVehicle(entity) then
						local Plate = GetVehicleNumberPlateText(entity)
						if #(Coords - entCoords) <= 1.0 and Plate ~= "PDMSPORT" then
							local Network = nil
							local Combustivel = false
							local vehModel = GetEntityModel(entity)
							SetEntityAsMissionEntity(entity,true,true)

							if NetworkGetEntityIsNetworked(entity) then
								Network = VehToNet(entity)
							end

							Selected = { Plate,vRP.VehicleModel(entity),entity,Network }

							local Menu = {}

							for _,v in pairs(Fuels) do
								local Distance = #(Coords - vec3(v[1],v[2],v[3]))
								if Distance <= 2.5 then
									Combustivel = true
									break
								end
							end

							if not Combustivel then
								if GetSelectedPedWeapon(Ped) == 883325847 then
									Selected[5] = true
									table.insert(Menu,{ event = "engine:Supply", label = "Abastecer", tunnel = "client" })
								else
									if GetVehicleDoorLockStatus(entity) == 1 then
										for k,Tyre in pairs(tyreList) do
											local Wheel = GetEntityBoneIndexByName(entity,k)
											if Wheel ~= -1 then
												local cWheel = GetWorldPositionOfEntityBone(entity,Wheel)
												local Distance = #(Coords - cWheel)
												if Distance <= 1.0 then
													Selected[5] = Tyre
													table.insert(Menu,{ event = "inventory:RemoveTyres", label = "Retirar Pneu", tunnel = "client" })
												end
											end
										end

										table.insert(Menu,{ event = "trunkchest:openTrunk", label = "Abrir Porta-Malas", tunnel = "server" })
										table.insert(Menu,{ event = "player:checkTrunk", label = "Checar Porta-Malas", tunnel = "server" })
									end

                                    if LocalPlayer["state"]["Mechanic"] then
                                        table.insert(Menu,{ event = "target:FixVehicle", label = "Reparar Veículo", tunnel = "server" })
                                    end

									table.insert(Menu,{ event = "garages:Key", label = "Criar Chave Cópia", tunnel = "police" })
									table.insert(Menu,{ event = "inventory:applyPlate", label = "Trocar Placa", tunnel = "server" })
                                    table.insert(Menu,{ event = "animation:CleanVeh", label = "Limpar Veiculo", tunnel = "client" })

									if not IsThisModelABike(vehModel) then
										local Rolling = GetEntityRoll(entity)
										if Rolling > 75.0 or Rolling < -75.0 then
											table.insert(Menu,{ event = "player:RollVehicle", label = "Desvirar", tunnel = "server" })
										else
											if GetEntityBoneIndexByName(entity,"boot") ~= -1 then
												local Trunk = GetEntityBoneIndexByName(entity,"boot")
												local cTrunk = GetWorldPositionOfEntityBone(entity,Trunk)
												local Distance = #(Coords - cTrunk)
												if Distance <= 1.25 then
													if GetVehicleDoorLockStatus(entity) == 1 then
														--table.insert(Menu,{ event = "player:enterTrunk", label = "Entrar no Porta-Malas", tunnel = "client" })
	
													end

													table.insert(Menu,{ event = "inventory:StealTrunk", label = "Arrombar Porta-Malas", tunnel = "client" })
												end
											end
										end
									end

									if LocalPlayer["state"]["Policia"] then
										table.insert(Menu,{ event = "police:Plate", label = "Verificar Placa", tunnel = "police" })
										table.insert(Menu,{ event = "police:Impound", label = "Registrar Veículo", tunnel = "police" })
										table.insert(Menu,{ event = "police:Arrest", label = "Apreender Veículo", tunnel = "police" })
									end

									for _,v in pairs(Dismantles) do
                                        if Entity(entity)["state"]["Spawned"] then
                                            if #(Coords - v) <= 20 then
                                                table.insert(Menu,{ event = "inventory:Dismantle", label = "Desmanchar", tunnel = "client" })
                                                break
                                            end
                                        end
									end

									for _,v in pairs(Tows) do
										if #(Coords - v) <= 10 then
											table.insert(Menu,{ event = "towdriver:Tow", label = "Rebocar", tunnel = "client" })
											table.insert(Menu,{ event = "impound:Check", label = "Impound", tunnel = "police" })
										end
									end

									table.insert(Menu,{ event = "engine:Vehrify", label = "Verificar", tunnel = "client" })
								end
							else
								Selected[5] = false
								table.insert(Menu,{ event = "engine:Supply", label = "Abastecer", tunnel = "client" })
							end

							SendNUIMessage({ Action = "Valid", data = Menu })

							Sucess = true
							while Sucess do
								local Ped = PlayerPedId()
								local Coords = GetEntityCoords(Ped)
								local _,entCoords,entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(Coords - entCoords) > 5.0 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ Action = "Left" })
						end
					elseif IsPedAPlayer(entity) then
                        local id = Entity(entity)["state"]["User"] or 0
						if #(Coords - entCoords) <= 5.0 then
							local index = NetworkGetPlayerIndexFromPed(entity)
							local source = GetPlayerServerId(index)
							local Menu = {}

							Selected = { source,entity }

							if LocalPlayer["state"]["Policia"] then
								table.insert(Menu,{ event = "police:Apreender", label = "Apreender Itens", tunnel = "police" })
								-- table.insert(Menu,{ event = "police:prisonClothes", label = "Roupa de TAF", tunnel = "police" })
                                if GetEntityHealth(entity) <= 100 then
                                    table.insert(Menu,{ event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" })
                                end
							elseif LocalPlayer["state"]["Paramedic"] then
								if GetEntityHealth(entity) <= 100 then
									table.insert(Menu,{ event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" })
								else
									table.insert(Menu,{ event = "paramedic:Treatment", label = "Tratamento", tunnel = "paramedic" })
									-- table.insert(Menu,{ event = "paramedic:Reposed", label = "Colocar de Repouso", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:Bandage", label = "Passar Ataduras", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:presetBurn", label = "Roupa de Queimadura", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:presetPlaster", label = "Colocar Gesso", tunnel = "paramedic" })
									table.insert(Menu,{ event = "paramedic:extractBlood", label = "Extrair Sangue", tunnel = "paramedic" })
                                    table.insert(Menu,{ event = "barbershop:Medic", label = "Aplicar plástica", tunnel = "paramedic" })
								end

								table.insert(Menu,{ event = "paramedic:Diagnostic", label = "Informações", tunnel = "paramedic" })
								table.insert(Menu,{ event = "paramedic:Bed", label = "Deitar Paciente", tunnel = "paramedic" })
							end

							if IsEntityPlayingAnim(entity,"random@mugging3","handsup_standing_base",3) then
								table.insert(Menu,{ event = "player:checkShoes", label = "Roubar Sapatos", tunnel = "paramedic" })
							end

                            if Entity(entity)["state"]["Instagram"] and Entity(entity)["state"]["Instagram"] ~= "" then
                                table.insert(Menu,{ event = "target:Instagram", label = "<img src='https://cdn.discordapp.com/attachments/1118308625526554736/1138937137799118928/esse.png'/> @"..Entity(entity)["state"]["Instagram"].."", tunnel = "paramedic" })
                            end

                            
                            if GlobalState["AllRevive"] then
                                if GetEntityHealth(entity) <= 100 and LocalPlayer["state"]["Route"] == 1 then
                                    if IsEntityPlayingAnim(entity,"misstrevor3_beatup","guard_beatup_exit_dockworker",3) then
                                        table.insert(Menu,{ event = "target:SetLife", label = "Reanimar", tunnel = "paramedic" })
                                    end
                                end
                            end


                            if Entity(entity)["state"]["TikTok"] and Entity(entity)["state"]["TikTok"] ~= "" then
                                table.insert(Menu,{ event = "target:TikTok", label = "<img src='https://media.discordapp.net/attachments/1118308625526554736/1139236270040690738/pngwing.com.png'/> @"..Entity(entity)["state"]["TikTok"].."", tunnel = "paramedic" })
                            end

							-- local Reputation = vPLAYER.GetReputation(source)

                            if not LocalPlayer["state"]["Newbie"] and not LocalPlayer["state"]["GreenMode"] and not LocalPlayer["state"]["InSafeZone"] and not LocalPlayer["state"]["PVP"] then
							    table.insert(Menu,{ event = "police:runInspect", label = "Revistar", tunnel = "police" })
                            end

							-- table.insert(Menu,{ event = "player:MaisReputacao", label = "👍 LIKE ("..Reputation[1]..")", tunnel = "paramedic" })

							-- table.insert(Menu,{ event = "player:MenosReputacao", label = "👎 TÓXICO ("..Reputation[2]..")", tunnel = "paramedic" })
                            if SafeMode == "true" then
                                if GlobalState["WarMode"] and not LocalPlayer["state"]["InSafeZone"] then
                                    if inWarMode and not Entity(entity)["state"]["WarMode"] then
                                        if GetGameTimer() > CooldownWarMode then
                                            table.insert(Menu,{ event = "WarMode:Enter", label = "Modo Guerra", tunnel = "warmode" })
                                        end
                                    end
                                end
                            end

							-- TriggerServerEvent(Data["event"],Selected[1],Data["service"])

                            -- table.insert(Menu,{ event = "player:Zaralho", label = "👎REPORTAR", tunnel = "report" })

							table.insert(Menu,{ event = "player:Relationship", label = "❤️ Namorar", tunnel = "paramedic" })

							SendNUIMessage({ Action = "Valid", data = Menu })

							Sucess = true
							while Sucess do
								local Ped = PlayerPedId()
								local Coords = GetEntityCoords(Ped)
								local _,entCoords,entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(Coords - entCoords) > 5.0 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ Action = "Left" })
						end
					else
						for k,v in pairs(Models) do
							if DoesEntityExist(entity) then
								if k == GetEntityModel(entity) then
									if #(Coords - entCoords) <= Models[k]["Distance"] then
										local objNet = nil
										if NetworkGetEntityIsNetworked(entity) then
											objNet = ObjToNet(entity)
										end

										Selected = { entity,k,objNet,GetEntityCoords(entity) }

										SendNUIMessage({ Action = "Valid", data = Models[k]["options"] })

										Sucess = true
										while Sucess do
											local Ped = PlayerPedId()
											local Coords = GetEntityCoords(Ped)
											local _,entCoords,entity = RayCastGamePlayCamera()

											if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
												SetCursorLocation(0.5,0.5)
												SetNuiFocus(true,true)
											end

											if GetEntityType(entity) == 0 or #(Coords - entCoords) > Models[k]["Distance"] then
												Sucess = false
											end

											Wait(1)
										end

										SendNUIMessage({ Action = "Left" })
									end
								end
							end
						end
					end
				end
			end

			Wait(100)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ROLLVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:RollVehicle")
AddEventHandler("target:RollVehicle",function(Network)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			SetVehicleOnGroundProperly(Vehicle)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function TargetDisable()
	if Sucess or not LocalPlayer["state"]["Target"] then
		return
	end
    for Zone,Name in pairs(AddedZone) do
        RemCircleZone(Name)
        AddedZone[Zone] = nil
    end
	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]["Target"] = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECT
-----------------------------------------------------------------------------------------------------------------------------------------
local ReportCooldown = GetGameTimer()
local BoxReportCooldown = GetGameTimer()
RegisterNUICallback("Select",function(Data,Callback)
    if not LocalPlayer["state"]["Target"] then
        return
    end
	Sucess = false
	SetNuiFocus(false,false)
	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]["Target"] = false

    for Zone,Name in pairs(AddedZone) do
        RemCircleZone(Name)
        AddedZone[Zone] = nil
    end

	if Data["tunnel"] == "client" then
		TriggerEvent(Data["event"],Selected)
	elseif Data["tunnel"] == "shop" then
		TriggerEvent(Data["event"],Selected,Data["service"])
	elseif Data["tunnel"] == "entity" then
		TriggerEvent(Data["event"],Selected[1],Data["service"])
	elseif Data["tunnel"] == "products" then
		TriggerEvent(Data["event"],Data["service"])
	elseif Data["tunnel"] == "Airdrop" then
		TriggerServerEvent(Data["event"],Entity(Selected)["state"]["Entity"])
	elseif Data["tunnel"] == "reportBox" then
        ReportBox = GetConvar("ReportBox", "")
        if ReportBox == "false" then
            TriggerEvent("Notify","aviso","Sistema temporariamente desativado",5000,"REPORT BOX")
			-- TriggerEvent("Notify2","#systemTempOff")
            return
        end
        if BoxReportCooldown > GetGameTimer() then
            TriggerEvent("Notify","vermelho","Você precisa esperar <b>"..parseInt((BoxReportCooldown - GetGameTimer()) / 1000).."</b> segundos para reportar novamente.",5000,"REPORTAR BOX")
			-- TriggerEvent("Notify2","#waitReportBox",{msg=parseInt((BoxReportCooldown - GetGameTimer()) / 1000)})
            return
        end
        BoxReportCooldown = GetGameTimer() + 30000
        TriggerServerEvent(Data["event"],Entity(Selected)["state"]["User"])
	elseif Data["tunnel"] == "server" then
		TriggerServerEvent(Data["event"],Selected)
	elseif Data["tunnel"] == "police" then
		TriggerServerEvent(Data["event"],Selected,Data["service"])
	elseif Data["tunnel"] == "report" then
        if ReportCooldown > GetGameTimer() then
            TriggerEvent("Notify","vermelho","Você precisa esperar <b>"..parseInt((ReportCooldown - GetGameTimer()) / 1000).."</b> segundos para reportar novamente.",5000,"REPORTAR")
			-- TriggerEvent("Notify2","#waitReportCD",{msg=parseInt((ReportCooldown - GetGameTimer()) / 1000)})
            return
        end
        ReportCooldown = GetGameTimer() + 30000
		TriggerServerEvent(Data["event"],Selected[1],Data["service"])
	elseif Data["tunnel"] == "warmode" then
        if CooldownWarMode > GetGameTimer() then
            TriggerEvent("Notify","vermelho","Você precisa esperar <b>"..parseInt((CooldownWarMode - GetGameTimer()) / 1000).."</b> segundos para usar o MODO GUERRA novamente.",5000,"MODO GUERRA")
			-- TriggerEvent("Notify2","#waitEnterWarMode",{msg=parseInt((CooldownWarMode - GetGameTimer()) / 1000)})
            return
        end
        if not LocalPlayer["state"]["Policia"] then 
            CooldownWarMode = GetGameTimer() + 15000
        end
		TriggerServerEvent(Data["event"],Selected[1])
	elseif Data["tunnel"] == "paramedic" then
		TriggerServerEvent(Data["event"],Selected[1],Data["service"])
	elseif Data["tunnel"] == "proserver" then
		TriggerServerEvent(Data["event"],Data["service"])
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	Sucess = false
	SetNuiFocus(false,false)
	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]["Target"] = false

    for Zone,Name in pairs(AddedZone) do
        RemCircleZone(Name)
        AddedZone[Zone] = nil
    end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Debug")
AddEventHandler("target:Debug",function()
	Sucess = false
	SetNuiFocus(false,false)
	SendNUIMessage({ Action = "Close" })
	LocalPlayer["state"]["Target"] = false

    for Zone,Name in pairs(AddedZone) do
        RemCircleZone(Name)
        AddedZone[Zone] = nil
    end

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local Rotation = GetGameplayCamRot()
	local Adjuste = vec3((math.pi / 180) * Rotation["x"],(math.pi / 180) * Rotation["y"],(math.pi / 180) * Rotation["z"])
	local direction = vec3(-math.sin(Adjuste[3]) * math.abs(math.cos(Adjuste[1])),math.cos(Adjuste[3]) * math.abs(math.cos(Adjuste[1])),math.sin(Adjuste[1]))

	return vec3(Coords[1] + direction[1] * Distance, Coords[2] + direction[2] * Distance, Coords[3] + direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera()
	local Ped = PlayerPedId()
	local Cam = GetGameplayCamCoord()
	local Cam2 = GetCoordsFromCam(10.0,Cam)
	local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,Cam2,-1,Ped,4)
	local a,Hit,Coords,b,entity = GetShapeTestResult(Handle)

	return Hit,Coords,entity
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(Name,Center,Radius,Options,Target)
	Zones[Name] = CircleZone:Create(Center,Radius,Options)
	Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(Name)
	if Zones[Name] then
		Zones[Name] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(Model,Options)
	for _,v in pairs(Model) do
		Models[v] = Options
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(Name,Center,Length,Width,Options,Target)
    Zones[Name] = BoxZone:Create(Center,Length,Width,Options)
    Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddBoxZone",AddBoxZone)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText(x,y,z,Message)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    font = RegisterFontId("Poppins")
    SetTextFont(font)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentString(Message)
        SetTextColour(255,215,0,255)
		SetTextScale(0.35,0.35)
        SetTextCentre(true)
        SetTextProportional(true)
		EndTextCommandDisplayText(_x,_y)
	end
end

RegisterCommand("instagram",function()
    local Keyboard = exports["keyboard"]:keySingle("Digite seu @ do instagram:")
    if Keyboard and Keyboard[1] then
        local Instagram = Keyboard[1]
        if Instagram ~= "" then
            Instagram = Instagram:gsub("[<>]","")
            Instagram = Instagram:gsub("@","")
            TriggerServerEvent("target:SetInstagram",Instagram)
            SetResourceKvp("Instagram",Instagram)
        else
            SetResourceKvp("Instagram","")
            TriggerServerEvent("target:RemInstagram")
        end
    else
        SetResourceKvp("Instagram","")
        TriggerServerEvent("target:RemInstagram")
    end
end)

RegisterCommand("TikTok",function()
    local Keyboard = exports["keyboard"]:keySingle("Digite seu @ do TikTok:")
    if Keyboard and Keyboard[1] then
        local TikTok = Keyboard[1]
        if TikTok ~= "" then
            TikTok = TikTok:gsub("[<>]","")
            TikTok = TikTok:gsub("@","")
            TriggerServerEvent("target:SetTikTok",TikTok)
            SetResourceKvp("TikTok",TikTok)
        else
            SetResourceKvp("TikTok","")
            TriggerServerEvent("target:RemTikTok")
        end
    else
        SetResourceKvp("TikTok","")
        TriggerServerEvent("target:RemTikTok")
    end
end)

RegisterNetEvent("vRP:Active")
AddEventHandler("vRP:Active",function()
    local Instagram = GetResourceKvpString("Instagram")
    if Instagram and Instagram ~= "" then
        TriggerServerEvent("target:SetInstagram",Instagram)
    end	
    local TikTok = GetResourceKvpString("TikTok")
    if TikTok and TikTok ~= "" then
        TriggerServerEvent("target:SetTikTok",TikTok)
    end	
end)

local Reviving = false
RegisterNetEvent("target:SetReviving")
AddEventHandler("target:SetReviving",function(Boolean)
    Reviving = Boolean
end)

AddEventHandler("actions:Cancel",function()
    if Reviving then
        TriggerEvent("Progress","Revivendo",0)
        TriggerServerEvent("target:StopReviving")
        Reviving = false
    end
end)
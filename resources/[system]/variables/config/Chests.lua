local Chests = {
	{ ["Name"] = "Policia-1", ["Coords"] = vec3(-946.66,-2038.31,9.4), ["Mode"] = "1" },
	{ ["Name"] = "Policia-2", ["Coords"] = vec3(-943.63,-2035.29,9.4), ["Mode"] = "1" },

	{ ["Name"] = "Paramedic-1", ["Coords"] = vec3(1135.4,-1540.45,35.38), ["Mode"] = "2" },
	{ ["Name"] = "Paramedic-2", ["Coords"] = vec3(1148.59,-1570.02,35.38), ["Mode"] = "2" },

	{ ["Name"] = "Mechanic-1", ["Coords"] = vec3(878.3,-2097.29,30.46), ["Mode"] = "2" },
	{ ["Name"] = "Mechanic-2", ["Coords"] = vec3(875.81,-2096.38,30.48), ["Mode"] = "2" },

	----------------------------------------------------------------------------------
	-- mansões exclusivas
	----------------------------------------------------------------------------------
	-- { ["Name"] = "Mansao01", ["Coords"] = vec3(-3211.09,775.64,14.07), ["Mode"] = "2" },	
}

local CityConfig = {
    ["Base"] = function()
		Chests[#Chests+1] = { ["Name"] = "Mansao06", ["Coords"] = vec3(-72.01,994.33,239.5), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mansao10", ["Coords"] = vec3(-1030.28,309.68,71.66), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mansao22", ["Coords"] = vec3(-808.65,175.06,76.73), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mansao23", ["Coords"] = vec3(-1466.14,-51.96,58.4), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mansao25", ["Coords"] = vec3(-1547.22,139.11,55.65), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mansao05", ["Coords"] = vec3(1403.86,1144.63,114.33), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Policia", ["Coords"] = vec3(2509.24,-357.53,94.09), ["Mode"] = "1" }
		Chests[#Chests+1] = { ["Name"] = "Policia-1", ["Coords"] = vec3(2519.93,-325.88,101.89), ["Mode"] = "1" }
	
		Chests[#Chests+1] = { ["Name"] = "Policia", ["Coords"] = vec3(2500.37,-423.63,94.58), ["Mode"] = "1" }
		Chests[#Chests+1] = { ["Name"] = "Policia-1", ["Coords"] = vec3(2509.28,-421.72,106.91), ["Mode"] = "1" }
	
		Chests[#Chests+1] = { ["Name"] = "Policia", ["Coords"] = vec3(-2358.54,3254.84,32.81), ["Mode"] = "1" } -- dp zancudo
		Chests[#Chests+1] = { ["Name"] = "Policia-1", ["Coords"] = vec3(-2361.24,3247.15,92.89), ["Mode"] = "1" } -- dp zancudo
	
		Chests[#Chests+1] = { ["Name"] = "Policia", ["Coords"] = vec3(1823.94,2477.32,62.85), ["Mode"] = "1" } -- prisao
		Chests[#Chests+1] = { ["Name"] = "Policia-1", ["Coords"] = vec3(1844.06,2574.12,46.02), ["Mode"] = "1" } -- prisao
	
		Chests[#Chests+1] = { ["Name"] = "Policia", ["Coords"] = vec3(1834.29,3677.16,38.87), ["Mode"] = "1" } -- dp sandy
		Chests[#Chests+1] = { ["Name"] = "Policia-1", ["Coords"] = vec3(1822.5,3667.9,34.19), ["Mode"] = "1" } -- dp sandy
	
		Chests[#Chests+1] = { ["Name"] = "Policia", ["Coords"] = vec3(-433.83,6004.29,36.99), ["Mode"] = "1" } -- dp paleto
		Chests[#Chests+1] = { ["Name"] = "Policia-1", ["Coords"] = vec3(-445.18,6019.51,32.28), ["Mode"] = "1" } -- dp paleto
	
		Chests[#Chests+1] = { ["Name"] = "Policia", ["Coords"] = vec3(448.3,-975.56,30.68), ["Mode"] = "1" } -- dp praça
		Chests[#Chests+1] = { ["Name"] = "Policia-1", ["Coords"] = vec3(437.49,-994.6,30.68), ["Mode"] = "1" } -- dp praça
	
		Chests[#Chests+1] = { ["Name"] = "Policia", ["Coords"] = vec3(-1877.35,3104.77,32.96), ["Mode"] = "1" } -- exercito
		Chests[#Chests+1] = { ["Name"] = "Policia-1", ["Coords"] = vec3(-1886.21,3109.86,32.92), ["Mode"] = "1" } -- exercito
	
		Chests[#Chests+1] = { ["Name"] = "Paramedic", ["Coords"] = vec3(1118.17,-1534.89,35.03), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Paramedic-1", ["Coords"] = vec3(1117.86,-1561.34,39.5), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Paramedic", ["Coords"] = vec3(1135.4,-1538.96,35.03), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Mechanic", ["Coords"] = vec3(822.18,-928.69,32.39), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mechanic-1", ["Coords"] = vec3(837.75,-933.45,32.39), ["Mode"] = "2" }
			-- bombeiros
		Chests[#Chests+1] = { ["Name"] = "Bombeiros-2", ["Coords"] = vec3(197.41,-1651.74,29.81), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bombeiros-3", ["Coords"] = vec3(207.41,-1659.38,29.81), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bombeiros-4", ["Coords"] = vec3(215.91,-1649.3,29.81), ["Mode"] = "2" }
	
			-- juridico
		Chests[#Chests+1] = { ["Name"] = "Juridico-2", ["Coords"] = vec3(-527.98,-185.7,43.35), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Juridico-4", ["Coords"] = vec3(-538.39,-196.57,43.35), ["Mode"] = "2" }
		--- DROGAS
		Chests[#Chests+1] = { ["Name"] = "Barragem-2", ["Coords"] = vec3(1314.4,-270.61,93.23), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Barragem-3", ["Coords"] = vec3(1334.42,-147.6,113.21), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Barragem-4", ["Coords"] = vec3(1273.2,-234.44,98.45), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Cartel-2", ["Coords"] = vec3(1395.12,1421.77,107.99), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Cartel-3", ["Coords"] = vec3(1447.17,1425.21,108.65), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Cartel-4", ["Coords"] = vec3(1412.11,1440.55,108.45), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Sindicato-2", ["Coords"] = vec3(2778.39,2688.3,56.06), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Sindicato-3", ["Coords"] = vec3(2750.4,2760.22,42.95), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Sindicato-4", ["Coords"] = vec3(2785.9,2704.08,55.87), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Vagos-2", ["Coords"] = vec3(353.65,-2033.15,22.39), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Vagos-3", ["Coords"] = vec3(288.68,-2066.5,17.78), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Vagos-4", ["Coords"] = vec3(337.46,-2011.89,22.39), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Umbrella-2", ["Coords"] = vec3(1020.53,3280.3,44.13), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Umbrella-3", ["Coords"] = vec3(1109.89,3276.12,37.49), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Umbrella-4", ["Coords"] = vec3(1034.3,3342.66,46.74), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Vermelhos-2", ["Coords"] = vec3(2198.31,92.04,229.07), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Vermelhos-3", ["Coords"] = vec3(2203.9,112.48,229.11), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Vermelhos-4", ["Coords"] = vec3(2232.48,75.0,246.97), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Amarelos-2", ["Coords"] = vec3(1838.09,453.21,166.66), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Amarelos-3", ["Coords"] = vec3(1848.86,482.34,172.49), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Amarelos-4", ["Coords"] = vec3(1820.47,406.75,166.66), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Verdes-2", ["Coords"] = vec3(2330.71,4018.92,41.08), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Verdes-3", ["Coords"] = vec3(2374.03,3992.8,36.06), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Verdes-4", ["Coords"] = vec3(2239.4,3994.66,33.7), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Laranjas-2", ["Coords"] = vec3(3589.76,3718.95,29.69), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Laranjas-4", ["Coords"] = vec3(3611.73,3751.51,28.68), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Brancos-2", ["Coords"] = vec3(1379.5,-767.89,69.13), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Brancos-3", ["Coords"] = vec3(1399.02,-741.17,72.15), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Brancos-4", ["Coords"] = vec3(1341.92,-695.3,70.25), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "LosAztecas-2", ["Coords"] = vec3(1301.08,-1712.37,54.93), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "LosAztecas-3", ["Coords"] = vec3(1249.94,-1724.94,59.41), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "LosAztecas-4", ["Coords"] = vec3(1309.19,-1725.4,54.53), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Rosas-2", ["Coords"] = vec3(1448.66,-2325.71,67.4), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Rosas-3", ["Coords"] = vec3(1469.75,-2440.64,66.81), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Rosas-4", ["Coords"] = vec3(1449.18,-2332.64,67.11), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Hollywood-2", ["Coords"] = vec3(2440.36,4974.89,46.81), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Hollywood-3", ["Coords"] = vec3(2436.11,4965.0,46.81), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Hollywood-4", ["Coords"] = vec3(2430.59,4968.68,46.83), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Hollywood-5", ["Coords"] = vec3(2433.75,4969.13,42.34), ["Mode"] = "2", ["Perms"] = { ["Take"] = 1, ["Store"] = 5 } }
	
		Chests[#Chests+1] = { ["Name"] = "Roxos-2", ["Coords"] = vec3(535.1,351.29,141.99), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Roxos-3", ["Coords"] = vec3(479.99,402.76,142.65), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Roxos-4", ["Coords"] = vec3(477.62,393.57,139.08), ["Mode"] = "2" }
	
		-- LAVAGEM
		Chests[#Chests+1] = { ["Name"] = "Ballas-2", ["Coords"] = vec3(100.5,-1962.4,20.84), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Ballas-3", ["Coords"] = vec3(1334.63,-147.56,113.23), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Ballas-4", ["Coords"] = vec3(111.8,-1972.4,21.33), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Bellagio-2", ["Coords"] = vec3(963.24,24.12,76.99), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bellagio-3", ["Coords"] = vec3(956.67,20.77,75.74), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bellagio-4", ["Coords"] = vec3(937.67,21.01,75.49), ["Mode"] = "2" }
	
	
		Chests[#Chests+1] = { ["Name"] = "Bahamas-2", ["Coords"] = vec3(168.69,732.4,208.6), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bahamas-3", ["Coords"] = vec3(162.41,704.68,208.21), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bahamas-4", ["Coords"] = vec3(179.17,681.45,207.45), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Luxor-2", ["Coords"] = vec3(-285.03,243.51,78.82), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Luxor-3", ["Coords"] = vec3(-305.7,200.63,88.14), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Luxor-4", ["Coords"] = vec3(-319.46,211.09,81.77), ["Mode"] = "2" }
		-- DESMANCHE
		Chests[#Chests+1] = { ["Name"] = "Groove-2", ["Coords"] = vec3(-150.32,-1599.66,35.03), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Groove-3", ["Coords"] = vec3(-167.94,-1534.86,35.1), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Groove-4", ["Coords"] = vec3(-152.66,-1594.06,35.03), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Outlaws-2", ["Coords"] = vec3(-770.94,-2596.89,17.66), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Outlaws-3", ["Coords"] = vec3(-768.32,-2585.23,17.66), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Outlaws-4", ["Coords"] = vec3(-765.05,-2558.29,13.58), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "TopGear-2", ["Coords"] = vec3(993.33,-2360.32,21.25), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "TopGear-3", ["Coords"] = vec3(819.3,-2365.05,30.19), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "TopGear-4", ["Coords"] = vec3(960.26,-2391.41,22.33), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Redline-2", ["Coords"] = vec3(1377.18,-2085.99,48.21), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Redline-3", ["Coords"] = vec3(1390.42,-2080.97,52.6), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Redline-4", ["Coords"] = vec3(1373.37,-2085.9,48.21), ["Mode"] = "2" }
		
		Chests[#Chests+1] = { ["Name"] = "Bennys-2", ["Coords"] = vec3(-227.88,-1327.3,30.9), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bennys-3", ["Coords"] = vec3(-178.83,-1327.64,31.27), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bennys-4", ["Coords"] = vec3(-203.55,-1336.76,30.9), ["Mode"] = "2" }
		
		Chests[#Chests+1] = { ["Name"] = "DriftKing-2", ["Coords"] = vec3(-1141.0,-1557.0,7.62), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "DriftKing-3", ["Coords"] = vec3(-1153.27,-1522.24,10.63), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "DriftKing-4", ["Coords"] = vec3(-1145.38,-1550.62,4.43), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Overdrive-2", ["Coords"] = vec3(-599.23,-1616.76,33.01), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Overdrive-3", ["Coords"] = vec3(-580.57,-1589.68,26.74), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Overdrive-4", ["Coords"] = vec3(-619.92,-1617.83,33.01), ["Mode"] = "2" }
		-- MUNIÇÕES
		Chests[#Chests+1] = { ["Name"] = "Crips-2", ["Coords"] = vec3(-3031.3,85.86,12.82), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Crips-3", ["Coords"] = vec3(-3008.55,77.29,16.31), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Crips-4", ["Coords"] = vec3(-3016.99,71.78,12.27), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Marrons-2", ["Coords"] = vec3(1860.51,6411.93,47.5), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Marrons-3", ["Coords"] = vec3(1765.89,6402.84,36.43), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Marrons-4", ["Coords"] = vec3(2033.19,6471.37,91.29), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Cinzas-2", ["Coords"] = vec3(2237.07,3446.39,61.54), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Cinzas-3", ["Coords"] = vec3(2182.74,3389.19,45.68), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Cinzas-4", ["Coords"] = vec3(2213.71,3400.34,58.54), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "SonsofAnarchy-2", ["Coords"] = vec3(104.22,1207.15,207.19), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "SonsofAnarchy-3", ["Coords"] = vec3(226.96,1150.32,225.59), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "SonsofAnarchy-4", ["Coords"] = vec3(78.43,1236.03,201.2), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Sinaloa-2", ["Coords"] = vec3(2308.69,5554.63,49.99), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Sinaloa-3", ["Coords"] = vec3(2196.48,5596.51,53.78), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Sinaloa-4", ["Coords"] = vec3(2319.7,5531.27,51.64), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "HellsAngels-2", ["Coords"] = vec3(1023.24,933.67,218.66), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "HellsAngels-3", ["Coords"] = vec3(1023.08,925.07,216.6), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "HellsAngels-4", ["Coords"] = vec3(1032.24,948.86,222.65), ["Mode"] = "2" }
	
	
		Chests[#Chests+1] = { ["Name"] = "Triade-2", ["Coords"] = vec3(-565.12,240.02,74.88), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Triade-3", ["Coords"] = vec3(-596.57,209.52,74.17), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Triade-4", ["Coords"] = vec3(-579.04,229.86,74.88), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Yakuza-2", ["Coords"] = vec3(-2243.74,-259.55,46.35), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Yakuza-3", ["Coords"] = vec3(-2256.55,-298.16,41.33), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Yakuza-4", ["Coords"] = vec3(-2197.22,-279.56,35.79), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Warlocks-2", ["Coords"] = vec3(340.58,-2706.26,1.7), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Warlocks-3", ["Coords"] = vec3(325.13,-2733.13,5.98), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Warlocks-4", ["Coords"] = vec3(345.86,-2703.29,1.7), ["Mode"] = "2" }
		-- ARMAS
		Chests[#Chests+1] = { ["Name"] = "Bloods-2", ["Coords"] = vec3(-1556.13,-375.7,48.04), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bloods-3", ["Coords"] = vec3(-1542.58,-447.15,35.92), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Bloods-4", ["Coords"] = vec3(-1568.7,-404.99,48.26), ["Mode"] = "2" }
		
		Chests[#Chests+1] = { ["Name"] = "Playboy-2", ["Coords"] = vec3(-1547.19,138.99,55.65), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Playboy-3", ["Coords"] = vec3(-1536.29,98.18,56.77), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Playboy-4", ["Coords"] = vec3(-1530.26,152.8,60.44), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Mercenarios-2", ["Coords"] = vec3(-1047.41,302.64,71.66), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mercenarios-3", ["Coords"] = vec3(-1043.98,295.34,66.78), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mercenarios-4", ["Coords"] = vec3(-1025.52,305.35,66.99), ["Mode"] = "2" }
		
		Chests[#Chests+1] = { ["Name"] = "Gringa-2", ["Coords"] = vec3(1102.62,-2023.39,43.84), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Gringa-3", ["Coords"] = vec3(979.92,-1981.81,30.67), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Gringa-4", ["Coords"] = vec3(1070.81,-2006.09,32.08), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Franca-2", ["Coords"] = vec3(-1618.58,526.94,124.03), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Franca-3", ["Coords"] = vec3(-1651.33,470.92,117.38), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Franca-3", ["Coords"] = vec3(-1574.37,377.75,98.66), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Franca-4", ["Coords"] = vec3(-1532.38,307.32,83.36), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Franca-4", ["Coords"] = vec3(-1617.5,420.57,108.7), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Italia-4", ["Coords"] = vec3(413.56,-1498.31,33.8), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Italia-2", ["Coords"] = vec3(416.55,-1484.37,33.8), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Russia-2", ["Coords"] = vec3(-1890.52,2063.78,145.57), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Russia-3", ["Coords"] = vec3(-1913.24,2085.79,140.38), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Russia-4", ["Coords"] = vec3(-1881.59,2060.72,140.98), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Israel-2", ["Coords"] = vec3(2526.99,4109.37,38.59), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Israel-3", ["Coords"] = vec3(9.92,3698.09,39.61), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Israel-4", ["Coords"] = vec3(2531.5,4121.64,38.59), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Mexico-2", ["Coords"] = vec3(900.02,382.55,124.91), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mexico-3", ["Coords"] = vec3(864.08,311.39,109.12), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mexico-3", ["Coords"] = vec3(948.15,445.43,121.08), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mexico-4", ["Coords"] = vec3(938.01,386.54,112.51), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Mexico-4", ["Coords"] = vec3(839.58,321.91,118.39), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "China-2", ["Coords"] = vec3(3120.84,5086.62,22.44), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "China-3", ["Coords"] = vec3(3251.99,5136.19,20.08), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "China-4", ["Coords"] = vec3(3131.87,5090.46,22.44), ["Mode"] = "2" }
	
		Chests[#Chests+1] = { ["Name"] = "Noxus-2", ["Coords"] = vec3(-2679.25,2335.55,21.13), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Noxus-2", ["Coords"] = vec3(-2759.8,2388.3,6.49), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Noxus-3", ["Coords"] = vec3(-2678.86,2334.82,17.78), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Noxus-3", ["Coords"] = vec3(-2777.12,2345.58,3.93), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Noxus-4", ["Coords"] = vec3(-2755.93,2278.33,21.82), ["Mode"] = "2" }
		Chests[#Chests+1] = { ["Name"] = "Noxus-5", ["Coords"] = vec3(-2748.81,2326.15,15.7), ["Mode"] = "2", ["Perms"] = { ["Take"] = 1, ["Store"] = 5 } }
    end,
}

CreateThread(function()
	if CityConfig[cityName] then
        CityConfig[cityName]()
    end

    local Table = {}

    for _,v in pairs(Chests) do
        table.insert(Table,{ v["Coords"][1],v["Coords"][2],v["Coords"][3],1.25,"Alt","Baú","Utilize o target" })
    end

    TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetChests",function()
	return Chests
end)
local cityName = GetConvar("cityName","Base")

local Locations = {
    [23] = { Coords = vec3(1837.91,2590.25,46.19), Hash = 539686410, Lock = true, Distance = 1.5, Perm = "Policia" },
	[24] = { Coords = vec3(1768.54,2498.41,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[25] = { Coords = vec3(1765.40,2496.59,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[26] = { Coords = vec3(1762.25,2494.77,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[27] = { Coords = vec3(1755.96,2491.14,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[28] = { Coords = vec3(1752.81,2489.33,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[29] = { Coords = vec3(1749.67,2487.51,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[30] = { Coords = vec3(1758.07,2475.39,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[31] = { Coords = vec3(1761.22,2477.20,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[32] = { Coords = vec3(1764.36,2479.02,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[33] = { Coords = vec3(1767.51,2480.84,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[34] = { Coords = vec3(1770.66,2482.65,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[35] = { Coords = vec3(1773.80,2484.47,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[36] = { Coords = vec3(1776.95,2486.29,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Policia" },
	[37] = { Coords = vec3(1861.75,3687.30,33.01), Hash = 1286535678, Lock = true, Distance = 7, Perm = "Policia" },
	[44] = { Coords = vec3(1813.55,3675.05,34.39), Hash = 2010487154, Lock = true, Distance = 1.5, Perm = "Policia" },
	[45] = { Coords = vec3(1810.13,3676.46,34.39), Hash = 2010487154, Lock = true, Distance = 1.5, Perm = "Policia" },
	[46] = { Coords = vec3(1808.62,3679.06,34.39), Hash = 2010487154, Lock = true, Distance = 1.5, Perm = "Policia" },
	[47] = { Coords = vec3(1807.13,3681.66,34.39), Hash = 2010487154, Lock = true, Distance = 1.5, Perm = "Policia" },

	[48] = { Coords = vec3(-445.37,6012.43,27.58), Hash = -594854737, Lock = true, Distance = 1.5, Perm = "Policia" },
	[49] = { Coords = vec3(-443.1,6014.52,27.58), Hash = -594854737, Lock = true, Distance = 1.5, Perm = "Policia" },
	[50] = { Coords = vec3(-789.11,-1211.98,3.56), Hash = 631614199, Lock = true, Distance = 1.5, Perm = "Policia" },
	[51] = { Coords = vec3(-784.52,-1216.23,3.56), Hash = 631614199, Lock = true, Distance = 1.5, Perm = "Policia" },
	[52] = { Coords = vec3(-787.04,-1213.74,3.56), Hash = 631614199, Lock = true, Distance = 1.5, Perm = "Policia" },

	[53] = { Coords = vec3(1845.26,2608.28,45.58), Hash = 741314661, Lock = true, Distance = 1.5, Perm = "Policia" },
	[54] = { Coords = vec3(1818.85,2608.48,45.6), Hash = 741314661, Lock = true, Distance = 1.5, Perm = "Policia" },

	[55] = { Coords = vec3(-3193.51,825.25,8.93), Hash = 2052512905, Lock = true, Distance = 7.0, Perm = "Mansao01" }, -- Mansao01

	[56] = { Coords = vec3(1127.1,-1567.21,39.53), Hash = -1337230745, Lock = true, Distance = 1.0, Perm = "Paramedic" },
	[57] = { Coords = vec3(1128.9,-1575.71,35.03), Hash = 1379556169, Lock = true, Distance = 1.0, Perm = "Paramedic" },
	[58] = { Coords = vec3(1128.77,-1576.53,35.03), Hash = 1379556169, Lock = true, Distance = 1.0, Perm = "Paramedic" },
	[59] = { Coords = vec3(1141.19,-1546.97,35.03), Hash = -1108204408, Lock = true, Distance = 1.0, Perm = "Paramedic" },
	[60] = { Coords = vec3(1139.42,-1533.05,35.03), Hash = -1600698396, Lock = true, Distance = 1.0, Perm = "Paramedic" },
	[61] = { Coords = vec3(1138.45,-1533.15,35.03), Hash = -1600698396, Lock = true, Distance = 1.0, Perm = "Paramedic" },
	[62] = { Coords = vec3(1135.76,-1536.87,35.03), Hash = -1337230745, Lock = true, Distance = 1.0, Perm = "Paramedic" },
	[63] = { Coords = vec3(1122.99,-1534.85,35.03), Hash = -1108204408, Lock = true, Distance = 1.0, Perm = "Paramedic" },
	[64] = { Coords = vec3(1141.13,-1541.76,35.03), Hash = -1337230745, Lock = true, Distance = 1.0, Perm = "Paramedic" },

	[4000] = { Coords = vec3(1290.32,-1577.32,51.32), Hash = -363096952, Lock = true, Distance = 1.5, Perm = "Crips" },
	[4001] = { Coords = vec3(613.17,-2769.36,6.05), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Yakuza" },
	[4002] = { Coords = vec3(613.17,-2769.36,6.05), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Yakuza" },

	[4003] = { Coords = vec3(1291.06,-1578.01,51.43), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Crips" },
	[4004] = { Coords = vec3(1290.56,-1576.73,51.31), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Crips" },
	[4005] = { Coords = vec3(1157.78,-1698.39,35.5), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Crips" },

	[4006] = { Coords = vec3(991.92,-2481.28,28.27), Hash = -1646581307, Lock = true, Distance = 1.5, Perm = "HellsAngels" },
	[4007] = { Coords = vec3(990.18,-2480.9,28.26), Hash = -1646581307, Lock = true, Distance = 1.5, Perm = "HellsAngels" },

	[4008] = { Coords = vec3(-1876.16,2040.23,140.21), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Russia" },
	[4009] = { Coords = vec3(-1886.38,2008.16,141.61), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Russia" },

	[4010] = { Coords = vec3(-1478.08,885.31,182.85), Hash = -1918480350, Lock = true, Distance = 1.5, Perm = "Mexico" },
	[4011] = { Coords = vec3(-1478.37,884.44,182.87), Hash = -349730013, Lock = true, Distance = 1.5, Perm = "Mexico" },

	[4012] = { Coords = vec3(-1800.3,473.68,133.69), Hash = 546378757, Lock = true, Distance = 1.5, Perm = "Franca" },
	[4013] = { Coords = vec3(-1799.92,472.9,133.69), Hash = -1249591818, Lock = true, Distance = 1.5, Perm = "Franca" },

	[4014] = { Coords = vec3(588.33,-2853.87,6.05), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Yakuza" },
	[4015] = { Coords = vec3(611.78,-2769.67,6.05), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Yakuza" },

	[4016] = { Coords = vec3(-637.54,187.28,66.78), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Triade" },

	[4017] = { Coords = vec3(297.72,-2011.68,19.97), Hash = 741314661, Lock = true, Distance = 1.5, Perm = "Vagos" },

	[4018] = { Coords = vec3(-332.37,231.06,86.3), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Luxor" },
	[4019] = { Coords = vec3(-295.95,242.48,88.63), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Luxor" },

	[4020] = { Coords = vec3(139.68,-1275.98,29.28), Hash = 741314661, Lock = true, Distance = 1.5, Perm = "Vanilla" },

	[4021] = { Coords = vec3(69.09,-1910.83,21.64), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Ballas" },

	[4022] = { Coords = vec3(-136.54,-1540.86,34.29), Hash = 741314661, Lock = true, Distance = 1.5, Perm = "Groove" },
	[4023] = { Coords = vec3(-145.83,-1717.81,30.11), Hash = 741314661, Lock = true, Distance = 1.5, Perm = "Groove" },

	[4024] = { Coords = vec3(1374.32,-2048.04,52.0), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Redline" },
	[4025] = { Coords = vec3(1434.23,-2054.54,55.32), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Redline" },

	[4026] = { Coords = vec3(896.89,-2351.19,30.48), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "TopGear" },
	[4027] = { Coords = vec3(837.51,-2352.73,30.33), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "TopGear" },

	[4028] = { Coords = vec3(243.13,1181.48,225.45), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "SonsofAnarchy" },

	[4029] = { Coords = vec3(926.88,49.59,81.1), Hash = 21324050, Lock = true, Distance = 1.0, Perm = "Bellagio" },
	[4030] = { Coords = vec3(926.14,48.27,81.1), Hash = 21324050, Lock = true, Distance = 1.0, Perm = "Bellagio" },
	[4031] = { Coords = vec3(925.4,47.19,81.1), Hash = 21324050, Lock = true, Distance = 1.0, Perm = "Bellagio" },
	[4032] = { Coords = vec3(924.72,45.93,81.1), Hash = 21324050, Lock = true, Distance = 1.0, Perm = "Bellagio" },
	[4033] = { Coords = vec3(923.87,44.55,81.1), Hash = 21324050, Lock = true, Distance = 1.0, Perm = "Bellagio" },
	[4034] = { Coords = vec3(923.17,43.47,81.1), Hash = 21324050, Lock = true, Distance = 1.0, Perm = "Bellagio" },

	[4035] = { Coords = vec3(1061.77,-1899.21,30.45), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Gringa" },

	[4036] = { Coords = vec3(651.38,-2740.89,6.15), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Yakuza" },
	[4037] = { Coords = vec3(594.26,-2704.5,6.07), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Yakuza" },

	[4038] = { Coords = vec3(-1532.22,-394.21,41.96), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Bloods" },
	[4039] = { Coords = vec3(-1515.89,-449.41,35.44), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Bloods" },

	[4040] = { Coords = vec3(1019.4,-2063.32,30.99), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Gringa" },
	[4041] = { Coords = vec3(959.52,-1920.89,31.09), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Gringa" },
	[4042] = { Coords = vec3(956.23,-1956.17,30.62), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Gringa" },
	[4043] = { Coords = vec3(1123.28,-2056.87,31.09), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Gringa" },

	[4044] = { Coords = vec3(-1918.31,2068.9,140.33), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Russia" },

	[4045] = { Coords = vec3(35.04,3608.44,39.73), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Israel" },
	[4046] = { Coords = vec3(82.08,3595.11,39.68), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Israel" },

	[4047] = { Coords = vec3(490.78,-1550.69,29.22), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Italia" },
	[4048] = { Coords = vec3(411.46,-1563.52,29.28), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Italia" },
	[4049] = { Coords = vec3(427.18,-1469.76,29.18), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Italia" },

	[4050] = { Coords = vec3(291.72,-2836.0,6.0), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Warlocks" },
	[4051] = { Coords = vec3(268.13,-2790.38,6.02), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Warlocks" },

	[4052] = { Coords = vec3(772.11,-2490.58,20.0), Hash = -1646581307, Lock = true, Distance = 5.5, Perm = "HellsAngels" },
	[4053] = { Coords = vec3(937.89,-2478.26,28.27), Hash = -1646581307, Lock = true, Distance = 5.5, Perm = "HellsAngels" },

	[4054] = { Coords = vec3(344.99,-1954.61,24.35), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Vagos" },
	[4055] = { Coords = vec3(380.43,-1969.18,24.1), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Vagos" },
	[4056] = { Coords = vec3(403.89,-1994.45,22.97), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Vagos" },
	[4057] = { Coords = vec3(432.27,-2100.23,20.81), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Vagos" },
	[4058] = { Coords = vec3(269.68,-2091.71,16.48), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Vagos" },
	[4059] = { Coords = vec3(260.06,-2055.98,17.47), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Vagos" },
	[4060] = { Coords = vec3(298.78,-2009.07,20.1), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Vagos" },

	[4061] = { Coords = vec3(-1356.54,-674.03,25.54), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Bahamas" },
	[4062] = { Coords = vec3(-1467.79,-680.87,26.56), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Bahamas" },
	[4063] = { Coords = vec3(-1452.56,-627.81,30.68), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Bahamas" },
	[4064] = { Coords = vec3(-1108.48,-1561.35,4.41), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "DriftKing" },
	[4065] = { Coords = vec3(-1159.95,-1596.31,4.36), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "DriftKing" },

	[4066] = { Coords = vec3(850.82,-2255.93,30.26), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "TopGear" },

	[4067] = { Coords = vec3(-860.75,-2687.47,13.78), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Outlaws" },
	[4068] = { Coords = vec3(-728.22,-2568.85,13.92), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Outlaws" },
	[4069] = { Coords = vec3(-733.08,-2565.6,13.92), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Outlaws" },

	[4070] = { Coords = vec3(140.96,-1274.83,29.22), Hash = 741314661, Lock = true, Distance = 5.5, Perm = "Vanilla" },

	[4071] = { Coords = vec3(31.8,-1824.21,26.1), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Ballas" },
	[4072] = { Coords = vec3(93.61,-1865.67,24.26), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Ballas" },

	[4073] = { Coords = vec3(825.62,-2445.52,25.24), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "TopGear" },

	[4074] = { Coords = vec3(653.06,-2740.62,6.17), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Yakuza" },

	[4075] = { Coords = vec3(1435.1,-2054.43,55.32), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Redline" },
	[4076] = { Coords = vec3(1375.18,-2047.3,52.0), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Redline" },

	[4077] = { Coords = vec3(1061.78,-1898.07,31.02), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Gringa" },

	[4078] = { Coords = vec3(426.14,-2018.13,22.95), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Vagos" },

	[4079] = { Coords = vec3(-31.8,-1824.21,26.1), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Ballas" },

	[4080] = { Coords = vec3(-178.27,-1506.29,32.62), Hash = 741314661, Lock = true, Distance = 5.5, Perm = "Groove" },
	[4081] = { Coords = vec3(-203.01,-1484.25,31.29), Hash = 741314661, Lock = true, Distance = 5.5, Perm = "Groove" },
	[4082] = { Coords = vec3(-181.34,-1759.5,29.89), Hash = 741314661, Lock = true, Distance = 5.5, Perm = "Groove" },

	[4083] = { Coords = vec3(-3003.87,116.38,15.69), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Crips" },

	[4084] = { Coords = vec3(1217.91,-287.86,69.84), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Barragem" },

	[4085] = { Coords = vec3(-654.03,-1640.74,25.58), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "TopGear" },

	[4086] = { Coords = vec3(1292.26,1428.07,101.03), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Cartel" },
	[4087] = { Coords = vec3(1553.6,1325.46,94.56), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Cartel" },
	[4088] = { Coords = vec3(1499.2,1583.31,112.35), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Cartel" },

	[4089] = { Coords = vec3(2592.51,2722.41,42.93), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Sindicato" },
	[4090] = { Coords = vec3(2808.95,2823.43,42.31), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Sindicato" },
	[4091] = { Coords = vec3(2898.45,2716.37,72.45), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Sindicato" },

	[4092] = { Coords = vec3(1118.91,3527.56,34.26), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Umbrella" },
	[4093] = { Coords = vec3(1112.42,3252.28,39.34), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Umbrella" },
	[4094] = { Coords = vec3(933.24,3224.6,38.86), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Umbrella" },

	[4095] = { Coords = vec3(2091.21,3863.68,33.56), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Verdes" },
	[4096] = { Coords = vec3(2433.16,3987.45,36.58), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Verdes" },

	[4097] = { Coords = vec3(1293.99,-712.64,64.84), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Brancos" },

	[4098] = { Coords = vec3(993.29,-2481.11,29.59), Hash = -1646581307, Lock = true, Distance = 5.5, Perm = "HellsAngels" },

	[4099] = { Coords = vec3(459.76,409.07,139.53), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Roxos" },
	[4100] = { Coords = vec3(651.55,357.74,111.95), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Roxos" },
	
	[4101] = { Coords = vec3(2241.14,3261.95,47.99), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Cinzas" },
	[4102] = { Coords = vec3(2152.19,3486.56,45.12), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Cinzas" },

	[4103] = { Coords = vec3(1348.94,-2226.81,60.57), Hash = 725274945, Lock = true, Distance = 5.5, Perm = "Rosas" },
	[4617] = { Coords = vec3(-2540.54,3755.62,13.41), Hash = -1573772550, Lock = true, Distance = 5.5, Perm = "Mansao29" },
	[4618] = { Coords = vec3(-2554.44,3735.7,13.38), Hash = 1299623290, Lock = true, Distance = 5.5, Perm = "Mansao29" },
	[4619] = { Coords = vec3(-2484.87,3733.38,16.28), Hash = 841381594, Lock = true, Distance = 5.5, Perm = "Mansao29" },

	[4620] = { Coords = vec3(-135.46,971.98,235.88), Hash = -1249591818, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4621] = { Coords = vec3(-104.65,976.54,235.75), Hash = -435821409, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4622] = { Coords = vec3(-70.49,1008.81,234.4), Hash = -435821409, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4623] = { Coords = vec3(-103.0,1011.41,235.76), Hash = -435821409, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4624] = { Coords = vec3(-111.5,999.42,235.75), Hash = -435821409, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4625] = { Coords = vec3(-97.78,988.74,235.75), Hash = -435821409, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4626] = { Coords = vec3(67.87,987.72,234.4), Hash = -435821409, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4627] = { Coords = vec3(-112.77,986.1,235.75), Hash = -2146494197, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4628] = { Coords = vec3(-58.15,979.85,232.86), Hash = -2146494197, Lock = true, Distance = 5.5, Perm = "Mansao06" },
	[4629] = { Coords = vec3(-62.41,998.81,234.4), Hash = -2146494197, Lock = true, Distance = 5.5, Perm = "Mansao06" },

	[4630] = { Coords = vec3(-104.53,850.59,235.63), Hash = -1249591818, Lock = true, Distance = 5.5, Perm = "Mansao09" },
	[4631] = { Coords = vec3(-85.71,835.1,235.91), Hash = 110411266, Lock = true, Distance = 5.5, Perm = "Mansao09" },
	[4632] = { Coords = vec3(-97.43,816.22,235.76), Hash = -1119680854, Lock = true, Distance = 5.5, Perm = "Mansao09" },
	[4633] = { Coords = vec3(-69.25,824.08,235.73), Hash = -1119680854, Lock = true, Distance = 5.5, Perm = "Mansao09" },
	[4634] = { Coords = vec3(-49.49,830.17,235.73), Hash = -1119680854, Lock = true, Distance = 5.5, Perm = "Mansao09" },
	[4635] = { Coords = vec3(-51.59,828.53,231.36), Hash = -1119680854, Lock = true, Distance = 5.5, Perm = "Mansao09" },
	[4636] = { Coords = vec3(-70.9,823.9,231.33), Hash = -1119680854, Lock = true, Distance = 5.5, Perm = "Mansao09" },
	[4637] = { Coords = vec3(-78.84,822.39,227.74), Hash = -1119680854, Lock = true, Distance = 5.5, Perm = "Mansao09" },

	[4638] = { Coords = vec3(-526.57,517.31,112.94), Hash = -711771128, Lock = true, Distance = 5.5, Perm = "Mansao20" },
	[4639] = { Coords = vec3(-510.06,502.61,108.09), Hash = -711771128, Lock = true, Distance = 5.5, Perm = "Mansao20" },
	[4640] = { Coords = vec3(-510.92,503.0,112.44), Hash = -711771128, Lock = true, Distance = 5.5, Perm = "Mansao20" },

	[4641] = { Coords = vec3(-1090.68,369.34,68.7), Hash = 1930237257, Lock = true, Distance = 5.5, Perm = "Mansao24" },
	[4642] = { Coords = vec3(-1129.26,389.97,70.75), Hash = -2139443164, Lock = true, Distance = 5.5, Perm = "Mansao24" },
	[4643] = { Coords = vec3(-1136.3,375.59,71.29), Hash = -88942360, Lock = true, Distance = 5.5, Perm = "Mansao24" },
	[4644] = { Coords = vec3(-1141.88,365.71,71.31), Hash = -88942360, Lock = true, Distance = 5.5, Perm = "Mansao24" },
	[4645] = { Coords = vec3(-1130.07,360.64,71.71), Hash = -1821777087, Lock = true, Distance = 5.5, Perm = "Mansao24" },
	[4646] = { Coords = vec3(-1130.32,370.8,74.93), Hash = -88942360, Lock = true, Distance = 5.5, Perm = "Mansao24" },
	[4647] = { Coords = vec3(-1134.4,363.21,74.95), Hash = -1821777087, Lock = true, Distance = 5.5, Perm = "Mansao24" },
	[4648] = { Coords = vec3(-1143.48,371.45,74.93), Hash = -88942360, Lock = true, Distance = 5.5, Perm = "Mansao24" },

	[4649] = { Coords = vec3(-1733.01,379.11,89.73), Hash = -826011544, Lock = true, Distance = 5.5, Perm = "Mansao18" },
	[4650] = { Coords = vec3(-1746.14,368.04,89.73), Hash = 634017584, Lock = true, Distance = 5.5, Perm = "Mansao18" },
	[4651] = { Coords = vec3(-1741.66,365.39,88.73), Hash = -826011544, Lock = true, Distance = 5.5, Perm = "Mansao18" },
	[4652] = { Coords = vec3(-1723.27,359.17,89.42), Hash = 1664299099, Lock = true, Distance = 5.5, Perm = "Mansao18" },

	-- [4653] = { Coords = vec3(-1090.68,369.34,68.7), Hash = -2125423493, Lock = true, Distance = 5.5, Perm = "Mansao25" }
	-- [4654] = { Coords = vec3(-1129.26,389.97,70.75), Hash = -1859471240, Lock = true, Distance = 5.5, Perm = "Mansao25" }
	-- [4655] = { Coords = vec3(-1136.3,375.59,71.29), Hash = -1859471240, Lock = true, Distance = 5.5, Perm = "Mansao25" }
	-- [4656] = { Coords = vec3(-1141.88,365.71,71.31), Hash = -1859471240, Lock = true, Distance = 5.5, Perm = "Mansao25" }
	-- [4657] = { Coords = vec3(-1130.07,360.64,71.71), Hash = -1821777087, Lock = true, Distance = 5.5, Perm = "Mansao25" }
	-- [4658] = { Coords = vec3(-1614.26,77.77,61.57), Hash = 2125423493, Lock = true, Distance = 5.5, Perm = "Mansao25" }
	-- [4659] = { Coords = vec3(-1134.4,363.21,74.95), Hash = -1176227434, Lock = true, Distance = 5.5, Perm = "Mansao25" }
	-- [4660] = { Coords = vec3(-1536.56,130.7,57.37), Hash = 1330109535, Lock = true, Distance = 5.5, Perm = "Mansao25" }

	[4661] = { Coords = vec3(-2652.27,1326.2,147.05), Hash = -1249591818, Lock = true, Distance = 5.5, Perm = "Mansao13" },
	[4662] = { Coords = vec3(-2651.96,1307.19,146.61), Hash = -1573772550, Lock = true, Distance = 5.5, Perm = "Mansao13" },
	[4663] = { Coords = vec3(-2666.83,1326.37,147.37), Hash = 1901183774, Lock = true, Distance = 5.5, Perm = "Mansao13" },

	[4664] = { Coords = vec3(-2599.26,1671.8,141.82), Hash = 1286535678, Lock = true, Distance = 5.5, Perm = "Mansao07" },
	[4665] = { Coords = vec3(-2603.61,1686.52,142.67), Hash = -951412226, Lock = true, Distance = 5.5, Perm = "Mansao07" },

	[4666] = { Coords = vec3(-2557.27,1913.02,168.89), Hash = -1249591818, Lock = true, Distance = 5.5, Perm = "Mansao11" },
	[4667] = { Coords = vec3(-2587.79,1910.87,167.49), Hash = 308207762, Lock = true, Distance = 5.5, Perm = "Mansao11" },
	[4668] = { Coords = vec3(-2600.24,1902.65,163.75), Hash = 813813633, Lock = true, Distance = 5.5, Perm = "Mansao11" },
	[4669] = { Coords = vec3(-2599.74,1901.03,167.3), Hash = 813813633, Lock = true, Distance = 5.5, Perm = "Mansao11" },
	[4670] = { Coords = vec3(-2594.54,1917.16,167.3), Hash = -2037125726, Lock = true, Distance = 5.5, Perm = "Mansao11" },

	[4671] = { Coords = vec3(-3134.76,796.08,17.42), Hash = 1286535678, Lock = true, Distance = 5.5, Perm = "Mansao01" },
	[4672] = { Coords = vec3(-3221.11,838.4,8.68), Hash = -550386901, Lock = true, Distance = 5.5, Perm = "Mansao01" },
	[4673] = { Coords = vec3(-3216.64,815.83,8.93), Hash = 308207762, Lock = true, Distance = 5.5, Perm = "Mansao01" },

	[4674] = { Coords = vec3(-1979.8,-495.69,12.18), Hash = 2052512905, Lock = true, Distance = 5.5, Perm = "Mansao19" },
	[4675] = { Coords = vec3(-1976.22,-497.48,12.18), Hash = -550386901, Lock = true, Distance = 5.5, Perm = "Mansao19" },
	[4676] = { Coords = vec3(-1993.42,-518.33,12.05), Hash = -550386901, Lock = true, Distance = 5.5, Perm = "Mansao19" },
	[4677] = { Coords = vec3(-1986.9,-512.42,12.18), Hash = 308207762, Lock = true, Distance = 5.5, Perm = "Mansao19" },
	[4678] = { Coords = vec3(-1987.09,-512.45,12.18), Hash = 308207762, Lock = true, Distance = 5.5, Perm = "Mansao19" },

	[4679] = { Coords = vec3(-775.02,309.43,85.7), Hash = 100848840, Lock = true, Distance = 5.5, Perm = "Mansao04" },

	[4680] = { Coords = vec3(2563.43,6171.49,165.01), Hash = 2093600960, Lock = true, Distance = 5.5, Perm = "Mansao14" },
	[4681] = { Coords = vec3(2540.85,6154.94,164.1), Hash = 1042741067, Lock = true, Distance = 5.5, Perm = "Mansao14" },

	[4682] = { Coords = vec3(-2164.86,2728.59,4.65), Hash = -1603817716, Lock = true, Distance = 5.5, Perm = "Mansao12" },

	[4683] = { Coords = vec3(-1065.86,316.26,65.8), Hash = -1918480350, Lock = true, Distance = 5.5, Perm = "Mansao10" },
	[4684] = { Coords = vec3(-943.89,292.01,70.4), Hash = -1568354151, Lock = true, Distance = 5.5, Perm = "Mansao10" },
	[4685] = { Coords = vec3(-952.66,301.32,70.84), Hash = -1918480350, Lock = true, Distance = 5.5, Perm = "Mansao10" },
	[4686] = { Coords = vec3(-1036.36,329.56,68.02), Hash = -1918480350, Lock = true, Distance = 5.5, Perm = "Mansao10" },
	[4687] = { Coords = vec3(-1041.99,298.11,66.99), Hash = 1123731138, Lock = true, Distance = 5.5, Perm = "Mansao10" },
	[4688] = { Coords = vec3(-1026.84,313.07,66.99), Hash = 395669496, Lock = true, Distance = 5.5, Perm = "Mansao10" },
	[4689] = { Coords = vec3(-1038.07,311.62,67.26), Hash = 893692758, Lock = true, Distance = 5.5, Perm = "Mansao10" },

	[4690] = { Coords = vec3(-1452.94,-32.32,54.59), Hash = -1918480350, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4691] = { Coords = vec3(-1472.96,-13.56,54.59), Hash = -1918480350, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4692] = { Coords = vec3(-1457.36,-50.86,54.53), Hash = 254433294, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4693] = { Coords = vec3(-1460.92,-53.69,54.59), Hash = 587333565, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4694] = { Coords = vec3(-1465.19,-34.47,55.05), Hash = -1017013428, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4695] = { Coords = vec3(-1486.48,-22.08,54.64), Hash = -1017013428, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4696] = { Coords = vec3(-1480.82,-40.72,56.83), Hash = -1017013428, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4697] = { Coords = vec3(-1482.79,-49.29,54.64), Hash = -1017013428, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4698] = { Coords = vec3(-1473.34,-58.44,54.64), Hash = -1017013428, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4699] = { Coords = vec3(-1468.5,-59.44,54.64), Hash = -1017013428, Lock = true, Distance = 5.5, Perm = "Mansao23" },
	[4700] = { Coords = vec3(-1465.13,-47.4,54.64), Hash = -1017013428, Lock = true, Distance = 5.5, Perm = "Mansao23" },

	[4701] = { Coords = vec3(-827.82,268.33,86.19), Hash = 1783199408, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4702] = { Coords = vec3(-818.8,267.61,86.39), Hash = 1448171236, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4703] = { Coords = vec3(-818.38,270.7,86.19), Hash = -449097539, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4705] = { Coords = vec3(-830.29,272.72,86.19), Hash = -449097539, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4706] = { Coords = vec3(-815.86,251.81,79.26), Hash = 65586107, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4707] = { Coords = vec3(-819.16,257.9,79.24), Hash = 65586107, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4708] = { Coords = vec3(-813.12,251.33,82.78), Hash = 65586107, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4709] = { Coords = vec3(-820.37,258.81,82.83), Hash = 65586107, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4710] = { Coords = vec3(-831.95,260.4,82.78), Hash = 65586107, Lock = true, Distance = 5.5, Perm = "Mansao03" },
	[4711] = { Coords = vec3(-832.48,259.97,79.19), Hash = 65586107, Lock = true, Distance = 5.5, Perm = "Mansao03" },

	[4712] = { Coords = vec3(8.31,539.6,176.03), Hash = 308207762, Lock = true, Distance = 5.5, Perm = "Mansao02" },
	[4713] = { Coords = vec3(18.1,546.59,176.05), Hash = 2052512905, Lock = true, Distance = 5.5, Perm = "Mansao02" },

	[4714] = { Coords = vec3(-844.4,159.05,66.76), Hash = -2125423493, Lock = true, Distance = 5.5, Perm = "Mansao22" },
	[4715] = { Coords = vec3(-849.77,178.73,69.69), Hash = -1568354151, Lock = true, Distance = 5.5, Perm = "Mansao22" },
	[4716] = { Coords = vec3(-806.88,186.19,72.47), Hash = -1563640173, Lock = true, Distance = 5.5, Perm = "Mansao22" },
	[4717] = { Coords = vec3(-816.96,178.15,72.22), Hash = -1686014385, Lock = true, Distance = 5.5, Perm = "Mansao22" },
	[4718] = { Coords = vec3(-795.36,177.35,72.82), Hash = -1454760130, Lock = true, Distance = 5.5, Perm = "Mansao22" },
	[4719] = { Coords = vec3(-793.66,181.31,72.82), Hash = -1454760130, Lock = true, Distance = 5.5, Perm = "Mansao22" },

	[4720] = { Coords = vec3(-2719.55,1506.1,106.56), Hash = 546378757, Lock = true, Distance = 5.5, Perm = "Mansao08" },
	[4721] = { Coords = vec3(-2789.01,1423.06,100.93), Hash = -991010358, Lock = true, Distance = 5.5, Perm = "Mansao08" },

	[4722] = { Coords = vec3(-878.55,19.22,45.21), Hash = -2125423493, Lock = true, Distance = 5.5, Perm = "Mansao21" },
	[4723] = { Coords = vec3(-888.39,43.06,49.15), Hash = 362837712, Lock = true, Distance = 5.5, Perm = "Mansao21" },
	[4724] = { Coords = vec3(-895.88,49.52,50.03), Hash = 362837712, Lock = true, Distance = 5.5, Perm = "Mansao21" },

	[4725] = { Coords = vec3(1395.62,1141.82,114.65), Hash = 1504256620, Lock = true, Distance = 5.5, Perm = "Mansao05" },
	[4726] = { Coords = vec3(1390.75,1132.37,114.33), Hash = -1032171627, Lock = true, Distance = 5.5, Perm = "Mansao05" },
	[4727] = { Coords = vec3(1400.46,1128.06,114.33), Hash = -1032171627, Lock = true, Distance = 5.5, Perm = "Mansao05" },
	[4728] = { Coords = vec3(1407.0,1128.32,114.33), Hash = 262671971, Lock = true, Distance = 5.5, Perm = "Mansao05" },
	[4729] = { Coords = vec3(1409.78,1147.24,114.33), Hash = -1032171627, Lock = true, Distance = 5.5, Perm = "Mansao05" },
	[4730] = { Coords = vec3(1408.53,1159.92,114.33), Hash = -1032171627, Lock = true, Distance = 5.5, Perm = "Mansao05" },
	[4731] = { Coords = vec3(1408.41,1164.73,114.33), Hash = -1032171627, Lock = true, Distance = 5.5, Perm = "Mansao05" },

	[4732] = { Coords = vec3(179.48,1677.63,230.15), Hash = 1286535678, Lock = true, Distance = 5.5, Perm = "Mansao15" },
	[4733] = { Coords = vec3(177.53,1701.08,227.39), Hash = 1901183774, Lock = true, Distance = 5.5, Perm = "Mansao15" },

	[4734] = { Coords = vec3(205.44,773.93,205.58), Hash = 546378757, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4735] = { Coords = vec3(206.89,774.26,205.58), Hash = -1249591818, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4736] = { Coords = vec3(228.98,766.11,204.98), Hash = 1632949967, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4737] = { Coords = vec3(246.45,766.84,203.7), Hash = -1166966571, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4738] = { Coords = vec3(246.56,765.93,203.7), Hash = -1166966571, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4739] = { Coords = vec3(232.24,747.71,203.7), Hash = -1166966571, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4740] = { Coords = vec3(231.46,747.12,203.7), Hash = -1166966571, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4741] = { Coords = vec3(241.2,754.49,200.09), Hash = -1166966571, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4742] = { Coords = vec3(239.81,753.3,200.09), Hash = -1166966571, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4743] = { Coords = vec3(248.09,765.93,200.09), Hash = -1166966571, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4744] = { Coords = vec3(247.77,766.71,200.09), Hash = -1166966571, Lock = true, Distance = 5.5, Perm = "Mansao26" },
	[4745] = { Coords = vec3(228.41,756.81,204.86), Hash = -1687047623, Lock = true, Distance = 5.5, Perm = "Mansao26" },

	[4746] = { Coords = vec3(233.3,588.24,190.54), Hash = -900791993, Lock = true, Distance = 5.5, Perm = "Mansao27" },
	[4747] = { Coords = vec3(230.38,575.02,185.75), Hash = -414392307, Lock = true, Distance = 5.5, Perm = "Mansao27" },
	[4748] = { Coords = vec3(228.68,585.67,190.02), Hash = -1186396713, Lock = true, Distance = 5.5, Perm = "Mansao27" },
	[4749] = { Coords = vec3(225.33,582.51,190.2), Hash = -619624554, Lock = true, Distance = 5.5, Perm = "Mansao27" },

	[4900] = { Coords = vec3(95.5,-1285.1,29.27), Hash = 668467214, Lock = true, Distance = 1.5, Perm = "Vanilla" },

	[4901] = { Coords = vec3(394.9,-1484.33,29.2), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Italia" },
	[4902] = { Coords = vec3(428.37,-1541.02,29.25), Hash = 725274945, Lock = true, Distance = 1.5, Perm = "Italia" },

	[4903] = { Coords = vec3(-1564.86,-406.87,42.38), Hash = 827574885, Lock = true, Distance = 1.5, Perm = "Bloods" },
	[4904] = { Coords = vec3(-1563.81,-405.58,42.38), Hash = -725970636, Lock = true, Distance = 1.5, Perm = "Bloods" },
	[4905] = { Coords = vec3(-1557.52,-398.34,41.99), Hash = 1641308239, Lock = true, Distance = 1.5, Perm = "Bloods" },

	[4906] = { Coords = vec3(-233.65,-333.27,30.09), Hash = -2076287065, Lock = true, Distance = 1.5, Perm = "Galaxy" },
	[4907] = { Coords = vec3(-233.56,-334.06,30.09), Hash = -374527357, Lock = true, Distance = 1.5, Perm = "Galaxy" },
	[4908] = { Coords = vec3(-234.13,-330.05,30.09), Hash = -2076287065, Lock = true, Distance = 1.5, Perm = "Galaxy" },
	[4909] = { Coords = vec3(-233.94,-331.16,30.09), Hash = -374527357, Lock = true, Distance = 1.5, Perm = "Galaxy" },

	[4910] = { Coords = vec3(128.79,-1298.46,29.23), Hash = -1116041313, Lock = true, Distance = 1.5, Perm = "Vanilla" },
	[4911] = { Coords = vec3(108.8,-1329.48,29.45), Hash = 741314661, Lock = true, Distance = 5.0, Perm = "Vanilla" },

	[4912] = { Coords = vec3(-1082.94,-260.72,37.79), Hash = -1679881977, Lock = true, Distance = 1.5, Perm = "Brancos" },
	[4913] = { Coords = vec3(-1081.22,-259.8,37.81), Hash = -1045015371, Lock = true, Distance = 1.5, Perm = "Brancos" },
	[4914] = { Coords = vec3(-1044.73,-231.42,39.01), Hash = 1104171198, Lock = true, Distance = 1.5, Perm = "Brancos" },
	[4915] = { Coords = vec3(-1045.75,-229.56,39.01), Hash = -1425071302, Lock = true, Distance = 1.5, Perm = "Brancos" },

	[4916] = { Coords = vec3(-1389.24,-587.49,30.23), Hash = -1687047623, Lock = true, Distance = 1.5, Perm = "Bahamas" },
	[4917] = { Coords = vec3(-1387.56,-586.37,30.21), Hash = -1687047623, Lock = true, Distance = 1.5, Perm = "Bahamas" },

	[4918] = { Coords = vec3(-205.34,-1309.96,31.29), Hash = -427498890, Lock = true, Distance = 5.0, Perm = "Bennys" },
	[4919] = { Coords = vec3(-244.66,-1308.25,31.29), Hash = 741314661, Lock = true, Distance = 5.0, Perm = "Bennys" },
	[4920] = { Coords = vec3(-151.74,-1297.88,31.1), Hash = 741314661, Lock = true, Distance = 5.0, Perm = "Bennys" }

}

local CityConfig = {
    ["Base"] = function()
        -- Locations[1000] = { Coords = vec3(-293.23,213.12,81.77), Hash = -947252223, Lock = true, Distance = 1.5, Perm = "Luxor" }
    end,
}

CreateThread(function()
	if CityConfig[cityName] then
        CityConfig[cityName]()
    end
end)

exports("GetDoors",function()
	return Locations
end)
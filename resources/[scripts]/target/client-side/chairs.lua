-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Previous = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAIRS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chairs = {
	-- BurgerShot
	{ ["Coords"] = vec3(-1195.44,-883.55,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1194.96,-884.31,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1193.82,-882.47,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1193.30,-883.22,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1192.98,-881.81,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1192.48,-882.60,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1191.01,-881.64,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1191.52,-880.80,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1189.33,-879.31,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1189.85,-879.69,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1188.14,-879.62,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1187.72,-880.32,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1187.08,-881.23,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1187.89,-881.76,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1185.99,-882.92,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1186.81,-883.47,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1183.18,-886.96,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1183.96,-887.49,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1182.06,-888.64,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1182.87,-889.20,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1180.97,-891.36,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1181.82,-891.92,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1181.00,-890.16,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1181.41,-889.55,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1183.94,-892.23,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1183.43,-892.91,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1184.89,-893.88,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1185.38,-893.11,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1185.72,-894.48,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1186.22,-893.72,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1187.37,-895.61,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1187.89,-894.86,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1191.19,-885.34,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1190.86,-885.78,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1191.12,-886.88,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1191.76,-887.33,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1192.77,-887.12,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1193.15,-886.60,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1189.26,-892.31,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1189.65,-891.76,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1189.37,-890.67,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1188.82,-890.28,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1187.85,-890.23,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1187.50,-890.74,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1193.91,-887.50,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1192.99,-888.86,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1191.30,-891.31,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1190.44,-892.68,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1188.91,-896.76,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1189.62,-897.21,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1190.85,-897.04,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1191.33,-896.33,13.5), ["Heading"] = 303 },
	{ ["Coords"] = vec3(-1200.55,-887.10,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1203.02,-888.78,13.5), ["Heading"] = 213 },
	{ ["Coords"] = vec3(-1180.80,-900.72,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1185.43,-904.10,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1184.68,-903.58,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1188.82,-903.77,13.5), ["Heading"] = 330 },
	{ ["Coords"] = vec3(-1187.79,-901.57,13.5), ["Heading"] = 309 },
	{ ["Coords"] = vec3(-1188.45,-900.58,13.5), ["Heading"] = 289 },
	{ ["Coords"] = vec3(-1186.65,-899.34,13.5), ["Heading"] = 199 },
	{ ["Coords"] = vec3(-1177.39,-895.82,13.5), ["Heading"] = 123 },
	{ ["Coords"] = vec3(-1179.68,-896.44,13.5), ["Heading"] = 294 },
	{ ["Coords"] = vec3(-1178.90,-897.46,13.5), ["Heading"] = 324 },
	{ ["Coords"] = vec3(-1177.84,-899.15,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1177.11,-898.76,13.5), ["Heading"] = 33 },
	{ ["Coords"] = vec3(-1176.38,-898.29,13.5), ["Heading"] = 33 },
	-- PizzaThis
	{ ["Coords"] = vec3(808.50,-755.33,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(808.50,-754.45,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(806.95,-755.33,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(806.95,-754.49,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(806.38,-755.42,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(806.38,-754.52,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(804.85,-755.42,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(804.85,-754.44,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(804.28,-755.32,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(804.28,-754.50,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(802.75,-755.45,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(802.75,-754.45,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(802.2,-755.28,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(802.2,-754.39,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(800.64,-755.34,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(800.64,-754.50,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(799.34,-756.80,26.28), ["Heading"] = 180 },
	{ ["Coords"] = vec3(799.33,-758.38,26.28), ["Heading"] = 0 },
	{ ["Coords"] = vec3(799.43,-758.97,26.28), ["Heading"] = 180 },
	{ ["Coords"] = vec3(799.43,-760.52,26.28), ["Heading"] = 0 },
	{ ["Coords"] = vec3(808.13,-751.56,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(806.01,-751.53,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(804.23,-751.53,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(802.05,-751.59,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(800.12,-751.51,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(798.04,-751.58,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(799.06,-748.86,26.28), ["Heading"] = 90 },
	{ ["Coords"] = vec3(796.97,-748.79,26.28), ["Heading"] = 270 },
	{ ["Coords"] = vec3(799.48,-754.09,26.28), ["Heading"] = 160 },
	{ ["Coords"] = vec3(799.50,-756.05,26.28), ["Heading"] = 5 },
	{ ["Coords"] = vec3(795.12,-750.46,26.28), ["Heading"] = 205 },
	{ ["Coords"] = vec3(795.22,-752.64,26.28), ["Heading"] = 355 },
	-- UwuCafé
	{ ["Coords"] = vec3(-573.94,-1058.86,21.99), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-573.04,-1058.84,21.99), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-573.9,-1060.65,21.99), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-573.07,-1060.69,21.99), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-573.86,-1062.48,21.99), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-573.06,-1062.45,21.99), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-573.86,-1064.31,21.99), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-573.06,-1064.28,21.99), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-573.9,-1066.19,21.99), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-573.02,-1066.16,21.99), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-573.95,-1068.02,21.99), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-573.1,-1068.05,21.99), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-577.58,-1052.5,21.85), ["Heading"] = 42.41 },
	{ ["Coords"] = vec3(-579.69,-1052.49,21.85), ["Heading"] = 329 },
	{ ["Coords"] = vec3(-580.83,-1050.91,21.85), ["Heading"] = 267 },
	{ ["Coords"] = vec3(-576.91,-1050.75,21.85), ["Heading"] = 108.24 },
	{ ["Coords"] = vec3(-591.26,-1049.2,21.85), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-590.56,-1049.16,21.85), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-589.81,-1049.12,21.85), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-598.29,-1050.07,21.85), ["Heading"] = 268 },
	{ ["Coords"] = vec3(-598.28,-1050.97,21.85), ["Heading"] = 268 },
	{ ["Coords"] = vec3(-573.58,-1053.56,26.07), ["Heading"] = 270 },
	{ ["Coords"] = vec3(-573.6,-1052.84,26.07), ["Heading"] = 270 },
	{ ["Coords"] = vec3(-573.58,-1052.08,26.07), ["Heading"] = 270 },
	{ ["Coords"] = vec3(-569.87,-1066.14,26.07), ["Heading"] = 90 },
	{ ["Coords"] = vec3(-569.85,-1066.92,26.07), ["Heading"] = 90 },
	{ ["Coords"] = vec3(-569.89,-1067.76,26.07), ["Heading"] = 90 },
	{ ["Coords"] = vec3(-569.87,-1068.54,26.07), ["Heading"] = 90 },
	{ ["Coords"] = vec3(-571.01,-1069.26,26.07), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-572.6,-1069.26,26.07), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-577.0,-1062.51,26.07), ["Heading"] = 0 },
	{ ["Coords"] = vec3(-578.7,-1058.0,26.07), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-578.0,-1058.02,26.07), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-577.28,-1058.03,26.07), ["Heading"] = 180 },
	{ ["Coords"] = vec3(-577.12,-1065.24,26.07), ["Heading"] = 165 },
	{ ["Coords"] = vec3(-578.79,-1065.32,26.07), ["Heading"] = 200 },
	-- PIERZADA
	{ ["Coords"] = vec3(-1631.27,-1091.24,12.46), ["Heading"] = 243 },
	{ ["Coords"] = vec3(-1630.54,-1090.35,12.46), ["Heading"] = 232 },
	{ ["Coords"] = vec3(-1632.32,-1090.18,12.46), ["Heading"] = 53 },
	{ ["Coords"] = vec3(-1631.65,-1089.33,12.46), ["Heading"] = 56 },
	{ ["Coords"] = vec3(-1635.62,-1094.22,12.45), ["Heading"] = 53 },
	{ ["Coords"] = vec3(-1636.37,-1095.07,12.45), ["Heading"] = 68 },
	{ ["Coords"] = vec3(-1635.4,-1096.0,12.45), ["Heading"] = 235 },
	{ ["Coords"] = vec3(-1634.7,-1095.3,12.45), ["Heading"] = 243 },
	{ ["Coords"] = vec3(-1627.42,-1084.64,12.46), ["Heading"] = 56 },
	{ ["Coords"] = vec3(-1628.18,-1085.38,12.46), ["Heading"] = 53 },
	{ ["Coords"] = vec3(-1626.54,-1085.55,12.46), ["Heading"] = 229 },
	{ ["Coords"] = vec3(-1627.14,-1086.4,12.46), ["Heading"] = 255 },
	{ ["Coords"] = vec3(-1623.37,-1081.75,12.46), ["Heading"] = 246 },
	{ ["Coords"] = vec3(-1622.72,-1081.06,12.46), ["Heading"] = 235 },
	{ ["Coords"] = vec3(-1624.32,-1080.8,12.46), ["Heading"] = 65 },
	{ ["Coords"] = vec3(-1623.66,-1080.03,12.46), ["Heading"] = 51 },
	{ ["Coords"] = vec3(-1619.27,-1074.75,12.47), ["Heading"] = 53 },
	{ ["Coords"] = vec3(-1620.02,-1075.56,12.47), ["Heading"] = 51 },
	{ ["Coords"] = vec3(-1619.02,-1076.5,12.47), ["Heading"] = 232 },
	{ ["Coords"] = vec3(-1618.27,-1075.67,12.47), ["Heading"] = 246 },
	{ ["Coords"] = vec3(-1613.63,-1070.25,12.47), ["Heading"] = 246 },
	{ ["Coords"] = vec3(-1614.3,-1070.96,12.47), ["Heading"] = 243 },
	{ ["Coords"] = vec3(-1614.61,-1069.22,12.47), ["Heading"] = 56 },
	{ ["Coords"] = vec3(-1615.19,-1070.04,12.47), ["Heading"] = 48 },
	{ ["Coords"] = vec3(-1610.58,-1064.58,12.47), ["Heading"] = 53 },
	{ ["Coords"] = vec3(-1611.38,-1065.45,12.47), ["Heading"] = 51 },
	{ ["Coords"] = vec3(-1606.76,-1059.98,12.47), ["Heading"] = 53 },
	{ ["Coords"] = vec3(-1607.4,-1060.76,12.47), ["Heading"] = 56 },
	{ ["Coords"] = vec3(-1605.59,-1060.85,12.47), ["Heading"] = 238 },
	{ ["Coords"] = vec3(-1606.44,-1061.74,12.47), ["Heading"] = 232 },
	{ ["Coords"] = vec3(-1606.8,-1059.92,12.47), ["Heading"] = 56 },
	{ ["Coords"] = vec3(-1603.49,-1056.02,12.47), ["Heading"] = 56 },
	{ ["Coords"] = vec3(-1602.79,-1055.2,12.47), ["Heading"] = 56 },
	{ ["Coords"] = vec3(-1602.52,-1057.02,12.47), ["Heading"] = 235 },
	{ ["Coords"] = vec3(-1601.86,-1056.19,12.47), ["Heading"] = 235 },
	{ ["Coords"] = vec3(-1638.0,-1100.59,12.47), ["Heading"] = 328 },
	{ ["Coords"] = vec3(-1638.84,-1099.8,12.47), ["Heading"] = 328 },
	{ ["Coords"] = vec3(-1638.88,-1101.63,12.47), ["Heading"] = 150 },
	{ ["Coords"] = vec3(-1639.78,-1100.96,12.47), ["Heading"] = 138 },
	{ ["Coords"] = vec3(-1633.88,-1105.84,12.47), ["Heading"] = 138 },
	{ ["Coords"] = vec3(-1633.09,-1106.54,12.47), ["Heading"] = 147 },
	{ ["Coords"] = vec3(-1632.94,-1104.83,12.47), ["Heading"] = 331 },
	{ ["Coords"] = vec3(-1632.03,-1105.58,12.47), ["Heading"] = 337 },
	{ ["Coords"] = vec3(-1610.24,-1066.25,12.47), ["Heading"] = 243 },
	{ ["Coords"] = vec3(-1609.71,-1065.56,12.47), ["Heading"] = 232 },
	{ ["Coords"] = vec3(-1645.52,-1093.84,12.55), ["Heading"] = 246 },
	{ ["Coords"] = vec3(-1646.37,-1094.69,12.55), ["Heading"] = 226 },
	{ ["Coords"] = vec3(-1642.61,-1090.29,12.55), ["Heading"] = 235 },
	{ ["Coords"] = vec3(-1641.89,-1089.49,12.55), ["Heading"] = 243 },
	{ ["Coords"] = vec3(-1638.43,-1085.4,12.55), ["Heading"] = 252 },
	{ ["Coords"] = vec3(-1637.68,-1084.47,12.55), ["Heading"] = 229 },
	{ ["Coords"] = vec3(-1633.33,-1079.43,12.55), ["Heading"] = 240 },
	{ ["Coords"] = vec3(-1633.95,-1080.26,12.55), ["Heading"] = 238 },
	{ ["Coords"] = vec3(-1626.21,-1070.72,12.55), ["Heading"] = 238 },
	{ ["Coords"] = vec3(-1625.57,-1069.95,12.55), ["Heading"] = 235 },
	{ ["Coords"] = vec3(-1620.79,-1064.38,12.55), ["Heading"] = 240 },
	{ ["Coords"] = vec3(-1621.43,-1065.16,12.55), ["Heading"] = 238 },
	{ ["Coords"] = vec3(-1616.67,-1059.37,12.55), ["Heading"] = 238 },
	{ ["Coords"] = vec3(-1616.66,-1059.36,12.55), ["Heading"] = 238 },
	{ ["Coords"] = vec3(-1630.4,-1075.71,12.55), ["Heading"] = 218 },
	{ ["Coords"] = vec3(-1629.73,-1074.97,12.55), ["Heading"] = 238 },
	{ ["Coords"] = vec3(-1617.42,-1060.2,12.55), ["Heading"] = 240 },
	{ ["Coords"] = vec3(-1613.89,-1055.77,12.55), ["Heading"] = 246 },
	{ ["Coords"] = vec3(-1613.34,-1055.05,12.55), ["Heading"] = 252 },
	{ ["Coords"] = vec3(-1610.82,-1049.84,12.55), ["Heading"] = 206 },
	{ ["Coords"] = vec3(-1611.09,-1050.52,12.55), ["Heading"] = 308 }

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(Chairs) do
		AddBoxZone("Chairs:"..Number,v["Coords"],0.35,0.35,{
			name = "Chairs:"..Number,
			heading = v["Heading"],
			minZ = v["Coords"]["z"] - 0.1,
			maxZ = v["Coords"]["z"]
		},{
			shop = Number,
			Distance = 5.25,
			options = {
				{
					event = "target:SitChair",
					label = "Sentar",
					tunnel = "client"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SITCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:SitChair")
AddEventHandler("target:SitChair",function(Number)
	if not Previous then
		local Ped = PlayerPedId()
		local Coords = Chairs[Number]["Coords"]
		TaskStartScenarioAtPosition(Ped,"PROP_HUMAN_SEAT_CHAIR_UPRIGHT",Coords["x"],Coords["y"],Coords["z"],Chairs[Number]["Heading"] + 1.0,-1,true,true)
		Previous = GetEntityCoords(Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpChair")
AddEventHandler("target:UpChair",function()
	if Previous then
		local Ped = PlayerPedId()
		SetEntityCoords(Ped,Previous["x"],Previous["y"],Previous["z"] - 1,false,false,false,false)
		Previous = nil
	end
end)
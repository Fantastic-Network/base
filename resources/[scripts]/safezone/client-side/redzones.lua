cityName = GetConvar("cityName", "Base")

local RedZones = {
    ["Verdes"] = PolyZone:Create({
        vector2(2183.94, 3847.46),
        vector2(2027.88, 4014.22),
        vector2(2240.00, 4177.94),
        vector2(2390.00, 4052.12)
    }, {
        name="verdes",
        
    }),
    ["China"] = PolyZone:Create({
        vector2(3196.36, 5224.27),
        vector2(3303.94, 5234.88),
        vector2(3366.06, 5146.95),
        vector2(3303.94, 5001.42),
        vector2(3041.06, 5087.07)
    }, {
        name="china",
        --minZ=0,
        --maxZ=800
    }),
    ["Brancos"] = PolyZone:Create({
        vector2(-1141.67, -279.55),
        vector2(-1124.24, -289.77),
        vector2(-1012.12, -234.47),
        vector2(-1013.64, -222.73),
        vector2(-1033.71, -213.64),
        vector2(-1105.30, -248.86)
       }, {
       
        name="brancos",
        --minZ=0,
        --maxZ=800
    }),
    ["Ballas"] = PolyZone:Create({
        vector2(101.52, -1866.67),
        vector2(29.55, -1934.09),
        vector2(100.00, -2024.24),
        vector2(131.06, -2025.76),
        vector2(137.88, -1980.30),
        vector2(201.52, -1915.91)
       }, {
       
        name="ballas",
        --minZ=0,
        --maxZ=800
    }),
    ["Vagos"] = PolyZone:Create({
        vector2(258.79, -2071.26),
        vector2(352.73, -1959.08),
        vector2(454.24, -2064.44),
        vector2(362.58, -2147.82)
    }, {
        name="Vagos",
        --minZ=0,
        --maxZ=800
    }),
    ["Laranjas"] = PolyZone:Create({
        vector2(3403.03, 3635.49),
        vector2(3604.17, 3593.80),
        vector2(3638.26, 3809.06),
        vector2(3439.39, 3824.22)
    }, {
        name="laranja",
        --minZ=0,
        --maxZ=800
    }),
    ["Russia"] = PolyZone:Create({
        vector2(-1867.80, 1988.26),
        vector2(-1905.68, 1987.88),
        vector2(-1906.06, 2014.39),
        vector2(-1924.62, 2020.83),
        vector2(-1939.02, 2034.47),
        vector2(-1931.06, 2059.47),
        vector2(-1910.98, 2085.61),
        vector2(-1883.71, 2091.29),
        vector2(-1852.27, 2074.24),
        vector2(-1842.80, 2054.92),
        vector2(-1843.56, 2039.02)
       }, {
        name="russia",
        --minZ=0,
        --maxZ=800
    }),
    ["Triade"] = PolyZone:Create({
        vector2(-642.80, 248.11),
        vector2(-639.77, 175.76),
        vector2(-545.45, 173.11),
        vector2(-544.32, 222.73),
        vector2(-564.02, 241.29)
       }, {
        name="Triade",
        --minZ=0,
        --maxZ=800
    }),
    ["Bellagio"] = PolyZone:Create({
        vector2(876.14, 25.76),
        vector2(960.98, -28.03),
        vector2(1016.29, 60.98),
        vector2(937.50, 100.38)
       }, {       
        name="Bellagio",
        --minZ=0,
        --maxZ=800
    }),

    ["Bahamas"] = PolyZone:Create({
        vector2(-1376.52, -583.33),
        vector2(-1351.89, -625.38),
        vector2(-1386.74, -647.73),
        vector2(-1415.53, -605.68)
       }, {
        name="Bahamas",
        --minZ=0,
        --maxZ=800
    }),
    ["Luxor"] = PolyZone:Create({
        vector2(-362.12, 224.24),
        vector2(-361.36, 135.98),
        vector2(-279.17, 139.02),
        vector2(-286.36, 245.08)
       }, {
        name="Luxor",
        --minZ=0,
        --maxZ=800
    }),
    ["Groove"] = PolyZone:Create({
        vector2(98.86, -1869.32),
        vector2(78.79, -1889.77),
        vector2(37.50, -1942.80),
        vector2(131.44, -2008.71),
        vector2(198.48, -1920.45)
       }, {
       
        name="Groove",
        --minZ=0,
        --maxZ=800
    }),
    ["Redline"] = PolyZone:Create({
        vector2(1350.00, -2020.45),
        vector2(1327.27, -2114.77),
        vector2(1345.45, -2141.29),
        vector2(1435.98, -2059.47),
        vector2(1412.88, -2027.27),
        vector2(1361.74, -2012.50)
       }, {
        name="RedLine",       
        --minZ=0,
        --maxZ=800
    }),
    ["Bennys"] = PolyZone:Create({
        vector2(-246.97, -1254.55),
        vector2(-248.11, -1343.18),
        vector2(-121.97, -1341.29),
        vector2(-121.21, -1255.68)
       }, {
       
        name="Bennys",
        --minZ=0,
        --maxZ=800
    }),
    ["DriftKing"] = PolyZone:Create({
        vector2(-1185.61, -1568.18),
        vector2(-1129.17, -1530.30),
        vector2(-1033.33, -1656.44),
        vector2(-1092.42, -1706.06)
       }, {
        name="DriftKing",
        --minZ=0,
        --maxZ=800
    }),
    ["Outlaws"] = PolyZone:Create({
        vector2(-794.32, -2571.21),
        vector2(-780.30, -2546.97),
        vector2(-768.18, -2522.35),
        vector2(-701.89, -2555.68),
        vector2(-756.06, -2652.65),
        vector2(-824.62, -2620.08)
       }, {
        name="Outlaws",
        --minZ=0,
        --maxZ=800
    }),
    ["Crips"] = PolyZone:Create({
        vector2(1280.30, -1548.48),
        vector2(1318.94, -1615.15),
        vector2(1228.41, -1678.79),
        vector2(1143.94, -1709.09),
        vector2(1117.05, -1647.35),
        vector2(1154.92, -1631.06),
        vector2(1209.85, -1579.17),
        vector2(1268.18, -1553.03)
       }, {       
        name="Crips",
        --minZ=0,
        --maxZ=800
    }),
    ["SonsOfAnarchy"] = PolyZone:Create({
        vector2(149.24, 1241.67),
        vector2(104.55, 1180.30),
        vector2(152.27, 1075.00),
        vector2(274.24, 1092.42),
        vector2(237.12, 1262.12)
    }, {
        name="SonsofAnarchy",
        --minZ=0,
        --maxZ=800
    }),
    ["HellsAngels"] = PolyZone:Create({
        vector2(929.92, -2472.73),
        vector2(923.86, -2556.06),
        vector2(1042.42, -2564.02),
        vector2(1052.27, -2483.71)
       }, {
       
        name="HellsAngels",
        --minZ=0,
        --maxZ=800
    }),
    ["Yakuza"] = PolyZone:Create({
        vector2(442.80, -2701.52),
        vector2(443.56, -2761.36),
        vector2(581.06, -2841.67),
        vector2(623.11, -2759.85),
        vector2(449.24, -2693.94)
       }, {
        name="Yakuza",
        --minZ=0,
        --maxZ=800
    }),
    ["Warlocks"] = PolyZone:Create({
        vector2(300.76, -2681.44),
        vector2(302.27, -2765.15),
        vector2(392.42, -2767.05),
        vector2(387.50, -2690.91)
       }, {       
        name="Warlocks",
        --minZ=0,
        --maxZ=800
    }),
    ["Bloods"] = PolyZone:Create({
        vector2(-1558.71, -359.85),
        vector2(-1510.98, -403.79),
        vector2(-1538.64, -438.26),
        vector2(-1593.56, -400.00)
       }, {
       
        name="Bloods",
        --minZ=0,
        --maxZ=800
    }),
    ["Franca"] = PolyZone:Create({
        vector2(-1870.45, 445.83),
        vector2(-1865.91, 340.91),
        vector2(-1831.82, 343.56),
        vector2(-1721.97, 401.14),
        vector2(-1740.91, 493.56),
        vector2(-1849.24, 484.85)
       }, {
        name="Franca",
        --minZ=0,
        --maxZ=800
    }),
    ["Italia"] = PolyZone:Create({
        vector2(385.61, -1490.15),
        vector2(423.86, -1544.32),
        vector2(453.03, -1523.48),
        vector2(433.33, -1504.92),
        vector2(422.73, -1468.94)
       }, {
       
        name="Italia",
        --minZ=0,
        --maxZ=800
    }),
    ["Israel"] = PolyZone:Create({
        vector2(-1457.95, -4.92),
        vector2(-1480.68, -12.50),
        vector2(-1525.76, -29.92),
        vector2(-1531.44, -74.62),
        vector2(-1495.08, -115.53),
        vector2(-1445.45, -73.48),
        vector2(-1435.61, -54.55),
        vector2(-1429.17, -33.33),
        vector2(-1429.92, -18.94),
        vector2(-1434.47, -2.27)
       }, {
        name="Israel",
        --minZ=0,
        --maxZ=800
    }),
    ["Mexico"] = PolyZone:Create({
        vector2(-1471.59, 917.80),
        vector2(-1509.47, 912.88),
        vector2(-1554.92, 882.95),
        vector2(-1571.97, 861.36),
        vector2(-1609.47, 833.71),
        vector2(-1596.59, 784.47),
        vector2(-1615.15, 771.21),
        vector2(-1618.18, 762.50),
        vector2(-1616.67, 750.76),
        vector2(-1609.09, 737.88),
        vector2(-1592.42, 736.36),
        vector2(-1533.71, 766.29),
        vector2(-1438.64, 821.21),
        vector2(-1449.24, 882.95)
       }, {
       
        name="Mexico",
        --minZ=0,
        --maxZ=800
    }),
    ["Gringa"] = PolyZone:Create({
        vector2(958.71, -1897.35),
        vector2(1037.50, -1896.21),
        vector2(1079.92, -1888.26),
        vector2(1105.30, -1878.79),
        vector2(1122.73, -1907.58),
        vector2(1151.52, -1941.67),
        vector2(1179.55, -1980.68),
        vector2(1194.32, -2003.03),
        vector2(1210.61, -2042.05),
        vector2(1192.05, -2051.14),
        vector2(1164.39, -2058.33),
        vector2(1133.33, -2060.23),
        vector2(1109.85, -2060.23),
        vector2(1006.06, -2062.50),
        vector2(951.89, -2062.88),
        vector2(945.08, -2054.55)
    }, {
        name="Gringa",
        --minZ=0,
        --maxZ=800
    }),
    ["TopGear"] = PolyZone:Create({
        vector2(907.95, -2257.95),
        vector2(784.09, -2249.62),
        vector2(769.70, -2431.06),
        vector2(884.47, -2443.94)
        }, {
        name="TopGear",
        --minZ=0,
        --maxZ=800
    }),
    ["Policia"] = PolyZone:Create({
        vector2(2497.73, -230.30),
        vector2(2375.00, -408.33),
        vector2(2547.73, -578.03),
        vector2(2611.36, -235.61)
       }, {
        name="Policia",
        --minZ=0,
        --maxZ=800
    }),
}

-- CONFIG CIDADES
if cityName == "Base" then
    RedZones["Crips"] = PolyZone:Create({
        vector2(-1453.41, 61.36),
        vector2(-1444.32, 150.00),
        vector2(-1407.95, 201.52),
        vector2(-1451.14, 244.32),
        vector2(-1500.00, 189.77),
        vector2(-1574.24, 148.11),
        vector2(-1643.56, 115.15),
        vector2(-1634.85, 84.47),
        vector2(-1550.76, 54.17)
       }, {
        name="Crips",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Bloods"] = PolyZone:Create({
        vector2(-1064.39, 326.14),
        vector2(-1064.77, 281.06),
        vector2(-966.67, 280.68),
        vector2(-919.70, 263.64),
        vector2(-951.52, 308.33),
        vector2(-930.68, 338.64),
        vector2(-961.36, 357.58),
        vector2(-996.59, 334.09)
       }, {
        name="Bloods",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Playboy"] = PolyZone:Create({
        vector2(-1637.88, 301.52),
        vector2(-1594.32, 299.24),
        vector2(-1493.94, 233.71),
        vector2(-1447.73, 281.44),
        vector2(-1565.91, 389.39),
        vector2(-1591.29, 528.41),
        vector2(-1628.41, 537.88),
        vector2(-1687.88, 487.50),
        vector2(-1735.98, 476.52),
        vector2(-1699.62, 411.36),
        vector2(-1654.55, 408.33)
       }, {
        name="Playboy",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Israel"] = PolyZone:Create({
        vector2(433.33, -3284.85),
        vector2(628.79, -3290.15),
        vector2(621.97, -3031.06),
        vector2(428.03, -3034.85)
       }, {
        name="Israel",
        --minZ=0,
        --maxZ=800
    })
    RedZones["China"] = PolyZone:Create({
        vector2(3033.71, 5037.12),
        vector2(3045.08, 5124.62),
        vector2(3298.48, 5188.26),
        vector2(3329.55, 5113.64),
        vector2(3169.70, 5026.89)
       }, {
        name="China",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Amarelos"] = PolyZone:Create({
        vector2(1760.23, 543.56),
        vector2(1872.73, 455.30),
        vector2(1793.18, 346.97),
        vector2(1675.38, 424.62)
       }, {
        name="Amarelos",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Groove"] = PolyZone:Create({
        vector2(-170.45, -1514.39),
        vector2(-64.39, -1610.23),
        vector2(-154.55, -1726.14),
        vector2(-235.23, -1689.02),
        vector2(-232.20, -1581.06)
       }, {
        name="Groove",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Bloods"] = PolyZone:Create({
        vector2(-1064.39, 326.14),
        vector2(-1064.77, 281.06),
        vector2(-966.67, 280.68),
        vector2(-919.70, 263.64),
        vector2(-951.52, 308.33),
        vector2(-930.68, 338.64),
        vector2(-961.36, 357.58),
        vector2(-996.59, 334.09)
       }, {
        name="Bloods",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Playboy"] = PolyZone:Create({
        vector2(-1637.88, 301.52),
        vector2(-1594.32, 299.24),
        vector2(-1493.94, 233.71),
        vector2(-1447.73, 281.44),
        vector2(-1565.91, 389.39),
        vector2(-1591.29, 528.41),
        vector2(-1628.41, 537.88),
        vector2(-1687.88, 487.50),
        vector2(-1735.98, 476.52),
        vector2(-1699.62, 411.36),
        vector2(-1654.55, 408.33)
       }, {
        name="Playboy",
        --minZ=0,
        --maxZ=800
    })
    RedZones["China"] = PolyZone:Create({
        vector2(3033.71, 5037.12),
        vector2(3045.08, 5124.62),
        vector2(3298.48, 5188.26),
        vector2(3329.55, 5113.64),
        vector2(3169.70, 5026.89)
       }, {
        name="China",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Barragem"] = PolyZone:Create({
        vector2(1229.55, -324.62),
        vector2(1190.53, -228.03),
        vector2(1301.89, -196.97),
        vector2(1337.12, -296.59)
       }, {
        name="Barragem",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Overdrive"] = PolyZone:Create({
        vector2(-658.71, -1643.94),
        vector2(-606.44, -1569.70),
        vector2(-512.88, -1618.94),
        vector2(-598.48, -1683.71)
       }, {
        name="Overdrive",
        --minZ=0,
        --maxZ=800
    })
    RedZones["Outlaws"] = PolyZone:Create({
        vector2(-814.02, -2608.33),
        vector2(-772.35, -2535.61),
        vector2(-712.12, -2574.62),
        vector2(-755.30, -2649.24)
       }, {
        name="Outlaws",
        --minZ=0,
        --maxZ=800
    })
end

function Creative.isInsideZone()
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    local Inside = false
    for k,v in pairs(RedZones) do
        if v:isPointInside(Coords) then
            Inside = true
        end
    end
    return Inside
end

local Entering = false
local InRedZone = false
SafeMode = GetConvar("SafeMode", "")

AddStateBagChangeHandler('Active',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if not GlobalState["SafeZone"] then
        return
    end
    if not SafeMode == "true" then
        return
    end
    if Value and GlobalState["WarMode"] then
        CreateThread(function()
            while true do
                local Idle = 1000
                local Coords = GetEntityCoords(Ped)
                if not Entering then
                    if InRedZone then
                        if not InRedZone:isPointInside(Coords) then
                            if SafeMode == "true" then
                                Entity(Ped)["state"]:set("WarMode",false,true)
                                LocalPlayer["state"]:set("WarMode",false,true)
                                LocalPlayer["state"]:set("GreenMode",true,true)
                            end
                            Entity(Ped)["state"]:set("Newbie",true,true)
                            TriggerEvent("Notify","vermelho","Você saiu do modo de guerra.",5000,"MODO DE GUERRA")
                            -- TriggerEvent("Notify2","#leaveWarMode")
                            TriggerServerEvent("Safe:Bucket",1)
                            InRedZone = false
                        end
                    end
                    if not InRedZone and not Entity(Ped)["state"]["WarMode"] then
                        for Zone, ZoneInfo in pairs(RedZones) do
                            if ZoneInfo:isPointInside(Coords) and not Entering then
                                -- TriggerEvent("Progress","Entrando em modo de guerra",10000)
                                -- if LocalPlayer["state"]["inSafeMode"] or LocalPlayer["state"]["inSafeZone"] then
                                --     goto Skip
                                -- end
                                Entering = true
                                if LocalPlayer["state"]["GreenMode"] then
                                    if Entity(Ped)["state"]["Newbie"] then
                                        InRedZone = ZoneInfo
                                        Entity(Ped)["state"]:set("Newbie",false,true)
                                    end
                                    local Coords = GetEntityCoords(Ped)
                                    if ZoneInfo:isPointInside(Coords) then
                                        TriggerServerEvent("WarMode:Enter",false,true)
                                    end
                                end
                                -- ::Skip::
                            end
                        end
                    end
                end
                Wait(Idle)
            end
        end)
    end
end)



RegisterNetEvent("Safezone:DoneEntering",function()
    Entering = false
end)
cityName = GetConvar("cityName", "Base")
MaxDistance = 200.0

Items = {
	{ Item = "WEAPON_PISTOL_MK2", Amount = 5 },
	{ Item = "WEAPON_SPECIALCARBINE_MK2", Amount = 5 },
	{ Item = "WEAPON_SPECIALCARBINE", Amount = 2 },
	{ Item = "WEAPON_PISTOL_AMMO", Amount = 750 },
	{ Item = "WEAPON_RIFLE_AMMO", Amount = 2000 },
	{ Item = "cocaine", Amount = 20 },
	{ Item = "joint", Amount = 20 },
	{ Item = "vest", Amount = 50 },
	{ Item = "dinheirosujo", Amount = 1000000 },
    }

if cityName == "Base" then
	Items = {
		{ Item = "WEAPON_PISTOL_MK2", Amount = 5 },
		{ Item = "WEAPON_SPECIALCARBINE_MK2", Amount = 5 },
		{ Item = "WEAPON_SPECIALCARBINE", Amount = 2 },
		{ Item = "WEAPON_PISTOL_AMMO", Amount = 750 },
		{ Item = "WEAPON_RIFLE_AMMO", Amount = 2000 },
		{ Item = "cocaine", Amount = 20 },
		{ Item = "joint", Amount = 20 },
		{ Item = "vest", Amount = 50 },
		{ Item = "dinheirosujo", Amount = 1000000 }
	}
end

Homes = {
    {
        ["Zone"] = {
            vector2(-3105.68, 776.89),
            vector2(-3220.45, 734.47),
            vector2(-3267.80, 828.41),
            vector2(-3154.17, 864.39),
            vector2(-3127.65, 806.06)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao01"
    },
    {
        ["Zone"] = {
            vector2(19.70, 549.62),
            vector2(28.41, 540.15),
            vector2(32.95, 526.89),
            vector2(35.61, 516.67),
            vector2(-8.71, 499.62),
            vector2(-26.89, 509.09),
            vector2(-29.92, 525.00)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao02"
    },
    {
        ["Zone"] = {
            vector2(-831.06, 275.00),
            vector2(-843.18, 257.58),
            vector2(-842.80, 238.26),
            vector2(-814.02, 234.85),
            vector2(-798.48, 238.64),
            vector2(-802.65, 270.08)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao03"
    },
    {
        ["Zone"] = {
            vector2(-803.03, 343.18),
            vector2(-800.76, 310.61),
            vector2(-746.21, 310.61),
            vector2(-745.45, 341.67)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao04"
    },
    {
        ["Zone"] = {
            vector2(1303.03, 1186.36),
            vector2(1498.48, 1188.64),
            vector2(1512.88, 1158.33),
            vector2(1515.15, 1091.67),
            vector2(1515.91, 1034.09),
            vector2(1500.76, 1023.48),
            vector2(1430.30, 1025.76),
            vector2(1389.39, 1040.15),
            vector2(1387.88, 1104.55),
            vector2(1363.64, 1118.18)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao05"
    },
    {
        ["Zone"] = {
            vector2(-131.06, 1036.36),
            vector2(-149.24, 1007.58),
            vector2(-119.70, 937.12),
            vector2(-68.94, 905.30),
            vector2(-27.27, 919.70),
            vector2(-25.76, 965.91),
            vector2(-77.27, 1027.27)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao06"
    },
    {
        ["Zone"] = {
            vector2(-2625.38, 1637.88),
            vector2(-2675.38, 1678.41),
            vector2(-2606.06, 1741.67),
            vector2(-2543.18, 1690.53),
            vector2(-2547.35, 1670.45),
            vector2(-2567.42, 1671.21),
            vector2(-2590.53, 1662.12),
            vector2(-2610.61, 1650.76)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao07"
    },
    {
        ["Zone"] = {
            vector2(-2701.89, 1497.35),
            vector2(-2707.20, 1491.29),
            vector2(-2724.24, 1501.14),
            vector2(-2732.20, 1499.24),
            vector2(-2739.77, 1491.67),
            vector2(-2741.67, 1475.38),
            vector2(-2741.67, 1462.12),
            vector2(-2742.42, 1449.24),
            vector2(-2752.27, 1436.74),
            vector2(-2784.09, 1396.97),
            vector2(-2810.23, 1412.88),
            vector2(-2820.08, 1407.58),
            vector2(-2828.79, 1416.29),
            vector2(-2814.39, 1437.12),
            vector2(-2807.58, 1444.32),
            vector2(-2792.42, 1451.89),
            vector2(-2775.76, 1443.94),
            vector2(-2757.20, 1459.09),
            vector2(-2750.38, 1471.21),
            vector2(-2752.27, 1487.50),
            vector2(-2745.45, 1501.52),
            vector2(-2732.58, 1508.71),
            vector2(-2717.80, 1509.09)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao08"
    },
    {
        ["Zone"] = {
            vector2(-105.68, 845.45),
            vector2(-84.47, 845.08),
            vector2(-64.39, 857.95),
            vector2(-18.56, 803.79),
            vector2(-49.62, 769.32),
            vector2(-89.39, 811.74),
            vector2(-99.24, 809.85),
            vector2(-114.77, 831.82)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao09"
    },
    {
        ["Zone"] = {
            vector2(-1068.94, 324.62),
            vector2(-1070.83, 281.06),
            vector2(-960.98, 274.24),
            vector2(-928.79, 265.15),
            vector2(-924.24, 275.00),
            vector2(-932.95, 286.74),
            vector2(-941.67, 289.02),
            vector2(-956.82, 320.08),
            vector2(-950.76, 335.23),
            vector2(-951.89, 346.97),
            vector2(-965.15, 346.97),
            vector2(-981.82, 334.85),
            vector2(-1004.17, 327.65),
            vector2(-1057.20, 325.76)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao10"
    },
    {
        ["Zone"] = {
            vector2(-2541.29, 1907.95),
            vector2(-2545.45, 1898.11),
            vector2(-2547.73, 1877.27),
            vector2(-2548.48, 1863.64),
            vector2(-2575.76, 1851.89),
            vector2(-2598.86, 1849.24),
            vector2(-2644.32, 1859.85),
            vector2(-2650.38, 1868.56),
            vector2(-2598.11, 1926.14),
            vector2(-2577.27, 1929.92),
            vector2(-2556.82, 1917.80)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao11"
    },
    {
        ["Zone"] = {
            vector2(-2160.23, 2720.45),
            vector2(-2186.36, 2697.35),
            vector2(-2193.18, 2704.17),
            vector2(-2203.41, 2621.21),
            vector2(-2143.94, 2621.21),
            vector2(-2139.39, 2706.06)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao12"
    },
    {
        ["Zone"] = {
            vector2(-2632.58, 1284.85),
            vector2(-2685.61, 1287.88),
            vector2(-2675.76, 1369.70),
            vector2(-2625.76, 1362.88)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao13"
    },
    {
        ["Zone"] = {
            vector2(2572.35, 6176.52),
            vector2(2608.71, 6133.33),
            vector2(2567.05, 6105.30),
            vector2(2523.86, 6142.80)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao14"
    },
    {
        ["Zone"] = {
            vector2(164.39, 1662.12),
            vector2(138.64, 1713.64),
            vector2(200.00, 1735.61),
            vector2(230.30, 1678.03)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao15"
    },
    {
        ["Zone"] = {
            vector2(3056.06, -13.64),
            vector2(3107.58, -313.64),
            vector2(3468.18, -286.36),
            vector2(3428.79, 43.94)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao16"
    },
    {
        ["Zone"] = {
            vector2(-1767.42, 362.50),
            vector2(-1742.42, 312.88),
            vector2(-1689.77, 361.74),
            vector2(-1705.30, 396.59)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao18"
    },
    -- {
    --     ["Zone"] = {
    --         vector2(-1976.52, -490.15),
    --         vector2(-1995.83, -513.64),
    --         vector2(-1984.85, -524.24),
    --         vector2(-1962.88, -501.52)
    --     },
    --     ["Alarm"] = false,
    --     ["Owner"] = {},
    --     ["Perm"] = {},
    --     ["Name"] = "Mansao19"
    -- },
	{
        ["Zone"] = {
            vector2(-1967.42, -500.00),
			vector2(-1983.71, -523.86),
			vector2(-1993.94, -514.77),
			vector2(-1991.29, -505.68),
			vector2(-1978.03, -490.53)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao19"
    },
    {
        ["Zone"] = {
            vector2(-520.45, 523.48),
            vector2(-540.15, 504.55),
            vector2(-508.33, 473.48),
            vector2(-483.33, 488.64)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao20"
    },
    {
        ["Zone"] = {
            vector2(-942.80, 76.52),
            vector2(-918.94, 44.32),
            vector2(-889.02, 24.24),
            vector2(-869.70, 14.02),
            vector2(-856.06, 20.83),
            vector2(-857.20, 31.44),
            vector2(-867.42, 40.53),
            vector2(-862.50, 46.97),
            vector2(-871.97, 65.91)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao21"
    },
    {
        ["Zone"] = {
            vector2(-846.21, 199.24),
            vector2(-850.00, 134.09),
            vector2(-758.71, 134.47),
            vector2(-762.88, 194.32)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao22"
    },
    {
        ["Zone"] = {
            vector2(-1530.30, -73.48),
            vector2(-1491.67, -107.58),
            vector2(-1456.82, -76.89),
            vector2(-1443.94, -49.24),
            vector2(-1477.27, -16.29),
            vector2(-1520.08, -37.50),
            vector2(-1522.35, -53.79)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao23"
    },
    {
        ["Zone"] = {
            vector2(-1085.61, 338.64),
            vector2(-1088.64, 377.27),
            vector2(-1121.97, 388.64),
            vector2(-1181.06, 390.91),
            vector2(-1176.52, 351.52),
            vector2(-1162.12, 340.15)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao24"
    },
    {
        ["Zone"] = {
            vector2(-1405.68, 206.44),
            vector2(-1439.77, 248.11),
            vector2(-1523.11, 177.27),
            vector2(-1673.11, 106.82),
            vector2(-1589.02, 60.98),
            vector2(-1573.86, 64.02),
            vector2(-1554.92, 53.79),
            vector2(-1504.55, 55.30),
            vector2(-1450.38, 59.09),
            vector2(-1442.05, 67.42),
            vector2(-1445.83, 130.30),
            vector2(-1420.83, 183.71)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao25"
    },
    {
        ["Zone"] = {
            vector2(199.62, 774.24),
            vector2(209.09, 754.55),
            vector2(215.53, 745.08),
            vector2(230.30, 734.09),
            vector2(242.42, 742.80),
            vector2(250.00, 736.74),
            vector2(258.33, 743.56),
            vector2(266.29, 747.35),
            vector2(272.35, 765.53),
            vector2(268.94, 775.76),
            vector2(256.82, 780.68),
            vector2(242.42, 769.32),
            vector2(234.09, 774.24),
            vector2(217.80, 759.85),
            vector2(212.50, 775.00)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao26"
    },
    {
        ["Zone"] = {
            vector2(-216.67, 585.98),
            vector2(-220.45, 556.06),
            vector2(-247.73, 557.58),
            vector2(-251.89, 567.42),
            vector2(-250.00, 591.29)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao27"
    },
    {
        ["Zone"] = {
            vector2(-496.97, 4923.48),
            vector2(-496.21, 4993.18),
            vector2(-578.79, 5010.61),
            vector2(-584.85, 4971.21)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao28"
    },
	{
        ["Zone"] = {
			vector2(-2478.03, 3716.67),
			vector2(-2466.67, 3767.42),
			vector2(-2459.47, 3785.23),
			vector2(-2606.44, 3803.79),
			vector2(-2641.29, 3721.21)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao29"
    },
	{
        ["Zone"] = {
			vector2(-292.42, -715.53),
			vector2(-301.14, -737.88),
			vector2(-270.08, -749.24),
			vector2(-262.12, -725.76)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao31"
    },
	{
        ["Zone"] = {
			vector2(-738.64, 656.82),
			vector2(-732.20, 627.27),
			vector2(-725.00, 612.50),
			vector2(-710.98, 608.71),
			vector2(-698.11, 610.98),
			vector2(-690.53, 619.70),
			vector2(-684.85, 628.79),
			vector2(-684.09, 668.94),
			vector2(-704.55, 660.61),
			vector2(-714.02, 655.30),
			vector2(-728.03, 661.36)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao32"
    },
	{
        ["Zone"] = {
			vector2(-1862.12, 432.58),
			vector2(-1846.97, 418.56),
			vector2(-1836.74, 409.85),
			vector2(-1849.24, 409.85),
			vector2(-1860.98, 404.92),
			vector2(-1846.21, 392.05),
			vector2(-1854.55, 393.94),
			vector2(-1861.36, 389.39),
			vector2(-1856.82, 380.68),
			vector2(-1860.98, 374.24),
			vector2(-1868.18, 360.61),
			vector2(-1867.42, 340.91),
			vector2(-1844.32, 342.42),
			vector2(-1850.38, 356.06),
			vector2(-1843.94, 368.56),
			vector2(-1823.11, 377.27),
			vector2(-1808.71, 382.58),
			vector2(-1796.97, 376.89),
			vector2(-1784.09, 376.89),
			vector2(-1757.58, 392.80),
			vector2(-1749.24, 403.79),
			vector2(-1732.58, 417.05),
			vector2(-1728.41, 422.73),
			vector2(-1733.71, 431.44),
			vector2(-1736.74, 461.36),
			vector2(-1739.39, 474.62),
			vector2(-1796.59, 473.48),
			vector2(-1832.58, 474.24),
			vector2(-1840.53, 470.45),
			vector2(-1847.35, 455.68),
			vector2(-1853.41, 442.42)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao33"
    },
	{
        ["Zone"] = {
			vector2(-578.03, 959.09),
			vector2(-625.00, 902.65),
			vector2(-673.11, 925.38),
			vector2(-697.73, 946.97),
			vector2(-705.30, 963.26),
			vector2(-708.33, 976.52),
			vector2(-689.39, 982.95),
			vector2(-664.39, 984.47),
			vector2(-630.30, 981.06),
			vector2(-598.48, 970.83),
			vector2(-584.09, 963.64)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao34"
    },
	{
        ["Zone"] = {
			vector2(-559.47, 828.03),
			vector2(-560.23, 820.45),
			vector2(-566.67, 802.65),
			vector2(-570.08, 790.91),
			vector2(-549.62, 784.09),
			vector2(-543.18, 774.24),
			vector2(-534.47, 779.17),
			vector2(-526.89, 781.06),
			vector2(-519.32, 790.15),
			vector2(-515.53, 803.41),
			vector2(-512.88, 821.59),
			vector2(-522.73, 824.62),
			vector2(-539.02, 825.38)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao35"
    },
	{
        ["Zone"] = {
			vector2(-2036.74, 396.21),
			vector2(-2037.50, 373.11),
			vector2(-2035.98, 349.62),
			vector2(-2035.23, 341.67),
			vector2(-1998.11, 346.21),
			vector2(-1973.48, 346.59),
			vector2(-1973.48, 364.77),
			vector2(-1975.00, 378.79),
			vector2(-1975.00, 397.73)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao36"
    },
	{
        ["Zone"] = {
			vector2(-793.56, 814.02),
			vector2(-780.68, 750.38),
			vector2(-752.65, 756.06),
			vector2(-725.00, 774.24),
			vector2(-729.17, 789.02),
			vector2(-734.47, 802.27),
			vector2(-743.18, 810.61),
			vector2(-748.86, 820.45),
			vector2(-781.44, 815.91)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao37"
    },
	{
        ["Zone"] = {
			vector2(-1037.50, -1146.59),
			vector2(-1025.00, -1168.94),
			vector2(-1015.91, -1162.88),
			vector2(-1028.41, -1141.29)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao38"
    },
	{
        ["Zone"] = {
			vector2(-930.30, -933.33),
			vector2(-956.06, -947.35),
			vector2(-948.11, -959.47),
			vector2(-921.21, -945.45)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao39"
    },
	{
        ["Zone"] = {
			vector2(-1000.38, -877.27),
			vector2(-985.61, -903.79),
			vector2(-972.35, -896.21),
			vector2(-989.02, -869.32)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao40"
    },
	{
        ["Zone"] = {
			vector2(-1062.88, -1159.47),
			vector2(-1049.24, -1182.58),
			vector2(-1040.53, -1177.65),
			vector2(-1054.55, -1156.44)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao41"
    },
	{
        ["Zone"] = {
			vector2(-1009.47, -1082.20),
			vector2(-991.67, -1109.47),
			vector2(-981.06, -1103.03),
			vector2(-998.48, -1078.03)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao42"
    },
	{
        ["Zone"] = {
			vector2(-1037.12, -982.58),
			vector2(-1024.62, -1003.79),
			vector2(-1013.64, -997.73),
			vector2(-1026.89, -976.14)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao43"
    },
	{
        ["Zone"] = {
			vector2(-1257.20, 855.68),
			vector2(-1289.77, 790.91),
			vector2(-1294.32, 781.82),
			vector2(-1303.03, 767.42),
			vector2(-1251.52, 737.88),
			vector2(-1234.47, 729.55),
			vector2(-1173.48, 834.47),
			vector2(-1249.24, 868.18)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao44"
    },
	{
        ["Zone"] = {
			vector2(-182.20, 844.32),
			vector2(-164.77, 846.97),
			vector2(-150.76, 853.03),
			vector2(-142.42, 847.73),
			vector2(-135.61, 850.00),
			vector2(-130.30, 847.73),
			vector2(-121.59, 859.09),
			vector2(-125.76, 874.62),
			vector2(-125.00, 901.14),
			vector2(-129.55, 926.89),
			vector2(-151.52, 947.73),
			vector2(-188.26, 925.76)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao46"
    },
	{
        ["Zone"] = {
			vector2(-2707.58, -40.15),
			vector2(-2748.86, -73.11),
			vector2(-2701.52, -98.48),
			vector2(-2681.82, -70.45)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao47"
    },
	{
        ["Zone"] = {
			vector2(831.82, 3449.07),
			vector2(678.03, 3450.76),
			vector2(675.76, 3371.97),
			vector2(736.36, 3348.48),
			vector2(781.06, 3214.94),
			vector2(850.76, 3220.65),
			vector2(809.09, 3346.97),
			vector2(839.39, 3344.70)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao48"
    },
	{
        ["Zone"] = {
			vector2(1112.12, 819.70),
			vector2(1162.12, 803.03),
			vector2(1195.45, 866.67),
			vector2(1151.52, 887.12),
			vector2(1132.58, 851.52),
			vector2(1121.21, 833.33)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao53"
    },
	{
        ["Zone"] = {
			vector2(-2065.91, -220.83),
			vector2(-2026.89, -203.79),
			vector2(-1998.86, -199.62),
			vector2(-1971.59, -199.62),
			vector2(-1951.14, -203.79),
			vector2(-1939.39, -215.15),
			vector2(-1932.58, -225.00),
			vector2(-1929.17, -238.26),
			vector2(-1929.55, -253.41),
			vector2(-1935.61, -273.11),
			vector2(-1942.05, -293.94),
			vector2(-1953.03, -295.83),
			vector2(-1969.32, -273.48),
			vector2(-2007.20, -246.59),
			vector2(-2013.64, -243.18),
			vector2(-2025.38, -258.33),
			vector2(-2032.58, -253.79),
			vector2(-2041.29, -265.53),
			vector2(-2053.79, -254.92),
			vector2(-2064.39, -237.12)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Mansao56"
    },
	{
        ["Zone"] = {
			vector2(-2132.29,-1002.56),
			vector2(-2116.53,-1014.59),
			vector2(-2102.86,-1020.48),
			vector2(-2019.05,-1047),
			vector2(-2014.14,-1033.71),
			vector2(-2103.04,-1003.83),
			vector2(-2116.95,-1001.92)
        },
        ["Alarm"] = false,
        ["Owner"] = {},
        ["Perm"] = {},
        ["Name"] = "Iate01"
    },
}


Robberys = {
	["1"] = {
		["Coords"] = vec3(28.3,-1339.75,29.49),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
        ["custom"] = {
            ["coords"] = vec4(28.61,-1354.15,29.34,187.09),
        },
	},
	["2"] = {
		["Coords"] = vec3(2549.54,384.98,108.61),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(2563.97,385.47,108.46,274.97),
        },
	},
	["3"] = {
		["Coords"] = vec3(1159.46,-314.0,69.2),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1160.42,-331.18,68.92,192.76),
        },
	},
	["4"] = {
		["Coords"] = vec3(-709.78,-904.12,19.21),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-711.91,-923.15,19.01,172.92),
        },
	},
	["5"] = {
		["Coords"] = vec3(-43.45,-1748.32,29.42),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-56.34,-1759.52,28.96,130.4),
        },
	},
	["6"] = {
		["Coords"] = vec3(378.16,333.06,103.56),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(375.75,320.11,103.42,167.25),
        },
	},
	["7"] = {
		["Coords"] = vec3(-3249.6,1004.35,12.82),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-3235.34,1004.27,12.27,272.13),
        },
	},
	["8"] = {
		["Coords"] = vec3(1734.88,6420.48,35.03),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1729.06,6403.57,34.56,167.25),
        },
	},
	["9"] = {
		["Coords"] = vec3(546.4,2663.07,42.16),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(543.29,2675.94,42.12,11.34),
        },
	},
	["10"] = {
		["Coords"] = vec3(1959.25,3748.95,32.33),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1966.61,3738.1,32.2,221.11),
        },
	},
	["11"] = {
		["Coords"] = vec3(2672.92,3286.54,55.23),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(2685.57,3280.86,55.23,252.29),
        },
	},
	["12"] = {
		["Coords"] = vec3(1707.96,4920.45,42.06),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1694.96,4932.48,42.07,45.36),
        },
	},
	["13"] = {
		["Coords"] = vec3(-1829.22,798.74,138.19),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1819.72,784.29,137.88,212.6),
        },
	},
	-- ["14"] = {
	-- 	["Coords"] = vec3(-2959.66,387.08,14.04),
	-- 	["name"] = "Loja de Departamento",
	-- 	["type"] = "pequena",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "card02",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
	-- 	}
	-- },
	["15"] = {
		["Coords"] = vec3(-3047.63,585.7,7.9),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-3035.23,590.96,7.8,286.3),
        },
	},
	["16"] = {
		["Coords"] = vec3(1126.81,-980.07,45.41),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1144.01,-980.61,46.2,277.8),
        },
	},
	-- ["17"] = {
	-- 	["Coords"] = vec3(1169.33,2717.82,37.15),
	-- 	["name"] = "Loja de Departamento",
	-- 	["type"] = "pequena",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "card02",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
	-- 	}
	-- },
	-- ["18"] = {
	-- 	["Coords"] = vec3(-1478.9,-375.48,39.16),
	-- 	["name"] = "Loja de Departamento",
	-- 	["type"] = "pequena",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "card02",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
	-- 	}
	-- },
	["19"] = {
		["Coords"] = vec3(-1220.9,-916.02,11.32),
		["name"] = "Loja de Departamento",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1227.41,-900.73,12.28,31.19),
        },
	},
	-- ["20"] = {
	-- 	["Coords"] = vec3(170.97,6642.43,31.69),
	-- 	["name"] = "Loja de Departamento",
	-- 	["type"] = "pequena",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "card02",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
	-- 	},
	-- 	["custom"] = {
    --         ["coords"] = vec4(-1227.41,-900.73,12.28,31.19),
    --     },
	-- },
	-- ["21"] = {
	-- 	["Coords"] = vec3(2581.03,464.39,108.61),
	-- 	["name"] = "Loja de Departamento",
	-- 	["type"] = "pequena",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "card02",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
	-- 	}
	-- },
	-- ["22"] = {
	-- 	["Coords"] = vec3(819.29,-774.6,26.17),
	-- 	["name"] = "Loja de Departamento",
	-- 	["type"] = "pequena",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "card02",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
	-- 	}
	-- },
	["23"] = {
		["Coords"] = vec3(1693.06,3762.16,34.69),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1702.53,3748.88,34.07,51.03),
        },
	},
	["24"] = {
		["Coords"] = vec3(253.51,-51.85,69.94),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(241.18,-44.29,69.67,70.87),
        },
	},
	["25"] = {
		["Coords"] = vec3(841.13,-1035.32,28.19),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(844.57,-1019.57,27.53,19.85),
        },
	},
	["26"] = {
		["Coords"] = vec3(-330.87,6086.01,31.46),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-323.11,6073.14,31.24,226.78),
        },
	},
	["27"] = {
		["Coords"] = vec3(-660.94,-933.33,21.82),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-664.39,-947.32,21.58,187.09),
        },
	},
	["28"] = {
		["Coords"] = vec3(-1304.3,-395.93,36.7),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1317.25,-389.51,36.4,87.88),
        },
	},
	["29"] = {
		["Coords"] = vec3(-1118.24,2700.85,18.55),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1110.23,2686.08,18.67,246.62),
        },
	},
	["30"] = {
		["Coords"] = vec3(2566.55,292.4,108.73),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(2570.48,307.92,108.6,323.15),
        },
	},
	["31"] = {
		["Coords"] = vec3(-3173.1,1089.68,20.84),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-3161.68,1081.05,20.76,252.29),
        },
	},
	["32"] = {
		["Coords"] = vec3(23.85,-1105.84,29.79),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(16.95,-1117.23,29.79,138.9),
        },
	},
	["33"] = {
		["Coords"] = vec3(808.86,-2159.05,29.62),
		["name"] = "Loja de Armas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(812.31,-2144.46,29.28,2.84),
        },
	},
	["34"] = {
		["Coords"] = vec3(134.71,-1707.82,29.28),
		["name"] = "Barbearia",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(131.29,-1714.14,29.25,107.72),
        },
	},
	["35"] = {
		["Coords"] = vec3(1211.49,-470.74,66.2),
		["name"] = "Barbearia",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1204.86,-469.92,66.27,82.21),
        },
	},
	["36"] = {
		["Coords"] = vec3(-1284.22,-1115.12,6.99),
		["name"] = "Barbearia",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1292.14,-1116.59,6.64,93.55),
        },
	},
	["37"] = {
		["Coords"] = vec3(-821.84,-183.37,37.56),
		["name"] = "Barbearia",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-826.93,-191.28,37.59,127.56),
        },
	},
	["38"] = {
		["Coords"] = vec3(-1211.19,-335.64,37.78),
		["name"] = "Fleeca lifeinvader",
		["type"] = "media", 
		["cooldown"] = 600,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 5000000, ["max"] = 6200000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1217.97,-321.82,37.64,127.56),
        },
	},
	["39"] = {
		["Coords"] = vec3(-353.38,-54.31,49.03),
		["name"] = "Fleeca shopping",
		["type"] = "media",
		["cooldown"] = 240,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 5000000, ["max"] = 6200000 }
		},
		["custom"] = {
            ["coords"] = vec4(-349.66,-32.17,47.45,252.29),
        },
	},
	["40"] = {
		["Coords"] = vec3(311.85,-283.38,54.16),
		["name"] = "Fleeca chaves",
		["type"] = "media",
		["cooldown"] = 600,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 5000000, ["max"] = 6200000 }
		},
		["custom"] = {
            ["coords"] = vec4(319.4,-270.21,53.82,153.08),
        },
	},
	-- ["41"] = {
	-- 	["Coords"] = vec3(147.18,-1046.23,29.68),
	-- 	["name"] = "Fleeca praca",
	-- 	["type"] = "media",
	-- 	["cooldown"] = 240,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 12,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "pendrive",
	-- 		["amount"] = 2
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 1000000, ["max"] = 1200000 }
	-- 	}
	-- },
	["42"] = {
		["Coords"] = vec3(-2957.74,481.94,15.69),
		["name"] = "Fleeca praia",
		["type"] = "media",
		["cooldown"] = 600,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 5000000, ["max"] = 6200000 }
		},
		["custom"] = {
            ["coords"] = vec4(-2971.51,483.64,15.43,155.91),
        },
	},
	["43"] = {
		["Coords"] = vec3(1175.93,2711.81,38.08),
		["name"] = "Fleeca petshop",
		["type"] = "media",
		["cooldown"] = 600,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 5000000, ["max"] = 6200000 }
		},
		["custom"] = {
            ["coords"] = vec4(1175.57,2696.67,37.96,178.59),
        },
	},
    ["44"] = {
		["Coords"] = vec3(1126.81,-980.08,45.41),
		["name"] = "Bebidas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1147.15,-982.37,46.1,184.26),
        },
	},
    ["45"] = {
		["Coords"] = vec3(-1478.94,-375.46,39.16),
		["name"] = "Bebidas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1493.67,-386.51,39.85,110.56),
        },
	},
    ["46"] = {
		["Coords"] = vec3(1169.23,2717.91,37.15),
		["name"] = "Bebidas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1176.02,2696.23,37.96,0.0),
        },
	},
    ["47"] = {
		["Coords"] = vec3(-2959.68,387.33,14.04),
		["name"] = "Bebidas",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-2977.88,390.26,15.01,102.05),
        },
	},
    -- ["48"] = {
	-- 	["Coords"] = vec3(1234.61,-354.65,69.08),
	-- 	["name"] = "Fast Food",
	-- 	["type"] = "pequena",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "card02",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
	-- 	}
	-- },
    ["49"] = {
		["Coords"] = vec3(90.6,298.17,110.21),
		["name"] = "Mc Donalds",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(78.82,263.91,109.09,155.91),
        },
	},
    ["50"] = {
		["Coords"] = vec3(-242.08,279.68,92.03),
		["name"] = "Lanchonete",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(-241.87,275.16,92.03,2.84),
        },
	},
    ["51"] = {
		["Coords"] = vec3(-431.12,288.82,86.05),
		["name"] = "Comedy Club",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(-409.74,271.28,83.15,2.84),
        },
	},
    ["52"] = {
		["Coords"] = vec3(990.39,-2149.64,30.19),
		["name"] = "Açougue",
		["type"] = "media",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 710000, ["max"] = 850000 }
		},
		["custom"] = {
            ["coords"] = vec4(938.3,-2109.36,30.45,306.15),
        },
	},
    ["53"] = {
		["Coords"] = vec3(2403.7,3127.82,48.16),
		["name"] = "Aeroporto Abandonado",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 45000, ["max"] = 55000 }
		},
		["custom"] = {
            ["coords"] = vec4(2375.95,3124.03,48.02,277.8),
        },
	},
    ["54"] = {
		["Coords"] = vec3(484.16,-1876.48,26.3),
		["name"] = "Atomic",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(493.22,-1879.79,26.23,274.97),
        },
	},
    ["55"] = {
		["Coords"] = vec3(187.05,-1655.19,29.93),
		["name"] = "Bombeiro",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(186.37,-1672.81,29.77,354.34),
        },
	},
    ["56"] = {
		["Coords"] = vec3(-1083.2,-1262.03,5.59),
		["name"] = "Cafeteria",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1070.46,-1270.83,5.91,76.54),
        },
	},
    ["57"] = {
		["Coords"] = vec3(482.6,-1685.09,29.93),
		["name"] = "Carpets",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(461.97,-1667.06,29.32,76.54),
        },
	},
    ["58"] = {
		["Coords"] = vec3(-1684.93,-291.4,51.88),
		["name"] = "Cemitério",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1660.47,-296.86,51.7,73.71),
        },
	},
    ["59"] = {
		["Coords"] = vec3(453.05,-607.74,28.59),
		["name"] = "Dashound Bus",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 45000, ["max"] = 60000 }
		},
		["custom"] = {
            ["coords"] = vec4(452.89,-668.42,28.11,357.17),
        },
	},
    ["60"] = {
		["Coords"] = vec3(-536.51,-46.03,42.63),
		["name"] = "Doceria",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 24000, ["max"] = 40000 }
		},
		["custom"] = {
            ["coords"] = vec4(-550.86,-55.16,42.14,357.17),
        },
	},
    ["61"] = {
		["Coords"] = vec3(1239.2,354.74,81.99),
		["name"] = "Estabulo",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1206.97,337.96,81.97,357.17),
        },
	},
    -- ["62"] = {
	-- 	["Coords"] = vec3(1441.2,1137.83,114.33),
	-- 	["name"] = "Fazenda",
	-- 	["type"] = "media",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "pendrive",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 710000, ["max"] = 850000 }
	-- 	},
	-- 	["custom"] = {
    --         ["coords"] = vec4(186.37,-1672.81,29.77,354.34),
    --     },
	-- },
    ["63"] = {
		["Coords"] = vec3(402.3,-339.03,46.98),
		["name"] = "Festa Junina",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(371.12,-375.77,46.88,357.17),
        },
	},
    ["64"] = {
		["Coords"] = vec3(-1366.1,56.68,54.09),
		["name"] = "Campo de golfe",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 45000, ["max"] = 70000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1342.11,-0.56,51.91,8.51),
        },
	},
    ["65"] = {
		["Coords"] = vec3(959.17,-121.14,74.96),
		["name"] = "Moto clube Sul",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 50000, ["max"] = 70000 }
		},
		["custom"] = {
            ["coords"] = vec4(958.4,-142.45,74.49,283.47),
        },
	},
    ["66"] = {
		["Coords"] = vec3(-1142.87,-1993.33,13.16),
		["name"] = "Mecanica abandonada",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 45000, ["max"] = 65000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1123.17,-1980.59,13.16,110.56),
        },
	},
    ["67"] = {
		["Coords"] = vec3(1082.6,-787.58,58.32),
		["name"] = "Hipermercado",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 45000, ["max"] = 60000 }
		},
		["custom"] = {
            ["coords"] = vec4(1122.3,-767.94,57.68,104.89),
        },
	},
    ["68"] = {
		["Coords"] = vec3(-424.06,-2789.57,6.4),
		["name"] = "Mini porto",
		["type"] = "media",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 710000, ["max"] = 850000 }
		},
		["custom"] = {
            ["coords"] = vec4(-398.53,-2776.81,6.0,90.71),
        },
	},
    ["69"] = {
		["Coords"] = vec3(144.16,-3324.0,6.02),
		["name"] = "Porto",
		["type"] = "media",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{{ ["item"] = "dinheirosujo", ["min"] = 710000, ["max"] = 850000 }}
        },
		["custom"] = {
            ["coords"] = vec4(170.8,-3304.48,5.81,90.71),
        },
    },
    ["70"] = {
		["Coords"] = vec3(-356.01,-1486.76,30.18),
		["name"] = "Posto Groove",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(-332.79,-1458.01,30.5,90.71),
        },
	},
    ["71"] = {
		["Coords"] = vec3(-26.91,-1672.44,29.49),
		["name"] = "Mosley Groove",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(-46.7,-1655.67,29.28,2.84),
        },
	},
    ["72"] = {
		["Coords"] = vec3(566.13,-1778.12,29.35),
		["name"] = "Motel Igreja",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(578.93,-1737.82,29.23,107.72),
        },
	},
    ["73"] = {
		["Coords"] = vec3(-1035.36,-1227.79,6.34),
		["name"] = "Pink yellow",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 50000, ["max"] = 70000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1022.25,-1243.31,5.96,136.07),
        },
	},
    ["74"] = {
		["Coords"] = vec3(302.0,-191.02,61.57),
		["name"] = "Pista de skate",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(312.36,-236.94,53.99,136.07),
        },
	},
    ["75"] = {
		["Coords"] = vec3(-684.27,-1170.93,10.62),
		["name"] = "Planet",
		["type"] = "media",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 710000, ["max"] = 850000 }
		},
		["custom"] = {
            ["coords"] = vec4(-737.63,-1111.55,11.1,136.07),
        },
	},
    ["76"] = {
		["Coords"] = vec3(1200.49,-1277.31,35.57),
		["name"] = "Posto crips",
		["type"] = "media",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 710000, ["max"] = 850000 }
		},
		["custom"] = {
            ["coords"] = vec4(1233.95,-1219.52,35.69,181.42),
        },
	},
    ["77"] = {
		["Coords"] = vec3(-842.29,-124.68,28.19),
		["name"] = "Bilheteria",
		["type"] = "media",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 710000, ["max"] = 850000 }
		},
		["custom"] = {
            ["coords"] = vec4(-794.9,-98.24,37.64,153.08),
        },
	},
    ["78"] = {
		["Coords"] = vec3(1104.19,86.62,80.88),
		["name"] = "Quiosque",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
		},
		["custom"] = {
            ["coords"] = vec4(1135.93,55.02,80.74,133.23),
        },
	},
    ["79"] = {
		["Coords"] = vec3(849.41,2383.72,54.16),
		["name"] = "Rebel",
		["type"] = "grande",
		["cooldown"] = 240,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 1800000, ["max"] = 2500000 }
		}
	},
    ["80"] = {
		["Coords"] = vec3(-1170.14,-534.56,30.16),
		["name"] = "Teatro",
		["type"] = "media",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 1000000, ["max"] = 1500000 }
		},
		["custom"] = {
            ["coords"] = vec4(-1217.02,-577.52,27.14,238.12),
        },
	},
    -- ["81"] = {
	-- 	["Coords"] = vec3(420.31,-2064.17,22.14),
	-- 	["name"] = "Warning vago",
	-- 	["type"] = "pequena",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "card02",
	-- 		["amount"] = 1
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
	-- 	},
	-- 	["custom"] = {
    --         ["coords"] = vec4(-1342.11,-0.56,51.91,8.51),
    --     },
	-- },
    ["82"] = {
		["Coords"] = vec3(1982.5,3053.65,47.21),
		["name"] = "Yellow Jack",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(1993.88,3064.08,47.04,314.65),
        },
	},
    ["83"] = {
		["Coords"] = vec3(20.43,-1505.7,31.85),
		["name"] = "Igreja Groove",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(29.7,-1514.55,29.28,314.65),
        },
	},
    ["84"] = {
		["Coords"] = vec3(200.05,336.08,105.58),
		["name"] = "Love 66",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(206.6,350.52,105.78,314.65),
        },
	},
    ["85"] = {
		["Coords"] = vec3(232.62,-1781.41,28.95),
		["name"] = "Guetto Shopping",
		["type"] = "pequena",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 110000, ["max"] = 150000 }
		},
		["custom"] = {
            ["coords"] = vec4(228.14,-1796.79,28.17,266.46),
        },
	},
    -- ["86"] = {
	-- 	["Coords"] = vec3(1243.23,1869.34,78.96),
	-- 	["name"] = "porto",
	-- 	["type"] = "media",
	-- 	["cooldown"] = 150,
	-- 	["duration"] = 20,
	-- 	["group"] = "Policia",
	-- 	["population"] = 6,
	-- 	["avaiable"] = false,
	-- 	["timavaiable"] = 0,
	-- 	["need"] = {
	-- 		["item"] = "pendrive",
	-- 		["amount"] = 2
	-- 	},
	-- 	["payment"] = {
	-- 		{ ["item"] = "dinheirosujo", ["min"] = 1000000, ["max"] = 1500000 }
	-- 	}
	-- },
    ["87"] = {
		["Coords"] = vec3(253.22,228.32,101.67),
		["name"] = "Banco Central",
		["type"] = "grande",
		["cooldown"] = 1800,
		["duration"] = 120,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "c4",
			["amount"] = 5
		},
		["payment"] = {
			{ ["item"] = "WEAPON_PISTOL50", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "WEAPON_SMG_MK2", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_PUMPSHOTGUN", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_SPECIALCARBINE_MK2", ["min"] = 4, ["max"] = 4 },
            { ["item"] = "WEAPON_PARAFAL", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "dinheirosujo", ["min"] = 7500000, ["max"] = 9000000 },
		}
	},
    ["88"] = {
		["Coords"] = vec3(-631.09,-229.81,38.05),
		["name"] = "Joalheria",
		["type"] = "grande",
		["cooldown"] = 1800,
		["duration"] = 120,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "c4",
			["amount"] = 5
		},
		["payment"] = {
			{ ["item"] = "WEAPON_PISTOL50", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "WEAPON_SMG_MK2", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_PUMPSHOTGUN", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_SPECIALCARBINE_MK2", ["min"] = 4, ["max"] = 4 },
            { ["item"] = "WEAPON_PARAFAL", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "dinheirosujo", ["min"] = 7500000, ["max"] = 9000000 },
		}
	},
    ["89"] = {
		["Coords"] = vec3(-103.81,6477.75,31.63),
		["name"] = "Paleto",
		["type"] = "grande",
		["cooldown"] = 1800,
		["duration"] = 120,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "c4",
			["amount"] = 5
		},
		["payment"] = {
			{ ["item"] = "WEAPON_PISTOL50", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "WEAPON_SMG_MK2", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_PUMPSHOTGUN", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_SPECIALCARBINE_MK2", ["min"] = 4, ["max"] = 4 },
            { ["item"] = "WEAPON_PARAFAL", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "dinheirosujo", ["min"] = 7500000, ["max"] = 9000000 },
		}
	},
    ["90"] = {
		["Coords"] = vec3(-566.16,5325.79,73.58),
		["name"] = "Madeireira",
		["type"] = "grande",
		["cooldown"] = 1800,
		["duration"] = 120,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "c4",
			["amount"] = 5
		},
		["payment"] = {
			{ ["item"] = "WEAPON_PISTOL50", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "WEAPON_SMG_MK2", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_PUMPSHOTGUN", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_SPECIALCARBINE_MK2", ["min"] = 4, ["max"] = 4 },
            { ["item"] = "WEAPON_PARAFAL", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "dinheirosujo", ["min"] = 1000000, ["max"] = 11000000 },
		}
	},
    ["91"] = {
		["Coords"] = vec3(-2260.45,3257.0,32.81),
		["name"] = "Zancudo",
		["type"] = "grande",
		["cooldown"] = 1800,
		["duration"] = 120,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "c4",
			["amount"] = 5
		},
		["payment"] = {
			{ ["item"] = "WEAPON_PISTOL50", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "WEAPON_SMG_MK2", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_PUMPSHOTGUN", ["min"] = 2, ["max"] = 2 },
            { ["item"] = "WEAPON_SPECIALCARBINE_MK2", ["min"] = 4, ["max"] = 4 },
            { ["item"] = "WEAPON_PARAFAL", ["min"] = 1, ["max"] = 1 },
            { ["item"] = "dinheirosujo", ["min"] = 1000000, ["max"] = 11000000 },
		}
	},
	["92"] = {
		["Coords"] = vec3(700.63,576.02,130.45),
		["name"] = "Observatório",
		["type"] = "media",
		["cooldown"] = 150,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dinheirosujo", ["min"] = 1000000, ["max"] = 1100000 }
		},
		["custom"] = {
            ["coords"] = vec4(901.79,513.91,122.03,266.46),
        },
	},
	["93"] = {
		["Coords"] = vec3(-77.9,6224.06,31.09),
		["name"] = "Galinheiro",
		["type"] = "media", 
		["cooldown"] = 240,
		["duration"] = 20,
		["group"] = "Policia",
		["population"] = 12,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 2
		},
		["payment"] = {
			
			{ ["item"] = "dinheirosujo", ["min"] = 1000000, ["max"] = 1200000 }
		},
		["custom"] = {
            ["coords"] = vec4(-80.37,6276.52,31.42,266.46),
        },
	},
}
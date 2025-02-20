warSystemConfig = {
  ["Paleto"] = {
      ["maxPoints"] = 300,
      ["maxTime"] = 10,
      ["maxPlayers"] = 999,
      ["Name"] = "Paleto", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(-677.27, 6071.21),
          vector2(-418.18, 5913.64),
          vector2(231.82, 6581.82),
          vector2(28.79, 6710.61)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(-136.36, 6324.24),
          vector2(-92.42, 6284.85),
          vector2(-43.18, 6334.09),
          vector2(-91.67, 6365.15)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Guetos"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Guetos", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(45.45, -1493.94),
          vector2(469.70, -1831.82),
          vector2(305.30, -1982.58),
          vector2(75.00, -1850.00),
          vector2(-18.18, -1768.94),
          vector2(-118.18, -1695.45),
          vector2(-38.64, -1605.30)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(-35.61, -1722.73),
          vector2(21.97, -1762.12),
          vector2(75.76, -1710.61),
          vector2(6.06, -1679.55)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Sandy"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Sandy", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(1092.42, 3653.03),
          vector2(1240.91, 3531.82),
          vector2(1759.09, 3460.61),
          vector2(2140.91, 3678.79),
          vector2(2003.03, 3780.30),
          vector2(1907.58, 3930.30),
          vector2(1603.03, 3859.09)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(1604.55, 3662.12),
          vector2(1643.18, 3602.27),
          vector2(1776.52, 3677.27),
          vector2(1736.36, 3742.42)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Ice"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Ice Store", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(909.85, -1455.30),
          vector2(734.85, -1628.03),
          vector2(700.76, -1939.39),
          vector2(1030.30, -1973.48),
          vector2(1024.24, -1453.03)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(925.76, -1492.05),
          vector2(924.62, -1521.97),
          vector2(976.89, -1523.11),
          vector2(974.62, -1488.64)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Veneza"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Veneza", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(-1248.48, -980.30),
          vector2(-943.94, -822.73),
          vector2(-745.45, -1166.67),
          vector2(-1134.85, -1334.85)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(-1056.44, -1045.83),
          vector2(-987.88, -1158.71),
          vector2(-975.38, -1154.55),
          vector2(-1044.32, -1039.39)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=100,
      },
  },

  ["Fazendas"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Fazendas", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(2400.76, 5130.30),
          vector2(2090.91, 4841.67),
          vector2(2427.27, 4584.09),
          vector2(2659.09, 4848.48),
          vector2(2593.18, 5086.36)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(2386.36, 4875.00),
          vector2(2437.88, 4827.27),
          vector2(2496.97, 4880.30),
          vector2(2434.09, 4917.42)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Zancudo"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Zancudo", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(-2440.91, 3698.48),
          vector2(-1481.82, 3156.06),
          vector2(-1853.03, 2656.06),
          vector2(-2903.03, 3240.91)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(-2240.15, 3196.21),
          vector2(-2288.64, 3071.21),
          vector2(-2100.00, 2983.33),
          vector2(-2101.52, 3168.18)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Offroad"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Offroad", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(836.36, 2525.76),
          vector2(792.42, 2210.61),
          vector2(1101.52, 2037.88),
          vector2(1215.15, 2042.42),
          vector2(1169.70, 2550.00)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(943.94, 2352.65),
          vector2(946.59, 2289.77),
          vector2(1014.77, 2289.39),
          vector2(1006.06, 2357.95)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Prisao"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Prisao", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(1548.48, 2757.58),
          vector2(1431.82, 2356.06),
          vector2(1800.00, 2309.09),
          vector2(1966.67, 2840.91)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(1634.85, 2534.85),
          vector2(1640.91, 2486.36),
          vector2(1751.52, 2504.55),
          vector2(1733.33, 2546.97)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Madeireira"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Madeireira", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(-622.73, 5542.42),
          vector2(-839.39, 5254.55),
          vector2(-431.82, 5021.21),
          vector2(-322.73, 5504.55)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(-556.82, 5322.73),
          vector2(-581.06, 5273.48),
          vector2(-528.79, 5253.79),
          vector2(-509.09, 5307.58)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=120,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=120,
      },
  },

  ["Industria"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Industria", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(2504.55, 1771.21),
          vector2(2940.91, 1753.03),
          vector2(2780.30, 1259.09),
          vector2(2474.24, 1304.55)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(2767.80, 1551.89),
          vector2(2755.68, 1506.06),
          vector2(2796.21, 1496.59),
          vector2(2810.98, 1543.94)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["DepartamentoPolicial"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Dep. Policial", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(2462.12, -160.61),
          vector2(2224.24, -495.45),
          vector2(2536.36, -722.73),
          vector2(2789.39, -246.97)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(2525.38, -367.42),
          vector2(2526.14, -411.36),
          vector2(2569.70, -411.36),
          vector2(2564.77, -359.09)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=160,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=160,
      },
  },

  ["Airport"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Aeroporto", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(-1256.06, -2175.76),
          vector2(-965.15, -2378.79),
          vector2(-1198.48, -2803.03),
          vector2(-1012.12, -2904.55),
          vector2(-1080.30, -3006.06),
          vector2(-1642.42, -2715.15)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(-1342.42, -2512.12),
          vector2(-1416.67, -2607.58),
          vector2(-1309.09, -2654.55),
          vector2(-1227.27, -2557.58)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=100,
      },
  },

  ["AreaNobre"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Area Nobre", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(796.97, -492.42),
          vector2(1151.52, -287.88),
          vector2(1481.82, -601.52),
          vector2(1403.03, -886.36),
          vector2(1045.45, -827.27),
          vector2(810.61, -616.67)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(1307.58, -677.27),
          vector2(1259.85, -765.91),
          vector2(1408.33, -823.48),
          vector2(1443.18, -684.85)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Praça"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Praça", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(20.45, -748.48),
          vector2(-95.45, -1065.15),
          vector2(335.61, -1146.97),
          vector2(349.24, -837.12)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(149.24, -921.21),
          vector2(128.79, -993.18),
          vector2(214.39, -1027.27),
          vector2(243.94, -939.39)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=100,
      },
  },

  ["Porto"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Porto", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(1401.52, -2871.21),
          vector2(725.76, -2866.67),
          vector2(674.24, -3472.73),
          vector2(1592.42, -3456.06)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(916.67, -3132.58),
          vector2(914.39, -3219.70),
          vector2(1026.52, -3221.21),
          vector2(1019.70, -3129.55)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=100,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=100,
      },
  },

  ["Favela 1"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Favela 1", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(1274.24, 1581.82),
          vector2(1284.85, 1195.45),
          vector2(1628.79, 1180.30),
          vector2(1596.97, 1598.48)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(1374.24, 1425.76),
          vector2(1378.79, 1353.03),
          vector2(1463.64, 1354.55),
          vector2(1451.52, 1434.85)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=20,
          maxZ=170,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=20,
          maxZ=170,
      },
  },

  ["Favela 2"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Favela 2", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(1725.76, 3992.42),
          vector2(2050.00, 3546.97),
          vector2(2765.15, 4053.03),
          vector2(2159.09, 4274.24)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(2089.39, 3943.94),
          vector2(2153.03, 3871.21),
          vector2(2283.33, 3943.94),
          vector2(2168.18, 4022.73)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
  },

  ["Favela 3"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Favela 3", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(840.91, 3531.82),
          vector2(804.55, 3110.61),
          vector2(1459.09, 3140.91),
          vector2(1356.06, 3589.39)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(1056.06, 3265.15),
          vector2(1065.15, 3201.52),
          vector2(1162.12, 3213.64),
          vector2(1146.97, 3301.52)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
  },

  ["Favela 4"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Favela 4", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(1621.21, -28.79),
          vector2(1630.30, -312.12),
          vector2(1151.52, -418.18),
          vector2(1006.06, -104.55),
          vector2(1387.88, 18.18)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(1133.33, -136.36),
          vector2(1169.70, -162.88),
          vector2(1216.67, -115.91),
          vector2(1159.85, -99.24)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
  },

  ["Favela 5"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Favela 5", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(1978.79, 478.79),
          vector2(1586.36, 680.30),
          vector2(1339.39, 363.64),
          vector2(1887.88, 95.45)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(1807.95, 442.42),
          vector2(1798.48, 420.83),
          vector2(1837.88, 403.79),
          vector2(1842.80, 440.91)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
  },

  ["Favela 6"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Favela 6", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(2019.70, 5886.36),
          vector2(2693.94, 5630.30),
          vector2(2640.91, 4974.24),
          vector2(1575.76, 5534.85)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(2208.33, 5638.64),
          vector2(2137.88, 5542.42),
          vector2(2255.30, 5499.24),
          vector2(2274.24, 5624.24)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
  },

  ["Central"] = {
    ["maxPoints"] = 750,
    ["maxTime"] = 9999,
    ["maxPlayers"] = 10,
    ["Name"] = "Central", -- NOME DA ZONA
    ["Points"] = {
        ["Point"] = 1, -- PONTOS POR SEGUNDO
        ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
        ["DeathPoint"] = 1,
        ["DoubleDeathPoint"] = 4,
    },
    ["Point"] = { -- COORDENADAS DA ZONA
        vector2(109.09, 449.24),
        vector2(585.61, 263.64),
        vector2(403.03, -149.24),
        vector2(-85.61, 43.94)
    },
    ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
        vector2(109.09, 449.24),
        vector2(585.61, 263.64),
        vector2(403.03, -149.24),
        vector2(-85.61, 43.94)
    },
    ["reward"] = {
        ["dollars"] = 5000,
    },
    ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
        debugColors = {
            noLines = true,
            opacity = 25,
            walls = {255,0,0},
        },
        debugGrid = true,
        minZ=1,
        maxZ=170,
    },
    ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
        debugColors = {
            noLines = true,
            opacity = 25,
            walls = {0,255,0}
        },
        debugGrid = true,
        minZ=1,
        maxZ=170,
    },
},

  ["Favela 7"] = {
      ["maxPoints"] = 750,
      ["maxTime"] = 9999,
      ["maxPlayers"] = 10,
      ["Name"] = "Favela 7", -- NOME DA ZONA
      ["Points"] = {
          ["Point"] = 1, -- PONTOS POR SEGUNDO
          ["DoublePoint"] = 4, -- PONTOS POR SEGUNDO SE ESTIVER NA ZONA
          ["DeathPoint"] = 1,
          ["DoubleDeathPoint"] = 4,
      },
      ["Point"] = { -- COORDENADAS DA ZONA
          vector2(2915.15, 5578.79),
          vector2(2910.61, 4837.88),
          vector2(3521.21, 4892.42),
          vector2(3266.67, 5571.21)
      },
      ["DoublePoint"] = { -- ZONA DE PONTOS DOBRADOS
          vector2(3260.61, 5201.52),
          vector2(3251.52, 5128.03),
          vector2(3343.18, 5121.21),
          vector2(3329.55, 5206.06)
      },
      ["reward"] = {
          ["dollars"] = 5000,
      },
      ["optionsD"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {255,0,0},
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
      ["optionsP"] = { -- SERVE SOMENTE PARA DEBUG
          debugColors = {
              noLines = true,
              opacity = 25,
              walls = {0,255,0}
          },
          debugGrid = true,
          minZ=1,
          maxZ=170,
      },
  },
}

warSytemGroups = {
  ["TESTE1"] = true,
  ["TESTE2"] = true,
  ["Bloods"] = true,
  ["Mercenarios"] = true,
  ["Bopegg"] = true,
  ["LaMafia"] = true,
  ["Franca"] = true,
  ["Italia"] = true,
  ["Russia"] = true,
  ["Israel"] = true,
  ["Playboy"] = true,
  ["Mexico"] = true,
  ["Gringa"] = true,
  ["China"] = true,
  ["Crips"] = true,
  ["Tropadu7"] = true,
  ["SonsofAnarchy"] = true,
  ["Sinaloa"] = true,
  ["HellsAngels"] = true,
  ["Triade"] = true,
  ["Yakuza"] = true,
  ["Warlocks"] = true,
  ["Groove"] = true,
  ["Outlaws"] = true,
  ["TopGear"] = true,
  ["Redline"] = true,
  ["Bennys"] = true,
  ["DriftKing"] = true,
  ["Forza"] = true,
  ["Overdrive"] = true,
  ["Ballas"] = true,
  ["Bellagio"] = true,
  ["Galaxy"] = true,
  ["Bahamas"] = true,
  ["Palazzo"] = true,
  ["Luxor"] = true,
  ["Barragem"] = true,
  ["Cartel"] = true,
  ["Sindicato"] = true,
  ["Vagos"] = true,
  ["Umbrella"] = true,
  ["Azuis"] = true,
  ["Vermelhos"] = true,
  ["Amarelos"] = true,
  ["AlcateiaHsT"] = true,
  ["Verdes"] = true,
  ["Roxos"] = true,
  ["LosAztecas"] = true,
  ["Laranjas"] = true,
  ["Marrons"] = true,
  ["Cinzas"] = true,
  ["Brancos"] = true,
  ["Policia"] = true,
  ["Bombeiros"] = true,
  ["Paramedic"] = true,
  ["Mechanic"] = true,
  ["Rosas"] = true
}

Logos = {
	["Base"] = "SEU LINK AQUI",

}

DiscordConv = {
    ["Base"] = "SEU LINK AQUI",
}

function DominationType()
  return dominationType
end

function DominationConfig()
  return warSystemConfig
end
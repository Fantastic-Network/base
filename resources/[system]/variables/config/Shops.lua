local Shops = {
	{ -1222.76, -907.1, 12.33,"Departament",true },
	{ -707.4, -914.06, 19.22,"Departament",true },
	{ 25.75, -1346.61, 29.5,"Departament",true },
	{ 1135.64, -982.08, 46.42,"Departament",true },
	{ 1163.45, -323.0, 69.21,"Departament",true },
	{ 374.06, 327.1, 103.57,"Departament",true },
	{ -1487.26, -379.06, 40.17,"Departament",true },
	{ -2967.88, 390.74, 15.05,"Departament",true },
	{ -3040.35, 585.44, 7.91,"Departament",true },
	{ -3243.22, 1001.35, 12.84,"Departament",true },
	{ 547.92, 2670.29, 42.16,"Departament",true },
	{ 1166.04, 2709.35, 38.16,"Departament",true },
	{ 2556.43, 382.13, 108.63,"Departament",true },
	{ 2677.92, 3280.95, 55.25,"Departament",true },
	{ 1960.74, 3741.45, 32.35,"Departament",true },
	{ 1698.6, 4924.12, 42.07,"Departament",true },
	{ 1729.37, 6415.4, 35.04,"Departament",true },
	{ 1392.59,3604.78,34.98,"Departament",true },
	{ -48.4,-1757.53,29.42,"Departament",true },
	{ -1820.45,792.64,138.1,"Departament",true },
	{ 1108.5,208.79,-49.45,"Departament",true },
	{ 1115.48,209.35,-49.45,"Departament",true },
	{ -2580.98,1868.14,163.8,"Departament",true },
	{ 21.76,-1105.92,30.78,"Ammunation",false },
	{ 248.17,-51.78,69.94,"Ammunation",false },
	{ 810.62,-2157.54,29.62,"Ammunation",false },
	{ 841.18,-1030.12,28.19,"Ammunation",false },
	{ -327.07,6082.22,31.46,"Ammunation",false },
	{ -659.18,-938.47,21.82,"Ammunation",false },
	{ -1309.43,-394.56,36.7,"Ammunation",false },
	{ -1113.41,2698.19,18.55,"Ammunation",false },
	{ 2564.83,297.46,108.73,"Ammunation",false },
	{ -3168.32,1087.46,20.84,"Ammunation",false },
	{ 16.91,-1107.56,29.79,"Ammunation",false },
	{ 814.84,-2155.14,29.62,"Ammunation",false },
	{ -1816.64,-1193.73,14.31,"Fishing",false }, -- Loja de vender peixes no pier
	{ 1523.69,3782.48,34.51,"Fishing2",true }, -- Loja de comprar itens para pescar
	{ 1134.98,-1546.32,35.38,"Paramedic",false },
	{ 1148.68,-1558.72,35.38,"Paramedic",false },
	{ -428.57,-1728.35,19.78,"Recycle",false },
	{ 1150.5,-1556.08,35.38,"Pharmacy",false }, -- hp
	{ 1836.08,3668.75,33.94,"Pharmacy",false },
	{ -1198.15,-1458.38,4.36,"Pharmacy",false },
	{ -1255.49,-1436.33,4.36,"Pharmacy",false },
	{ 591.17,2743.5,42.04,"Pharmacy",false },
	{ 261.17,6321.34,32.42,"Pharmacy",false },
	{ 180.55,2793.45,45.65,"Recycle",false },
	{ -195.79,6264.95,31.49,"Recycle",false },
	{ -947.03,-2043.3,9.4,"Policia",false }, -- Departamento Policial DP
	{ -626.21,-238.24,38.05,"Miners",false }, -- Loja para vender pedra de mineração
	{ 475.1,3555.28,33.23,"Criminal",false }, -- Loja para vender itens roubados do script de roubar casas
	{ 112.41,3373.68,35.25,"Criminal2",false }, -- Loja para vender itens roubados do script de roubar casas
	{ 2013.95,4990.88,41.21,"Criminal3",false }, -- Loja para vender itens roubados do script de roubar casas
	{ 186.9,6374.75,32.33,"Criminal4",false }, -- Loja para comprar itens para roubar
	{ -653.12,-1502.67,5.22,"Criminal",false }, -- Loja para vender itens roubados do script de roubar casas
	{ 389.71,-942.61,29.42,"Criminal2",false }, -- Loja para vender itens roubados do script de roubar casas
	{ 154.98,-1472.47,29.35,"Criminal3",false }, -- Loja para vender itens roubados do script de roubar casas
	{ 488.1,-1456.11,29.28,"Criminal4",false }, -- Loja para comprar itens para roubar
	{ 871.55,-2123.39,30.46,"Mechanic",false },
	{ 913.97,-2127.28,30.46,"Mechanic",false },
	{ -1228.76,-922.4,2.14,"BurgerShot",false }, -- Loja de comidas (geralmente usado em casas)
	{ 78.16,-1389.44,29.37,"Clothes",false },
	{ -709.68,-153.25,37.41,"Clothes",false },
	{ -163.34,-302.74,39.73,"Clothes",false },
	{ -1193.34,-768.19,17.32,"Clothes",false },
	{ -1450.47,-237.66,49.81,"Clothes",false },
	{ -1208.59,-1508.3,4.36,"Bebidas",false }, -- Bebidas para festas(adicionar efeitos nas bebidas)
	{ -1272.13,-1417.05,4.36,"Bebidas",false }, -- Bebidas para festas(adicionar efeitos nas bebidas)
	{ 456.9,5571.7,781.17,"Paraguedas",false },
	-- { 748.15,6450.85,32.08,"Farmer3",false }, -- Loja de vender itens do emprego de farmer
	-- { -544.07,-197.6,38.22,"Identity",false },
	-- { -550.76,-201.96,38.22,"Identity",false },
	-- { -530.87,-180.1,43.35,"Lawyer",false }, -- Verificar essa loja em algum momento
	-- { 169.76,-1535.88,29.25,"Weapons",false }, -- Loja de comprar peças de armas(deixar desativado)
	-- { 301.14,-195.75,61.57,"Weapons",false }, -- Loja de comprar peças de armas(deixar desativado)
	{ 84.24,-1908.36,21.13,"Laundry",false },	-- Loja das facs de lavagem(Algemas, Credencial para corridas e Energetico)
	{ -140.63,-1647.58,32.6,"Dismantle",false }, -- Loja das facs de Desmanche (lock pick, c4, contrato de desmanche de veiculo, capuz, alicate, cartão in-comum, pendrive)
	{ -413.36,1594.61,362.51,"Ammoshop",false }, -- Loja das facs de munição (Colete)
	{ -1210.14,-1464.29,4.36,"Weeds",false }, -- Loja de seda(testar para que serve seda)
	{ -1618.19,-1050.87,13.13,"Premium",false }, -- Loja de comprar itens com diamantes
}

local CityConfig = {
    ["Base"] = function()
        -- Shops[#Shops+1] = { x,y,z,"Name",false }
    end,
}

CreateThread(function()
    if CityConfig[cityName] then
        CityConfig[cityName]()
    end

    local Table = {}

    for _,v in pairs(Shops) do
        table.insert(Table,{ v[1],v[2],v[3],1.25,"E","Loja","Pressione para abrir" })
    end

    TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetShops",function()
    return Shops
end)
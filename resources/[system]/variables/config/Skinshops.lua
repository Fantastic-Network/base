local cityName = GetConvar("cityName","Base")

local Locations = {
	{ 73.73,-1398.9,29.37 },
	{ -708.67,-160.43,37.41 },
	{ -158.46,-297.01,39.73 },
	{ -829.14,-1074.72,11.32 },
	{ -1193.88,-772.99,17.32 },
	{ -1456.93,-240.92,49.81 },
	{ 10.7,6515.02,31.88 },
	{ 1695.37,4829.17,42.06 },
	{ 123.5,-220.44,54.56 },
	{ 617.83,2759.99,42.09 },
	{ 1190.66,2712.33,38.22 },
	{ -3172.58,1047.47,20.86 },
	{ -1107.45,2708.13,19.11 },
	{ 427.56,-800.13,29.49 },
	{ 882.57,-2101.71,30.46 }, -- Mecanica
	{ 1150.44,-1583.39,35.28 }, -- Hospital
	{ 1150.38,-1589.18,35.28 }, -- Hospital
	{ -950.72,-2043.38,9.4 }, -- Departamento Policial DP
}

local CityConfig = {
    ["Base"] = function()
		-- Locations[#Locations+1] = { x,y,z }
    end,
}

CreateThread(function()
	if CityConfig[cityName] then
        CityConfig[cityName]()
    end

    local Table = {}

    for _,v in pairs(Locations) do
		table.insert(Table,{ v[1],v[2],v[3],1,"E","Loja de Roupas","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetSkinShops",function()
    return Locations
end)
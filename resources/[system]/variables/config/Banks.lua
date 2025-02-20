local Locations = {
	{ 314.33,-279.13,54.17 },
	{ -2962.57,482.93,15.7 },
	{ 1174.92,2706.85,38.1 },
	{ -1212.59,-330.68,37.78 },
	{ -350.78,-49.96,49.03 },
	{ 150.04,-1040.8,29.37 },
	{ 237.3,217.96,106.29 },
	{ -112.04,6469.27,31.63 },
	{ 872.3,-2109.38,30.46 }, -- Mecanica
	{ 1152.43,-1534.99,35.38 }, -- Hospital
}

CreateThread(function()
    local Table = {}

    for _,v in pairs(Locations) do
        table.insert(Table,{ v[1],v[2],v[3],1.25,"E","Banco","Pressione para abrir" })
    end

    TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetBanks",function()
    return Locations
end)
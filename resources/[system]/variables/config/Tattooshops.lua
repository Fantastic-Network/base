local cityName = GetConvar("cityName","Base")

local Locations = {
	{ 1322.93,-1652.29,52.27 },
	{ -1154.42,-1425.9,4.95 },
	{ 322.84,180.16,103.58 },
	{ -3169.62,1075.8,20.83 },
	{ 1864.07,3747.9,33.03 },
	{ -293.57,6199.85,31.48 },
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
		table.insert(Table,{ v[1],v[2],v[3],1,"E","Loja de Tatuagem","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetTattooShops",function()
    return Locations
end)
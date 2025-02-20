local cityName = GetConvar("cityName","Base")

local Locations = {
	-- { 330.19,-601.21,43.29,343.65,-581.77,28.8 },
	-- { 343.65,-581.77,28.8,330.19,-601.21,43.29 },
}

local CityConfig = {
    ["Base"] = function()
        -- Locations[#Locations+1] = { x1,y1,z1,x2,y2,z2 }
    end,
}

CreateThread(function()
	if CityConfig[cityName] then
        CityConfig[cityName]()
    end

	local Table = {}

	for _,v in pairs(Locations) do
		table.insert(Table,{ v[1],v[2],v[3],1,"E","Porta de Acesso","Pressione para acessar" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetTeleports",function()
	return Locations
end)
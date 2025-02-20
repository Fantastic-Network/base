local cityName = GetConvar("cityName","Base")

local Parents = {
	["Fathers"] = { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,42,43,44 },
	["Mothers"] = { 21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,45 },
}

local Locations = {
	{ -814.58,-184.03,37.56 },
	{ 137.37,-1707.46,29.28 },
	{ -1282.76,-1117.38,6.99 },
	{ 1932.06,3730.46,32.84 },
	{ 1212.31,-473.01,66.2 },
	{ -33.13,-152.38,57.07 },
	{ -278.47,6227.91,31.69 },
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
		table.insert(Table,{ v[1],v[2],v[3],1,"E","Barbearia","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetBarberShops",function()
    return Locations
end)

exports("GetParents",function(ParentType)
	return Parents[ParentType]
end)
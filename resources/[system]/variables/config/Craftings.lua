local cityName = GetConvar("cityName","Base")

local Locations = {
	-- { vec3(x,y,z),"Nome" },
}

local CityConfig = {
    ["Base"] = function()
        -- Locations[#Locations+1] = { vec3(x,y,z),"Nome" }
    end,
}

CreateThread(function()
    if CityConfig[cityName] then
        CityConfig[cityName]()
    end

    local Table = {}

    for _,v in pairs(Locations) do
        table.insert(Table,{ v[1]["x"],v[1]["y"],v[1]["z"],1.25,"E","Crafting","Pressione para abrir" })
    end

	TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetCrafting",function()
    return Locations
end)
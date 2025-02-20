local cityName = GetConvar("cityName","Base")

local Locations = {
	["Mechanic01"] = {
		pos = vec3(888.02,-2102.03,29.45),
		heading = 172.92,
		permission = "Mechanic"
	},
	["Mechanic02"] = {
		pos = vec3(895.86,-2102.62,29.45),
		heading = 172.92,
		permission = "Mechanic"
	},
	["Mechanic03"] = {
		pos = vec3(875.85,-2124.93,29.55),
		heading = 357.17,
		permission = "Mechanic"
	},
	["Mechanic04"] = {
		pos = vec3(887.19,-2125.88,29.55),
		heading = 357.17,
		permission = "Mechanic"
	},
	["Mechanic05"] = {
		pos = vec3(897.9,-2126.84,29.55),
		heading = 357.17,
		permission = "Mechanic"
	},
	["Mechanic06"] = {
		pos = vec3(909.21,-2127.94,29.55),
		heading = 357.17,
		permission = "Mechanic"
	}
}

local CityConfig = {
    ["Base"] = function()
        -- Locations["Mechanic100"] = { pos = vec3(909.1,-930.27,59.09), heading = 14.18, permission = "Mechanic"}
    end,
}

CreateThread(function()
	if CityConfig[cityName] then
        CityConfig[cityName]()
    end

    local Table = {}

	for _,v in pairs(Locations) do
		table.insert(Table,{ v["pos"][1],v["pos"][2],v["pos"][3],1,"E","Mecânica","Pressione para abrir" })
	end

	TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetMechanics",function()
    return Locations
end)
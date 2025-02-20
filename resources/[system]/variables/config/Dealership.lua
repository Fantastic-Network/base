local StaticVehicles = {
    {
        ["Coords"] = vec3(-2314.76,3435.82,30.94),-- Zancudo
        ["Heading"] = 85.04,
        ["Model"] = "dilettante2",
        ["Distance"] = 100,
    },
    {
        ["Coords"] = vec3(-2308.51,3391.24,30.33), -- Zancudo
        ["Heading"] = 141.74,
        ["Model"] = "policeb",
        ["Distance"] = 100,
    },
    {
        ["Coords"] = vec3(1042.21,-724.37,56.82), -- Parque das Criancas
        ["Heading"] = 184.26,
        ["Model"] = "pranger",
        ["Distance"] = 100,
        ["Siren"] = true,
    },
    {
        ["Coords"] = vec3(-464.21,6455.27,2.38), -- Paleto
        ["Heading"] = 36.86,
        ["Model"] = "lguard",
        ["Distance"] = 100,
    },
    {
        ["Coords"] = vec3(-938.03,-2115.99,9.08), -- DP
        ["Heading"] = 133.23,
        ["Model"] = "policeb",
        ["Distance"] = 100,
        ["Siren"] = false,
    },
    -- {
    --     ["Coords"] = vec3(),
    --     ["Heading"] = ,
    --     ["Model"] = "",
    --     ["Distance"] = 100,
    --     ["Rotate"] = true,
    --     ["Color"] = {255, 0, 150}
    -- },
}

local CityConfig = {
    ["Base"] = function()
        --[[ StaticVehicles[#StaticVehicles+1] = {
            ["Coords"] = vec3(x,y,z),
            ["Heading"] = h,
            ["Model"] = "",
            ["Distance"] = 100,
        } ]]
    end,
}

CreateThread(function()
	if CityConfig[cityName] then
        CityConfig[cityName]()
    end
end)

exports("GetStaticVehicles",function()
    return StaticVehicles
end)
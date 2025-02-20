local cityName = GetConvar("cityName","Base")

local AnimSpawn = {
    { ["Dict"] = "random@street_race", ["Name"] = "_car_b_lookout" },
    { ["Dict"] = "mini@triathlon", ["Name"] = "idle_e" },
    { ["Dict"] = "friends@fra@ig_1", ["Name"] = "over_here_idle_a" },
    { ["Dict"] = "missmic4premiere", ["Name"] = "prem_4stars_a_benton" }
}

local SelectionSpawn = {
    ["Player"] = vector4(-1848.29,-1229.48,13.01,141.74),
    ["Peds"] = vector4(-1850.18,-1232.01,12.01,325.99),
    ["Camera"] = 140.0
}

local NewbieSpawn = {
    vec3(-1850.9,-1232.46,13.01),
    -- vec3(1418.59,6684.56,14.47)
}

local LocationSpawn = {}

local CityConfig = {
    ["Base"] = function()
        --SelectionSpawn["Player"] = vector4(560.01,-436.53,-69.66,337.33)
        --SelectionSpawn["Peds"] = vector4(559.06,-438.6,-70.66,331.66)
        LocationSpawn = {
            { ["Coords"] = vec3(-1636.93,-984.85,13.01), ["name"] = "Pier" },
            { ["Coords"] = vec3(-151.54,6356.13,31.49), ["name"] = "Paleto" },
            { ["Coords"] = vec3(-965.84,-2122.43,9.4), ["name"] = "DP" },
            { ["Coords"] = vec3(-2314.8,3404.87,30.87), ["name"] = "Zancudo" },
            { ["Coords"] = vec3(1139.41,-1482.89,34.85), ["name"] = "Hospital" }
        }
    end,
}

CreateThread(function()
	if CityConfig[cityName] then
        CityConfig[cityName]()
    end
end)

exports("GetAnimSpawn",function()
    local Random = math.random(#AnimSpawn)
    return AnimSpawn[Random]
end)

exports("GetSelectionSpawn",function()
    return SelectionSpawn
end)

exports("GetNewbieSpawn",function()
    return NewbieSpawn
end)

exports("GetLocationSpawn",function()
    return LocationSpawn
end)
local cityName = GetConvar("cityName","Base")

local Locations = {
    { -921.66,-2029.97,9.4,"Policia" },
    { 1139.93,-1536.9,35.38,"Paramedic" },
    { 875.49,-2101.75,30.46,"Mechanic" }
}

local CityConfig = {
    ["Base"] = function()
        -- Locations[#Locations+1] = { x,y,z,"Group" }
    end,
}

CreateThread(function()
    if CityConfig[cityName] then
        CityConfig[cityName]()
    end

    local Table = {}

    for _,v in pairs(Locations) do
        table.insert(Table,{ v[1],v[2],v[3],1.25,"E","Trabalhar","Pressione para entrar/sair" })
    end

    TriggerEvent("hoverfy:Insert",Table)
end)

exports("GetServices",function()
    return Locations
end)
local cityName = GetConvar("cityName","Base")

local Fathers = exports["variables"]:GetParents("Fathers")
local Mothers = exports["variables"]:GetParents("Mothers")

local Peds = {
    {
        Distance = 100,
        Coords = { -1588.48,2793.41,16.92,221.11 }, -- Forte Zancudo
        Model = "s_m_m_armoured_01",
        Anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" } -- Braços Cruzados
    },
    {
        Distance = 100,
        Coords = { -2306.26,3391.32,30.99,51.03 }, -- Forte Zancudo
        Model = "s_m_m_armoured_02",
        Anim = { "amb@code_human_wander_idles_cop@female@static","static" } -- Mãos na cintura aberto
    },
    {
        Distance = 100,
        Coords = { -2313.4,3439.11,31.58,93.55 }, -- Forte Zancudo
        Model = "s_m_m_armoured_01",
        Anim = { "anim@heists@prison_heiststation@cop_reactions","cop_a_idle" } -- Mãos na cintura Fechado
    },
    {
        Distance = 100,
        Coords = { -939.2,-2114.28,9.77,127.56 }, -- Departamento policial DP
        Model = "s_m_m_armoured_01",
        Anim = { "anim@heists@prison_heiststation@cop_reactions","cop_a_idle" } -- Mãos na cintura Fechado
    },
    {
        Distance = 100,
        Coords = { 1044.02,-724.97,57.2,184.26 }, -- Parque das crianças
        Model = "s_m_m_armoured_01",
        Anim = { "amb@code_human_wander_idles_cop@female@static","static" } -- Mãos na cintura aberto
    },
    {
        Distance = 100,
        Coords = { 1064.91,-722.65,56.77,133.23 }, -- Parque das crianças
        Model = "s_m_m_armoured_02",
        Anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" } -- Braços Cruzados
    }
}

local CityConfig = {
    ["Base"] = function()
        --[[ Peds[#Peds+1] = {
            Distance = 100,
            Coords = { x,y,z }, -- Forte Zancudo
            Model = "",
            Anim = { "","" } -- Braços Cruzados
        } ]]
    end
}

CreateThread(function()
    if CityConfig[cityName] then
        CityConfig[cityName]()
    end
end)

exports("GetPeds",function()
    return Peds
end)
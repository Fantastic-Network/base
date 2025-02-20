-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cityName = GetConvar("cityName","Base")
local Cooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Services",function()
    if LocalPlayer["state"]["Route"] < 900000 and GetGameTimer() >= Cooldown then
        Cooldown = GetGameTimer() + 10000

        local Ped = PlayerPedId()
        if not IsPedInAnyVehicle(Ped) then
            local Coords = GetEntityCoords(Ped)
            local Services = exports["variables"]:GetServices()
            for _,v in pairs(Services) do
                local Distance = #(Coords - vec3(v[1],v[2],v[3]))
                if Distance <= 1.25 then
                    vSERVER.ToggleService(v[4])

                    break
                end
            end
        end
    end
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)
local RenderDistance = 1.0
local Switch = {
    [1] = false,
    [2] = false
}

local Test = {
    "t_carshowroom",
    "int_dockcontrol_small",
    "MichaelsDirectional",
    "MP_Garage_L",
    "NEW_station_unfinished",
    "Prologue_shootout_opt",
    "refit",
    "v_recycle",
    "NEW_tunnels",
    "New_sewers",
    "new_MP_Garage_L",
}

RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
    elseif args[1] == "off" then
        ClearTimecycleModifier()
    else
        SendNUIMessage({ Action = "message", action = "OPEN_MENU", data = {
            switch1Title = "BOOST 1",
            switch2Title = "BOOST 2",
            range = (1.0 - RenderDistance) * 100,
            switch1 = Switch[1],
            switch2 = Switch[2],
        }})
        SetNuiFocus(true, true)
    end
end)

RegisterNuiCallback("success",function(data)
    local range = tonumber(data.data.range) / 100
    range = 1.0 - range
    RenderDistance = range
    SetNuiFocus(false, false)
    Switch[1] = data.data.switch1
    Switch[2] = data.data.switch2
    if data.data.switch1 then
        SetTimecycleModifier("NEW_tunnels")
    else
        ClearTimecycleModifier()
    end
    local Data = {
        Switch = Switch,
        RenderDistance = RenderDistance,
    }
    SetResourceKvp("FPSConfig",json.encode(Data))
end)

RegisterNuiCallback("failure",function(data)
    SetNuiFocus(false, false)
end)

CreateThread(function()
    local Data = GetResourceKvpString("FPSConfig")
    if Data then
        Data = json.decode(Data)
        if Data.RenderDistance then
            Switch = Data.Switch
            RenderDistance = Data.RenderDistance
            if Switch[1] then
                SetTimecycleModifier("NEW_tunnels")
            end
        end
    end
    while true do
        OverrideLodscaleThisFrame(RenderDistance)
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        if Switch[2] then
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            ClearPedBloodDamage(PlayerPedId())
            ClearPedWetness(PlayerPedId())
            ClearPedEnvDirt(PlayerPedId())
            ResetPedVisibleDamage(PlayerPedId())
            ClearExtraTimecycleModifier()
            ClearOverrideWeather()
            ClearHdArea()
            DisableVehicleDistantlights(false)
            DisableScreenblurFade()
            SetRainLevel(0.0)
            SetWindSpeed(0.0)
        end
        Wait(1500)
    end
end)

CreateThread(function()
    while true do
        local Idle = 2500
        if Switch[2] then
            Idle = 0
            local Ped = PlayerPedId()
            DisableOcclusionThisFrame()
            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(Ped), 10.0)
            SetArtificialLightsState(true)
        end
        Wait(Idle)
    end
end)
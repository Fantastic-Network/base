local Flares = {}
local Blips = {}
local _Blips = {}
local _Flares = {}
local Opening = false

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

RegisterNetEvent("Airdrop:Blip",function(Id)
    SetBlipColour(Blips[Id],1)
end)

RegisterNetEvent("Airdrop:Particle",function(Dict,ParticleName,Coords,Id)
    local Blip = AddBlipForCoord(Coords["x"],Coords["y"],Coords["z"] )
    RequestNamedPtfxAsset(Blip)
    SetBlipSprite(Blip,94)
    SetBlipAsShortRange(Blip,true)
    SetBlipColour(Blip,28)
    SetBlipScale(Blip,1.5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("~o~EVENTO~w~ Airdrop")
    EndTextCommandSetBlipName(Blip)
    while not HasNamedPtfxAssetLoaded(Dict) do
        Wait(0)
    end
    Blips[Id] = Blip
    table.insert(_Blips,Blip)
    UseParticleFxAssetNextCall(Dict)

    local Flare = StartParticleFxLoopedAtCoord(ParticleName, Coords["x"],Coords["y"],Coords["z"] -0.99, 0.0, 0.0, 0.0, 2.3, false, false, false)
    Flares[Id] = Flare
    table.insert(_Flares,Flare)
end)

RegisterNetEvent("Airdrop:Ground",function(Id)
    if not Flares[Id] then 
        return 
    end
    StopParticleFxLooped(Flares[Id],false)
    Flares[Id] = nil
end)

RegisterNetEvent("Airdrop:Opening",function(AirDrop)
    Opening = AirDrop
end)

RegisterNetEvent("Airdrop:Finish",function(AirDrop)
    Opening = false
    TriggerEvent("Notify:Text","")
end)

RegisterNetEvent("Airdrop:Remove",function(Id)
    if DoesBlipExist(Blips[Id]) then
        RemoveBlip(Blips[Id])
        Blips[Id] = nil
    end
end)

RegisterNetEvent("Airdrop:Clean",function()
    for _,Id in pairs(Blips) do
        if DoesBlipExist(Blips[Id]) then
            RemoveBlip(Blips[Id])
            Blips[Id] = nil
        end
        Blips[Id] = nil
    end
    for Id,_ in pairs(_Blips) do
        if DoesBlipExist(_Blips[Id]) then
            RemoveBlip(_Blips[Id])
            _Blips[Id] = nil
        end
    end
    for Id,_ in pairs(_Flares) do
        StopParticleFxLooped(_Flares[Id],false)
        _Flares[Id] = nil
    end
    for _,Id in pairs(Flares) do
        StopParticleFxLooped(Flares[Id],false)
        Flares[Id] = nil
    end
end)

AddEventHandler("actions:Cancel",function()
    if Opening then
        TriggerServerEvent("Airdrop:Cancel",Opening)
        TriggerEvent("Notify:Text","")
        Opening = false
    end
end)
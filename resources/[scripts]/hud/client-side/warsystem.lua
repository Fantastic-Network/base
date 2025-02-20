RegisterNetEvent("hud:WarSystem")
AddEventHandler("hud:WarSystem",function(Table)
    -- print("hud:WarSystem")
    SendNUIMessage({ Action = "UpdateGangWarMode", Attacker = Table["Attacker"], Defense = Table["Defense"] })
end)

RegisterNetEvent("hud:PublicWarSystem")
AddEventHandler("hud:PublicWarSystem",function(Table)
    if LocalPlayer["state"]["inWar"] then
        return
    end
    SendNUIMessage({ Action = "UpdateGangWarMode", Attacker = Table["Attacker"], Defense = Table["Defense"] })
    Wait(10000)
    SendNUIMessage({ Action = "HideGangWarMode" })
end)

RegisterNetEvent("hud:HideWarSystem")
AddEventHandler("hud:HideWarSystem",function()
    SendNUIMessage({ Action = "HideGangWarMode" })
end)


local RiskZones = {
    -- ["Test"] = PolyZone:Create({
    --     vector2(-1459.85, -711.36),
    --     vector2(-1346.21, -806.06),
    --     vector2(-1825.76, -1359.09),
    --     vector2(-2110.61, -1150.00),
    --     vector2(-1537.88, -656.06)
    -- }, {
    --     name="Pier",
    -- }),
}
local RiskZonesBlips = {}

-- cityName = GetConvar("cityName", "Base")

-- if cityName == "Test" then
--     RiskZones["BancoCentral"] = CircleZone:Create(vector2(201.55,195.35), 220.00, {
--         name="BancoCentral",
--     })
--     table.insert(RiskZonesBlips,vector4(201.55,195.35,0.0,220.00))

--     RiskZones["CemiterioAvioes"] = CircleZone:Create(vector2(1971.17,3036.59), 300.00, {name="CemiterioAvioes",debugPoly=true,debugColor = {255,0,0},minZ=30,maxZ=40})
--     table.insert(RiskZonesBlips,vector4(1971.17,3036.59,0.0,300.00))

--     RiskZones["Rodovia"] = CircleZone:Create(vector2(1918.03,2453.74), 300.00, {       
--         name="Rodovia",
--     })
--     table.insert(RiskZonesBlips,vector4(1918.03,2453.74,54.66,300.00))

--     RiskZones["Zancudo"] = CircleZone:Create(vector2(-1287.0,2525.61), 500.54, {name="Zancudo",debugPoly=true,debugColor = {255,0,0},minZ=20,maxZ=100})
--     table.insert(RiskZonesBlips,vector4(-1287.0,2525.61,0.0,500.00))
    
--     RiskZones["Vagos"] = CircleZone:Create(vector2(404.42,-1954.53), 200.00, {name="Vagos",debugPoly=true,debugColor = {255,0,0},minZ=20,maxZ=100})
--     table.insert(RiskZonesBlips,vector4(404.42,-1954.53,0.0,200.00))

--     RiskZones["PertoVanilla"] = CircleZone:Create(vector2(64.61,-1546.15), 110.00, {     
--         name="PertoVanilla",
--        })
--     table.insert(RiskZonesBlips,vector4(64.61,-1546.15,0.0,110.00))
-- end


-- 826.41,-1751.56

CreateThread(function()
    for i=1,#RiskZonesBlips do
        local Blip = AddBlipForRadius(RiskZonesBlips[i]["x"],RiskZonesBlips[i]["y"],RiskZonesBlips[i]["z"],RiskZonesBlips[i]["w"])
        SetBlipColour(Blip, 1)
        SetBlipAlpha(Blip, 125)
        SetBlipAsShortRange(Blip, true)
    end
    while true do
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        local Inside = false
        for Name,Zone in pairs(RiskZones) do
            if Zone:isPointInside(Coords) then
                Inside = true
            end
        end
        if Inside then
            SendNUIMessage({ Action = "ZoneRisk", Risk = true })
        else
            SendNUIMessage({ Action = "ZoneRisk", Area = false })
        end
        Wait(1000)
    end
end)

local Radius = 1400.00
local RoyaleStarted = false
-- local circleZone = CircleZone:Create(vector2(5263.68,-5418.46), DeafaultRadius, {
--     name="Zancudo",
--     debugPoly=true,
--     debugColor = {0,0,255}
--    })

-- CreateThread(function()
--     while true do
--         Radius = Radius - 0.01*2
--         circleZone:setRadius(Radius)
--         Wait(1)
--     end
-- end)


RegisterNetEvent("royale:StartDomClient")
AddEventHandler("royale:StartDomClient",function(Circle,Radius)
    local Ped = PlayerPedId()
    RoyaleStarted = true
    circleZone = CircleZone:Create(Circle, Radius, {
        name="Cayo Perico",
        debugPoly=true,
        debugColor = {0,0,255}
    })

    TriggerEvent("hoverfy:removeHoverfy")
    TriggerEvent("domination:StartNui",Table)
    FreezeEntityPosition(Ped,true)
    LocalPlayer["state"]["Invincible"] = true
    SetEntityInvincible(ped,true)

    Wait(11000)

    SetEntityInvincible(ped,false)
    LocalPlayer["state"]["Invincible"] = false
    FreezeEntityPosition(Ped,false)


    SetRunSprintMultiplierForPlayer(PlayerId(),1.15)
    InsideDomination()
end)


function InsideRoyale()
    local Ped = PlayerPedId()
    while RoyaleStarted do
        local Coords = GetEntityCoords(Ped)
        if not circleZone:isPointInside(Coords) then
            local Health = GetEntityHealth(Ped)
            SetEntityHealth(Ped, Health - 1)
        end
        Wait(1000)
    end
end
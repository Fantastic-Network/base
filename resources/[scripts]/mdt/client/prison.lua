local IsPrisoner =  false
local NextJob = 1
local inJob = false
local Prison = PolyZone:Create({
    vector2(1654.55, 2379.55),
    vector2(1761.36, 2397.73),
    vector2(1825.76, 2465.15),
    vector2(1818.18, 2584.09),
    vector2(1825.00, 2611.36),
    vector2(1850.76, 2687.12),
    vector2(1771.97, 2766.67),
    vector2(1638.64, 2759.09),
    vector2(1554.55, 2676.52),
    vector2(1520.45, 2578.79),
    vector2(1530.30, 2456.06)
}, {
    name="Prison",
    minZ=30,
    maxZ=99
})
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATEBAGHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------

CreateThread(function()
    while true do
        if LocalPlayer["state"]["InPrison"] then
            if not IsPrisoner then
                ExecutePrison()
            end
        end
        Wait(5000)
    end
end)

function ExecutePrison()
    local Ped = PlayerPedId()
    IsPrisoner = true
    SetEntityCoords(Ped, 1688.7,2516.83,46.13)
    CreateThread(function()
        while IsPrisoner do
            local Coords = GetEntityCoords(Ped)
            local Health = GetEntityHealth(Ped)
            if Health <= 100 then
                SetEntityCoords(Ped, 1688.7,2516.83,46.13)
                Wait(2500)
                exports["survival"]:Revive(200)
            end
            if not Prison:isPointInside(Coords) then
                SetEntityCoords(Ped, 1688.7,2516.83,46.13)
            end
            Wait(5)
        end
    end)
    CreateThread(function()
        while IsPrisoner do
            local Coords = GetEntityCoords(Ped)
            local Next = vector3(PrisonJobs["Coords"][NextJob]["x"],PrisonJobs["Coords"][NextJob]["y"],PrisonJobs["Coords"][NextJob]["z"])
            local Distance = #(Coords - Next)
            if Distance <= 50.0 and not inJob then
                DrawText(Next.x,Next.y,Next.z,"PRESSIONE  ~b~E~w~  PARA TRABALHAR")
                if IsControlJustPressed(0,38) and Distance <= 2.5 then
                    inJob = true
                    if vSERVER.ReduceTime() then
                        NextJob = NextJob + 1
                        if NextJob > #PrisonJobs["Coords"] then
                            NextJob = 1
                        end
                        inJob = false
                    else
                        inJob = false
                    end
                end
            end
            Wait(5)
        end
    end)
end
AddStateBagChangeHandler('InPrison',('player:%s'):format(Player), function(_, _, Value)
    local Ped = PlayerPedId()
    if Value then
        ExecutePrison()
    else
        IsPrisoner = false
        Wait(100)
        TriggerEvent("Notify","azul","Você cumpriu sua pena.",5000,"Prisão")
        -- TriggerEvent("Notify2","#servedTime")
        SetEntityCoords(Ped, 1849.35,2586.28,45.66)
    end
end)
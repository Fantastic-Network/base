Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vSERVER = Tunnel.getInterface("safezone")

local Zones = {
}

if cityName == "Base" then
    Zones["Franca"] = PolyZone:Create({
        vector2(1224.62, -304.55),
        vector2(1313.64, -293.56),
        vector2(1213.64, -204.17),
        vector2(1178.41, -242.05),
        vector2(1214.02, -275.76)
    }, {
        name="Franca",
        --debugGrid=true,
    })
    Zones["Luxor-2"] = PolyZone:Create({
        vector2(-362.83770751953, 224.490234375),
        vector2(-364.06307983398, 134.16842651367),
        vector2(-281.35882568359, 135.18298339844),
        vector2(-281.20614624023, 248.96063232422)
    }, {
        name="Luxor",
    })
    Zones["Bloods"] = PolyZone:Create({
        vector2(-2404.55, 413.64),
        vector2(-2301.52, 131.82),
        vector2(-2125.76, 207.58),
        vector2(-2275.76, 475.76)
    }, {
        name="Bloods",
        --debugGrid=true,
    })
    Zones["ALCATEIAHST"] = PolyZone:Create({
        vector2(1897.73, -918.18),
        vector2(1962.12, -910.61),
        vector2(2031.82, -982.58),
        vector2(1949.24, -1087.88),
        vector2(1831.06, -998.48)
    }, {
        name="ALCATEIAHST",
        --debugGrid=true,
    })
    Zones["Brancos"] = PolyZone:Create({
        vector2(1307.58, -682.20),
        vector2(1267.80, -753.03),
        vector2(1381.06, -789.77),
        vector2(1424.62, -718.56)
    }, {
        name="Brancos",
        --debugGrid=true,
    })
    Zones["Groove"] = PolyZone:Create({
        vector2(-214.39, -1471.97),
        vector2(-48.48, -1611.36),
        vector2(-174.24, -1752.27),
        vector2(-321.97, -1641.67)
    }, {
        name="Groove",
        --debugGrid=true,
    })
    Zones["Sindicato"] = PolyZone:Create({
        vector2(2760.61, 2822.73),
        vector2(2915.15, 2653.03),
        vector2(2816.67, 2551.52),
        vector2(2560.61, 2701.52)
    }, {
        name="Sindicato",
        --debugGrid=true,
    })
    Zones["Mercenarios"] = PolyZone:Create({
        vector2(-3036.36, 175.00),
        vector2(-3003.79, 113.64),
        vector2(-2903.03, 44.70),
        vector2(-2931.06, 3.79),
        vector2(-3059.85, 84.85)
    }, {
        name="Mercenarios",
        --debugGrid=true,
    })
end

-- DEBUG --
-- CreateThread(function()
--     Wait(1000)
--     local Ped = PlayerPedId()
--     while true do
--         for zone,ZoneData in pairs(Zones) do
--             if ZoneData:isPointInside(GetEntityCoords(Ped)) then
--                 TriggerEvent("Notify","vermelho","Entrou na zona "..zone)
--                 vSERVER.HasPermission(zone,1)
--             end
--         end
--         Wait(500)
--     end
-- end)


AddEventHandler("gameEventTriggered",function(name,args)
    if name ~= "CEventNetworkEntityDamage" then
        return
    end
    if LocalPlayer["state"]["Route"] ~= 1 then
        return
    end
    local Victim = tonumber(args[1])
    local Attacker = PlayerPedId()
    
    if args[2] ~= Attacker then
        return
    end

    local AttackerInside = false
    local VictimInside = false
    local Zone = nil
    for zone,ZoneData in pairs(Zones) do
        if ZoneData:isPointInside(GetEntityCoords(Victim)) then
            VictimInside = true
            Zone = zone
        end
    end

    if not Zone then
        return
    end

    if not VictimInside then
        return
    end
    
    local VictimDied = GetEntityHealth(Victim) <= 100
    local Weapon = tostring(args[7])
    if VictimDied then
        if IsEntityAPed(Victim) then
            if IsPedAPlayer(Victim) then
                local VictimServerId = GetPlayerServerId((NetworkGetPlayerIndexFromPed(Victim)))
                local HasPermission = vSERVER.HasPermission(Zone,VictimServerId)
                if not HasPermission then
                    KillThisBitch()
                end
            end
        end
    end
end)


function KillThisBitch()
    local player = PlayerPedId()
    local weapon = "WEAPON_PISTOL_MK2"
    RequestWeaponAsset(GetHashKey(weapon)) 
    while not HasWeaponAssetLoaded(GetHashKey(weapon)) do
    	Wait(1)
    end
    local RootPosition = GetPedBoneCoords(player, SKEL_ROOT, 0, 0, 0)
    local HandPosition = GetPedBoneCoords(player, SKEL_R_Hand, 0, 0, 0.2)
    local WeaponHash = GetHashKey(weapon)
    ShootSingleBulletBetweenCoords(
        HandPosition.x,
        HandPosition.y,
        HandPosition.z,
        RootPosition.x,
        RootPosition.y,
        RootPosition.z,
        600,
        0,
        WeaponHash,
        GetPlayerServerId(player),
        false,
        false,
        1
    )
end
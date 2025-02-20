local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vADMIN = Tunnel.getInterface("admin")
vSERVER = Tunnel.getInterface("safezone")
Player = GetPlayerServerId(PlayerId())
cityName = GetConvar("cityName", "Base")
Creative = {}
Tunnel.bindInterface("safezone",Creative)
SafeMode = GetConvar("SafeMode", "")

local safeZoneName = ""
local safeMode = false
local safeZone = {
    ["Pier"] = PolyZone:Create({
        vector2(-1459.85, -711.36),
        vector2(-1346.21, -806.06),
        vector2(-1825.76, -1359.09),
        vector2(-2110.61, -1150.00),
        vector2(-1537.88, -656.06)
    }, {
        name="Pier",
    }),
    ["KidsZone"] = PolyZone:Create({
        vector2(-1293.18, -1535.61),
        vector2(-1225.76, -1514.39),
        vector2(-1287.88, -1400.76),
        vector2(-1344.70, -1440.91)
       }, {
        name="kidszone",
    }),
    ["Escola"] = PolyZone:Create({
        vector2(-1497.73, 225.00),
        vector2(-1568.56, 244.32),
        vector2(-1617.05, 290.91),
        vector2(-1736.36, 240.15),
        vector2(-1805.30, 155.30),
        vector2(-1795.45, 116.67),
        vector2(-1746.21, 97.73),
        vector2(-1646.59, 135.61),
        vector2(-1540.15, 185.61)
    }, {
        name = "Escola",
    }),
    ["Dealership"] = PolyZone:Create({
        vector2(-58.71, -1066.67),
        vector2(-4.55, -1087.50),
        vector2(-20.45, -1131.06),
        vector2(-80.30, -1127.27)
       }, {
        name="dealership",
    }),
    ["Mecanica"] = PolyZone:Create({
        vector2(845.83, -2090.15),
        vector2(844.32, -2131.06),
        vector2(913.26, -2140.91),
        vector2(916.29, -2094.32)
       }, {
        name="mecanica",
    }),
    ["Banneds"] = PolyZone:Create({
        vector2(2711.36, -1246.21),
        vector2(3028.03, -1262.12),
        vector2(2834.85, -1737.88),
        vector2(2592.42, -1537.12)
       }, {
        name="banneds",
    }),
    ["Hospital"] = PolyZone:Create({
        vector2(1096.59, -1454.92),
        vector2(1256.06, -1472.73),
        vector2(1144.32, -1640.91),
        vector2(1097.73, -1578.41)
       }, {
        name="Hospital",
    }),
    ["Norte"] = PolyZone:Create({
        vector2(-140.53, 2769.70),
        vector2(-51.14, 2776.14),
        vector2(-52.27, 2795.83),
        vector2(-133.71, 2824.62)
       }, {
        name="norte",
    }),
    ["Pesca"] = PolyZone:Create({
        vector2(1420.45, 3844.70),
        vector2(1480.30, 3914.02),
        vector2(1579.92, 3776.89),
        vector2(1438.26, 3695.08)
       }, {
        name="PESCA",
    }),
    ["Vanilla"] = PolyZone:Create({
        vector2(70.08, -1276.89),
        vector2(79.92, -1298.86),
        vector2(111.36, -1345.45),
        vector2(150.38, -1373.48),
        vector2(165.53, -1362.88),
        vector2(195.08, -1309.47),
        vector2(203.79, -1276.52),
        vector2(165.53, -1267.80),
        vector2(144.32, -1260.98),
        vector2(115.15, -1273.86)
       }, {
        name="Vanilla",
    }),
    ["Farm"] = PolyZone:Create({
        vector2(1600.38, 6340.91),
        vector2(1389.77, 6390.91),
        vector2(1364.39, 6284.47),
        vector2(1567.42, 6240.15)
       }, {
        name="Farm",
    }),
    ["Fazenda"] = PolyZone:Create({
        vector2(601.52, 6506.06),
        vector2(599.24, 6413.64),
        vector2(794.32, 6410.98),
        vector2(786.74, 6467.80)
       }, {
        name="Fazenda",
    }),
    ["Hack"] = PolyZone:Create({
        vector2(651.14, 110.61),
        vector2(707.20, 89.39),
        vector2(737.12, 139.77),
        vector2(673.11, 166.67)
       }, {
        name="Hack",
    })
}

if cityName == "Base" then
    safeZone["Praca"] = PolyZone:Create({
        vector2(70.45, -1029.55),
        vector2(238.26, -1075.76),
        vector2(327.65, -808.71),
        vector2(162.88, -760.61)
        }, {
        name="Praca",
    })
end

local Buckets = {
    ["Pier"] = 1,
    ["Hospital"] = 1,
}

safeCooldown = GetGameTimer()
safeuser = nil
isInside = false
updateEntity = GetGameTimer()
cooldownInside = GetGameTimer()
safeMode = false
SafeWarmode = false

function insidePoly()
    if LocalPlayer["state"]["Route"] > 1 or LocalPlayer["state"]["PVP"] then
        return
    end
    local ped = PlayerPedId()
    TriggerEvent("Notify","amarelo","Você entrou na zona segura.",5000,"Safezone")
    -- TriggerEvent("Notify2","#enteredSafeZ")
    TriggerEvent("sounds:Private","entersafe",0.07)
    if SafeMode == "true" then
        if GlobalState["WarMode"] and Entity(ped)["state"]["WarMode"] then
            WarModeSafeZone(safeuser)
            SafeWarmode = true
        end
    end
    SetLocalPlayerAsGhost(true)
    SetGhostedEntityAlpha(254)
    vSERVER.setSafeZone(true)
    LocalPlayer["state"]["Invincible"] = true
    InSafeZone()
    -- if Buckets[safeZoneName] then
    --     if IsPedInAnyVehicle(ped) then
    --         local vehicle = GetVehiclePedIsIn(ped)
    --         if GetPedInVehicleSeat(vehicle,-1) == ped then
    --             TriggerServerEvent("Safe:Bucket",Buckets[safeZoneName])
    --         end
    --     else
    --         TriggerServerEvent("Safe:Bucket",Buckets[safeZoneName])
    --     end
    -- end
    while true do
        local coords = GetEntityCoords(ped)
        if safeuser and not safeuser:isPointInside(coords) then
            SetLocalPlayerAsGhost(false)
            DisablePlayerFiring(ped,false)
            SetEntityInvincible(ped,false)
            LocalPlayer["state"]["Invincible"] = false
            TriggerEvent("Notify","vermelho","Você saiu da zona segura.",3000,"Safezone")
            -- TriggerEvent("Notify2","#leaveSafeZ")
            TriggerEvent("sounds:Private","leavesafe",0.07)
            vSERVER.setSafeZone(false)
            safeuser = false
            if safeMode then
                SetLocalPlayerAsGhost(true)
                SetGhostedEntityAlpha(254)
                if not LocalPlayer.state["inSafeMode"] then
                    vSERVER.setSafeMode(true)
                end
            else
                SetLocalPlayerAsGhost(false)
                if LocalPlayer.state["inSafeMode"] then
                    vSERVER.setSafeMode(false)
                end
            end
            if Buckets[safeZoneName] then
                safeZoneName = false
                if LocalPlayer["state"]["Route"] >= 900000 then
                    return
                end
                -- if IsPedInAnyVehicle(ped) then
                --     local vehicle = GetVehiclePedIsIn(ped)
                --     if GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,-1) == 0 then
                --         TriggerServerEvent("Safe:Bucket",1)
                --     end
                -- else
                --     TriggerServerEvent("Safe:Bucket",1)
                -- end
            end
            break
        else
            if LocalPlayer["state"]["Route"] >= 900000 then
                return
            end
            TriggerEvent("inventory:CleanWeapons")
        end
        Wait(750)
    end
end

CreateThread(function()
    if GlobalState["SafeZone"] then
        while true do
            local idle = 2500
            if LocalPlayer["state"]["InSafeZone"] then
                idle = 1000
                local ped = PlayerPedId()
                local Coords = GetEntityCoords(ped)
                for k,v in pairs(safeZone) do
                    isInside = v:isPointInside(Coords)
                    if isInside then
                        -- if k == "Pier" then
                        --     Wait(2500)
                        --     exports["survival"]:Revive(400)
                        --     exports['pma-voice']:resetProximityCheck()
                        -- end
                    end
                end
            end
            Wait(idle)
        end
    end
end)

function InSafeZone()
    local ped = PlayerPedId()
    SetEntityInvincible(ped,true)
    CreateThread(function()
        while safeuser do
            SetCanPedEquipAllWeapons(ped, false)
            DisablePlayerFiring(ped,true)
            DisableControlAction(0,140,true)
            Wait(1)
        end
    end)
end

function inSafeMode()
    local ped = PlayerPedId()
    SetLocalPlayerAsGhost(true)
    SetGhostedEntityAlpha(254)
    LocalPlayer["state"]["Invincible"] = true
    SetEntityInvincible(ped,true)
    CreateThread(function()
        while safeMode do
            local Idle = 1500
            if not safeuser then
                Idle = 1
                SetPedConfigFlag(ped, 186, true)
                DisableControlAction(0,140,true)
                SetCanPedEquipAllWeapons(ped, false)
                DisablePlayerFiring(ped,true)
                SetEntityInvincible(ped,true)
            end
            Wait(Idle)
        end
    end)
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        if LocalPlayer["state"]["Active"] and LocalPlayer["state"]["Route"] <= 900000 then
            for k,v in pairs(safeZone) do
                isInside = v:isPointInside(coords)
                if isInside then
                    safeuser = v
                    safeZoneName = k
                    insidePoly()
                    cooldownInside = GetGameTimer() + 1000*60
                end
            end
        end
        Wait(2000)
    end
end)

local EnterSafing = false
RegisterNetEvent("safezone:updateNewbie")
AddEventHandler("safezone:updateNewbie",function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if safeZone["Pier"]:isPointInside(coords) then
        if GetGameTimer() >= safeCooldown then
            safeCooldown = GetGameTimer() + 5000

            if safeuser then
                if not EnterSafing then
                    if not safeMode then
                        TriggerEvent("Progress","Entrando no modo seguro",30000)
                        EnterSafing = true
                        Wait(30000)

                        EnterSafing = false
                        local ped = PlayerPedId()
                        local coords = GetEntityCoords(ped)
                        if safeZone["Pier"]:isPointInside(coords) then
                            safeMode = true
                            if safeuser then
                                TriggerEvent("Notify","verde","Você entrou no modo segurança.", 3000,"Safezone")
                                -- TriggerEvent("Notify2","#enteredSafeMode")
                            else
                                TriggerEvent("Notify","vermelho","Você saiu da safe o modo segurança foi cancelado.", 3000,"Safezone")
                                -- TriggerEvent("Notify2","#leaveSafeMode")
                            end
                        end
                    else
                        TriggerEvent("Progress","Saindo do modo seguro",30000)
                        EnterSafing = true
                        Wait(30000)

                        EnterSafing = false
                        local ped = PlayerPedId()
                        local coords = GetEntityCoords(ped)
                        if safeZone["Pier"]:isPointInside(coords) then
                            safeMode = false
                            if safeuser then
                                TriggerEvent("Notify","vermelho","Você saiu do modo segurança.",3000,"Safezone")
                                -- TriggerEvent("Notify2","#safeModeOff")
                            else
                                TriggerEvent("Notify","vermelho","Você saiu da safe o modo segurança foi cancelado.",3000,"Safezone")
                                -- TriggerEvent("Notify2","#leaveSafeMode")
                            end
                        end
                    end
                end
            else
                TriggerEvent("Notify","amarelo","Você só pode ativar/desativar em uma zona segura.",3000,"Safezone")
                -- TriggerEvent("Notify2","#onOffSafe")
            end
        end
    else
         TriggerEvent("Notify","amarelo","Vai pro pier.",3000,"Safezone")
        --  TriggerEvent("Notify2","#goPier")
    end
end)

AddStateBagChangeHandler('inSafeMode',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if GlobalState["WarMode"] then
        return
    end
    if not GlobalState["SafeZone"] then
        return
    end
    if not Value then
        LocalPlayer["state"]["Invincible"] = false
        SetEntityInvincible(ped,false)
        safeMode = false
    else
        if LocalPlayer["state"]["Route"] >= 900000 then
            return
        end
        safeMode = true
        inSafeMode()
    end
end)

AddStateBagChangeHandler('PVP',('player:%s'):format(Player) , function(_, _, Value)
    local ped = PlayerPedId()
    if not GlobalState["SafeZone"] then
        return
    end
    if Value then
        SetLocalPlayerAsGhost(false)
        DisablePlayerFiring(ped,false)
        SetEntityInvincible(ped,false)
        LocalPlayer["state"]["Invincible"] = false
        vSERVER.setSafeZone(false)
        safeuser = false
        safeZoneName = false
    end
end)

AddStateBagChangeHandler('Newbie',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if GlobalState["WarMode"] then
        return
    end
    if not GlobalState["SafeZone"] then
        return
    end
    if not Value then
        SetLocalPlayerAsGhost(false)
        DisablePlayerFiring(Ped,false)
        SetEntityInvincible(Ped,false)
        LocalPlayer["state"]["Invincible"] = false
        safeMode = false
    else
        if LocalPlayer["state"]["Route"] >= 900000 then
            return
        end
        safeMode = true
        SetEntityInvincible(Ped,true)
        LocalPlayer["state"]["Invincible"] = true
        inSafeMode()
    end
end)


AddEventHandler("gameEventTriggered",function(name,args)
    local ped = PlayerPedId()
    if name == "CEventNetworkEntityDamage" and args[1] == ped then
        if LocalPlayer["state"]["Route"] >= 900000 then
            return
        end
        if GetEntityHealth(ped) <= 100 then
            local coords = GetEntityCoords(ped)
            for k,v in pairs(safeZone) do
                isInside = v:isPointInside(coords)
                if isInside then
                    --if cooldownInside <= GetGameTimer() then
                    -- if k == "Pier" then
                    --     Wait(2500)
                    --     exports["survival"]:Revive(400)
                    --     exports['pma-voice']:resetProximityCheck()
                    -- end
                end
            end
        end
	end
end)
local createdZone = false
RegisterCommand("testzone",function()
    local Ped = PlayerPedId()
    local Coords = GetEntityCoords(Ped)
    if createdZone then
        createdZone:destroy()
        createdZone = false
    end
    createdZone = CircleZone:Create(vector3(Coords), 424.0, {
        name="circle_zone",
        debugPoly=true,
    })
end)


RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

CreateThread(function()
    Wait(5000)
    if not GlobalState["NoVehicleDamage"] then
        return
    end
    while true do
        SetWeaponDamageModifier(-1553120962, 0.0) 
        Wait(0)
    end
end)

CreateThread(function()
    Wait(5000)
    if not GlobalState["NoFallDamage"] then
        return
    end
	while true do
		Wait(5)
        local Ped = PlayerPedId()
        local Player = PlayerId()
        if IsPedFalling(Ped) then
            SetEntityInvincible(Ped, true)
            SetPlayerInvincible(Player, true)
            SetPedCanRagdoll(Ped, false)
            ClearPedBloodDamage(Ped)
            ResetPedVisibleDamage(Ped)
            ClearPedLastWeaponDamage(Ped)
            SetEntityProofs(Ped, true, true, true, true, true, true, true, true)
            SetEntityOnlyDamagedByPlayer(Ped, false)
            SetEntityCanBeDamaged(Ped, false)
        else
            SetEntityInvincible(Ped, false)
            SetPlayerInvincible(Player, false)
            -- SetPedCanRagdoll(Ped, true)
            ClearPedLastWeaponDamage(Ped)
            SetEntityProofs(Ped, false, false, false, false, false, false, false, false)
            SetEntityOnlyDamagedByPlayer(Ped, false)
            SetEntityCanBeDamaged(Ped, true)
        end 
	end
end)
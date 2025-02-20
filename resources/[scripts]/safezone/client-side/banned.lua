Player = GetPlayerServerId(PlayerId())
cityName = GetConvar("cityName", "Base")

local BannedCoords = vector3(2844.81,-1434.19,12.67)
local UnbanCoords = vector3(1285.69,4321.13,38.3)

local Banned = false
local BannedZone = PolyZone:Create({
    vector2(2820.45, -1281.82),
    vector2(2923.48, -1329.55),
    vector2(2813.64, -1662.12),
    vector2(2682.58, -1604.55)
    }, {
        name="BANNEDS",
})
local BannedClothes = {
    [tostring(GetHashKey("mp_m_freemode_01"))] = {
        ["hat"] = { item = -1, texture = 0 },
        ["pants"] = { item = 56, texture = 6 },
        ["vest"] = { item = 0, texture = 0 },
        ["bracelet"] = { item = -1, texture = 0 },
        ["backpack"] = { item = 0, texture = 0 },
        ["decals"] = { item = 0, texture = 0 },
        ["mask"] = { item = 0, texture = 0 },
        ["shoes"] = { item = 34, texture = 0 },
        ["tshirt"] = { item = 15, texture = 1 },
        ["torso"] = { item = 15, texture = 1 },
        ["accessory"] = { item = 0, texture = 0 },
        ["watch"] = { item = -1, texture = 0 },
        ["arms"] = { item = 15, texture = 0 },
        ["glass"] = { item = 0, texture = 0 },
        ["ear"] = { item = -1, texture = 0 }
    },
    [tostring(GetHashKey("mp_f_freemode_01"))] = {
        ["hat"] = { item = -1, texture = 0 },       
        ["pants"] = { item = 10, texture = 3 },      
        ["vest"] = { item = 0, texture = 0 },       
        ["bracelet"] = { item = -1, texture = 0 },
        ["backpack"] = { item = 0, texture = 0 },   
        ["decals"] = { item = 0, texture = 0 },     
        ["mask"] = { item = 0, texture = 0 },       
        ["shoes"] = { item = 35, texture = 0 },      
        ["tshirt"] = { item = 15, texture = 1 },    
        ["torso"] = { item = 32, texture = 2 },     
        ["accessory"] = { item = 0, texture = 0 },  
        ["watch"] = { item = -1, texture = 0 },
        ["arms"] = { item = 15, texture = 0 },      
        ["glass"] = { item = 0, texture = 0 },
        ["ear"] = { item = -1, texture = 0 }
    }
}

CreateThread(function()
    while not Banned do
        if LocalPlayer["state"]["Banned"] then
            StartBannedFunction(Value)
        end
        Wait(2500)
    end
end)

RegisterNetEvent("temp_banned:Set")
AddEventHandler("temp_banned:Set", function(Value)
    if not Banned then
        if Value then
            StartBannedFunction(Value)
        end
    end
    LocalPlayer["state"]["temporaryBanned"] = true
end)

RegisterNetEvent("temp_banned:Rem")
AddEventHandler("temp_banned:Rem", function(Value)
    Banned = false
    Wait(10)
    teleportBanned(UnbanCoords)
    SetEntityInvincible(Ped,false)
    TriggerEvent("Notify:Text","")
    exports['pma-voice']:resetProximityCheck()
    LocalPlayer["state"]["temporaryBanned"] = false
end)

function StartBannedFunction(Value)
    local Ped = PlayerPedId()
    if type(Value) == "table" then
        TriggerEvent("Notify:Text","[CASTIGO]: "..Value["Reason"].."! <br/>[Por]: "..Value["Name"].."<br/>Use o comando /removeradv para comprar sua remoção de advertência!")
    end
    local Model = tostring(GetEntityModel(Ped))
    if Model and BannedClothes[Model] then
        TriggerEvent("skinshop:Apply",BannedClothes[Model])
    end
    teleportBanned(BannedCoords)
    exports['pma-voice']:overrideProximityCheck(function(player)
        return false
    end)
    if not Banned then
        Banned = true
        CreateThread(function()
            while Banned do
                local Coords = GetEntityCoords(Ped)
                if not BannedZone:isPointInside(Coords) then
                    teleportBanned(BannedCoords)
                    TriggerEvent("Notify","vermelho","Você foi PUNIDO temporariamente, Você não pode deixar a ILHA.",15000,"PUNIÇÃO")
                    -- TriggerEvent("Notify2","#punished")
                end
                SetPedConfigFlag(Ped, 186, true)
                SetEntityInvincible(Ped,true)
                DisableControlAction(0,140,true)
                SetCanPedEquipAllWeapons(Ped, false)
                DisablePlayerFiring(Ped,true)
                TriggerEvent("inventory:CleanWeapons")
                exports['pma-voice']:overrideProximityCheck(function(player)
                    return false
                end)
                if GetEntityHealth(Ped) <= 100 then
                    async(function()
                        Wait(2500)
                        exports["survival"]:Revive(400)
                    end)
                end
                Wait(1)
            end
        end)
    end
    SetEntityInvincible(Ped,false)
end

function teleportBanned(coords)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        ped = GetVehiclePedIsUsing(ped)
    end
    local ground
    local groundFound = false
    local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }
    local x,y,z = table.unpack(coords)
    for i,height in ipairs(groundCheckHeights) do
        SetEntityCoordsNoOffset(ped,x,y,height,1,0,0)
        
        RequestCollisionAtCoord(x,y,z)
        while not HasCollisionLoadedAroundEntity(ped) do
            Wait(1)
        end
        
        Wait(20)
        
        ground,z = GetGroundZFor_3dCoord(x,y,height)
        if ground then
            z = z + 1.0
            groundFound = true
            break;
        end
    end
    
    if not groundFound then
        z = 1200
        GiveDelayedWeaponToPed(ped,0xFBAB5776,1,0)
    end
    
    RequestCollisionAtCoord(x,y,z)
    while not HasCollisionLoadedAroundEntity(ped) do
        Wait(1)
    end
    
    SetEntityCoordsNoOffset(ped,x,y,z,1,0,0)
end
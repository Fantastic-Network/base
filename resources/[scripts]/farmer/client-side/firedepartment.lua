local coords_fires = {                                --# Local dos incêndios
    { 39.36,-1427.17,30.15},
    { 356.81,-1712.56,29.27 },
    { 135.38,-1848.11,29.35 }
}

local StartCoords = {
    vector3(210.84,-1657.01,29.81)
}

local inMission = false

CreateThread(function()
    local Table = {}

    for i=1, #StartCoords do
        Table[i] = {
            StartCoords[i].x,
            StartCoords[i].y,
            StartCoords[i].z,
            5.0,
            "E",
            "Iniciar chamados de incendio",
            "Pressione para iniciar",
        }
    end

    TriggerEvent("hoverfy:Insert",Table)

    while true do 
        local idle = 2500
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        for i=1, #StartCoords do
            if #(Coords - StartCoords[i]) <= 5.0 then
                idle = 5
                if IsControlJustPressed(0,38) then
                    fireMission()
                    inMission = true
                end
            end
        end
        Wait(idle)
    end
    
end)



function fireMission()
    local ped = PlayerPedId()
    local get_fires = coords_fires 
    local rand = 1
    TriggerEvent("Notify","verde", "Missão iniciada, vá até o local marcado no mapa e apague os incêndios.")
    local createdCar = false
    local carro = "firetruk"
    while inMission do
        local timeDistance = 500
        if IsPedInAnyVehicle(ped) then
            local atual_veh = GetPlayersLastVehicle()
            if IsVehicleModel(atual_veh,GetHashKey(carro)) then
                timeDistance = 100
                if get_fires[rand] then
                    local x,y,z = get_fires[rand][1],get_fires[rand][2],get_fires[rand][3]
                    local firecount = 5
                    while firecount > 0 do
                        StartScriptFire(x, y, z - 1.0,24,false)
                        StartScriptFire(x, y + firecount, z - 1.0,24,false)
                        StartScriptFire(x, y - firecount, z - 1.0,24,false)
                        StartScriptFire(x - firecount, y, z - 1.0,24,false)
                        StartScriptFire(x + firecount, y, z - 1.0,24,false)
                        firecount = firecount - 1
                        Wait(100)
                    end
                    criarBlip(x,y,z)
                    Wait(2000)
                    local qntd_fire = GetNumberOfFiresInRange(x,y,z,8)
                    while qntd_fire > 0 do
                        qntd_fire = GetNumberOfFiresInRange(x,y,z,30.0)
                        Wait(1000)
                    end
                    rand = rand + 1
                    if not get_fires[rand] then
                        rand = 1
                    end
                    vSERVER.FireDepartment()
                end
            end
        end
        Wait(timeDistance)
    end
end

function criarBlip(x,y,z)
    if blip then
        RemoveBlip(blip)
        blip = nil
    end
    SetNewWaypoint(x, y)
    blip = AddBlipForCoord(x+0.0001,y+0.0001,z+0.0001)
    SetBlipSprite(blip,1)
    SetBlipColour(blip,3)
    SetBlipScale(blip,0.5)
    SetBlipAsShortRange(blip,false)
    SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Missão")
	EndTextCommandSetBlipName(blip)
end

function cancelMission()
    inMission = false
    if blip then
        RemoveBlip(blip)
        blip = nil
    end
    if alvo_blip then
        RemoveBlip(alvo_blip)
        alvo_blip = nil
    end
end

-- CreateThread(function()
--     fireMission()
-- end)
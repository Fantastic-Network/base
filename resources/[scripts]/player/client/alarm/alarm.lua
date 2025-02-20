local alreadyInside = false
local insideHouse
local house
local hasPerm = {}
local Zones = {}

CreateThread(function()
    for i=1,#Homes do
        local Zone = PolyZone:Create(Homes[i]["Zone"],{})
        Zones[i] = Zone
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local health = GetEntityHealth(ped)
        if health > 101 then
            if not alreadyInside then
                for i=1,#Homes do
                    local v = Zones[i]
                    local k = i
                    if v and v:isPointInside(coords) then
                        insideHouse = v
                        house = k
                        if not hasPerm[k] then
                            local isOwner = vSERVER.notifyOwner(house,"Uma pessoa invadiu sua residência <b>"..house.."</b>.")
                            if not isOwner then
                                TriggerEvent("Notify","negado","Você esta numa propriedade privada saia imediatamente.")
                                -- TriggerEvent("Notify2","#saiaPropriPrivada")
                                alreadyInside = true
                                CreateThread(function()
                                    while true do
                                        local ped = PlayerPedId()
                                        local coords = GetEntityCoords(ped)
                                        local health = GetEntityHealth(ped)
                                        if alreadyInside then
                                            if insideHouse:isPointInside(coords) then
                                                if health > 101 then
                                                    SetEntityHealth(ped,health-25)
                                                    TriggerEvent("Notify","negado","Você esta numa propriedade privada saia imediatamente.")
                                                    -- TriggerEvent("Notify2","#saiaPropriPrivada")
                                                else
                                                    SetEntityHealth(ped,101)
                                                end
                                            end
                                        else
                                            break
                                        end
                                        Wait(5000)
                                    end
                                end)
                            else
                                hasPerm[k] = true
                            end
                        end
                    end
                end
            else
                local coords = GetEntityCoords(ped)
                if insideHouse:isPointInside(coords) then
                    alreadyInside = false
                    insideHouse = nil
                end
            end
        end
        Wait(5000)
    end
end) 

RegisterNetEvent("mansion_alarm:Reset")
AddEventHandler("mansion_alarm:Reset",function()
    alreadyInside = false
    insideHouse = nil
    house = nil
    hasPerm = {}
    Zones = {}
end)
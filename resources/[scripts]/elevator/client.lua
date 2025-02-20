local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPServer = Tunnel.getInterface("vRP")
func = {}
Tunnel.bindInterface("elevator", func)

local cfg = module("elevator", "cfg")


----------------------------------------------------------------------------------------------------------------------------------
-- GLOBAIS 
----------------------------------------------------------------------------------------------------------------------------------
function showNui(nuiName)
    SetNuiFocus(true, true)
    TransitionToBlurred(1000)
    SendNUIMessage({action = "showNui", nuiName = nuiName})
end

RegisterNUICallback(
    "hideNui",
    function(data, cb)
        SetNuiFocus(false)
        TransitionFromBlurred(1000)
        SendNUIMessage({action = "hideNui", nuiName = data.nuiName})
    end
)

-- PEGAR O TAMANHO DA TABLE (ÍNDICES NÃO ORDENADOS) .
function length(array)
    local len = 0
    for i in pairs(array) do
        if array[i] then
            len = len + 1
        end
    end
    return len
end
-----------------------------------------------------------------------------------------------------------------
-- ELEVATOR 
-----------------------------------------------------------------------------------------------------------------
local nearestElevator = {}
local elevatorType = nil

-- ATUALIZA OS ELEVADORES PROXIMOS
CreateThread(
    function()
        while true do
            local playercoords = GetEntityCoords(PlayerPedId())
            for k in pairs(cfg.elevator) do
                for k2 in pairs(cfg.elevator[k].blips) do
                    local distance = #(playercoords - cfg.elevator[k].blips[k2].coords)
                    if distance < 3 then
                        nearestElevator[k .. "-" .. k2] = cfg.elevator[k].blips[k2]
                        elevatorType = k
                    elseif nearestElevator[k .. "-" .. k2] then
                        nearestElevator[k .. "-" .. k2] = nil
                        elevatorType = nil
                    end
                end
            end
            Citizen.Wait(1000)
        end
    end
)

-- THREAD DOS MARKERS E ATIVADORA DA NUI
Citizen.CreateThread(
    function()
        while true do
            local delay = 1000
            if length(nearestElevator) > 0 then
                local playercoords = GetEntityCoords(PlayerPedId())
                for i in pairs(nearestElevator) do
                    if nearestElevator[i] then
                        delay = 4
                        local coords = nearestElevator[i].coords
                        DrawMarker(27,coords.x, coords.y, coords.z-0.95,0,0,0,0.0,0,0,0.5,0.5,0.4,255,255,255,75,0,0,0,1)
                        local distance = #(playercoords - coords)
                        if distance < 2 and IsControlJustPressed(0, 38) then
                            showNui("elevator")
                        end
                    end
                end
            end
            Citizen.Wait(delay)
        end
    end
)

RegisterNUICallback(
    "elevatorListButtons",
    function(data, cb)
        cb({elevatorTable = getElevatorTable(elevatorType)})
    end
)

RegisterNUICallback(
    "elevatorButtonActive",
    function(data, cb)
        for k, v in pairs(cfg.elevator[elevatorType].andares) do
            if v.name == data.index then
                local ped = PlayerPedId()
                DoScreenFadeOut(1000)
                SetTimeout(
                    1400,
                    function()
                        SetEntityCoords(ped, v.coords, 0, 0, 0, 0)
                        SetEntityHeading(ped, v.h)
                        TriggerEvent("sounds:Private","elevator",0.5)
                        DoScreenFadeIn(1000)
                    end
                )
            end
        end
    end
)

function getElevatorTable(type)
    if type then
        return cfg.elevator[type].andares
    end

    return {}
end
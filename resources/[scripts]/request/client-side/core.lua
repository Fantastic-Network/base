-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
Client = {}
Tunnel.bindInterface("request",Client)
Server = Tunnel.getInterface("request")
local Timer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNuiCallback("askResponse",function(data,cb)
    local id = data.request.id
    Server._response(id,data.accepted)
end)

function Client.addRequest(id, message, interval)
    interval = (interval or 30) * 1000
    Timer = GetGameTimer() + interval
    TriggerEvent("hoverfy:removeHoverfy")
    SendNUIMessage({
        action = "addRequest",
        data = {
            id = id,
            message = message,
            interval = interval
        }
    })
    CreateThread(function()
        while Timer > GetGameTimer() do
            Wait(1000)
        end
        TriggerEvent("hoverfy:returnHoverfy")
    end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Y
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Y",function()
    TriggerEvent("race:PressedY")
    SendNUIMessage({ action = "pressedYes" })
    TriggerEvent("hoverfy:returnHoverfy")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- U
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("U",function()
    TriggerEvent("race:PressedU")
    SendNUIMessage({ action = "pressedNo" })
    TriggerEvent("hoverfy:returnHoverfy")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("Y","Aceitar requisições.","keyboard","Y")
RegisterKeyMapping("U","Rejeitar requisições.","keyboard","U")

exports("Request",function(...)
    return Server.wrapper(...)
end)
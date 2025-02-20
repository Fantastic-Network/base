-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRPC = Tunnel.getInterface("vRP")
local vRP = Proxy.getInterface("vRP")

local Client = Tunnel.getInterface("request")
local Tools = module("lib/Tools")
local request_ids = Tools.newIDGenerator()

local Server = {}
Tunnel.bindInterface("request",Server)

local requests = {}

-- RegisterCommand("reee",function(source,Message,History)
--     local rr = vRP.Request(source,"Sarapatel")
--     print(rr)
-- end)

function Server.wrapper(...)
    local source = source
    return vRP.Request(source,...)
end

function Server.response(id, ok)
    local request = requests[id]
    if request and request.source == source then
        request.done = true
        request.callback(not not ok)
        request_ids:free(id)
        requests[id] = nil
    end
end

exports("make",function(source,message, interval)
    interval = tonumber(interval)
    interval = interval or 30
    local r = async()
    local id = request_ids:gen()
    local request = { source = source, callback = r, done = false }
    requests[id] = request

    Client._addRequest(source, id, message, interval)

    SetTimeout((interval * 1000) + 3000, function()
        if not request.done then
            request.callback(false)
            request_ids:free(id)
            requests[id] = nil
        end
    end)
    return r:wait()
end)


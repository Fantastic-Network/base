Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

vPLAYER = Tunnel.getInterface("player")
vGARAGE = Tunnel.getInterface("garages")
vDELIVER = Tunnel.getInterface("deliver")
vCLIENT = Tunnel.getInterface("inventory")
vKEYBOARD = Tunnel.getInterface("keyboard")
vPARAMEDIC = Tunnel.getInterface("paramedic")
SafeMode = GetConvar("SafeMode", "")

Inventory = {}

-- prop_ld_int_safe_01
RegisterCommand("getprop",function(source,Message)
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",3) then
        local Keyboard = vKEYBOARD.keySingle(source,"Digite o nome do item:")
        if Keyboard and Keyboard[1] then
            local Hash = Keyboard[1]
            local application,Coords,heading = vRPC.objectCoords(source,Hash,1.0)
            if application then
                print(Coords,heading)
                TriggerClientEvent("copyToClipboard",source,"vector4("..mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading).."),")
            end
        end
    end
end)
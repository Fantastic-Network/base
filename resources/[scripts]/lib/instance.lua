do
    if (GetCurrentResourceName() == 'lib') then return end
    
    if (GetResourceState('vrp') == 'started') then
        import('vrp', 'lib/Utils')
        Proxy = import('vrp', 'lib/Proxy')
        Tunnel = import('vrp', 'lib/Tunnel')
        
        
        if (SERVER) then
            vRP = Proxy.getInterface('vRP')
            vRPC = Tunnel.getInterface('vRP')
            server = {}
            Tunnel.bindInterface(GetCurrentResourceName(),server)
            client = Tunnel.getInterface(GetCurrentResourceName())
            vKEYBOARD = Tunnel.getInterface("keyboard")
        else
            vRP = Proxy.getInterface('vRP')
            client = {}
            Tunnel.bindInterface(GetCurrentResourceName(),client)
            server = Tunnel.getInterface(GetCurrentResourceName())
        end
    end
end
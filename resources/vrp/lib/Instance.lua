do
	if GetCurrentResourceName() == "vrp" then return end

	if GetResourceState("vrp") == "started" then
		import("vrp","lib/Utils")
		Proxy = import("vrp","lib/Proxy")
		Tunnel = import("vrp","lib/Tunnel")

		if _SERVER then
			vRP = Proxy.getInterface("vRP")
			vRPC = Tunnel.getInterface("vRP")
			Server = {}
			Tunnel.bindInterface(GetCurrentResourceName(),Server)
			Client = Tunnel.getInterface(GetCurrentResourceName())
			vKEYBOARD = Tunnel.getInterface("keyboard")
		else
			vRP = Proxy.getInterface("vRP")
			Client = {}
			Tunnel.bindInterface(GetCurrentResourceName(),Client)
			Server = Tunnel.getInterface(GetCurrentResourceName())
		end
	end
end
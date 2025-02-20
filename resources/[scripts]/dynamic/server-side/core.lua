-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("dynamic",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Experience()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Experiences = {
			["Desmanche"] = vRP.GetExperience(Passport,"Dismantle"),
			["Reboque"] = vRP.GetExperience(Passport,"Tows"),
			["Entregador"] = vRP.GetExperience(Passport,"Delivery"),
			["Lenhador"] = vRP.GetExperience(Passport,"Lumberman")
		}

		return Experiences
	end
end
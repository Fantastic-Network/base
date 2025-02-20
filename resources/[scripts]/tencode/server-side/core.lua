-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("tencode",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local codes = {
	["QRU"] = {
		text = "Confronto",
		blip = 6
	},
	["QTH"] = {
		text = "Localização",
		blip = 38
	},
	["QRV"] = {
		text = "Suspeita",
		blip = 83
	},
	["QRL"] = {
		text = "Abordagem",
		blip = 61
	},
	["QRM"] = {
		text = "Acidente",
		blip = 77
	},
	["QRR"] = {
		text = "",
		blip = 4
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.sendCode(code)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Ped = GetPlayerPed(source)
        if Ped ~= 0 and DoesEntityExist(Ped) then
            local Coords = GetEntityCoords(Ped)
            local Identity = vRP.Identity(Passport)
            local Service = vRP.NumPermission("Policia")
            local Text = ""
            if code == "QRR" then
                Text = Identity["name"].." "..Identity["name2"]
            else
                Text = codes[code]["text"]
            end
            for Passports,Sources in pairs(Service) do
                async(function()
                    vRPC.PlaySound(Sources,"Event_Start_Text","GTAO_FM_Events_Soundset")
                    TriggerClientEvent("NotifyPush",Sources,{ code = code, title = Text, x = Coords["x"], y = Coords["y"], z = Coords["z"], name = Identity["name"].." "..Identity["name2"], time = ". Recebido às "..os.date("%H:%M"), blipColor = codes[code]["blip"] })
                    local Custom = {
                        background = "rgba(255,165,0,.60)",
                    }
                    --TriggerClientEvent("chat:ClientMessage",Sources,code,Identity["name"].." "..Identity["name2"]..". Recebido às "..os.date("%H:%M"),"Codigo",false,Custom)
                end)
            end
        end
	end
end
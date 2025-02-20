-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy = module("lib/Proxy")
Tunnel = module("lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = {}
tvRP = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNER/PROXY
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy.addInterface("vRP",vRP)
Tunnel.bindInterface("vRP",tvRP)
REQUEST = exports["request"]
TASKBAR = Tunnel.getInterface("inventory/taskbar")
SURVIVAL = Tunnel.getInterface("survival")
PLAYER = Tunnel.getInterface("player")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:SERVICE_REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("smartphone:service_request",function(Data)
	local Answered = false
	local Service = vRP.NumPermission(Data["service"]["permission"])

    if not Data["content"] then
        return
    end

	if (Data["service"]["permission"] == "Policia") then
        local uPassport = vRP.Passport(Data["source"])
		for Passport,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("NotifyPolice",Sources, Data["content"])
				TriggerClientEvent("chat:ClientMessage",Sources,uPassport.." | "..Data["name"],Data["content"],"chamado")

				if vRP.Request(Sources,"Chamado: <b>"..Data["content"].."?") then
					if not Answered then
						Answered = true
						TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_RESPONSE",{})
						TriggerClientEvent("smartphone:pusher",Sources,"GPS",{ location = Data["location"] })
					else
						TriggerClientEvent("Notify",Sources,"vermelho","Este chamado ja foi atendido.",5000)
                        -- TriggerClientEvent("Notify2",Source,"#commandAnswered")
					end
				end
			end)
		end
    else
        local uPassport = vRP.Passport(Data["source"])
        for Passport,Sources in pairs(Service) do
            async(function()
                TriggerClientEvent("chat:ClientMessage",Sources,uPassport.." | "..Data["name"],Data["content"],"chamado")
    
                if vRP.Request(Sources,"Chamado: <b>"..Data["content"].."?") then
                    if not Answered then
                        Answered = true
                        TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_RESPONSE",{})
                        TriggerClientEvent("smartphone:pusher",Sources,"GPS",{ location = Data["location"] })
                    else
                        TriggerClientEvent("Notify",Sources,"vermelho","Este chamado ja foi atendido.",5000)
                        -- TriggerClientEvent("Notify2",Source,"#commandAnswered")
                    end
                end
            end)
        end
	end

	SetTimeout(30000,function()
		if not Answered then
			TriggerClientEvent("smartphone:pusher",Data["source"],"SERVICE_REJECT",{})
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Request(...)
	return REQUEST:make(...)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local ReviveCooldown = {}
function vRP.Revive(source,Health,Arena)
    ReviveCooldown[source] = os.time()
    return SURVIVAL.Revive(source,Health,Arena)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
local WMCooldown = 1

if cityName == "Base" then
    WMCooldown = 1
end

function vRP.WarModeCooldown(source)
    if Player(source)["state"]["Policia"] then
        return os.time() - WMCooldown
    end
    if ReviveCooldown[source] then
        return ReviveCooldown[source]
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP.TASK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Task(source,Amount,Speed)
    return TASKBAR.Task(source,Amount,Speed)
end
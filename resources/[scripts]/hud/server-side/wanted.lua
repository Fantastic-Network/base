-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Wanted = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Wanted",function(source,Passport,Seconds)
	if Wanted[Passport] then
		if os.time() > Wanted[Passport] then
			Wanted[Passport] = os.time() + Seconds
		else
			Wanted[Passport] = Wanted[Passport] + Seconds
		end
	else
		Wanted[Passport] = os.time() + Seconds
	end

	TriggerClientEvent("hud:Wanted",source,Wanted[Passport] - os.time())
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Wanted",function(Passport)
	if Wanted[Passport] and Wanted[Passport] > os.time() then
		return true
	end

	return false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	if Wanted[Passport] and Wanted[Passport] > os.time() then
		TriggerClientEvent("hud:Wanted",source,Wanted[Passport] - os.time())
	end
end)
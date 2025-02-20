-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ToggleService(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.ServiceToggle(source,Passport,Service,false)
	end
end
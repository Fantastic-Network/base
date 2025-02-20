-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetPremium(source)
	if Characters[source] then
		vRP.Query("accounts/setPremium",{ license = Characters[source]["license"], premium = os.time() + 2592000 })
		Characters[source]["premium"] = parseInt(os.time() + 2592000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradePremium(source)
	if Characters[source] then
		vRP.Query("accounts/updatePremium",{ license = Characters[source]["license"] })
		Characters[source]["premium"] = Characters[source]["premium"] + 2592000
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPremium(Passport)
    local Return = true
    local source = vRP.Source(Passport)

    if Characters[source] then
        if Characters[source]["premium"] < os.time() then
            Return = false

            if vRP.HasPermission(Passport,"Spotify") then
                vRP.RemovePermission(Passport,"Spotify")
            end
        end
    end

    return Return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.LicensePremium(License)
	local Account = vRP.Account(License)
    local Consult = vRP.Query("characters/Characters",{ license = License })
    if Consult and Consult[1] then
        local Passport = parseInt(Consult[1]["id"])
        local VIPs = vRP.GetGroup(Consult[1]["id"],"VIP")
        local NewVIP = vRP.HasVip(Passport)
        if NewVIP then
            return true
        end 
        if VIPs and (VIPs["Premium"] and VIPs["Premium"][1]) or (VIPs and VIPs["Blacks"]) then
            return true
        end
    end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.LicenseAdmin(License)
	local Account = vRP.Account(License)
    local Consult = vRP.Query("characters/Characters",{ license = License })
    local Admin = false
    if Consult and Consult[1] then
        for k,v in pairs(Consult) do
            vRP.GetUserGroups(tostring(v["id"]))
            if vRP.HasGroup(v["id"],"Admin") then
                Admin = true
            end
        end
    end

	return Admin
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIP PROPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Cupoms = {
    -- ["Base"] = "Cupom",
}

RegisterServerEvent("VIP:PROPS")
AddEventHandler("VIP:PROPS",function()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local URL = vRP.generateFastCheckout(Passport)
        if URL then
            TriggerClientEvent("player:OpenURL",source,URL)
        end
    end
end)
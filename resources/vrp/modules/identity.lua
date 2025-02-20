local Plates = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FALSEIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.FalseIdentity(Passport)
	local Consult = vRP.Query("fidentity/Result",{ id = Passport })
	return Consult[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FULLNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.FullName(Passport)
	local Passport = parseInt(Passport)
	local Identity = vRP.Identity(Passport)
	if Identity then
		return Identity["name"].." "..Identity["name2"]
	else
		return "Indivíduo Indigente"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Identity(Passport)
	local source = vRP.Source(Passport)

	if Characters[source] then
		return Characters[source] or false
	else
		local Consult = vRP.Query("characters/Person",{ Passport })
		return Consult[1] or false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.License(Passport)
	local source = vRP.Source(Passport)

	if Characters[source] then
		return Characters[source]["license"] or false
	else
		local Consult = vRP.Query("characters/Person",{ Passport })
		return Consult[1]["license"] or false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InitPrison(Passport,Amount)
	local Amount = parseInt(Amount)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		vRP.Query("characters/setPrison",{ Passport = Passport, prison = Amount })

		if Characters[source] then
			Characters[source]["prison"] = Amount
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdatePrison(Passport,Amount)
	local Amount = parseInt(Amount)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		vRP.Query("characters/removePrison",{ Passport = Passport, prison = Amount })

		if Characters[source] then
			Characters[source]["prison"] = Characters[source]["prison"] - Amount

			if Characters[source]["prison"] <= 0 then
				Characters[source]["prison"] = 0
				vRP.Teleport(source,1896.15,2604.44,45.75)
				TriggerClientEvent("Notify",source,"verde","Serviços finalizados.",5000)
				-- TriggerClientEvent("Notify2",source,"#finishedService")
			else
				TriggerClientEvent("Notify",source,"azul","Restam <b>"..Characters[source]["prison"].." serviços</b>.",5000)
				-- TriggerClientEvent("Notify2",source,"#serviceRemai",{msg=Characters[source]["prison"]})
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESPENDING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeSpending(Passport,Amount)
	local Amount = parseInt(Amount)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		vRP.Query("characters/UpgradeSpending",{ Passport = Passport, spending = Amount })

		if Characters[source] then
			Characters[source]["spending"] = Characters[source]["spending"] + Amount
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESPENDING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeSpending(Passport,Amount)
	local Amount = parseInt(Amount)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		vRP.Query("characters/DowngradeSpending",{ Passport = Passport, spending = Amount })

		if Characters[source] then
			Characters[source]["spending"] = Characters[source]["spending"] - Amount

			if Characters[source]["spending"] <= 0 then
				Characters[source]["spending"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECARDLIMIT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeCardlimit(Passport,Amount)
	local Amount = parseInt(Amount)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		vRP.Query("characters/UpgradeCardlimit",{ Passport = Passport, cardlimit = Amount })

		if Characters[source] then
			Characters[source]["cardlimit"] = Characters[source]["cardlimit"] + Amount
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADECARDLIMIT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeCardlimit(Passport,Amount)
	local Amount = parseInt(Amount)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		vRP.Query("characters/DowngradeCardlimit",{ Passport = Passport, cardlimit = Amount })

		if Characters[source] then
			Characters[source]["cardlimit"] = Characters[source]["cardlimit"] - Amount

			if Characters[source]["cardlimit"] <= 0 then
				Characters[source]["cardlimit"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeChars(source)
	if Characters[source] then
		vRP.Query("accounts/infosUpdatechars",{ license = Characters[source]["license"] })
		Characters[source]["chars"] = Characters[source]["chars"] + 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserGemstone(License)
	local Informations = vRP.Account(License)
    if Informations then
        return Informations["gems"] or 0
    else
        return 0
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeGemstone(Passport,Amount)
	local Amount = parseInt(Amount)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		local Identity = vRP.Identity(Passport)
		if Identity then
			vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = Amount })

			if Characters[source] then
				TriggerClientEvent("hud:AddGems",source,Amount)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADENAMES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeNames(Passport,Name,Name2)
	local source = vRP.Source(Passport)
	vRP.Query("characters/updateName",{ name = Name, name2 = Name2, Passport = Passport })

	if Characters[source] then
		Characters[source]["name2"] = Name2
		Characters[source]["name"] = Name
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATERELATIONSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateRelationship(Passport,Message)
	local source = vRP.Source(Passport)
	vRP.Query("characters/UpdateRelationship",{ relationship = Message, Passport = Passport })

	if Characters[source] then
		Characters[source]["relationship"] = Message
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradePhone(Passport,Phone)
	local source = vRP.Source(Passport)
	vRP.Query("characters/updatePhone",{ phone = Phone, id = Passport })

	if Characters[source] then
		Characters[source]["phone"] = Phone
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PassportPlate(Plate)
	return Plates[Plate] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetPlate(Plate,Passport)
    if Plate and Passport then
        Plates[Plate] = parseInt(Passport)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPhone(Phone)
	local Consult = vRP.Query("characters/getPhone",{ phone = Phone })
	return Consult[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateString(Format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local Number = ""

	for i = 1,#Format do
		local char = string.sub(Format,i,i)
    	if char == "D" then
    		Number = Number..string.char(zbyte + math.random(0,9))
		elseif char == "L" then
			Number = Number..string.char(abyte + math.random(0,25))
		else
			Number = Number..char
		end
	end

	return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePlate()
	local Plate = ""
	local Passport = false

	repeat
		Plate = vRP.GenerateString("DDLLLDDD")
		Passport = vRP.PassportPlate(Plate)
	until not Passport

	return Plate
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetToken(Token)
    local Query = vRP.Query("accounts/GetToken",{ token = Token })
    if Query and Query[1] then
        return false
    end
    return true
end

local TableRandom = {
    "DLLDLD","LLDDLL","LLLDDD","LDDLDL","DDLLDD"
}
function vRP.GenerateToken(License)
	local Plate = ""
	local Token = false

	repeat
        local Random = math.random(1,#TableRandom)
		GenerateToken = vRP.GenerateString(TableRandom[Random])
		Token = GetToken(GenerateToken)
        Wait(10)
	until Token
	vRP.Query("accounts/GenerateToken",{ license = License, token = GenerateToken })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePhone()
	local Phone = ""
	local Passport = false

	repeat
		Phone = vRP.GenerateString("DDD-DDD")
		Passport = vRP.UserPhone(Phone)
	until not Passport

	return Phone
end
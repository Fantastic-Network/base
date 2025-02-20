-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEBANK
-----------------------------------------------------------------------------------------------------------------------------------------
local BankAchievements = {
    [1000000] = 3,
    [100000000] = 4,
    [1000000000] = 5,
}

GlobalState["EconomyTax"] = 2.0
GlobalState["EconomyMoney"] = 1.0
GlobalState["EconomyWeapon"] = 1.0
GlobalState["EconomyDrugs"] = 1.0

local CityEconomy = {
    ["Base"] = function()
        GlobalState["EconomyTax"] = 2.0
        GlobalState["EconomyMoney"] = 1.0
        GlobalState["EconomyWeapon"] = 1.0
        GlobalState["EconomyDrugs"] = 1.0
    end,
}

CreateThread(function()
    if CityEconomy[cityName] then
        CityEconomy[cityName]()
    end
end)
vRP.Prepare("bank_log/AddBank","INSERT INTO bank_log(Passport,Amount,Type) VALUES(@Passport,@Amount,@Type)")

function vRP.GiveBank(Passport,Amount,Type)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		exports["bank"]:AddTransactions(Passport,"entry",Amount)
		vRP.Query("characters/addBank",{ Passport = Passport, amount = Amount })
        -- --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Type})
		if Characters[source] then
			Characters[source]["bank"] = Characters[source]["bank"] + Amount
            local Achievement = BankAchievements[GetClosesValueinTable(BankAchievements,Characters[source]["bank"])]
            if Achievement then
                -- if not PlayerAchievements[Passport][Achievement] or not PlayerAchievements[Passport][Achievement]["completed"] then
                --     vRP.UpdateAchievement(Passport,Achievement,1)
                -- end
            end
			TriggerClientEvent("itensNotify",source,{ "added","dollars",Amount,"Dólares" })
		end
	end
end

function vRP.GenerateMoney(Passport,Amount,Notify)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)
    if Amount > 1 then
        Amount = parseInt(Amount * GlobalState["EconomyMoney"])
    end
	if Amount > 0 then
		exports["bank"]:AddTransactions(Passport,"entry",Amount)
		vRP.Query("characters/addBank",{ Passport = Passport, amount = Amount })
		if Characters[source] then
			Characters[source]["bank"] = Characters[source]["bank"] + Amount
            if Notify then
			    TriggerClientEvent("itensNotify",source,{ "added","dollars",Amount,"Dólares" })
            end
            local Item = "dollars"
            if Item and ItemId[Item] and ItemId[Item]["Id"] then
                exports["inventory"]:CreateItem(ItemId[Item]["Id"],Amount)
            end
		end
	end
end

function GetClosesValueinTable(table,value)
    local closest = 0
    for k,v in pairs(table) do
        if value >= k then
            closest = k
        end
    end
    return closest
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveBank(Passport,Amount,Hidden)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)

	if Amount > 0 then
        if not Hidden then
		    exports["bank"]:AddTransactions(Passport,"exit",Amount)
        end
		vRP.Query("characters/remBank",{ Passport = Passport, amount = Amount })

		if Characters[source] then
			Characters[source]["bank"] = Characters[source]["bank"] - Amount

			if Characters[source]["bank"] < 0 then
				Characters[source]["bank"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetBank(source)
	if Characters[source] then
		return Characters[source]["bank"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetFine(source)
	if Characters[source] then
		return Characters[source]["fines"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveFine(Passport,Amount)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		vRP.Query("characters/addFines",{ id = Passport, fines = Amount })

		if Characters[source] then
			Characters[source]["fines"] = Characters[source]["fines"] + Amount
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveFine(Passport,Amount)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		vRP.Query("characters/removeFines",{ id = Passport, fines = Amount })

		if Characters[source] then
			Characters[source]["fines"] = Characters[source]["fines"] - Amount

			if Characters[source]["fines"] < 0 then
				Characters[source]["fines"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTGEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentGems(Passport,Amount)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		if Characters[source] then
			if vRP.UserGemstone(Characters[source]["license"]) >= Amount then
				vRP.Query("accounts/RemoveGems",{ license = Characters[source]["license"], gems = Amount })
				TriggerClientEvent("hud:RemoveGems",source,Amount)

				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentBank(Passport,Amount)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)

    if source then
        if Amount > 0 then
            if Characters[source] then
                if Characters[source]["bank"] >= Amount then
                    vRP.RemoveBank(Passport,Amount,source)
                    TriggerClientEvent("itensNotify",source,{ "removed","dollars",Amount,"Dólares" })

                    return true
                end
            end
        end
    end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentFull(Passport,Amount)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)
    
    if source and Passport and Amount then
        if Amount > 0 then
            local Consult = vRP.InventoryItemAmount(Passport,"creditcard")
            if Consult[1] >= 1 then
                local OtherPassport = splitString(Consult[2],"-")[2]
                local Check = vRP.Query("dependents/Check",{ Passport = OtherPassport, Dependent = Passport })

                if Check[1] then
                    local Identity = vRP.Identity(OtherPassport)
                    if Identity then
                        if Identity["bank"] >= Amount then
                            vRP.RemoveBank(OtherPassport,Amount,source)
                            TriggerClientEvent("itensNotify",source,{ "removed","dollars",Amount,"Dólares" })

                            return true
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"amarelo","Cartão bloqueado.",5000)
                    -- TriggerClientEvent("Notify2",source,"#cardBlocked")
                    vRP.RemoveItem(Passport,Consult[2],1,false)
                end
            elseif vRP.TakeItem(Passport,"dollars",Amount,true) then
                return true
            else
                return vRP.PaymentBank(Passport,Amount)
            end
        end
    end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WithdrawCash(Passport,Amount)
	local Amount = parseInt(Amount)
	local Passport = parseInt(Passport)
	local source = vRP.Source(Passport)

	if Amount > 0 then
		if Characters[source] then
			if Characters[source]["bank"] >= Amount then
				vRP.RemoveBank(Passport,Amount,source)
				vRP.GiveItem(Passport,"dollars",Amount,true)
                -- -- --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = "Withdraw"})
				return true
			end
		end
	end

	return false
end
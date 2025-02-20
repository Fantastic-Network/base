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
Tunnel.bindInterface("bank",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local Cooldown = 0
vRP.Prepare("transactions/List","SELECT * FROM transactions WHERE Passport = @Passport ORDER BY id DESC LIMIT @Limit")
vRP.Prepare("transactions/Add","INSERT INTO transactions(Passport,Type,Date,Value,Balance) VALUES(@Passport,@Type,@Date,@Value,@Balance)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVES
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	while true do
-- 		if os.time() >= Cooldown then
-- 			Cooldown = os.time() + 3600
-- 			vRP.Query("investments/Actives")
-- 		end

-- 		Wait(1000)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOME
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Home()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Yield = 0
		local Identity = vRP.Identity(Passport)

		-- local InvestmentCheck = vRP.Query("investments/Check",{ Passport = Passport })
		-- if InvestmentCheck[1] then
		-- 	Yield = InvestmentCheck[1]["Monthly"]
		-- end

		return {
			["yield"] = Yield,
			["cardnumber"] = "0000 0000 0000 "..1000 + Passport,
			["balance"] = Identity["bank"],
			["transactions"] = Transactions(Passport),
			["dependents"] = Dependents(Passport)
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDDEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.AddDependents(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and OtherPassport ~= Passport then
		Active[Passport] = true

		local Check = vRP.Query("dependents/Check",{ Passport = Passport, Dependent = OtherPassport })
		if not Check[1] then
			local OtherSource = vRP.Source(OtherPassport)
			if OtherSource then
				local Identity = vRP.Identity(Passport)
				local OtherIdentity = vRP.Identity(OtherPassport)

				if vRP.Request(OtherSource,"<b>"..Identity["name"].."</b> deseja convida-lo para sua lista de dependentes bancário, você aceita esse convite?","Sim, aceito","Não, obrigado") then
					vRP.Query("dependents/Add",{ Passport = Passport, Dependent = OtherPassport, Name = OtherIdentity["name"].." "..OtherIdentity["name2"] })
					vRP.GiveItem(OtherPassport,"creditcard-"..Passport,1,true)
					Active[Passport] = nil

					return OtherIdentity["name"]
				end
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.RemoveDependents(OtherPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Consult = vRP.Query("dependents/Check",{ Passport = Passport, Dependent = OtherPassport })
		if Consult[1] then
			vRP.Query("dependents/Remove",{ Passport = Passport, Dependent = OtherPassport })
			Active[Passport] = nil

			return true
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONHISTORIY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TransactionHistory()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Transactions(Passport,50)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Deposit(Valuation)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and parseInt(Valuation) > 0 then
		Active[Passport] = true

		if vRP.ConsultItem(Passport,"dollars",Valuation) and vRP.TakeItem(Passport,"dollars",Valuation) then
			vRP.GiveBank(Passport,Valuation,"Deposit")
		end

		Active[Passport] = nil

		return {
			["balance"] = vRP.Identity(Passport)["bank"],
			["transactions"] = Transactions(Passport)
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Withdraw(Valuation)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and parseInt(Valuation) > 0 then
		Active[Passport] = true

		vRP.WithdrawCash(Passport,Valuation)

		Active[Passport] = nil

		return {
			["balance"] = vRP.Identity(Passport)["bank"],
			["transactions"] = Transactions(Passport)
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Transfer(OtherPassport,Valuation)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and OtherPassport ~= Passport and parseInt(Valuation) > 0 then
		Active[Passport] = true

		if vRP.Identity(OtherPassport) and vRP.PaymentBank(Passport,Valuation,true) then
			vRP.GiveBank(OtherPassport,Valuation,"Transfer")
		end

		Active[Passport] = nil
	end

	return {
		["balance"] = vRP.Identity(Passport)["Bank"],
		["transactions"] = Transactions(Passport)
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Transactions(Passport,Limit)
	local Transaction = {}
	local TransactionList = vRP.Query("transactions/List",{ Passport = Passport, Limit = Limit or 4 })
	if TransactionList[1] then
		for _,v in pairs(TransactionList) do
			Transaction[#Transaction + 1] = {
				["type"] = v["Type"],
				["date"] = v["Date"],
				["value"] = v["Value"],
				["balance"] = v["Balance"]
			}
		end
	end

	return Transaction
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPENDENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Dependents(Passport)
	local Dependents = {}
	local DependentList = vRP.Query("dependents/List",{ Passport = Passport })
	if DependentList[1] then
		for _,v in pairs(DependentList) do
			Dependents[#Dependents + 1] = {
				["name"] = v["Name"],
				["passport"] = v["Dependent"]
			}
		end
	end

	return Dependents
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINES
-----------------------------------------------------------------------------------------------------------------------------------------
function Fines(Passport)
	local Fines = {}
	local FineList = vRP.Query("fines/List",{ Passport = Passport })
	if FineList[1] then
		for _,v in pairs(FineList) do
			Fines[#Fines + 1] = {
				["id"] = v["id"],
				["name"] = v["Name"],
				["value"] = v["Value"],
				["date"] = v["Date"],
				["hour"] = v["Hour"],
				["message"] = v["Message"]
			}
		end
	end

	return Fines
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.FineList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Fines(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.FinePayment(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Fine = vRP.Query("fines/Check",{ Passport = Passport, id = Number })
		if Fine[1] then
			if vRP.PaymentBank(Passport,Fine[1]["Value"]) then
				vRP.Query("fines/Remove",{ Passport = Passport, id = Number })
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINEPAYMENTALL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.FinePaymentAll()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local FineList = vRP.Query("fines/List",{ Passport = Passport })
		if FineList[1] then
			for _,v in pairs(FineList) do
				if vRP.PaymentBank(Passport,v["Value"]) then
					vRP.Query("fines/Remove",{ Passport = Passport, id = v["id"] })
				end
			end
		end

		Active[Passport] = nil

		return Fines(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXS
-----------------------------------------------------------------------------------------------------------------------------------------
function Taxs(Passport)
	local Taxs = {}
	local TaxList = vRP.Query("taxs/List",{ Passport = Passport })
	if TaxList[1] then
		for _,v in pairs(TaxList) do
			Taxs[#Taxs + 1] = {
				["id"] = v["id"],
				["name"] = v["Name"],
				["value"] = v["Value"],
				["date"] = v["Date"],
				["hour"] = v["Hour"],
				["message"] = v["Message"]
			}
		end
	end

	return Taxs
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TaxList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Taxs(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAXPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TaxPayment(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Tax = vRP.Query("taxs/Check",{ Passport = Passport, id = Number })
		if Tax[1] then
			if vRP.PaymentBank(Passport,Tax[1]["Value"]) then
				vRP.Query("taxs/Remove",{ Passport = Passport, id = Number })
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.InvoiceList()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		return Invoices(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.MakeInvoice(OtherPassport,Value,Reason)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and OtherPassport ~= Passport and parseInt(Value) > 0 then
		Active[Passport] = true

		local OtherSource = vRP.Source(OtherPassport)
		if OtherSource then
			local Identity = vRP.Identity(Passport)
			if vRP.Request(OtherSource,"<b>"..Identity["name"].." "..Identity["name2"].."</b> lhe enviou uma fatura de <b>R$"..parseFormat(Value).."</b>, deseja aceita-la?","Sim, por favor","Não, obrigado") then
				vRP.Query("invoices/Add",{ Passport = OtherPassport, Received = Passport, Type = "received", Reason = Reason, Holder = Identity["name"].." "..Identity["name2"], Value = Value })
				vRP.Query("invoices/Add",{ Passport = Passport, Received = OtherPassport, Type = "sent", Reason = Reason, Holder = "Você", Value = Value })
				Active[Passport] = nil

				return Invoices(Passport)
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICEPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.InvoicePayment(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		local Invoice = vRP.Query("invoices/Check",{ id = Number })
		if Invoice[1] then
			if vRP.PaymentBank(Passport,Invoice[1]["Value"]) then
				vRP.GiveBank(Invoice[1]["Received"],Invoice[1]["Value"],"Invoice")
				vRP.Query("invoices/Remove",{ id = Number })
				Active[Passport] = nil

				return true
			end
		end

		Active[Passport] = nil
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function Invoices(Passport)
	local Invoices = {}
	local InvoiceList = vRP.Query("invoices/List",{ Passport = Passport })
	if InvoiceList[1] then
		for _,v in pairs(InvoiceList) do
			local Type = v["Type"]

			if not Invoices[Type] then
				Invoices[Type] = {}
			end

			Invoices[Type][#Invoices[Type] + 1] = {
				["id"] = v["id"],
				["reason"] = v["Reason"],
				["holder"] = v["Holder"],
				["value"] = v["Value"]
			}
		end
	end

	return Invoices
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTMENTS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Investments()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Total,Brute,Liquid,Deposit = 0,0,0,0
		-- local InvestmentCheck = vRP.Query("investments/Check",{ Passport = Passport })
		-- if InvestmentCheck[1] then
		-- 	Total = InvestmentCheck[1]["Deposit"] + InvestmentCheck[1]["Liquid"]
		-- 	Brute = InvestmentCheck[1]["Deposit"]
		-- 	Liquid = InvestmentCheck[1]["Liquid"]
		-- 	Deposit = InvestmentCheck[1]["Deposit"]
		-- end

		return {
			["total"] = Total,
			["brute"] = Brute,
			["liquid"] = Liquid,
			["deposit"] = Deposit
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Invest(Valuation)
	local source = source
	local Passport = vRP.Passport(source)
    TriggerClientEvent(source,"Notify","vermelho","<b>Manutencão</b> Emergencial nos Investimentos, Somente possivel retirada.","Investimento",8000)
	-- TriggerClientEvent(source,"Notify2","#manuInvestimento")
    return false
	-- if Passport and not Active[Passport] and parseInt(Valuation) > 0 then
	-- 	Active[Passport] = true

	-- 	if vRP.PaymentBank(Passport,Valuation,true) then
	-- 		local InvestmentCheck = vRP.Query("investments/Check",{ Passport = Passport })
	-- 		if InvestmentCheck[1] then
	-- 			vRP.Query("investments/Invest",{ Passport = Passport, Value = Valuation })
	-- 		else
	-- 			vRP.Query("investments/Add",{ Passport = Passport, Deposit = Valuation })
	-- 		end

	-- 		Active[Passport] = nil

	-- 		return true
	-- 	end

	-- 	Active[Passport] = nil
	-- end

	-- return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVESTRESCUE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.InvestRescue()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] then
		Active[Passport] = true

		-- local InvestmentCheck = vRP.Query("investments/Check",{ Passport = Passport })
		-- if InvestmentCheck[1] then
		-- 	local Valuation = InvestmentCheck[1]["Deposit"] + InvestmentCheck[1]["Liquid"]
		-- 	vRP.Query("investments/Remove",{ Passport = Passport })
		-- 	vRP.GiveBank(Passport,Valuation,"Invest")
		-- end

		Active[Passport] = nil
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTAXS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTaxs",function(Passport,Name,Value,Message)
	local Identity = vRP.Identity(Passport)
	if Identity then
		vRP.Query("taxs/Add",{ Passport = Passport, Name = Name, Date = os.date("%d/%m/%Y"), Hour = os.date("%H:%M"), Value = Value, Message = Message })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTAXS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddTransactions",function(Passport,Type,Value)
	local Identity = vRP.Identity(Passport)
	if Identity then
		vRP.Query("transactions/Add",{ Passport = Passport, Type = Type, Date = os.date("%d/%m/%Y"), Value = Value, Balance = Identity["bank"] })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDFINES
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddFines",function(Passport,OtherPassport,Value,Message,mdt)
	local Identity = vRP.Identity(OtherPassport)
	if Identity then
		vRP.Query("fines/Add",{ Passport = Passport, Name = Identity["name"].." "..Identity["name2"], Date = os.date("%d/%m/%Y"), Hour = os.date("%H:%M"), Value = Value, Message = Message, mdt = mdt })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Taxs",Taxs)
exports("Fines",Fines)
exports("Invoices",Invoices)
exports("Dependents",Dependents)
exports("Transactions",Transactions)
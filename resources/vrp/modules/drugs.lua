-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Weed = {}
local Alcohol = {}
local Chemical = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WeedReturn(Passport)
	if Weed[Passport] then
		if os.time() < Weed[Passport] then
			return parseInt(Weed[Passport] - os.time())
		else
			Weed[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WeedTimer(Passport,Time)
	if Weed[Passport] then
		Weed[Passport] = Weed[Passport] + (Time * 60)
	else
		Weed[Passport] = os.time() + (Time * 60)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChemicalReturn(Passport)
	if Chemical[Passport] then
		if os.time() < Chemical[Passport] then
			return parseInt(Chemical[Passport] - os.time())
		else
			Chemical[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChemicalTimer(Passport,Time)
	if Chemical[Passport] then
		Chemical[Passport] = Chemical[Passport] + (Time * 60)
	else
		Chemical[Passport] = os.time() + (Time * 60)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALCOHOLRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AlcoholReturn(Passport)
	if Alcohol[Passport] then
		if os.time() < Alcohol[Passport] then
			return parseInt(Alcohol[Passport] - os.time())
		else
			Alcohol[Passport] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AlcoholTimer(Passport,Time)
	if Alcohol[Passport] then
		Alcohol[Passport] = Alcohol[Passport] + (Time * 60)
	else
		Alcohol[Passport] = os.time() + (Time * 60)
	end
end
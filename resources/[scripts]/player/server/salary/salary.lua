-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY
-----------------------------------------------------------------------------------------------------------------------------------------
local Salary = {}
local SalaryTimer = 60*60
local SalaryEconomy =  1
local GroupsSalaryEconomy = {}
CreateThread(function()
    Wait(500)
    SalaryTimer = exports["variables"]:GetVariable("variables","SalaryTimer") or 60*60
    SalaryEconomy = exports["variables"]:GetVariable("variables","SalaryEconomy") or 1
    GroupsSalaryEconomy = exports['variables']:GetVariable('variables','GroupsSalaryEconomy') or {}
end)

local Groups = GetGroups()
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Salary:Add",function(Passport,Permission)
    local Passport = parseInt(Passport)
	if not Salary[Permission] then
		Salary[Permission] = {}
	end

	if not Salary[Permission][Passport] then
		Salary[Permission][Passport] = os.time() + SalaryTimer
	end
    local Source = vRP.Source(Passport)
    if Source and DoesPlayerExist(Source) then
        TriggerClientEvent("updateRewards",vRP.Source(parseInt(Passport)),{["money"] = { start = SalaryTimer, multiplier = 1 }})
    end
end)

-- Debug
-- CreateThread(function()
--     TriggerEvent("Salary:Add",1,"Black")
--     TriggerEvent("Salary:Add",1,"Ouro")
-- end)

CreateThread(function()
    local Players = GetPlayers()
    for i=1,#Players do
        local Player = Players[i]
        local Passport = vRP.Passport(parseInt(Player))
        if Passport then
            for Permission,_ in pairs(Groups) do
                if vRP.HasGroup(Passport,Permission) then
                    TriggerEvent("Salary:Add",Passport,Permission)
                end
            end
        end
        Wait(5)
    end
    -- print("^1[Salary]^0 Loaded!")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Salary:Remove",function(Passport,Permission)
	if Permission then
		if Salary[Permission] and Salary[Permission][Passport] then
			Salary[Permission][Passport] = nil
		end
	else
		for Permission,_ in pairs(Salary) do
			if Salary[Permission][Passport] then
				Salary[Permission][Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FACVALUE
-----------------------------------------------------------------------------------------------------------------------------------------
local FacValue = {
	[1] = 6000,
	[2] = 4000,
	[3] = 2000
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
local PermissionFunction = {
    ["Premium"] = function(Permission,Passport)
        if UserPremium[Passport] and UserPremium[Passport][1] then
            for i=1,#UserPremium[Passport] do
                local Amount = UserPremium[Passport][i] * SalaryEconomy
                if Amount then
                    vRP.GenerateMoney(Passport,Amount,"Premium Salary",false)
                end
            end
        end
        Salary[Permission][Passport] = os.time() + SalaryTimer
    end,
}

local TypeFunction = {
    ["Salary"] = function(Permission,Passport)
        local Source = vRP.Source(parseInt(Passport))
        local Amount = Groups[Permission]["Salary"][1]
        if GroupsSalaryEconomy[Permission] then
            Amount = GroupsSalaryEconomy[Permission][1]
        end
        Amount = Amount * SalaryEconomy
        vRP.GenerateMoney(Passport,Amount,"Salary",false)
        Salary[Permission][Passport] = os.time() + SalaryTimer
        if Source and DoesPlayerExist(Source) then
            TriggerClientEvent("rewardsAnimation",Source,"money",Groups[Permission]["Salary"][1])
            TriggerClientEvent("updateRewards",Source,{["money"] = { start = SalaryTimer, multiplier = 1 }})
        end
    end,
    ["VIP"] = function(Permission,Passport)
        local Source = vRP.Source(parseInt(Passport))
        local Amount = Groups[Permission]["Salary"][1]
        if GroupsSalaryEconomy[Permission] then
            Amount = GroupsSalaryEconomy[Permission][1]
        end
        Amount = Amount * SalaryEconomy
        vRP.GenerateMoney(Passport,Amount,"Salary VIP",false)
        Salary[Permission][Passport] = os.time() + SalaryTimer
        if Source then
            TriggerClientEvent("rewardsAnimation",Source,"money",Groups[Permission]["Salary"][1])
            TriggerClientEvent("updateRewards",Source,{["money"] = { start = SalaryTimer, multiplier = 1 }})
        end
    end,
    ["Painel"] = function(Permission,Passport)
        local Number = vRP.HasPermission(Passport,Permission)
        if Number then
            if Groups[Permission]["Salary"][Number] and Groups[Permission]["Salary"][Number] > 0 then
                local Amount = Groups[Permission]["Salary"][Number]
                if GroupsSalaryEconomy[Permission] then
                    Amount = GroupsSalaryEconomy[Permission][Number]
                end
                Amount = Amount * SalaryEconomy
                vRP.GenerateMoney(Passport,Amount,"Salary Painel",false)
                Salary[Permission][Passport] = os.time() + SalaryTimer
            end

            local Level = 0
            local Consult = vRP.Query("painel/getallVip",{ name = Permission })
            if Consult[1] and parseInt(Consult[1]["level"]) >= 1 then
                Level = parseInt(Consult[1]["level"])

                if FacValue[Level] then
                    local Amount = FacValue[Level] * SalaryEconomy
                    vRP.GiveBank(Amount,"Salary Painel",true)
                    Salary[Permission][Passport] = os.time() + SalaryTimer
                end
            end
            local Source = vRP.Source(parseInt(Passport))
            if Source and DoesPlayerExist(Source) then
                async(function()
                    TriggerClientEvent("updateRewards",Source,{["money"] = { start = SalaryTimer, multiplier = 1 }})
                end)
            end
        end
    end,
}

CreateThread(function()
    while true do
        local now = os.time()

        -- print('Salary tick #')
        -- print('Salary tick -> Salary', json.encode(Salary))

        for Permission, entries in pairs(Salary) do

            -- print('Salary tick -> Permission', Permission, 'entries', json.encode(entries))

            for Passport, Timer in pairs(entries) do

                -- print('Salary tick -> entry Passport', Passport, 'Timer', Timer, 'give salary', now >= Timer)

                if now >= Timer then

                    ---@type fun(...) | nil
                    local func = nil

                    if PermissionFunction[Permission] then
                        func = PermissionFunction[Permission]
                    elseif Groups[Permission]["Type"] and TypeFunction[Groups[Permission]["Type"]] then
                        func = TypeFunction[Groups[Permission]["Type"]]
                    else
                        if TypeFunction["Painel"] then
                            func = TypeFunction["Painel"]
                        end
                    end
                    if func then
                        Citizen.CreateThreadNow(function()
                            xpcall(
                                function()
                                    func(Permission, Passport)
                                end,
                                function(err)
                                    -- TODO: Log error?

                                    -- print( ('Salary tick error! passport=%d permission=%s'):format(Passport, Permission), err )
                                end
                            )
                        end)
                    end
                end
            end
        end

        -- print('Salary tick # end')
        
        Wait(60 * 1000 --[[ A cada 1 minuto ]])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	for Permission,_ in pairs(Salary) do
		if Salary[Permission][Passport] then
			Salary[Permission][Passport] = nil
		end
	end
end)
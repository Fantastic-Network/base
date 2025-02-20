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
Server = {}
Tunnel.bindInterface("register",Server)
vCLIENT = Tunnel.getInterface("register")
cityName = GetConvar("cityName","Base")
DevMode = "true"
local characters = {}
local ObrigatoryToken = false
local TokenTimer = {}
local WithToken = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/updateAccountInfo","UPDATE accounts SET name = @Name, email = @Email, sex = @Sex, recommendation = @Recommendation, birthday = STR_TO_DATE(@Birthday,'%Y-%m-%d'), whatsapp = @Number WHERE license = @License")
vRP.Prepare("accounts/updateAccountRecommendation","UPDATE accounts SET recommendation = @recommendation WHERE license = @License")
vRP.Prepare("accounts/getAccountRecommendation","SELECT recommendation,token FROM accounts WHERE license = @License")
vRP.Prepare("accounts/getAccountToken","SELECT id FROM accounts WHERE token = @Token")
vRP.Prepare("vehicles/freeVehicles","INSERT IGNORE INTO vehicles(Passport,vehicle,plate,work,rental,tax,degrade,expires) VALUES(@Passport,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 86000,UNIX_TIMESTAMP() + 86000,UNIX_TIMESTAMP(),DATE_ADD(CURRENT_TIMESTAMP(),INTERVAL + @Days DAY))")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.setAccountInfo(Name,Email,Sex,Recommendation,Birthday,Number)
    local source = source
    local License = vRP.Identities(source)
    vRP.Query("accounts/updateAccountInfo",{ Name = Name, Email = Email, Sex = Sex, Recommendation = recommendationConfig[cityName][Recommendation], Birthday = Birthday, License = License, Number = Number })
    exports["vrp"]:ChangePlayerBucket(source,source)
    return true
end

RegisterServerEvent("register:CheckRegister")
AddEventHandler("register:CheckRegister",function()
    local Source = source
    local License = vRP.Identities(Source)
    local Account = vRP.Account(License)
    if DevMode == "true" and Account["token"] ~= nil then
        vRP.Query("accounts/GenerateToken",{ license = License, token = nil })
    end

    if Account and Account["token"] then
        Player(Source)["state"]["Token"] = Account["token"]
    end

    if not Account["name"] then
        print("Register: "..Source.." - "..License)
        TriggerClientEvent("spawn:SetNewPlayer",Source)
        TriggerClientEvent("register:Open",Source,true)
        exports["vrp"]:ChangePlayerBucket(Source,parseInt(Source))
        vRP.Query("login_steps/AddSteps",{ Action = 1, AccountId = Account["id"] })
        vRP.Query("new_player/setNewAction", { id = Account["id"], action = 2 })
    elseif Account["name"] and Account["token"] then
        TriggerClientEvent("register:OpenToken",Source)
        exports["vrp"]:ChangePlayerBucket(Source,parseInt(Source))
        vRP.Query("login_steps/AddSteps",{ Action = 4, AccountId = Account["id"] })
    else
        TriggerClientEvent("spawn:FirsLogin",Source)
    end
end)

AddEventHandler("Connect",function(Passport,Source)
    local Identity = vRP.Identity(Passport)
    local License = vRP.Identities(Source)
    local Account = vRP.Account(License)
    if Account and Account["token"] then
        Player(Source)["state"]["Token"] = Account["token"]
    end

    if DevMode == "true" then
        ExecuteCommand("removetoken")
        ExecuteCommand("removediscordprotection")
    end
    
    if not Account["token"] and not Account["name"] then
        TriggerClientEvent("register:Open",Source,true)
        exports["vrp"]:ChangePlayerBucket(Source,parseInt(Source))
        vRP.Query("login_steps/AddSteps",{ Action = 1, AccountId = Account["id"] })
        vRP.Query("new_player/setNewAction", { id = Account["id"], action = 2 })
    elseif Account["name"] and Account["token"] then
        TriggerClientEvent("register:OpenToken",Source)
        exports["vrp"]:ChangePlayerBucket(Source,parseInt(Source))
        vRP.Query("login_steps/AddSteps",{ Action = 4, AccountId = Account["id"] })
    end

    if Identity["tracking"] then
        if Identity["tracking"] >= 900 then
            local query = vRP.Query("accounts/getAccountRecommendation",{ License = License })
            if query[1] then
                for Recommendation,Value in pairs(recommendationConfig[cityName]) do
                    if query[1]["recommendation"] == Value then
                        vRP.Query("accounts/updateAccountRecommendation",{ recommendation = Recommendation, License = License })
                    end
                end
            end
        end
    end
end)

local StoreToken = {
    ["Base"] = "SEU TOKEN AQUI",
}

-- function CheckBannedDiscord(Source)
--     local License = vRP.Identities(Source)
--     local Account = vRP.Account(License)
--     if Account["discord"] ~= "0" then
--         local BannedDiscord = false
--         local Discords = vRP.Query("banneds_hwid/CheckRDiscord",{ Account["discord"] })
--         for i=1,#Discords do
--             if Discords[i]["id"] and tostring(Discords[i]["id"]) ~= "0" then
--                 if vRP.Banned(Discords[i]["id"]) then
--                     BannedDiscord = true
--                     exports["vrp"]:SendWebHook("hwid","```prolog\n[ACCOUNT ID ANTIGO]: "..Discords[i]["id"].."\n[ACCOUNT ID NOVA]: "..Account["id"].."\n[BANIDO HWID_3]\n" ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```")
--                 end
--             end
--         end
--         if BannedDiscord then
--             vRP.Query("banneds/InsertBanned",{ accountId = Account["id"], reason = "HWID_3" })
--             DropPlayer(Source,"Voce está banido por HWID")
--         end
--     end
-- end

function Server.ValidateToken()
    local Source = source
    local License = vRP.Identities(Source)
    local Account = vRP.Account(License)
    local Valid = false
    local Passport = vRP.Passport(Source)
    local SetToken = false
    if ObrigatoryToken then
        if Account then
            if not Account["token"] then
                Player(Source)["state"]["Token"] = false
                Valid = true
                Wait(100)
                --CheckBannedDiscord(Source)
                if TokenTimer[Passport] then
                    TokenTimer[Passport] = nil
                end
                local Consult = vRP.Query("characters/lastCharacters",{ license = License })
                TriggerClientEvent("register:Close",Source)
                if not Consult[1] then
                    local Ped = GetPlayerPed(Source)
                    TriggerClientEvent("spawn:FirsLogin",Source)
                    SetEntityHeading(Ped,138.9)
                    vRP.Query("login_steps/AddSteps",{ Action = 4, AccountId = Account["id"] })
                    Player(Source)["state"]["FirstLogin"] = true
                    if Ped ~= 0 and DoesEntityExist(Ped) then
                        local Coords = GetEntityCoords(Ped)
                        local Bucket = parseInt(Source+5500)
                        exports["vrp"]:ChangePlayerBucket(Source,Bucket)
                    end
                end
            end
        end
    else
        Valid = true
    end
    return Valid
end

vRP.Prepare("vehicles/UserVehiclesRegister","SELECT id FROM vehicles WHERE Passport = @Passport LIMIT 1")

function Server.giveVehicle(Spawn)
    local Source = source
    local Passport = vRP.Passport(Source)
    local License = vRP.Identities(Source)
    local Account = vRP.Account(License)
    if Passport and validateVehicle(Spawn) then
        local Query = vRP.Query("vehicles/UserVehiclesRegister",{ Passport = Passport })
        if not Query[1] then
            vRP.Query("vehicles/freeVehicles",{ Passport = Passport, vehicle = Spawn, plate = vRP.GeneratePlate(), work = "false", Days = 7 })
        end
        TriggerClientEvent("register:Close",Source)
        SetEntityHeading(Ped,138.9)
        vRP.Query("login_steps/AddSteps",{ Action = 4, AccountId = Account["id"] })
    end
end

function validateVehicle(Spawn)
    for i=1,#infoLogin[cityName]["Cars"] do
        if infoLogin[cityName]["Cars"][i]["spawn"] == Spawn then
            return true
        end
    end
end

RegisterCommand("removetoken",function(source,args)
    if source == 0 then
        ObrigatoryToken = not ObrigatoryToken
        if ObrigatoryToken then
            print("Token Obrigatorio: ^2ATIVADO^7")
        else
            print("Token Obrigatorio: ^1DESATIVADO^7")
        end
    end
end)

-- CreateThread(function()
--     while true do
--         for Passport,Timer in pairs(TokenTimer) do
--             if os.time() > Timer then
--                 if ObrigatoryToken then
--                     local Source = vRP.Source(Passport)
--                     TriggerClientEvent("register:OpenToken",Source)
--                 end
--             end
--         end
--         Wait(60000)
--     end
-- end)
CreateThread(function()
    while true do
        for Passport,Timer in pairs(WithToken) do
            if os.time() > Timer then
                if ObrigatoryToken then
                    local Source = vRP.Source(Passport)
                    if Source then
                        local Identity = vRP.Identity(Passport)
                        local License = vRP.Identities(Source)
                        local Account = vRP.Account(License)
                        if Account["token"] then
                            vRP.Kick(Source,"Valide seu token do discord TOKEN: "..Account["token"]..".")
                            WithToken[Passport] = nil
                        else
                            WithToken[Passport] = nil
                        end
                    end
                end
            end
        end
        Wait(60000*5)
    end
end)

AddEventHandler("Disconnect",function(Passport,Source)
    if TokenTimer[Passport] then
        TokenTimer[Passport] = nil
    end
    if WithToken[Passport] then
        WithToken[Passport] = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("register:AddAction")
AddEventHandler("register:AddAction",function(Action)
    local Source = source
    local License = vRP.Identities(Source)
    local Account = vRP.Account(License)
    if Account then
        vRP.Query("login_steps/AddSteps",{ Action = Action, AccountId = Account["id"] })
    end
end)


-- function Server.CheckAccount()
--     local Source = source
--     local Passport = vRP.Passport(Source)
--     if Passport then
--         local License = vRP.Identities(Source)
--         local Account = vRP.Account(License)
--         if Account and Account["token"] then
--             return false
--         end
--         return true
--     else
--         DropPlayer(Source,"Voce não tem um passaporte")
--     end
-- end

local CountRegister = {}
CreateThread(function()
    while true do
        xpcall(function()
            local Players = GetPlayers()
            for i=1,#Players do
                async(function()
                    local source = tostring(Players[i])
                    if not vCLIENT.CheckRegister(source) then
                        exports["vrp"]:ChangePlayerBucket(source,parseInt(source))
                        if CountRegister[source] then
                            CountRegister[source] = CountRegister[source] + 1
                            if CountRegister[source] >= 2 then
                                DropPlayer(source,"Você foi kickado por tentar burlar o sistema de registro.")
                            end
                        else
                            CountRegister[source] = 1
                        end
                    end
                end)
            end
        end,function(err)
            print(err)
        end)
        Wait(60000*2)
    end
end)
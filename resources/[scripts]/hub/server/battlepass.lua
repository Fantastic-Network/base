
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
BattlePass = {}
local BattlePassTime = 30*60
local BattlePassExperience = 50
local MaxExperience = GetBattlePassMax()
BattlePassRewards = GetBattlePass()
local MaxLevel = #BattlePassRewards["Free"]

vRP.Prepare("battlepass/GetPlayerInfo","SELECT * FROM battlepass WHERE passport = @passport")
vRP.Prepare("battlepass/InsertPlayer","INSERT INTO battlepass(passport,experience,level,hasPremium,premium,free) VALUES(@passport,@experience,@level,@hasPremium,@premium,@free)")
vRP.Prepare("battlepass/UpdatePlayer","UPDATE battlepass SET experience = @experience, level = @level, hasPremium = @hasPremium, premium = @premium, free = @free WHERE passport = @passport")
vRP.Prepare("battlepass/SetCompleted","UPDATE battlepass SET completed = current_timestamp() WHERE passport = @passport")

CreateThread(function()
    while true do
        for Passport,Info in pairs(BattlePass) do
            Citizen.CreateThreadNow(function()
                xpcall(
                    function()
                        CheckExperience(tostring(Passport))
                    end,
                    function(err)
                        print( ('Pass Experience tick error! passport=%d'):format(Passport), err )
                    end
                )
            end)
            Wait(1)
        end
        Wait(60000)
    end
end)

AddEventHandler("Connect",function(Passport,source)
    GeneratePlayerCache(Passport)
end)

AddEventHandler("Disconnect",function(Passport,source)
    local sPassport = tostring(Passport)
    if BattlePass[sPassport] then
        vRP.Query("battlepass/UpdatePlayer",{passport = Passport,experience = BattlePass[sPassport]["Experience"],level = BattlePass[sPassport]["Level"],hasPremium = BattlePass[sPassport]["HasPremium"], premium = json.encode(BattlePass[sPassport]["Premium"]),free = json.encode(BattlePass[sPassport]["Free"]) })
    end
    BattlePass[sPassport] = nil
end)

function GeneratePlayerCache(Passport)
    local Source = vRP.Source(Passport)
    local Query = vRP.Query("battlepass/GetPlayerInfo",{passport = Passport})
    local sPassport = tostring(Passport)
    if Query and Query[1] then
        BattlePass[sPassport] = {
            ["Experience"] = Query[1]["experience"],
            ["Level"] = Query[1]["level"],
            ["HasPremium"] = Query[1]["hasPremium"],
            ["Premium"] = json.decode(Query[1]["premium"]),
            ["Free"] = json.decode(Query[1]["free"]),
            ["Time"] = os.time()
        }
    else
        BattlePass[sPassport] = {
            ["Experience"] = 0,
            ["Level"] = 1,
            ["HasPremium"] = false,
            ["Premium"] = {},
            ["Free"] = {},
            ["Time"] = os.time()
        }
        vRP.Query("battlepass/InsertPlayer",{passport = Passport,experience = 0,level = 0,hasPremium = false, premium = json.encode({}),free = json.encode({}) })
    end
    if Source then
        TriggerClientEvent("hub:SeasonPass",Source,BattlePass[sPassport])
    end
end

-- CreateThread(function()
--     GeneratePlayerCache(Passport)
-- end)

function CheckExperience(Passport)
    local Table = BattlePass[Passport]
    local sPassport = tostring(Passport)
    if Table then
        local Time = os.time()
        if Table["Completed"] then
            return
        end
        if Table["Experience"] >= MaxExperience then
            Table["Completed"] = true
            vRP.Query("battlepass/SetCompleted",{passport = Passport})
        end
        if Time - Table["Time"] >= BattlePassTime then
            Table["Time"] = Time
            Table["Experience"] = Table["Experience"] + BattlePassExperience
            local Level = Table["Level"]
            local NextLevel = Level + 1
            local Source = vRP.Source(Passport)
            if BattlePassRewards["Free"][NextLevel] then
                if Table["Experience"] >= BattlePassRewards["Free"][NextLevel]["Experience"] then
                    Table["Level"] = Level + 1
                    if Source then
                        TriggerClientEvent("Notify",Source,"verde","Você subiu para o nível "..(NextLevel).." do passe de batalha.")
                    end
                    local higherAmount = 0
                    for _,Amount in pairs(BattlePassRewards["Premium"][NextLevel]["Reward"]) do
                        if Amount > higherAmount then
                            higherAmount = Amount
                        end
                    end
                    local Info = {
                        item = {
                            image = BattlePassRewards["Premium"][NextLevel]["Photo"],
                            name = BattlePassRewards["Premium"][NextLevel]["Name"],
                            amount = higherAmount,
                        },
                        level = Table["Level"],
                        maxLevel = MaxLevel,
                    }
                    if Source then
                        TriggerClientEvent("rewardsAnimation",Source,"battlepass",Info)
                        TriggerClientEvent("hub:SeasonPass",Source,BattlePass[Passport])
                    end
                    vRP.Query("battlepass/UpdatePlayer",{passport = Passport,experience = BattlePass[sPassport]["Experience"],level = BattlePass[sPassport]["Level"],hasPremium = BattlePass[sPassport]["HasPremium"], premium = json.encode(BattlePass[sPassport]["Premium"]),free = json.encode(BattlePass[sPassport]["Free"]) })
                end
                BattlePass[sPassport] = Table
            end
        end
    end
end

function HasPassPremium(Passport)
    if BattlePass[Passport] then
        return BattlePass[Passport]["HasPremium"]
    end
    return false
end


function PassReward(Passport,Level,Type)
    local Source = vRP.Source(Passport)
    local sPassport = tostring(Passport)
    Level = parseInt(Level)
    local sLevel = tostring(Level)
    if Type == "Premium" then
        if not BattlePass[sPassport]["HasPremium"] then
            return false
        end
        if BattlePass[sPassport]["Premium"][sLevel] then
            return false
        else
            if BattlePass[sPassport]["Experience"] >= BattlePassRewards["Premium"][Level]["Experience"] then
                local Table = BattlePassRewards["Premium"][Level]["Reward"]
                local Type = BattlePassRewards["Premium"][Level]["Type"]
                RewardsFunctions[Type](Passport,Table)
                BattlePass[sPassport]["Premium"][sLevel] = true
                vRP.Query("battlepass/UpdatePlayer",{passport = Passport,experience = BattlePass[sPassport]["Experience"],level = BattlePass[sPassport]["Level"],hasPremium = BattlePass[sPassport]["HasPremium"], premium = json.encode(BattlePass[sPassport]["Premium"]),free = json.encode(BattlePass[sPassport]["Free"]) })
                return true
            end
        end
    elseif Type == "Free" then
        if BattlePass[sPassport]["Free"][sLevel] then
            return false
        else
            if BattlePass[sPassport]["Experience"] >= BattlePassRewards["Free"][Level]["Experience"] then
                local Type = BattlePassRewards["Free"][Level]["Type"]
                local Table = BattlePassRewards["Free"][Level]["Reward"]
                RewardsFunctions[Type](Passport,Table)
                BattlePass[sPassport]["Free"][sLevel] = true
                vRP.Query("battlepass/UpdatePlayer",{passport = Passport,experience = BattlePass[sPassport]["Experience"],level = BattlePass[sPassport]["Level"],hasPremium = BattlePass[sPassport]["HasPremium"], premium = json.encode(BattlePass[sPassport]["Premium"]),free = json.encode(BattlePass[sPassport]["Free"]) })
                return true
            end
        end
    end
end

function PassRewardAll(Passport)
    local Source = vRP.Source(Passport)
    local sPassport = tostring(Passport)
    if BattlePass[sPassport]["HasPremium"] then
        for Level,Info in pairs(BattlePassRewards["Premium"]) do
            local sLevel = tostring(Level)
            if not BattlePass[sPassport]["Premium"][sLevel] then
                if not BattlePass[sPassport]["HasPremium"] then
                    return false
                end
                if BattlePass[sPassport]["Experience"] >= Info["Experience"] then
                    local Type = Info["Type"]
                    local Table = Info["Reward"]
                    RewardsFunctions[Type](Passport,Table)
                    BattlePass[sPassport]["Premium"][sLevel] = true
                end
            end
        end
    end
    for Level,Info in pairs(BattlePassRewards["Free"]) do
        local sLevel = tostring(Level)
        if not BattlePass[sPassport]["Free"][sLevel] then
            if BattlePass[sPassport]["Experience"] >= Info["Experience"] then
                local Type = Info["Type"]
                local Table = Info["Reward"]
                RewardsFunctions[Type](Passport,Table)
                BattlePass[sPassport]["Free"][sLevel] = true
            end
        end
    end
    vRP.Query("battlepass/UpdatePlayer",{passport = Passport,experience = BattlePass[sPassport]["Experience"],level = BattlePass[sPassport]["Level"],hasPremium = BattlePass[sPassport]["HasPremium"], premium = json.encode(BattlePass[sPassport]["Premium"]),free = json.encode(BattlePass[sPassport]["Free"]) })
    TriggerClientEvent("hub:SeasonPass",vRP.Source(Passport),BattlePass[sPassport])
end

function RemovePlayerCache(Passport)
    local sPassport = tostring(Passport)
    vRP.Query("battlepass/UpdatePlayer",{passport = Passport,experience = BattlePass[sPassport]["Experience"],level = BattlePass[sPassport]["Level"],hasPremium = BattlePass[sPassport]["HasPremium"], premium = json.encode(BattlePass[sPassport]["Premium"]),free = json.encode(BattlePass[sPassport]["Free"]) })
    BattlePass[sPassport] = nil
end

RewardsFunctions = {
    ["Item"] = function(Passport,Table)
        for Item,Amount in pairs(Table) do
            vRP.GenerateItem(Passport,Item,parseInt(Amount),true)
        end
    end,
    ["Vehicle"] = function(Passport,Table)
        for Vehicle,Amount in pairs(Table) do
            if Amount > 0 then
                vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = Vehicle, rental = 60*60*24*Amount, plate = vRP.GeneratePlate(), work = "false" })
            else
                vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Vehicle, plate = vRP.GeneratePlate(), work = "false" })
            end
        end
    end,
    ["temporaryGroup"] = function(Passport,Table)
        -- for Group,Days in pairs(Table) do
        --     vRP.AddTemporaryGroup(Passport,Group,Days)
        -- end
    end,
    ["Group"] = function(Passport,Table)
        for Group,Level in pairs(Table) do
            vRP.SetPermission(Passport,Group,Level)
        end
    end,
    ["Garage"] = function(Passport,Table) 
        for Garage,Amount in pairs(Table) do
            vRP.Query("characters/giveGarage",{ Passport = Passport, garages = Amount })
        end
    end,
    ["Diamond"] = function(Passport,Table)
        local Identity = vRP.Identity(Passport)
        for _,Amount in pairs(Table) do
            vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = parseInt(Amount) })
        end
    end,
}

CreateThread(function()
    Wait(2000)
    local Players = GetPlayers()
    for i=1,#Players do
        local Player = Players[i]
        local Passport = vRP.Passport(parseInt(Player))
        if Passport then
            GeneratePlayerCache(Passport)
        end
        Wait(5)
    end
    -- print("^1[BattlePass]^0 Loaded!")
end)

AddEventHandler("UpdatePlayerPass",function(Passport)
    if Passport then
        GeneratePlayerCache(Passport)
    end
end)

function ResetPass(Passport,Level)
    local userPassport = parseInt(Passport)
    local level = parseInt(Level)
    local experience = BattlePassRewards["Free"][level]["Experience"]
    local sUserPassport = tostring(userPassport)
    local Source = vRP.Source(userPassport)
    vRP.Query("battlepass/UpdatePlayer", {
        passport = userPassport, 
        experience = experience, 
        level = level, 
        hasPremium = 0,
        premium = json.encode({}), 
        free = json.encode({})
    })
    
    BattlePass[sUserPassport] = {
        ["Experience"] = experience,
        ["Level"] = level,
        ["HasPremium"] = false,
        ["Premium"] = {},
        ["Free"] = {},
        ["Time"] = os.time()
    }
    if Source then
        TriggerClientEvent("hub:SeasonPass",Source,BattlePass[sUserPassport])
    end
end
exports("ResetPass",ResetPass)

RegisterCommand("resetpass", function(source, args, rawCommand)
    local passport = vRP.Passport(source)
    if passport then
        if vRP.HasGroup(passport, "Admin", 2) then
            local userPassport = parseInt(args[1])
            local level = parseInt(args[2])
            local experience = BattlePassRewards["Free"][level]["Experience"]
            local sUserPassport = tostring(userPassport)
            vRP.Query("battlepass/UpdatePlayer", {
                passport = userPassport, 
                experience = experience, 
                level = level, 
                hasPremium = 0,
                premium = json.encode({}), 
                free = json.encode({})
            })
            
            BattlePass[sUserPassport] = {
                ["Experience"] = experience,
                ["Level"] = level,
                ["HasPremium"] = false,
                ["Premium"] = {},
                ["Free"] = {},
                ["Time"] = os.time()
            }

            TriggerClientEvent("Notify", source, "verde", "Voce resetou o Season Pass para o passaporte " .. userPassport .. ".", 8000, "BATTLEPASS")

            exports["vrp"]:SendWebHook("resetpass", "Passport: " .. passport .. " has reset the pass of Passport: " .. userPassport .. " to level " .. level .. " with experience " .. experience)
            TriggerClientEvent("hub:SeasonPass",vRP.Source(userPassport),BattlePass[sUserPassport])
        else
            TriggerClientEvent("Notify", source, "vermelho", "Voce nao tem permissao para usar esse comando.", 8000, "BATTLEPASS")
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "Passaporte nao encontrado.", 8000, "BATTLEPASS")
    end
end)

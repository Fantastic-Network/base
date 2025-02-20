-----------------------------------------------------------------------------------------------------------------------------------------
-- CODIGUIN
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("player_code/Create","INSERT INTO player_code (code, player, createdby) VALUES (@code, @player, @createdby)")
vRP.Prepare("player_code_uses/Create","INSERT INTO player_code_uses (code, player) VALUES (@code, @player)")
vRP.Prepare("player_code_uses/Get","SELECT * FROM player_code_uses WHERE player = @player")
vRP.Prepare("player_code/GetCode","SELECT * FROM player_code WHERE code = @code")
vRP.Prepare("player_code_uses/GetAll","SELECT * FROM player_code_uses WHERE player = @player")
vRP.Prepare("player_code_uses/updateSteps","UPDATE player_code_uses SET steps = @steps WHERE player = @player")
vRP.Prepare("player_code/UpdateUses","UPDATE player_code SET uses = uses + 1 WHERE code = @code")
vRP.Prepare("player_code/Get","SELECT * FROM player_code WHERE code = @code")
vRP.Prepare("player_code/GetAllUser","SELECT * FROM player_code WHERE player = @player")
vRP.Prepare("player_code_uses/GetAllCode","SELECT id,player,code,steps,UNIX_TIMESTAMP(date) as timestamp FROM player_code_uses WHERE code = @code")
vRP.Prepare("player_code_steps_history/GetAllFromToday","SELECT * FROM player_code_steps_history WHERE `code` = @code AND DATE(`Date`) = CURDATE()")
vRP.Prepare("player_code_uses/GetAllFromToday","SELECT COUNT(*) AS total FROM player_code_uses WHERE `code` = @code AND DATE(`date`) = CURDATE()")
vRP.Prepare("player_code_steps_history/Set","INSERT INTO player_code_steps_history (player, step, code) VALUES (@player, @step,@code)")

function cleanString(str)
    return (str:gsub("[^%w]", "")):gsub("_", "")
end

local RedeemFunctions = {
    ["Item"] = function(Passport,Rewards)
        for Item,Amount in pairs(Rewards) do
            vRP.GenerateItem(Passport,Item,parseInt(Amount),true,false,"CODIGUIN",Passport)
        end
    end,
    ["Vehicle"] = function(Passport,Rewards)
        for Spawn,Days in pairs(Rewards) do
            if Days then
                vRP.Query("vehicles/freeVehicles",{ Passport = Passport, vehicle = Spawn, plate = vRP.GeneratePlate(), work = "false", Days = Days })
            else
                vRP.Query("vehicles/addVehicles",{ Passport = parseInt(Passport), vehicle = Spawn, plate = vRP.GeneratePlate(), work = "false" })
            end
        end
    end,
    ["Diamonds"] = function(Passport,Amount)
        local License = vRP.License(Passport)
        local source = vRP.Source(Passport)
        if License then
            vRP.Query("accounts/AddGems",{ license = License, gems = Amount })
            TriggerClientEvent("Notify2",source,"#gem")
        end
    end,
    ["Groups"] = function(Passport,Rewards)
        for Group,Info in pairs(Rewards) do
            vRP.SetPermission(Passport,Group,Info["Level"],false,false,Info["Time"])
        end
    end,

}

local RedeemCode = {
    ["Base"] = {
        {
            Type = "Vehicle",
            Rewards = {
                ["gtrinfluencer"] = false, -- INFINITO
            }
        },
    },
}

RegisterCommand("createcode",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        --if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(Source,"Codigo:","Player:")
            if Keyboard and Keyboard[1] and Keyboard[2] then
                local Code = Keyboard[1]
                local Influencer = parseInt(Keyboard[2])
                if Code and Influencer then
                    vRP.Query("player_code/Create",{ code = Code, player = Influencer, createdby = Passport })
                    TriggerClientEvent("Notify2",Source,"#createCode",{msg=Code})
                end
            end
        --end
    end
end)

vRP.Prepare("characters/getDays","SELECT UNIX_TIMESTAMP(firstspawn) as created,DATEDIFF(CURDATE(), firstspawn) AS days FROM characters WHERE id = @Passport")
RegisterCommand("codiguin",function(Source,Args)
    local Passport = vRP.Passport(Source)
    if Passport then
        local Keyboard = vKEYBOARD.keySingle(Source,"Codigo:")
        if Keyboard and Keyboard[1] then
            local Code = Keyboard[1]:upper()
            local License = vRP.License(Passport)
            local Account = vRP.Account(License)
            if Account and Passport then
                local Query = vRP.Query("characters/getDays",{ Passport = Passport })
                if Query and Query[1] then
                    local Days = parseInt(Query[1]["days"])
                    if not Query[1]["days"] then
                        TriggerClientEvent("Notify2",Source,"#pastDaysCode")
                        return
                    end
                    if Days > 3 then
                        TriggerClientEvent("Notify2",Source,"#pastDaysCode")
                        return
                    end
                else
                    TriggerClientEvent("Notify2",Source,"#pastDaysCode")
                    return
                end
            else
                return
            end
            if Code then
                local Query = vRP.Query("player_code_uses/Get",{ player = Passport })
                if Query and Query[1] then
                    TriggerClientEvent("Notify2",Source,"#redeemedCode")
                    return
                end
                local Query = vRP.Query("player_code/Get",{ code = Code })
                if not Query or not Query[1] then
                    TriggerClientEvent("Notify2",Source,"#codeNfound")
                    return
                end
                if RedeemCode[cityName] then
                    for i=1,#RedeemCode[cityName] do
                        local Table = RedeemCode[cityName][i]
                        local Type = Table["Type"]
                        local Rewards = Table["Rewards"]
                        RedeemFunctions[Type](Passport,Rewards)
                    end
                    vRP.Query("player_code_uses/Create",{ code = Code, player = Passport })
                    vRP.Query("player_code/UpdateUses",{ code = Code })
                    TriggerClientEvent("Notify2",Source,"#redeemCode",{msg=Code})
                    Wait(100)
                    GetAllFromUser(Query[1]["player"])
                end
            end
        end
    end
end)

local StepsTracking = {
    [1] = 60,
    [2] = 120,
    [3] = 180,
    [4] = 360,
    [5] = 720,
    [6] = 1440,
    [7] = 2880,
    [8] = 5660,
    [9] = 9320,
    [10] = 12640,
    [11] = 15280,
    [12] = 20080,
    [13] = 24080,
    [14] = 29080,
    [15] = 35180,
    [16] = 42080,
    [17] = 49080,
    [18] = 57080,
    [19] = 62080,
    [20] = 69080,
}

local DiamondSteps = {
    [1] = 100,
    [2] = 100,
    [3] = 100,
    [4] = 100,
    [5] = 100,
    [6] = 100,
    [7] = 100,
    [8] = 100,
    [9] = 100,
    [10] = 100,
    [11] = 100,
    [12] = 100,
    [13] = 100,
    [14] = 100,
    [15] = 100,
    [16] = 100,
    [17] = 100,
    [18] = 100,
    [19] = 100,
    [20] = 100,
}

local CheckTracking = {}
local PlayerCodeInfo = {}

function GetTotalDiamondEarned(Steps)
    local Total = 0
    for i=1,Steps do
        Total = Total + DiamondSteps[i]
    end
    return Total
end

function lastLogin(Passport)
    if Passport then
        local rows = vRP.Query("accounts/getLastLogin",{ Passport = Passport })
        if rows[1] and rows[1]["login"] then
            return rows[1]["login"]
        else
            return os.time()
        end
    end
end

function codeExists(code)
    local queryResult = vRP.Query("player_code/GetCode", { code = code })
    return queryResult and queryResult[1]
end

function generateCode(name)
    local namePart = name:sub(1, math.min(5, #name))
    local randomPart = ""

    for i = 1, 5 do
        if math.random() > 0.5 then
            randomPart = randomPart .. tostring(math.random(0, 9))
        else
            randomPart = randomPart .. string.char(math.random(65, 90))
        end
    end

    local code = string.gsub(namePart .. randomPart, " ", ""):upper()

    return code
end


function CodeExist(Code)
    local Query = vRP.Query("player_code/GetCode",{ code = Code })
    if Query and Query[1] then
        return false
    end
    return Code
end

function GenerateCode(Passport)
    local maxAttempts = 100  -- Maximum attempts to generate a unique code
    local attempts = 0  -- Current attempt counter
    local Code = ""
    local Name = cleanString(vRP.FullName(Passport))

    -- Safeguard to prevent infinite loop
    repeat
        Code = cleanString(generateCode(Name))
        attempts = attempts + 1
        if attempts >= maxAttempts then
            print("Maximum attempts reached. Could not generate a unique code.")
            return
        end
        Wait(100)
    until not codeExists(Code)

    vRP.Query("player_code/Create", {code = Code, player = Passport, createdby = Passport})
    Wait(500)

    local Query = vRP.Query("player_code/GetAllUser", {player = Passport})
    if Query and Query[1] then
        local Info = {
            ["statistics"] = {
                ["diamonds"] = 0,
                ["followers"] = 0,
                ["todayDiamonds"] = 0,
                ["todayFollowers"] = 0,
            },
            ["followers"] = {},
            ["code"] = Query[1]["code"],
        }

        local TodayDiamonds = vRP.Query("player_code_steps_history/GetAllFromToday", {code = Query[1]["code"]})
        for _, diamond in ipairs(TodayDiamonds) do
            Info["statistics"]["todayDiamonds"] = Info["statistics"]["todayDiamonds"] + DiamondSteps[diamond["step"]]
        end

        local TodayFollowers = vRP.Query("player_code_uses/GetAllFromToday", {code = Query[1]["code"]})
        if TodayFollowers and TodayFollowers[1] and TodayFollowers[1]["total"] then
            Info["statistics"]["todayFollowers"] = TodayFollowers[1]["total"]
        end

        local Followers = vRP.Query("player_code_uses/GetAllCode", {code = Query[1]["code"]})
        for _, follower in ipairs(Followers) do
            local Table, Diamonds = GenerateFollower(follower["player"], follower)
            table.insert(Info["followers"], Table)
            Info["statistics"]["diamonds"] = Info["statistics"]["diamonds"] + Diamonds
        end

        Info["statistics"]["followers"] = #Followers
        PlayerCodeInfo[tostring(Passport)] = Info
    end
end


function GenerateFollower(Passport,Info)
    local Identity = vRP.Identity(Passport)
    local Account = vRP.Account(Identity["license"])
    local Diamonds = GetTotalDiamondEarned(Info["steps"])
    local Table = {
        ["date"] = os.date("%d/%m/%Y",Info["timestamp"]),
        ["diamonds"] = Diamonds,
        ["discord"] = Identity["discord"],
        ["name"] = Identity["name"].." "..Identity["name2"],
        ["lastLogin"] = os.date("%d/%m/%Y",lastLogin(Passport)),
        ["time"] = parseInt(Identity["tracking"]/60/60).."h",
    }
    return Table,Diamonds
end

function GetAllFromUser(Passport)
    local Query = vRP.Query("player_code/GetAllUser",{ player = Passport })
    if Query and Query[1] then
        local Info = {
            ["statistics"] = {
                ["diamonds"] = 0,
                ["followers"] = 0,
                ["todayDiamonds"] = 0,
                ["todayFollowers"] = 0,
            },
            ["followers"] = {},
            ["code"] = Query[1]["code"],
        }
        local TodayDiamonds = vRP.Query("player_code_steps_history/GetAllFromToday",{ code = Query[1]["code"] })
        for i=1,#TodayDiamonds do
            Info["statistics"]["todayDiamonds"] = Info["statistics"]["todayDiamonds"] + DiamondSteps[TodayDiamonds[i]["step"]]
        end
        local TodayFollowers = vRP.Query("player_code_uses/GetAllFromToday",{ code = Query[1]["code"] })    
        if TodayFollowers and TodayFollowers[1] and TodayFollowers[1]["total"] then
            Info["statistics"]["todayFollowers"] = TodayFollowers[1]["total"]
        end
        local Followers = vRP.Query("player_code_uses/GetAllCode",{ code = Query[1]["code"] })
        for i=1,#Followers do
            local Table,Diamonds = GenerateFollower(Followers[i]["player"],Followers[i])
            table.insert(Info["followers"],Table)
            Info["statistics"]["diamonds"] = Info["statistics"]["diamonds"] + Diamonds
        end
        Info["statistics"]["followers"] = #Followers
        PlayerCodeInfo[tostring(Passport)] = Info
    else
        GenerateCode(Passport)
    end
end

function Server.GetPlayerInfo()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Info = PlayerCodeInfo[tostring(Passport)] or {}
        if Info then
            return Info
        end
    end
end

function Server.GetInfluencer()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        return vRP.HasGroup(Passport, "Influ")
    end
end


-- CreateThread(function()
--     TriggerEvent("Connect",121,vRP.Source(121))
-- end)

AddEventHandler("Connect",function(Passport,source)
    local Query = vRP.Query("player_code_uses/GetAll",{ player = Passport })
    if Query and Query[1] then
        local Steps = Query[1]["steps"]
        local Identity = vRP.Identity(Passport)
        local Code = Query[1]["code"]
        if Identity and Identity["tracking"] then
            local Tracking = parseInt(Identity["tracking"]/60)
            for i = 1,#StepsTracking do
                if Tracking < StepsTracking[i] then
                    Steps = i-1
                    break
                else
                    Steps = i
                    if StepsTracking[Steps] and Tracking > StepsTracking[Steps] and Steps > Query[1]["steps"] then
                        local QueryCode = vRP.Query("player_code/Get",{ code = Code })
                        if QueryCode and QueryCode[1] then
                            local Player = QueryCode[1]["createdby"]
                            local License = vRP.License(Player)
                            vRP.Query("player_code_uses/updateSteps",{ player = Passport, steps = Steps })
                            vRP.Query("player_code_steps_history/Set",{ player = Passport, step = Steps, code = Code })
                            vRP.Query("accounts/AddGems",{ license = License, gems = DiamondSteps[Steps] })
                        end
                    end
                end
            end
        end
    end
    GetAllFromUser(Passport)
end)
vRP.Prepare("achievements/GetAllPlayerAchievements","SELECT * FROM player_achievements WHERE passport = @Passport")

vRP.Prepare("achievements/CompletePlayerAchievements","UPDATE player_achievements SET completed = current_timestamp() WHERE passport = @Passport and achievement = @Achievement")

vRP.Prepare("achievements/UpdateAchievementProgress","UPDATE player_achievements SET progress = @Progress WHERE passport = @Passport and achievement = @Achievement")

vRP.Prepare("achievements/RewardedPlayerAchievements","UPDATE player_achievements SET rewarded = current_timestamp() WHERE passport = @Passport and achievement = @Achievement")

vRP.Prepare("achievements/AddAchievement","INSERT INTO player_achievements (passport,achievement,completed,rewarded,progress) VALUES (@Passport,@Achievement,@Completed,@Rewarded,@Progress)")

vRP.Prepare("user_titles/GetPlayerTitles","SELECT * FROM user_titles WHERE passport = @Passport")

vRP.Prepare("user_titles/AddPlayerTitle","INSERT INTO user_titles (passport,title) VALUES (@Passport,@Title)")

vRP.Prepare("achievements/getTitlesName","SELECT * FROM achievements")

vRP.Prepare("achievements_group/getGroupsName","SELECT * FROM achievements_group")

vRP.Prepare("achievements/insertAchievements","INSERT INTO achievements(`group`,`name`,`description`,`rewards`,`title`,`progress`) VALUES(@group,@name,@description,@rewards,@title,@progress)")

vRP.Prepare("achievements_group/insertGroups","INSERT INTO achievements_group (`group`) VALUES (@group)")

PlayerAchievements = {}
PlayerTitles = {}

function vRP.GetAchievementStatus(Achievement)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if PlayerAchievements[Passport] and PlayerAchievements[Passport][Achievement] then
            return PlayerAchievements[Passport][Achievement]
        end
    end
    return false
end

function vRP.RewardAchievement(Passport,Achievement)
    if Passport then
        if PlayerAchievements[Passport] and PlayerAchievements[Passport][Achievement] then
            local Table = PlayerAchievements[Passport][Achievement]
            if not Table["rewarded"] then
                local Reward = Achievements[Achievement]["Rewards"]
                vRP.Query("achievements/RewardedPlayerAchievements",{ Passport = Passport, Achievement = Achievement })
                PlayerAchievements[Passport][Achievement]["rewarded"] = true
                local Rewards = Achievements[Achievement]["Rewards"]
                for i=1,#Rewards do
                    local Type = Rewards[i]["type"]
                    local Value = Rewards[i]["name"]
                    local Amount = Rewards[i]["amount"]
                    AchievementsFunctions[Type](Passport,Value,Amount)
                end
            end
        end
    end
end

function vRP.AddProgress(Passport,Number)
    local Passport = vRP.Passport(source)
    if Passport then
        if PlayerAchievements[Passport] and PlayerAchievements[Passport][Achievement] then
            local Table = PlayerAchievements[Passport][Achievement]
            local Progress = Table["progress"]
            local MaxProgress = Achievements[Number]["Progress"]
            if Progress < MaxProgress then
                local NewProgress = Progress + Number
                if NewProgress > MaxProgress then
                    NewProgress = MaxProgress
                end
                vRP.Query("achievements/UpdateAchievementProgress",{ Passport = Passport, Achievement = Achievement, Progress = NewProgress })
                PlayerAchievements[Passport][Achievement]["progress"] = NewProgress
            else
                vRP.Query("achievements/CompletePlayerAchievements",{ Passport = Passport, Achievement = Achievement })
                PlayerAchievements[Passport][Achievement]["completed"] = true
            end
        else
            vRP.Query("achievements/AddAchievement",{ Passport = Passport, Achievement = Achievement, Progress = Number })
            PlayerAchievements[Passport][Achievement] = { ["progress"] = Number }
        end
    end
end


AddEventHandler("Connect",function(Passport,Source)
    local Query = vRP.Query("achievements/GetAllPlayerAchievements",{ Passport = Passport })
    if Query and Query[1] then
        local Info = {}
        for i=1,#Query do
            local Table = Query[i]
            Info[Table["achievement"]] = Query[i]
            if Table["completed"] then
                Info[Table["achievement"]]["completed"] = true
            end
            if Table["rewarded"] then
                Info[Table["achievement"]]["rewarded"] = true
            end
        end
        PlayerAchievements[Passport] = Info
    end
    local Query = vRP.Query("user_titles/GetPlayerTitles",{ Passport = Passport })
    if Query and Query[1] then
        local Info = {}
        for i=1,#Query do
            local Table = Query[i]
            table.insert(Info,Table["title"])
        end
        PlayerTitles[Passport] = Info
    end
    TriggerClientEvent("hub:Achievements",Source,PlayerAchievements[Passport])
    TriggerClientEvent("hub:Titles",Source,PlayerTitles[Passport])
end)

AddEventHandler("Disconnect",function(Passport)
    if PlayerAchievements[Passport] then
        PlayerAchievements[Passport] = nil
    end
end)

function vRP.GiveTitle(Passport,Title)
    local Source = vRP.Source(Passport)
    if Passport then
        if PlayerTitles[Passport] then
            vRP.Query("user_titles/AddPlayerTitle",{ Passport = Passport, Title = Title })
            table.insert(PlayerTitles[Passport],Title)
            if Source then
                TriggerClientEvent("hub:Titles",Source,PlayerTitles[Passport])
            end
        else
            vRP.Query("user_titles/AddPlayerTitle",{ Passport = Passport, Title = Title })
            PlayerTitles[Passport] = { Title }
            if Source then
                TriggerClientEvent("hub:Titles",Source,PlayerTitles[Passport])
            end
        end
    end
end


AchievementsFunctions = {
    ["Item"] = function(Passport,Item,Amount)
        vRP.GenerateItem(Passport,Item,Amount,true,false,"Achievement")
    end,
    ["Vehicle"] = function(Passport,Vehicle,Amount)
        if Amount > 1 then
            vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = Vehicle, rental = 60*60*24*Amount, plate = vRP.GeneratePlate(), work = "false" })
        else
            vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Vehicle, plate = vRP.GeneratePlate(), work = "false" })
        end
    end,
    ["Bank"] = function(Passport,Bank,Amount)
        vRP.giveBankMoney(Passport,Amount)
    end,
}

CreateThread(function()
    Wait(1000)
    local ExistGroups = {}
    local ExistAchievements = {}

    local QueryAchievements = vRP.Query("achievements/getTitlesName")
    for i=1,#QueryAchievements do
        local Name = QueryAchievements[i]["name"]
        if not ExistAchievements[Name] then
            ExistAchievements[Name] = true
        end
    end
    local QueryGroups = vRP.Query("achievements_group/getGroupsName")
    for i=1,#QueryGroups do
        local Name = QueryGroups[i]["group"]
        if not ExistGroups[Name] then
            ExistGroups[Name] = true
        end
    end
    
    for i=1,#AchievementsGroups do
        if not ExistGroups[AchievementsGroups[i]] then
            vRP.Query("achievements_group/insertGroups", { group = AchievementsGroups[i] })
        end
    end

    for i=1, #Achievements do
        local Achievement = Achievements[i]
        if not ExistAchievements[Achievement.Name] then
            vRP.Query("achievements/insertAchievements", {
                group = Achievement.GroupID,
                name = Achievement.Name,
                description = Achievement.Description,
                rewards = json.encode(Achievement.Rewards),
                title = Achievement.Title,
                progress = Achievement.Progress
            })
        end
    end
end)

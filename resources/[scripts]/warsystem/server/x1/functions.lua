function GetAmountPlayersX1(LobbyId)
    local Count = 0
    local Best = false
    local Worst = false
    if Infox1[LobbyId]["RoundDone"] then
        return false
    end
    if not Infox1[LobbyId] or not Infox1[LobbyId]["Teams"] then
        return false
    end
    for Group,Table in pairs(Infox1[LobbyId]["Teams"]) do
        local Alive = 0
        for i=1,#Table["Players"] do
            local Source = parseInt(Table["Players"][i])
            if vRP.GetHealth(Source) and vRP.GetHealth(Source) > 100 then
                Alive = Alive + 1
            end
        end
        
        if Alive == 0 then
            Worst = Group
        else
            Best = Group
        end
    end
    if Worst then
        return Best
    else
        return false
    end
end

local MaxRoundsX1 = 10
function AddPointX1(LobbyId,Group)
    if LobbyId and Group and Infox1[LobbyId] and Infox1[LobbyId]["Teams"][Group] and Infox1[LobbyId]["Teams"][Group]["Score"]  then
        Infox1[LobbyId]["Teams"][Group]["Score"] = Infox1[LobbyId]["Teams"][Group]["Score"] + 1
        Infox1[LobbyId]["Rounds"] = Infox1[LobbyId]["Rounds"] + 1
        Infox1[LobbyId]["RoundDone"] = false
        if Infox1[LobbyId]["Teams"][Group]["Score"] >= MaxRoundsX1 then
            local GroupWinner = Group
            local Winner = false
            local Loser = false
            local TableNotify = {}
            local ResultTable = {}
            for Group,Table in pairs(Infox1[LobbyId]["Teams"]) do
                for i=1,#Table["Players"] do
                    local Source = parseInt(Table["Players"][i])
                    local Passport = vRP.Passport(Source)
                    if Passport then
                        if GroupWinner == Group then
                            Winner = Passport
                            ResultTable["Winner"] = Passport.." | "..vRP.FullName(Passport)
                        else
                            ResultTable["Loser"] = Passport.." | "..vRP.FullName(Passport)
                            Loser = Passport
                        end
                        if Source then
                            table.insert(TableNotify,Source)
                        end
                        vRP.ApplyTemporary(Passport,Source)
                        local Ped = GetPlayerPed(Source)
                        if Ped ~= 0 and DoesEntityExist(Ped) then
                            SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                            RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                            TriggerClientEvent("1x1:Finish",Source)
                        end
                    end
                end
            end
            vRP.Query("rank_1x1/InsertWinner",{ winner = Winner, loser = Loser})
            local Custom = {
                background = "rgba(10,10,44,.75)",
            }
            Wait(2000)
            for i=1,#TableNotify do
                local Source = parseInt(TableNotify[i])
                local Message = "O jogador <b>"..ResultTable["Winner"].."</b> ganhou o x1 contra <b>"..ResultTable["Loser"].."</b>!"
                Player(Source)["state"]["1x1"] = false
                TriggerClientEvent("Notify",Source,"vermelho",Message,5000,"1x1")
            end
            Infox1[LobbyId] = {}
        else
            UpdateClientInfoX1(LobbyId)
            StartRoundX1(LobbyId)
        end 
    end
end

function PreStartRoundX1(LobbyId,Start)
    UpdateClientInfoX1(LobbyId)
    for Group,Table in pairs(Infox1[LobbyId]["Teams"]) do
        async(function()
            for i=1,#Table["Players"] do
                async(function()
                    local Source = Table["Players"][i]
                    local Passport = vRP.Passport(Source)
                    TriggerClientEvent("1x1:PreStart",Source,Group,Infox1[LobbyId]["Info"],Infox1[LobbyId]["Teams"][Group]["Name"],Infox1[LobbyId]["Type"])
                    if Start then
                        vRP.SaveTemporary(Passport,Source,Infox1[LobbyId]["Bucket"],"Event_Pistol")
                        exports["vrp"]:ChangePlayerBucket(Source,Infox1[LobbyId]["Bucket"])
                    end
                    Player(Source)["state"]["1x1"] = true
                    Wait(2500)
                    exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
                end)
            end
        end)
    end
end

function StartRoundX1(LobbyId,Start)
    if Infox1[LobbyId] and Infox1[LobbyId]["Teams"] then
        UpdateClientInfoX1(LobbyId)
        for Group,Table in pairs(Infox1[LobbyId]["Teams"]) do
            async(function()
                for i=1,#Table["Players"] do
                    async(function()
                        local Source = Table["Players"][i]
                        local Passport = vRP.Passport(Source)
                        TriggerClientEvent("1x1:Start",Source,Group,Infox1[LobbyId]["Info"],Infox1[LobbyId]["Teams"][Group]["Name"],Infox1[LobbyId]["Type"])
                        if Start then
                            vRP.SaveTemporary(Passport,Source,Infox1[LobbyId]["Bucket"],"Event_Pistol")
                        end
                        exports["vrp"]:ChangePlayerBucket(Source,Infox1[LobbyId]["Bucket"])
                        Player(Source)["state"]["1x1"] = true
                        Wait(2500)
                        exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
                    end)
                end
            end)
        end
        if Start and Infox1[LobbyId] and Infox1[LobbyId]["Spectate"] then
            for i=1,#Infox1[LobbyId]["Spectate"] do
                async(function()
                    local Source = Infox1[LobbyId]["Spectate"][i]
                    TriggerClientEvent("1x1:Update",Source,Infox1[LobbyId]["Info"])
                end)
            end
        end
    end
end

function UpdateClientInfoX1(LobbyId)
    local Table = {}
    if Infox1[LobbyId] and Infox1[LobbyId]["Teams"] then
        for Group,Players in pairs(Infox1[LobbyId]["Teams"]) do
            if not Table["myTeam"] then
                Table["myTeam"] = {
                    name = Infox1[LobbyId]["Teams"][Group]["Name"],
                    score = Infox1[LobbyId]["Teams"][Group]["Score"],
                }
            else
                Table["theirTeam"] = {
                    name = Infox1[LobbyId]["Teams"][Group]["Name"],
                    score = Infox1[LobbyId]["Teams"][Group]["Score"],
                }
            end
        end
        Infox1[LobbyId]["Info"] = Table
        for Group,Table in pairs(Infox1[LobbyId]["Teams"]) do
            async(function()
                for i=1,#Table["Players"] do
                    async(function()
                        local Source = Table["Players"][i]
                        TriggerClientEvent("1x1:Update",Source,Infox1[LobbyId]["Info"])
                    end)
                end
            end)
        end
        if Infox1[LobbyId]["Spectate"] then
            for i=1,#Infox1[LobbyId]["Spectate"] do
                async(function()
                    local Source = Infox1[LobbyId]["Spectate"][i]
                    TriggerClientEvent("1x1:Update",Source,Infox1[LobbyId]["Info"])
                end)
            end
        end
    end
end
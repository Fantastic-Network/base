function GetPassportString(String,EventId,Team)
    numbers = {}
    for number in string.gmatch(String, '([^,]+)') do
        local Passport = parseInt(number)
        local Source = vRP.Source(Passport)
        if Source then
            if Team then
                PlayersEvent[tostring(Source)] = {Team = Team, EventId = EventId}
                PlayerKills[tostring(Source)] = 0
            else
                PlayersEventSpectate[tostring(Source)] = {EventId = EventId}
            end
            table.insert(numbers, Source)
        end
    end
    return numbers
end

function GetAmountPlayersEvent(EventId)
    local Count = 0
    local Best = false
    local Worst = false
    if Event[EventId]["RoundDone"] then
        return false
    end
    if not Event[EventId] or not Event[EventId]["Teams"] then
        return false
    end
    for Group,Table in pairs(Event[EventId]["Teams"]) do
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

function RemPoint(EventId,Group)
    if EventId and Group then
        Event[EventId]["Teams"][Group]["Score"] = Event[EventId]["Teams"][Group]["Score"] - 1
        Event[EventId]["Rounds"] = Event[EventId]["Rounds"] - 1
        UpdateClientInfoEvent(EventId)
    end
end

function AddPoint(EventId,Group)
    if EventId and Group and Event[EventId] and Event[EventId]["Teams"][Group] and Event[EventId]["Teams"][Group]["Score"]  then
        Event[EventId]["Teams"][Group]["Score"] = Event[EventId]["Teams"][Group]["Score"] + 1
        Event[EventId]["Rounds"] = Event[EventId]["Rounds"] + 1
        Event[EventId]["RoundDone"] = false
        if Event[EventId]["Teams"][Group]["Score"] >= Event[EventId]["MaxRounds"] then
            for Group,Table in pairs(Event[EventId]["Teams"]) do
                for i=1,#Table["Players"] do
                    local Source = parseInt(Table["Players"][i])
                    local Passport = vRP.Passport(Source)
                    vRP.ApplyTemporary(Passport,Source)
                    local Ped = GetPlayerPed(Source)
                    if Ped ~= 0 and DoesEntityExist(Ped) then
                        SetPedAmmo(Ped,GetSelectedPedWeapon(Ped),0)
                        RemoveWeaponFromPed(Ped,GetSelectedPedWeapon(Ped))
                        TriggerClientEvent("event:Finish",Source)
                    end
                    --EndSpectateEvent(Sourcen)
                end
            end
            for i=1,#Event[EventId]["Spectate"] do
                async(function()
                    local Source = Event[EventId]["Spectate"][i]
                    TriggerClientEvent("event:Finish",Source)
                end)
            end

            local Custom = {
                background = "rgba(10,10,44,.75)",
            }
            Wait(2000)
            TriggerClientEvent("chat:ClientMessage",-1,"O time",""..Event[EventId]["Teams"][Group]["Name"].." venceu o evento "..Event[EventId]["Name"]..".","FFA",false,Custom)	
            Wait(2000)
            Event[EventId] = {}
        else
            UpdateClientInfoEvent(EventId)
            StartRound(EventId)
        end 
    end
end

function PreStartRound(EventId,Start)
    UpdateClientInfoEvent(EventId)
    for Group,Table in pairs(Event[EventId]["Teams"]) do
        async(function()
            for i=1,#Table["Players"] do
                async(function()
                    local Source = Table["Players"][i]
                    local Passport = vRP.Passport(Source)
                    TriggerClientEvent("event:PreStart",Source,Group,Event[EventId]["Info"],Event[EventId]["Teams"][Group]["Name"],Event[EventId]["Type"])
                    if Start then
                        vRP.SaveTemporary(Passport,Source,Event[EventId]["Bucket"],"Event_Pistol")
                        exports["vrp"]:ChangePlayerBucket(Source,Event[EventId]["Bucket"])
                    end
                    Player(Source)["state"]["Event"] = true
                    Wait(2500)
                    exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
                end)
            end
        end)
    end
end

function StartRound(EventId,Start)
    UpdateClientInfoEvent(EventId)
    for Group,Table in pairs(Event[EventId]["Teams"]) do
        async(function()
            for i=1,#Table["Players"] do
                async(function()
                    local Source = Table["Players"][i]
                    local Passport = vRP.Passport(Source)
                    TriggerClientEvent("event:Start",Source,Group,Event[EventId]["Info"],Event[EventId]["Teams"][Group]["Name"],Event[EventId]["Type"])
                    if Start then
                        vRP.SaveTemporary(Passport,Source,Event[EventId]["Bucket"],"Event_Pistol")
                    end
                    exports["vrp"]:ChangePlayerBucket(Source,Event[EventId]["Bucket"])
                    Player(Source)["state"]["Event"] = true
                    Wait(2500)
                    exports["inventory"]:putWeaponHands(Source,"WEAPON_PISTOL_MK2",250,{},false)
                end)
            end
        end)
    end
    if Start and Event[EventId] and Event[EventId]["Spectate"] then
        for i=1,#Event[EventId]["Spectate"] do
            async(function()
                local Source = Event[EventId]["Spectate"][i]
                TriggerClientEvent("event:Update",Source,Event[EventId]["Info"])
            end)
        end
    end
end

function UpdateClientInfoEvent(EventId)
    local Table = {}
    if Event[EventId] and Event[EventId]["Teams"] then
        for Group,Players in pairs(Event[EventId]["Teams"]) do
            if not Table["myTeam"] then
                Table["myTeam"] = {
                    name = Event[EventId]["Teams"][Group]["Name"],
                    score = Event[EventId]["Teams"][Group]["Score"],
                }
            else
                Table["theirTeam"] = {
                    name = Event[EventId]["Teams"][Group]["Name"],
                    score = Event[EventId]["Teams"][Group]["Score"],
                }
            end
        end
        Event[EventId]["Info"] = Table
        for Group,Table in pairs(Event[EventId]["Teams"]) do
            async(function()
                for i=1,#Table["Players"] do
                    async(function()
                        local Source = Table["Players"][i]
                        TriggerClientEvent("event:Update",Source,Event[EventId]["Info"])
                    end)
                end
            end)
        end
        if Event[EventId]["Spectate"] then
            for i=1,#Event[EventId]["Spectate"] do
                async(function()
                    local Source = Event[EventId]["Spectate"][i]
                    TriggerClientEvent("event:Update",Source,Event[EventId]["Info"])
                end)
            end
        end
    end
end
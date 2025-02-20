function GetPlayerTokens(Source)
    local Tokens = GetNumPlayerTokens(Source)
    local Table = {}

    for i=0,Tokens do
        Table[#Table+1] = GetPlayerToken(Source, i)
    end
    local Info = exports["vrp"]:filterPlayerHwids(Table)
    return Info["validHwidsArray"]
end

function CheckPlayerTokens(Source)
    local IsBanned = false
    local Tokens = GetPlayerTokens(Source)
    for i=1,#Tokens do
        local Token = Tokens[i]
        local Query = vRP.Query("banneds_hwid/getRHwid",{ token = Token })
        if Query and Query[1] then
            IsBanned = Query[1]["reason"] or "Not Listed"
        end
    end
    return IsBanned
end

function SetPlayerTokens(Source,accountId)
    local Tokens = GetPlayerTokens(Source)
    local IsBanned = false
    for i=1,#Tokens do
        local Token = Tokens[i]
        vRP.Query("banneds_hwid/setHwid",{ Token,accountId })
    end
    return Tokens
end

AddEventHandler("Connect",function(Passport,Source)
    local License = vRP.Identities(Source)
    local Account = vRP.Account(License)
    local ip = GetPlayerEndpoint(Source)
    Wait(50)
    if Account and Account["id"] then
        if Account["discord"] ~= "0" then
            local BannedDiscord = false
            local Discords = vRP.Query("banneds_hwid/CheckRDiscord",{ Account["discord"] })
            for i=1,#Discords do
                if Discords[i]["id"] and tostring(Discords[i]["id"]) ~= "0" then
                    if vRP.Banned(Discords[i]["id"]) then
                        BannedDiscord = true
                        exports["vrp"]:SendWebHook("hwid","```prolog\n[ACCOUNT ID ANTIGO]: "..Discords[i]["id"].."\n[ACCOUNT ID NOVA]: "..Account["id"].."\n[BANIDO HWID_3]\n" ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```")
                    end
                end
            end
            -- if BannedDiscord then
            --     vRP.Query("banneds/InsertBanned",{ accountId = Account["id"], reason = "HWID_3" })
            --     DropPlayer(Source,"Voce está banido por HWID")
            -- end
        end 
        
        -- if ip and ip ~= "" then
        --     local Query = vRP.Query("banned_ip/CheckRIP",{ ip })
        --     if Query and Query[1] then
        --         exports["vrp"]:SendWebHook("hwid","```prolog\n[ACCOUNT ID]: "..Account["id"].."\n[BANIDO HWID_2]\n" ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```")
        --         vRP.Query("banneds/InsertBanned",{ accountId = Account["id"], reason = "HWID_2" })
        --         DropPlayer(Source,"Voce está banido por HWID")
        --     end
        -- end
        
        if License then
            local Query = vRP.Query("global_banned/RGet",{ License })
            if Query[1] then
                vRP.Query("banneds/InsertBanned",{ accountId = Account["id"], reason = "Global" })
                exports["vrp"]:SendWebHook("ban","**Aplicou:** 0\n**Recebeu:** "..Account["discord"].."\n**Account id:** "..Account["id"].."\n\n**Passaporte:** 0\n**Deu ban:** "..Passport.."\n**Account id:** "..Account["id"].."\n**Motivo:** Global\n**Seleção:** Global\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                DropPlayer(Source,"Banido.")
            end
        end
    end

end)

function vRP.setBanned(user_id, status, reason, author)
    if user_id then
        local Identity = vRP.Identity(user_id)
        if Identity then
            local Account = vRP.Account(Identity["license"])
            if Account and Account["id"] then
                vRP.Query("banneds/InsertBanned",{ accountId = Account["id"], reason = author })
                return true
            end
        end
    end
    print("Erro ao banir: ", user_id, author)
end
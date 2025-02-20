--[=[
---@param source    Source
---@param actions   BeforePlayerConnectActions
---@param done      fun( data : BeforePlayerConnectResultAllowed ): nil | fun( failureReason: string ): nil
local function HandleBeforePlayerConnectEvent( source, done )

    --CheckAmountPlayers()

    local licenseId = vRP.Identities(source)

    --if cityName ~= "Base" then
        if AccountConnected[licenseId] and not DebugMode == "true" then
            return done("Esta conta já está conectada no servidor.")
        end
    --end

    local Account = vRP.Account(licenseId)
    local CheckTokens = CheckPlayerTokens(source)

    if CheckTokens then
        local Information = "N/A"
        if Account and Account["id"] then
            Information = Account["id"]
        else
            Information = "BAN ID"..CheckTokens
        end

        return done( "Você está banido HWID ID: "..Information )
    end

    if not licenseId then
        return done("Servidor lotado. Tente novamente!")
    end

    local account = vRP.Account(licenseId)

    if not account then
        vRP.Query("accounts/newAccount",{ license = licenseId })
        vRP.GenerateToken(licenseId)

        Wait(100)

        account = vRP.Account(licenseId)

        vRP.Query("new_player/setNewAction", { id = account["id"], action = GetNewPlayerNumber("Connect") })

        local IP = GetPlayerEndpoint(source)

        if IP then
            PerformHttpRequest("http://pro.ip-api.com/json/"..IP.."?key=chH9lkwpF3PQxYd", function(err, text, headers)
                vRP.Query("accounts/setIPInfo", { accountId = account["id"], ip = text})
            end, 'GET', '')
        end
    end

    vRP.checkTemporaryBan(account["id"])

    if Maintenance and not MaintenanceLicenses[licenseId] then
        return done(MaintenanceText)
    end

    if vRP.Banned(account["id"]) then
        return done("Você foi banido do(a) "..cityName..". ID: "..account["id"]..".")
    end

    if Whitelisted and not account["whitelist"] then
        return done("Você não possui WL. Entre em nosso discord e faça o processo de liberação: "..CityDiscord[cityName]..".\nID: "..account["id"])
    end

    AccountConnected[licenseId] = true
    Accounts[source] = account["id"]

    if account["token"] then
        Player(source)["state"]["Token"] = account["token"]
    end

    vRP.Query("accounts/updateAmountLogins", { license = licenseId })

    local activation = vRP.Query("new_player/getExistAction", { id = account["id"], action = GetNewPlayerNumber("Activation") })
    
    if not activation[1] then
        firstActivation[account["id"]] = os.time()
    end

    local IP = GetPlayerEndpoint(source) or ""

    PerformHttpRequest("http://shield-direct.ecxon.com.br/direct.php?authKey=8oWiLsK036rOZ9P7nXFAjd6y&ip="..IP,function(err,text,headers) end,"POST",json.encode({
        ip = IP,
    }),{ ["Content-Type"] = "application/json" })

    local orderPriority = 0

    if vRP.LicensePremium( licenseId ) then
        orderPriority = 10
    end

    if vRP.LicenseAdmin( licenseId ) then
        orderPriority = 90
    end

    orderPriority = math.max( orderPriority, account['priority'] )

    --[[ TODO: Reutilizar os valores de orderPriority das queries anteriories ]]

    return done({
        userId        = account['id'],
        orderPriority = orderPriority
    })
end

AddEventHandler( 'beforePlayerConnect', HandleBeforePlayerConnectEvent )
--]=]

-- ---@param source    Source
-- ---@param done      fun( data : BeforePlayerConnectResultAllowed ): nil | fun( failureReason: string ): nil
-- local function HandleBeforePlayerConnectEventDummy( source, done )

--     done({ userId = source + 1, orderPriority = 2 })
-- end

-- AddEventHandler( 'beforePlayerConnect', HandleBeforePlayerConnectEventDummy )
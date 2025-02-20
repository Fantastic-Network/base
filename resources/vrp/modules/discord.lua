local cityName = GetConvar("cityName","Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(1000)
    Discords = exports["variables"]:GetDiscords()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
local DiscordQueue = {}
local SendWebHookTime = {}

function PerformHttpRequestWithRateLimit(Url,Data)
    PerformHttpRequest(Url, function(code, data, headers)
        responseCode = code
        responseBody = data
        responseHeaders = headers
    end,"POST",
    json.encode({
        username = "Base",
        embeds = { { color = Data["Color"], description = Data["Message"] } }
    }),{ ["Content-Type"] = "application/json" })

    while not responseCode do
        Wait(100)
    end
    if responseCode == 429 and responseHeaders["retry-after"] then
        local retryAfter = tonumber(responseHeaders["retry-after"])
        if retryAfter then
            Wait(retryAfter * 1000)
            return PerformHttpRequestWithRateLimit(Url,Data)
        end
    elseif responseHeaders["x-ratelimit-remaining"] and responseHeaders["x-ratelimit-reset"] then
        local remainingRequests = tonumber(responseHeaders["x-ratelimit-remaining"])
        local resetTime = tonumber(responseHeaders["x-ratelimit-reset"])

        if remainingRequests == 0 and resetTime then
            local currentTime = os.time()
            local waitTime = resetTime - currentTime

            if waitTime > 0 then
                Wait(waitTime * 1000)
                return PerformHttpRequestWithRateLimit(Url,Data)
            end
        end
    end

    return responseCode, responseBody, responseHeaders
end

function SendWebHook(Hook,Message,Color,Users)
    local BlackListed = false
    if Users then
        for i=1,#Users do
            if Users[i] then
                local Passport = parseInt(Users[i])
                local Identity = vRP.Identity(Passport)
                if Identity and Identity["license"] then
                    local License = Identity["license"]
                    if exports["variables"]:GetLicenses("Rem")[License] then
                        BlackListed = true
                        return
                    end
                end
            end
        end
    end
    if BlackListed then
        return
    end
    if not Color then Color = 9317187 end
    if Discords[cityName] and Discords[cityName][Hook] then
        -- table.insert(DiscordQueue[Hook],{ Message = Message, Color = Color, Time = os.time() })
        PerformHttpRequestWithRateLimit(Discords[cityName][Hook],{ Message = Message, Color = Color, Time = os.time() })
    end
end
exports("SendWebHook", SendWebHook)

function UpdateWebHook(Hook,Link)
    Discords[cityName][Hook] = Link
end
exports("UpdateWebHook",UpdateWebHook)
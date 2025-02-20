local gIsAirdropSystemActive = false

---@param networkTime number
---@param airdrop       Airdrop
---@param playerPedId   number
---@param focusPos      vector3
local function TickAirdrop( networkTime, airdrop, playerPedId, focusPos )

    if not CanAirdropBeStreamedIn( airdrop, focusPos ) then

        StopAirdropStreamIn( airdrop )

        return
    end
    
    if not StartAirdropStreamIn(airdrop) then
        return
    end

    UpdateStreamedInAirdrop( airdrop, networkTime )
end

---@return boolean
local function TickAirdropSystem()
    local airdrops = GetAirdrops()

    -- print('TickAirdropSystem', #airdrops)

    if #airdrops <= 0 then
        return false
    end

    local playerPedId = PlayerPedId()
    local playerPedPos = GetEntityCoords( playerPedId )

    local networkTime = GetNetworkTime()

    for _, airdrop in ipairs( airdrops ) do
        -- pcall(function()
            TickAirdrop(  networkTime, airdrop, playerPedId, playerPedPos )
        -- end)
    end

    return true
end

function EnsureAirdropSystem()
    if gIsAirdropSystemActive then
        return
    end

    gIsAirdropSystemActive = true

    CreateThread(function()
        while gIsAirdropSystemActive do
            Wait(0)

            if not TickAirdropSystem() then
                break
            end
        end

        gIsAirdropSystemActive = false
    end)
end

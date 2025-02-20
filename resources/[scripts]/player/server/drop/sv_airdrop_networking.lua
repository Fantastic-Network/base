function UpdateAirdropsGlobalState()

    ---@type AirdropId[]
    local airdropsIds = { }

    for _, airdrop in ipairs( GetAirdrops() ) do
        table.insert( airdropsIds, airdrop.id )
    end

    local value = #airdropsIds > 0 and airdropsIds or nil

    GlobalState:set( 'airdrops', value, true )
end

---@param airdrop ServerAirdrop
function UpdateAirdropIsOpeningGlobalState( airdrop )
    GlobalState:set( ('airdrop:%d:isOpening'):format(airdrop.id), airdrop.isOpening and true or nil, true )
end

---@param airdrop ServerAirdrop
function UpdateAirdropGlobalState( airdrop )

    ---@type PackedNetworkAirdrop
    local data = { airdrop.positionEnd, airdrop.timeCreated }

    GlobalState:set( ('airdrop:%d'):format(airdrop.id), data, true )

    UpdateAirdropIsOpeningGlobalState( airdrop )
end

---@param airdropId AirdropId
function ClearAirdropGlobalState( airdropId )
    GlobalState:set( ('airdrop:%d'          ):format(airdropId), nil, true )
    GlobalState:set( ('airdrop:%d:isOpening'):format(airdropId), nil, true )
end

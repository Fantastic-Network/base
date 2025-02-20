local gAirdropsStateBagHandlerCookies = { }

---@param airdropId AirdropId
---@return NetworkAirdrop | nil
local function GetAirdropGlobalState( airdropId )

    ---@type PackedNetworkAirdrop
    local packed = GlobalState[ ('airdrop:%d'):format(airdropId) ]

    ---@type NetworkAirdrop
    local state =
    {
        positionEnd = packed[1],

        timeCreated = packed[2],
    }

    return state
end

---@param airdropId AirdropId
---@return boolean
local function HasAirdropGlobalState( airdropId )
    return GlobalState[ ('airdrop:%d'):format(airdropId) ] ~= nil
end

---@param value true | nil
local function OnAirdropIsOpeningGlobalStateChanged(airdropId, value)
    if not HasAirdrop( airdropId ) then
        return
    end

    local airdrop = GetClientAirdrop( airdropId )

    SetClientAirdropAsOpening( airdrop, value and true or false )
end

---@param value AirdropId[] | nil
local function OnAirdropsGlobalStateChanged(value)

    for _, airdrop in ipairs( GetAirdrops() ) do

        local airdropId = airdrop.id

        xpcall(
            function ()

                --[[ O GlobalState desse airdrop foi removido? então ele não existe mais! ]]
                if not HasAirdropGlobalState( airdropId )  then
                    DeleteClientAirdrop( airdrop )

                    local cookies = gAirdropsStateBagHandlerCookies[airdropId]

                    for _, cookie in ipairs(cookies) do
                        RemoveStateBagChangeHandler( cookie )
                    end
                end
            end,
            function( err )
                print( ('^1Ocorreu um error enquanto tentava remover o Airdrop com id=%d.\n%s^7'):format( airdropId, err ) )
            end
        )
    end

    for _, airdropId in ipairs( value or { } ) do
        -- airdropsIdsMap[airdropId] = true

        xpcall(
            function ()
            
                --[[ Esse airdrop já existe localmente? ]]
                if not HasAirdrop( airdropId ) then

                    --[[ Esse airdrop não existe localmente, vamos criar-lo! ]]

                    local state = GetAirdropGlobalState( airdropId )

                    assert( state, ('Airdrop with id=%d has not state on GlobalState'):format( airdropId ) )

                    CreateClientAirdrop( airdropId, state.positionEnd, state.timeCreated, state.isOpening )

                    local cookies =
                    {
                        AddStateBagChangeHandler( ('airdrop:%d:isOpening'):format(airdropId), 'global', function(bagName, key, value, reserved, replicated)
                            OnAirdropIsOpeningGlobalStateChanged(airdropId, value)
                        end)
                    }

                    gAirdropsStateBagHandlerCookies[airdropId] = cookies
                end
            end,
            function( err )
                print( ('^1Ocorreu um error enquanto tentava adicionar o Airdrop com id=%d.\n%s^7'):format( airdropId, err ) )
            end
        )
    end
end

AddStateBagChangeHandler('airdrops', 'global', function(bagName, key, value, reserved, replicated)
    OnAirdropsGlobalStateChanged(value)
end)
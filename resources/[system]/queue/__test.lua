local DUMMY_NAME_DICTIONARY =
{
    'key',
    'value',
    'klan',
    'tu',
    'TI',
    'AGO',
    'NOVEMBER'
}

---@param source        Source
---@param playerName    string
---@return Deferrals
local function CreateDummyPlayerDeferrals( source, playerName )

    ---@type Deferrals
---@diagnostic disable-next-line: missing-fields
    local deferrals = { }

    function deferrals.defer()
    end

    function deferrals.update( message )
        logger.debug( ('[DEFERRALS] source="%s" playerName="%s" update -> "%s"'):format( source, playerName, message ) )
    end

    function deferrals.presentCard( card, cb )
    end

    function deferrals.done( failureReason )
        logger.debug( ('[DEFERRALS] source="%s" playerName="%s" done -> allowed="%s" failureReason = "%s"'):format( source, playerName, failureReason == nil, failureReason ) )
    end

    function deferrals.handover( data )
    end

    return deferrals
end

local function StartDummyPlayerConnection( source )

    ---@type Source
    -- local source = tostring( math.random(60000, 65000) )

    source = tostring( source )

    local playerName = DUMMY_NAME_DICTIONARY[ math.random( #DUMMY_NAME_DICTIONARY ) ]

    local deferrals = CreateDummyPlayerDeferrals( source, playerName )

    TriggerEvent('playerConnecting', playerName, nil, deferrals, source )

    return source
end

local function StartDummyPlayerJoining( tempSource, source )

    -- local source = tostring( math.random(0, 50000) )

    tempSource = tostring( tempSource )

    source = tostring( source )

    TriggerEvent('playerJoining', tempSource, source )
end

CreateThread(function ()

    local dummyPlayersJoining = { }

    for i = 1, MAX_NUM_QUEUE_ENTRIES do
        local dummySource = StartDummyPlayerConnection( i )

        if math.random() <= 0.5 then

            table.insert( dummyPlayersJoining, dummySource )
        end
    end

    Citizen.SetTimeout( 1000, function ()

        for _, dummySource in ipairs( dummyPlayersJoining ) do

            StartDummyPlayerJoining( dummySource, 65000 - dummySource )
        end
    end)
end)
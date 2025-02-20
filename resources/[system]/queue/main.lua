
---@param scope string
function QUEUE_PROFILER_SCOPE_BEGIN( scope )
    ProfilerEnterScope( scope .. '[@queue]' )
end

function QUEUE_PROFILER_SCOPE_END()
    ProfilerExitScope()
end

--[[ Não re-alocar o handover toda vez, caso não tenha necessidade ]]
DEFAULT_HANDOVER =
{
    cityName = SERVER__CITY__NAME,
}

---@param deferrals     Deferrals
---@param _dummySource  Source? -- Só é usado para testes
local function HandlePlayerConnectingEvent( playerName, _setKickReason, deferrals, _dummySource )

QUEUE_PROFILER_SCOPE_BEGIN( 'HandlePlayerConnectingEvent' )

    local source = tostring( _dummySource or source ) --[[ @as Source ]]

    deferrals.defer()

    --[[ Obrigatório! ]]
    Wait(0)

    deferrals.handover( DEFAULT_HANDOVER )

    deferrals.update( 'Descobrindo a fila...' )

    QUEUE_PROFILER_SCOPE_BEGIN( 'HandlePlayerConnectingEvent:xpcall' )

    local status, err = xpcall(
        function ()

            deferrals.update( 'Autenticando na fila..' )

            local beforeQueueEntryAddedResult = OnBeforeQueueEntryAdded( source )

            deferrals.update( 'Autenticando na fila..' )

            if beforeQueueEntryAddedResult.denied then
                return deferrals.done( beforeQueueEntryAddedResult.denied.failureReason )
            end

            deferrals.update( 'Autenticando na fila...' )

            assert( beforeQueueEntryAddedResult.allowed.userId, 'Missing "userId" parameter returned by "OnBeforeQueueEntryAdded"' )

            deferrals.update( 'Você está na fila, o tempo de espera é de até 1 minuto..' )

            if gNumQueueEntries >= MAX_NUM_QUEUE_ENTRIES then
                deferrals.done( 'A fila chegou na capacidade máxima de jogadores, tente novamente mais tarde!' )

                error( ('Number of queue entries exceeded the maximum of %s. gNumQueueEntries=%d'):format( MAX_NUM_QUEUE_ENTRIES, gNumQueueEntries ) )
            end

            deferrals.update( 'Você está na fila, o tempo de espera é de até 1 minuto...' )

            local queueEntry = CreateQueueEntry( source, deferrals, playerName, beforeQueueEntryAddedResult.allowed )

            deferrals.update( 'Você está na fila, o tempo de espera é de até 1 minuto....' )

            AddQueueEntry( queueEntry )
        end,
        function( err )

            deferrals.done( 'Um error inesperado ocorreu, contate os Administradores do servidor!' )

            return err
        end
    )

    QUEUE_PROFILER_SCOPE_END() -- END HandlePlayerConnectingEvent:xpcall

QUEUE_PROFILER_SCOPE_END() -- END HandlePlayerConnectingEvent

    assert( status,  ('Ocorreu um error ao tentar adicionar source="%s" ao Queue!\n> %s'):format( source, err ) )
end

---Evento que é executado quando o jogador realmente se junta ao servidor.
---@param temporaryId   Source
---@param _dummySource  Source? -- Só é usado para testes
local function HandlePlayerJoiningEvent( temporaryId, _dummySource )

    temporaryId = tostring( temporaryId )

    local source = tostring( _dummySource or source ) --[[ @as Source ]]

    local queueEntry = gQueueEntriesBySource[ temporaryId ]

    assert( queueEntry, ('QueueEntry for source="%s" could not be found!'):format( temporaryId ) )

    --[[ Confirmar a entrada do jogador para o Queue ]]
    OnQueueEntryJoined( queueEntry, source )

    OnAfterQueueEntryJoined( queueEntry )
end

--[[
local function HandlePlayerDroppedEvent( reason )

    local source = tostring( source )

    local queueEntry = gQueueEntriesBySource[ source ]

    logger.debug( 'dropped', source, reason )
end
--]]

AddEventHandler( 'playerConnecting', HandlePlayerConnectingEvent )
AddEventHandler( 'playerJoining'   , HandlePlayerJoiningEvent    )
-- AddEventHandler( 'playerDropped'   , HandlePlayerDroppedEvent    )

CreateThread(function()

    while true do

        UpdateQueue()

        Wait( 1000 )
    end
end)

AddEventHandler('onResourceStop', function( resourceName )
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    for _, queueEntry in each ( gQueueEntries ) do
        queueEntry.deferrals.done( 'O queue foi pausado. Tente novamente em alguns segundos!' )
    end
end)
---@diagnostic disable: lowercase-global

---@alias Source string

---@class Deferrals
---@field defer         fun(): nil
---@field update        fun( message       : string ): nil
---@field presentCard   fun( card          : table | string, cb?: fun(data: table, rawData: string): nil ): nil
---@field done          fun( failureReason : string? ): nil
---@field handover      fun( data: table<string, any> ): nil

---@class BeforePlayerConnectResultAllowed
---@field userId        number
---@field orderPriority number

---@class BeforePlayerConnectResultDenied
---@field failureReason string

---@class BeforePlayerConnectResult
---@field denied    BeforePlayerConnectResultDenied?
---@field allowed   BeforePlayerConnectResultAllowed?

---@class DoneBeforePlayerConnect
---@overload fun( dataOrfailureReason: BeforePlayerConnectResultAllowed | string ): nil

cityName = GetConvar("cityName", "Base")
SERVER__CITY__NAME        = cityName
SERVER__CITY__MAX_CLIENTS = 1300

--[[ Número máximo de jogadores que podem estar na fila ao mesmo tempo. ]]
MAX_NUM_QUEUE_ENTRIES = 2048

--[[ Número máximo de jogadores que podem estar se juntando no servidor ao mesmo tempo. ]]
MAX_NUM_QUEUE_ENTRIES_JOINING = 50

MAX_NUM_DOTS = 3

gNumQueueEntries = 0

gNumQueueEntriesJoining = 0

---@type (QueueEntry | nil)[]
gQueueEntries = { }

---@type (QueueEntry | nil)[]
gQueueEntriesOrderedByPriority = { }

---@type table<Source, QueueEntry>
gQueueEntriesBySource = { }

---@type table<number, QueueEntry>
gQueueEntriesByUserId = { }

gNumQueueUpdates = 0

--[[ Localizar para que a gente criar promises mais rápido ]]
local promise_new = promise.new

---Lida com validações/autenticações de resources externos antes de adicionar o jogador na fila
---substitui o evento "Queue:Connecting"
---@param source Source
---@return BeforePlayerConnectResult
function OnBeforeQueueEntryAdded( source )
QUEUE_PROFILER_SCOPE_BEGIN( 'OnBeforeQueueEntryAdded' )

    QUEUE_PROFILER_SCOPE_BEGIN( 'OnBeforeQueueEntryAdded ( Allocating promises )')

    local pA = promise_new() --[[ Promise para os actions ]]
    local pT = promise_new() --[[ Promise para o  timeout ]]

    QUEUE_PROFILER_SCOPE_END()

    QUEUE_PROFILER_SCOPE_BEGIN( 'OnBeforeQueueEntryAdded ( Allocating actions )')

    ---@overload fun( data         : BeforePlayerConnectResultAllowed ): nil
    ---@overload fun( failureReason: string                           ): nil
    function done( dataOrFailureReason )

        ---@type BeforePlayerConnectResult
        local result = { }

        if type(dataOrFailureReason) == 'string' then

            --[[ Denied! ]]
            result.denied = { failureReason = dataOrFailureReason }

            pA:resolve( result )

            return
        end
        --[[ Allowed! ]]

        result.allowed = dataOrFailureReason

        pA:resolve( result )
    end

    QUEUE_PROFILER_SCOPE_END()

    --[[ Timeout para que o subsistema não demore demais para responder! ]]
    Citizen.SetTimeout( 10000, function ()
        pT:reject( 'O sub-sistema demorou demais para validar a nova entrada no queue' )
    end)

    QUEUE_PROFILER_SCOPE_BEGIN( 'OnBeforeQueueEntryAdded ( Triggering event and awaiting response )')

    local p = promise.first({ pA, pT })

    TriggerEvent( 'beforePlayerConnect', source, done )

    local result = Citizen.Await( p )

    QUEUE_PROFILER_SCOPE_END()

QUEUE_PROFILER_SCOPE_END()
    return result
end

---@param queueEntry QueueEntry
function OnAfterQueueEntryJoined( queueEntry )

    -- TriggerEvent( 'afterPlayerJoined', queueEntry.source )
end


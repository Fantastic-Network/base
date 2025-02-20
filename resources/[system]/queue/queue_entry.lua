---@diagnostic disable: lowercase-global

---@class QueueEntry
---@field idx               number
---@field isValid           boolean
---@field failed            boolean
---@field failureReason     string?
---@field orderPriority     number
---@field source            Source
---@field isJoining         boolean
---@field deferrals         Deferrals
---@field createdAt         number
---@field playerName        string
---@field userId            number

---Marca o QueueEntry para ser deletado e removido no proximo tick/update do Queue
---@param queueEntry    QueueEntry
local function InvalidateQueueEntry( queueEntry )

    assert( queueEntry.isValid, ('QueueEntry with source="%s" is already invalid, why are you trying to invalidate it multiple times?'):format( queueEntry.source ) )

    queueEntry.isValid       = false
end

---@param queueEntry    QueueEntry
function RemoveQueueEntry( queueEntry )

    if queueEntry.failed then
        queueEntry.deferrals.done( queueEntry.failureReason )   --[[ Falha!   ]]
    end

    --[[
        NOTE: Não usamos "table.remove" aqui porque se não a tabela gQueueEntries
        seria reorganizada a cada valor que a gente removesse dela
        então, é mais eficiente a gente só mudar esse valor para "nil"
    --]]
    gQueueEntries[ queueEntry.idx ] = nil

    if gQueueEntriesBySource[ queueEntry.source ] == queueEntry then
        --[[ Source pode talvez ser reutilizado, então vamos só garantir que estamos removendo o QueueEntry correto ]]

        gQueueEntriesBySource[ queueEntry.source ] = nil
    end

    if gQueueEntriesByUserId[ queueEntry.userId ] == queueEntry then
        --[[ Pode ser que essa QueueEntry foi removida por ter um userId duplicado, então vamos verificar antes de remover a outra entrada do QueueEntry ]]

        gQueueEntriesByUserId[ queueEntry.userId ] = nil
    end

    if queueEntry.isJoining then
        gNumQueueEntriesJoining -= 1
    end

    gNumQueueEntries -= 1

    logger.debug( ('QueueEntry with source="%s" playerName="%s" was removed! reason="%s"'):format( queueEntry.source, queueEntry.playerName, queueEntry.failureReason ) )
end

---@param source        Source
---@param deferrals     Deferrals
---@param playerName    string
---@param data          BeforePlayerConnectResultAllowed 
---@return QueueEntry
function CreateQueueEntry( source, deferrals, playerName, data )

    ---@type QueueEntry
    local queueEntry =
    {
        idx = -1, --[[ Invalid idx! ]]

        isValid = true,

        failed = false,

        orderPriority = data.orderPriority,

        source    = source,
        deferrals = deferrals,
        isJoining = false,

        createdAt = GetGameTimer(),

        playerName = playerName,

        userId = data.userId,
    }

    return queueEntry
end

---@param queueEntry QueueEntry
---@return nil
function AddQueueEntry( queueEntry )

QUEUE_PROFILER_SCOPE_BEGIN( 'AddQueueEntry ()')

    --[[ Achar um espaço vazio para adicionar o novo QueueEntry! ]]
    for idx = 1, MAX_NUM_QUEUE_ENTRIES do

        if gQueueEntries[ idx ] == nil then

            --[[ Remover um QueueEntry duplicado! ]]
            local oldQueueEntry = gQueueEntriesByUserId[ queueEntry.userId ]

            if oldQueueEntry and oldQueueEntry.isValid then
                OnQueueEntryJoiningDenied( oldQueueEntry, ('Removing duplicate! userId=%d'):format( queueEntry.userId ) )
            end

            gNumQueueEntries += 1

            gQueueEntries[ idx ] = queueEntry

            gQueueEntriesBySource[ queueEntry.source ] = queueEntry

            gQueueEntriesByUserId[ queueEntry.userId ] = queueEntry

            queueEntry.idx = idx

            logger.debug( ('QueueEntry added! with source="%s" playerName="%s" idx=%d'):format( queueEntry.source, queueEntry.playerName, idx ) )

QUEUE_PROFILER_SCOPE_END()

            return true
        end
    end

QUEUE_PROFILER_SCOPE_END()

    error( ('Failed to find an empty spot for queueEntry="%s"'):format( json.encode(queueEntry) ) )
end

---@param queueEntry    QueueEntry
---@param reason        string?
function OnQueueEntryJoiningDenied( queueEntry, reason )

    InvalidateQueueEntry( queueEntry )

    queueEntry.failed        = true
    queueEntry.failureReason = reason or 'Você foi removido da fila, tente novamente!'

    logger.debug( ('QueueEntry with source="%s" playerName="%s" was denied joining! reason="%s"'):format( queueEntry.source, queueEntry.playerName, queueEntry.failureReason ) )
end

---@param queueEntry    QueueEntry
function OnQueueEntryJoiningAllowed( queueEntry )

    gNumQueueEntriesJoining += 1

    queueEntry.isJoining = true

    queueEntry.deferrals.update( 'Entrando...' )

    queueEntry.deferrals.done() --[[ Sucesso! ]]

    logger.debug( ('QueueEntry with source="%s" playerName="%s" is joining!'):format( queueEntry.source, queueEntry.playerName ) )
end

---O jogador foi anteriormente permitido a conexão via "AllowQueueEntryConnection"
---e agora o jogador realmente se juntou o servidor, então vamos remover ele completamente do queue.
---@param queueEntry    QueueEntry]
---@param newSource     Source
function OnQueueEntryJoined( queueEntry, newSource )

    InvalidateQueueEntry( queueEntry )

    queueEntry.source = newSource

    logger.debug( ('QueueEntry with source="%s" playerName="%s" has joined, invalidating!'):format( queueEntry.source, queueEntry.playerName ) )
end
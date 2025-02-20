---@diagnostic disable: lowercase-global

---@param queueEntryA QueueEntry | nil
---@param queueEntryB QueueEntry | nil
---@return boolean
local function OrderQueueEntriesByPriority( queueEntryA, queueEntryB )

    if queueEntryA == nil then
        --[[ queueEntryA é nulo, então queueEntryB vai ser ordenado primeiro na lista ]]

        return false
    end

    if queueEntryB == nil then
        --[[ queueEntryB é nulo, então queueEntryA vai ser ordenado primeiro na lista ]]

        return true
    end

    return queueEntryA.orderPriority > queueEntryB.orderPriority
end

---@return boolean
local function ShouldUpdateQueueEntries()

    if GetNumPlayerIndices() >= SERVER__CITY__MAX_CLIENTS then
        return false
    end

    return true
end

---@param fc? number
function UpdateQueue( fc )

QUEUE_PROFILER_SCOPE_BEGIN( 'UpdateQueue')
    ---@class InvalidatedQueueEntry
    ---@field queueEntryIdx number
    ---@field queueEntry    QueueEntry

    --[[ gQueueEntries vai ser clonado para gQueueEntriesOrderedByPriority ]]
    gQueueEntriesOrderedByPriority = table.clone( gQueueEntries )

    --[[ TODO: Re-ordenar a lista somente a cada X intervalo de frames ]]
    table.sort( gQueueEntriesOrderedByPriority, OrderQueueEntriesByPriority )

    ---@type QueueEntry[]
    local queueEntriesInvalidate = { }

    local shouldUpdateQueueEntries = ShouldUpdateQueueEntries()

    --[[ Criar a mensagem uma só vez por frame, ao invés de varias vezes para cada QueueEntry ]]
    local messageFmtQueueOrder = 'Sua posição na fila é %d / %d '

    ---[[ Gerar os pontos da mensagem da ordem atual no queue ]]
    local messageOrderDots = ( gNumQueueUpdates % MAX_NUM_DOTS ) + 1

    for i = 1, messageOrderDots do
        messageFmtQueueOrder = messageFmtQueueOrder .. '.'
    end

    QUEUE_PROFILER_SCOPE_BEGIN( 'UpdateQueue ( Main iteration )')

    logger.debug( 'UpdateQueue -> shouldUpdateQueueEntries', shouldUpdateQueueEntries )

    logger.debug( 'UpdateQueue -> gNumQueueEntriesJoining', gNumQueueEntriesJoining, 'max', MAX_NUM_QUEUE_ENTRIES_JOINING )

    --[[ 'each' ignora entradas em gQueueEntriesOrderedByPriority com valor 'nil' ]]
    for order, queueEntry in each( gQueueEntriesOrderedByPriority ) do

        --[[ Esse QueueEntry ainda é valido? ( não vai ser deletado? ) ]]
        local isValid = queueEntry.isValid

        --[[ Tem vaga para se juntar ao servidor? ]]
        local isJoiningEnabled = gNumQueueEntriesJoining < MAX_NUM_QUEUE_ENTRIES_JOINING
        if isValid then
            queueEntry.deferrals.update( ( messageFmtQueueOrder ):format( order, #gQueueEntriesOrderedByPriority ) )
        end

        if shouldUpdateQueueEntries and isValid and isJoiningEnabled then
            --[[ Não queremos processar um QueueEntry que já foi invalidado e que vai ser removido da fila. ]]

            if UpdateQueueEntry( queueEntry ) then
                
                --[[ Vamos aceitar a conexão desse jogador! ]]
                OnQueueEntryJoiningAllowed( queueEntry )
            end
        end

        --[[ QueueEntry pode ser invalidado pela função UpdateQueueEntry ]]
        if not isValid then

            table.insert( queueEntriesInvalidate, queueEntry )
        end
    end

    QUEUE_PROFILER_SCOPE_END()

    QUEUE_PROFILER_SCOPE_BEGIN( 'UpdateQueue ( Invalidation iteration )')

    for _, queueEntry in ipairs( queueEntriesInvalidate ) do

        RemoveQueueEntry( queueEntry )
    end

    QUEUE_PROFILER_SCOPE_END()

    gNumQueueUpdates += 1

QUEUE_PROFILER_SCOPE_END()
end
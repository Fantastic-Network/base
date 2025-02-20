---@param queueEntry    QueueEntry
---@return boolean
function UpdateQueueEntry( queueEntry )

    --[[ O jogador ainda existe? Ainda tá no processo de se juntar ao servidor? ]]
    if not DoesPlayerExist( queueEntry.source ) then

        --[[
            Jogadores com tempId ( antes de se juntar ao servidor )
            não vão emitir um playerDropped, então a gente tem que manualmente verificar
            se o jogadora ainda está tentando se conectar ou ser cancelou a conexão
        --]]

        OnQueueEntryJoiningDenied( queueEntry, 'Desconectou enquanto se juntava ao servidor.' )

        return false
    end

    --[[ Jogador já está entrando no servidor... ]]
    if queueEntry.isJoining then

        --[[ Tudo certo por enquanto, vamos ignorar-lo! ]]
        return false
    end

    return true
end
cityName = GetConvar("cityName", "Base")
Language = GetConvar("Language", "") or false

NotifyId = {
    [1] = function(...)
        local _,Count = ...
        TriggerEvent("Notify","amarelo","Um novo chamado foi aberto! <b>[F1]</b><br/>Total de Chamados abertos <b>"..Count.."</b>.",10000,"CHAMADOS")
        -- TriggerEvent("Notify2","#novoChamado",{msg=Count})
    end,
    [2] = function(...)
        TriggerEvent("Notify","vermelho","Notificações de chamados <b>desativadas</b>.",5000,"Chamados")
        -- TriggerEvent("Notify2","#notifyChamadasOff")
    end,
    [3] = function(...)
        TriggerEvent("Notify","verde","Notificações de chamados <b>ativadas</b>.",5000,"Chamados")
        -- TriggerEvent("Notify2","#notifyChamadasOn")
    end,
    [4] = function(...)
        TriggerEvent("Notify","vermelho","Você não pode responder o seu próprio chamado.",5000,"Chamados")
        -- TriggerEvent("Notify2","#seuChamadoNao")
    end,
    [5] = function(...)
        TriggerEvent("Notify","vermelho","Jogador offline.",5000)
        -- TriggerEvent("Notify2","#playerOff")
    end,
    [6] = function(...)
        local _,Cooldown = ...
        TriggerEvent("Notify","vermelho","Você precisa esperar <b>"..Cooldown.."</b> para responder outro chamado.",5000,"Chamados")
        -- TriggerEvent("Notify2","#esperaChamado",{msg=Cooldown})
    end,
    [7] = function(...)
        local _,Cooldown = ...
        TriggerEvent("Notify","vermelho","Você precisa esperar <b>"..Cooldown.."</b> segundos para finalizar o chamado.",5000,"Chamados")
        -- TriggerEvent("Notify2","#esperaFinalizaChamado",{msg=Cooldown})
    end,
    [8] = function(...)
        local _,Cooldown = ...
        TriggerEvent("Notify","vermelho","Você não pode finalizar chamados de outro admin.",5000,"Chamados")
        -- TriggerEvent("Notify2","#chamadoOutroAdmin")
    end,
    [9] = function(...)
        TriggerEvent("Notify","vermelho","Você não pode finalizar o seu próprio chamado.",5000,"Chamados")
        -- TriggerEvent("Notify2","#seuChamadoNao")
    end,
    [10] = function(...)
        local _,Diamond,PlayerIdentity = ...
        TriggerEvent("Notify","verde","Você acaba de receber ".. Diamond .." 💎 de presente por ter atendido o chamado de "..PlayerIdentity.."!",5000,"Obrigado")
        -- TriggerEvent("Notify2","#diamondRecivedAtendimento",{msg=Diamond,msg2=PlayerIdentity})
        TriggerEvent('sounds:Private','like',0.3)
    end,
    [11] = function(...)
        TriggerEvent("Notify","vermelho","Você não recebeu bonus pela finalização desse chamado.",5000,"Chamados")
        -- TriggerEvent("Notify2","#bonusFinalizacao")
    end,
}

Languages = {
    -- ["en-us"] = {
    --     NotifyId[1] = function(...)

    --     end,
    -- }
}


CreateThread(function()
    if Language then
        if Languages[Language] then
            Languages[Language]()
        end
    end
end)
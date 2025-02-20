cityName = GetConvar("cityName", "Base")
DiamondAmount = 75

-- if cityName == "Base" then
--     DiamondAmount = 1
-- end

groupFunctions = {
    ["hire"] = function(sourceRecruiter,Passport)
        local RecruiterPassport = vRP.Passport(sourceRecruiter)
        local OwnerJob,OwnerRank,OwnerGroup,OwnerHierarchy = vRP.UserGroupByType(RecruiterPassport,'Job')
        local Source = vRP.Source(Passport)
        local identity = vRP.Identity(RecruiterPassport)
        local identity2 = vRP.Identity(Passport)
        Passport = parseInt(Passport)
        Hiring[RecruiterPassport] = true
        if OwnerRank <= 4 then
            if not Source then
                TriggerClientEvent("Notify",sourceRecruiter,"vermelho","O Jogador está <b>Offline</b>",5000)
                -- TriggerClientEvent("Notify2",sourceRecruiter,"#playerOff")
                Hiring[RecruiterPassport] = nil
                return {}
            end
            local Job = vRP.UserGroupByType(Passport,'Job')
            if Job and not vRP.HasGroup(Passport,"Iniciante") and not vRP.HasGroup(Passport,"Desempregado") then
                TriggerClientEvent("Notify",sourceRecruiter,"vermelho","O Jogador precisa ser <b>Iniciante</b> ou <b>Desempregado</b>.",5000,"RECRUTAMENTO")
                -- TriggerClientEvent("Notify2",sourceRecruiter,"#inicianteOuDesemp")
                Hiring[RecruiterPassport] = nil
                return
            end
            
            TriggerClientEvent("Notify",sourceRecruiter,"amarelo","Você tentou contratar o ID "..Passport..".",5000)
            -- TriggerClientEvent("Notify2",sourceRecruiter,"#tryContratar",{msg=Passport})
            
            if exports["request"]:make(Source,"Deseja ser contratado para "..OwnerJob.." ?") then
                if vRP.HasGroup(Passport,"Iniciante") then
                    addGroupPoints(OwnerJob,DiamondAmount)
                    -- vRP.UpdateAchievement(RecruiterPassport,6,1)
                    -- vRP.Query("accounts/AddGems",{ license = identity["license"], gems = DiamondAmount })
                    -- TriggerClientEvent("Notify",sourceRecruiter,"verde","Você recebeu <b>💎 x"..DiamondAmount.."</b> por contratar um iniciante.",5000,"Diamantes")
                    TriggerClientEvent("Notify",sourceRecruiter,"verde","Sua organização ganhou 🟡 x"..DiamondAmount.." pontos para sua organização por ter recrutado um iniciante!.",5000,"RECRUTAMENTO")
                    -- TriggerClientEvent("Notify2",sourceRecruiter,"#orgRecivedDiamond",{msg=DiamondAmount})
                    TriggerClientEvent('sounds:Private',sourceRecruiter,'like',0.3)
                    vRP.Query("hire_history/add",{ group = OwnerJob, recruiter = RecruiterPassport, recruited = Passport, newbie = 1 })
                    exports["vrp"]:AddPlayerIcr(Passport,OwnerJob)
                    local Consult = vRP.Query("painel/getallVip",{ name = OwnerJob })
                    if Consult[1] and parseInt(Consult[1]["level"]) == 1 then
                        TriggerClientEvent("Notify",Source,"verde"," Boas vindas a organização, que tal pegar seu /kitiniciante ?",45000)
                        KitIniciante[Passport] = true
                    end
                else
                    vRP.Query("hire_history/add",{ group = OwnerJob, recruiter = RecruiterPassport, recruited = Passport, newbie = 0 })
                end
                local Custom = {
                    background = "rgba(6,57,112,.75)",
                }
                local Message = ""..RecruiterPassport.." | "..identity["name"].." contratou "..Passport.." | "..identity2["name"].." para a organização."
                TriggerClientEvent("chat:ClientMessage",-1,OwnerJob,Message,"🧲 Painel",false,Custom)

                vRP.SetPermission(Passport,OwnerJob,5,false,RecruiterPassport)
                TriggerClientEvent("Notify",sourceRecruiter,"verde","Você contratou o ID "..Passport.." para "..OwnerJob..".",5000)
                -- TriggerClientEvent("Notify2",sourceRecruiter,"#contrataPassport"m{msg=Passport,msg2=OwnerJob})
                exports["vrp"]:SendWebHook("contratou","**Passaporte:** "..RecruiterPassport.." " .. vRP.FullName(RecruiterPassport) .. "\n**Contratou:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Fac:** "..OwnerJob.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
                updateSortedMembers(OwnerJob)
                Wait(750)
                local Position = getUserPosition(groupCache[OwnerJob]["members"],Passport)
                Hiring[RecruiterPassport] = nil
                return groupCache[OwnerJob]["members"][Position]
            end
        end
        Hiring[RecruiterPassport] = nil
        return false
    end,
    ["promote"] = function(sourceRecruiter,Passport)
        local RecruiterPassport = vRP.Passport(sourceRecruiter)  
        local OwnerJob,OwnerRank,OwnerGroup,OwnerHierarchy = vRP.UserGroupByType(RecruiterPassport,'Job')
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
        Passport = parseInt(Passport)
        if OwnerHierarchy == "Chefe" or OwnerHierarchy == "Sub-Chefe" or OwnerHierarchy == "Supervisor" and Hierarchy ~= "Chefe" then
            local Source = vRP.Source(Passport)
            local inGroup = groupCache[OwnerJob]["members"]
            
            vRP.SetPermission(Passport,OwnerJob,false,"Promote",RecruiterPassport)
            local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
            if OwnerHierarchy == "Sub-Chefe" or OwnerHierarchy == "Supervisor" and Hierarchy ~= "Membro" then
                TriggerClientEvent("Notify",sourceRecruiter,"vermelho","Você não pode promover um <b>Sub-Chefe</b>.",5000)
                -- TriggerClientEvent("Notify2",sourceRecruiter,"#naoPSubchefe")
                vRP.SetPermission(Passport,OwnerJob,false,"Demote",RecruiterPassport)
                return {}
            end
            
            local Position = getUserPosition(groupCache[OwnerJob]["members"],Passport)
            if Position then
                groupCache[OwnerJob]["members"][Position]["group"] = Group
                groupCache[OwnerJob]["members"][Position]["role"] = tonumber(Hierarchy) or 5
            end
            groupCache[OwnerJob]["members"] = inGroup
            TriggerClientEvent("Notify",sourceRecruiter,"verde","Voce promoveu o ID: <b>"..Passport.."</b> para <b>"..Hierarchy.."</b>",5000)
            -- TriggerClientEvent("Notify2",sourceRecruiter,"#promovePassport",{msg=Passport},msg2=Hierarchy)
            -- exports["vrp"]:SendWebHook("promover","**Passaporte:** "..RecruiterPassport.." " .. vRP.FullName(RecruiterPassport) .. "\n**Promoveu:** "..Passport.." " .. vRP.FullName(Passport) .. " a "..Hierarchy.."\n**Fac:** "..OwnerJob.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
            updateSortedMembers(OwnerJob)
            Wait(100)
            return ChangeGroup(Passport)
        end
    end,
    ["demote"] = function(sourceRecruiter,Passport,Name)
        local RecruiterPassport = vRP.Passport(sourceRecruiter)  
        local OwnerJob,OwnerRank,OwnerGroup,OwnerHierarchy = vRP.UserGroupByType(RecruiterPassport,'Job')
        Passport = parseInt(Passport)
        if OwnerHierarchy == "Chefe" or OwnerHierarchy == "Sub-Chefe" then
            local Source = vRP.Source(Passport)
            vRP.SetPermission(Passport,OwnerJob,false,"Demote",RecruiterPassport)
            local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
            local Position = getUserPosition(groupCache[OwnerJob]["members"],Passport)
            if Position then
                if groupCache[OwnerJob]["members"] and groupCache[OwnerJob]["members"][Position] then
                    if groupCache[OwnerJob]["members"][Position]["group"] then
                        groupCache[OwnerJob]["members"][Position]["group"] = Group
                    end
                    if groupCache[OwnerJob]["members"][Position]["role"] then
                        groupCache[OwnerJob]["members"][Position]["role"] = tonumber(Hierarchy) or 5
                    end
                end
            end
            
            TriggerClientEvent("Notify",sourceRecruiter,"verde","Voce rebaixou o ID: <b>"..Passport.."</b> para <b>"..Hierarchy.."</b>",5000)
            -- TriggerClientEvent("Notify2",sourceRecruiter,"#rebaixaPassport",{msg=Passport},msg2=Hierarchy)
            -- exports["vrp"]:SendWebHook("rebaixar","**Passaporte:** "..RecruiterPassport.." " .. vRP.FullName(RecruiterPassport) .. "\n**Rebaixou:** "..Passport.." " .. vRP.FullName(Passport) .. " a "..Hierarchy.."\n**Fac:** "..OwnerJob.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
            updateSortedMembers(OwnerJob)
            Wait(100)
            return ChangeGroup(Passport)
        end
    end,
    ["fire"] = function(sourceRecruiter,Passport)
        local RecruiterPassport = vRP.Passport(sourceRecruiter)  
        local OwnerJob,OwnerRank,OwnerGroup,OwnerHierarchy = vRP.UserGroupByType(RecruiterPassport,'Job')
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
        Passport = parseInt(Passport)
        if RecruiterPassport == Passport then
            TriggerClientEvent("Notify",sourceRecruiter,"vermelho","Você não pode demitir você mesmo.",5000)
            -- TriggerClientEvent("Notify2",sourceRecruiter,"#naoDemitirVc")
            return {}
        end
        
        if OwnerHierarchy == "Chefe" or OwnerHierarchy == "Sub-Chefe" then
            if Hierarchy == "Chefe" and OwnerHierarchy == "Sub-Chefe" then
                TriggerClientEvent("Notify",sourceRecruiter,"vermelho","Você não pode demitir um <b>Chefe</b>.",5000)
                -- TriggerClientEvent("Notify2",sourceRecruiter,"#naoDemitirChefe")
                return {}
            end
            local Source = vRP.Source(Passport)
            local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
            local inGroup = groupCache[OwnerJob]["members"]
            local Position = getUserPosition(groupCache[OwnerJob]["members"],Passport)
            vRP.SetPermission(Passport,"Desempregado")
            Wait(100)
            if Position then
                table.remove(groupCache[OwnerJob]["members"],Position)
            end
            vRP.Query("painel/setMemberFired",{ Passport = Passport, GroupId = groupCache[OwnerJob]["groupId"] })
            TriggerClientEvent("Notify",sourceRecruiter,"verde","Você demitiu o ID: <b>"..Passport.."</b>",5000)
            -- TriggerClientEvent("Notify2",sourceRecruiter,"#demitiuPassport",{msg=Passport})
            exports["vrp"]:SendWebHook("demitiu","**Passaporte:** "..RecruiterPassport.." " .. vRP.FullName(RecruiterPassport) .. "\n**Demitiu:** "..Passport.." " .. vRP.FullName(Passport) .. "\n**Fac:** "..OwnerJob.."\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),9317187)
            updateSortedMembers(OwnerJob)
            return Passport
        end 
    end,
}

bankFunctions = {
    ["withdraw"] = function(Source,Passport,Amount)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        local Job = vRP.UserGroupByType(Passport,"Job")
        if Amount <= groupCache[Job]["amount"] then
            groupCache[Job]["amount"] = groupCache[Job]["amount"] - Amount
            vRP.GiveBank(Passport, tonumber(Amount),"Withdraw Painel")
            TriggerClientEvent("Notify",Source,"verde","Você sacou: R$"..Amount,5000)
            -- TriggerClientEvent("Notify2",Source,"#vcSacou",{msg=Amount})
            groupCache[Job]["bankLogs"][#groupCache[Job]["bankLogs"] + 1] = { 
                id = Passport,
                name = identity["name"],
                type = 1,
                quantity = parseInt(Amount),
                timer = os.time()
            }
            updateBank(Job)
            insertBankLog(Job,Passport,1,Amount)
            Wait(100)
            return BankInfo(Job)
        else
            TriggerClientEvent("Notify",Source,"vermelho","Quantidade invalida",5000)
            -- TriggerClientEvent("Notify2",Source,"#qntInvalida")
            return false
        end
    end,
    ["remove"] = function(Source,Passport,Amount,Name)
        local identity = vRP.Identity(Passport)
        groupCache[Name]["amount"] = groupCache[Name]["amount"] - Amount
        TriggerClientEvent("Notify",Source,"verde","Você removeu: R$"..Amount,5000)
        -- TriggerClientEvent("Notify2",Source,"#vcRemoveu",{msg=Amount})
        groupCache[Name]["bankLogs"][#groupCache[Name]["bankLogs"] + 1] = { 
            id = Passport,
            name = identity["name"],
            type = 3,
            quantity = Amount,
            timer = os.time()
        }
        updateBank(Name)
        insertBankLog(Job,Passport,3,Amount)
    end,
    ["deposit"] = function(Source,Passport,Amount)
        local Passport = vRP.Passport(Source)
        local identity = vRP.Identity(Passport)
        local Bank = vRP.GetBank(Source) 
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
        if Amount <= Bank then
            vRP.RemoveBank(Passport, tonumber(Amount))
            Amount = parseInt(Amount * 0.95)
            groupCache[Job]["amount"] = groupCache[Job]["amount"] + Amount
            TriggerClientEvent("Notify",Source,"verde","Você depositou: R$"..Amount,5000)
            -- TriggerClientEvent("Notify2",Source,"#vcDepositou",{msg=Amount})
            groupCache[Job]["bankLogs"][#groupCache[Job]["bankLogs"] + 1] = { 
                id = Passport,
                name = identity["name"],
                type = 2,
                quantity = parseInt(Amount),
                timer = os.time()
            }
            updateBank(Job)
            insertBankLog(Job,Passport,2,Amount)
            Wait(100)
            TriggerClientEvent("Notify",Source,"verde","Ao limpar o dinheiro na transferencia, você perdeu 5% do total do dinheiro.",5000,"Deposito")
            -- TriggerClientEvent("Notify2",Source,"#perdeLimpar")
            return BankInfo(Job)
        else
            TriggerClientEvent("Notify",Source,"vermelho","Quantidade invalida",5000)
            -- TriggerClientEvent("Notify2",Source,"#qntInvalida")
        end
        return false
    end,
}

arsenalFunctions = {
    ["item"] = function(Source,Passport,Item,Type,Amount,Id)
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
        local Price = GetPriceStore(Job,Item,Type,Amount)
        Passport = vRP.Passport(Source)
        if Type == "organization" and Rank == 1 then
            local Points = getGroupPoints(Job)
            if Points >= Price then
                if Id then
                    Passport = parseInt(Id)
                end
                if removeGroupPoints(Job,Price) then
                    vRP.GenerateItem(Passport,Item,Amount,true,false,"Painel",Passport)
                    exports["vrp"]:SendWebHook("lojapainel","**Passaporte:** "..Passport.." ".. vRP.FullName(Passport) .." \n**Comprou:** "..Item.. "\n**Quantidade** " ..Amount.." \n**Facção:** "..Job.. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"),9317187)
                    return false
                end
            end
        end
    end,
}
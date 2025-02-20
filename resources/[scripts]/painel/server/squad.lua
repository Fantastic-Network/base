PlayerSquads = {}
Squads = {}
SquadsDT = {}
GlobalState["SquadsDT"] = SquadsDT

vRP.Prepare("squads/newDT","INSERT INTO squad_deaths(name,deathtimer,content) VALUES (@name,@deathtimer)")
vRP.Prepare("squads/getDT","SELECT * FROM squad_deaths")
vRP.Prepare("quads/updateDT","UPDATE squad_deaths SET deathtimer = @deathtimer WHERE name = @name")

CreateThread(function()
    local Query = vRP.Query("squads/getDT",{})
    for i=1,#Query do
        if Query[i]["name"] and Query[i]["deathtimer"] then
            SquadsDT[Query[i]["name"]] = Query[i]["deathtimer"]
        end
    end
    GlobalState["SquadsDT"] = SquadsDT
end)

function FormatMessages(Table)
    local Formated = {}
    for i=1,#Table do
        local Identity = vRP.Identity(Table[i]["author"])
        local Name = Identity['name'] .. ' ' .. Identity['name2']
        local Author = Name
        local AuthorId = Table[i]["author"]
        local Message = Table[i]["message"]
        local createdAt = Table[i]["date"]
        local Type = Table[i]["type"]
        table.insert(Formated, {author = Author, authorId = AuthorId, content = Message, createdAt = createdAt, type = Type})
    end
    return Formated
end

function FormatSquads(Table)
    local GroupSquad = {}
    for i=1,#Table do
        local Info = {}
        Info["id"] = Table[i]["id"]
        Info["name"] = Table[i]["name"]
        Info["members"] = 0
        local Members = json.decode(Table[i]["members"]) or {}
        local FormatedMembers = {}
        for k,v in pairs(Members) do
            local PlayerInfo = {}
            local Passport = parseInt(k)
            local Identity = vRP.Identity(Passport)
            if Identity then
                local Name = Identity['name'] .. ' ' .. Identity['name2']
                local Source = vRP.Source(Passport)
                PlayerInfo["name"] = Name
                PlayerInfo["id"] = Passport
                PlayerInfo["role"] = v
                table.insert(FormatedMembers, PlayerInfo)
                if v == 1 then
                    Info["leader"] = Name
                    Info["leaderId"] = Passport
                end
                if not PlayerSquads[Passport] then
                    PlayerSquads[Passport] = {}
                    PlayerSquads[Passport] = {Info["id"]}
                else
                    table.insert(PlayerSquads[Passport], Info["id"])
                end
                if Source then
                    Info["members"] = Info["members"] + 1
                end
            end
        end
        Info["membersInfo"] = FormatedMembers
        Info["membersTable"] = Members or {}
        -- Info["maxMembers"] = #FormatedMembers
        Info["maxMembers"] = 20
        Squads[Table[i]["id"]] = Info
        table.insert(GroupSquad, Info)
    end
    return GroupSquad
end

function Server.GetSquadInfo(id)
    if Squads[id] then
        return Squads[id]["membersInfo"]
    end
    return {}
end

function GetPlayerRank(Passport,Group)
    local Job,Rank = vRP.UserGroupByType(Passport,'Job')
    local Table = {}
    if Passport == groupCache[Group]["leaderid"] then
        Table = {"create","edit"}
    else
        if Rank <= 2 then
            Table = {"edit"}
        end
    end
    return Table
end

function Server.GetSquads(Group)
    local source = source
    local Passport = vRP.Passport(source)
    if groupCache[Group] then
        return { playerSquads = PlayerSquads[Passport] or {}, userId = Passport, permissions = GetPlayerRank(Passport,Group), teams = groupCache[Group]["squads"], messages = groupCache[Group]["SquadsMessages"] }
    end
    return {}
end

function Server.CreateSquad(Group,Name,Leader)
    if groupCache[Group] then
        local groupId = groupCache[Group]["groupId"]
        local Query = vRP.Query("painel/CreateSquad",{group = groupId, name = Name})
        local SquadId = Query["insertId"]
        local SquadInfo = {}
        SquadInfo["id"] = SquadId
        SquadInfo["name"] = Name
        SquadInfo["members"] = 0
        SquadInfo["maxMembers"] = 20
        SquadInfo["membersInfo"] = {}
        SquadInfo["membersTable"] = {}
        SquadInfo["maxMembers"] = 20
        Squads[SquadId] = SquadInfo
        table.insert(groupCache[Group]["squads"], Squads[SquadId])
    end
end

function Server.DeleteSquad(Group,SquadId)
    local source = source
    if groupCache[Group] and Squads[SquadId] then
        Squads[SquadId] = nil
        RemoveGroupSquads(Group,SquadId)
        vRP.Query("painel/DeleteSquad",{ GroupId = SquadId })
        TriggerClientEvent("Notify",source,"verde","Você deletou o pelotão com sucesso!",8000,"Pelotao")
        -- TriggerClientEvent("Notify2",source,"#deletesquad")
    end
end

function RemoveGroupSquads(Group,SquadId)
    for i=1,#groupCache[Group]["squads"] do
        if groupCache[Group]["squads"][i]["id"] == SquadId then
            table.remove(groupCache[Group]["squads"], i)
            break
        end
    end
end

function UpdateGroupSquads(Table,Group,Id)
    for i=1,#groupCache[Group]["squads"] do
        if groupCache[Group]["squads"][i]["id"] == Id then
            groupCache[Group]["squads"][i] = Table
            break
        end
    end
end

function Server.InviteUser(Group,SquadId,InvitedPassport)
    local source = source
    local Passport = vRP.Passport(source)
    if groupCache[Group] and Squads[SquadId] then
        local InvitedSource = vRP.Source(InvitedPassport)
        local SquadName = Squads[SquadId]["name"]

        if #Squads[SquadId]["membersInfo"] >= 20 then
            TriggerClientEvent("Notify",source,"vermelho","Pelotão com o máximo de membros!",8000,"Pelotao")
            -- TriggerClientEvent("Notify2",source,"#maxPSquad")
            return
        end

        if vRP.Request(InvitedSource,"Deseja entrar para o pelotão "..SquadName.."?") then
            local Identity = vRP.Identity(InvitedPassport)
            local Name = Identity['name'] .. ' ' .. Identity['name2']
            Squads[SquadId]["membersTable"][tostring(InvitedPassport)] = 3
            table.insert(Squads[SquadId]["membersInfo"],{ name = Name, id = InvitedPassport, role = 3 })
            -- Squads[SquadId]["maxMembers"] = #Squads[SquadId]["membersInfo"]
            Squads[SquadId]["maxMembers"] = 20
            Squads[SquadId]["members"] = Squads[SquadId]["members"] + 1
            UpdateGroupSquads(Squads[SquadId],Group,SquadId)
            vRP.Query("painel/UpdateSquad",{ Name = SquadName, Members = json.encode(Squads[SquadId]["membersTable"]), GroupId = SquadId })
            if not PlayerSquads[Passport] then
                PlayerSquads[Passport] = {}
                PlayerSquads[Passport] = { SquadId }
            else
                table.insert(PlayerSquads[Passport], SquadId)
            end
            local pSquads = {}
            if PlayerSquads[InvitedPassport] then
                for i=1,#PlayerSquads[InvitedPassport] do
                    local SquadId = PlayerSquads[InvitedPassport][i]
                    if Squads[SquadId] then
                        pSquads[Squads[SquadId]["name"]] = true
                    end
                end
                Player(source)["state"]["Squads"] = pSquads
                TriggerClientEvent("Notify",InvitedSource,"verde","Você entrou para o "..SquadName.."!",8000,"Pelotao")
                -- TriggerClientEvent("Notify2",InvitedSource,"#entrouSquad",{msg=SquadName})
                TriggerClientEvent("Notify",source,"verde","O Memebro "..InvitedPassport.." Entrou para o pelotão.",8000,"Pelotao")
                -- TriggerClientEvent("Notify2",source,"#membroEntrouSquad",{msg=InvitedPassport})
                TriggerClientEvent("Painel:UpdateTeam",source)
            end
        end
    end
end

function Server.ChangeName(Group,SquadId,Name)
    local source = source
    local Passport = vRP.Passport(source)
    if groupCache[Group] and Squads[SquadId] then
        Squads[SquadId]["name"] = Name
        UpdateGroupSquads(Squads[SquadId],Group,SquadId)
        vRP.Query("painel/UpdateSquad",{Name = Name, Members = json.encode(Squads[SquadId]["membersTable"]), GroupId = SquadId })
        TriggerClientEvent("Notify",source,"verde","O nome do pelotão foi alterado para "..Name.."!",8000,"Pelotao")
        -- TriggerClientEvent("Notify2",source,"#nomeSquadAlterado",{msg=Name})
    end
end

function Server.NewMessage(Group,Message,Type)
    local source = source
    local Passport = vRP.Passport(source)
    if groupCache[Group] then
        local groupId = groupCache[Group]["groupId"]
        local Identity = vRP.Identity(Passport)
        local Name = Identity['name'] .. ' ' .. Identity['name2']
        vRP.Query("painel/NewSquadMessage",{GroupId = groupId, Message = Message, Type = Type, Author = Passport })
        table.insert(groupCache[Group]["SquadsMessages"],{content = Message, createdAt = os.time() * 1000, type = Type, author = Name, authorId = Passport})
    end
end

function Server.UpdateUserRole(Group,SquadId,UserId,Role)
    local source = source
    local Passport = vRP.Passport(source)
    if Squads[SquadId] then
        local SquadName = Squads[SquadId]["name"]
        local Identity = vRP.Identity(UserId)
        local Name = Identity['name'] .. ' ' .. Identity['name2']
        Squads[SquadId]["membersTable"][tostring(UserId)] = Role
        for i=1,#Squads[SquadId]["membersInfo"] do
            if Squads[SquadId]["membersInfo"][i]["id"] == UserId then
                Squads[SquadId]["membersInfo"][i]["role"] = Role
                break
            end
        end
        if Role == 1 then
            Squads[SquadId]["leader"] = Name
            Squads[SquadId]["leaderId"] = UserId
        end
        UpdateGroupSquads(Squads[SquadId],Group,SquadId)
        vRP.Query("painel/UpdateSquad",{ Name = SquadName, Members = json.encode(Squads[SquadId]["membersTable"]), GroupId = SquadId })
        TriggerClientEvent("Notify",source,"verde","O cargo do membro "..Name.." foi alterado para "..Role.."!",8000,"Pelotao")
        -- TriggerClientEvent("Notify2",source,"#cargoMembroAlterado",{msg=Name,msg2=Role})
        if Role == 1 then
            return Name
        end
    end
end

function Server.RemoveUser(Group,SquadId,UserId)
    local source = source
    local Passport = vRP.Passport(source)
    if Squads[SquadId] then
        local SquadName = Squads[SquadId]["name"]
        Squads[SquadId]["membersTable"][tostring(UserId)] = Role
        for i=1,#Squads[SquadId]["membersInfo"] do
            if Squads[SquadId]["membersInfo"][i]["id"] == UserId then
                if Squads[SquadId]["membersInfo"][i]["role"] == 1 then
                    Squads[SquadId]["leader"] = nil
                    Squads[SquadId]["leaderId"] = nil
                end
                table.remove(Squads[SquadId]["membersInfo"],i)
                break
            end
        end
        UpdateGroupSquads(Squads[SquadId],Group,SquadId)
        vRP.Query("painel/UpdateSquad",{ Name = SquadName, Members = json.encode(Squads[SquadId]["membersTable"]), GroupId = SquadId })
        TriggerClientEvent("Notify",source,"verde","O membro "..UserId.." foi retirado do pelotão "..SquadName.."!",8000,"Pelotao")
        -- TriggerClientEvent("Notify2",source,"#membroRetirado",{msg=UserId,msg2=SquadName})
    end
end

AddEventHandler("Connect",function(Passport,source)
    local pSquads = {}
    if PlayerSquads[Passport] then
        for i=1,#PlayerSquads[Passport] do
            local SquadId = PlayerSquads[Passport][i]
            if Squads[SquadId] then
                Squads[SquadId]["members"] = Squads[SquadId]["members"] + 1
                pSquads[Squads[SquadId]["name"]] = true
            end
        end
    end
    Player(source)["state"]["Squads"] = pSquads
end)

AddEventHandler("Disconnect",function(Passport,source)
    if PlayerSquads[Passport] then
        for i=1,#PlayerSquads[Passport] do
            local SquadId = PlayerSquads[Passport][i]
            if Squads[SquadId] then
                Squads[SquadId]["members"] = Squads[SquadId]["members"] - 1
            end
        end
    end
end)

RegisterCommand("squaddeath",function(source)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Digite o nome do pelotão:", "Tempo de morte:")
            if Keyboard and Keyboard[2] then
                SetDeathTimer(Keyboard[1],parseInt(Keyboard[2]))
                TriggerClientEvent("Notify",source,"verde","O tempo de morte do pelotão "..Keyboard[1].." foi alterado para "..Keyboard[2].." segundos!",8000,"Pelotao")
                -- TriggerClientEvent("Notify2",source,"#tempoMorteSquad",{msg=Keyboard[1],msg2=Keyboard[2]})
            end
        end
    end
end)

function SetDeathTimer(Name,Timer)
    if not SquadsDT[Name] then
        vRP.Query("quads/newDT",{ name = Name, deathtimer = Timer })
    else
        vRP.Query("quads/updateDT",{ name = Name, deathtimer = Timer })
    end
    SquadsDT[Name] = Timer
    GlobalState["SquadsDT"] = SquadsDT
end
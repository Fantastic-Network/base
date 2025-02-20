Tunnel = module('vrp','lib/Tunnel')
Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
Server = {}
Proxy.addInterface('painel',Server)
Tunnel.bindInterface('painel',Server)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
groupCache = {}
playerRecruited = {}
vKEYBOARD = Tunnel.getInterface("keyboard")
PlayerGroup = {}
PlayerPoints = {}
SortedMembers = {}
Hiring = {}
KitIniciante = {}
create = {}
vRP.Prepare("painel/clearGroupMembers","DELETE FROM painel_members WHERE groupid = @GroupId")
vRP.Prepare("painel/clearGroupMessages","DELETE FROM painel_messages WHERE groupid = @GroupId")
vRP.Prepare("painel/getMessages","SELECT * FROM painel_messages WHERE groupid = @GroupId ORDER BY createdAt DESC LIMIT 10")
vRP.Prepare("painel/newMessage","INSERT INTO painel_messages (groupId,author,content) VALUES (@GroupId,@Author,@Message)")
vRP.Prepare("painel/setLeader","UPDATE PAINEL SET leader = @Leader WHERE id = @GroupId")
vRP.Prepare("hire_history/add","INSERT INTO hire_history (`group`,recruited,recruiter,newbie) VALUES (@group,@recruited,@recruiter,@newbie)")
vRP.Prepare("painel_points_history/addPoints","INSERT INTO painel_points_history (`groupId`,amount) VALUES (@groupId,@amount)")
vRP.Prepare("painel/GetSquads","SELECT * FROM painel_squad WHERE `group` = @GroupId")
vRP.Prepare("painel/GetSquadsMessages","SELECT * FROM painel_squad_messages WHERE `group` = @GroupId ORDER BY date DESC LIMIT 20")
vRP.Prepare("painel/CreateSquad","INSERT INTO painel_squad(`group`,name) VALUES (@group,@name)")
vRP.Prepare("painel/NewSquadMessage","INSERT INTO painel_squad_messages(`group`,message,type,author) VALUES (@GroupId,@Message,@Type,@Author)")
vRP.Prepare("painel/UpdateSquad","UPDATE painel_squad SET name = @Name, members = @Members WHERE id = @GroupId")
vRP.Prepare("painel/DeleteSquad","DELETE FROM painel_squad WHERE id = @GroupId")
vRP.Prepare("painel/ClearGroup","UPDATE painel SET bankAmount = @bankAmount, discord = null, leader = 0, buff = 1, organization_points = @Points WHERE id = @GroupId;")
vRP.Prepare("painel/updateGroup","UPDATE painel SET bankAmount = @bankAmount WHERE id = @GroupId")
vRP.Prepare("painel/UpdatePoint","UPDATE painel SET organization_points = @Points WHERE id = @GroupId")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATE CACHE
-----------------------------------------------------------------------------------------------------------------------------------------
function StartPainel(result,i)
    if not result[i]["id"] then
        return
    end
    local groupId = result[i]["id"]
    -- for name,_ in pairs(groupsConfig) do
    --     if result[i]["name"] == name then
    --         create[name] = nil
    --     end
    -- end
    
    local allTimeWithdraw = vRP.Query("painel/getGroupAllWithdraw",{ groupId = groupId })
    local allTimeDeposit = vRP.Query("painel/getGroupAllDeposit",{ groupId = groupId })
    local monthWithdraw = vRP.Query("painel/getGroupMonthWithdraw",{ groupId = groupId })
    local monthDeposit = vRP.Query("painel/getGroupMonthDeposit",{ groupId = groupId })
    local members = vRP.Query("painel/getAllPlayersInGroup",{ groupId = groupId })
    local allTimeGroupRecruited = vRP.Query("painel/getGroupTotalMembers",{ groupid = groupId })
    local monthRecruited = vRP.Query("painel/getGroupMonthMembers",{ groupid = groupId })
    local LatestRecruited = vRP.Query("painel/getGroupLatestRecruited",{ groupid = groupId })
    local bankLogs = vRP.Query("painel/getGroupTransactions",{ groupId = groupId })
    local getMessages = vRP.Query("painel/getMessages",{ GroupId = groupId })
    local Squads = FormatSquads(vRP.Query("painel/GetSquads",{ GroupId = groupId }))
    local SquadsMessages = FormatMessages(vRP.Query("painel/GetSquadsMessages",{ GroupId = groupId }))
    local alltimeRecruitedRanking = {}
    local monthRecruitedRanking = {}
    local Messages = {{}}
    
    for i=1,#getMessages do
        local Identity = vRP.Identity(getMessages[i]["author"])
        if Identity then
            getMessages[i]["author"] = Identity["name"].." "..Identity["name2"]
            Messages[#Messages+1] = Table
        else
            getMessages[i]["author"] = "N/a"
            Messages[#Messages+1] = Table
        end
    end
    
    if getMessages[1] then
        Messages = getMessages
    end
    
    for j=1,#members do
        local Passport = parseInt(members[j]["passport"])
        local source = vRP.Source(members[j]["passport"])
        local IdentityMember = vRP.Identity(Passport)
        local IdentityRecruiter = vRP.Identity(members[j]["recruiter"])
        if IdentityMember and IdentityMember["name"] and IdentityRecruiter and IdentityRecruiter["name"] then
            local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(members[j]["passport"],"Job")
            local LastLogin = lastLogin(Passport)
            local alltimeRecruited = vRP.Query("painel/getMemberTotalRecruited",{ groupid = groupId, passport = members[j]["passport"] })
            local monthRecruited = vRP.Query("painel/getMemberMonthRecruited",{ groupid = groupId, passport = members[j]["passport"] })
            
            local online = false
            
            if source then
                online = true
                LastLogin = os.time()
            end
            
            PlayerGroup[Passport] = j
            local Table = { 
                id = members[j]["passport"],
                name = IdentityMember["name"],
                role = tonumber(Rank) or 5,
                lastlogin = LastLogin,
                phone = IdentityMember["phone"],
                online = online and true or false
            }
            
            PlayerPoints[members[j]["passport"]] = members[j]["points"] or 0
            
            if alltimeRecruited[1] and alltimeRecruited[1]["total"] and alltimeRecruited[1]["total"] > 0 then
                alltimeRecruitedRanking[#alltimeRecruitedRanking+1] = { name = IdentityMember["name"], total = alltimeRecruited[1]["total"]}
            end
            
            if monthRecruited[1] and monthRecruited[1]["total"] and monthRecruited[1]["total"] > 0 then
                monthRecruitedRanking[#monthRecruitedRanking+1] = { name = IdentityMember["name"], total = monthRecruited[1]["total"]}
            end
            playerRecruited[Table["id"]] = { recruitedAmount = #alltimeRecruited}
            members[j] = Table
        end
    end
    
    local FormatBankLogs = {}
    for j=1,#bankLogs do
        if bankLogs[j]["passport"] then
            local identity = vRP.Identity(bankLogs[j]["passport"])
            if identity and identity["name"] then
                local Table = { 
                    id = bankLogs[j]["passport"],
                    name = identity["name"],
                    type = bankLogs[j]["type"],
                    quantity = bankLogs[j]["quantity"],
                    timer = bankLogs[j]["timer"]
                }
                FormatBankLogs[#FormatBankLogs+1] = Table
            end
        end
    end 
    bankLogs = FormatBankLogs
    
    table.sort(bankLogs, function (a, b) return a["timer"] > b["timer"] end) 
    local FormatLatestRecruited = {}
    for j=1,#LatestRecruited do
        local IdentityMember = vRP.Identity(LatestRecruited[j]["passport"])
        local IdentityRecruiter = vRP.Identity(LatestRecruited[j]["recruiter"])
        if IdentityMember and IdentityMember["name"] and IdentityRecruiter and IdentityRecruiter["name"] then
            local Table = { 
                id = LatestRecruited[j]["passport"],
                name = IdentityMember["name"],
                timer = LatestRecruited[j]["timer"],
                recruiter = IdentityRecruiter["name"] 
            }
            FormatLatestRecruited[#FormatLatestRecruited+1] = Table
        end
    end
    
    LatestRecruited = FormatLatestRecruited
    table.sort(alltimeRecruitedRanking, function (a, b) return a["total"] > b["total"] end)
    table.sort(monthRecruitedRanking, function (a, b) return a["total"] > b["total"] end)
    
    if #alltimeRecruitedRanking > 5 then
        for j=1,#alltimeRecruitedRanking do
            if j > 5 then
                alltimeRecruitedRanking[j] = nil
            end
        end
    end
    
    if #monthRecruitedRanking > 5 then
        for j=1,#alltimeRecruitedRanking do
            if j > 5 then
                monthRecruitedRanking[j] = nil
            end
        end
    end
    local Leader = "N/A"
    if result[i]["leader"] and result[i]["leader"] > 0 then
        local LeaderIdentity = vRP.Identity(result[i]["leader"])
        if LeaderIdentity then
            Leader = LeaderIdentity["name"].." "..LeaderIdentity["name2"]
            LeaderId = parseInt(result[i]["leader"])
        end
    end
    
    groupCache[result[i]["name"]] = { 
        groupId = groupId, 
        discord = result[i]["discord"] or "", 
        members = members, 
        bankLogs = bankLogs, 
        amount = result[i]["bankAmount"],
        sorted = members,
        squads = Squads,
        SquadsMessages = SquadsMessages,
        organization_points = result[i]["organization_points"],
        messages = Messages,
        leader = Leader,
        leaderid = LeaderId,
        withdraw = { 
            alltime = allTimeWithdraw, 
            month = monthWithdraw 
        },
        
        deposit = { 
            alltime = allTimeDeposit,
            month = monthDeposit 
        },
        
        analytics = { 
            allTimeRecruited = parseInt(#allTimeGroupRecruited),
            monthRecruited = parseInt(#monthRecruited),
            latestRecruited = LatestRecruited,
            alltimeRecruitedRanking = alltimeRecruitedRanking,
            monthRecruitedRanking = monthRecruitedRanking
        }
    }
    -- print("Carregado Organização: "..result[i]["name"].." | ID: "..groupId)
end

CreateThread(function()
    Wait(1000)
    local result = vRP.Query("painel/getallGroups")

    -- print("Abrindo Painel...")
    
    for name,_ in pairs(groupsConfig) do
        create[name] = true
    end
    
    for i=1,#result do
        -- print("Loading Group: "..result[i]["name"].." | ID: "..result[i]["id"].."")
        CreateThread(function()
            xpcall(
                function()
                    StartPainel(result, i)
                end,
                function(err)
                    print( ('Salary tick error! groupId=%d'):format(i), err )
                end
            )
        end)
    end
    -- print("Painel Carregado!")
    Wait(600000)
    for k,v in pairs(create) do
        vRP.Query("painel/insertOnPainel",{ name = k })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function updateSortedMembers(Group)
    groupCache[Group]["sorted"] = groupCache[Group]["members"]
    for i=1,#groupCache[Group]["sorted"] do
        if groupCache[Group]["sorted"][i]["online"] == nil then
            groupCache[Group]["sorted"][i]["online"] = false
        end
    end
end

function lastLogin(Passport)
    if Passport then
        local rows = vRP.Query("accounts/getLastLogin",{ Passport = Passport })
        if rows[1] and rows[1]["login"] then
            return rows[1]["login"]
        else
            return os.time()
        end
    end
end

RegisterCommand("painel", function(source, Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local source = source
        local Passport = vRP.Passport(source)
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
        if GlobalState["Restarting"] then
            TriggerClientEvent("Notify",source,"negado","O servidor ira reiniciar em breve.",5000,"REINICIAR")
            return false
        end
        if Passport and Job and Hierarchy then
            if groupsConfig[Job] and groupCache[Job] then
                local Identity = vRP.Identity(Passport)
                local UserName = Identity["name"].." "..Identity["name2"]
                if Hierarchy then
                    table.sort(groupCache[Job]["sorted"],compareMembers)
                    local TotalPages = getNumPages(groupCache[Job]["sorted"])
                    TriggerClientEvent("Painel:Open",source,Hierarchy,Job,getAllOnline(Job),#groupCache[Job]["members"],TotalPages,Rank,groupCache[Job]["discord"])
                end
            end
        end
        
    end
end)

function getGroupCache(Job)
    return groupCache[Job]["members"],groupCache[Job]["amount"],groupCache[Job]["bankLogs"],vRP.GetNewbieInfo() or {},groupCache[Job]["withdraw"],groupCache[Job]["deposit"],groupCache[Job]["analytics"]
end

function Server.searchByName(Name)
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    if Job and groupCache[Job] and groupCache[Job]["members"] then
        return searchTableByName(groupCache[Job]["members"],Name)
    end
end

function Server.searchByID(Id)
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    if Job and groupCache[Job] and groupCache[Job]["members"] then
        return searchTableById(groupCache[Job]["members"],parseInt(Id))
    end
end

function Server.getUserGroups()
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    if Passport and Job and Hierarchy then
        if groupsConfig[Job] and groupCache[Job] then
            local Identity = vRP.Identity(Passport)
            local UserName = Identity["name"].." "..Identity["name2"]
            if Hierarchy then
                local Table = getDataPerPage(groupCache[Job]["sorted"],1)
                local TotalPages = getNumPages(groupCache[Job]["sorted"])
                return Hierarchy,Job,getAllOnline(Job),Table,#groupCache[Job]["members"],TotalPages
            end
        end
    end
end

function Server.getBankInfo()
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    if Passport and Job and groupsConfig[Job] and Hierarchy and groupCache[Job] then
        local Table = {
            Balance = groupCache[Job]["amount"],
            History = groupCache[Job]["bankLogs"],
            Withdraw = groupCache[Job]["withdraw"],
            Deposit = groupCache[Job]["deposit"]
        }
        return Table
    end
end

function BankInfo(Job)
    if Job and groupsConfig[Job] and groupCache[Job] then
        local Table = {
            Balance = groupCache[Job]["amount"],
            History = groupCache[Job]["bankLogs"],
            Withdraw = groupCache[Job]["withdraw"],
            Deposit = groupCache[Job]["deposit"]
        }
        return Table
    end
end

function Server.getMembersInfo(Page)
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    if Passport and Job and groupsConfig[Job] and Hierarchy and groupCache[Job] then
        local Table = getDataPerPage(groupCache[Job]["sorted"],Page)
        return Table
    end
end

function Server.getAnalytics()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Job = vRP.UserGroupByType(Passport,'Job')
        if Job then
            return groupCache[Job]["analytics"]
        end
    end
end

function Server.getGroupMessages()
    local source = source
    local Passport = vRP.Passport(source)
    
    if Passport then
        local Job = vRP.UserGroupByType(Passport,'Job')
        if Job and groupCache[Job] then
            return groupCache[Job]["messages"] or {{}}
        end
    end
end

function Server.postNewMessage(Message)
    local source = source
    local Passport = vRP.Passport(source)
    
    if Passport then
        local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
        if Job and groupCache[Job] and Rank <= 2 then
            vRP.Query("painel/newMessage",{GroupId = groupCache[Job]["groupId"], Author = Passport, Message = Message})
            local rows = vRP.Query("painel/getMessages",{GroupId = groupCache[Job]["groupId"]})
            groupCache[Job]["messages"][#groupCache[Job]["messages"]+1] = rows
        end
    end
end


local NewbieInfo = {}

function Server.getNewbieInfo()
    local source = source
    local Passport = vRP.Passport(source)
    
    if Passport then
        local Job = vRP.UserGroupByType(Passport,'Job')
        if Job then
            if not NewbieInfo["Timer"] or os.time() - NewbieInfo["Timer"] > 60 then
                NewbieInfo["Info"] = vRP.GetNewbieInfo()
                NewbieInfo["Timer"] = os.time()
            end
            NewbieInfo["Timer"] = os.time()
            return getDataPerPage(NewbieInfo["Info"],1),os.time(),getNumPages(NewbieInfo["Info"]),#NewbieInfo["Info"]
        end
    end
end

function Server.getNewbieInfoPage(Page)
    return getDataPerPage(NewbieInfo["Info"],Page),os.time()
end

function getAllOnline(permission)
    local Table,TotalOnline = vRP.NumPermission(permission)
    return TotalOnline
end

function Server.bank(Type,name,amount)
    local source = source
    local Passport = vRP.Passport(source)
    if GlobalState["Restarting"] then
        TriggerClientEvent("Notify",source,"negado","O servidor ira reiniciar em breve.",5000,"REINICIAR")
        return false
    end
    if Passport and vRP.HasGroup(Passport, name, 2) then
        return bankFunctions[Type](source,Passport,parseInt(amount))
    end
end

function Server.setUser(Type,Passport)
    local source = source
    local OwnerPassport = vRP.Passport(source)
    if GlobalState["Restarting"] then
        TriggerClientEvent("Notify",source,"negado","O servidor ira reiniciar em breve.",5000,"REINICIAR")
        return false
    end
    if Hiring[OwnerPassport] then
        TriggerClientEvent("Notify2",source,"#hiringPendent")
        return
    end
    local Job,Rank = vRP.UserGroupByType(OwnerPassport,'Job')
    if OwnerPassport and Job then
        return groupFunctions[Type](source,parseInt(Passport))
    end
end

function Server.buyStore(Class,Item,Type,Amount,Id)
    local Source = source
    local Passport = vRP.Passport(Source)
    local Job,Rank = vRP.UserGroupByType(Passport,'Job')
    if GlobalState["Restarting"] then
        TriggerClientEvent("Notify",source,"negado","O servidor ira reiniciar em breve.",5000,"REINICIAR")
        return false
    end
    if Passport and Job then
        if storeConfig[Job] and Rank <= 2 then
            local Available = false
            for i=1,#storeConfig[Job] do
                if storeConfig[Job][i]["itemName"] == Item and storeConfig[Job][i]["type"] == Type then
                    Available = true
                    break
                end
            end
            if Available then
                if groupCache[Job]["leaderid"] == Passport then
                    arsenalFunctions[Class](Source,Passport,Item,Type,Amount,Id)
                end
            end
        end
    end
end

function GetPriceStore(Group,Item,Type,Amount)
    local Price = 0
    Group = "Barragem"
    for i=1,#storeConfig[Group] do
        if storeConfig[Group][i]["itemName"] == Item and storeConfig[Group][i]["type"] == Type then
            Price = storeConfig[Group][i]["price"] * Amount
            break
        end
    end
    return Price
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("multaradm",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin") then
            local Keyboard = vKEYBOARD.keyDouble(source,"Nome da fac:","Valor:")
            bankFunctions["remove"](source,Passport,parseInt(Keyboard[2]),Keyboard[1])
        end
    end
end)

function updateBank(name)
    vRP.Query("painel/updateGroup",{ GroupId = groupCache[name]["groupId"], bankAmount = groupCache[name]["amount"] })
    table.sort(groupCache[name]["bankLogs"], function (a, b) return a["timer"] > b["timer"] end)
end

function insertBankLog(Name,Passport,Type,Quantity)
    vRP.Query("painel/insertBankLog",{ groupId = groupCache[Name]["groupId"], passport = Passport, type = Type, quantity = Quantity })
end

function ChangeGroup(Passport)
    local IdentityMember = vRP.Identity(Passport)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,"Job")
    if Job and groupCache[Job] then
        local alltimeRecruited = vRP.Query("painel/getMemberTotalRecruited",{ groupid = groupId, passport = Passport })
        local monthRecruited = vRP.Query("painel/getMemberMonthRecruited",{ groupid = groupId, passport = Passport })
        local LastLogin = lastLogin(Passport)
        local Position = getUserPosition(groupCache[Job]["members"],Passport)
        local members = groupCache[Job]["members"]
        if Position and members[Position] then
            local source = vRP.Source(Passport)
            local online = false
            if source then
                online = true
            end
            local Table = { 
                id = Passport,
                name = IdentityMember["name"],
                role = tonumber(Rank) or 5,
                lastlogin = LastLogin,
                phone = IdentityMember["phone"],
                online = online and true or false
            }
            groupCache[Job]["members"][Position] = Table
            return Table
        end
    end
end

AddEventHandler("painel:addUserGroup",function(Passport,Recruiter,Job)
    local _,Rank,Group = vRP.UserGroupByType(Passport,"Job")
    local sourceRecruiter = vRP.Source(Recruiter)
    local Type = "Recruit"
    local Data = {}
    Passport = parseInt(Passport)
    if Passport and Job and groupCache[Job] then
        local members = groupCache[Job]["members"]
        local source = vRP.Source(Passport)
        local online = false
        if source then
            online = true
        end
        local Position = getUserPosition(groupCache[Job]["members"],Passport)
        if not Position and not members[Position] then
            local IdentityMember = vRP.Identity(Passport)
            local IdentityRecruiter = vRP.Identity(Recruiter)
            if IdentityRecruiter and IdentityMember then
                local _,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,"Job")
                local LastLogin = lastLogin(Passport)
                local alltimeRecruited = vRP.Query("painel/getMemberTotalRecruited",{ groupid = groupId, passport = Passport })
                local monthRecruited = vRP.Query("painel/getMemberMonthRecruited",{ groupid = groupId, passport = Passport })
                
                local Table = { 
                    id = Passport,
                    name = IdentityMember["name"],
                    role = tonumber(Rank) or 5,
                    lastlogin = LastLogin,
                    phone = IdentityMember["phone"],
                    online = online and true or false
                } 
                
                table.insert(groupCache[Job]["members"],Table)
                vRP.Query("painel/insertMember",{ Passport = Passport, GroupId = groupCache[Job]["groupId"], RoleId = 1, Recruiter = Recruiter })
                PlayerPoints[Passport] = 0
            end
        end
    end
end)

function UpdatePlayerStatus(Passport,Status)
    if Passport then
        local Job,Rank,Group = vRP.UserGroupByType(Passport,"Job")
        if groupCache[Job] then
            local Position = getUserPosition(groupCache[Job]["members"],Passport)
            if Position then
                groupCache[Job]["members"][Position]["online"] = Status and true or false
                groupCache[Job]["members"][Position]["lastlogin"] = os.time()
            end
            updateSortedMembers(Job)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source,First)
    local Job,Rank,Group = vRP.UserGroupByType(Passport,"Job")
    if Passport then
        vRP.Query("characters/updateLogin",{ id = Passport })
        if Job and groupCache[Job] then
            UpdatePlayerStatus(Passport,true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
    local Job,Rank,Group = vRP.UserGroupByType(Passport,"Job")
    if Job and groupCache[Job] then
        UpdatePlayerStatus(Passport,false)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLEADER
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.getVip()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Job,Rank,Group = vRP.UserGroupByType(Passport,"Job")
        if Job and groupCache[Job] then
            local Consult = vRP.Query("painel/getallVip",{ name = Job })
            if Consult and Consult[1] then
                return Consult[1]["level"]
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLEADER
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.getleader()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local Job,Rank,Group = vRP.UserGroupByType(Passport,"Job")
        if Job and groupCache[Job] then
            local Leader = groupCache[Job]["leader"]
            return Leader
        end
    end
end

RegisterCommand("setleader", function(source, Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Organização:","Passaporte/id:")
            if Keyboard and Keyboard[1] and Keyboard[2] then
                local Org = Keyboard[1]
                local Leader = parseInt(Keyboard[2])
                if groupCache[Org] then
                    local LeaderIdentity = vRP.Identity(Leader)
                    if LeaderIdentity then
                        local LeaderName = LeaderIdentity["name"].." "..LeaderIdentity["name2"]
                        groupCache[Org]["leader"] = LeaderName
                        vRP.Query("painel/setLeader",{ GroupId = groupCache[Org]["groupId"], Leader = Leader })
                        TriggerClientEvent("Notify",source,"verde","Você definiu <b>"..LeaderName.."</b> como líder da "..Org..".",5000,"LIDER")
                        -- TriggerClientEvent("Notify2",source,"#setleader",{msg=LeaderName,msg2=Org})
                    end
                else
                    TriggerClientEvent("Notify",source,"vermelho","Organização não encontrada.",5000,"LIDER")
                    -- TriggerClientEvent("Notify2",source,"#orgNEncontrada")
                end
            end
        end
    end
end)

function SetLeader(Org,Leader)
    local Leader = parseInt(Leader)
    if groupCache[Org] then
        local LeaderIdentity = vRP.Identity(Leader)
        if LeaderIdentity then
            local LeaderName = LeaderIdentity["name"].." "..LeaderIdentity["name2"]
            groupCache[Org]["leader"] = LeaderName
            vRP.Query("painel/setLeader",{ GroupId = groupCache[Org]["groupId"], Leader = Leader })
        end
    end
end
exports("SetLeader",SetLeader)

vRP.Prepare("painel/getBuffs", "SELECT name,buff FROM painel")
RegisterCommand("listbuffs", function(source, Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local result = vRP.Query("painel/getBuffs")
            local Message = "Buffs: <br>"
            for i=1,#result do
                Message = Message..result[i]["name"].." - "..result[i]["buff"].."<br>"
            end
            TriggerClientEvent("BigNotify",source,"verde",Message,60000*2,"BUFFS")
        end
    end
end)

vRP.Prepare("painel/ChangeAlias", "UPDATE painel SET alias = @alias WHERE name = @Name")
RegisterCommand("changealias", function(source, Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Organizacao:","Alias:")
            if Keyboard and Keyboard[2] then
                vRP.Query("painel/ChangeAlias",{ alias = Keyboard[2], Name = Keyboard[1] })
                Wait(250)
                TriggerEvent("ChangeFacBlips")
                TriggerClientEvent("Notify",source,"verde","Alias da organização <b>"..Keyboard[1].."</b> alterado para <b>"..Keyboard[2].."</b>.",5000,"LIDER")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE DATABASE
-----------------------------------------------------------------------------------------------------------------------------------------
function SavePainel()
    for Group,Info in pairs(groupCache) do
        local Hierarchy = vRP.Hierarchy(Group)
        vRP.Query("painel/updateGroup",{ GroupId = Info["groupId"], bankAmount = Info["amount"]})
        for i=1,#Info["members"] do
            local memberRole = 3
            if Info["members"][i] then
                local Passport = Info["members"][i]["id"]
                if Hierarchy then
                    for j=1,#Hierarchy do
                        if Info["members"][i]["role"] == Hierarchy[j] then
                            memberRole = tonumber(j)
                        end
                    end
                    if memberRole > 3 then
                        memberRole = 3
                    end
                    local test = vRP.Query("painel/updateMember",{ GroupId = Info["groupId"], Passport = Passport, Role = memberRole, Points = PlayerPoints[Passport] })
                end
            end
        end
    end
    -- print("O resource painel salvou os dados.!")
end

AddEventHandler("SaveServer",function(Passport,source,First)
    SavePainel()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("SavePainel",function(Source)
    if Source == 0 then
        SavePainel()
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
function getBank(Group)
    if groupCache[Group] and groupCache[Group]["amount"] then
        return groupCache[Group]["amount"]
    end
end
exports("getBank",getBank)


function GivePointsPlayer(Group,TotalPlayers)
    local Item = "premium03"
    local Type = "organization"
    local Amount = 1
    if groupCache[Group] then
        local Price = GetPriceStore(Group,Item,Type,Amount)
        local PointsPPlayer = 0.000705 / 150 * Price
        local Points = PointsPPlayer * TotalPlayers
        addGroupPoints(Group,Points)
        -- print("O grupo "..Group.." recebeu "..Points.." pontos, Pontos por player: "..PointsPPlayer)
    end
end
exports("GivePointsPlayer",GivePointsPlayer)

function removeUserPoints(Passport,Points)
    local source = vRP.Source(Passport)
    local Job = vRP.UserGroupByType(Passport,"Job")
    if PlayerPoints[Passport] then
        PlayerPoints[Passport] = PlayerPoints[Passport] - Points
        if source then
            TriggerClientEvent("painel:updateGroups",source,"Points",{ user = Points, group = groupCache[Job]["organization_points"] })
            vRP.Query("painel/UpdatePoint",{ GroupId = groupCache[Job]["groupId"], Points = groupCache[Job]["organization_points"] })
        end
        return true
    end
    return false
end
exports("removeUserPoints",removeUserPoints)

function getUserPoints(Passport)
    local Points = 0
    if PlayerPoints[Passport] then
        Points = PlayerPoints[Passport]
    end
    return Points
end
exports("getUserPoints",getUserPoints)

function getGroupPoints(Group)
    local Points = 0
    if groupCache[Group] then
        Points = groupCache[Group]["organization_points"]
    end
    return Points
end

function Server.getGroupPoints(Group)
    local Points = 0
    if groupCache[Group] then
        Points = groupCache[Group]["organization_points"]
    end
    return Points
end

function addGroupPoints(Group,Points)
    if groupCache[Group] then
        groupCache[Group]["organization_points"] = groupCache[Group]["organization_points"] + Points
        -- vRP.Query("painel_points_history/addPoints",{ groupId = groupCache[Group]["groupId"], amount = Points })
        vRP.Query("painel/UpdatePoint",{ GroupId = groupCache[Group]["groupId"], Points = groupCache[Group]["organization_points"] })
        return true
    end
    return false
end
exports("addGroupPoints",addGroupPoints)

function removeGroupPoints(Group,Points)
    if groupCache[Group] then
        groupCache[Group]["organization_points"] = groupCache[Group]["organization_points"] - Points
        return true
    end
    return false
end
exports("removeGroupPoints",removeGroupPoints)

function addUserPoints(Passport,Points)
    local source = vRP.Source(Passport)
    local Job = vRP.UserGroupByType(Passport,"Job")
    if PlayerPoints[Passport] then
        PlayerPoints[Passport] = PlayerPoints[Passport] + Points
        if source then
            TriggerClientEvent("painel:updateGroups",source,"Points",{ user = Points, group = groupCache[Job]["organization_points"] })
        end
        return true
    end
    return false
end
exports("addUserPoints",addUserPoints)

RegisterCommand("setarpontosfac",function(source,Message)
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",2) then
        local Keyboard = vKEYBOARD.keyDouble(source,"Organizacao:","Pontos:")
        if Keyboard and Keyboard[1] then
            addGroupPoints(Keyboard[1],Keyboard[2])
            TriggerClientEvent("Notify",source,"verde","Você adicionou <b>"..Keyboard[2].."</b> pontos para o grupo "..Keyboard[1]..".",5000,"PAINEL")
            -- TriggerClientEvent("Notify2",source,"#setarpontosfac",{msg=Keyboard[2],msg2=Keyboard[1]})
        end
    end
end)


function RemoveUserPainel(Passport,Permission)
    local Passport = parseInt(Passport)
    if groupCache[Permission] then
        local Position = getUserPosition(groupCache[Permission]["members"],Passport)
        if Position then
            if groupCache[Permission] then
                if groupCache[Permission]["members"][Position] then
                    table.remove(groupCache[Permission]["members"],Position)
                end
                vRP.Query("painel/setMemberFired",{ Passport = Passport, GroupId = groupCache[Permission]["groupId"] })
            end
            return true
        else
            if groupCache[Permission] then
                for i=1,#groupCache[Permission]["members"] do
                    if groupCache[Permission]["members"][i]["id"] == Passport then
                        HasPosisiton = true
                        table.remove(groupCache[Permission]["members"],i)
                        break
                    end
                end
                vRP.Query("painel/setMemberFired",{ Passport = Passport, GroupId = groupCache[Permission]["groupId"] })
            end
        end
    end
end
exports("RemoveUserPainel",RemoveUserPainel)

RegisterCommand("clearpainel",function(source,args,rawCommand)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Admin",2) then
            local Keyboard = vKEYBOARD.keySingle(source,"Nome:")
            if Keyboard and Keyboard[1] then
                CleanGroup(Keyboard[1],source)
            else
                TriggerClientEvent("Notify",source,"vermelho","Você não digitou o nome do grupo corretamente mula.",5000,"PAINEL")
                -- TriggerClientEvent("Notify2",source,"#nomeErradoGrupo")
                end
            end
        end
    end)
    
    function CleanGroup(Group,source)
        if groupCache[Group] then
            vRP.ClearPermission(Group)
            Wait(500)
            local groupId = groupCache[Group]["groupId"]
            groupCache[Group] = { 
                groupId = groupId, 
                members = {}, 
                bankLogs = {}, 
                amount = 0,
                messages = {{}},
                sorted = {},
                organization_points = 0,
                leader = "N/A",
                leaderid = 0,
                withdraw = { 
                    alltime = {{}}, 
                    month = {{}}
                },
                
                deposit = { 
                    alltime = {{}}, 
                    month = {{}}
                },
                
                analytics = { 
                    allTimeRecruited = 0,
                    monthRecruited = 0,
                    latestRecruited = {},
                    alltimeRecruitedRanking = {},
                    monthRecruitedRanking = {}
                }
            }
            vRP.Query("painel/clearGroupMembers",{ GroupId = groupId })
            vRP.Query("painel/clearGroupMessages",{ GroupId = groupId })
            vRP.Query("painel/ClearGroup",{ GroupId = groupId, bankAmount = 0, Points = 0 })
            if source then
                TriggerClientEvent("Notify",source,"verde","Você limpou o grupo <b>"..Group.."</b>",5000,"PAINEL")
            end
            -- TriggerClientEvent("Notify2",source,"#limpouGrupo",{msg=Group})
        end
    end
    exports("CleanGroup",CleanGroup)
    
    local ConfigSMS = {
        "Aee, ví que tu chegou... tamo precisando uma galera responsa pra nós ajudar aqui na família, anima? Me chama no whats: %s",
        "Olha quem tá na área... Tenho uns trampos pra ti heeim... Da um toque no whats: %s",
        "Pow, como que tu tá? Me chama manda um whats, preciso falar contigo! %s",
    }
    
    local SMSCooldown = {}
    function Server.getPhone(User)
        local Identity = vRP.Identity(User)
        if Identity then
            return Identity["phone"]
        end
    end
    
    function Server.sendSMS(User)
        local source = source
        local Passport = vRP.Passport(source)
        local inCD = false
        
        if SMSCooldown[Passport] then
            for i=1,#SMSCooldown[Passport] do
                if SMSCooldown[Passport][i]["User"] == User and os.time() > SMSCooldown[Passport][i]["Timer"] then
                    TriggerClientEvent("Notify",source,"vermelho","Você já enviou uma mensagem recentemente.",5000,"PAINEL")
                    -- TriggerClientEvent("Notify2",source,"#msgRecentemente")
                    inCD = true
                end
            end
        end
        
        if inCD then
            return
        end
        
        if not SMSCooldown[Passport] then
            SMSCooldown[Passport] =  { User = User, Timer = os.time() + 120 }
        else
            table.insert(SMSCooldown[Passport],{ User = User, Timer = os.time() + 120 })
        end
        
        if Passport then
            local Identity = vRP.Identity(Passport)
            local Source = vRP.Source(User)
            local Random = math.random(1,#ConfigSMS)
            local Message = ConfigSMS[Random]
            local Identity_User = vRP.Identity(User)
            Message = Message:format(Identity_User["phone"])
            if Source then
                TriggerClientEvent("smartphone:createSMS",Source,Identity["name"].." "..Identity["name2"],Message)
            end
            TriggerClientEvent("Notify",source,"verde","Você enviou uma mensagem para <b>"..Identity_User["name"].." "..Identity_User["name2"].."</b>.",5000,"PAINEL")
            -- TriggerClientEvent("Notify2",source,"#msgPara",{msg=Identity_User["name"],msg2=Identity_User["name2"]})
        end
    end
    
RegisterCommand("paineldiscord", function(source, Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local source = source
        local Passport = vRP.Passport(source)
        if vRP.HasGroup(Passport,"Admin",2) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Grupo:","Link do convite do discord:")
            if Keyboard and Keyboard[1] then
                local Job = Keyboard[1]
                if groupCache[Job] then
                    vRP.Query("painel/setDiscord",{ discord = Keyboard[2], name = Job })
                    groupCache[Job]["discord"] = Keyboard[2]
                    TriggerClientEvent("Notify",source,"verde","Você adicionou o discord <b>"..Keyboard[1].."</b> para o grupo "..Job..".",5000,"PAINEL")
                    -- TriggerClientEvent("Notify2",source,"#discordParaGrupo",{msg=Keyboard[1],msg2=Job})
                else
                    TriggerClientEvent("Notify",source,"vermelho","Você digitou o nome do grupo incorretamente.",5000,"PAINEL")
                    -- TriggerClientEvent("Notify2",source,"#nomeGrupoIncorreto")
                end
            end
        end
    end
end)

function SetDiscord(Org,Link)
    local Org = Keyboard[1]
    if groupCache[Org] then
        vRP.Query("painel/setDiscord",{ discord = Link, name = Org })
        groupCache[Org]["discord"] = Link
    end
end
exports("SetDiscord",SetDiscord)

local KitInicianteConfig = {
    ["WEAPON_PISTOL_MK2"] = 5,
    ["WEAPON_SPECIALCARBINE_MK2"] = 2,
    ["WEAPON_PISTOL_AMMO"] = 1250,
    ["WEAPON_RIFLE_AMMO"] = 500,
    ["cocaine"] = 10,
}

RegisterCommand("kitiniciante", function(source, Message)
    local Passport = vRP.Passport(source)
    if Passport then
        local source = source
        local Passport = vRP.Passport(source)
        if KitIniciante[Passport] then
            for Item,Amount in pairs(KitInicianteConfig) do
                vRP.GenerateItem(Passport,Item,Amount,true)
            end
            KitIniciante[Passport] = nil
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
cityName = GetConvar("cityName", "Base")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Server = {}
Tunnel.bindInterface("calladmin",Server)

local InfoGroups = {
    ["total"] = 0,
    ["hired"] = 0,
    ["lost"] = 0,
    ["activated"] = 0,
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Tickets = {}
-- Caso o admin aceite um chamado e venha a cair/relogar, o player fica com a tela o tempo inteiro com a nui do chamado

local TicketsInfo = {
    ["Total"] = 0,
    ["Answered"] = 0,
    ["Finished"] = 0,
    ["Cancelled"] = 0,
}

local Ranking = {}
local PlayerCooldown = {}
local AdminCooldown = {}
local DiamondAmount = 1
local AnsweredCooldown = {}

if cityName == "Base" then
    -- DiamondAmount = 1
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TicketsS
-----------------------------------------------------------------------------------------------------------------------------------------
TicketsState = {}
GlobalState["AnswerTime"] = 0
local Tickets = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("support_tickets/CountAllTicket", "SELECT COUNT(*) AS count FROM support_tickets")
vRP.Prepare("support_tickets/CountAnswered", "SELECT COUNT(*) AS count FROM support_tickets WHERE answered IS NOT NULL AND cancelled = 0")
vRP.Prepare("support_tickets/CountFinished", "SELECT COUNT(*) AS count FROM support_tickets WHERE finished IS NOT NULL AND cancelled = 0")
vRP.Prepare("support_tickets/CountCancelled", "SELECT COUNT(*) AS count FROM support_tickets WHERE cancelled = 1")
vRP.Prepare("support_tickets/CountUnanswered", "SELECT COUNT(*) AS count FROM support_tickets WHERE answered IS NULL")
vRP.Prepare("support_tickets/CreateTicket", "INSERT INTO support_tickets(Passport,Type,created) VALUES (@Passport, @Type, current_timestamp()) RETURNING id")
vRP.Prepare("support_tickets/updateAdmin", "UPDATE support_tickets SET Admin = @Admin WHERE id = @id")
vRP.Prepare("support_tickets/updateSolved", "UPDATE support_tickets SET solved = @solved WHERE id = @id")
vRP.Prepare("support_tickets/updateCancelled", "UPDATE support_tickets SET cancelled = 1 WHERE id = @id")
vRP.Prepare("support_tickets/Answered", "UPDATE support_tickets SET answered = current_timestamp() WHERE id = @id")
vRP.Prepare("support_tickets/Finished", "UPDATE support_tickets SET finished = current_timestamp() WHERE id = @id")
vRP.Prepare("support_tickets/GetTicketCount","SELECT Admin,COUNT(*) as TotalTicket,SUM(solved) as Solved FROM support_tickets WHERE YEARWEEK(created) = YEARWEEK(CURRENT_TIMESTAMP()) GROUP BY `Admin`")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CACHE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    local Query = vRP.Query("support_tickets/GetTicketCount")

    for i=1,#Query do
        if Query[i]["Admin"] ~= 0 then
            local Identity = vRP.Identity(Query[i]["Admin"]) or { name = "Administrador", name2 = "" }
            local Rating = parseInt((Query[i]["Solved"] / Query[i]["TotalTicket"]) * 100)
            Ranking[#Ranking+1] = {
                ["Name"] = Identity["name"].." "..Identity["name2"],
                ["TotalTicket"] = Query[i]["TotalTicket"],
                ["Rating"] = Rating.."%",
            }
        end
    end

    table.sort(Ranking,function(a,b)
        return a["TotalTicket"] > b["TotalTicket"]
    end)

    local Total = vRP.Query("support_tickets/CountAllTicket")

    if Total[1] then
        TicketsInfo["Total"] = Total[1]["count"]
    end

    local Answered = vRP.Query("support_tickets/CountAnswered")

    if Answered[1] then
        TicketsInfo["Answered"] = Answered[1]["count"]
    end

    local Finished = vRP.Query("support_tickets/CountFinished")

    if Finished[1] then
        TicketsInfo["Finished"] = Finished[1]["count"]
    end

    local Cancelled = vRP.Query("support_tickets/CountCancelled")

    if Cancelled[1] then
        TicketsInfo["Cancelled"] = Cancelled[1]["count"]
    end
end)
local inDashBoard = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.openDashboard()
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin",5) then
        inDashBoard[source] = true
        return rankStatistics(), Ranking, TicketsInfo, TicketsState
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
local CommandNotify = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHAMADOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chamados",function(source,Message)
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport,"Base") or vRP.HasGroup(Passport,"Admin",1) then
            if not CommandNotify[source] then
                TriggerClientEvent("NotifyId",source,2)
                CommandNotify[source] = true
            else
                TriggerClientEvent("NotifyId",source,3)
                CommandNotify[source] = nil
            end
        end
    end
end)

function Server.CreateTicket(Type,Text)
    local source = source
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    local TicketID = false
    if Identity then
        local Name = Identity["name"].." | #"..Passport
        local Query = vRP.Query("support_tickets/CreateTicket", { Passport = Passport, Type = Type })
        if Query[1] then
            TicketID = Query[1]["id"]
            local Time = os.time()
            Tickets[TicketID] = { Passport = Passport, Type = Type, Created = os.time(), Answered = nil, Finished = nil, Admin = 0, Cancelled = 0, Admin = 0 }
            TicketsState[#TicketsState+1] = { Description = Text, id = TicketID, Player = Name, Status = 0, Type = Type, Time = os.date("%H:%M",Time), Admin = 0 }
            TicketsInfo["Total"] = TicketsInfo["Total"] + 1

            for Sources,_ in pairs(inDashBoard) do
                async(function()
                    TriggerClientEvent("calladmin:UpdateList",Sources,TicketsState)
                end)
            end
            local Admins = vRP.NumPermission("Admin")
            local Count = totalTicketOpen()
            for _,Sources in pairs(Admins) do
                async(function()
                    if not CommandNotify[Sources] then
                        TriggerClientEvent("NotifyId",Sources,1,Count)
                        if Count >= 5 then
                            TriggerClientEvent("sounds:Private",Sources,"calladmin",0.3)
                        end
                    end
                end)
            end
        end
    end
    return TicketID
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANSWER
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.AnswerTicket(TicketID)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and vRP.HasGroup(Passport,"Admin",5) then
        AnsweredCooldown[Passport] = os.time() + 0
        if not AdminCooldown[Passport] or os.time() > AdminCooldown[Passport] then
            local Identity = vRP.Identity(Passport)
            if Tickets[TicketID] and Tickets[TicketID]["Answered"] == nil then
                if Tickets[TicketID]["Passport"] == Passport then
                    TriggerClientEvent("NotifyId",source,4)
                    return
                end
                AdminCooldown[Passport] = os.time() + 0
                Tickets[TicketID]["Answered"] = os.time()
                Tickets[TicketID]["Admin"] = Passport
                vRP.Query("support_tickets/updateAdmin", { Admin = Passport, id = TicketID })
                vRP.Query("support_tickets/Answered", { id = TicketID })
                local Selected = 0
                for i=1,#TicketsState do
                    if TicketsState[i]["id"] == TicketID then
                        TicketsState[i]["Admin"] = source
                        TicketsState[i]["Status"] = 1
                        Selected = i
                        break
                    end
                end
                if TicketsState[Selected] and TicketsState[Selected]["Description"] then
                    TriggerClientEvent("Notify:Text",source,TicketsState[Selected]["Description"])
                end
                TicketsInfo["Answered"] = TicketsInfo["Answered"] + 1
                GlobalState["AnswerTime"] = TimeToAnswer()

                local Player = vRP.Source(Tickets[TicketID]["Passport"])
                local Service = vRP.NumPermission("Admin")

                for Sources,_ in pairs(inDashBoard) do
                    async(function()
                        TriggerClientEvent("calladmin:UpdateList",Sources,TicketsState)
                    end)
                end
                
                if Player then
                    local Ped = GetPlayerPed(Player)
                    if Ped ~= 0 and DoesEntityExist(Ped) then
                        local Coords = GetEntityCoords(Ped)
                        local Bucket = GetPlayerRoutingBucket(Player)
                        TriggerEvent("vRP:BucketServer",source,"Enter",Bucket)

                        vRP.Teleport(source,Coords["x"],Coords["y"],Coords["z"])
                        TriggerClientEvent("calladmin:AnswerTicket",Player,{ staff_id = Passport, staff_name = Identity["name"].." "..Identity["name2"] })

                        if not vRPC.ReturnNoClip(source) then
                            vRPC.noClip(source)
                        end
                        local Admins = vRP.NumPermission("Admin")
                        for _,Sources in pairs(Admins) do
                            async(function()
                                local Custom = {
                                    background = "rgba(159, 108, 0,.70)",
                                }
                                TriggerClientEvent("chat:ClientMessage",Sources,"Administrador ","["..Passport.."] "..vRP.FullName(Passport).." aceitou o chamado de ["..Tickets[TicketID]["Passport"].."] | " .. vRP.FullName(Tickets[TicketID]["Passport"]),"Chamados",false, Custom)	
                            end)
                        end
                    end
                else
                    TriggerClientEvent("NotifyId",source,5)
                end
                
                return true
            end
        else
            TriggerClientEvent("NotifyId",source,6,(os.time()-AdminCooldown[Passport]))
        end
    end

    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANSWER
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.FinishTicket(TicketID)
    local source = source
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    if vRP.HasGroup(Passport,"Admin",5) then
        if AnsweredCooldown[Passport] and os.time() < AnsweredCooldown[Passport] then
            TriggerClientEvent("NotifyId",source,7,(os.time()-AnsweredCooldown[Passport]))
            return
        end

        if Tickets[TicketID] and Tickets[TicketID]["Admin"] ~= Passport then
            TriggerClientEvent("NotifyId",source,8)
            return
        end

        if Tickets[TicketID] and Tickets[TicketID]["Finished"] == nil then
            local PlayerPassport = parseInt(Tickets[TicketID]["Passport"])
            if PlayerPassport == Passport then
                TriggerClientEvent("NotifyId",source,9)
                return
            end
            Tickets[TicketID]["Finished"] = os.time()
            vRP.Query("support_tickets/Finished", { id = TicketID })
            for i=1,#TicketsState do
                if TicketsState[i]["id"] == TicketID then
                    table.remove(TicketsState,i)
                    break
                end
            end
            TicketsInfo["Finished"] = TicketsInfo["Answered"] + 1

            for Sources,_ in pairs(inDashBoard) do
                async(function()
                    TriggerClientEvent("calladmin:UpdateList",Sources,TicketsState)
                end)
            end

            local Player = vRP.Source(PlayerPassport)
            local PlayerIdentity = vRP.Identity(PlayerPassport)
            if not PlayerCooldown[PlayerPassport] then
                PlayerCooldown[PlayerPassport] = {
                    PlayerTimer = os.time() + 60*5,
                    Admin = Passport,
                    AdminTimer = os.time() + 60*60,
                }
                vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = DiamondAmount })
                TriggerClientEvent("NotifyId",source,10,DiamondAmount,PlayerIdentity["name"])
            else
                if os.time() > PlayerCooldown[PlayerPassport]["PlayerTimer"] then
                    if Passport ~= PlayerCooldown[PlayerPassport]["Admin"] then
                        PlayerCooldown[PlayerPassport]["PlayerTimer"] = os.time() + 60*5
                        PlayerCooldown[PlayerPassport]["AdminTimer"] = os.time() + 60*60
                        PlayerCooldown[PlayerPassport]["Admin"] = Passport
                        vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = DiamondAmount })
                        TriggerClientEvent("NotifyId",source,10,DiamondAmount,PlayerIdentity["name"])
                    else
                        if os.time() > PlayerCooldown[PlayerPassport]["AdminTimer"] then
                            PlayerCooldown[PlayerPassport]["PlayerTimer"] = os.time() + 60*5
                            PlayerCooldown[PlayerPassport]["AdminTimer"] = os.time() + 60*60
                            PlayerCooldown[PlayerPassport]["Admin"] = Passport
                            vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = DiamondAmount })
                            TriggerClientEvent("NotifyId",source,10,DiamondAmount,PlayerIdentity["name"])
                        else
                            TriggerClientEvent("NotifyId",source,11)
                        end
                    end
                end
            end
            TriggerClientEvent("Notify:Text",source,"")
            if Player then
                TriggerClientEvent("calladmin:FinishTicket",Player)
            else
                TriggerClientEvent("NotifyId",source,5)
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IS SOLVED
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.isSolved(TicketID,Solved)
    local source = source
    local Passport = vRP.Passport(source)
    local Identity = vRP.Identity(Passport)
    if Tickets[TicketID] and Tickets[TicketID]["Finished"] ~= nil and Tickets[TicketID]["Passport"] == Passport then
        vRP.Query("support_tickets/updateSolved", { solved = Solved, id = TicketID })
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.CancellTicket(TicketID)
    local source = source
    local Passport = vRP.Passport(source)
    if Tickets[TicketID] and Tickets[TicketID]["Passport"] == Passport then
        Tickets[TicketID]["Cancelled"] = 1
        vRP.Query("support_tickets/updateCancelled", { id = TicketID })
        TicketsInfo["Cancelled"] = TicketsInfo["Cancelled"] + 1
        for i=1,#TicketsState do
            if TicketsState[i]["id"] == TicketID then
                table.remove(TicketsState,i)
                break
            end
        end
        local Service = vRP.NumPermission("Admin")

        for Sources,_ in pairs(inDashBoard) do
            async(function()
                TriggerClientEvent("calladmin:UpdateList",Sources,TicketsState)
            end)
        end

        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIME TO ANSWER
-----------------------------------------------------------------------------------------------------------------------------------------
function TimeToAnswer()
    local Total = 0
    local Count = 0
    for k,v in pairs(Tickets) do
        if v["Answered"] ~= nil then
            Total = Total + (v["Answered"] - v["Created"])
            Count += 1
        end
    end
    local WaitTime = Total / Count
    return WaitTime
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TODAY STATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function rankStatistics()
    local Total = 0
    local Answered = 0
    local Finished = 0
    local Cancelled = 0
    for k,v in pairs(Tickets) do
        if v["Answered"] then
            Answered = Answered + 1
        end
        if v["Finished"]  then
            Finished = Finished + 1
        end
        if v["Cancelled"] == 1 then
            Cancelled = Cancelled + 1
        end
        Total = Total + 1
    end
    return { attendedToday = Answered, finalizedCalls = Finished, canceledCalls = Cancelled }
end
function totalTicketOpen()
    local Count = 0
    for i=1,#TicketsState do
        if TicketsState[i]["Status"] and TicketsState[i]["Status"] == 0 then
            Count = Count + 1
        end
    end
    return Count
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN DROP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
    if vRP.HasGroup(Passport,"Admin") then
        if inDashBoard[source] then
            inDashBoard[source] = nil
        end
        for i=1,#TicketsState do
            if parseInt(TicketsState[i]["Admin"]) == parseInt(source) then
                local TicketID = TicketsState[i]["id"]
                Tickets[TicketID]["Answered"] = nil
                Tickets[TicketID]["Admin"] = 0
                Tickets[TicketID]["Cancelled"] = 0
                TicketsState[i]["Admin"] = 0
                TicketsState[i]["Status"] = 0

                vRP.Query("support_tickets/updateAdmin", { Admin = 0, id = TicketID })

                local Player = vRP.Source(parseInt(Tickets[TicketID]["Passport"]))

                if Player then
                    TriggerClientEvent("calladmin:adminDrop",Player)
                else
                    TriggerClientEvent("NotifyId",source,5)
                end

                local Service = vRP.NumPermission("Admin")

                for Sources,_ in pairs(inDashBoard) do
                    if source == Sources then
                        return
                    end
                    async(function()
                        TriggerClientEvent("calladmin:UpdateList",Sources,TicketsState)
                    end)
                end

                break
            end
        end
    end
end)

RegisterNetEvent("calladmin:closeDashBoard")
AddEventHandler("calladmin:closeDashBoard",function()
    local source = source
    if inDashBoard[source] then
        inDashBoard[source] = nil
    end
end)

RegisterNetEvent("calladmin:teleportId")
AddEventHandler("calladmin:teleportId",function(nPlayer)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if vRP.HasGroup(Passport, "Admin") then
            local nSource = vRP.Source(nPlayer)
            if nSource then
                local Ped = GetPlayerPed(nSource)
                if Ped and Ped ~= 0 then
                    -- if not vRPC.ReturnNoClip(source) then
                    --     vRPC.noClip(source)
                    -- end
                    local Coords = GetEntityCoords(Ped)
                    local Bucket = GetPlayerRoutingBucket(nSource)
                    exports["vrp"]:ChangePlayerBucket(source,Bucket)
                    TriggerClientEvent("admin:Teleport",source,Coords)
                    exports["vrp"]:SendWebHook("tpto", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Teleportou pelo painel para o Passaporte:** " .. nPlayer .. " " .. vRP.FullName(nPlayer) .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
                end
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD INFO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("accounts/GetWl",[[
    SELECT 
        COUNT(DISTINCT characters.id) - COUNT(DISTINCT banneds.id) AS total
    FROM 
        (SELECT id FROM characters WHERE DATE(firstspawn) = CURDATE()) AS characters
    LEFT JOIN 
        (SELECT banneds.id FROM banneds 
        INNER JOIN accounts ON banneds.accountId = accounts.id 
        WHERE DATE(accounts.account_create) = CURDATE() AND accounts.email IS NOT NULL) AS banneds
    ON
        characters.id = banneds.id
]])
vRP.Prepare("accounts/GetActivation",[[
    SELECT COUNT(*) AS total
        FROM characters
        INNER JOIN accounts ON accounts.license = characters.license
        WHERE accounts.email IS NOT NULL
        AND DATE(characters.firstspawn) = CURDATE();
]])

CreateThread(function()
    while true do
        local QueryICR = vRP.Query("icr/getDate",{ date = os.date("%Y-%m-%d") })
        local QueryWL = vRP.Query("accounts/GetWl",{})
        local QueryActivation = vRP.Query("accounts/GetActivation",{})
        if QueryICR[1] then
            InfoGroups["total"] = QueryWL[1]["total"] or 0
            InfoGroups["lost"] = (InfoGroups["total"] - InfoGroups["hired"])
            InfoGroups["hired"] = parseInt(((QueryICR[1]["amount"] or 0)/InfoGroups["total"])*100)
            InfoGroups["activated"] = parseInt(((QueryActivation[1]["total"] or 0)/InfoGroups["total"])*100)
        end
        Wait(60000)
    end
end)

function getAllOnline(permission)
    local Table,TotalOnline = vRP.NumPermission(permission)
    return TotalOnline
end

local BlackListGroups = {
    ["Abuser"] = true,
    ["Base"] = true,
    ["Ammogroup"] = true,
    ["Blacks"] = true,
    ["Diamante"] = true,
    ["Dismantle"] = true,
    ["Emergency"] = true,
    ["Esmeralda"] = true,
    ["Especial"] = true,
    ["ClienteBlack"] = true,
    ["ClienteEspecial"] = true,
    ["Iate01"] = true,
    ["Iate02"] = true,
    ["Ilegal"] = true,
    ["Lancamento"] = true,
    ["Laundry"] = true,
    ["Wallg"] = true,
    ["Mansao01"] = true,
    ["Mansao02"] = true,
    ["Mansao03"] = true,
    ["Mansao04"] = true,
    ["Mansao05"] = true,
    ["Mansao06"] = true,
    ["Mansao07"] = true,
    ["Mansao08"] = true,
    ["Mansao09"] = true,
    ["Mansao10"] = true,
    ["Mansao11"] = true,
    ["Mansao12"] = true,
    ["Mansao13"] = true,
    ["Mansao14"] = true,
    ["Mansao15"] = true,
    ["Mansao16"] = true,
    ["Mansao17"] = true,
    ["Mansao18"] = true,
    ["Mansao19"] = true,
    ["Mansao20"] = true,
    ["Mansao21"] = true,
    ["Mansao22"] = true,
    ["Mansao23"] = true,
    ["Mansao24"] = true,
    ["Mansao25"] = true,
    ["Mansao26"] = true,
    ["Mansao27"] = true,
    ["Mansao28"] = true,
    ["Mansao29"] = true,
    ["Mansao30"] = true,
    ["Mansao31"] = true,
    ["Mansao32"] = true,
    ["Mansao33"] = true,
    ["Mansao34"] = true,
    ["Mansao35"] = true,
    ["Mansao36"] = true,
    ["Mansao37"] = true,
    ["Mansao38"] = true,
    ["Mansao39"] = true,
    ["Mansao40"] = true,
    ["Mansao41"] = true,
    ["Mansao42"] = true,
    ["Mansao43"] = true,
    ["Mansao44"] = true,
    ["Mansao45"] = true,
    ["Mansao46"] = true,
    ["Mansao47"] = true,
    ["Mansao48"] = true,
    ["Mansao49"] = true,
    ["Mansao50"] = true,
    ["Natal"] = true,
    ["Noticia"] = true,
    ["Ouro"] = true,
    ["Prata"] = true,
    ["Bronze"] = true,
    ["Black"] = true,
    ["Platina"] = true,
    ["Premium"] = true,
    ["QA"] = true,
    ["Rubi"] = true,
    ["SalarioAvançado"] = true,
    ["SalarioBrabo"] = true,
    ["SalarioDosDeuses"] = true,
    ["SalarioIniciante"] = true,
    ["SalarioMediano"] = true,
    ["Teste1"] = true,
    ["Teste2"] = true,
    ["garagempanamera"] = true,

    ["kitiniciante"] = true,
    ["TESTE1"] = true,
    ["TESTE2"] = true,
    ["Roupas2"] = true,
    ["Spotify"] = true,
    ["Verificado"] = true,
}

function GetAllGroups()
    local Groups = vRP.Groups()
    local Info = {}
    for Group, _ in pairs(Groups) do
        if not BlackListGroups[Group] then
            local onlineCount = getAllOnline(Group)
            Info[Group] = onlineCount
        end
    end

    -- Create a custom sort function to sort based on the number of players online
    table.sort(Info, function(a, b)
        return a > b
    end)

    return Info
end


function Server.getGroups()
    local Info = {
        groups = GetAllGroups(),
        statistics = InfoGroups,
    }
    return Info
end

function Server.getGroupInfo(Group)
    local Table = vRP.NumPermission(Group)
    local List = {}
    for Passports,Sources in pairs(Table) do
        local Name = vRP.FullName(Passports)
        local Level = vRP.HasPermission(Passports,Group)
        if not Level then
            Level = 0
        end
        table.insert(List,{ id = Passports, name = Name, level = Level})
    end
    table.sort(List, function(a, b)
        return a["level"] > b["level"]
    end)
    return List
end

local SuspectCache = {}
AddEventHandler("AC:Suspect",function(Content)
    local Info = {}
    local Passport = Content["user_id"]
    local Name = Passport.." | "..vRP.FullName(Passport)
    local Timestamp = os.time()
    local Date = os.date("%d/%m/%Y %H:%M:%S",Timestamp)
    local Identity = vRP.Identity(Passport)
    local Discord = Identity["discord"]
    local Reason = Content["reason"]
    Info = {
        passport = Passport,
        date = Date,
        discord = Discord,
        name = Name,
        reason = Reason,
        timestamp = Timestamp,
    }
    table.insert(SuspectCache,Info)
    table.sort(SuspectCache, function(a, b)
        return a["timestamp"] < b["timestamp"]
    end)
end)

function Server.GetLastSuspects()
    local List = {
        suspects = {

        }
    }
    for i=1,50 do
        if SuspectCache[i] then
            table.insert(List["suspects"],SuspectCache[i])
        end
    end
    return List
end

-- CreateThread(function()
--     TriggerEvent("AC:Suspect",{
--         user_id = "121",
--         reason = "Teste",
--     })
-- end)

local SuspectFunctions = {
    ["teleport"] = function(Passport,nPlayer)
        local Source = vRP.Source(Passport)
        local nSource = vRP.Source(nPlayer)
        if nSource then
            local Ped = GetPlayerPed(nSource)
            if Ped and Ped ~= 0 then
                local Coords = GetEntityCoords(Ped)
                local Bucket = GetPlayerRoutingBucket(nSource)
                exports["vrp"]:ChangePlayerBucket(source,Bucket)
                TriggerClientEvent("admin:Teleport",source,Coords)
                exports["vrp"]:SendWebHook("tpto", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Teleportou pelo painel para o Passaporte:** " .. nPlayer .. " " .. vRP.FullName(nPlayer) .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
            end
        end
    end,
    ["spectate"] = function(Passport,nPlayer)
        local Source = vRP.Source(Passport)
        TriggerEvent("player:SpectatePlayer",Source,nPlayer)
    end,
}

function Server.actionSuspect(Data)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport, "Admin", 5) then
        SuspectFunctions[Data["action"]](Passport,Data["passport"])
    end
end
-- cityName = GetConvar("cityName", "Base")
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- LANG
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local SourceLicense = {}
-- local Lang = {
--     ["Join"] = "Entrando...",
--     ["Connecting"] = "Conectando...\nEstamos selecionando seu lugar na fila por favor aguarde.",
--     ["Position"] = "Você é o %d/%d da fila, aguarde sua conexão",
--     ["Error"] = "Conexão perdida.",
--     ["AccountLogged"] = "Essa conta já esta logada"
-- }
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- QUEUE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local Queue = {
--     ["List"] = {},
--     ["Players"] = {},
--     ["Counts"] = 0,
--     ["Connecting"] = {},
--     ["BeforeConnect"] = {},
--     ["Threads"] = 0,
--     ["Max"] = 1300,
--     ["MaxConnecting"] = 60,
--     ["MaxPlayers"] = 1300, -- MAXIMO DE JOGADORES NO SERVIDOR
-- }
-- local BeforeConnect = 0
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- CONFIG
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- if cityName == "Base" then
--     Queue["MaxPlayers"] = 1300
--     Queue["MaxConnecting"] = 120
-- end
-- RegisterCommand('updatequeue', function(source, args, rawCommand)
--     if source == 0 then
--         if args[1] and args[2] then
--             Queue["MaxPlayers"] = parseInt(args[1])
--             Queue["MaxConnecting"] = parseInt(args[2])
--             print("MaxPlayers: "..Queue["MaxPlayers"].." MaxConnecting: "..Queue["MaxConnecting"])
--         end
--     end
-- end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECK AMOUNT PLAYERS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- function CheckAmountPlayers()
-- --     local NumberPlayers = GetNumPlayerIndices()
-- --     if NumberPlayers > 1000 then
-- --         print("Numero de players: "..NumberPlayers.." Maximo de conexoes simultaneas: "..Queue["MaxConnecting"])
-- --     end
 
-- --     if NumberPlayers < 1000 then
-- --         Queue["MaxConnecting"] = 120
-- --     end
-- --     if NumberPlayers > 1100 and NumberPlayers < 1200 then
-- --         Queue["MaxConnecting"] = 110
-- --     elseif NumberPlayers > 1200 and NumberPlayers < 1300 then
-- --         Queue["MaxConnecting"] = 100
-- --     elseif NumberPlayers > 1300 and NumberPlayers < 1400 then
-- --         Queue["MaxConnecting"] = 90
-- --     elseif NumberPlayers > 1400 and NumberPlayers < 1500 then
-- --         Queue["MaxConnecting"] = 80
-- --     end
-- -- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- INQUEUE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function getQueue(ids,trouble,source,connect)
--     for k,v in ipairs(connect and Queue["Connecting"] or Queue["List"]) do
--         local inQueue = false
     
--         if not source then
--             for _,i in ipairs(v["ids"]) do
--                 if inQueue then
--                     break
--                 end
             
--                 for _,o in ipairs(ids) do
--                     if o == i then
--                         inQueue = true
--                         break
--                     end
--                 end
--             end
--         else
--             inQueue = ids == v["source"]
--         end
     
--         if inQueue then
--             if trouble then
--                 return k,connect and Queue["Connecting"][k] or Queue["List"][k]
--             end
         
--             return true
--         end
--     end
 
--     return false
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- CHECKPRIORITY
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function CheckPriority(source)
--     local Result = 0
 
--     for _,v in pairs(GetPlayerIdentifiers(source)) do
--         if string.find(v,"license") then
--             local Split = splitString(v,":")
--             local Query = vRP.Query("accounts/getPriority",{Split[2]})
--             if vRP.LicenseAdmin(Split[2]) then
--                 if Result < 90 then
--                     Result = 90
--                 end
--             end
--             if vRP.LicensePremium(Split[2]) then
--                 if Result < 10 then
--                     Result = 10
--                 end
--             end
--             if Query and Query[1] then
--                 local Priority = parseInt(Query[1]["priority"]) or 0
--                 if Result < Priority then
--                     Result = Priority
--                 end
--             end
--         end
--     end
--     return Result
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- ADDQUEUE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function addQueue(ids,connectTime,name,source,deferrals)
--     if getQueue(ids) then
--         return
--     end
 
--     local tmp = { source = source, ids = ids, name = name, firstconnect = connectTime, priority = CheckPriority(source), timeout = 0, deferrals = deferrals }
 
--     local _pos = false
--     local queueCount = #Queue["List"] + 1
 
--     for k,v in ipairs(Queue["List"]) do
--         if tmp["priority"] then
--             if not v["priority"] then
--                 _pos = k
--             else
--                 if tmp["priority"] > v["priority"] then
--                     _pos = k
--                 end
--             end
         
--             if _pos then
--                 break
--             end
--         end
--     end
 
--     if not _pos then
--         _pos = #Queue["List"] + 1
--     end
 
--     table.insert(Queue["List"],_pos,tmp)
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- REMOVEQUEUE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function RemoveQueue(ids,source)
--     if getQueue(ids,false,source) then
--         local pos,data = getQueue(ids,true,source)
--         table.remove(Queue["List"],pos)
--     end
--     RemoveFromBeforeQueue(source)
-- end
-- function AddBeforeQueue(source)
--     BeforeConnect = BeforeConnect + 1
--     table.insert(Queue["BeforeConnect"],source)
-- end
-- function GetBeforeQueue(Source)
--     local Position = false
--     for k,v in ipairs(Queue["BeforeConnect"]) do
--         if v == Source then
--             Position = k
--         end
--     end
--     return Position
-- end
-- function RemoveFromBeforeQueue(Source)
--     for k,v in ipairs(Queue["BeforeConnect"]) do
--         if v == Source then
--             BeforeConnect = BeforeConnect - 1
--             table.remove(Queue["BeforeConnect"],k)
--         end
--     end
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- ISCONNECT
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function isConnect(ids,source,refresh)
--     local k,v = getQueue(ids,refresh and true or false,source and true or false,true)
 
--     if not k then
--         return false
--     end
 
--     if refresh and k and v then
--         Queue["Connecting"][k]["timeout"] = 0
--     end
--     return true
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- REMOVECONNECT
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function RemoveConnect(ids,source,reason)
--     for Index,v in ipairs(Queue["Connecting"]) do
--         local connect = false
     
--         if not source then
--             for _,i in ipairs(v["ids"]) do
--                 if connect then
--                     break
--                 end
             
--                 for _,o in ipairs(ids) do
--                     if o == i then
--                         connect = true
--                         break
--                     end
--                 end
--             end
--         else
--             connect = ids == v["source"]
--         end
     
--         if connect then
--             table.remove(Queue["Connecting"],Index)
--             return true
--         end
--     end
 
--     return false
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- ADDCONNECT
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function addConnect(ids,ignorePos,autoRemove,done)
--     local function removeFromQueue()
--         if not autoRemove then
--             return
--         end
     
--         done(Lang["Error"])
--         RemoveConnect(ids,false,"addConnect")
--         RemoveQueue(ids)
--     end
 
--     -- if #Queue["Connecting"] >= Queue["MaxConnecting"] then
--     --     removeFromQueue()
--     --     return false
--     -- end
 
--     -- if isConnect(ids) then
--     --     RemoveConnect(ids)
--     -- end
 
--     local pos,data = getQueue(ids,true)
--     if not ignorePos and (not pos or pos > 1) then
--         removeFromQueue()
--         return false
--     end
 
--     table.insert(Queue["Connecting"],data)
--     RemoveQueue(ids)
 
--     return true
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- STEAMIDS
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function steamIds(source)
--     return GetPlayerIdentifiers(source)
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- UPDATEDATA
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function updateData(source,ids,deferrals)
--     local pos,data = getQueue(ids,true)
--     Queue["List"][pos]["ids"] = ids
--     Queue["List"][pos]["timeout"] = 0
--     Queue["List"][pos]["source"] = source
--     Queue["List"][pos]["deferrals"] = deferrals
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- NOTFULL
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function notFull(firstJoin)
--     local canJoin = Queue["Counts"] + #Queue["Connecting"] < Queue["Max"]
 
--     if #Queue["Connecting"] <= Queue["MaxConnecting"] then
--         canJoin = true
--     else
--         canJoin = false
--     end
 
--     if GetNumPlayerIndices() >= Queue["MaxPlayers"] then
--         return false
--     end
 
--     if firstJoin and canJoin then
--         canJoin = #Queue["List"] <= 1
--     end
 
--     return canJoin
-- end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- SETPOSITION
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function setPosition(ids,newPos)
--     local pos,data = getQueue(ids,true)
--     table.remove(Queue["List"],pos)
--     table.insert(Queue["List"],newPos,data)
-- end
-- local BeforeConnect = 0
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADSYSTEM
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
--     local function playerConnect(name,setKickReason,deferrals)
--         local source = source
--         local ids = steamIds(source)
--         local connectTime = os.time()
--         local connecting = true
--         AddBeforeQueue(source)
--         local License = vRP.Identities(source)
--         SourceLicense[source] = License
--         deferrals.defer()
--         deferrals.handover({
--             cityName = cityName
--         })
--         local Timer = math.random(30,180)
--         local WaitTimer = 500
--         Citizen.CreateThread(function()
--             while connecting do
--                 Wait(2500)
--                 if not connecting then
--                     return
--                 end
             
--                 deferrals.update(Lang["Connecting"])
--             end
--         end)
     
--         Citizen.Wait(1000)
     
--         local function done(message)
--             connecting = false
--             RemoveFromBeforeQueue(source)
--             Citizen.CreateThread(function()
--                 if message then
--                     deferrals.update(tostring(message) and tostring(message) or "")
--                 end
             
--                 Citizen.Wait(1000)
             
--                 if message then
--                     deferrals.done(tostring(message) and tostring(message) or "")
--                     CancelEvent()
--                 end
--             end)
--         end
     
--         local function update(message)
--             connecting = false
--             BeforeConnect = BeforeConnect - 1
--             RemoveFromBeforeQueue(source)
--             deferrals.update(tostring(message) and tostring(message) or "")
--         end
     
--         if not vRP.Identities(source) then
--             done(Lang["Error"])
--             CancelEvent()
--             return
--         end
     
--         local reason = "Removido da fila."
     
--         local function setReason(message)
--             reason = tostring(message)
--         end
     
--         TriggerEvent("Queue:playerJoinQueue",source,setReason)
     
--         if WasEventCanceled() then
--             done(reason)
         
--             RemoveQueue(ids)
--             AccountConnected[License] = nil 
--             RemoveConnect(ids,false,"Canceled")
         
--             CancelEvent()
--             return
--         end
     
--         local rejoined = false
--         local PositionBefore = true
--         while PositionBefore do
--             local Position = GetBeforeQueue(source)
--             if Position then
--                 if Position == 1 then
--                     PositionBefore = false
--                     RemoveFromBeforeQueue(source)
--                 end
--             end
--             Wait(1000)
--         end
     
--         if getQueue(ids) then
--             rejoined = true
--             updateData(source,ids,deferrals)
--         else
--             Wait(WaitTimer)
--             addQueue(ids,connectTime,name,source,deferrals)
--         end
     
--         if isConnect(ids,false,true) then
--             RemoveConnect(ids,false,"382")
         
--             if notFull() then
--                 if notFull() then
--                     local added = addConnect(ids,true,true,done)
--                     if not added then
--                         CancelEvent()
--                         return
--                     end
                 
--                     done()
--                     TriggerEvent("Queue:Connecting",source,ids,deferrals)
                 
--                     return
--                 else
--                     addQueue(ids,connectTime,name,source,deferrals)
--                     setPosition(ids,1)
--                 end
--             else
--                 Wait(WaitTimer)
--                 addQueue(ids,connectTime,name,source,deferrals)
--                 setPosition(ids,1)
--             end
--         end
     
--         local pos,data = getQueue(ids,true)
     
--         if not pos or not data then
--             done(Lang["Error"])
--             RemoveFromQueue(ids)
--             RemoveFromConnecting(ids)
--             CancelEvent()
--             return
--         end
     
--         if notFull(true) then
--             local added = addConnect(ids,true,true,done)
--             if not added then
--                 CancelEvent()
--                 return
--             end
         
--             done()
         
--             TriggerEvent("Queue:Connecting",source,ids,deferrals)
         
--             return
--         end
     
--         update(string.format(Lang["Position"],pos,#Queue["List"]))
     
--         Citizen.CreateThread(function()
--             if rejoined then
--                 return
--             end
         
--             Queue["Threads"] = Queue["Threads"] + 1
--             local dotCount = 0
         
--             while true do
--                 Citizen.Wait(1000)
--                 local dots = ""
             
--                 dotCount = dotCount + 1
--                 if dotCount > 3 then
--                     dotCount = 0
--                 end
             
--                 for i = 1,dotCount do
--                     dots = dots.."."
--                 end
             
--                 local pos,data = getQueue(ids,true)
             
--                 if not pos or not data then
--                     if data and data.deferrals then
--                         data.deferrals.done(Lang["Error"])
--                         AccountConnected[License] = nil 
--                     end
                 
--                     CancelEvent()
--                     RemoveQueue(ids)
--                     RemoveConnect(ids,false,"465")
--                     Queue["Threads"] = Queue["Threads"] - 1
--                     return
--                 end
             
--                 if pos <= 1 and notFull() then
--                     local added = addConnect(ids)
--                     data.deferrals.update(Lang["Join"])
                 
--                     Citizen.Wait(500)
                 
--                     if not added then
--                         data.deferrals.done(Lang["Error"])
--                         CancelEvent()
--                         Queue["Threads"] = Queue["Threads"] - 1
--                         return
--                     end
                 
--                     data.deferrals.update("Carregando conexão com o servidor.")
                 
--                     RemoveQueue(ids)
--                     Queue["Threads"] = Queue["Threads"] - 1
                 
--                     TriggerEvent("Queue:Connecting",source,data.ids,data.deferrals)
--                     return
--                 end
             
--                 local message = string.format("Base\n\n"..Lang["Position"].."%s\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, xe sua sugestão em nosso discord.",pos,#Queue["List"],dots)
--                 data.deferrals.update(message)
--             end
--         end)
--     end
 
--     AddEventHandler("playerConnecting",playerConnect)
 
--     local function checkTimeOuts()
--         local i = 1
     
--         while i <= #Queue["List"] do
--             local data = Queue["List"][i]
--             local lastMsg = GetPlayerLastMsg(data.source)
         
--             if lastMsg == 0 or lastMsg >= 30000 then
--                 data.timeout = data.timeout + 1
--             else
--                 data.timeout = 0
--             end
         
--             if not data.ids or not data.name or not data.firstconnect or not data.priority or not data.source then
--                 data.deferrals.done(Lang["Error"])
--                 table.remove(Queue["List"],i)
--                 RemoveFromBeforeQueue(data.source)
--             elseif (data.timeout >= 120) and os.time() - data.firstconnect > 5 then
--                 data.deferrals.done(Lang["Error"])
--                 RemoveQueue(data.source,true)
--                 AccountConnected[SourceLicense[data.source]] = nil 
--                 RemoveConnect(data.source,true,"521")
--             else
--                 i = i + 1
--             end
--         end
     
--         i = 1
     
--         while i <= #Queue["Connecting"] do
--             local data = Queue["Connecting"][i]
--             local lastMsg = GetPlayerLastMsg(data.source)
--             data.timeout = data.timeout + 1
         
--             if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and os.time() - data.firstconnect > 5 then
--                 RemoveQueue(data.source,true)
--                 AccountConnected[SourceLicense[data.source]] = nil
--                 RemoveConnect(data.source,true,"537")
--                 RemoveFromBeforeQueue(data.source)
--             else
--                 i = i + 1
--             end
--         end
     
--         SetTimeout(1000,checkTimeOuts)
--     end
 
--     checkTimeOuts()
-- end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- QUEUE:CONNECT
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterServerEvent("Queue:Connect")
-- AddEventHandler("Queue:Connect",function()
--     local source = source
 
--     if not Queue["Players"][source] then
--         local ids = steamIds(source)
     
--         Queue["Counts"] = Queue["Counts"] + 1
--         Queue["Players"][source] = true
--         RemoveQueue(ids)
--         RemoveConnect(ids,false,"561")
--     end
-- end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- PLAYERDROPPED
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- AddEventHandler("playerDropped",function()
--     if Queue["Players"][source] then
--         local ids = steamIds(source)
     
--         Queue["Counts"] = Queue["Counts"] - 1
--         Queue["Players"][source] = nil
--         RemoveQueue(ids)
--         if AccountConnected[SourceLicense[source]] then
--             AccountConnected[SourceLicense[source]] = nil
--         end
--         RemoveConnect(ids,false,"577")
--     end
-- end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- QUEUE:REMOVE
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- AddEventHandler("Queue:Remove",function(ids)
--     RemoveQueue(ids)
--     RemoveConnect(ids,false,"585")
-- end)
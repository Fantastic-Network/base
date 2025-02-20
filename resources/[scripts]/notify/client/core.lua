-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
Player = GetPlayerServerId(PlayerId())
Language = GetConvar("language", "") or "pt-br"
local Notify =  true
local PoliceCount = 0
local ValidNotify = {
    ["vermelho"] = true,
    ["verde"] = true,
    ["amarelo"] = true,
    ["azul"] = true,
    ["sangramento"] = true,
    ["compras"] = true,
    ["fome"] = true,
    ["sede"] = true,
    ["police"] = true,
    ["paramedic"] = true,
    ["admin"] = true,
    ["dica"] = true,
    ["amor"] = true,
    ["airdrop"] = true,
    ["dominacao"] = true,
    ["drogas"] = true,
    ["wheel"] = true,
    ["mechanic"] = true,
    ["adminNew"] = true,
    ["paramedicNew"] = true,
    ["mechanicNew"] = true,
    ["eventsNew"] = true,
    ["ilegalNew"] = true,
    ["anonymousNew"] = true,
    ["policeNew"] = true,
}

AddEventHandler("gameEventTriggered",function(eventName,args)
    if eventName ~= "CEventNetworkPlayerEnteredVehicle" then
        return
    end

    local Ped = PlayerPedId()
    
    if tonumber(args[1]) ~= PlayerId() or not LocalPlayer["state"]["Active"] then
        return
    end
    SendNUIMessage({ Action = "isCar", Data = true })
    CreateThread(function()
        while true do 
            if not IsPedInAnyVehicle(Ped) then
                SendNUIMessage({ Action = "isCar", Data = false })
                break
            end
            Wait(500)
        end
    end)
end)

RegisterNetEvent("Notify")
AddEventHandler("Notify",function(Css,Message,Timer,Title)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    if not Notify then
        return
    end
    if LocalPlayer["state"]["PVP"] then
        return
    end
    if ValidNotify[Css] then
        SendNUIMessage({ Action = "Notify", Css = Css, Message = Message, Timer = Timer or 5000, Title = Title })
    else
        SendNUIMessage({ Action = "Notify", Css = "vermelho", Message = Message, Title = Title, Timer = Timer or 5000 })
    end
end)

RegisterNetEvent("NotifyId")
AddEventHandler("NotifyId",function(...)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    local Id = ...
    if NotifyId[Id] then
        NotifyId[Id](...)
    end
end)

RegisterNetEvent("Notify2")
AddEventHandler("Notify2",function(...)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    local Notify,Variables = ...
    Language = "pt-br"
    local Config = notifyConfig[Language][Notify]
    if Config then
        local Title = Config["title"]
        local Message = parseString(Config["message"],Variables)
        local Css = Config["type"]
        local Timer = Config["duration"]
        SendNUIMessage({ Action = "Notify", Css = Css, Message = Message, Timer = Timer or 5000, Title = Title })
    end
end)

RegisterNetEvent("BigNotify")
AddEventHandler("BigNotify",function(Css,Message,Timer,Title)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    if not Notify then
        return
    end
    if ValidNotify[Css] then
        SendNUIMessage({ Action = "SpecialNotify", Css = Css, Message = Message, Timer = Timer or 5000, Title = Title })
    else
        SendNUIMessage({ Action = "SpecialNotify", Css = "vermelho", Message = Message, Title = Title, Timer = Timer or 5000 })
    end
end)

RegisterNetEvent("Notify:Text")
AddEventHandler("Notify:Text",function(Text)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    SendNUIMessage({ Action = "Text", Message = ""})
    Wait(50)
    SendNUIMessage({ Action = "Text", Message = Text})
end)

RegisterNetEvent("Notify:Remkey")
AddEventHandler("Notify:Remkey",function(Status)
    Notify = not Status
    SendNUIMessage({ Action = "remKey", Status = Status})
end)

RegisterNetEvent("Announce")
AddEventHandler("Announce",function(Css,Message,Timer,Title)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    if not Notify then
        return
    end
    if ValidNotify[Css] then
        SendNUIMessage({ Action = "Announce", Css = Css, Message = Message, Timer = Timer or 5000, Title = Title })
    else
        SendNUIMessage({ Action = "Announce", Css = "admin", Message = Message, Title = Title, Timer = Timer or 5000 })
    end
end)

local HelpNotify = {
    "Você sabia que não pode ser assaltado enquanto estiver no modo safe?",
    "Trabalho de Pescador, Minerador e Agricultor estão bufados! [Procure no Mapa]",
    "Você pode fazer TestDrive gratuitamente de carros vips diretamente na concessionária da cidade!",
    "Em breve punições serão aplicadas em jogadores com muitos deslikes.",
    "Você pode denúnciar um jogador que deslogou em meio a uma ação através da box deixada no local da morte! [Advertência Automática]",
    "Trabalho de Mineração de Criptomoeda te permite ganhar dinheiro mesmo enquanto está AFK! [Próximo ao Cassino]",
    "Você ganha 💎 diamantes por tempo online, use o comando /diamantes para acessar a loja de diamantes!",
    "Você pode avaliar outro jogador (👍/👎) segurando ALT e mirando sobre ele!",
    "Você sabia que hoje mais de 40 colaboradores trabalham full-time no Base?",
    "Você sabia que carros vip além de te dar mais respeito com os amigos correm mais que os demais carros da cidade?",
    "Você sabia que Anti-RP não são bem vindos aqui? E que você pode denúnciar um mau jogador? [Aperte F5]",
    "Você sabia que existe um FAQ de Dúvidas Frequentes na cidade? [Aperte F5]",
    "Você sabia que pode abrir a loja vip da cidade a qualquer momento através do comando /lojavip?",
    "Você sabia que pode avaliar um Staff como positivo ou negativo na prefeitura do Pier?",
    "Recrutamentos para a polícia são feitos diariamente! [Procure no Mapa]",
    "Jogadores ganham benefícios por recrutar iniciantes para Polícia, Hospital e Facções!",
    "O Pier é o Ponto Central da Cidade e onde os moradores se socializam! [Procure no Mapa]",
    "Você ganha benefícios gratuitamente por estar online através do BattlePass! [Aperte F4]",
    "Os produtos mais vendidos na loja vip atualmente são o Vip Ouro e BattlePass! [digite /lojavip]",
    "Seu personagem não morre mais de fome e sede enquanto você estiver AFK!",
    "Em breve jogadores que receberem muitas avaliações como toxicas terão sérios problemas?",   
    "Você sabia que o BattlePass é renovado todo dia 01 de cada mês?",
    "Você sabia que Médico é uma profissão legal que paga muito bem?",
    "Você sabia que pode salvar sua o preset da sua roupa atual e voltar facilmente pra ela depois? [F9/Roupas/Guardar]"
}

local HelpDone = {}
cityName = GetConvar("cityName", "Base")

AddStateBagChangeHandler('Active',('player:%s'):format(Player) , function(_, _, Value)
    local Ped = PlayerPedId()
    if Value and GlobalState["Dicas"] then
        CreateThread(function()
            Wait(2500)
            while true do
                -- if not LocalPlayer["state"]["Newbie"] then
                --     return
                -- end
                ::Another::
                if #HelpDone == #HelpNotify then
                    HelpDone = {}
                end
                local Random = math.random(1,#HelpNotify)
                if HelpDone[Random] then
                    goto Another
                end
                HelpDone[Random] = true
                TriggerEvent("Notify","dica",HelpNotify[Random],10000,"Dicas")
                TriggerEvent("sounds:Private",-1,"anuncioadm",0.04)
                Wait(1000*60*10)
            end
        end)
    end 
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

local Recruit = {}
local Events = {}

RegisterNetEvent("notify:CustomRecruit")
AddEventHandler("notify:CustomRecruit",function(Title,Message,Name,Timer,Coords,CustomTitle,CustomCaller)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    if not Notify then
        return
    end
    local Count = #Recruit + 1
    Recruit[Count] = { Coords = Coords }
    local Messages = Message:gsub("[<>]","")
    SendNUIMessage({ Action = "Recruitment", Title = Title, Message = Messages, Name = Name, Id = Count, CustomCaller = CustomCaller, CustomTitle = CustomTitle, Timer = Timer or 5000 })
end)

RegisterNetEvent("notify:Events")
AddEventHandler("notify:Events",function(Title,Message,Name,Timer,Coords,CustomTitle,CustomCaller)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    if not Notify then
        return
    end
    local Count = #Events + 1
    Events[Count] = { Coords = Coords }
    local Messages = Message:gsub("[<>]","")
    SendNUIMessage({ Action = "Events", Title = Title, Message = Messages, Name = Name, Id = Count, CustomCaller = CustomCaller, CustomTitle = CustomTitle, Timer = Timer or 5000 })
end)

RegisterNetEvent("Notify:ActionPol")
AddEventHandler("Notify:ActionPol",function(Title,Message,Name,Timer,Coords,CustomTitle,CustomCaller,ActionId)
    if LocalPlayer["state"]["FirstLogin"] then
        return
    end
    if not Notify then
        return
    end
    if cityName == "Test" then
        numberBlips = numberBlips + 1
        local id = tostring(numberBlips)
        timeBlips[id] = 60
        showBlips[id] = AddBlipForCoord(Coords["x"],Coords["y"],Coords["z"] or 0.0)
    
        SetBlipSprite(showBlips[id],10)
        SetBlipDisplay(showBlips[id],4)
        SetBlipAsShortRange(showBlips[id],true)
        SetBlipColour(showBlips[id],1)
        SetBlipScale(showBlips[id],0.5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Ação Policial")
        EndTextCommandSetBlipName(showBlips[id])
        return
    end
    PoliceCount = PoliceCount + 1
    local Messages = Message:gsub("[<>]","")
    SendNUIMessage({ Action = "PoliceCall", Title = Title, Message = Messages, Name = Name, Id = ActionId, CustomCaller = CustomCaller, CustomTitle = CustomTitle, Timer = Timer or 5000 })
end)

RegisterNUICallback("MarkRecruitment",function(Data,Callback)
    local Coords = Recruit[tonumber(Data.Id)].Coords
    local Ped = PlayerPedId()
    DoScreenFadeOut(2500)
    while not IsScreenFadedOut() do 
        Wait(5) 
    end
    SetEntityCoords(Ped,Coords.x,Coords.y,Coords.z-1,false,false,false,false)
    FreezeEntityPosition(Ped,true)
    RequestCollisionAtCoord(Coords.x,Coords.y,Coords.z)
    while not HasCollisionLoadedAroundEntity(Ped) do
        Wait(1)
    end
    DoScreenFadeIn(5000)
    while not IsScreenFadedIn() do
        Wait(5)
    end
    FreezeEntityPosition(Ped,false)
    -- SetNewWaypoint(Coords.x,Coords.y)
end)

RegisterNUICallback("MarkEvents",function(Data,Callback)
    local Coords = Events[tonumber(Data.Id)].Coords
    local Ped = PlayerPedId()
    DoScreenFadeOut(2500)
    while not IsScreenFadedOut() do 
        Wait(5) 
    end
    SetEntityCoords(Ped,Coords.x,Coords.y,Coords.z-1,false,false,false,false)
    FreezeEntityPosition(Ped,true)
    RequestCollisionAtCoord(Coords.x,Coords.y,Coords.z)
    while not HasCollisionLoadedAroundEntity(Ped) do
        Wait(1)
    end
    FreezeEntityPosition(Ped,false)
    DoScreenFadeIn(5000)
    while not IsScreenFadedIn() do
        Wait(5)
    end
    ExecuteCommand("mundo Evento")
    table.remove(Events,tonumber(Data.Id))
    -- SetNewWaypoint(Coords.x,Coords.y)
end)

RegisterNUICallback("MarkPolice",function(Data,Callback)
    if PoliceCount <= 0 then
        return
    end
    TriggerServerEvent("Notify:PolGoto",Data.Id)
    PoliceCount = PoliceCount - 1
end)

RegisterCommand("ClickRecruit",function()
    if PoliceCount <= 0 then
        if Events[1] then
            SendNUIMessage({ Action = "EventsId" })
        else
            SendNUIMessage({ Action = "RecuitementId" })
        end
    else
        SendNUIMessage({ Action = "PoliceId" })
    end
    TriggerEvent("notify:Reset")
end)

RegisterKeyMapping("ClickRecruit","Abrir Recrutamento.","keyboard","F3")

RegisterNUICallback("hideFrame",function(Data,Callback)
	SetNuiFocus(false,false)
	Callback("Ok")
end)

RegisterNUICallback("toggleKey",function(Data,Callback)
    SendNUIMessage({ Action = "remKey", Status = Data})

	Callback("Ok")
end)

------------------------------------------------------------------------------------------------------------------------
-- POLICE
------------------------------------------------------------------------------------------------------------------------
local showBlips = {}
local timeBlips = {}
local numberBlips = 0

RegisterCommand("showNotifies",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPauseMenuActive() then
        SetNuiFocus(true,true)
		SendNUIMessage({ Action = "showWarns" })
	end
end)
RegisterKeyMapping("showNotifies","Consultar as notificações.","keyboard","F2")

RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(data)
	numberBlips = numberBlips + 1
    if not data["code"] then
        data["code"] = "QRU"
        data["title"] = "Disparos"
        data["blipColor"] = 6
    end
    local id = tostring(numberBlips)
	timeBlips[id] = 60
	showBlips[id] = AddBlipForCoord(data["x"],data["y"],data["z"])

	SetBlipSprite(showBlips[id],10)
	SetBlipDisplay(showBlips[id],4)
	SetBlipAsShortRange(showBlips[id],true)
	SetBlipColour(showBlips[id],data["blipColor"])
	SetBlipScale(showBlips[id],0.5)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(data["title"])
	EndTextCommandSetBlipName(showBlips[id])
end)

RegisterNetEvent("NotifyPushShots")
AddEventHandler("NotifyPushShots",function(Coords)
	numberBlips = numberBlips + 1
    local data = {}
    data["code"] = "QRU"
    data["title"] = "Disparos"
    data["blipColor"] = 6
    local id = tostring(numberBlips)
	timeBlips[id] = 60
	showBlips[id] = AddBlipForCoord(Coords["x"],Coords["y"],Coords["z"])

	SetBlipSprite(showBlips[id],42)
	SetBlipDisplay(showBlips[id],4)
	SetBlipScale(showBlips[id],0.6)
    SetBlipAsShortRange(showBlips[id],true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(data["title"])
	EndTextCommandSetBlipName(showBlips[id])
end)

RegisterNetEvent("hideNotifys")
AddEventHandler("hideNotifys",function(Coords)
    SendNUIMessage({ Action = "hideNotifys"})
end)

RegisterNetEvent("NotifyPolice")
AddEventHandler("NotifyPolice", function(message)
    local Hours,Minutes = exports["hud"]:getTime()
    SendNUIMessage({ 
        Action = "addPoliceWarn", 
        message = message,
        hours = Hours..":"..Minutes
    })
end)

RegisterNetEvent("notify:Toggle")
AddEventHandler("notify:Toggle",function(toggle)
    SendNUIMessage({ Action = "Toggle", toggle = toggle or false })
end)

CreateThread(function()
    if LocalPlayer["state"]["Active"] then
        Wait(3000)
        SendNUIMessage({ Action = "Toggle", toggle = true })
    end
end)

CreateThread(function()
	while true do
		for k,v in pairs(timeBlips) do
			if timeBlips[k] > 0 then
				timeBlips[k] = timeBlips[k] - 1
				if timeBlips[k] <= 0 then
					RemoveBlip(showBlips[k])
					showBlips[k] = nil
					timeBlips[k] = nil
				end
			end
		end

		Wait(1000)
	end
end)
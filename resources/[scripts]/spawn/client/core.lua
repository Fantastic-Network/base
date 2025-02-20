-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Peds = nil
local Camera = nil
local Characters = {}
local selected = nil
local isFirstLogin = true
local Active = false
local NewPlayer = false
local Default = true
local model =  `mp_m_freemode_01`
local SelectedModel = `mp_m_freemode_01`
local TestTimer = GetGameTimer()
local CustomSpawn = nil
local cityName = GetConvar("cityName","Base")
local CreatingCharacter = false
local Debug = false
-- local Characters,Slots,isFirstLogin
local DataNameInfo = { ["nome"] = "", ["nome2"] = "", ["sexo"] = "", ["idade"] = nil }
----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    AnimSpawn = exports["variables"]:GetAnimSpawn()
    SelectionSpawn = exports["variables"]:GetSelectionSpawn()
    NewbieSpawn = exports["variables"]:GetNewbieSpawn()
    LocationSpawn = exports["variables"]:GetLocationSpawn()
end)

-- local FirstZone = PolyZone:Create({
--     vector2(-1639.77, -1015.15),
--     vector2(-1571.21, -1065.91),
--     vector2(-1639.77, -1150.00),
--     vector2(-1719.32, -1097.73)
-- },{
--     name="FirstZone",
-- })
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

function executePlayerLogin()
    DoScreenFadeOut(0)
    --TriggerEvent("timeSet","Day")
    local Count = 0
    ::WaitModel::
    
    while not HasModelLoaded(model) do
        Count += 1
        if Count == 1000 then
            if GetIsLoadingScreenActive() then
                TriggerEvent("CloseLoadingScreen")
                Wait(100)
                DoScreenFadeIn(500)
            end
            TriggerEvent("Notify","vermelho","Econtramos problemas ao tentar carregar seu personagem aguarde mais <b>15</> Segundos.",15000,"SPAWN")
            -- TriggerEvent("Notify2","#fLoadCharacter")
            break
        end
        Wait(100)
    end
    
    exports["pma-voice"]:overrideProximityCheck(function(player)
        return false
    end)
    
    if not HasModelLoaded(model)  then
        goto WaitModel
    end
    
    SetPlayerModel(PlayerId(),model)
    -- print("First Set")
    -- print(GetGameTimer()-TestTimer)
    local Ped = PlayerPedId()
    FreezeEntityPosition(Ped,true)
    LocalPlayer["state"]["Invincible"] = true
    SetEntityInvincible(Ped,true)
    LocalPlayer["state"]["Invisible"] = true
    SetEntityVisible(Ped,false,false)
    SetPlayerControl(Ped,false,false)
    ClearPedTasksImmediately(Ped)
    Characters,Slots,isFirstLogin,CustomSpawn = vSERVER.Characters()
    -- TriggerServerEvent("testPed")
    -- Ped = PlayerPedId()
    -- SetEntityCoordsNoOffset(Ped,-312.68,194.50,144.37, false, false, false, true)
    SetEntityHeading(Ped,0.0)
    DisplayRadar(false)
    SetEntityCoords(Ped,SelectionSpawn["Player"]["x"],SelectionSpawn["Player"]["y"],SelectionSpawn["Player"]["z"],false,false,false,false)
    Wait(100)
    FreezeEntityPosition(Ped,true)
    LocalPlayer["state"]["Invisible"] = true
    SetEntityVisible(Ped,false,false)
    LocalPlayer["state"]["Invincible"] = true
    SetEntityInvincible(Ped,true)
    SetEntityHealth(Ped,100)
    SetPedArmour(Ped,0)
    -- print("Second Set")
    TriggerEvent("CloseLoadingScreen")
    while GetIsLoadingScreenActive() do
        TriggerEvent("CloseLoadingScreen")
        Wait(1)
    end
    Wait(100)
    DoScreenFadeIn(500)
    exports["pma-voice"]:overrideProximityCheck(function(player)
        return false
    end)
    TriggerEvent("notify:TutorialStatus",false)
    if parseInt(#Characters) > 0 then
        Selecting = true
        Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
        SetEntityCoords(Ped,SelectionSpawn["Player"]["x"],SelectionSpawn["Player"]["y"],SelectionSpawn["Player"]["z"],false,false,false,false)
        CreateThread(function()
            while Selecting do
                NetworkOverrideClockTime(12,00,00)
                FreezeEntityPosition(Ped,true)
                SetEntityVisible(Ped,false,false)
                Wait(1)
            end
        end)
        Wait(500)
        RequestCollisionAtCoord(SelectionSpawn["Player"]["x"],SelectionSpawn["Player"]["y"],SelectionSpawn["Player"]["z"])
        while not HasCollisionLoadedAroundEntity(Ped) do
            Wait(1)
        end
        Wait(500)
        SetCamCoord(Camera,SelectionSpawn["Player"]["x"],SelectionSpawn["Player"]["y"],SelectionSpawn["Player"]["z"])
        PedCreated(Characters[1])
        RenderScriptCams(true,true,1,true,true)
        SetCamRot(Camera,0.0,0.0,SelectionSpawn["Camera"],2)
        SetCamActive(Camera,true)
        Wait(100)
        DoScreenFadeIn(500)
        TriggerEvent("timeSet","Night")
        
        SetNuiFocus(true,true)
        SendReactMessage("setVisible", "")
    else
        SetEntityCoords(Ped,SelectionSpawn["Player"]["x"],SelectionSpawn["Player"]["y"],SelectionSpawn["Player"]["z"],false,false,false,false)
        RequestCollisionAtCoord(SelectionSpawn["Player"]["x"],SelectionSpawn["Player"]["y"],SelectionSpawn["Player"]["z"])
        while not HasCollisionLoadedAroundEntity(Ped) do
            Wait(1)
        end
        SetEntityHeading(Ped,297.62)
        SetEntityVisible(Ped,false,false)
        Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
        SetCamCoord(Camera,SelectionSpawn["Player"]["x"],SelectionSpawn["Player"]["y"],SelectionSpawn["Player"]["z"])
        RenderScriptCams(true,true,1,true,true)
        SetCamRot(Camera,0.0,0.0,SelectionSpawn["Camera"],2)
        CreatingCharacter = true
        CreateThread(function()
            while CreatingCharacter do
                SetEntityVisible(Ped,false,false)
                Wait(1)
            end
            SetEntityVisible(Ped,true,false)
        end)
        TriggerServerEvent("register:CheckRegister")
    end
	SetPedCanRagdoll(PlayerPedId(), false)
end

RegisterNetEvent("spawn:FirsLogin")
AddEventHandler("spawn:FirsLogin",function()
    local Ped = PlayerPedId()
    NewPlayer = true
    Wait(100)
    exports["barbershop"]:Apply({},Ped)
    exports["skinshop"]:Apply({},Peds)
    Wait(250)
    DoScreenFadeIn(500)
    SetNuiFocus(true,true)
    SendReactMessage("setVisible", "newPlayer")
    TriggerEvent("timeSet","Night")
end)

RegisterNetEvent("onClientResourceStart")
AddEventHandler("onClientResourceStart",function(Resource)
    if not Debug then
        if LocalPlayer["state"]["Active"] then
            return
        end
    end
    if (GetCurrentResourceName() ~= Resource) then
        return
    end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
	SetPedCanRagdoll(PlayerPedId(), false)
    local Ped = PlayerPedId()
    SetPedRandomComponentVariation(Ped, true)
    -- SetEntityCoordsNoOffset(Ped,312.68,194.50,144.37, false, false, false, true)
    -- NetworkResurrectLocalPlayer(-312.68,194.50,144.37,true,true,false)
end)

RegisterNUICallback("GetCharacters", function(data, cb)
    local Spawns = {}
    if isFirstLogin then
        for i=1,#LocationSpawn do
            Spawns[#Spawns+1] = { title = LocationSpawn[i]["name"] }
        end
    end
    if not (Characters) then
        Characters, Slots, isFirstLogin, CustomSpawn = vSERVER.Characters()
    end
    if CustomSpawn then
        Spawns[#Spawns+1] = { title = "PERSONALIZADO" }
    end
    cb({
        Characters = Characters,
        Slots = Slots,
        Spawns = Spawns
    })
end)

RegisterNUICallback("Init", function(data, cb)
    if not Debug then
        if LocalPlayer["state"]["Active"] then
            return
        end
    end
    exports["pma-voice"]:overrideProximityCheck(function(player)
        return false
    end)
    executePlayerLogin()
    LocalPlayer["state"]["Loading"] = true
    TriggerServerEvent("Queue:Connect")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ChoseCharacter", function(data, cb)
    if Characters[1] and data["Character"] and Characters[parseInt(data["Character"])] then
        selected = parseInt(data["Character"])
        if DoesEntityExist(Peds) then
            DeleteEntity(Peds)
        end
        
        for k,v in pairs(Characters) do
            if k == selected then
                PedCreated(v)
                break
            end
        end
    end
end)

RegisterNUICallback("ClickSpawn", function(data, cb)
    Selecting = false
    DoScreenFadeOut(0)
    SendReactMessage("setVisible", false)
    SetNuiFocus(false,false)
    if not selected then
        if Characters[1] then
            selected = 1
        else
            return
        end
    end
    local Ped = PlayerPedId()
    local Index = data["location"]
    local Coords = nil
    if isFirstLogin and type(Index) == "number" then
        if LocationSpawn[Index] then
            Coords = LocationSpawn[Index]["Coords"]
        end
    end
    
    if (data["spawn"] == "PERSONALIZADO") and LocalPlayer["state"]["CustomSpawn"] then
        Coords = LocalPlayer["state"]["CustomSpawn"]
    end
    if (data["spawn"] == "org") then
        Coords = GROUP_COORDS[data["group"]]
    end
    if DoesEntityExist(Peds) then
        DeleteEntity(Peds)
    end
    SetCamRot(Camera,0.0,0.0,0.0,2)
    RenderScriptCams(false,false,0,true,true)
    SetCamActive(Camera,false)
    DestroyCam(Camera,true)
    Camera = nil
    vSERVER.ChoseCharacter(selected,Coords)
    SetEntityVisible(Ped,true,false)
    SelectedModel = GetHashKey(Characters[selected]["Skin"])
    LocalPlayer["state"]["Invisible"] = false
    Active = true
    TriggerServerEvent("vRP:justObjects")
    Wait(1000)
    DoScreenFadeIn(1000)
    TriggerEvent("hud:Active",true)
    exports["pma-voice"]:resetProximityCheck()
    TriggerEvent("sounds:Private","stop",0.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CreateCharacter",function(Data,Callback)
    local sexo = "mp_f_freemode_01"
    local Ped = PlayerPedId()
    if Data["sexo"] == "m" then
        sexo = "mp_m_freemode_01"
    end
    local model = GetHashKey(sexo)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    SendNUIMessage({
        action = "DeleteModal",
        data = { nones = "none" }
    })
    SetCamRot(Camera,0.0,0.0,0.0,2)
    RenderScriptCams(false,false,0,true,true)
    SetCamActive(Camera,false)
    DestroyCam(Camera,true)
    Camera = nil
    SetEntityHeading(Ped,297.62)
    vSERVER.NewCharacter(Data["nome"],Data["nome2"],sexo,Data["idade"],SelectionSpawn["Player"])
    DoScreenFadeOut(1000)
    Wait(1000)
    Active = true
    SetEntityVisible(Ped,false)
    SetNuiFocus(false,false)
    if DoesEntityExist(Peds) then
        DeleteEntity(Peds)
    end
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWITCHCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ChangeCharacter",function(Data,Callback)
    if DoesEntityExist(Peds) then
        DeleteEntity(Peds)
    end
    
    for _,v in pairs(Characters) do
        if v["id"] == Data["id"] then
            PedCreated(v)
            break
        end
    end
    
    Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Finish")
AddEventHandler("spawn:Finish",function()
    local Ped = PlayerPedId()
    if not NewPlayer then
        SetEntityVisible(Ped,true,false)
    end
    LocalPlayer["state"]["Invisible"] = false
    TriggerEvent("hud:Active",true)
    SendReactMessage("setVisible", false)
    SetNuiFocus(false,false)
    
    RenderScriptCams(false,false,0,true,true)
    SetCamActive(Camera,false)
    DestroyCam(Camera,true)
    Camera = nil
    Active = true
    exports["pma-voice"]:resetProximityCheck()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEDCREATED
-----------------------------------------------------------------------------------------------------------------------------------------
function PedCreated(Table)
    if Table["Skin"] then
        local Hash = GetHashKey(Table["Skin"])
        RequestModel(Hash)
        while not HasModelLoaded(Hash) do
            Wait(1)
        end
        Peds = CreatePed(4,Table["Skin"],SelectionSpawn["Peds"]["x"],SelectionSpawn["Peds"]["y"],SelectionSpawn["Peds"]["z"],SelectionSpawn["Peds"]["w"],false,false)
        SetEntityInvincible(Peds,true)
        FreezeEntityPosition(Peds,true)
        SetBlockingOfNonTemporaryEvents(Peds,true)
        SetModelAsNoLongerNeeded(Table["Skin"])
        
        if LoadAnim(AnimSpawn["Dict"]) then
           TaskPlayAnim(Peds,AnimSpawn["Dict"],AnimSpawn["Name"],8.0,8.0,-1,1,0,0,0,0)
        end
        
        exports["skinshop"]:Apply(Table["Clothes"],Peds)
        exports["barbershop"]:Apply(Table["Barber"],Peds)
        exports["tattooshop"]:Apply(Table["Tattoos"],Peds)
    end
end

RegisterNetEvent("spawn:SetNewPlayer")
AddEventHandler("spawn:SetNewPlayer",function()
    -- if not LocalPlayer["state"]["DefaultSpawn"] then
    --     CreateThread(function()
    --         while NewPlayer do 
    --             local Ped = PlayerPedId()
    --             local Coords = GetEntityCoords(Ped)
    --             if not FirstZone:isPointInside(Coords) then
    --                 TriggerServerEvent("vRP:BucketClient","Exit")
    --                 NewPlayer = false
    --             end
    --             Wait(10)
    --         end
    --     end)
    -- else
    --     TriggerServerEvent("vRP:BucketClient","Exit")
    -- end
end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)

RegisterNetEvent("spawn:NameInfo")
AddEventHandler("spawn:NameInfo", function(Data)
    DataNameInfo = Data
end)

RegisterNUICallback("getUserValues",function(Data,Callback)
    if DataNameInfo["nome"] then
        Callback(DataNameInfo)
    end
end)

RegisterNetEvent("spawn:TeleportNewbie")
AddEventHandler("spawn:TeleportNewbie", function(Quantity)
    local Ped = PlayerPedId()
    local Random = math.random(#NewbieSpawn)
    if not Quantity then
        Random = 1
    end
    local StartCoords = NewbieSpawn[Random]
    -- if cityName == "Test" then
    --     StartCoords = vector3(154.63,-1049.1,29.23)
    -- end
    if not IsScreenFadedOut() then 
        DoScreenFadeOut(2500)
    end
    while not IsScreenFadedOut() do 
        Wait(5) 
    end
    RequestCollisionAtCoord(StartCoords["x"],StartCoords["y"],StartCoords["z"])
    while not HasCollisionLoadedAroundEntity(Ped) do
        Wait(1)
    end
    SetEntityCoordsNoOffset(Ped,StartCoords["x"],StartCoords["y"],StartCoords["z"], false, false, false, true)
    FreezeEntityPosition(Ped,true)
    SetCam(StartCoords)
end)
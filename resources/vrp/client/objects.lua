-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Init = {}
local Objects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Table")
AddEventHandler("objects:Table",function(Table)
    Objects = Table
    
    --for _,Info in pairs(Table) do
    	-- local Inits = AddBlipForRadius(Info["x"],Info["y"],Info["z"],10.0)
    	-- SetBlipAlpha(Inits,200)
    	-- SetBlipColour(Inits,3)
    --end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Adicionar")
AddEventHandler("objects:Adicionar",function(Number,Table)
    Objects[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGETLABEL
-----------------------------------------------------------------------------------------------------------------------------------------
function targetLabel(x,y,z,Number,Item,Mode,Perm)
    if Mode == "Spray" then
        exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),0.75,{
            name = "Objects:"..Number,
            heading = 3374176
        },{
            shop = Number,
            Distance = 1.5,
            options = {
                {
                    event = "inventory:StoreObjects",
                    label = "Remover",
                    tunnel = "client"
                }
            }
        })
    elseif Mode == "1" then
        exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),0.75,{
            name = "Objects:"..Number,
            heading = 3374176
        },{
            shop = Number,
            Distance = 1.5,
            options = {
                {
                    event = "inventory:StoreObjects",
                    label = "Guardar",
                    tunnel = "client"
                },{
                    event = "inventory:MakeProducts",
                    label = "Produzir",
                    tunnel = "products",
                    service = Item
                }
            }
        })
    elseif Mode == "2" then
        exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),0.75,{
            name = "Objects:"..Number,
            heading = 3374176
        },{
            shop = Number,
            Distance = 2.5,
            options = {
                {
                    event = "inventory:MakeProducts",
                    label = "Cozinhar Filé de Peixe",
                    tunnel = "products",
                    service = "fishfillet"
                },{
                    event = "inventory:MakeProducts",
                    label = "Assar Marshmallow",
                    tunnel = "products",
                    service = "marshmallow"
                }
            }
        })
    elseif Mode == "3" then
        exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),0.75,{
            name = "Objects:"..Number,
            heading = 3374176
        },{
            shop = Number,
            Distance = 1.5,
            options = {
                {
                    event = "inventory:StoreObjects",
                    label = "Guardar",
                    tunnel = "client"
                }
            }
        })
    elseif Mode == "4" then
        exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),0.75,{
            name = "Objects:"..Number,
            heading = 3374176
        },{
            shop = Number,
            Distance = 1.5,
            options = {
                {
                    event = "inventory:StoreObjects",
                    label = "Guardar",
                    tunnel = "client"
                },{
                    event = "shops:medicBag",
                    label = "Abrir",
                    tunnel = "client"
                }
            }
        })
    elseif Mode == "Medic" or Mode == "Weapons" or Mode == "Supplies" then
        exports["target"]:AddCircleZone("Objects:"..Number,vec3(x,y,z),0.75,{
            name = "Objects:"..Number,
            heading = 3374176
        },{
            shop = Number,
            Distance = 1.5,
            options = {
                {
                    event = "inventory:Loot",
                    label = "Abrir",
                    tunnel = "shop",
                    service = Mode
                }
            }
        })
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        
        for Number,v in pairs(Objects) do
            if #(Coords - vec3(v["x"],v["y"],v["z"])) <= v["Distance"] then
                if not Init[Number] and LoadModel(v["object"]) then
                    if v["mode"] then
                        targetLabel(v["x"],v["y"],v["z"],Number,v["item"],v["mode"],v["perm"])
                    end
                    
                    Init[Number] = CreateObjectNoOffset(v["object"],v["x"],v["y"],v["z"],false,false,false)
                    FreezeEntityPosition(Init[Number],true)
                    SetEntityHeading(Init[Number],v["h"])
                    SetModelAsNoLongerNeeded(v["object"])
                end
            else
                if Init[Number] then
                    exports["target"]:RemCircleZone("Objects:"..Number)
                    
                    if DoesEntityExist(Init[Number]) then
                        DeleteEntity(Init[Number])
                        Init[Number] = nil
                    end
                end
            end
        end
        
        Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("objects:Remover")
AddEventHandler("objects:Remover",function(Number)
    Objects[Number] = nil
    
    if Init[Number] then
        exports["target"]:RemCircleZone("Objects:"..Number)
        
        if DoesEntityExist(Init[Number]) then
            DeleteEntity(Init[Number])
            Init[Number] = nil
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
    local Rotation = GetGameplayCamRot()
    local Adjusted = vec3((math.pi / 180) * Rotation["x"],(math.pi / 180) * Rotation["y"],(math.pi / 180) * Rotation["z"])
    local Direction = vec3(-math.sin(Adjusted[3]) * math.abs(math.cos(Adjusted[1])),math.cos(Adjusted[3]) * math.abs(math.cos(Adjusted[1])),math.sin(Adjusted[1]))
    
    return vec3(Coords[1] + Direction[1] * Distance, Coords[2] + Direction[2] * Distance, Coords[3] + Direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.objectCoords(Model,Velocity)
    local Aplication = false
    local ObjectCoords = false
    local ObjectHeading = false
    if not Velocity then
        Velocity = 3.0
    end
    if LoadModel(Model) then
        local Progress = true
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)
        local Heading = GetEntityHeading(Ped)
        local NextObject = CreateObjectNoOffset(Model,Coords["x"],Coords["y"],Coords["z"],false,false,false)
        SetEntityCollision(NextObject,false,false)
        SetEntityHeading(NextObject,Heading)
        SetEntityAlpha(NextObject,100,false)
        SetModelAsNoLongerNeeded(Model)
        while Progress do
            local Ped = PlayerPedId()
            local Cam = GetGameplayCamCoord()
            local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,GetCoordsFromCam(10.0,Cam),-1,Ped,4)
            local _,_,Coords = GetShapeTestResult(Handle)
            
            if Model == "prop_ld_binbag_01" then
                SetEntityCoords(NextObject,Coords["x"],Coords["y"],Coords["z"] + 0.9,false,false,false,false)
            else
                SetEntityCoords(NextObject,Coords["x"],Coords["y"],Coords["z"],false,false,false,false)
            end
            
            DwText("~g~F~w~  CANCELAR",4,0.015,0.86,0.38,255,255,255,255)
            DwText("~g~E~w~  COLOCAR OBJETO",4,0.015,0.89,0.38,255,255,255,255)
            DwText("~y~SCROLL UP~w~  GIRA ESQUERDA",4,0.015,0.92,0.38,255,255,255,255)
            DwText("~y~SCROLL DOWN~w~  GIRA DIREITA",4,0.015,0.95,0.38,255,255,255,255)
            
            if IsControlJustPressed(1,38) then
                Aplication = true
                Progress = false
            end
            
            if IsControlJustPressed(1,49) then
                Progress = false
            end
            
            if IsControlJustPressed(1,180) then
                local Heading = GetEntityHeading(NextObject)
                SetEntityHeading(NextObject,Heading + Velocity or 1.0)
            end
            
            if IsControlJustPressed(1,181) then
                local Heading = GetEntityHeading(NextObject)
                SetEntityHeading(NextObject,Heading -Velocity or 1.0)
            end
            
            Wait(1)
        end
        
        ObjectCoords = GetEntityCoords(NextObject)
        ObjectHeading = GetEntityHeading(NextObject)
        
        DeleteEntity(NextObject)
    end
    
    return Aplication,ObjectCoords,ObjectHeading
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DwText(Text,Font,x,y,Scale,R,G,B,A)
    SetTextFont(Font)
    SetTextScale(Scale,Scale)
    SetTextColour(R,G,B,A)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(Text)
    DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:EXPLOSION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:Explosion")
AddEventHandler("vRP:Explosion",function(Coords)
    AddExplosion(Coords,2,1.0,true,false,false)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VIP:OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(x,y, scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- local VIPObjects = {
--     vector3(162.39,-1004.13,29.35),
--     vector3(838.22,-1019.63,27.35),
--     vector3(1139.2,-1486.2,34.85),
--     vector3(-1626.05,-1017.77,13.14),
--     vector3(-731.85,-674.17,30.25),
--     vector3(109.23,-1088.29,29.3),
--     -- vector3(-45.95,-1096.66,26.42),
--     vector3(415.84,307.96,102.97),
--     vector3(2554.94,-356.1,93.11),
--     vector3(1622.41,3557.53,35.4),
--     vector3(1968.97,3708.64,32.15),
--     vector3(1342.86,4325.37,38.1),
--     vector3(100.6,6333.74,31.49),
--     vector3(1708.95,4713.46,42.36),
-- }

-- CreateThread(function()
--     while true do
--         local Idle = 2500
--         for i=1,#VIPObjects do
--             local Ped = PlayerPedId()
--             local Coords = GetEntityCoords(Ped)
--             local Distance = #(Coords - VIPObjects[i])
--             if Distance <= 10.0 then
--                 local ObjCoords = GetEntityCoords(Object)
--                 Idle = 0
--                 if Distance <= 3.0 then
--                     drawTxt(0.5, 0.9, 0.4,"PRESSIONE ~g~E~w~  PARA ABRIR A LOJA E APROVEITEM O CUPOM!", 255,255,255,255)
--                     if IsControlJustPressed(0,38) then
--                         TriggerEvent("player:OpenURL",StoreLink[cityName])
--                     end
--                 end
--             end
--         end
--         Wait(Idle)
--     end
-- end)
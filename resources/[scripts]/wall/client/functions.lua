---@type table
local Config = {
    Player = {
        menus = {
            {
                title = "Editar Grupos:",
                options = {
                    { name = "Remover",key = "RemGroup" },
                    { name = "Adicionar",key = "AddGroup" },
                    { name = "Listar",key = "ListGroups" },
                }
            },
            {
                title = "Interação Jogador:",
                options = {
                    { name = "God",key = "God" },
                    { name = "Colete",key = "Armor" },
                    { name = "Dar item",key = "GiveItem" },
                    { name = "Skin",key = "Skin" },
                    -- { name = 'Derrubar', key = 'Knockdown' },
                }
            },
            {
                title = "Informações Jogador:",
                options = {
                    { name = "Discord ID",key = "GetDiscord" },
                }
            },
            -- {
            --     title = '',
            --     options = {
            --         { name = 'Expulsar', key = 'Kick' },
            --         { name = 'Banir', key = 'Ban' },
            --     }
            -- },
        }
    },

    Vehicle = {
        menus = {
            {
                title = "",
                options = {
                    { name = "Deletar",key = "Delete" },
                    { name = "Consertar",key = "Fix" },
                    { name = "Tuning",key = "Tuning" },
                    { name = "Abastecer",key = "Fuel" },
                }
            },
            {
                title = "",
                options = {
                    { name = "Trocar placa",key = "ChangePlate" },
                    { name = "Trancar/destrancar",key = "ToggleLock" },
                }
            },
            {
                title = "",
                options = {
                    { name = "Mostrar dono",key = "ShowOwner" },
                    { name = "Mostrar placa",key = "ShowPlate" },
                }
            },
            -- {
            --     title = '',
            --     options = {
            --         { name = 'Dirigir', key = 'Drive' },
            --         { name = 'Mexer', key = 'Move' },
            --         { name = 'Tpin', key = 'TpIn' },
            --     }
            -- }
        }
    }
}

---@type table
local WallConfig = {
    Source = false,
    Passport = true,
    Health = true,
    Vehicle = true,
}

---@type table
local PlayersInfos = {}
---@type string
local OpenedType = ""
---@type number
local OpenedEntity = 0
---@type boolean
local IsActive = false
---@type number
local ViewDistance = 300 -- by default, the view distance is the same as fivem onesync
---@type table
local VehicleOffsets = {
    [-1] = { -1.2,1.2 },
    [0] = { 1.2,1.2 },
    [1] = { -1.2,0.0 },
    [2] = { 1.2,0.0 },
    [3] = { -1.2,-1.2 },
    [4] = { 1.2,-1.2 },
    [5] = { -1.2,-2.4 },
    [6] = { 1.2,-2.4 },
}
---@type boolean
local Hitting = false
--- Draws the text in 3D.
---@param x number
---@param y number
---@param z number
---@param text string
---@return nil
local function DrawTopText3D(x,y,z,text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)

    if onScreen then
        SetTextScale(0.35,0.35)
        SetTextFont(4)
        SetTextDropShadow(1,0,0,0,255)
        SetTextOutline()
        SetTextProportional(1)
        SetTextColour(255,255,255,215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local function DrawBottomText3D(x,y,z,text,Distance)
    local Newz = 0.22
    if Distance > 10 then
        Newz = 0.35
        Newz = Newz + (Distance / 100)
    end
    local onScreen,_x,_y = World3dToScreen2d(x,y,z - Newz)

    if onScreen then
        SetTextScale(0.35,0.35)
        SetTextFont(4)
        SetTextDropShadow(1,0,0,0,255)
        SetTextOutline()
        SetTextProportional(1)
        SetTextColour(255,255,255,215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--- Updates the players infos.
---@param tbl table
---@return nil
function Client.UpdatePlayersInfos(tbl)
    PlayersInfos = tbl
end

function Client.UpdateSource(source,tbl)
    PlayersInfos[tostring(source)] = tbl
end

function Client.RemoveSource(source)
    PlayersInfos[tostring(source)] = nil
end

--- Toggles the admin blips.
---@param status boolean
---@param playersInfos table
---@return nil
function Client.ToggleAdminBlips(status,playersInfos)
    IsActive = status
    if IsActive then
        CreateBlipThread()
    end

    if playersInfos then
        PlayersInfos = playersInfos
    end
end

--- Get rotation from vector.
---@param rotation table
---@return table
local function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation["x"],
        y = (math.pi / 180) * rotation["y"],
        z = (math.pi / 180) * rotation["z"]
    }

    local direction = {
        x = -math.sin(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
        y = math.cos(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
        z = math.sin(adjustedRotation["x"])
    }

    return direction
end

--- Raycast from the game play camera.
---@param distance number
---@return boolean
---@return table
---@return number

function GetCoordsFromCam(Distance,Coords)
    local Rotation = GetGameplayCamRot()
    local Adjuste = vec3((math.pi / 180) * Rotation["x"],(math.pi / 180) * Rotation["y"],(math.pi / 180) * Rotation["z"])
    local direction = vec3(-math.sin(Adjuste[3]) * math.abs(math.cos(Adjuste[1])),math.cos(Adjuste[3]) * math.abs(math.cos(Adjuste[1])),math.sin(Adjuste[1]))

    return vec3(Coords[1] + direction[1] * Distance,Coords[2] + direction[2] * Distance,Coords[3] + direction[3] * Distance)
end

function RayCastGamePlayCamera()
    local Ped = PlayerPedId()
    local Cam = GetGameplayCamCoord()
    local Cam2 = GetCoordsFromCam(200.0,Cam)
    local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,Cam2,-1,Ped,4)
    local a,Hit,Coords,b,entity = GetShapeTestResult(Handle)

    return Hit,Coords,entity
end

function HSVToRGB(h,s,v)
    local r,g,b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    if i % 6 == 0 then
        r,g,b = v,t,p
    elseif i % 6 == 1 then
        r,g,b = q,v,p
    elseif i % 6 == 2 then
        r,g,b = p,v,t
    elseif i % 6 == 3 then
        r,g,b = p,q,v
    elseif i % 6 == 4 then
        r,g,b = t,p,v
    else
        r,g,b = v,p,q
    end

    return math.floor(r * 255),math.floor(g * 255),math.floor(b * 255)
end

--- Creates the blip thread.
---@return nil
function CreateBlipThread()
    local KVP = GetResourceKvpString("WallConfig")
    if KVP and KVP ~= "" then
        WallConfig = json.decode(KVP)
    end
    CreateThread(function()
        local playerPedId = PlayerPedId()
        while IsActive do
            local ThreadDelay = 1
            local Players = GetActivePlayers()

            for k,v in pairs(Players) do
                local PlayerServerId = GetPlayerServerId(v)
                local PlayerPed = GetPlayerPed(v)

                if not PlayerServerId or PlayerPed == 0 or not IsPedAPlayer(PlayerPed) or not DoesEntityExist(PlayerPed) then goto Skip end
                if v == PlayerId() then goto Skip end

                local PedCoords = GetEntityCoords(PlayerPed)
                local DistanceToPed = #(PedCoords - GetEntityCoords(playerPedId))

                local PlayerInfo = PlayersInfos[tostring(PlayerServerId)]
                if not PedCoords then goto Skip end
                if not PlayerInfo then
                    local VehicleOffset,VehicleSeat = GetPedVehicleOffset(PlayerPed)
                    local x = (VehicleSeat and VehicleOffset.x or PedCoords.x)
                    local y = (VehicleSeat and VehicleOffset.y or PedCoords.y)
                    local z = PedCoords.z + 1.0
                    local SourceText = ("\n SOURCE: [~g~"..PlayerServerId.."~w~]") or ""
                    local topText = SourceText
                    DrawTopText3D(x,y,z,topText)
                    local cx,cy,cz = table.unpack(GetEntityCoords(PlayerPedId()))
                    local currentTime = GetGameTimer()
                    local hue = (currentTime % 30000) / 15000.0
                    local x,y,z = table.unpack(GetEntityCoords(PlayerPed))
                    local r,g,b = HSVToRGB(hue,1,1)
                    DrawLine(cx,cy,cz,x,y,z,r,g,b,255)
                    goto Skip
                end
                if DistanceToPed > ViewDistance then goto Skip end

                local PlayerName = (IsEntityVisible(PlayerPed) and "~w~" or "~r~")..""..PlayerInfo.identity.name.."~w~"
                local PlayerHealth = GetEntityHealth(PlayerPed)
                PlayerHealth = PlayerHealth > 100 and "~g~"..PlayerHealth.."~w~" or "~r~MORTO~w~"
                local PlayerArmor = "~b~"..GetPedArmour(PlayerPed).."~w~"

                local SideText = ""
                if PlayerInfo.job then
                    SideText = SideText.."~y~"..PlayerInfo.job.."~w~"
                end
                local PurchasedText = ""
                -- if PlayerInfo.identity.purchased > 0 then
                --     PurchasedText = '\n'..PurchasedText..' | ~g~GASTO~w~'
                -- end
                local Wall = ""
                if PlayerInfo.wall then
                    Wall = "\n[~g~WALL~w~]"
                end
                local SourceText = (WallConfig["Source"] and "\n SOURCE: [~g~"..PlayerServerId.."~w~]") or ""
                local Staff = (PlayerInfo.staff and "[~r~"..PlayerInfo.staff.."~w~]") or ""
                local VehicleOffset,VehicleSeat = GetPedVehicleOffset(PlayerPed)
                local x = (VehicleSeat and VehicleOffset.x or PedCoords.x)
                local y = (VehicleSeat and VehicleOffset.y or PedCoords.y)
                local z = PedCoords.z + 1.0
                local topText = (WallConfig["Passport"] and "[~o~"..PlayerInfo.identity.id.."~w~] " or "")..PlayerName.." ("..SideText..") "..(PlayerInfo.staff and Staff or "")..""..(NetworkIsPlayerTalking(v) and "\n~y~FALANDO~w~" or "")
                local bottomText = (WallConfig["Health"] and PlayerHealth.." | "..PlayerArmor.."" or "")..SourceText..""..PurchasedText..Wall..(WallConfig["Vehicle"] and (VehicleSeat and "\n~y~P"..(VehicleSeat + 2).."~w~" or "") or "")

                DrawTopText3D(x,y,z,topText)
                DrawBottomText3D(x,y,z - 1.2,bottomText,DistanceToPed)

                ::Skip::
            end
            Wait(ThreadDelay)
        end
    end)

    Citizen.CreateThread(function()
        while IsActive do
            Citizen.Wait(0)
            local screenX,screenY = 0.5,0.5
            local endX,endY = 0.75,0.5
            DrawRect(screenX,screenY,0.0025,0.005,255,0,0,150)      -- Red dot.
            DrawLine(screenX,screenY,0.0,endX,endY,0.0,255,0,0,255) -- Red line.
        end
    end)

    CreateThread(function()
        while IsActive do
            local ThreadDelay = 250
            local Hit,EntCoords,Entity = RayCastGamePlayCamera(200.0)
            local cx,cy,cz = table.unpack(GetEntityCoords(PlayerPedId()))
            if Hit and Entity then
                Hitting = true
                DrawBoxAroundEntity(Entity,EntCoords)
                if Hit and Entity and DoesEntityExist(Entity) then
                    if IsEntityAPed(Entity) or IsEntityAVehicle(Entity) then
                        ThreadDelay = 1
                    end
                    if IsEntityAPed(Entity) and IsPedAPlayer(Entity) and IsControlJustReleased(0,38) then
                        local PlayerIndex = NetworkGetPlayerIndexFromPed(Entity)
                        if PlayerIndex and PlayerIndex ~= -1 then
                            local SourceId = GetPlayerServerId(PlayerIndex)
                            local PlayerInfo = PlayersInfos[tostring(SourceId)]
                            if PlayerInfo then
                                local MenuTitle = PlayerInfo.identity.id.." | "..PlayerInfo.identity.name
                                OpenAdminNUI("Player",SourceId,MenuTitle)
                            end
                        end
                    elseif IsEntityAVehicle(Entity) and IsControlJustReleased(0,38) then
                        local VehModel = GetEntityArchetypeName(Entity) or "N/E"
                        local MenuTitle = tostring(VehModel):upper().." | "..GetVehicleNumberPlateText(Entity)
                        --OpenAdminNUI('Vehicle', Entity, MenuTitle)
                    end
                end
            else
                Hitting = false
            end
            Wait(ThreadDelay)
        end
    end)
end

--- Get ped vehicle offset.
---@param Ped number
---@return table
---@return number | boolean
function GetPedVehicleOffset(Ped)
    local PedSeat = -2
    if not Ped or not DoesEntityExist(Ped) or not IsEntityAPed(Ped) or not IsPedAPlayer(Ped) then
        goto finish
    end

    if GetVehiclePedIsIn(Ped,false) ~= 0 then
        local Vehicle = GetVehiclePedIsIn(Ped,false)
        if not Vehicle or not DoesEntityExist(Vehicle) or not IsEntityAVehicle(Vehicle) then
            goto finish
        end
    end

    for i = -1,6 do
        if GetPedInVehicleSeat(GetVehiclePedIsIn(Ped,false),i) == Ped then
            PedSeat = i
            break
        end
    end

    if PedSeat ~= -2 and VehicleOffsets[PedSeat] then
        return GetOffsetFromEntityInWorldCoords(GetVehiclePedIsIn(Ped,false),VehicleOffsets[PedSeat][1],VehicleOffsets[PedSeat][2],0.0),PedSeat
    end

    ::finish::
    return { 0.0,0.0 },false
end

--- Draws a box around the ped.
---@param Entity number
---@return nil
function DrawBoxAroundEntity(Entity,LookingAtCoords)
    local cx,cy,cz = table.unpack(GetEntityCoords(PlayerPedId()))

    if not Entity or not DoesEntityExist(Entity) or not (IsEntityAVehicle(Entity) or (IsEntityAPed(Entity) and IsPedAPlayer(Entity))) then
        return
    end

    local x,y,z = table.unpack(GetEntityCoords(Entity))
    DrawLine(cx,cy,cz,x,y,z,255,255,255,255)

    if IsEntityAPed(Entity) then
        local LineOneBegin = GetOffsetFromEntityInWorldCoords(Entity,-0.3,-0.3,-0.9)
        local LineOneEnd = GetOffsetFromEntityInWorldCoords(Entity,0.3,-0.3,-0.9)
        local LineTwoBegin = GetOffsetFromEntityInWorldCoords(Entity,0.3,-0.3,-0.9)
        local LineTwoEnd = GetOffsetFromEntityInWorldCoords(Entity,0.3,0.3,-0.9)
        local LineThreeBegin = GetOffsetFromEntityInWorldCoords(Entity,0.3,0.3,-0.9)
        local LineThreeEnd = GetOffsetFromEntityInWorldCoords(Entity,-0.3,0.3,-0.9)
        local LineFourBegin = GetOffsetFromEntityInWorldCoords(Entity,-0.3,-0.3,-0.9)
        local TLineOneBegin = GetOffsetFromEntityInWorldCoords(Entity,-0.3,-0.3,0.8)
        local TLineOneEnd = GetOffsetFromEntityInWorldCoords(Entity,0.3,-0.3,0.8)
        local TLineTwoBegin = GetOffsetFromEntityInWorldCoords(Entity,0.3,-0.3,0.8)
        local TLineTwoEnd = GetOffsetFromEntityInWorldCoords(Entity,0.3,0.3,0.8)
        local TLineThreeBegin = GetOffsetFromEntityInWorldCoords(Entity,0.3,0.3,0.8)
        local TLineThreeEnd = GetOffsetFromEntityInWorldCoords(Entity,-0.3,0.3,0.8)
        local TLineFourBegin = GetOffsetFromEntityInWorldCoords(Entity,-0.3,-0.3,0.8)
        local ConnectorOneBegin = GetOffsetFromEntityInWorldCoords(Entity,-0.3,0.3,0.8)
        local ConnectorOneEnd = GetOffsetFromEntityInWorldCoords(Entity,-0.3,0.3,-0.9)
        local ConnectorTwoBegin = GetOffsetFromEntityInWorldCoords(Entity,0.3,0.3,0.8)
        local ConnectorTwoEnd = GetOffsetFromEntityInWorldCoords(Entity,0.3,0.3,-0.9)
        local ConnectorThreeBegin = GetOffsetFromEntityInWorldCoords(Entity,-0.3,-0.3,0.8)
        local ConnectorThreeEnd = GetOffsetFromEntityInWorldCoords(Entity,-0.3,-0.3,-0.9)
        local ConnectorFourBegin = GetOffsetFromEntityInWorldCoords(Entity,0.3,-0.3,0.8)
        local ConnectorFourEnd = GetOffsetFromEntityInWorldCoords(Entity,0.3,-0.3,-0.9)


        DrawLine(ConnectorOneBegin.x,ConnectorOneBegin.y,ConnectorOneBegin.z,ConnectorOneEnd.x,ConnectorOneEnd.y,ConnectorOneEnd.z,255,255,255,255)
        DrawLine(ConnectorTwoBegin.x,ConnectorTwoBegin.y,ConnectorTwoBegin.z,ConnectorTwoEnd.x,ConnectorTwoEnd.y,ConnectorTwoEnd.z,255,255,255,255)
        DrawLine(ConnectorThreeBegin.x,ConnectorThreeBegin.y,ConnectorThreeBegin.z,ConnectorThreeEnd.x,ConnectorThreeEnd.y,ConnectorThreeEnd.z,255,255,255,255)
        DrawLine(ConnectorFourBegin.x,ConnectorFourBegin.y,ConnectorFourBegin.z,ConnectorFourEnd.x,ConnectorFourEnd.y,ConnectorFourEnd.z,255,255,255,255)
        DrawLine(LineOneBegin.x,LineOneBegin.y,LineOneBegin.z,LineOneEnd.x,LineOneEnd.y,LineOneEnd.z,255,255,255,255)
        DrawLine(LineTwoBegin.x,LineTwoBegin.y,LineTwoBegin.z,LineTwoEnd.x,LineTwoEnd.y,LineTwoEnd.z,255,255,255,255)
        DrawLine(LineThreeBegin.x,LineThreeBegin.y,LineThreeBegin.z,LineThreeEnd.x,LineThreeEnd.y,LineThreeEnd.z,255,255,255,255)
        DrawLine(LineThreeEnd.x,LineThreeEnd.y,LineThreeEnd.z,LineFourBegin.x,LineFourBegin.y,LineFourBegin.z,255,255,255,255)
        DrawLine(TLineOneBegin.x,TLineOneBegin.y,TLineOneBegin.z,TLineOneEnd.x,TLineOneEnd.y,TLineOneEnd.z,255,255,255,255)
        DrawLine(TLineTwoBegin.x,TLineTwoBegin.y,TLineTwoBegin.z,TLineTwoEnd.x,TLineTwoEnd.y,TLineTwoEnd.z,255,255,255,255)
        DrawLine(TLineThreeBegin.x,TLineThreeBegin.y,TLineThreeBegin.z,TLineThreeEnd.x,TLineThreeEnd.y,TLineThreeEnd.z,255,255,255,255)
        DrawLine(TLineThreeEnd.x,TLineThreeEnd.y,TLineThreeEnd.z,TLineFourBegin.x,TLineFourBegin.y,TLineFourBegin.z,255,255,255,255)
    elseif IsEntityAVehicle(Entity) then
        local minVec,maxVec = GetModelDimensions(GetEntityModel(Entity))
        local length = maxVec.y - minVec.y
        local width = maxVec.x - minVec.x
        local height = (maxVec.z - minVec.z) / 2

        local frontLeft = GetOffsetFromEntityInWorldCoords(Entity,-width / 2,length / 2,-height)
        local frontRight = GetOffsetFromEntityInWorldCoords(Entity,width / 2,length / 2,-height)
        local rearLeft = GetOffsetFromEntityInWorldCoords(Entity,-width / 2,-length / 2,-height)
        local rearRight = GetOffsetFromEntityInWorldCoords(Entity,width / 2,-length / 2,-height)

        local frontLeftTop = GetOffsetFromEntityInWorldCoords(Entity,-width / 2,length / 2,height)
        local frontRightTop = GetOffsetFromEntityInWorldCoords(Entity,width / 2,length / 2,height)
        local rearLeftTop = GetOffsetFromEntityInWorldCoords(Entity,-width / 2,-length / 2,height)
        local rearRightTop = GetOffsetFromEntityInWorldCoords(Entity,width / 2,-length / 2,height)

        DrawLine(frontLeft.x,frontLeft.y,frontLeft.z,frontRight.x,frontRight.y,frontRight.z,255,255,255,255)
        DrawLine(frontRight.x,frontRight.y,frontRight.z,rearRight.x,rearRight.y,rearRight.z,255,255,255,255)
        DrawLine(rearRight.x,rearRight.y,rearRight.z,rearLeft.x,rearLeft.y,rearLeft.z,255,255,255,255)
        DrawLine(rearLeft.x,rearLeft.y,rearLeft.z,frontLeft.x,frontLeft.y,frontLeft.z,255,255,255,255)

        DrawLine(frontLeftTop.x,frontLeftTop.y,frontLeftTop.z,frontRightTop.x,frontRightTop.y,frontRightTop.z,255,255,255,255)
        DrawLine(frontRightTop.x,frontRightTop.y,frontRightTop.z,rearRightTop.x,rearRightTop.y,rearRightTop.z,255,255,255,255)
        DrawLine(rearRightTop.x,rearRightTop.y,rearRightTop.z,rearLeftTop.x,rearLeftTop.y,rearLeftTop.z,255,255,255,255)
        DrawLine(rearLeftTop.x,rearLeftTop.y,rearLeftTop.z,frontLeftTop.x,frontLeftTop.y,frontLeftTop.z,255,255,255,255)

        DrawLine(frontLeft.x,frontLeft.y,frontLeft.z,frontLeftTop.x,frontLeftTop.y,frontLeftTop.z,255,255,255,255)
        DrawLine(frontRight.x,frontRight.y,frontRight.z,frontRightTop.x,frontRightTop.y,frontRightTop.z,255,255,255,255)
        DrawLine(rearRight.x,rearRight.y,rearRight.z,rearRightTop.x,rearRightTop.y,rearRightTop.z,255,255,255,255)
        DrawLine(rearLeft.x,rearLeft.y,rearLeft.z,rearLeftTop.x,rearLeftTop.y,rearLeftTop.z,255,255,255,255)
    end
end

--- Handles the NUI opening.
---@param EntityType string
---@param EntityId number
---@param MenuTitleName string | nil
---@return nil
function OpenAdminNUI(EntityType,EntityId,MenuTitleName)
    OpenedType = EntityType
    OpenedEntity = EntityId

    local ConfigToOpen = Config[OpenedType]
    ConfigToOpen.title = MenuTitleName or "Gerenciador de Entidades"
    SendNUIMessage({ name = "updateData",payload = ConfigToOpen })
    SendNUIMessage({ name = "visibility",payload = true })
    SetNuiFocus(true,true)
    SetCursorLocation(0.8,0.4)
end

--- Closes the NUI.
---@return nil
function CloseNUI()
    SetNuiFocus(false,false)
    SendNUIMessage({ name = "visibility",payload = false })
end

--- Handles the NUI option selection.
RegisterNUICallback("selectOption",function(Data,Cb)
    if OpenedType == "Player" then
        local PlayerInfo = PlayersInfos[tostring(OpenedEntity)]
        if not PlayerInfo or not PlayerInfo.identity or not PlayerInfo.identity.id then
            TriggerEvent("Notify","vermelho","Jogador não encontrado, reconecte no servidor.",5000)
            return
        end
        server._ManagePlayer(PlayerInfo.identity.id,Data)
    elseif OpenedType == "Vehicle" then
        local VehNet = NetworkGetNetworkIdFromEntity(OpenedEntity)
        if not NetworkDoesNetworkIdExist(VehNet) then return end
        server._ManageVehicle(VehNet,OpenedEntity,Data)
    end

    CloseNUI()
    Cb(true)
end)

--- Handles the NUI closing.
RegisterNUICallback("closeUI",function(Data,Cb)
    CloseNUI()
    Cb(true)
end)

--- Command to set the blip distance.
RegisterCommand("blips-dist",function(_,args)
    if not args[1] then
        ViewDistance = 300
        TriggerEvent("Notify","verde","Distância resetada: <b>300m</b>.",3000)
    end

    local NewDistance = parseInt(args[1])
    if NewDistance > 474 then NewDistance = 474 end

    ViewDistance = NewDistance
    TriggerEvent("Notify","verde","Nova distância: <b>"..NewDistance.."m</b>.",3000)
end)

RegisterCommand("wallconfig2",function(_,args)
    local KeyBoard = exports["keyboard"]:keyFourth("Source:true/false","Passaporte:true/false","Vida:true/false","Veiculo:true/false")
    if KeyBoard and KeyBoard[4] then
        for i = 1,#KeyBoard do
            if KeyBoard[i] == "true" then
                KeyBoard[i] = true
            else
                KeyBoard[i] = false
            end
        end
        local Source = KeyBoard[1]
        local Passport = KeyBoard[2]
        local Health = KeyBoard[3]
        local Vehicle = KeyBoard[4]
        WallConfig = {
            Source = Source,
            Passport = Passport,
            Health = Health,
            Vehicle = Vehicle,
        }
        SetResourceKvp("WallConfig",json.encode(WallConfig))
    end
end)
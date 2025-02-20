function SetCam(campos)
    local ped = PlayerPedId()
    local spawnLocates = {}
    characterCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",campos["x"],campos["y"],campos["z"] + 200.0,270.00,0.0,0.0,80.0,0,0)
    SetCamActive(characterCamera,true)
    RenderScriptCams(true,false,1,true,true)
    DoScreenFadeIn(2500)
    while not IsScreenFadedIn() do 
        Wait(5) 
    end
    SetCamRot(characterCamera,270.0)
    SetCamActive(characterCamera,true)
    brokenCamera = false
    SetCamRot(characterCamera,270.0)
    SetCamActive(characterCamera,true)
    brokenCamera = true
    local speed = 0.4
    weight = 270.0
    local coords = GetEntityCoords(ped)

    SetCamCoord(characterCamera,coords["x"],coords["y"],coords["z"] + 200.0)
    local i = coords["z"] + 200.0
    while i > coords["z"] + 1.5 do
        i = i - speed
        SetCamCoord(characterCamera,coords["x"],coords["y"],i)

        if i <= coords["z"] + 14.0 and weight < 360.0 then
            if speed - 0.0078 >= 0.05 then
                speed = speed - 0.0078
            end

            weight = weight + 0.75
            SetCamRot(characterCamera,weight)
        end
        if i <= coords["z"] + 1.5 then
            brokenCamera = false
        end
        if not brokenCamera then
            break
        end

        Wait(0)
    end
    PostSpawnPlayer(ped)
end

function PostSpawnPlayer(ped)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(characterCamera, false)
    DestroyCam(characterCamera, true)
    Wait(500)
    FreezeEntityPosition(ped,false)
    TriggerEvent("notify:Tutorial")
    TriggerEvent("hud:Active",true)
end
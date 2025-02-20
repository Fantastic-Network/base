local keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["INSERT"] = 121, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["UP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local nearby = false

local points = {}

RegisterCommand("open_interactions", function()
    if nearby then
        local ply = PlayerPedId()
        local info = points[nearby]
        local coords = GetEntityCoords(ply)
        local distance = #(coords - info["loc"])
        if distance <= info["distance"] then
            info["callback"]()
        end
    end
end)

RegisterKeyMapping ( 'open_interactions' , 'Abrir Interactions' , 'keyboard' , 'e' )

CreateThread(
    function()
        while true do 
            local ply = PlayerPedId()
            local idle = 2500
            local lastCoords = GetEntityCoords(ply)
            for k,v in pairs(points) do 
                -- if v.key ~= "E" and not v.keyMapping then
                --     RegisterKeyMapping ( 'open_interactions' , 'Abrir Interactions' , 'keyboard' , v.key )
                --     points[k]["keyMapping"] = true
                -- end
                local coords = GetEntityCoords(ply)
                local distance = #(coords - v.loc)
                if distance <= 10 then 
                    idle = 1000
                else
                    goto continue
                end
                if distance <= tonumber(v.distance) then 
                    PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET")
                    nearby = k
                end

                while distance <= tonumber(v.distance) do
                    coords = GetEntityCoords(ply)
                    distance = #(coords - v.loc)
                    local bonePos =  GetPedBoneCoords(ply, 39317, 0,0,0)
                    local bol, sX, sY = GetScreenCoordFromWorldCoord(bonePos.x,bonePos.y,bonePos.z)
                    local camRot = GetGameplayCamRot(0)
                    local pedRot = GetEntityRotation(ply)
                    SendNUIMessage({ action = "updatePos", sX = sX, sY = sY, zoom = GetFollowPedCamZoomLevel(), camRotZ = camRot.z, pedRotZ = pedRot.z })
                    SendNUIMessage({ action = "updateData", key = type(v.key) == "number" and "E" or v.key, desc = v.desc, label = v.label})
                    -- SendNUIMessage({ action = "updateData", key = v.key, desc = v.desc, label = v.label})
                    if IsNuiFocused() then 
                        SendNUIMessage({ action = "hide"})
                    else
                        SendNUIMessage({ action = "show" })
                    end
                    Wait(15)
                end
                SendNUIMessage({ action = "hide"})
                ::continue::
            end
            Wait(idle)
        end
    end
)
registerInteraction = function(index, key, desc, label, loc, distance, callback)
    if not points[index] then 
        points[index] = {key = key, desc = desc, label = label, loc = loc, distance = distance, callback = callback}
    else 
        if points[index] then 
            points[index].key = key
            points[index].desc = desc
            points[index].label = label
            points[index].loc = loc
            points[index].distance = distance
        end
    end
end
exports("registerInteraction",registerInteraction)

changeInteraction = function(index, key, desc, label, loc, distance)
    if points[index] then 
        points[index].key = key
        points[index].desc = desc
        points[index].label = label
        points[index].loc = loc
        points[index].distance = distance
    end
end
exports("changeInteraction",changeInteraction)

removeInteraction = function(index)
    if points[index] then 
        points[index] = nil
    end
end

exports("removeInteraction",removeInteraction)


-- exemplo de uso em outros scripts
-- exports["interactions"]:registerInteraction("ClotheShop"..k2, "E", "Pressione para", "Abrir Loja", vector3(v2.x, v2.y, v2.z), 1.2, function()
--     openLoja()
-- end)

-- registerInteraction("ClotheShop", "E", "Pressione para", "Abrir Loja", vector3(1879.5, 2602.97, 45.68), 2.2, function()
--     print('ksajdkj')
-- end)

RegisterNUICallback("getCityName",function(Data,Callback)
    cityName = GetConvar("cityName", "Base")
    Callback(string.lower(cityName))
end)
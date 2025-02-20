-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText(x,y,z,Message)
    local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
    
    if onScreen then
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringKeyboardDisplay(Message)
        SetTextColour(255,255,255,150)
        SetTextScale(0.35,0.35)
        SetTextFont(4)
        SetTextCentre(1)
        EndTextCommandDisplayText(_x,_y)
        
        local width = string.len(Message) / 160 * 0.45
        DrawRect(_x,_y + 0.0125,width,0.03,15,15,15,175)
    end
end
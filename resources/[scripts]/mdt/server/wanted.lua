-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.GetWanteds(Page)
    return GetWanteds(Page or 1)
end

function Server.SetWanted(Wanted,Reason)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        SetWanted(Wanted,Passport,Reason)
    end
end

function Server.RemoveWanted(Wanted)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        RemoveWanted(Wanted)
    end
end
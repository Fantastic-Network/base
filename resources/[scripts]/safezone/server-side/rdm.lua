function sRP.HasPermission(Group,Victim)
    local source = source
    local Passport = vRP.Passport(source)
    local Perm = string.gsub(Group, "-.*", "")
    local HasPerm = (vRP.HasGroup(Passport, Group) or vRP.HasPermission(Passport, "Admin"))
    if not HasPerm then
        CreateThread(function()
            Wait(1000)
            if DoesPlayerExist(Victim) then
                vRP.Revive(Victim,400)
            end
        end)
    end
    return HasPerm
end
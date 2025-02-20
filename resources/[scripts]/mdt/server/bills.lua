-----------------------------------------------------------------------------------------------------------------------------------------
-- BILLS
-----------------------------------------------------------------------------------------------------------------------------------------
function Server.CreateBill(Player,TableInfractions,Description)
    local source = source
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Policia",3) then
        local Amount = 0
        for i=1,#TableInfractions do
            local Infraction = tostring(TableInfractions[i])
            if InfractionsInfo[Infraction] then
                Amount = Amount + InfractionsInfo[Infraction]["bill"]
            end
        end
        CreateBill(Player,Passport,Amount,Description)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET ARRESTED
----------------------------------------------------------------------------------------------------------------------------------------- 
function Server.SetArrested(Prisoner,Description,reduceSentence,reductionBill,TableInfractions)
    local source = source
    local Passport = vRP.Passport(source)
    local Sentence = 0
    local Bill = 0
    Infraction = 101
    if vRP.HasGroup(Passport,"Policia",3) then
        print(Passport,Description)
        for i=1,#TableInfractions do
            local Infraction = tostring(TableInfractions[i])
            if InfractionsInfo[Infraction] then
                Sentence = Sentence + InfractionsInfo[Infraction]["time"]
                Bill = Bill + InfractionsInfo[Infraction]["bill"]
            end
        end
        if reduceSentence > 0 then
            Sentence = parseInt(Sentence * (1 - reduceSentence))
        end
        if reductionBill > 0 then
            Bill = parseInt(Bill * (1 - reductionBill))
        end
        if Sentence > 140 then
            Sentence = 140
        end
        CreateBill(Prisoner,Passport,Bill,Description,nil,true)
        ArrestPlayer(Passport,Prisoner,Description,json.encode(TableInfractions),Sentence)
        TriggerClientEvent("Notify",source,"sucesso","Você prendeu <b>"..vRP.FullName(Prisoner).."</b> por <b>"..Sentence.." meses</b> e uma multa de <b>$"..Bill.."</b>.",8000)
        -- TriggerClientEvent("Notify2",source,"#uArrestedPlayer",{msg=vRP.FullName(Prisoner),msg2=Sentence,msg3=Bill})
        exports["vrp"]:SendWebHook("prisao", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Prendeu:** " .. Prisoner .. " " .. vRP.FullName(Prisoner) .. "\n**Tempo:** " .. Sentence .. "\n**Descrição:** " .. Description .. "\n**Multa:** " .. Bill .. "" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
    end
end
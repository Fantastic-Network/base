RegisterCommand("e",function(source,Message)
	local Passport = vRP.Passport(source)
    if Player(source)["state"]["Buttons"] then
        return
    end
	if Passport and vRP.GetHealth(source) and vRP.GetHealth(source) > 100 then
        local args = Message
        local user_id = vRP.Passport(source)
        local identity = vRP.Identity(user_id)
        local nplayer = vRPC.ClosestPed(source,1)
        local Ped
        local Health = false
        if nplayer then
            Ped = GetPlayerPed(nplayer)
            Health = vRPC.GetHealth(nplayer)
        end
        if nplayer and Ped and GetVehiclePedIsIn(Ped, false) and GetVehiclePedIsIn(Ped, false) == 0 and Health and Health > 100 then
            if args[1] == "abracar1" then
                if vRP.Request(nplayer,"Deseja beijar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,0.8)
                    TriggerClientEvent("abracarr1",source)
                    TriggerClientEvent("abracarr2",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal" then
                if vRP.Request(nplayer,"Deseja beijar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.4)
                    TriggerClientEvent("casal",source)
                    TriggerClientEvent("casal1",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal2" then
                if vRP.Request(nplayer,"Deseja beijar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,0.63)
                    TriggerClientEvent("casal2",source)
                    TriggerClientEvent("casall2",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal3" then
                if vRP.Request(nplayer,"Deseja sentar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.77)
                    TriggerClientEvent("casal3",source)
                    TriggerClientEvent("casall3",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal4" then
                if vRP.Request(nplayer,"Deseja beijar igual cinema <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.37)
                    TriggerClientEvent("casal4",source)
                    TriggerClientEvent("casall4",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal5" then
                if vRP.Request(nplayer,"Deseja beijar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.2)
                    TriggerClientEvent("casal5",source)
                    TriggerClientEvent("casall5",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal6" then
                if vRP.Request(nplayer,"Deseja beijar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.4)
                    TriggerClientEvent("casal6",source)
                    TriggerClientEvent("casall6",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal7" then
                if vRP.Request(nplayer,"Deseja abraçar você <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.4)
                    TriggerClientEvent("casal7",source)
                    TriggerClientEvent("casall7",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal8" then
                if vRP.Request(nplayer,"Deseja dançar junto <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,0.3)
                    TriggerClientEvent("casal8",source)
                    TriggerClientEvent("casall8",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "casal9" then
                if vRP.Request(nplayer,"Deseja dançar junto <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,0.3)
                    TriggerClientEvent("casal9",source)
                    TriggerClientEvent("casall9",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "lutar1" then
                if vRP.Request(nplayer,"Deseja lutar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.5)
                    TriggerClientEvent("lutar1",source)
                    TriggerClientEvent("lutarr1",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "lutar2" then
                if vRP.Request(nplayer,"Deseja lutar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.7)
                    TriggerClientEvent("lutar2",source)
                    TriggerClientEvent("lutarr2",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "lutar3" then
                if vRP.Request(nplayer,"Deseja lutar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.7)
                    TriggerClientEvent("lutar3",source)
                    TriggerClientEvent("lutarr3",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "lutar4" then
                if vRP.Request(nplayer,"Deseja lutar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.7)
                    TriggerClientEvent("lutar4",source)
                    TriggerClientEvent("lutarr4",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "lutar5" then
                if vRP.Request(nplayer,"Deseja lutar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.7)
                    TriggerClientEvent("lutar5",source)
                    TriggerClientEvent("lutarr5",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "lutar6" then
                if vRP.Request(nplayer,"Deseja lutar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.7)
                    TriggerClientEvent("lutar6",source)
                    TriggerClientEvent("lutarr6",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "lutar7" then
                if vRP.Request(nplayer,"Deseja lutar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.7)
                    TriggerClientEvent("lutar7",source)
                    TriggerClientEvent("lutarr7",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            elseif args[1] == "lutar8" then
                if vRP.Request(nplayer,"Deseja lutar <b>"..identity.name.." "..identity.name2.."</b> ?","Sim","Não") then
                    TriggerClientEvent("syncanim",source,1.7)
                    TriggerClientEvent("lutar8",source)
                    TriggerClientEvent("lutarr8",nplayer)
                else
                    TriggerClientEvent("Notify",source,"negado","NEGADO","A pessoa negou o abraço.")
                end
            else
                TriggerClientEvent("emotes",source,Message[1])
            end
        else
            TriggerClientEvent("emotes",source,Message[1])
        end
	end
end)
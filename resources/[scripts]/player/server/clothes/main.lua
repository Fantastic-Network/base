
-----------------------------------------------------------------------------------------------------------------------------------------
-- /mascara
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(Source,Message)
	local Passport = vRP.Passport(Source)
	if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then		
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then 
            TriggerClientEvent("setmascara",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /blusa
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(Source,Message)
	local Passport = vRP.Passport(Source)
	if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then		
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("setblusa",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /colete
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(Source,Message)
	local Passport = vRP.Passport(Source)
	if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then		
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("setcolete",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /jaqueta
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(Source,Message)
	local Passport = vRP.Passport(Source)
	if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then		
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("setjaqueta",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /maos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(Source,Message)
	local Passport = vRP.Passport(Source)
	if Passport then
		if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then	
            if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
                TriggerClientEvent("setmaos",Source,Message[1],Message[2])
            else
                TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
                -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /calca
---------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(Source,Message)
	local Passport = vRP.Passport(Source)
	if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then		
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("setcalca",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /acessorios
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(Source,Message)
	local Passport = vRP.Passport(Source)
	if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then		
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("setacessorios",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sapatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(Source,Message)
	local Passport = vRP.Passport(Source)
	if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then		
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("setsapatos",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /chapeu
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(Source,Message)
	local Passport = vRP.Passport(Source)
    if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then	
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("setchapeu",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /oculos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(Source,Message)
	local Passport = vRP.Passport(Source)
    if Passport and vRP.GetHealth(Source) and vRP.GetHealth(Source) > 101 then	
        if vRP.HasGroup(Passport,"Roupas2") or vRP.HasGroup(Passport, "Admin", 3) then
            TriggerClientEvent("setoculos",Source,Message[1],Message[2])
        else
            TriggerClientEvent("Notify",Source,"vermelho","Você não tem permissão para usar esse comando, adquira já um vip em nossa loja.",7500,"Permissão")
            -- TriggerClientEvent("Notify2",Source,"#comandoNpermitido")
        end
    end
end)
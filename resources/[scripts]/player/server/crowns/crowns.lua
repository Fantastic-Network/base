vRP.Prepare("crowns/Check","SELECT * FROM crowns")
vRP.Prepare("crowns/Remove","DELETE FROM crowns WHERE id = @id")
vRP.Prepare("crowns/CheckId","SELECT * FROM crowns WHERE id = @id")
vRP.Prepare("crowns/Add","INSERT INTO crowns(Name,Coords,Color,Sprite,Serial) VALUES (@Name,@Coords,@Color,@Sprite,@Serial)")


-- DROP TABLE IF EXISTS `crowns`;
-- CREATE TABLE IF NOT EXISTS `crowns` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `Serial` varchar(50) NOT NULL,
--   `Name` varchar(50) NOT NULL,
--   `Coords` longtext DEFAULT NULL,
--   `Color` int(3) NOT NULL DEFAULT 1,
--   `Sprite` int(3) NOT NULL DEFAULT 1,
--   PRIMARY KEY (`id`),
--   KEY `id` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPMARK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("blipmark",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin") then
		local Messages = ""
		local Consult = vRP.Query("crowns/Check")

		for _,v in pairs(Consult) do
			Messages = Messages.."<b>ID:</b>"..v["id"].." - <b>Nome:</b>"..v["Name"].."<br>"
		end

		if Messages ~= "" then
			TriggerClientEvent("BigNotify",source,"verde",Messages,10000)
            -- TriggerClientEvent("Notify2",source,"#blipmark",{msg=Messages})
            TriggerClientEvent("copyToClipboard",source,Messages)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("bliped",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.HasGroup(Passport,"Admin")  then
        local Keyboard = vKEYBOARD.keySingle(source,"Adicionar/Remover:")
        if Keyboard and Keyboard[1] then
            if Keyboard[1] == "Adicionar" then
                local Ped = GetPlayerPed(source)
                local Coords = GetEntityCoords(Ped)
                local Coords = mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])
                Wait(250)
                local Keyboard = vKEYBOARD.keyTriple(source,"Nome:","Cor:","Sprite:")
                if Keyboard and Keyboard[1] then
                    local Serials = vRP.GeneratePlate()
                    vRP.Query("crowns/Add",{ Name = Keyboard[1], Coords = tostring(Coords), Color = Keyboard[2], Sprite = Keyboard[3], Serial = Serials })
                    vCLIENT.AddCrown(-1,{ Name = Keyboard[1], Serial = Serials, Coords = Coords, Color = parseInt(Keyboard[2]) , Sprite = parseInt(Keyboard[3]) })
                end
            elseif Keyboard[1] == "Remover" then
                Wait(250)
                local Keyboard = vKEYBOARD.keySingle(source,"Id do blip:")
                if Keyboard and Keyboard[1] then
                    local Consult = vRP.Query("crowns/CheckId",{ id = parseInt(Keyboard[1]) })
                    if Consult[1] then
                        vCLIENT.RemoveCrown(-1,Consult[1]["Serial"])
                        vRP.Query("crowns/Remove",{ id = parseInt(Keyboard[1]) })
                    end
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local Consult = vRP.Query("crowns/Check")
	vCLIENT.FullCrown(source,Consult)
end)
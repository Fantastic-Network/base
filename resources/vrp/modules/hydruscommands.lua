RegisterCommand("GiveMoney",function(Source,Message)
    if Source == 0 then
        vRP.GiveBank(parseInt(Message[1]),parseInt(Message[2]),"GiveMoney Command")
    end
end)

RegisterCommand("GiveGarage",function(Source,Message)
    if Source == 0 then
        vRP.Query("characters/giveGarage",{ Passport = parseInt(Message[1]), garages = parseInt(Message[2]) })
    end
end)

RegisterCommand("GiveVehicle",function(Source,Message)
    if Source == 0 then
        vRP.Query("vehicles/addVehicles",{ Passport = parseInt(Message[1]), vehicle = Message[2], plate = vRP.GeneratePlate(), work = "false" })
    end
end)

RegisterCommand("RemVehicle",function(source,Message)
    if Source == 0 then
        vRP.Query("vehicles/removeVehicles",{ Passport = parseInt(Keyboard[1]), vehicle = Keyboard[2] })
    end
end)


RegisterCommand("GiveTitle",function(Source,Message)
    if Source == 0 then
        vRP.GiveTitle(parseInt(Message[1]),Message[2])
    end
end)

RegisterCommand("GiveItem",function(Source,Message)
    if Source == 0 then
        vRP.GenerateItem(parseInt(Message[1]),Message[2],parseInt(Message[3]),true)
    end
end)

vRP.Prepare("battlepass/givePremium","UPDATE battlepass SET hasPremium = 1 WHERE passport = @Passport")
RegisterCommand("GivePass",function(Source,Message)
    if Source == 0 then
        vRP.Query("battlepass/givePremium",{ Passport = parseInt(Message[1])})
        TriggerEvent("UpdatePlayerPass",parseInt(Message[1]))
    end
end)

RegisterCommand("GiveDiamond",function(Source,Message)
    if Source == 0 then
        local Identity = vRP.Identity(parseInt(Message[1]))
        vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = parseInt(Message[2]) })
    end
end)

RegisterCommand("RemDiamond",function(Source,Message)
    if Source == 0 then
        local Identity = vRP.Identity(parseInt(Message[1]))
        vRP.Query("accounts/RemoveGems",{ license = Characters[source]["license"], gems = parseInt(Message[2]) })
    end
end)

RegisterCommand("RemGroup",function(Source,Message)
    if Source == 0 then
        vRP.RemovePermission(parseInt(Message[1]),Message[2])
    end
end)

RegisterCommand("SetFac",function(Source,Message)
    if Source == 0 then
        local Passport = parseInt(Message[1])
        local Level = Message[2]
        local Job = vRP.UserGroupByType(Passport,"Job")
        vRP.Query("painel/setFacLevel",{ level = Level, name = Job })
    end
end)

RegisterCommand("RemoAdv",function(Source,Message)
    if Source == 0 then
        local OtherPassport = parseInt(Message[1])
        local Identity = vRP.Identity(OtherPassport)
        if Identity then
            local Account = vRP.Account(Identity["license"])
            local Source = vRP.Source(OtherPassport)
            vRP.Query("temporary_banneds/deleteBanned",{ id = Account["id"]})
            vRP.ResetTemporaryBanneds(Account["id"],OtherPassport)
            exports["vrp"]:SendWebHook("remadv","**Removeu:** Hydrus\n**Recebeu:** "..Account["discord"].."\n**Account id:** "..Account["id"].."\n\n**Passaporte:** "..OtherPassport.."\n**Retirou ban:**Hydrus\n**Data:** "..os.date("%d/%m/%Y - %H:%M:%S"),10038562)
            if Source then
                TriggerClientEvent("temp_banned:Rem",Source)
            end
        end
    end
end)

local Kits = {
    ["Wipe"] = {
        ["Group"] = {
            ["Roupas"] = 30,
        },
        ["Item"] = {
            ["WEAPON_PISTOL_MK2"] = 15,
            ["WEAPON_PISTOL_AMMO"] = 1500,
            ["WEAPON_SPECIALCARBINE_MK2"] = 5,
            ["WEAPON_RIFLE_AMMO"] = 1250,
            ["vest"] = 10,
            ["WEAPON_PUMPSHOTGUN_MK2"] = 3,
            ["WEAPON_SHOTGUN_AMMO"] = 150,
        },
        ["Car"] = {
            ["urussanta"] = 0,
        },
    }
}

RegisterCommand("GiveKitWipe",function(Source,Message)
    if Source == 0 then
        local Passport = parseInt(Message[1])
        local Identity = vRP.Identity(Passport)
        local Source = vRP.Source(Passport)
        if Identity then
            local Account = vRP.Account(Identity["license"])
            if Account and Account["id"] then
                vRP.Query("accounts/UpdatePriority",{ AccountId = Account["id"], priority = 99 })
                -- if Source then
                --     vRP.GiveKit(Passport,KitWipe)
                -- end
                vRP.Query("delivery_kit/InsertKit",{ AccountId = Account["id"], Info = json.encode(Kits["Wipe"]) })
            end
        end
    end
end)


RegisterCommand("GivePriorityId",function(Source,Message)
    if Source == 0 then
        if Message[1] and Message[2] then
            local Identity = vRP.Identity(parseInt(Message[1]))
            if Identity then
                local License = Identity["license"]
                vRP.Query("accounts/setPriority",{ parseInt(Message[2]),License })
            end
        end
    end
end)

RegisterCommand("GivePriorityLicense",function(Source,Message)
    if Source == 0 then
        if Message[1] and Message[2] then
            local License = Message[1]
            vRP.Query("accounts/setPriority",{ parseInt(Message[2]),License })
        end
    end
end)
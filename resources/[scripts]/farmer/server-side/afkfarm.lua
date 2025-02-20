local FarmingCooldown = {}

function GetGroupFarm(Group)
    local Selected = {}
    for Farm,Table in pairs(Farming) do
        if Table["Permissions"][Group] then
            table.insert(Selected,Farm)
        end
    end
    return Selected
end

local EconomyAFK = 1

CreateThread(function()
    Wait(1000)
    EconomyAFK = exports['variables']:GetVariable('variables','EconomyAFK') or 1
end)

RegisterServerEvent("farmer:Farming")
AddEventHandler("farmer:Farming",function()
    local source = source
    local Passport = vRP.Passport(source)
    local Job,Rank,Group,Hierarchy = vRP.UserGroupByType(Passport,'Job')
    if GlobalState["Restarting"] then
        return false
    end
    if Passport then
        if not Player(source)["state"]["Farming"] then
            return
        end
        local Selected = GetGroupFarm(Job)
        if Selected and Selected[1] then
            if not FarmingCooldown[Passport] or os.time() > FarmingCooldown[Passport] then
                for i=1,#Selected do
                    if Farming[Selected[i]] then
                        FarmingCooldown[Passport] = os.time() + 50
                        local AllowedVips = {
                            ["Bronze"] = 1.05,
                            ["Prata"] = 1.10,
                            ["Ouro"] = 1.20,
                            ["Black"] = 1.25,
                            ["VipLancamento"] = 1.30
                        }
                        local NewVips = vRP.HasVip(Passport)
                        local Bonus = 1
                        if NewVips then
                            for Group,_ in pairs(NewVips) do
                                if AllowedVips[Group] then
                                    if AllowedVips[Group] > Bonus then
                                        Bonus = AllowedVips[Group]
                                    end
                                end
                            end
                        end
                        local Job = vRP.UserGroupByType(Passport,'Job')
                        local GroupBuff = exports["crafting"]:getGroupFarmBuff(Job) or 1
                        for Item,Info in pairs(Farming[Selected[i]]["Items"]) do
                            local Random = parseInt(math.random(Info[1],Info[2]) * Bonus)
                            if GlobalState["WipeBonus"] and GlobalState["WipeBonus"] > 0 then
                                Random = Random * Random["WipeBonus"]
                            end
                            -- NERF
                            Random = parseInt(Random * 0.2)
                            Random = parseInt(Random * GroupBuff)
                            Random = parseInt(Random * EconomyAFK)
                            --
                            vRP.GenerateItem(Passport,Item,parseInt(Random),true)
                            TriggerClientEvent("Notify",source,"verde","Você recebeu <b>"..Item.." x"..Random.." </b>.",5000,"FARM")
                            -- TriggerClientEvent("Notify2",source,"#recebeuItem",{msg=Item,msg2=Random})
                        end
                    end
                end
            end
        end
    end
end)
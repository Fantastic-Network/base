Config = {
    variables = {
        -- ["SalaryTimer"] = {
        --     value = 60*60,
        --     shared = false,
        -- },
        -- ["SalaryEconomy"] = {
        --     value = 1,
        --     shared = false,
        -- },
        -- ["GroupsSalaryEconomy"] = {
        --     value = {
        --         ["Ouro"] = { 60000 }, -- SUBSTITUI O SALARIO DA CONFIG DO VRP
        --     },
        --     shared = false,
        -- },
        ["EconomyAFK"] = {
            value = 1,
            shared = false,
        },
        -- ["PaymentBus"] = {
        --     value = {5000,6000},
        --     shared = false,
        -- },
        -- ["PaymentFarmer"] = {
        --     value = {
        --         ["Separate"] = {
        --             ["Consume"] = {
        --                 ["graos"] = { 
        --                     ["Amount"] = 1,
        --                     ["Give"] = {
        --                         ["cereais"] = 1,
        --                     },
        --                 },
        --             }
        --         },
        --         ["Route"] = {
        --             ["Give"] = {
        --                 ["graos"] = 1,
        --             }
        --         }
        --     },
        --     shared = false,
        -- },
        -- ["PaymentFireMan"] = {
        --     value = {1000,3000},
        --     shared = false,
        -- },
        -- ["PaymentChicken"] = {
        --     value = {3500,4000},
        --     shared = false,
        -- },
        -- ["PaymentPostOffice"] = {
        --     value = {3500,4000},
        --     shared = false,
        -- },
        -- ["PaymentMechanic"] = {
        --     value = {1,2},
        --     shared = false,
        -- },
        -- ["PaymentHospital"] = {
        --     value = {1,2},
        --     shared = false,
        -- },
        -- ["EconomyRoutesItens"] = { -- NERFAR CRIACAO DE UM UNICO ITEM
        --     value = {
        --         ["dinheirosujo"] = 1, -- Porcentagem
        --     },
        --     shared = false,
        -- },
        -- ["EconomyRoutes"] = { -- NERFAR CRIACAO DE TODOS OS ITENS SOMA COM O EconomyRoutesItens
        --     value = 1,
        --     shared = false,
        -- },
        -- ["CharacterItens"] = {
        --     value = {
        --         {"cellphone",1},
        --         {"dollars",25000},
        --         {"creator",2},
        --     },
        --     shared = false,
        -- },
        -- ["StarterBank"] = {
        --     value = 20000,
        --     shared = false,
        -- },
        -- ["ModifiedStores"] = {
        --     value = {
        --         ["BuyDirty"] = {
        --             ["mode"] = "Buy",
        --             ["type"] = "Dirty",
        --             ["name"] = "DirtyStore",
        --             ["List"] = {
        --                 ["WEAPON_SPECIALCARBINE_MK2"] = 390000,
        --                 ["WEAPON_CARBINERIFLE_MK2"] = 300000,
        --                 ["WEAPON_SPECIALCARBINE"] = 290000,
        --                 ["WEAPON_ASSAULTRIFLE_MK2"] = 320000,
        --                 ["WEAPON_ASSAULTRIFLE"] = 280000,
        --                 ["WEAPON_PISTOL_MK2"] = 190000,
        --                 ["WEAPON_COMBATPISTOL"] = 160000,
        --                 ["WEAPON_PUMPSHOTGUN"] = 750000,
        --                 ["cocaine"] = 15000,
        --                 ["joint"] = 15000,
        --                 ["meth"] = 15000,
        --                 ["handcuff"] = 15000,
        --                 ["WEAPON_RIFLE_AMMO"] = 1000,
        --                 ["WEAPON_PISTOL_AMMO"] = 750,
        --                 ["WEAPON_SMG_AMMO"] = 750,
        --                 ["WEAPON_SHOTGUN_AMMO"] = 2000,
        --                 ["WEAPON_SNIPER_AMMO"] = 1250,
        --             }
        --         },
        --     },
        --     shared = true,
        -- },
        -- ["ShopBuy"] = {
        --     value = 1.0,
        --     shared = true,
        -- },
        -- ["ShopSell"] = {
        --     value = 1.0,
        --     shared = true,
        -- },
        -- ["DealerShipSelected"] = {
        --     value = {
        --         ["akuma"] = 1000000,
        --     },
        --     shared = true,
        -- },
        -- ["RobberysAll"] = {
        --     value = 1.0,
        --     shared = true,
        -- },
        -- ["SelectedRobberys"] = {
        --     value = {
        --         ["1"] = {
        --             ["payment"] = {
        --                 { ["item"] = "dinheirosujo", ["min"] = 180000, ["max"] = 220000 }
        --             },
        --         }
        --     },
        --     shared = true,
        -- },
        ["EconomyAllCraft"] = {
            value = 1.0,
            shared = true,
        },
        ["FreeCar"] = {
            value = "camaro",
            shared = false,
        },
        ["MultiSpawnList"] = {
            value = {
                ["baller3"] = true,
                ["swift2"] = true,
                ["Kcarbonrs"] = true,
                ["benson"] = true,
                ["pounder2"] = true,
                ["dubsta"] = true,
                ["pounder"] = true,
                ["Kbati"] = true,
                ["mule2"] = true,
                ["buzzard2"] = true,
                ["Kakuma"] = true,
                ["mule"] = true,
                ["landstalker"] = true,
            },
            shared = false,
        },
        ["BoostList"] = {
            value = {
                ["landstalker"] = 0.12,
            },
            shared = true,
        },
        -- ["NormalStamina"] = {
        --     value = {
        --         ["Base"] = true,
        --     },
        --     shared = true,
        -- }
    },
    
    functions = {
        -- ["KitFogueteiro"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",100)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",50)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",50)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",15000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",15000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",15000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["PackPremium"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",800)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",800)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",8000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",200000)
        --         vRP.GenerateItem(Passport,"c4",80)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["KitCriminal"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",75)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",75)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",150)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",25000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",25000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["KitCriminal"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",75)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",75)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",150)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",25000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",25000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["KitMafioso"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",125)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",125)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",250)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",25000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",25000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["KitDosRaul"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",175)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",175)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",375)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",30000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",30000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["KitBoqueta"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",25000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",25000)
        --         -- vRP.GenerateItem(Passport,"cocaine",1000)
        --         -- vRP.GenerateItem(Passport,"joint",1000)
        --         TriggerClientEvent("inventory:Update",source,"Backpack")
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["Premium03"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"dollars",10000000)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",50)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",50)
        --         vRP.GenerateItem(Passport,"vest",100)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",5000)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",5000)
    
        --         TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
        --         -- TriggerClientEvent("Notify2",source,"#itemUsed",{msg=itemName(Full)})
        --         --vRP.Query("bank_log/AddBank",{ Passport = Passport, Amount = Amount, Type = Item})
        --         TriggerClientEvent("inventory:Update",source,"Backpack")
        --         ExecuteCommand("SetVehicles "..Passport.." 1 Lendário rmodp1gtr,oycdefender,mercedesgt63,taycan,r1250,x6mf16,audir8,cbr,bm422pxx2ncs,mercedesg65,mclarensenna,terzo,lancerevolution9,rs6avant20,rvgxrx7,urus,nissangtr3,skyliner34")
        --         ExecuteCommand("SetVehicles "..Passport.." 1 Vip saveirog7,kiagt,civictyper,mazdarx7,acuransx,nissangtrnismo,c63,nissangtr,marshall,skyliner34,lancerevolutionx,subaruimpreza,teslamodels,lamborghinihuracanlw,675ltsp,porsche911,bmwm1wb,rmodgt63mini,SC18Hartge,tesroad20,toyotasupra2,rangerover,golfgti,lx2018,corvettec7,f800,160,xj6,hornet,mp412c,lancerevolution9,rmodm4,nissangtr,fordmustang,bnr34")
        --         vRP.SetPermission(Passport,"Ouro",1)
        --         vRP.SetPermission(Passport,"Spotify",1)
        --         vRP.SetPermission(Passport,"Roupas2",1)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["Premium04"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"dollars",10000000)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",20)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",20)
        --         vRP.GenerateItem(Passport,"vest",50)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",2000)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",2000)

        --         TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
        --         TriggerClientEvent("inventory:Update",source,"Backpack")
        --         ExecuteCommand("SetVehicles "..Passport.." 2 Vip saveirog7,kiagt,civictyper,mazdarx7,acuransx,nissangtrnismo,c63,nissangtr,marshall,skyliner34,lancerevolutionx,subaruimpreza,teslamodels,lamborghinihuracanlw,675ltsp,porsche911,bmwm1wb,rmodgt63mini,SC18Hartge,tesroad20,toyotasupra2,rangerover,golfgti,lx2018,corvettec7,f800,160,xj6,hornet,mp412c,lancerevolution9,rmodm4,nissangtr,fordmustang,bnr34")
        --         vRP.SetPermission(Passport,"Prata",1)
        --         vRP.SetPermission(Passport,"Spotify",1)
        --         vRP.SetPermission(Passport,"Roupas2",1)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["Premium05"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"dollars",5000000)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE",5)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",5)
        --         vRP.GenerateItem(Passport,"vest",10)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",500)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",500)
        --         TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
        --         ExecuteCommand("SetVehicles "..Passport.." 1 Vip saveirog7,kiagt,civictyper,mazdarx7,acuransx,nissangtrnismo,c63,nissangtr,marshall,skyliner34,lancerevolutionx,subaruimpreza,teslamodels,lamborghinihuracanlw,675ltsp,porsche911,bmwm1wb,rmodgt63mini,SC18Hartge,tesroad20,toyotasupra2,rangerover,golfgti,lx2018,corvettec7,f800,160,xj6,hornet,mp412c,lancerevolution9,rmodm4,nissangtr,fordmustang,bnr34")
        --         TriggerClientEvent("inventory:Update",source,"Backpack")
        --         vRP.SetPermission(Passport,"Bronze",1)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["VipSorteio"] = {
        --     func = function(Passport, source)
        --         TriggerClientEvent("Notify",source,"verde",itemName(Full).." utilizado.",5000)
        --         TriggerClientEvent("inventory:Update",source,"Backpack")
        --         ExecuteCommand("SetVehicles "..Passport.." 1 Vip saveirog7,kiagt,civictyper,mazdarx7,acuransx,nissangtrnismo,c63,nissangtr,marshall,skyliner34,lancerevolutionx,subaruimpreza,teslamodels,lamborghinihuracanlw,675ltsp,porsche911,bmwm1wb,rmodgt63mini,SC18Hartge,tesroad20,toyotasupra2,rangerover,golfgti,lx2018,corvettec7,f800,160,xj6,hornet,mp412c,lancerevolution9,rmodm4,nissangtr,fordmustang,bnr34")
        --         vRP.SetPermission(Passport,"VipSorteio",1)
        --         vRP.SetPermission(Passport,"Spotify",1)
        --         vRP.SetPermission(Passport,"Roupas2",1)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["PackElite"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_MK2",600)
        --         vRP.GenerateItem(Passport,"WEAPON_SPECIALCARBINE_MK2",600)
        --         vRP.GenerateItem(Passport,"WEAPON_PISTOL_AMMO",6000)
        --         vRP.GenerateItem(Passport,"WEAPON_RIFLE_AMMO",150000)
        --         vRP.GenerateItem(Passport,"c4",60)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["Money1"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"dollars",50000000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["Money2"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"dollars",25000000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["Money3"] = {
        --     func = function(Passport, source)
        --         vRP.GenerateItem(Passport,"dollars",10000000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["Money4"] = {
        --     func = function(Passport,source)
        --         vRP.GenerateItem(Passport,"dollars",1000000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
        -- ["Money5"] = {
        --     func = function(Passport,source)
        --         RP.GenerateItem(Passport,"dollars",10000000)
        --         return true
        --     end,    
        --     shared = false,
        -- },
    }
}
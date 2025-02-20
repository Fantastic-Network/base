-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Whitelisted = GetConvar("Whitelist", "false")
if Whitelisted == "true" then
    Whitelisted = true
else
    Whitelisted = false
end
SpawnCoords = vec3(-28.08,-145.96,56.99)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------
Maintenance = false
MaintenanceText = "Servidor reiniciando!"
MaintenanceLicenses = {
	["ce615964a7cee36cc5333f7eb44ea3a29905387d"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARENA (Itens recebidos ao entrar na arena)
-----------------------------------------------------------------------------------------------------------------------------------------
ArenaItens = {
    ["Pistol"] = {
        { ["WEAPON_COMBATPISTOL"] = 1 },
        { ["WEAPON_PISTOL_MK2"] = 1} ,
        { ["WEAPON_PISTOL_AMMO"] = 1000 }
    },
    ["DropKill"] = {
        { ["WEAPON_ASSAULTRIFLE_MK2"] = 1 },
        { ["WEAPON_SPECIALCARBINE_MK2"] = 1 },
        { ["WEAPON_PISTOL_MK2"] =  1 },
        { ["WEAPON_PISTOL_AMMO"] = 250 },
        { ["WEAPON_RIFLE_AMMO"] = 250 },
    },
    ["FFAPistola"] = {
        { ["WEAPON_PISTOL_MK2"] = 1 },
        { ["WEAPON_COMBATPISTOL"] = 1 },
        { ["WEAPON_PISTOL_AMMO"] = 500 }
    },
    ["Event_Pistol"] = {
        { ["WEAPON_PISTOL_MK2"] = 1 },
        { ["WEAPON_PISTOL_AMMO"] = 500 },
        { ["radio"] = 1 },
    },
    ["FFAFuzil"] = {
        { ["WEAPON_ASSAULTRIFLE_MK2 "] = 1 },
        { ["WEAPON_SPECIALCARBINE_MK2"] = 1 },
        { ["WEAPON_RIFLE_AMMO"] = 500 }
    },
    ["AimNPC"] = {
        { ["WEAPON_PISTOL_MK2"] = 1 },
        { ["WEAPON_PISTOL_AMMO"] = 1000 }
    },
    ["AimLabs"] = {
        { ["WEAPON_PISTOL_MK2"] = 1 },
        { ["WEAPON_PISTOL_AMMO"] = 1000 }
    },
    ["InvasaoFuzil"] = {
        { ["WEAPON_SPECIALCARBINE_MK2"] = 1 },
        { ["WEAPON_ASSAULTRIFLE_MK2 "] = 1 },
        { ["WEAPON_RIFLE_AMMO"] = 15000 },
        { ["cocaine"] = 20 },
        { ["bandage"] = 20 },
        { ["joint"] = 20 },
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERITENS (Itens recebidos ao criar o personagem)
-----------------------------------------------------------------------------------------------------------------------------------------
CharacterItens = {
    {"cellphone",1},
    {"dollars",25000},
    {"creator",2},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
GroupBlips = {
	["Policia"] = true,
	["Paramedic"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENTSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
ClientState = {
    ["Admin"] = true,
    ["Policia"] = true,
    ["Bombeiros"] = true,
    ["Mechanic"] = true,
    ["Paramedic"] = true,
    ["Barragem"] = true,
    ["Cartel"] = true,
    ["Sindicato"] = true,
    ["Vagos"] = true,
    ["Umbrella"] = true,
    ["Azuis"] = true,
    ["Vermelhos"] = true,
    ["Amarelos"] = true,
    ["AlcateiaHsT"] = true,
    ["Verdes"] = true,
    ["Roxos"] = true,
    ["LosAztecas"] = true,
    ["Laranjas"] = true,
    ["Brancos"] = true,
    ["Marrons"] = true,
    ["Cinzas"] = true,
    ["Rosas"] = true,
    ["Ballas"] = true,
    ["Bellagio"] = true,
    ["Bahamas"] = true,
    ["Palazzo"] = true,
    ["Luxor"] = true,
    ["Groove"] = true,
    ["TopGear"] = true,
    ["Redline"] = true,
    ["Bennys"] = true,
    ["DriftKing"] = true,
    ["Forza"] = true,
    ["Overdrive"] = true,
    ["Crips"] = true,
    ["Tropadu7"] = true,
    ["Outlaws"] = true,
    ["SonsofAnarchy"] = true,
    ["Sinaloa"] = true,
    ["HellsAngels"] = true,
    ["Triade"] = true,
    ["Yakuza"] = true,
    ["Warlocks"] = true,
    ["Bloods"] = true,
    ["Mercenarios"] = true,
    ["Bopegg"] = true,
    ["LaMafia"] = true,
    ["Gringa"] = true,
    ["Franca"] = true,
    ["Italia"] = true,
    ["Russia"] = true,
    ["Israel"] = true,
    ["Playboy"] = true,
    ["Mexico"] = true,
    ["China"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITIAL
-----------------------------------------------------------------------------------------------------------------------------------------
Initial = {
    [1] = {
        ["skinshop"] = {
            [0] = {
                ["pants"] = { item = 4, texture = 2 },
                ["arms"] = { item = 0, texture = 0 },
                ["tshirt"] = { item = 15, texture = 0 },
                ["torso"] = { item = 22, texture = 0 },
                ["vest"] = { item = 0, texture = 0 },
                ["shoes"] = { item = 14, texture = 7 },
                ["mask"] = { item = 0, texture = 0 },
                ["backpack"] = { item = 0, texture = 0 },
                ["hat"] = { item = -1, texture = 0 },
                ["glass"] = { item = 0, texture = 0 },
                ["ear"] = { item = -1, texture = 0 },
                ["watch"] = { item = -1, texture = 0 },
                ["bracelet"] = { item = -1, texture = 0 },
                ["accessory"] = { item = 0, texture = 0 },
                ["decals"] = { item = 0, texture = 0 }
            },
            [1] = {
                ["pants"] = { item = 0, texture = 8 },
                ["arms"] = { item = 14, texture = 0 },
                ["tshirt"] = { item = 15, texture = 0 },
                ["torso"] = { item = 23, texture = 0 },
                ["vest"] = { item = 0, texture = 0 },
                ["shoes"] = { item = 52, texture = 3 },
                ["mask"] = { item = 0, texture = 0 },
                ["backpack"] = { item = 0, texture = 0 },
                ["hat"] = { item = -1, texture = 0 },
                ["glass"] = { item = 0, texture = 0 },
                ["ear"] = { item = -1, texture = 0 },
                ["watch"] = { item = -1, texture = 0 },
                ["bracelet"] = { item = -1, texture = 0 },
                ["accessory"] = { item = 0, texture = 0 },
                ["decals"] = { item = 0, texture = 0 }
            }
        },
        ["barbershop"] = {
            [0] = { 0,0,0.65,2,12,0,-1,4,-1,45,29,29,0,0,0,0,0,0,30,0.99,0,1,0.88,0,-1,0,0,-1,0.84,0.72,0.46,0,0,0.3,-0.3,0,-0.58,-0.72,-0.52,0.21,0.37,0.79,0.6,0.71,0.43,-0.7,0 },
            [1] = { 0,6,0.5,9,0,6,6,7,-1,12,15,29,41,0.99,0,4,0.99,25,0,0.99,15,0,0,0,1,0.13,52,-0.32,0,-1,0,0.2,0,-0.1,-0.14,0,-0.04,0.04,0.02,0.48,0,-1,0,0,-0.08,-0.02,1 }
        }
    },
    [2] = {
        ["skinshop"] = {
            [0] = {
                ["pants"] = { item = 4, texture = 2 },
                ["arms"] = { item = 0, texture = 0 },
                ["tshirt"] = { item = 15, texture = 0 },
                ["torso"] = { item = 22, texture = 0 },
                ["vest"] = { item = 0, texture = 0 },
                ["shoes"] = { item = 14, texture = 7 },
                ["mask"] = { item = 0, texture = 0 },
                ["backpack"] = { item = 0, texture = 0 },
                ["hat"] = { item = -1, texture = 0 },
                ["glass"] = { item = 0, texture = 0 },
                ["ear"] = { item = -1, texture = 0 },
                ["watch"] = { item = -1, texture = 0 },
                ["bracelet"] = { item = -1, texture = 0 },
                ["accessory"] = { item = 0, texture = 0 },
                ["decals"] = { item = 0, texture = 0 }
            },
            [1] = {
                ["pants"] = { item = 0, texture = 8 },
                ["arms"] = { item = 14, texture = 0 },
                ["tshirt"] = { item = 15, texture = 0 },
                ["torso"] = { item = 23, texture = 0 },
                ["vest"] = { item = 0, texture = 0 },
                ["shoes"] = { item = 52, texture = 3 },
                ["mask"] = { item = 0, texture = 0 },
                ["backpack"] = { item = 0, texture = 0 },
                ["hat"] = { item = -1, texture = 0 },
                ["glass"] = { item = 0, texture = 0 },
                ["ear"] = { item = -1, texture = 0 },
                ["watch"] = { item = -1, texture = 0 },
                ["bracelet"] = { item = -1, texture = 0 },
                ["accessory"] = { item = 0, texture = 0 },
                ["decals"] = { item = 0, texture = 0 }
            }
        },
        ["barbershop"] = {
            [0] = { 0,8,0.5,0,3,0,-1,4,-1,73,0,0,0,0,0,0,0,0,30,0.99,0,1,0.88,0,-1,0,0,-1,0.84,0.72,0.46,0,0,0.3,-0.3,0,-0.58,-0.72,-0.52,0.21,0.37,0.79,0.6,0.71,0.43,-0.7 },
            [1] = { 0,0,1,8,2,0,-1,-1,-1,25,0,4,6,0.45,2,4,0.99,0,2,0.99,26,0,0,0,1,0.13,10,-0.32,0,-1,0,0.2,0,-0.1,-0.14,0,-0.04,0.04,0.02,0.48,0,-1,0,-0.38,-0.08,-0.02,1 }
        }
    },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICECLEANER
-----------------------------------------------------------------------------------------------------------------------------------------
PoliceCleaner = {
    ["WEAPON_PISTOL"] = true,
    ["WEAPON_PISTOL_MK2"] = true,
    ["WEAPON_COMPACTRIFLE"] = true,
    ["WEAPON_APPISTOL"] = true,
    ["WEAPON_HEAVYPISTOL"] = true,
    ["WEAPON_MACHINEPISTOL"] = true,
    ["WEAPON_MICROSMG"] = true,
    ["WEAPON_NAILGUN"] = true,
    ["WEAPON_MINISMG"] = true,
    ["WEAPON_SNSPISTOL"] = true,
    ["WEAPON_SNSPISTOL_MK2"] = true,
    ["WEAPON_VINTAGEPISTOL"] = true,
    ["WEAPON_PISTOL50"] = true,
    ["WEAPON_REVOLVER"] = true,
    ["WEAPON_COMBATPISTOL"] = true,
    ["WEAPON_PARAFAL"] = true,
    ["WEAPON_FNFAL"] = true,
    ["WEAPON_COLTXM177"] = true,
    ["WEAPON_CARBINERIFLE"] = true,
    ["WEAPON_CARBINERIFLE_MK2"] = true,
    ["WEAPON_ADVANCEDRIFLE"] = true,
    ["WEAPON_BULLPUPRIFLE"] = true,
    ["WEAPON_BULLPUPRIFLE_MK2"] = true,
    ["WEAPON_SPECIALCARBINE"] = true,
    ["WEAPON_TACTICALRIFLE"] = true,
    ["WEAPON_MILITARYRIFLE"] = true,
    ["WEAPON_COMBATMG_MK2"] = true,
    ["WEAPON_TECPISTOL"] = true,
    ["WEAPON_SNIPERRIFLE"] = true,
    ["WEAPON_SPECIALCARBINE_MK2"] = true,
    ["WEAPON_PUMPSHOTGUN"] = true,
    ["WEAPON_PUMPSHOTGUN_MK2"] = true,
    ["WEAPON_MUSKET"] = true,
    ["WEAPON_SAWNOFFSHOTGUN"] = true,
    ["WEAPON_SMG"] = true,
    ["WEAPON_SMG_MK2"] = true,
    ["WEAPON_ASSAULTRIFLE"] = true,
    ["WEAPON_ASSAULTRIFLE_MK2"] = true,
    ["WEAPON_ASSAULTSMG"] = true,
    ["WEAPON_GUSENBERG"] = true,
    ["WEAPON_STUNGUN"] = true,
    ["WEAPON_MOLOTOV"] = true,
    ["WEAPON_SMOKEGRENADE"] = true,
    ["WEAPON_HATCHET"] = true,
    ["WEAPON_KATANA"] = true,
    ["WEAPON_KARAMBIT"] = true,
    ["WEAPON_BATTLEAXE"] = true,
    ["WEAPON_MACHETE"] = true,
    ["WEAPON_STONE_HATCHET"] = true,
    ["WEAPON_KNUCKLE"] = true,
    ["WEAPON_NIGHTSTICK"] = true,
    ["WEAPON_PISTOL_AMMO"] = true,
    ["WEAPON_NAIL_AMMO"] = true,
    ["WEAPON_SMG_AMMO"] = true,
    ["WEAPON_RIFLE_AMMO"] = true,
    ["WEAPON_SHOTGUN_AMMO"] = true,
    ["WEAPON_MUSKET_AMMO"] = true,
    ["dinheirosujo"] = true,
    ["cocaine"] = true,
    ["joint"] = true,
    ["meth"] = true,
    ["lockpick"] = true,
    ["c4"] = true,
    ["hood"] = true,
    ["handcuff"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTCLEANGG
-----------------------------------------------------------------------------------------------------------------------------------------
NotCleanGG = {
    ["premium01"] = true,
    ["premium02"] = true,
    ["premium03"] = true,
    ["premium04"] = true,
    ["premium05"] = true,
    ["vipsorteio"] = true,
    ["kitfogueteiro"] = true,
    ["kitcriminal"] = true,
    ["kitmafioso"] = true,
    ["kitdosraul"] = true,
    ["kitboqueta"] = true,
	["gemstone"] = true,
    ["premiumplate"] = true,
    ["phonechange"] = true,
    ["newchars"] = true,
    ["creator"] = true,
    ["namechange"] = true,
    ["creditcard"] = true,
    ["vehkey"] = true,
    ["propertys"] = true,
	["money1"] = true,
	["money2"] = true,
	["money3"] = true,
	["money4"] = true,
	["money5"] = true,
	["packbasic"] = true,
	["packelite"] = true,
	["packpremium"] = true,
    ["weedleaf"] = true,
    ["silk"] = true,
    ["cokeleaf"] = true,
    ["sulfuric"] = true,
    ["saline"] = true,
    ["acetone"] = true,
    ["aguadestilada"] = true,
    ["cloro"] = true,
    ["capsula"] = true,
    ["polvora"] = true,
    ["weaponbody"] = true,
    ["molas"] = true,
    ["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANTE
-----------------------------------------------------------------------------------------------------------------------------------------
InicianteItems = {
    ["WEAPON_PISTOL"] = true,
    ["WEAPON_PISTOL_MK2"] = true,
    ["WEAPON_COMPACTRIFLE"] = true,
    ["WEAPON_APPISTOL"] = true,
    ["WEAPON_HEAVYPISTOL"] = true,
    ["WEAPON_MACHINEPISTOL"] = true,
    ["WEAPON_MICROSMG"] = true,
    ["WEAPON_NAILGUN"] = true,
    ["WEAPON_MINISMG"] = true,
    ["WEAPON_SNSPISTOL"] = true,
    ["WEAPON_SNSPISTOL_MK2"] = true,
    ["WEAPON_VINTAGEPISTOL"] = true,
    ["WEAPON_PISTOL50"] = true,
    ["WEAPON_REVOLVER"] = true,
    ["WEAPON_COMBATPISTOL"] = true,
    ["WEAPON_PARAFAL"] = true,
    ["WEAPON_FNFAL"] = true,
    ["WEAPON_COLTXM177"] = true,
    ["WEAPON_CARBINERIFLE"] = true,
    ["WEAPON_CARBINERIFLE_MK2"] = true,
    ["WEAPON_ADVANCEDRIFLE"] = true,
    ["WEAPON_BULLPUPRIFLE"] = true,
    ["WEAPON_BULLPUPRIFLE_MK2"] = true,
    ["WEAPON_SPECIALCARBINE"] = true,
    ["WEAPON_SPECIALCARBINE_MK2"] = true,
    ["WEAPON_PUMPSHOTGUN"] = true,
    ["WEAPON_PUMPSHOTGUN_MK2"] = true,
    ["WEAPON_MUSKET"] = true,
    ["WEAPON_SAWNOFFSHOTGUN"] = true,
    ["WEAPON_SMG"] = true,
    ["WEAPON_SMG_MK2"] = true,
    ["WEAPON_ASSAULTRIFLE"] = true,
    ["WEAPON_ASSAULTRIFLE_MK2"] = true,
    ["WEAPON_ASSAULTSMG"] = true,
    ["WEAPON_GUSENBERG"] = true,
    ["WEAPON_STUNGUN"] = true,
    ["WEAPON_MOLOTOV"] = true,
    ["WEAPON_SMOKEGRENADE"] = true,
    ["WEAPON_HATCHET"] = true,
    ["WEAPON_KATANA"] = true,
    ["WEAPON_KARAMBIT"] = true,
    ["WEAPON_BATTLEAXE"] = true,
    ["WEAPON_MACHETE"] = true,
    ["WEAPON_STONE_HATCHET"] = true,
    ["WEAPON_KNUCKLE"] = true,
    ["WEAPON_NIGHTSTICK"] = true,
    ["WEAPON_PISTOL_AMMO"] = true,
    ["WEAPON_NAIL_AMMO"] = true,
    ["WEAPON_SMG_AMMO"] = true,
    ["WEAPON_RIFLE_AMMO"] = true,
    ["WEAPON_SHOTGUN_AMMO"] = true,
    ["WEAPON_MUSKET_AMMO"] = true,
    ["dinheirosujo"] = true,
    ["cocaine"] = true,
    ["joint"] = true,
    ["meth"] = true,
    ["lockpick"] = true,
    ["c4"] = true,
    ["hood"] = true,
    ["handcuff"] = true
}

StoreLink = {
    ["Base"] = "SEU LINK AQUI",
}

Logos = {
	["Base"] = "SEU LINK AQUI",

}

DiscordConv = {
	["Base"] = "SEU LINK AQUI",
}

function GetLogo(City)
    return Logos[City]
end

function GetDiscordConv(City)
    return DiscordConv[City]
end
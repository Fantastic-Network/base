-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {}
cityName = GetConvar("cityName","Base")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
PremiumItems = {
    "premium01",
    "premium02",
    "premium03",
    "premium04",
    "premium05",
    "vipsorteio",
    "kitfogueteiro",
    "kitcriminal",
    "kitmafioso",
    "kitdosraul",
    "kitboqueta",
	"gemstone",
    "premiumplate",
    "phonechange",
    "money1",
    "money2",
    "money3",
    "money4",
    "money5",
    "packbasic",
    "packelite",
    "packpremium",
    "rolepass",
	"megaphone",
	"namechange",
	"creator",
    "newchars",
	"WEAPON_GRENADELAUNCHER",
    "WEAPON_HOMINGLAUNCHER",
    "WEAPON_RAILGUN",
    "WEAPON_RPG",
    "WEAPON_RPG_AMMO",
    "WEAPON_RAYPISTOL",
    "WEAPON_RAYCARBINE",
    "WEAPON_RAYMINIGUN",
	
}

BlackList = {
	-- ["WEAPON_COMBATPISTOL"] = true,
	-- ["WEAPON_CARBINERIFLE"] = true,
	-- ["WEAPON_CARBINERIFLE_MK2"] = true,
    -- ["WEAPON_SPECIALCARBINE"] = true,
    -- ["WEAPON_SPECIALCARBINE_MK2"] = true,
    -- ["WEAPON_PUMPSHOTGUN"] = true,
	-- ["WEAPON_SMG"] = true,
	["WEAPON_NIGHTSTICK"] = true,
	["WEAPON_GRENADELAUNCHER"] = true,
    ["WEAPON_HOMINGLAUNCHER"] = true,
    ["WEAPON_RAILGUN"] = true,
    ["WEAPON_RPG"] = true,
    ["WEAPON_RPG_AMMO"] = true,
    ["WEAPON_RAYPISTOL"] = true,
    ["WEAPON_RAYCARBINE"] = true,
    ["WEAPON_RAYMINIGUN"] = true,
}

function IsBlackListed(Item)
    if BlackList[Item] then
        return true
    else
        return false
    end
end

function IsPremiumItem(Item)
    local isPremium = false
    for i=1,#PremiumItems do
        if PremiumItems[i] == Item then
            isPremium = true
        end
    end
    return isPremium
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
List = {
    ["advrem"] = {
        ["Index"] = "advrem",
        ["Name"] = "Remover ADV",
        ["Description"] = "Item adquirido na loja, para remoção de advertência",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["WEAPON_RPG_AMMO"] = {
        ["Index"] = "MRPG",
        ["Name"] = "M. RPG",
        ["Description"] = "Munição utilizada para o armamento",
        ["Type"] = "Munição",
        ["Weight"] = 0.001,
        ["Class"] = "Armas",
        ["Economy"] = 30
    },
    ["WEAPON_GRENADELAUNCHER"] = {
        ["Index"] = "RPG",
        ["Name"] = "RPG",
        ["Description"] = "Armamento de RPG",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RPG_AMMO",
        ["Weight"] = 3.75,
        ["Class"] = "Armas",
        ["Economy"] = 775
    },
    ["WEAPON_HOMINGLAUNCHER"] = {
        ["Index"] = "RPG",
        ["Name"] = "RPG",
        ["Description"] = "Armamento de RPG",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RPG_AMMO",
        ["Weight"] = 3.75,
        ["Class"] = "Armas",
        ["Economy"] = 775
    },
    ["WEAPON_RAILGUN"] = {
        ["Index"] = "RPG",
        ["Name"] = "RPG",
        ["Description"] = "Armamento de RPG",
        ["Description"] = "Munição utilizada para o armamento",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RPG_AMMO",
        ["Weight"] = 3.75,
        ["Class"] = "Armas",
        ["Economy"] = 775
    },
    ["WEAPON_RPG"] = {
        ["Index"] = "RPG",
        ["Name"] = "RPG",
        ["Description"] = "Armamento de RPG",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RPG_AMMO",
        ["Weight"] = 3.75,
        ["Class"] = "Armas",
        ["Economy"] = 775
    },
    ["WEAPON_RAYPISTOL"] = {
        ["Index"] = "Ray Pistol",
        ["Description"] = "Armamento de RPG",
        ["Name"] = "RPG",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RPG_AMMO",
        ["Weight"] = 3.75,
        ["Class"] = "Armas",
        ["Economy"] = 775
    },
    ["WEAPON_RAYCARBINE"] = {
        ["Index"] = "Ray Carbine",
        ["Name"] = "RPG",
        ["Description"] = "Armamento de RPG",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RPG_AMMO",
        ["Weight"] = 3.75,
        ["Class"] = "Armas",
        ["Economy"] = 775
    },
    ["WEAPON_RAYMINIGUN"] = {
        ["Index"] = "Ray MiniguN",
        ["Name"] = "Ray MiniguN",
        ["Description"] = "Armamento de RPG",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RPG_AMMO",
        ["Weight"] = 3.75,
        ["Class"] = "Armas",
        ["Economy"] = 775
    },
    ["packbasic"] = {
        ["Index"] = "packbasic",
        ["Name"] = "Pack de Armas - Basic",
        ["Description"] = "Pacote básico de armamento, adquirido em nossa loja",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["packelite"] = {
        ["Index"] = "packelite",
        ["Name"] = "Pack de Armas - Elite",
        ["Description"] = "Pacote elite de armamento, adquirido em nossa loja",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["packpremium"] = {
        ["Index"] = "packpremium",
        ["Name"] = "Pack de Armas - Premium",
        ["Description"] = "Pacote premium de armamento, adquirido em nossa loja",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["prisaorem"] = {
        ["Index"] = "prisaorem",
        ["Name"] = "Remover Prisao",
        ["Description"] = "Item adquirido em nossa loja para remoção de prisão",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["money1"] = {
        ["Index"] = "money1",
        ["Name"] = "50 milhões de Dollars",
        ["Description"] = "Item adquirido em nossa loja para obter 50 milhões de dolares em sua contra bancária",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["money2"] = {
        ["Index"] = "money2",
        ["Name"] = "25 milhões de Dollars",
        ["Description"] = "Item adquirido em nossa loja para obter 25 milhões de dolares em sua contra bancária",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["money3"] = {
        ["Index"] = "money3",
        ["Name"] = "10 milhões de Dollars",
        ["Description"] = "Item adquirido em nossa loja para obter 10 milhões de dolares em sua contra bancária",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["money4"] = {
        ["Index"] = "money4",
        ["Name"] = "1 milhão de Dollars",
        ["Description"] = "Item adquirido em nossa loja para obter 1 milhão de dolares em sua contra bancária",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["money5"] = {
        ["Index"] = "money5",
        ["Name"] = "10 milhões de Dollars",
        ["Description"] = "Item adquirido em nossa loja para obter 10 milhões de dolares em sua contra bancária",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 2250
    },
    ["adrenaline"] = {
        ["Index"] = "adrenaline",
        ["Name"] = "Adrenalina",
        ["Description"] = "Item para reanimar player morto",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 200000
    },
    ["bolsadesangue"] = {
        ["Index"] = "bolsadesangue",
        ["Name"] = "Bolsa de Sangue",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 200000
    },
    ["creator"] = {
        ["Index"] = "creator",
        ["Name"] = "Criação de Personagem",
        ["Description"] = "Item adquirido com diamantes ou spawn para reset para troca de aparência física",
        ["Type"] = "Usável",
        ["Weight"] = 15.0,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 0
    },
    ["changesexf"] = {
        ["Index"] = "changesexf",
        ["Name"] = "Criação de Personagem",
        ["Description"] = "Item adquirido com diamantes ou spawn para reset para troca de sexo",
        ["Type"] = "Usável",
        ["Weight"] = 15.0,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 0
    },
    ["changesexm"] = {
        ["Index"] = "changesexm",
        ["Name"] = "Criação de Personagem",
        ["Description"] = "Item adquirido com diamantes ou spawn para reset para troca de sexo",
        ["Type"] = "Usável",
        ["Weight"] = 15.0,
        ["Block"] = true,
        ["Class"] = "Premium",
        ["Economy"] = 0
    },
    ["album"] = {
        ["Index"] = "album",
        ["Name"] = "Álbum da Copa",
        ["Description"] = "Álbum de copa, para colecionar figurinhas",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["aboboradoce"] = {
        ["Index"] = "aboboradoce",
        ["Name"] = "Aboboradoce",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["balinhas"] = {
        ["Index"] = "balinhas",
        ["Name"] = "Balinhas",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["chiclete"] = {
        ["Index"] = "chiclete",
        ["Name"] = "Chiclete",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["docefantasma"] = {
        ["Index"] = "docefantasma",
        ["Name"] = "Doce Fantasma",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["milhodoce"] = {
        ["Index"] = "milhodoce",
        ["Name"] = "Milho doce",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["minhocadoce"] = {
        ["Index"] = "minhocadoce",
        ["Name"] = "Minhoca Doce",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["lixo"] = {
        ["Index"] = "lixo",
        ["Name"] = "Lixo",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["esqueleto"] = {
        ["Index"] = "esqueleto",
        ["Name"] = "Esqueleto",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["rainha"] = {
        ["Index"] = "rainha",
        ["Name"] = "Rainha",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["mulherfrank"] = {
        ["Index"] = "mulherfrank",
        ["Name"] = "Mulher Frank",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["et"] = {
        ["Index"] = "et",
        ["Name"] = "ET",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["troll"] = {
        ["Index"] = "troll",
        ["Name"] = "Troll",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["skate"] = {
        ["Index"] = "skate",
        ["Name"] = "Skate",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["frankenstein"] = {
        ["Index"] = "frankenstein",
        ["Name"] = "Frankenstein",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["heman"] = {
        ["Index"] = "heman",
        ["Name"] = "Heman",
        ["Type"] = "Usável",
        ["Weight"] = 2.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["alvejante"] = {
        ["Index"] = "alvejante",
        ["Name"] = "Alvejante",
        ["Description"] = "Item de farm, para limpar dinheiro sujo",
        ["Type"] = "Comum",
        ["Weight"] = 0.0,
        ["Class"] = "Drogas",
        ["Economy"] = 0
    },
    ["ferro"] = {
        ["Index"] = "ferro",
        ["Name"] = "Ferro",
        ["Description"] = "Barra de ferro, sem utilitário",
        ["Type"] = "Comum",
        ["Weight"] = 0.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["capsula"] = {
        ["Index"] = "capsula",
        ["Name"] = "Capsula",
        ["Description"] = "Item de farm para produção de munição",
        ["Type"] = "Comum",
        ["Weight"] = 0.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["valecasa"] = {
        ["Index"] = "valecasa",
        ["Name"] = "Vale Casa",
        ["Description"] = "Item para adquirir uma residência simples",
        ["Type"] = "Comum",
        ["Weight"] = 0.0,
        ["Class"] = "Premium",
        ["Economy"] = 0
    },
    ["valemansao"] = {
        ["Index"] = "valemansao",
        ["Name"] = "Vale Mansão",
        ["Description"] = "Item para adquirir uma mansão",
        ["Type"] = "Comum",
        ["Weight"] = 0.0,
        ["Class"] = "Premium",
        ["Economy"] = 0
    },
    ["creditcard"] = {
        ["Index"] = "creditcard",
        ["Name"] = "Cartão de Crédito",
        ["Description"] = "Item para utilizar em compras nos blips de pagamento",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["diagram"] = {
        ["Index"] = "diagram",
        ["Name"] = "Diagrama",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["propertys"] = {
        ["Index"] = "propertys",
        ["Name"] = "Cartão de Segurança",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["megaphone"] = {
        ["Index"] = "megaphone",
        ["Name"] = "Megafone",
        ["Description"] = "Item adquirido na loja para mandar mensagem no chat em geral",
        ["Type"] = "Usável",
        ["Durability"] = 15,
        ["Block"] = true,
        ["Weight"] = 0.01,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["sprays01"] = {
        ["Index"] = "sprays",
        ["Name"] = "Spray",
        ["Description"] = "Spray de tinta, item sem função",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["dismantle"] = {
        ["Index"] = "dismantle",
        ["Name"] = "Contrato",
        ["Description"] = "Ativando o mesmo você assume a responsabilidade com o <b>Lester</b> de desmanchar um veículo.",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 125,
        ["Max"] = 1
    },
    ["repairkit01"] = {
        ["Index"] = "repairkit01",
        ["Name"] = "Kit de Reparos - Comum",
        ["Description"] = "Kit reparo para veiculo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 550
    },
    ["repairkit02"] = {
        ["Index"] = "repairkit02",
        ["Name"] = "Kit de Reparos - Raro",
        ["Description"] = "Kit reparo para veiculo",
        ["Type"] = "Comum",
        ["Weight"] = 3.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 3250
    },
    ["repairkit03"] = {
        ["Index"] = "repairkit03",
        ["Name"] = "Kit de Reparos - Épico",
        ["Description"] = "Kit reparo para veiculo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 7250
    },
    ["repairkit04"] = {
        ["Index"] = "repairkit04",
        ["Name"] = "Kit de Reparos - Lendário",
        ["Description"] = "Kit reparo para veiculo",
        ["Type"] = "Comum",
        ["Weight"] = 1.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 16000
    },
    ["backschool"] = {
        ["Index"] = "backschool",
        ["Name"] = "Mochila de Escola",
        ["Description"] = "Mochila escolar, sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100000
    },
    ["backcyclist"] = {
        ["Index"] = "backcyclist",
        ["Name"] = "Mochila de Ciclista",
        ["Description"] = "Mochila de Ciclista, sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100000
    },
    ["backcamping"] = {
        ["Index"] = "backcamping",
        ["Name"] = "Mochila de Acampamento",
        ["Description"] = "Mochila de Acampamento, sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100000
    },
    ["backalohomorawhite"] = {
        ["Index"] = "backalohomorawhite",
        ["Name"] = "Mochila Alohomora Branca",
        ["Description"] = "Mochila Alohomora Branca, sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 150000
    },
    ["backalohomorablack"] = {
        ["Index"] = "backalohomorablack",
        ["Name"] = "Mochila Alohomora Preta",
        ["Description"] = "Mochila Alohomora Preta, sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 150000
    },
    ["backalohomorared"] = {
        ["Index"] = "backalohomorared",
        ["Name"] = "Mochila Alohomora Vermelha",
        ["Description"] = "Mochila Alohomora Vermelha, sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 150000
    },
    ["backrudolphpurple"] = {
        ["Index"] = "backrudolphpurple",
        ["Name"] = "Mochila Rudolph Roxo",
        ["Description"] = "Mochila Rudolph Roxo, sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 150000
    },
    ["backrudolphred"] = {
        ["Index"] = "backrudolphred",
        ["Name"] = "Mochila Rudolph Vermelho",
        ["Description"] = "Mochila Rudolph Vermelho, sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 150000
    },
    ["paper"] = {
        ["Index"] = "paper",
        ["Name"] = "Papel",
        ["Description"] = "Papel, sem função especifica",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 120
    },
    ["rentalveh"] = {
        ["Index"] = "rentalveh",
        ["Name"] = "Aluguel de Veículo",
        ["Description"] = "Leve até a concessionária para usa-lo.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Economy"] = 0
    },
    ["paramedicpass"] = {
        ["Index"] = "medicbag",
        ["Name"] = "Vale - Médico",
        ["Description"] = "Leve até um médico para troca-lo.",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["luckywheelpass"] = {
        ["Index"] = "luckywheelpass",
        ["Name"] = "Vale - Roda da Fortuna",
        ["Description"] = "Leve até o cassino para usa-lo.",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 5000
    },
    ["mechanicpass"] = {
        ["Index"] = "mechanicpass",
        ["Name"] = "Vale - Mecânico",
        ["Description"] = "Leve até um mecânico para troca-lo.",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["uwucoffeepass"] = {
        ["Index"] = "foodpass",
        ["Name"] = "Vale - Uwu Café",
        ["Description"] = "Leve até o restaurante para troca-lo.",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["pizzathispass"] = {
        ["Index"] = "foodpass",
        ["Name"] = "Vale - Pizza This",
        ["Description"] = "Leve até o restaurante para troca-lo.",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["burgershotpass"] = {
        ["Index"] = "foodpass",
        ["Name"] = "Vale - BurgerShot",
        ["Description"] = "Leve até o restaurante para troca-lo.",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["c4"] = {
        ["Index"] = "c4",
        ["Name"] = "C4",
        ["Description"] = "C4, Bomba para roubar banco central",
        ["Type"] = "Usável",
        ["Weight"] = 1.75,
        ["Max"] = 10,
        ["Class"] = "Utilitarios",
        ["Economy"] = 625
    },
    ["geode"] = {
        ["Index"] = "geode",
        ["Name"] = "Geodo",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10
    },
    ["pickaxe"] = {
        ["Index"] = "pickaxe",
        ["Name"] = "Picareta",
        ["Description"] = "Picareta, arma branca",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Durability"] = 15,
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 525
    },
    ["suitcase"] = {
        ["Index"] = "suitcase",
        ["Name"] = "Maleta",
        ["Description"] = "Maleta, item sem função especifica",
        ["Type"] = "Usável",
        ["Weight"] = 1.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 275
    },
    ["badge01"] = {
        ["Index"] = "badge01",
        ["Name"] = "Distintivo",
        ["Description"] = "Policia Do Estado Do Rio De Janeiro",
        ["Type"] = "Usável",
        ["Block"] = true,
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10
    },
    ["badge02"] = {
        ["Index"] = "badge02",
        ["Name"] = "Distintivo",
        ["Description"] = "Hospital - UPA",
        ["Type"] = "Usável",
        ["Block"] = true,
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10
    },
    ["nigirizushi"] = {
        ["Index"] = "nigirizushi",
        ["Name"] = "Nigirizushi",
        ["Description"] = "Sushi, alimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.65,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 75
    },
    ["sushi"] = {
        ["Index"] = "sushi",
        ["Name"] = "Sushi",
        ["Description"] = "Sushi, alimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.65,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 75
    },
    ["cupcake"] = {
        ["Index"] = "cupcake",
        ["Name"] = "Cupcake",
        ["Description"] = "Cupcake, alimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 75
    },
    ["milkshake"] = {
        ["Index"] = "milkshake",
        ["Name"] = "Milk Shake",
        ["Description"] = "Milk Shake, alimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.8555,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 125
    },
    ["cappuccino"] = {
        ["Index"] = "cappuccino",
        ["Name"] = "Cappuccino",
        ["Description"] = "Cappuccino, café, alimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.65,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 150
    },
    ["applelove"] = {
        ["Index"] = "applelove",
        ["Name"] = "Maça do Amor",
        ["Description"] = "Maça do Amor, alimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 75
    },
    ["credential"] = {
        ["Index"] = "credential",
        ["Name"] = "Credencial",
        ["Description"] = "Credencial, para identificação, sem utilidade",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1000
    },
    ["racetrophy"] = {
        ["Index"] = "racetrophy",
        ["Name"] = "Troféu",
        ["Description"] = "Trofeu, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 2250
    },
    ["scanner"] = {
        ["Index"] = "scanner",
        ["Name"] = "Scanner",
        ["Description"] = "Scanner, item sem função",
        ["Repair"] = "repairkit02",
        ["Type"] = "Usável",
        ["Weight"] = 4.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 6750
    },
    -- ["postit"] = {
    -- 	["Index"] = "postit",
        -- ["Description"] = "Postit, item sem função",
    -- 	["Name"] = "Post-It",
    -- 	["Type"] = "Usável",
    -- 	["Weight"] = 0.25,
    -- 	["Economy"] = 20
    -- },
    ["attachsFlashlight"] = {
        ["Index"] = "attachsFlashlight",
        ["Description"] = "Lanterna tatica, item para melhoria do armamento",
        ["Name"] = "Lanterna Tatica",
        ["Type"] = "Usável",
        ["Weight"] = 1.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1750
    },
    ["attachsCrosshair"] = {
        ["Index"] = "attachsCrosshair",
        ["Name"] = "Mira Holográfica",
        ["Description"] = "Mira holográfica, item para melhoria do armamento",
        ["Type"] = "Usável",
        ["Weight"] = 1.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1750
    },
    ["attachsSilencer"] = {
        ["Index"] = "attachsSilencer",
        ["Name"] = "Silenciador",
        ["Description"] = "Silenciador, item para melhoria do armamento",
        ["Type"] = "Usável",
        ["Weight"] = 1.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1750
    },
    ["attachsMagazine"] = {
        ["Index"] = "attachsMagazine",
        ["Name"] = "Pente Estendido",
        ["Description"] = "Pente estendido, quantidade maior de munição para melhoria do armamento",
        ["Type"] = "Usável",
        ["Weight"] = 1.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1750
    },
    ["attachsGrip"] = {
        ["Index"] = "attachsGrip",
        ["Name"] = "Empunhadura",
        ["Description"] = "Empunhadura, item para melhoria do armamento",
        ["Type"] = "Usável",
        ["Weight"] = 1.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1750
    },
    ["cheese"] = {
        ["Index"] = "cheese",
        ["Name"] = "Queijo",
        ["Description"] = "Queijo, alimennto",
        ["Type"] = "Comum",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["silk"] = {
        ["Index"] = "silk",
        ["Name"] = "Seda",
        ["Description"] = "Seda, farm para produção de maconha",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 5
    },
    ["tablecoke"] = {
        ["Index"] = "tablecoke",
        ["Name"] = "Mesa de Criação",
        ["Description"] = "Utilizada para criação de Cocaína.",
        ["Repair"] = "repairkit02",
        ["Type"] = "Usável",
        ["Weight"] = 12.75,
        ["Class"] = "Drogas",
        ["Economy"] = 1750
    },
    ["tablemeth"] = {
        ["Index"] = "tablemeth",
        ["Name"] = "Mesa de Criação",
        ["Description"] = "Utilizada para criação de Metanfetamina.",
        ["Repair"] = "repairkit02",
        ["Type"] = "Usável",
        ["Weight"] = 12.75,
        ["Class"] = "Drogas",
        ["Economy"] = 1750
    },
    ["tableweed"] = {
        ["Index"] = "tableweed",
        ["Name"] = "Mesa de Criação",
        ["Description"] = "Utilizada para criação de Baseados.",
        ["Repair"] = "repairkit02",
        ["Type"] = "Usável",
        ["Weight"] = 12.75,
        ["Class"] = "Drogas",
        ["Economy"] = 1750
    },
    ["campfire"] = {
        ["Index"] = "campfire",
        ["Name"] = "Fogueira",
        ["Description"] = "Fogueira, item sem função",
        ["Type"] = "Usável",
        ["Weight"] = 1.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 675
    },
    ["barrier"] = {
        ["Index"] = "barrier",
        ["Name"] = "Barreira",
        ["Description"] = "Barreira, item sem função",
        ["Type"] = "Usável",
        ["Weight"] = 1.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 250
    },
    ["medicbag"] = {
        ["Index"] = "medicbag",
        ["Name"] = "Bolsa Médica",
        ["Description"] = "Bolsa médica, item sem função", 
        ["Type"] = "Usável",
        ["Weight"] = 1.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 425
    },
    ["medicbed"] = {
        ["Index"] = "medicbed",
        ["Name"] = "Maca Médica",
        ["Description"] = "Maca médica, item para colocar o paciente a locomoção ou atendimento",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 725
    },
    ["techtrash"] = {
        ["Index"] = "techtrash",
        ["Name"] = "Lixo Eletrônico",
        ["Description"] = "Lixo para descarte, sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 125
    },
    ["tarp"] = {
        ["Index"] = "tarp",
        ["Name"] = "Lona",
        ["Description"] = "Lona, sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.65,
        ["Class"] = "Utilitarios",
        ["Economy"] = 50
    },
    ["sheetmetal"] = {
        ["Index"] = "sheetmetal",
        ["Name"] = "Chapa de Metal",
        ["Description"] = "Chapa de Metal, sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 50
    },
    ["roadsigns"] = {
        ["Index"] = "roadsigns",
        ["Name"] = "Placas de Trânsito",
        ["Description"] = "Placas de trânsito, sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.65,
        ["Class"] = "Utilitarios",
        ["Economy"] = 50
    },
    ["leather"] = {
        ["Index"] = "leather",
        ["Name"] = "Couro",
        ["Description"] = "Couro, sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 20
    },
    ["explosives"] = {
        ["Index"] = "explosives",
        ["Name"] = "Explosivos",
        ["Description"] = "",
        ["Type"] = "Comum",
        ["Weight"] = 0.55,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["fidentity"] = {
        ["Index"] = "identity",
        ["Name"] = "Passaporte",
        ["Description"] = "Passaporte para identificação",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10000
    },
    ["identity"] = {
        ["Index"] = "identity",
        ["Name"] = "Passaporte",
        ["Description"] = "Passaporte para identificação",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 5000
    },
    ["blocksignal"] = {
        ["Index"] = "blocksignal",
        ["Name"] = "Bloqueador de Sinal",
        ["Description"] = "Bloqueador de Sinal, sem função",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 325
    },
    ["pistolbody"] = {
        ["Index"] = "pistolbody",
        ["Name"] = "Corpo de Pistola",
        ["Description"] = "Corpo de Pistola, farma para criação de armamento",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Armas",
        ["Economy"] = 425
    },
    ["smgbody"] = {
        ["Index"] = "smgbody",
        ["Name"] = "Corpo de Sub-Metralhadora",
        ["Description"] = "Corpo de Sub-Metralhadora, farm para criação de armamento",
        ["Type"] = "Comum",
        ["Weight"] = 0.85,
        ["Class"] = "Armas",
        ["Economy"] = 525
    },
    ["dinheirosujo"] = {
        ["Index"] = "dinheirosujo",
        ["Name"] = "Dinheiro Sujo",
        ["Description"] = "Dinheiro sujo, feito em algo ilegal, por ex: desmanche de carro",
        ["Type"] = "Comum",
        ["Weight"] = 0.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1
    },
    ["keycard"] = {
        ["Index"] = "keycard",
        ["Name"] = "Keycard",
        ["Type"] = "Comum",
        ["Weight"] = 0.95,
        ["Class"] = "Utilitarios",
        ["Economy"] = 625
    },
    ["aguadestilada"] = {
        ["Index"] = "aguadestilada",
        ["Name"] = "Agua Destilada",
        ["Description"] = "Agua destilada, item de farm para criação de meta",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 625
    },
    ["cloro"] = {
        ["Index"] = "cloro",
        ["Name"] = "Cloro",
        ["Description"] = "Cloro, item de farm para criação de meta",
        ["Type"] = "Comum",
        ["Weight"] = 0.0,
        ["Class"] = "Drogas",
        ["Economy"] = 625
    },
    ["weaponbody"] = {
        ["Index"] = "weaponbody",
        ["Name"] = "Peça de Arma",
        ["Description"] = "Peça de Arma, item de farm para criação para armamento",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Armas",
        ["Economy"] = 625
    },
    ["alvejantepequeno"] = {
        ["Index"] = "alvejantepequeno",
        ["Name"] = "Alvejante Pequeno ",
        ["Description"] = "Alvejante Pequeno, item de farm para lavar dinheiro sujo",
        ["Type"] = "Comum",
        ["Weight"] = 0.95,
        ["Class"] = "Drogas",
        ["Economy"] = 625
    },
    ["alvejantemedio"] = {
        ["Index"] = "alvejantemedio",
        ["Name"] = "Alvejante Medio",
        ["Description"] = "Alvejante Médio, item de farm para lavar dinheiro sujo",
        ["Type"] = "Comum",
        ["Weight"] = 0.95,
        ["Class"] = "Drogas",
        ["Economy"] = 625
    },
    ["alvejantegrande"] = {
        ["Index"] = "alvejantegrande",
        ["Name"] = "Alvejante Grande",
        ["Description"] = "Alvejante Grande, item de farm para lavar dinheiro sujo",
        ["Type"] = "Comum",
        ["Weight"] = 0.95,
        ["Class"] = "Drogas",
        ["Economy"] = 625
    },
    ["molas"] = {
        ["Index"] = "molas",
        ["Name"] = "Molas",
        ["Description"] = "Molas, item de farm para criação de armamento",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Armas",
        ["Economy"] = 0
    },
    ["capsula"] = {
        ["Index"] = "capsula",
        ["Name"] = "Capsula",
        ["Description"] = "Item de farm para criação de munição",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Armas",
        ["Economy"] = 0
    },
    ["polvora"] = {
        ["Index"] = "polvora",
        ["Name"] = "Polvora",
        ["Description"] = "Item de farm para criação de munição",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Armas",
        ["Economy"] = 625
    },
    ["cotton"] = {
        ["Index"] = "cotton",
        ["Name"] = "Algodão",
        ["Description"] = "Algodão, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 45
    },
    ["plaster"] = {
        ["Index"] = "plaster",
        ["Name"] = "Esparadrapo",
        ["Description"] = "Esparadrapo, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.45,
        ["Class"] = "Utilitarios",
        ["Economy"] = 35
    },
    ["sulfuric"] = {
        ["Index"] = "sulfuric",
        ["Name"] = "Ácido Sulfúrico",
        ["Description"] = "Ácido Sulfúrico, item de farm para cocaina",
        ["Type"] = "Usável",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 30
    },
    ["saline"] = {
        ["Index"] = "saline",
        ["Name"] = "Soro Fisiológico",
        ["Description"] = "Soro Fisiológico, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 25
    },
    ["alcohol"] = {
        ["Index"] = "alcohol",
        ["Name"] = "Álcool",
        ["Description"] = "Álcool, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.65,
        ["Class"] = "Drogas",
        ["Economy"] = 40
    },
    ["notebook"] = {
        ["Index"] = "notebook",
        ["Name"] = "Notebook",
        ["Description"] = "Notbook, serve para melhoria em alguns aspctos do veiculo",
        ["Repair"] = "repairkit02",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 4250
    },
    ["syringe"] = {
        ["Index"] = "syringe",
        ["Name"] = "Seringa",
        ["Description"] = "Seringa, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 2
    },
    ["syringe01"] = {
        ["Index"] = "syringe2",
        ["Name"] = "Seringa A+",
        ["Description"] = "Seringa A+, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10
    },
    ["syringe02"] = {
        ["Index"] = "syringe2",
        ["Name"] = "Seringa B+",
        ["Description"] = "Seringa B+, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10
    },
    ["syringe03"] = {
        ["Index"] = "syringe2",
        ["Name"] = "Seringa A-",
        ["Description"] = "Seringa A-, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10
    },
    ["syringe04"] = {
        ["Index"] = "syringe2",
        ["Name"] = "Seringa B-",
        ["Description"] = "Seringa B-, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10
    },
    ["burgershot1"] = {
        ["Index"] = "burgershot1",
        ["Name"] = "Copo de Suco",
        ["Description"] = "Copo de suco, alimento",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 1,
        ["Economy"] = 10
    },
    ["burgershot2"] = {
        ["Index"] = "burgershot2",
        ["Name"] = "Caixa de Lanche",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 1,
        ["Economy"] = 10
    },
    ["burgershot3"] = {
        ["Index"] = "burgershot3",
        ["Name"] = "Combo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 120
    },
    ["burgershot4"] = {
        ["Index"] = "burgershot3",
        ["Name"] = "Combo + Brinquedo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 270
    },
    ["pizzathis1"] = {
        ["Index"] = "pizzathis1",
        ["Name"] = "Copo de Suco",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 1,
        ["Economy"] = 10
    },
    ["pizzathis2"] = {
        ["Index"] = "pizzathis2",
        ["Name"] = "Caixa de Lanche",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 1,
        ["Economy"] = 10
    },
    ["pizzathis3"] = {
        ["Index"] = "pizzathis3",
        ["Name"] = "Combo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 120
    },
    ["pizzathis4"] = {
        ["Index"] = "pizzathis3",
        ["Name"] = "Combo + Brinquedo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 270
    },
    ["uwucoffee1"] = {
        ["Index"] = "uwucoffee1",
        ["Name"] = "Copo de Suco",
        ["Description"] = "Copo de suco, alimento",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 1,
        ["Economy"] = 10
    },
    ["uwucoffee2"] = {
        ["Index"] = "uwucoffee2",
        ["Name"] = "Caixa de Lanche",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 1,
        ["Economy"] = 10
    },
    ["uwucoffee3"] = {
        ["Index"] = "uwucoffee3",
        ["Name"] = "Combo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 120
    },
    ["uwucoffee4"] = {
        ["Index"] = "uwucoffee3",
        ["Name"] = "Combo + Brinquedo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 270
    },
    ["beanmachine1"] = {
        ["Index"] = "beanmachine1",
        ["Name"] = "Copo de Suco",
        ["Description"] = "Copo de suco, alimento",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 1,
        ["Economy"] = 10
    },
    ["beanmachine2"] = {
        ["Index"] = "beanmachine2",
        ["Name"] = "Caixa de Lanche",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 1,
        ["Economy"] = 10
    },
    ["beanmachine3"] = {
        ["Index"] = "beanmachine3",
        ["Name"] = "Combo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 120
    },
    ["beanmachine4"] = {
        ["Index"] = "beanmachine3",
        ["Name"] = "Combo + Brinquedo",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Comida",
        ["Max"] = 2,
        ["Economy"] = 270
    },
    ["wheelchair"] = {
        ["Index"] = "wheelchair",
        ["Name"] = "Cadeira de Rodas",
        ["Type"] = "Usável",
        ["Name"] = "Cadeira de Rodas, item para rp de [doente, machucado]",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Block"] = true,
        ["Economy"] = 2750
    },
    ["vehkey"] = {
        ["Index"] = "vehkey",
        ["Name"] = "Chave Cópia",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["evidence01"] = {
        ["Index"] = "evidence01",
        ["Name"] = "Evidência",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["evidence02"] = {
        ["Index"] = "evidence02",
        ["Name"] = "Evidência",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["evidence03"] = {
        ["Index"] = "evidence03",
        ["Name"] = "Evidência",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["evidence04"] = {
        ["Index"] = "evidence04",
        ["Name"] = "Evidência",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 0
    },
    ["card01"] = {
        ["Index"] = "card01",
        ["Name"] = "Cartão Comum",
        ["Description"] = "Roubar Lojas de Departamento.",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 325
    },
    ["card02"] = {
        ["Index"] = "card02",
        ["Name"] = "Cartão In-Comum",
        ["Description"] = "Roubar Lojas de Armas.",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 325
    },
    ["card03"] = {
        ["Index"] = "card03",
        ["Name"] = "Cartão Épico",
        ["Description"] = "Roubar Bancos Fleeca.",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 375
    },
    ["card04"] = {
        ["Index"] = "card04",
        ["Name"] = "Cartão Raro",
        ["Description"] = "Roubar Barbearias.",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 275
    },
    ["card05"] = {
        ["Index"] = "card05",
        ["Name"] = "Cartão Lendário",
        ["Description"] = "Roubar Bancos.",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 425
    },
    ["gemstone"] = {
        ["Index"] = "gemstone",
        ["Name"] = "Gemstone",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Economy"] = 2000
    },
    ["radio"] = {
        ["Index"] = "radio",
        ["Name"] = "Rádio",
        ["Description"] = "Rádio aparelho de comunicação.",
        ["Type"] = "Usável",
        ["Repair"] = "repairkit01",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 975
    },
    ["vest"] = {
        ["Index"] = "vest",
        ["Name"] = "Colete",
        ["Description"] = "Colete, vestimento de proteção contra tiros.",
        ["Type"] = "Usável",
        ["Durability"] = 3,
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1500
    },
    ["bandage"] = {
        ["Index"] = "bandage",
        ["Name"] = "Bandagem",
        ["Description"] = "Bandagem, item médico para cura da vida.",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Medicamentos",
        ["Max"] = 3,
        ["Economy"] = 15000
    },
    ["medkit"] = {
        ["Index"] = "medkit",
        ["Name"] = "Kit Médico",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Medicamentos",
        ["Max"] = 1,
        ["Economy"] = 575
    },
    ["woodlog"] = {
        ["Index"] = "woodlog",
        ["Name"] = "Tora de Madeira",
        ["Description"] = "Tora de Madeira, item sem função.",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 40
    },
    ["fishingrod"] = {
        ["Index"] = "fishingrod",
        ["Name"] = "Vara de Pescar",
        ["Description"] = "Item para pesca.",
        ["Type"] = "Usável",
        ["Weight"] = 1.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 725
    },
    ["switchblade"] = {
        ["Index"] = "switchblade",
        ["Name"] = "Canivete",
        ["Type"] = "Usável",
        ["Description"] = "Utilizada para remoção de carne.",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 525
    },
    ["octopus"] = {
        ["Index"] = "octopus",
        ["Name"] = "Polvo",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 14
    },
    ["shrimp"] = {
        ["Index"] = "shrimp",
        ["Name"] = "Camarão",
        ["Type"] = "Comum",
        ["Weight"] = 0.50,
        ["Class"] = "Utilitarios",
        ["Economy"] = 14
    },
    ["carp"] = {
        ["Index"] = "carp",
        ["Name"] = "Carpa",
        ["Type"] = "Usável",
        ["Weight"] = 0.50,
        ["Class"] = "Utilitarios",
        ["Economy"] = 12
    },
    ["codfish"] = {
        ["Index"] = "codfish",
        ["Name"] = "Bacalhau",
        ["Type"] = "Usável",
        ["Weight"] = 0.50,
        ["Class"] = "Utilitarios",
        ["Economy"] = 16
    },
    ["catfish"] = {
        ["Index"] = "catfish",
        ["Name"] = "Bagre",
        ["Type"] = "Usável",
        ["Weight"] = 0.50,
        ["Class"] = "Utilitarios",
        ["Economy"] = 16
    },
    ["goldenfish"] = {
        ["Index"] = "goldenfish",
        ["Name"] = "Dourado",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 30
    },
    ["horsefish"] = {
        ["Index"] = "horsefish",
        ["Name"] = "Cavala",
        ["Type"] = "Usável",
        ["Weight"] = 0.50,
        ["Class"] = "Utilitarios",
        ["Economy"] = 12
    },
    ["tilapia"] = {
        ["Index"] = "tilapia",
        ["Name"] = "Tilápia",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 14
    },
    ["pacu"] = {
        ["Index"] = "pacu",
        ["Name"] = "Pacu",
        ["Type"] = "Usável",
        ["Weight"] = 0.50,
        ["Class"] = "Utilitarios",
        ["Economy"] = 24
    },
    ["pirarucu"] = {
        ["Index"] = "pirarucu",
        ["Name"] = "Pirarucu",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 26
    },
    ["tambaqui"] = {
        ["Index"] = "tambaqui",
        ["Name"] = "Tambaqui",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 28
    },
    ["bait"] = {
        ["Index"] = "bait",
        ["Name"] = "Isca",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 5
    },
    ["weedclone"] = {
        ["Index"] = "weedclone",
        ["Name"] = "Clonagem de Maconha",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Drogas",
        ["Economy"] = 0
    },
    ["weedleaf"] = {
        ["Index"] = "weedleaf",
        ["Name"] = "Folha de Maconha",
        ["Description"] = "Farm para craft de baeado.",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 0
    },
    ["joint"] = {
        ["Index"] = "joint",
        ["Name"] = "Baseado",
        ["Description"] = "Você recebe um colete extra ao usar este item.",
        ["Type"] = "Usável",
        ["Weight"] = 0.05,
        ["Class"] = "Drogas",
        ["Economy"] = 10000
    },
    ["lanca"] = {
        ["Index"] = "lanca",
        ["Name"] = "Lança",
        ["Description"] = "Apenas para ficar doidão.",
        ["Type"] = "Usável",
        ["Weight"] = 0.05,
        ["Class"] = "Drogas",
        ["Economy"] = 10000
    },
    ["md"] = {
        ["Index"] = "md",
        ["Name"] = "MD",
        ["Description"] = "Apenas para ficar doidão.",
        ["Type"] = "Usável",
        ["Weight"] = 0.05,
        ["Class"] = "Drogas",
        ["Economy"] = 10000
    },
    ["codeine"] = {
        ["Index"] = "codeine",
        ["Name"] = "Codeína",
        ["Type"] = "Comum",
        ["Weight"] = 0.10,
        ["Class"] = "Drogas",
        ["Economy"] = 10000
    },
    ["amphetamine"] = {
        ["Index"] = "amphetamine",
        ["Name"] = "Anfetamina",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 10000
    },
    ["cocaine"] = {
        ["Index"] = "cocaine",
        ["Name"] = "Coca",
        ["Description"] = "Aumenta sua velocidade ao correr.",
        ["Type"] = "Usável",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 10000
    },
    ["cokeleaf"] = {
        ["Index"] = "cokeleaf",
        ["Name"] = "Folha de Coca",
        ["Description"] = "Item de farm para cocaina.",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 5
    },
    ["meth"] = {
        ["Index"] = "meth",
        ["Name"] = "Metanfetamina",
        ["Description"] = "Você recebe um colete extra ao usar este item.",
        ["Type"] = "Usável",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 10000
    },
    ["acetone"] = {
        ["Index"] = "acetone",
        ["Name"] = "Acetona",
        ["Type"] = "Comum",
        ["Weight"] = 0.01,
        ["Class"] = "Drogas",
        ["Economy"] = 40
    },
    ["drugtoy"] = {
        ["Index"] = "drugtoy",
        ["Name"] = "Brinquedo",
        ["Type"] = "Comum",
        ["Weight"] = 0.50,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100
    },
    ["rolepass"] = {
        ["Index"] = "rolepass",
        ["Name"] = "Rolepass Premium",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 200000
    },
    ["premium01"] = {
        ["Index"] = "premium01",
        ["Name"] = "VIP Diamante",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 300000
    },
    ["premium02"] = {
        ["Index"] = "premium02",
        ["Name"] = "VIP Policia",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 250000
    },
    ["premium03"] = {
        ["Index"] = "premium03",
        ["Name"] = "VIP Ouro",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 200000
    },
    ["vipsorteio"] = {
        ["Index"] = "premium03",
        ["Name"] = "VIP Sorteio",
        ["Description"] = "Item para sorteios.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 200000
    },
    ["premium04"] = {
        ["Index"] = "premium04",
        ["Name"] = "VIP Prata",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 150000
    },
    ["premium05"] = {
        ["Index"] = "premium05",
        ["Name"] = "VIP Bronze",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 150000
    },
    ["kitdosraul"] = {
        ["Index"] = "kitdosraul",
        ["Name"] = "Kit dos Raul",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 150000
    },
    ["kitboqueta"] = {
        ["Index"] = "kitboqueta",
        ["Name"] = "Kit Boqueta",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 150000
    },
    ["kitmafioso"] = {
        ["Index"] = "kitmafioso",
        ["Name"] = "Kit Mafioso",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 150000
    },
    ["kitcriminal"] = {
        ["Index"] = "kitcriminal",
        ["Name"] = "Kit Criminal",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 150000
    },
    ["kitfogueteiro"] = {
        ["Index"] = "kitfogueteiro",
        ["Name"] = "Kit Fogueteiro",
        ["Description"] = "Item da loja vip.",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 150000
    },
    ["premiumplate"] = {
        ["Index"] = "platepremium",
        ["Name"] = "Placa Personalizada",
        ["Type"] = "Usável",
        ["Description"] = "Personaliza a placa do veículo.",
        ["Weight"] = 0.75,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 100000
    },
    ["phonechange"] = {
        ["Index"] = "phonechange",
        ["Name"] = "Número Personalizada",
        ["Type"] = "Usável",
        ["Description"] = "Personaliza a número de telefone.",
        ["Weight"] = 0.75,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 100000
    },
    ["newchars"] = {
        ["Index"] = "newchars",
        ["Name"] = "+1 Personagem",
        ["Type"] = "Usável",
        ["Description"] = "Limite de personagem em +1.",
        ["Weight"] = 0.25,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 150000
    },
    ["namechange"] = {
        ["Index"] = "namechange",
        ["Name"] = "Troca de Nome",
        ["Type"] = "Usável",
        ["Description"] = "Troca o nome do personagem.",
        ["Weight"] = 0.25,
        ["Class"] = "Premium",
        ["Block"] = true,
        ["Economy"] = 100000
    },
    ["milkbottle"] = {
        ["Index"] = "milkbottle",
        ["Name"] = "Garrafa de Leite",
        ["Description"] = "Garrafa vazia para liquido de leite.",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 5,
        ["Economy"] = 35
    },
    ["guarananatural"] = {
        ["Index"] = "guarananatural",
        ["Name"] = "Guaraná Natural",
        ["Description"] = "Guarana, item liquido.",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["energetic"] = {
        ["Index"] = "energetic",
        ["Name"] = "Energético ",
        ["Description"] = "Item que aumenta velocidade do movimento.",
        ["Type"] = "Usável",
        ["Durability"] = 15,
        ["Class"] = "Comida",
        ["Weight"] = 0.25,
        ["Economy"] = 1000
    },
    ["graos"] = {
        ["Index"] = "graos",
        ["Name"] = "Graos ",
        ["Type"] = "Usável",
        ["Class"] = "Comida",
        ["Weight"] = 0.25,
        ["Economy"] = 1000
    },
    ["cereais"] = {
        ["Index"] = "cereais",
        ["Name"] = "Cereais ",
        ["Type"] = "Usável",
        ["Class"] = "Comida",
        ["Weight"] = 0.25,
        ["Economy"] = 1000
    },
    ["attachments"] = {
        ["Index"] = "attachsCrosshair",
        ["Name"] = "Modificador de Arma ",
        ["Description"] = "Item que para melhoria de armamento.",
        ["Type"] = "Usável",
        ["Durability"] = 15,
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100
    },
    ["gamebooster"] = {
        ["Index"] = "gamebooster",
        ["Name"] = "Game booster",
        ["Description"] = "Item que aumenta velocidade do movimento.",
        ["Type"] = "Usável",
        ["Durability"] = 15,
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["gamebooster1"] = {
        ["Index"] = "gamebooster",
        ["Name"] = "Game booster",
        ["Description"] = "Item que aumenta velocidade do movimento.",
        ["Type"] = "Usável",
        ["Durability"] = 10,
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["water"] = {
        ["Index"] = "water",
        ["Name"] = "Água",
        ["Description"] = "Item liquido, alimento.",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 30
    },
    ["emptybottle"] = {
        ["Index"] = "emptybottle",
        ["Name"] = "Garrafa Vazia",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Max"] = 5,
        ["Economy"] = 30
    },
    ["coffee"] = {
        ["Index"] = "coffee",
        ["Name"] = "Copo de Café",
        ["Description"] = "Item liquido, alimento.",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 20
    },
    ["coffeemilk"] = {
        ["Index"] = "coffeemilk",
        ["Name"] = "Café com Leite",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 95
    },
    ["cola"] = {
        ["Index"] = "cola",
        ["Name"] = "Cola",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 15
    },
    ["tacos"] = {
        ["Index"] = "tacos",
        ["Name"] = "Tacos",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 25
    },
    ["fries"] = {
        ["Index"] = "fries",
        ["Name"] = "Fritas",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 125
    },
    ["soda"] = {
        ["Index"] = "soda",
        ["Name"] = "Sprunk",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 15
    },
    ["apple"] = {
        ["Index"] = "apple",
        ["Name"] = "Maça",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["orange"] = {
        ["Index"] = "orange",
        ["Name"] = "Laranja",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["strawberry"] = {
        ["Index"] = "strawberry",
        ["Name"] = "Morango",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["coffee2"] = {
        ["Index"] = "coffee2",
        ["Name"] = "Grão de Café",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["grape"] = {
        ["Index"] = "grape",
        ["Name"] = "Uva",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["tange"] = {
        ["Index"] = "tange",
        ["Name"] = "Tangerina",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["banana"] = {
        ["Index"] = "banana",
        ["Name"] = "Banana",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["guarana"] = {
        ["Index"] = "guarana",
        ["Name"] = "Guaraná",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["acerola"] = {
        ["Index"] = "acerola",
        ["Name"] = "Acerola",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["passion"] = {
        ["Index"] = "passion",
        ["Name"] = "Maracujá",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["tomato"] = {
        ["Index"] = "tomato",
        ["Name"] = "Tomate",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["mushroom"] = {
        ["Index"] = "mushroom",
        ["Name"] = "Cogumelo",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["sugar"] = {
        ["Index"] = "sugar",
        ["Name"] = "Açucar",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Comida",
        ["Economy"] = 5
    },
    ["cookies"] = {
        ["Index"] = "cookies",
        ["Name"] = "Cookies",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 60
    },
    ["orangejuice"] = {
        ["Index"] = "orangejuice",
        ["Name"] = "Suco de Laranja",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["tangejuice"] = {
        ["Index"] = "tangejuice",
        ["Name"] = "Suco de Tangerina",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["grapejuice"] = {
        ["Index"] = "grapejuice",
        ["Name"] = "Suco de Uva",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["strawberryjuice"] = {
        ["Index"] = "strawberryjuice",
        ["Name"] = "Suco de Morango",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["bananajuice"] = {
        ["Index"] = "bananajuice",
        ["Name"] = "Suco de Banana",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["acerolajuice"] = {
        ["Index"] = "acerolajuice",
        ["Name"] = "Suco de Acerola",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["passionjuice"] = {
        ["Index"] = "passionjuice",
        ["Name"] = "Suco de Maracujá",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 100
    },
    ["bread"] = {
        ["Index"] = "bread",
        ["Name"] = "Pão",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Economy"] = 5
    },
    ["ketchup"] = {
        ["Index"] = "ketchup",
        ["Name"] = "Ketchup",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Economy"] = 75
    },
    ["cannedsoup"] = {
        ["Index"] = "cannedsoup",
        ["Name"] = "Sopa em Lata",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Economy"] = 55
    },
    ["canofbeans"] = {
        ["Index"] = "canofbeans",
        ["Name"] = "Lata de Feijão",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Economy"] = 55
    },
    ["fishfillet"] = {
        ["Index"] = "fishfillet",
        ["Name"] = "Filé de Peixe",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Economy"] = 10
    },
    ["marshmallow"] = {
        ["Index"] = "marshmallow",
        ["Name"] = "Marshmallow",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 35
    },
    ["cookedfishfillet"] = {
        ["Index"] = "cookedfishfillet",
        ["Name"] = "Filé de Peixe Cozido",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 35
    },
    ["hamburger"] = {
        ["Index"] = "hamburger",
        ["Name"] = "Hambúrguer",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 25
    },
    ["hamburger2"] = {
        ["Index"] = "hamburger2",
        ["Name"] = "Hambúrguer Artesanal",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 125
    },
    ["onionrings"] = {
        ["Index"] = "onionrings",
        ["Name"] = "Anéis de Cebola",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 70
    },
    ["chickenfries"] = {
        ["Index"] = "chickenfries",
        ["Name"] = "Frango Frito",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 125
    },
    ["pizzamozzarella"] = {
        ["Index"] = "pizzamozzarella",
        ["Name"] = "Pizza de Muçarela",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 150
    },
    ["pizzamushroom"] = {
        ["Index"] = "pizzamushroom",
        ["Name"] = "Pizza de Cogumelo",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 150
    },
    ["pizzabanana"] = {
        ["Index"] = "pizzabanana",
        ["Name"] = "Pizza de Banana",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 150
    },
    ["pizzachocolate"] = {
        ["Index"] = "pizzachocolate",
        ["Name"] = "Pizza de Chocolate",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 150
    },
    ["calzone"] = {
        ["Index"] = "calzone",
        ["Name"] = "Calzone",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 150
    },
    ["hotdog"] = {
        ["Index"] = "hotdog",
        ["Name"] = "Cachorro-Quente",
        ["Type"] = "Usável",
        ["Weight"] = 0.45,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 15
    },
    ["donut"] = {
        ["Index"] = "donut",
        ["Name"] = "Rosquinha",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 15
    },
    ["plate"] = {
        ["Index"] = "plate",
        ["Name"] = "Placa",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 525
    },
    ["lockpick"] = {
        ["Index"] = "lockpick",
        ["Name"] = "Lockpick de Alumínio",
        ["Repair"] = "repairkit01",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 425
    },
    ["toolbox"] = {
        ["Index"] = "toolbox",
        ["Name"] = "Ferramentas Básicas",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Max"] = 2,
        ["Economy"] = 625
    },
    ["advtoolbox"] = {
        ["Index"] = "toolbox",
        ["Name"] = "Kit de Reparo - Usado para reparar veículos quebrados.",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Charges"] = 3,
        ["Class"] = "Utilitarios",
        ["Max"] = 1,
        ["Economy"] = 1525
    },
    ["notepad"] = {
        ["Index"] = "notepad",
        ["Name"] = "Bloco de Notas",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 10
    },
    ["tyres"] = {
        ["Index"] = "tyres",
        ["Name"] = "Pneu",
        ["Type"] = "Usável",
        ["Weight"] = 1.75,
        ["Class"] = "Utilitarios",
        ["Max"] = 4,
        ["Economy"] = 225
    },
    ["cellphone"] = {
        ["Index"] = "cellphone",
        ["Name"] = "Celular",
        ["Description"] = "Aparelho telefonico, utilizado para comunicação e acesso a apps",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 300
    },
    ["scuba"] = {
        ["Index"] = "scuba",
        ["Name"] = "Roupa de Mergulho",
        ["Type"] = "Usável",
        ["Weight"] = 4.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 975
    },
    ["handcuff"] = {
        ["Index"] = "handcuff",
        ["Name"] = "Algemas",
        ["Description"] = "item utilizado por bandidos e policial, para prender um player",
        ["Repair"] = "repairkit02",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 5750
    },
    ["hood"] = {
        ["Index"] = "hood",
        ["Name"] = "Capuz",
        ["Description"] = "Capuz, item utilizado para vendar todas as pessoas, utilizado em sequestro",
        ["Repair"] = "repairkit01",
        ["Type"] = "Usável",
        ["Weight"] = 1.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 5750
    },
    ["plastic"] = {
        ["Index"] = "plastic",
        ["Name"] = "Plástico",
        ["Type"] = "Comum",
        ["Weight"] = 0.065,
        ["Class"] = "Utilitarios",
        ["Economy"] = 20
    },
    ["glass"] = {
        ["Index"] = "glass",
        ["Name"] = "Vidro",
        ["Type"] = "Comum",
        ["Weight"] = 0.065,
        ["Class"] = "Utilitarios",
        ["Economy"] = 20
    },
    ["rubber"] = {
        ["Index"] = "rubber",
        ["Name"] = "Borracha",
        ["Type"] = "Comum",
        ["Weight"] = 0.050,
        ["Class"] = "Utilitarios",
        ["Economy"] = 20
    },
    ["aluminum"] = {
        ["Index"] = "aluminum",
        ["Name"] = "Alumínio",
        ["Type"] = "Comum",
        ["Weight"] = 0.075,
        ["Class"] = "Utilitarios",
        ["Economy"] = 30
    },
    ["copper"] = {
        ["Index"] = "copper",
        ["Name"] = "Cobre",
        ["Type"] = "Comum",
        ["Weight"] = 0.095,
        ["Class"] = "Utilitarios",
        ["Economy"] = 30
    },
    ["ritmoneury"] = {
        ["Index"] = "ritmoneury",
        ["Name"] = "Ritmoneury",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Max"] = 2,
        ["Economy"] = 475
    },
    ["sinkalmy"] = {
        ["Index"] = "sinkalmy",
        ["Name"] = "Sinkalmy",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Max"] = 2,
        ["Economy"] = 375
    },
    ["cigarette"] = {
        ["Index"] = "cigarette",
        ["Name"] = "Cigarro",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Max"] = 5,
        ["Economy"] = 10
    },
    ["lighter"] = {
        ["Index"] = "lighter",
        ["Name"] = "Isqueiro",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Weight"] = 0.55,
        ["Class"] = "Utilitarios",
        ["Economy"] = 175
    },
    ["vape"] = {
        ["Index"] = "vape",
        ["Name"] = "Vape",
        ["Repair"] = "repairkit01",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 4750
    },
    ["dollars"] = {
        ["Index"] = "dollars",
        ["Name"] = "Dólares",
        ["Type"] = "Comum",
        ["Weight"] = 0.0,
        ["Class"] = "Utilitarios",
        ["Economy"] = 1
    },
    ["battery"] = {
        ["Index"] = "battery",
        ["Name"] = "Pilhas",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 90
    },
    ["elastic"] = {
        ["Index"] = "elastic",
        ["Name"] = "Elástico",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 60
    },
    ["plasticbottle"] = {
        ["Index"] = "plasticbottle",
        ["Name"] = "Garrafa Plástica",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 60
    },
    ["glassbottle"] = {
        ["Index"] = "glassbottle",
        ["Name"] = "Garrafa de Vidro",
        ["Type"] = "Comum",
        ["Weight"] = 0.45,
        ["Class"] = "Utilitarios",
        ["Economy"] = 60
    },
    ["metalcan"] = {
        ["Index"] = "metalcan",
        ["Name"] = "Lata de Metal",
        ["Type"] = "Comum",
        ["Weight"] = 0.55,
        ["Class"] = "Utilitarios",
        ["Economy"] = 90
    },
    ["chocolate"] = {
        ["Index"] = "chocolate",
        ["Name"] = "Chocolate",
        ["Description"] = "Alimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.15,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 15
    },
    ["sandwich"] = {
        ["Index"] = "sandwich",
        ["Name"] = "Sanduiche",
        ["Description"] = "Alimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Comida",
        ["Max"] = 3,
        ["Economy"] = 15
    },
    ["rose"] = {
        ["Index"] = "rose",
        ["Name"] = "Rosa",
        ["Description"] = "Flor, rosa",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 25
    },
    ["teddy"] = {
        ["Index"] = "teddy",
        ["Name"] = "Teddy",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["absolut"] = {
        ["Index"] = "absolut",
        ["Name"] = "Absolut",
        ["Description"] = "bebida alcoólica",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Economy"] = 15
    },
    ["chandon"] = {
        ["Index"] = "chandon",
        ["Name"] = "Chandon",
        ["Description"] = "bebida alcoólica",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Economy"] = 15
    },
    ["dewars"] = {
        ["Index"] = "dewars",
        ["Name"] = "Dewars",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Economy"] = 15
    },
    ["hennessy"] = {
        ["Index"] = "hennessy",
        ["Name"] = "Hennessy",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Comida",
        ["Economy"] = 15
    },
    ["goldbar"] = {
        ["Index"] = "goldbar",
        ["Name"] = "Barra de Ouro",
        ["Description"] = "Barra de Ouro",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 525
    },
    ["binoculars"] = {
        ["Index"] = "binoculars",
        ["Name"] = "Binóculos",
        ["Description"] = "item para observar coisas há longa distância",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 275
    },
    ["camera"] = {
        ["Index"] = "camera",
        ["Name"] = "Câmera",
        ["Description"] = "Câmera fotografica",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 275
    },
    ["WEAPON_HATCHET"] = {
        ["Index"] = "hatchet",
        ["Description"] = "Armamento braco, Machado",
        ["Name"] = "Machado",
        ["Type"] = "Armamento",
        ["Repair"] = "repairkit01",
        ["Weight"] = 1.75,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_BAT"] = {
        ["Index"] = "bat",
        ["Name"] = "Bastão de Beisebol",
        ["Description"] = "Armamento braco, Bastão de Beisebol",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.75,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_KATANA"] = {
        ["Index"] = "katana",
        ["Name"] = "Katana",
        ["Description"] = "Armamento braco, Katana",
        ["Type"] = "Armamento",
        ["Repair"] = "repairkit01",
        ["Weight"] = 1.75,
        ["Class"] = "Armas",
        ["Economy"] = 75000
    },
    ["WEAPON_KARAMBIT"] = {
        ["Index"] = "karambit",
        ["Name"] = "Karambit",
        ["Description"] = "Armamento braco, Karambit",
        ["Type"] = "Armamento",
        ["Repair"] = "repairkit01",
        ["Weight"] = 1.25,
        ["Class"] = "Armas",
        ["Economy"] = 75000
    },
    ["WEAPON_BATTLEAXE"] = {
        ["Index"] = "battleaxe",
        ["Name"] = "Machado de Batalha",
        ["Description"] = "Armamento braco, Machado de Batalha",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.75,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_CROWBAR"] = {
        ["Index"] = "crowbar",
        ["Name"] = "Pé de Cabra",
        ["Description"] = "Armamento braco, Pé de Cabra",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.35,
        ["Class"] = "Armas",
        ["Economy"] = 725
    },
    ["WEAPON_GOLFCLUB"] = {
        ["Index"] = "golfclub",
        ["Name"] = "Taco de Golf",
        ["Description"] = "Armamento braco, taco de golf",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.65,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_HAMMER"] = {
        ["Index"] = "hammer",
        ["Name"] = "Martelo",
        ["Description"] = "Armamento braco, Martelo",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.45,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_MACHETE"] = {
        ["Index"] = "machete",
        ["Name"] = "Facão",
        ["Description"] = "Armamento braco, Facão",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.35,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_POOLCUE"] = {
        ["Index"] = "poolcue",
        ["Name"] = "Taco de Sinuca",
        ["Description"] = "Armamento braco, Taco de Sinuca",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.25,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_STONE_HATCHET"] = {
        ["Index"] = "stonehatchet",
        ["Name"] = "Machado de Pedra",
        ["Description"] = "Armemento branco, Machado de Pedra",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.55,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_WRENCH"] = {
        ["Index"] = "wrench",
        ["Name"] = "Chave Inglesa",
        ["Description"] = "Armemento branco, soco inglês",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.45,
        ["Class"] = "Armas",
        ["Economy"] = 725
    },
    ["WEAPON_KNUCKLE"] = {
        ["Index"] = "knuckle",
        ["Name"] = "Soco Inglês",
        ["Description"] = "Armemento branco, soco inglês",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.15,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_FLASHLIGHT"] = {
        ["Index"] = "flashlight",
        ["Name"] = "Lanterna",
        ["Description"] = "Lanterna, item para melhoria do armamento",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.15,
        ["Class"] = "Armas",
        ["Economy"] = 15000
    },
    ["WEAPON_NIGHTSTICK"] = {
        ["Index"] = "nightstick",
        ["Description"] = "Arma branca cassetete, armamento de policial",
        ["Name"] = "Cassetete",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Weight"] = 1.15,
        ["Class"] = "Armas",
        ["Economy"] = 125
    },
    ["WEAPON_PISTOL"] = {
        ["Index"] = "m1911",
        ["Name"] = "M1911",
        ["Description"] = "Armento pistola MM1911",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_PISTOL_MK2"] = {
        ["Index"] = "fiveseven",
        ["Name"] = "FN Five Seven",
        ["Description"] = "Armento pistola Five Seven",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_COMPACTRIFLE"] = {
        ["Index"] = "akcompact",
        ["Name"] = "AK Compact",
        ["Description"] = "Armento de rifle AK Compact",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_APPISTOL"] = {
        ["Index"] = "kochvp9",
        ["Name"] = "Koch Vp9",
        ["Description"] = "Armento pistola Koch VP9",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_HEAVYPISTOL"] = {
        ["Index"] = "atifx45",
        ["Name"] = "Ati FX45",
        ["Description"] = "Armento de pistola Ati FX45",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_MACHINEPISTOL"] = {
        ["Index"] = "tec9",
        ["Name"] = "Tec-9",
        ["Description"] = "Armento de SMG TEC-9",
        ["Type"] = "Armamento",
        ["Repair"] = "repairkit03",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_MICROSMG"] = {
        ["Index"] = "uzi",
        ["Name"] = "Uzi",
        ["Description"] = "Armento de SMG UZI",
        ["Type"] = "Armamento",
        ["Repair"] = "repairkit03",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_NAILGUN"] = {
        ["Index"] = "nailgun",
        ["Name"] = "Arma de Prego",
        ["Description"] = "Armamento de Prego",
        ["Repair"] = "repairkit01",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_NAIL_AMMO",
        ["Vehicle"] = false,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 3250
    },
    ["WEAPON_MINISMG"] = {
        ["Index"] = "skorpionv61",
        ["Name"] = "Skorpion V61",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_TECPISTOL"] = {
        ["Index"] = "tecm31",
        ["Name"] = "Tec M31",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_SCORPIONEVO"] = {
        ["Index"] = "skorpionv61",
        ["Name"] = "Scorpion Evo",
        ["Description"] = "Armamento SMG Scorpion EVO",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_MP5K"] = {
        ["Index"] = "skorpionv61",
        ["Name"] = "MP5K",
        ["Description"] = "Armamento SMG mp5k",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_MP9"] = {
        ["Index"] = "skorpionv61",
        ["Name"] = "MP9",
        ["Description"] = "Armamento SMG MP9",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_M9A3"] = {
        ["Index"] = "amt380",
        ["Name"] = "M9A3",
        ["Description"] = "Armamento pistola m9a3",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_SNSPISTOL"] = {
        ["Index"] = "amt380",
        ["Name"] = "AMT 380",
        ["Description"] = "Armamento pistola AMT 380",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_SNSPISTOL_MK2"] = {
        ["Index"] = "hkp7m10",
        ["Name"] = "HK P7M10",
        ["Description"] = "Armamento pistola HK P7M10",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_VINTAGEPISTOL"] = {
        ["Index"] = "m1922",
        ["Name"] = "M1922",
        ["Description"] = "Armamento pistola m1922",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_PISTOL50"] = {
        ["Index"] = "desert",
        ["Name"] = "Desert Eagle",
        ["Description"] = "Armamento pistola Desert Eagle",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_REVOLVER"] = {
        ["Index"] = "magnum",
        ["Name"] = "Magnum 44",
        ["Description"] = "Armamento pistola Magnum 44",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_COMBATPISTOL"] = {
        ["Index"] = "glock",
        ["Name"] = "Glock",
        ["Description"] = "Armamento pistola Glock",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PISTOL_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 125000
    },
    ["WEAPON_PARAFAL"] = {
        ["Index"] = "parafal",
        ["Name"] = "PARA-FAL M964A1",
        ["Description"] = "Armamento fuzil Parafal",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_SCARH"] = {
        ["Index"] = "fnfal",
        ["Name"] = "Scar-H",
        ["Description"] = "Armamento fuzil Scar-H",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_NAVYCARBINE"] = {
        ["Index"] = "m4a1",
        ["Name"] = "Navy Carbine",
        ["Description"] = "Armamento fuzil Navy Carbine",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_COLTXM177"] = {
        ["Index"] = "coltxm177",
        ["Name"] = "COLT XM177",
        ["Description"] = "Armamento fuzil COLT XM177",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_NSR"] = {
        ["Index"] = "m4a1",
        ["Name"] = "NSR",
        ["Description"] = "Armamento fuzil NSR",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_CARBINERIFLE"] = {
        ["Index"] = "m4a1",
        ["Name"] = "M4A1",
        ["Description"] = "Armamento fuzil M4A1",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_CARBINERIFLE_MK2"] = {
        ["Index"] = "m4a4",
        ["Name"] = "M4A4",
        ["Repair"] = "repairkit04",
        ["Description"] = "Armamento fuzil M4A4",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_ADVANCEDRIFLE"] = {
        ["Index"] = "tar21",
        ["Name"] = "Tar-21",
        ["Description"] = "Armamento fuzil TAR-21",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_BULLPUPRIFLE"] = {
        ["Index"] = "qbz95",
        ["Name"] = "QBZ-95",
        ["Description"] = "Armamento fuzil QBZ-95",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_BULLPUPRIFLE_MK2"] = {
        ["Index"] = "l85",
        ["Name"] = "L85",
        ["Repair"] = "repairkit04",
        ["Description"] = "Armamento fuzil L85",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_SPECIALCARBINE"] = {
        ["Index"] = "g36c",
        ["Name"] = "G36C",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_SNIPERRIFLE"] = {
        ["Index"] = "awmmagnum",
        ["Name"] = "AWM Magnum",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SNIPER_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 650000
    },
    ["WEAPON_COMBATMG_MK2"] = {
        ["Index"] = "m249",
        ["Name"] = "M249",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_MILITARYRIFLE"] = {
        ["Index"] = "mtar-21",
        ["Name"] = "MTAR-21",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_TACTICALRIFLE"] = {
        ["Index"] = "m16",
        ["Name"] = "M16",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_SPECIALCARBINE_MK2"] = {
        ["Index"] = "sigsauer556",
        ["Name"] = "Sig Sauer 556",
        ["Description"] = "Armamento fuzil G3 MK2",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 300000
    },
    ["WEAPON_PUMPSHOTGUN"] = {
        ["Index"] = "mossberg590",
        ["Name"] = "Mossberg 590",
        ["Description"] = "Armamento DOZE",
        ["Repair"] = "repairkit03",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SHOTGUN_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_PUMPSHOTGUN_MK2"] = {
        ["Index"] = "mossberg590a1",
        ["Name"] = "Mossberg 590A1",
        ["Description"] = "Armamento DOZE MK2",
        ["Repair"] = "repairkit04",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SHOTGUN_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_MUSKET"] = {
        ["Index"] = "winchester",
        ["Name"] = "Winchester 1892",
        ["Description"] = "Armamento de MUSKET",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_MUSKET_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 3250
    },
    ["WEAPON_SAWNOFFSHOTGUN"] = {
        ["Index"] = "mossberg500",
        ["Name"] = "Mossberg 500",
        ["Repair"] = "repairkit03",
        ["Description"] = "Armamento DOZE",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SHOTGUN_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_SMG"] = {
        ["Index"] = "mp5",
        ["Name"] = "MP5",
        ["Repair"] = "repairkit03",
        ["Description"] = "Armamento de SMG",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_SMG_MK2"] = {
        ["Index"] = "evo3",
        ["Name"] = "Evo-3",
        ["Repair"] = "repairkit03",
        ["Description"] = "Armamento de SMG",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Vehicle"] = true,
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 190000
    },
    ["WEAPON_ASSAULTRIFLE"] = {
        ["Index"] = "ak103",
        ["Name"] = "AK-103",
        ["Repair"] = "repairkit04",
        ["Description"] = "Armamento de fuzil",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_ASSAULTRIFLE_MK2"] = {
        ["Index"] = "ak74",
        ["Name"] = "AK-74",
        ["Repair"] = "repairkit04",
        ["Description"] = "Armamento de rifle",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_ASSAULTSMG"] = {
        ["Index"] = "steyraug",
        ["Name"] = "Steyr AUG",
        ["Repair"] = "repairkit03",
        ["Description"] = "Armamento de rifle",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_RIFLE_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_GUSENBERG"] = {
        ["Index"] = "thompson",
        ["Name"] = "Thompson",
        ["Repair"] = "repairkit03",
        ["Description"] = "Armamento de SMG",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_SMG_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 250000
    },
    ["WEAPON_PETROLCAN"] = {
        ["Index"] = "gallon",
        ["Name"] = "Galão",
        ["Type"] = "Armamento",
        ["Ammo"] = "WEAPON_PETROLCAN_AMMO",
        ["Weight"] = 0.6,
        ["Class"] = "Armas",
        ["Economy"] = 50
    },
    ["GADGET_PARACHUTE"] = {
        ["Index"] = "parachute",
        ["Name"] = "Paraquedas",
        ["Description"] = "Item para pular de paraquedas",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Armas",
        ["Economy"] = 1000
    },
    ["WEAPON_STUNGUN"] = {
        ["Index"] = "stungun",
        ["Name"] = "Tazer",
        ["Repair"] = "repairkit02",
        ["Type"] = "Armamento",
        ["Weight"] = 0.75,
        ["Class"] = "Armas",
        ["Economy"] = 525
    },
    ["WEAPON_NAIL_AMMO"] = {
        ["Index"] = "nails",
        ["Name"] = "M. Pregos",
        ["Description"] = "Munição de grampeador, prego",
        ["Type"] = "Munição",
        ["Weight"] = 0.004,
        ["Class"] = "Armas",
        ["Economy"] = 2
    },
    ["WEAPON_PISTOL_AMMO"] = {
        ["Index"] = "pistolammo",
        ["Name"] = "M. Pistola",
        ["Description"] = "Munição de armamento, Pistolas",
        ["Type"] = "Munição",
        ["Weight"] = 0.001,
        ["Class"] = "Armas",
        ["Economy"] = 50
    },
    ["WEAPON_SMG_AMMO"] = {
        ["Index"] = "smgammo",
        ["Name"] = "M. Sub",
        ["Description"] = "Munição de armamento, Submetralhadora",
        ["Type"] = "Munição",
        ["Weight"] = 0.001,
        ["Class"] = "Armas",
        ["Economy"] = 60
    },
    ["WEAPON_RIFLE_AMMO"] = {
        ["Index"] = "rifleammo",
        ["Name"] = "M. Rifle",
        ["Type"] = "Munição",
        ["Weight"] = 0.001,
        ["Class"] = "Armas",
        ["Economy"] = 75
    },
    ["WEAPON_SNIPER_AMMO"] = {
        ["Index"] = "sniperammo",
        ["Name"] = "M. Sniper",
        ["Type"] = "Munição",
        ["Weight"] = 0.001,
        ["Class"] = "Armas",
        ["Economy"] = 120
    },
    ["WEAPON_SHOTGUN_AMMO"] = {
        ["Index"] = "shotgunammo",
        ["Name"] = "M. Escopeta",
        ["Description"] = "Munição de armamento, 12 Shotgunn",
        ["Type"] = "Munição",
        ["Weight"] = 0.001,
        ["Class"] = "Armas",
        ["Economy"] = 75
    },
    ["WEAPON_MUSKET_AMMO"] = {
        ["Index"] = "musketammo",
        ["Name"] = "M. Mosquete",
        ["Description"] = "Munição de armamento. Mosquete",
        ["Type"] = "Munição",
        ["Weight"] = 0.004,
        ["Class"] = "Armas",
        ["Economy"] = 7
    },
    ["WEAPON_PETROLCAN_AMMO"] = {
        ["Index"] = "fuel",
        ["Name"] = "Combustível",
        ["Description"] = "Combustível, item para encher o tanque do veiculo",
        ["Type"] = "Munição",
        ["Weight"] = 0.00,
        ["Class"] = "Armas",
        ["Economy"] = 0
    },
    ["WEAPON_BRICK"] = {
        ["Index"] = "brick",
        ["Name"] = "Tijolo",
        ["Description"] = "item de pedra feito para tacar nos outros ou construir algo",
        ["Type"] = "Throwing",
        ["Vehicle"] = true,
        ["Weight"] = 0.75,
        ["Class"] = "Armas",
        ["Economy"] = 25
    },
    ["WEAPON_SNOWBALL"] = {
        ["Index"] = "snowball",
        ["Name"] = "Bola de Neve",
        ["Description"] = "item feito com gelo/neve",
        ["Type"] = "Throwing",
        ["Vehicle"] = true,
        ["Weight"] = 0.55,
        ["Class"] = "Armas",
        ["Economy"] = 6
    },
    ["WEAPON_SHOES"] = {
        ["Index"] = "shoes",
        ["Name"] = "Tênis",
        ["Type"] = "Throwing",
        ["Description"] = "Tênis, item de vestimenta",
        ["Vehicle"] = true,
        ["Weight"] = 0.755,
        ["Class"] = "Armas",
        ["Economy"] = 25
    },
    ["WEAPON_MOLOTOV"] = {
        ["Index"] = "molotov",
        ["Name"] = "Coquetel Molotov",
        ["Type"] = "Throwing",
        ["Vehicle"] = true,
        ["Weight"] = 0.95,
        ["Class"] = "Armas",
        ["Economy"] = 225,
        ["Max"] = 3
    },
    ["WEAPON_SMOKEGRENADE"] = {
        ["Index"] = "smokegrenade",
        ["Name"] = "Granada de Fumaça",
        ["Description"] = "Granada de fumaça, item utilizado em guerras",
        ["Type"] = "Throwing",
        ["Vehicle"] = true,
        ["Weight"] = 0.95,
        ["Class"] = "Armas",
        ["Economy"] = 225,
        ["Max"] = 3
    },
    ["pager"] = {
        ["Index"] = "pager",
        ["Name"] = "Pager",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 125
    },
    ["firecracker"] = {
        ["Index"] = "firecracker",
        ["Name"] = "Fogos de Artificio",
        ["Type"] = "Usável",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100
    },
    ["analgesic"] = {
        ["Index"] = "analgesic",
        ["Name"] = "Analgésico",
        ["Description"] = "Analgesico, Item médico para cura de um ferimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Medicamentos",
        ["Max"] = 5,
        ["Economy"] = 10000
    },
    ["oxy"] = {
        ["Index"] = "analgesic",
        ["Name"] = "Oxy",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Medicamentos",
        ["Max"] = 5,
        ["Economy"] = 35
    },
    ["gauze"] = {
        ["Index"] = "gauze",
        ["Name"] = "Ataduras",
        ["Description"] = "Atadura, Item médico para cura de um ferimento",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Medicamentos",
        ["Max"] = 5,
        ["Economy"] = 10000
    },
    ["gsrkit"] = {
        ["Index"] = "gsrkit",
        ["Name"] = "Kit Residual",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 20
    },
    ["gdtkit"] = {
        ["Index"] = "gdtkit",
        ["Name"] = "Kit Químico",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 20
    },
    ["emerald"] = {
        ["Index"] = "emerald",
        ["Name"] = "Esmeralda",
        ["Description"] = "Esmeralda, pedra preciosa de grande valor",
        ["Type"] = "Comum",
        ["Weight"] = 0.95,
        ["Class"] = "Utilitarios",
        ["Economy"] = 85
    },
    ["diamond"] = {
        ["Index"] = "diamond",
        ["Name"] = "Diamante",
        ["Description"] = "Diamante, pedra preciosa de grande valor",
        ["Type"] = "Comum",
        ["Weight"] = 0.95,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["ruby"] = {
        ["Index"] = "ruby",
        ["Name"] = "Rubi",
        ["Description"] = "Rubi, pedra preciosa de grande valor",
        ["Type"] = "Comum",
        ["Weight"] = 0.85,
        ["Class"] = "Utilitarios",
        ["Economy"] = 55
    },
    ["sapphire"] = {
        ["Index"] = "sapphire",
        ["Name"] = "Safira",
        ["Description"] = "Safira, pedra preciosa de grande valor",
        ["Type"] = "Comum",
        ["Weight"] = 0.85,
        ["Class"] = "Utilitarios",
        ["Economy"] = 45
    },
    ["amethyst"] = {
        ["Index"] = "amethyst",
        ["Name"] = "Ametista",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 35
    },
    ["amber"] = {
        ["Index"] = "amber",
        ["Name"] = "Âmbar",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 25
    },
    ["turquoise"] = {
        ["Index"] = "turquoise",
        ["Name"] = "Turquesa",
        ["Type"] = "Comum",
        ["Weight"] = 0.65,
        ["Class"] = "Utilitarios",
        ["Economy"] = 15
    },
    ["keyboard"] = {
        ["Index"] = "keyboard",
        ["Name"] = "Teclado",
        ["Description"] = "Teclado, periferico do cumputador",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["mouse"] = {
        ["Index"] = "mouse",
        ["Name"] = "Mouse",
        ["Description"] = "Mouse, periferico do cumputador",
        ["Type"] = "Comum",
        ["Weight"] = 0.55,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["silverring"] = {
        ["Index"] = "silverring",
        ["Name"] = "Anel de Prata",
        ["Description"] = "Anel de prata, produto de embeleze pessoal",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["goldring"] = {
        ["Index"] = "goldring",
        ["Name"] = "Anel de Ouro",
        ["Description"] = "Anel de ouro, produto de embeleze pessoal",
        ["Type"] = "Comum",
        ["Weight"] = 0.45,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100
    },
    ["silvercoin"] = {
        ["Index"] = "silvercoin",
        ["Name"] = "Moeda de Prata",
        ["Description"] = "Moeda de prata, item de valor, dinheiro",
        ["Type"] = "Usável",
        ["Weight"] = 0.05,
        ["Class"] = "Utilitarios",
        ["Economy"] = 20
    },
    ["goldcoin"] = {
        ["Index"] = "goldcoin",
        ["Name"] = "Moeda de Ouro",
        ["Description"] = "Moeda de Ouro, item de valor, dinheiro",
        ["Type"] = "Usável",
        ["Weight"] = 0.05,
        ["Class"] = "Utilitarios",
        ["Economy"] = 40
    },
    ["watch"] = {
        ["Index"] = "watch",
        ["Name"] = "Relógio",
        ["Description"] = "Bracelete, produto de enfeite pessoal",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["playstation"] = {
        ["Index"] = "playstation",
        ["Name"] = "Playstation",
        ["Description"] = "Playstation, video game",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["xbox"] = {
        ["Index"] = "xbox",
        ["Name"] = "Xbox",
        ["Description"] = "Xbox, video game",
        ["Type"] = "Comum",
        ["Weight"] = 1.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["legos"] = {
        ["Index"] = "legos",
        ["Name"] = "Legos",
        ["Type"] = "Comum",
        ["Weight"] = 0.45,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["ominitrix"] = {
        ["Index"] = "ominitrix",
        ["Name"] = "Ominitrix",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["bracelet"] = {
        ["Index"] = "bracelet",
        ["Name"] = "Bracelete",
        ["Description"] = "Bracelete, produto de enfeite pessoal",
        ["Type"] = "Comum",
        ["Weight"] = 0.55,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["dildo"] = {
        ["Index"] = "dildo",
        ["Name"] = "Vibrador",
        ["Description"] = "Vibrador, produto +18",
        ["Type"] = "Comum",
        ["Weight"] = 0.45,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["spray01"] = {
        ["Index"] = "spray01",
        ["Name"] = "Desodorante 24hrs",
        ["Description"] = "Desodorante, produto de higiene pessoal",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["spray02"] = {
        ["Index"] = "spray02",
        ["Name"] = "Antisséptico",
        ["Description"] = "Antisséptico, produto de higiene pessoal",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["spray03"] = {
        ["Index"] = "spray03",
        ["Name"] = "Desodorante 48hrs",
        ["Description"] = "Desodorante, produto de higiene pessoal",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["spray04"] = {
        ["Index"] = "spray04",
        ["Name"] = "Desodorante 72hrs",
        ["Description"] = "Desodorante, produto de higiene pessoal",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["dices"] = {
        ["Index"] = "dices",
        ["Name"] = "Dados",
        ["Description"] = "Dado, item feito para jogos",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 45
    },
    ["dish"] = {
        ["Index"] = "dish",
        ["Name"] = "Prato",
        ["Description"] = "Prato, item de cozinha para fazer suas refeições",
        ["Type"] = "Comum",
        ["Weight"] = 0.55,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["pan"] = {
        ["Index"] = "pan",
        ["Name"] = "Panela",
        ["Description"] = "Panela, item de cozinha para fazer alimentos",
        ["Type"] = "Usável",
        ["Weight"] = 0.55,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100
    },
    ["fan"] = {
        ["Index"] = "fan",
        ["Name"] = "Ventilador",
        ["Description"] = "Ventilador",
        ["Type"] = "Comum",
        ["Weight"] = 1.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["rimel"] = {
        ["Index"] = "rimel",
        ["Name"] = "Rímel",
        ["Description"] = "Item de maquiagem",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["blender"] = {
        ["Index"] = "blender",
        ["Name"] = "Liquidificador",
        ["Description"] = "Liquidificador, item sem função",
        ["Type"] = "Usável",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["switch"] = {
        ["Index"] = "switch",
        ["Name"] = "Interruptor",
        ["Description"] = "Interruptor de tomara, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 45
    },
    ["horseshoe"] = {
        ["Index"] = "horseshoe",
        ["Name"] = "Ferradura",
        ["Description"] = "Ferradura, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.45,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["brush"] = {
        ["Index"] = "brush",
        ["Name"] = "Escova",
        ["Description"] = "Escova de cabeço",
        ["Type"] = "Comum",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["domino"] = {
        ["Index"] = "domino",
        ["Name"] = "Dominó",
        ["Description"] = "Item de jogo,item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 45
    },
    ["floppy"] = {
        ["Index"] = "floppy",
        ["Name"] = "Disquete",
        ["Description"] = "Item de informatica, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 45
    },
    ["cup"] = {
        ["Index"] = "cup",
        ["Name"] = "Cálice",
        ["Description"] = "Cálice, item sem função",
        ["Type"] = "Comum",
        ["Weight"] = 0.45,
        ["Class"] = "Utilitarios",
        ["Economy"] = 100
    },
    ["deck"] = {
        ["Index"] = "deck",
        ["Name"] = "Baralho",
        ["Description"] = "Item de jogo, baralho, carta, item sem função",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["eraser"] = {
        ["Index"] = "eraser",
        ["Name"] = "Apagador",
        ["Description"] = "Item escolar",
        ["Type"] = "Comum",
        ["Weight"] = 0.15,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["pliers"] = {
        ["Index"] = "pliers",
        ["Name"] = "Alicate",
        ["Description"] = "Ferramenta",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 55
    },
    ["lampshade"] = {
        ["Index"] = "lampshade",
        ["Name"] = "Abajur",
        ["Description"] = "Item de iluminação",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["soap"] = {
        ["Index"] = "soap",
        ["Name"] = "Sabonete",
        ["Description"] = "Item de banho",
        ["Type"] = "Usável",
        ["Weight"] = 0.25,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["slipper"] = {
        ["Index"] = "slipper",
        ["Name"] = "Chinelo",
        ["Description"] = "Item de calçado",
        ["Type"] = "Comum",
        ["Weight"] = 0.35,
        ["Class"] = "Utilitarios",
        ["Economy"] = 75
    },
    ["pendrive"] = {
        ["Index"] = "pendrive",
        ["Name"] = "Pendrive",
        ["Description"] = "Para efeturar roubo de lojinhas",
        ["Repair"] = "repairkit01",
        ["Type"] = "Comum",
        ["Weight"] = 0.75,
        ["Class"] = "Utilitarios",
        ["Economy"] = 325
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemBody(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] then
		return List[Item]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function itemIndex(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Index"] then
		return List[Item]["Index"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function itemName(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Name"] then
		return List[Item]["Name"]
	end

	return "Deletado"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemType(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Type"] then
		return List[Item]["Type"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMCLASS
-----------------------------------------------------------------------------------------------------------------------------------------
function itemClass(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Class"] then
		return List[Item]["Class"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMO
-----------------------------------------------------------------------------------------------------------------------------------------
function itemAmmo(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Ammo"] then
		return List[Item]["Ammo"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemVehicle(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Vehicle"] then
		return List[Item]["Vehicle"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemWeight(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Weight"] then
		return List[Item]["Weight"]
	end

	return 0.0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMMAXAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemMaxAmount(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Max"] then
		return List[Item]["Max"]
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCRIPTION
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDescription(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Description"] then
		return List[Item]["Description"]
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDurability(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Durability"] then
		return List[Item]["Durability"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMCHARGES
-----------------------------------------------------------------------------------------------------------------------------------------
function itemCharges(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Charges"] then
		return List[Item]["Charges"]
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMECONOMY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemEconomy(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Economy"] then
		return List[Item]["Economy"]
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
function itemBlock(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Block"] then
		return List[Item]["Block"]
	end

	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMREPAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function itemRepair(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Repair"] then
		return List[Item]["Repair"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM LIST
-----------------------------------------------------------------------------------------------------------------------------------------
function itemList()
    return List
end
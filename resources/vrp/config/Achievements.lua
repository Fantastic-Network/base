AchievementsGroups = {
    [1] = "PVP",
    [2] = "ROLEPLAY",
    [3] = "VISITAS",
    [4] = "EVENTOS",
}

Achievements = {
    { 
        GroupID = 2, -- NUMERO DO GRUPO EM ORDE DOS AchievementsGroups
        Group = "ROLEPLAY", -- NOME DO GRUPO EM ORDE DOS AchievementsGroups
        Name = "Começando com o pé direito", -- NOME UNICO
        Description = "Fale com todos os NPCs do pier", -- DESCRICAO DOS ACHIEVEMENTS
        Rewards = {
            -- { type = "Vehicle", name = "panto", amount = 1 }, -- RECOMPENSA 
        },
        Title = "Pé direito", -- TITULO QUE VAI RECEBER
        Progress = 5,-- PROGRESSO SAO OS PASSOS 1-2-3 MAXIMOS PARA RECEBER O REWARD
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Primeiro milhão",
        Description = "Conquiste seu primeiro milhão no banco.",
        Rewards = {
            { type = "Item", name = "dollars", amount = 100000 },
        },
        Title = "Rico", -- TITULO QUE VAI RECEBER
        Progress = 1,-- PROGRESSO SAO OS PASSOS 1-2-3 MAXIMOS PARA RECEBER O REWARD
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Fome de poder",
        Description = "Conquiste 100 milhões no banco",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        Title = "Magnata", -- TITULO QUE VAI RECEBER
        Progress = 1,-- PROGRESSO SAO OS PASSOS 1-2-3 MAXIMOS PARA RECEBER O REWARD
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Clube do Bilhão",
        Description = "Consiga um bilhão no banco",
        Rewards = {
            { type = "Item", name = "dollars", amount = 5000000 },
        },
        Title = "Bilionário", -- TITULO QUE VAI RECEBER
        Progress = 1,-- PROGRESSO SAO OS PASSOS 1-2-3 MAXIMOS PARA RECEBER O REWARD
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Carteira assinada",
        Description = "Seja contratado!",
        Rewards = {
            { type = "Item", name = "dollars", amount = 1 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Deixando de ser desabrigado",
        Description = "Compre uma casa",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Deixando de andar a pé",
        Description = "Compre um carro",
        Rewards = {
            { type = "Item", name = "dollars", amount = 60000 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Adquirindo recursos",
        Description = "Tenha 10 carros na garagem",
        Rewards = {
            { type = "Item", name = "dollars", amount = 140000 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Iniciandro a frota",
        Description = "Tenha 50 carros na garagem",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    { -- DONE
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "GearHead",
        Description = "Tenha pelo menos 100 carros na garagem",
        Rewards = {
            { type = "Item", name = "dollars", amount = 3000000 },
        },
        -- SEM TITULO
        Title = "GearHead", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    { -- DONE
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Colecionador",
        Description = "Tenha pelo menos 200 carros na garagem",
        Rewards = {
            { type = "Item", name = "dollars", amount = 9000000 },
        },
        -- SEM TITULO
        Title = "Colecionador", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "O fim é triste...",
        Description = "Morra pela primeira vez",
        Rewards = {
            { type = "Item", name = "dollars", amount = 10000 },
        },
        -- SEM TITULO
        Title = "Eu vou.. mas volto!", -- TITULO QUE VAI RECEBER
        Progress = 5,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Compre sua primeira moto",
        Description = "Compre uma moto na concessionária",
        Rewards = {
            { type = "Item", name = "dollars", amount = 15000 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Compre sua primeira aeronave",
        Description = "Compre uma aeronave em alguma loja.",
        Rewards = {
            { type = "Item", name = "dollars", amount = 100000 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Bem relacionado",
        Description = "Consiga um parceiro(a)",
        Rewards = {
            { type = "Item", name = "dollars", amount = 100 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Bons costumes",
        Description = "Dê um like em alguém.",
        Rewards = {
            { type = "Item", name = "dollars", amount = 100 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Sendo querido pelos demais",
        Description = "Receba um like de alguém.",
        Rewards = {
            { type = "Item", name = "dollars", amount = 100 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Amigo da vizinhança",
        Description = "Consiga 500 likes",
        Rewards = {
            { type = "Item", name = "dollars", amount = 100 },
        },
        -- SEM TITULO
        Progress = 1,
    },
    {
        GroupID = 2,
        Group = "ROLEPLAY",
        Name = "Miss Simpatia",
        Description = "Consiga 1000 likes",
        Rewards = {
            { type = "Item", name = "dollars", amount = 100 },
        },
        -- SEM TITULO
        Title = "Miss Simpatia", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 1,
        Group = "PVP",
        Name = "Ninguém tá puro",
        Description = "Elimine 10 adversarios sem morrer",
        Rewards = {},
        Title = "Perigoso", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 1,
        Group = "PVP",
        Name = "Ninguém tá puro 2.0",
        Description = "Elimine 20 adversarios sem morrer",
        Rewards = {},
        Title = "Lenda", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 1,
        Group = "PVP",
        Name = "Perigo iminente",
        Description = "Equipe uma arma",
        Rewards = {},
        -- Title = "Perigoso", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 1,
        Group = "PVP",
        Name = "PvPlayer?",
        Description = "Elimine pelo menos 1000 adversários",
        Rewards = {},
        Title = "PvPas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 1,
        Group = "PVP",
        Name = "PvPlayer? 2.0",
        Description = "Elimine pelo menos 10000 adversários",
        Rewards = {},
        Title = "DuByPass", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "O começo de tudo!",
        Description = "Complete 12 horas jogadas",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Lado bom da força", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Engajando!",
        Description = "Complete 24 horas jogadas",
        Rewards = {
            { type = "Item", name = "dollars", amount = 100000 },
        },
        -- Title = "Lado bom da força", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Resolvi ficar!",
        Description = "Complete 72 horas jogadas",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Lado bom da força", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Já conheço tudo!",
        Description = "Complete 170 horas jogadas",
        Rewards = {},
        Title = "⏱️ 170 Horas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Parece casa de mãe!",
        Description = "Complete 720 horas jogadas",
        Rewards = {},
        Title = "⏱️ 720 Horas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Aqui é minha casa!",
        Description = "Complete 1500 horas jogadas",
        Rewards = {},
        Title = "⏱️ 1500 Horas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Inderrubável",
        Description = "Jogue por 30 minutos sem deslogar",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Lado bom da força", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Fechamento",
        Description = "Faça 10 sessões de 30 minutos sem deslogar.",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Lado bom da força", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "01 carro de luxo",
        Description = "Faça 30 sessões de 30 minutos sem deslogar.",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Lado bom da força", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Receba!",
        Description = "Faça 100 sessões de 30 minutos sem deslogar.",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Lado bom da força", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 3,
        Group = "VISITAS",
        Name = "Hospital",
        Description = "Visite o HP",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Salva-vidas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 3,
        Group = "VISITAS",
        Name = "Mecanica",
        Description = "Visite a Mecanica",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Salva-vidas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 3,
        Group = "VISITAS",
        Name = "Departamento Policial",
        Description = "Visite a DP",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Salva-vidas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 3,
        Group = "VISITAS",
        Name = "Mt. Chilliad",
        Description = "Visite o Monte Chilliad",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Salva-vidas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 3,
        Group = "VISITAS",
        Name = "Cayo Perico",
        Description = "Visite a ilha de Cayo Perico",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Salva-vidas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 3,
        Group = "VISITAS",
        Name = "Pier do Norte",
        Description = "Visite o Pier do Norte",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Salva-vidas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 3,
        Group = "VISITAS",
        Name = "Aeroporto",
        Description = "Visite o Aeroporto",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Salva-vidas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 3,
        Group = "VISITAS",
        Name = "Esgotos",
        Description = "Explore o esgoto da cidade.",
        Rewards = {
            { type = "Item", name = "dollars", amount = 50000 },
        },
        -- Title = "Salva-vidas", -- TITULO QUE VAI RECEBER
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Algorithms & Code",
        Description = "Abuser",
        Rewards = {},
        Title = "Ex_Machina", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 4,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "The Matrix",
        Description = "Participou ativamente da montagem da S5",
        Rewards = {},
        Title = "The Architect", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Os seus problemas",
        Description = "Isso é viver",
        Rewards = {},
        Title = "Hakuna Matata", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Brainstorming",
        Description = "Esse cara realmente dá boas ideias",
        Rewards = {},
        Title = "Genio", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Trial Phase",
        Description = "Participaram ativamente da fase de testes S4",
        Rewards = {},
        Title = "Rato de Laboratório", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "01 de uma facção",
        Description = "Seja o dono de uma facção",
        Rewards = {},
        Title = "👑 Bigode Grosso", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Cliente Especial Season 04",
        Description = "Entre em contato com seu vendedor favorito",
        Rewards = {},
        Title = "👑 Conta Larga", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Velhos tempos",
        Description = "Players que estão conosco desde a S1 ~ S2",
        Rewards = {},
        Title = "🦈 Respeita Minha História", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 1,
    },
    {
        GroupID = 4,
        Group = "EVENTOS",
        Name = "Vencedor BaseCUP",
        Description = "Ganhe o BaseCup",
        Rewards = {},
        Title = "👑 We are the Champions", -- TITULO PRECISA SER SETADO E REMOVIDO POR COMANDO
        Progress = 1,
    },
}

function GetAchievements()
    return Achievements,AchievementsGroups
end
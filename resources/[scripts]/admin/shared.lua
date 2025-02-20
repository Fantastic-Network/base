cityName = GetConvar("cityName", "Base")
banConfig = {
    ["ADV"] = {
        ["Heading"] = "ADVERTIR USUARIO",
        ["Button"] = "ADVERTIR",
        ["Info"] = {
            { name = "Selecione uma opção", value = "1", fine = 5000 },
            { name = "Loteando fora de ação", value = "120", fine = 5000 },
            { name = "Forçar RP", value = "120", fine = 5000 },
            { name = "Anti RP", value = "120", fine = 5000 },
            { name = "Ação sem identificação de facção", value = "120", fine = 5000 },
            { name = "RDM", value = "250", fine = 5000 },
            { name = "Toxico c Iniciante", value = "250", fine = 5000 },
            { name = "VDM", value = "250", fine = 5000 },
            { name = "Anti amor a vida", value = "250", fine = 5000 },
            { name = "Power Gaming", value = "250", fine = 5000 },
            { name = "Combat Loggin", value = "600", fine = 5000 },
            { name = "Meta Gaming", value = "600", fine = 5000 },
            { name = "Cop Bait ", value = "600", fine = 5000 },
            { name = "Revenge Kill ", value = "600", fine = 5000 },
            { name = "Voltar para ação", value = "600", fine = 5000 },
            { name = "Abuso de BUG", value = "600", fine = 5000 },
        },

    },
    ["BAN"] = {
        ["Heading"] = "BANIR USUARIO",
        ["Button"] = "BANIR",
        ["Info"] = {
            { name = "Selecione uma opção", value = "1" },
            { name = "Zaralho", value = "99999" },
            { name = "Desrespeito Cidade/Staff", value = "99999" },
            { name = "Prog Ilícitos/Negou Telagem", value = "99999" },
            { name = "Dark RP", value = "99999" },
            { name = "Hacker", value = "99999" },
        }
    }
}

if cityName == "Base" then
    banConfig["ADV"]["Info"] = {
        { name = "Selecione uma opção", value = "1", fine = 5000 },
        { name = "Nivel 1", value = "150", fine = 5000 },
        { name = "Nivel 2", value = "300", fine = 5000 },
        { name = "Nivel 3", value = "600", fine = 5000 },
        { name = "RDM", value = "250", fine = 5000 },
        { name = "VDM", value = "250", fine = 5000 },
        { name = "CL", value = "600", fine = 5000 },
        { name = "Puxar ação sem realiza-la", value = "100", fine = 5000 },
        { name = "Abuso de bug", value = "1000", fine = 5000 },
    }
end
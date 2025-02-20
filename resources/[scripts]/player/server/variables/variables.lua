cityName = GetConvar("cityName", "Base")

Variables = {
    ["Dicas"] = {
        ["Base"] = false,
    },
    ["Ranking-Facs"] = {
        ["Base"] = false,
    },
    ["RecruitmentLow"] = {
        ["Base"] = false,
    },
    ["Premios"] = {
        ["Base"] = false,
    },
    ["AssaultHourDisable"] = {
        ["Base"] = true,
    },
    ["ChatScale"] = {
        ["Base"] = 0.90,
    },
    ["Dismantle"] = {
        ["Base"] = 0.9,
    },
    ["AllRevive"] = {
        ["Base"] = false,
    },
    ["DriveBy"] = {
        ["Base"] = false,
    },
    ["newbieConfig"] = {
        ["Base"] = 20,
    },
    ["newbieTimer"] = {
        ["Base"] = 60*1,
    },
    ["HasBucket"] = {
        ["Base"] = true,
    },
    ["RemoveAirDrop"] = {
        ["Base"] = true,
    },
    ["DeathTimer"] = {
        ["Base"] = 150,
    },
    ["NewbieRanking"] = {
        ["Base"] = false,
    },
    ["Hud"] = {
        ["Base"] = "base",
    },
    ["Hunger"] = {
        ["Base"] = false,
    },
    ["NoVehicleDamage"] = {
        ["Base"] = true,
    },
    ["NoFallDamage"] = {
        ["Base"] = false,
    },
    ["AutoDomination"] = {
        ["Base"] = false,
    },
    ["RecruitmentCommand"] = {
        ["Base"] = true,
    },
    ["BlockMultiSpawn"] = {
        ["Base"] = true,
    },
}

for variable, table in pairs(Variables) do
    if table[cityName] then
        GlobalState[variable] = table[cityName]
    else
        GlobalState[variable] = table[cityName] or false
    end
    if not GlobalState["DeathTimer"] then
        GlobalState["DeathTimer"] = 150
    end
end
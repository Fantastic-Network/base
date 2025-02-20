Groups = {
	["Admin"] = {
		["Service"] = {},
		["Type"] = "Staff",
		["Parent"] = {
			["Admin"] = true
		},
        ["Salary"] = { 0,0,60000,40000,25000 },
		["Hierarchy"] = { "DEV","Responsavel","Administrador","Moderador","Suporte" },
        ["Color"] = 1,
	},
	["Comercial"] = {
		["Service"] = {},
        ["Type"] = "Comercial",
		["Parent"] = {
			["Comercial"] = true
		}
	},
	["Abuser"] = {
		["Service"] = {},
        ["Type"] = "Abuser",
		["Parent"] = {
			["Abuser"] = true
		}
	},
	["Acoes"] = {
		["Service"] = {},
        ["Type"] = "Acoes",
		["Parent"] = {
			["Acoes"] = true
		}
	},
	["SS"] = {
		["Service"] = {},
        ["Type"] = "SS",
		["Parent"] = {
			["SS"] = true
		}
	},
	["Helper"] = {
		["Service"] = {},
        ["Type"] = "Helper",
		["Parent"] = {
			["Helper"] = true
		}
	},
	["Ilegal"] = {
		["Service"] = {},
        ["Type"] = "Ilegal",
		["Parent"] = {
			["Ilegal"] = true
		}
	},
	["Eventos"] = {
		["Service"] = {},
        ["Type"] = "Eventos",
		["Parent"] = {
			["Eventos"] = true
		}
	},
    ["Wallg"] = {
		["Service"] = {},
        ["Type"] = "Wallg",
		["Parent"] = {
			["Wallg"] = true
		}
	},
	["Wall"] = {
		["Service"] = {},
        ["Type"] = "Wall",
		["Parent"] = {
			["Wall"] = true
		}
	},
	["Base"] = {
		["Service"] = {},
        ["Type"] = "Base",
		["Parent"] = {
			["Base"] = true
		}
	},
	["TESTE1"] = {
		["Service"] = {},
		["Parent"] = {
			["TESTE1"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 12,
        ["Color"] = 22
	},
	["TESTE2"] = {
		["Service"] = {},
		["Parent"] = {
			["TESTE2"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 12,
        ["Color"] = 22
	},
	["QA"] = {
		["Service"] = {},
		["Type"] = "Staff QA",
		["Parent"] = {
			["QA"] = true
		},
		["Hierarchy"] = { "QA" },
        ["Color"] = 1,
	},
    ["Tutor"] = {
		["Service"] = {},
		["Type"] = "Staff",
		["Parent"] = {
			["Tutor"] = true
		},
		["Hierarchy"] = { "Tutor","Tutor","Tutor","Tutor","Tutor" },
        ["Color"] = 3,
	},
	["Aliado"] = {
		["Service"] = {},
		["Type"] = "Staff",
		["Parent"] = {
			["Aliado"] = true
		},
		["Hierarchy"] = { "1","2","3","4","5" },
        ["Id"] = 6,
        ["Color"] = 1,
	},
	["InfluenciadorVerificado"] = {
		["Service"] = {},
		["Type"] = "Staff",
		["Parent"] = {
			["InfluenciadorVerificado"] = true
		},
		["Hierarchy"] = { "1","2","3","4","5" },
        ["Id"] = 6,
        ["Color"] = 1,
	},
	["Influencer"] = {
		["Service"] = {},
		["Type"] = "Staff",
		["Parent"] = {
			["Influencer"] = true
		},
		["Hierarchy"] = { "1","2","3","4","5" },
        ["Id"] = 6,
        ["Color"] = 1,
	},
	["Influ"] = {
		["Service"] = {},
        ["Type"] = "Staff",
		["Parent"] = {
			["Influ"] = true
		}
	},
	["Influenciador"] = {
		["Service"] = {},
		["Parent"] = {
			["Influenciador"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Id"] = 7,
        ["Color"] = 1,
	},
	["Policia"] = {
		["Service"] = {},
		["Parent"] = {
			["Policia"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
		["Salary"] = { 70000,60000,40000,35000,30000	},
		["Type"] = "Job",
        ["Group"] = "Policia",
        ["Achievement"] = 7,
        ["Id"] = 8,
        ["Color"] = 3,
	},
	["Bombeiros"] = {
		["Service"] = {},
		["Parent"] = {
			["Bombeiros"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
		["Salary"] = { 70000,60000,40000,35000,30000	},
		["Type"] = "Job",
        ["Group"] = "Bombeiros",
        ["Achievement"] = 7,
        ["Id"] = 8,
        ["Color"] = 3,
	},
	["Mechanic"] = {
		["Service"] = {},
		["Parent"] = {
			["Mechanic"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
		["Salary"] = { 20000,18000,16000,14000,12000 },
		["Type"] = "Job",
		["Group"] = "Mechanic",
        ["Achievement"] = 8,
        ["Id"] = 9,
        ["Color"] = 47,
	},
	["Paramedic"] = {
		["Service"] = {},
		["Parent"] = {
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
		["Salary"] = { 45000,35000,30000,25000,22000 },
		["Type"] = "Job",
        ["Achievement"] = 9,
        ["Id"] = 10,
        ["Color"] = 15,
	},
	["Juridico"] = {
		["Service"] = {},
		["Parent"] = {
			["Juridico"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
		["Salary"] = { 20000,16000,12000,10000,8000 },
		["Type"] = "Job",
        ["Id"] = 11,
        ["Color"] = 52,
	},
    ["ClienteBlack"] = {
		["Service"] = {},
		["Parent"] = {
			["ClienteBlack"] = true
		},
		["Type"] = "Client"
	},
    ["ClienteEspecial"] = {
		["Service"] = {},
		["Parent"] = {
			["ClienteEspecial"] = true
		},
		["Type"] = "Client"
	},
	["Black"] = {
		["Service"] = {},
		["Parent"] = {
			["Black"] = true
		},
		["Hierarchy"] = { "Black" },
		["Salary"] = { 100000 },
        ["Weight"] = 90,
		["Type"] = "VIP"
	},
	["VipLancamento"] = {
		["Service"] = {},
		["Parent"] = {
			["VipLancamento"] = true
		},
		["Hierarchy"] = { "VipLancamento" },
		["Salary"] = { 70000 },
        ["Weight"] = 89,
		["Type"] = "VIP"
	},
	["Ouro"] = {
		["Service"] = {},
		["Parent"] = {
			["Ouro"] = true
		},
		["Hierarchy"] = { "Ouro" },
		["Salary"] = { 60000 },
        ["Weight"] = 88,
		["Type"] = "VIP"
	},
	["VipSorteio"] = {
		["Service"] = {},
		["Parent"] = {
			["VipSorteio"] = true
		},
		["Hierarchy"] = { "VipSorteio" },
		["Salary"] = { 25000 },
        ["Weight"] = 87,
		["Type"] = "VIP"
	},
    ["Prata"] = {
		["Service"] = {},
		["Parent"] = {
			["Prata"] = true
		},
		["Hierarchy"] = { "Prata" },
		["Salary"] = { 40000 },
        ["Weight"] = 86,
		["Type"] = "VIP"
	},
    ["Bronze"] = {
		["Service"] = {},
		["Parent"] = {
			["Bronze"] = true
		},
		["Hierarchy"] = { "Bronze" },
		["Salary"] = { 25000 },
        ["Weight"] = 85,
		["Type"] = "VIP"
	},
	["Premium"] = {
		["Service"] = {},
		["Parent"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Diamante","Policia","Ouro","Prata","Bronze" },
		["Salary"] = { 50000,20000,20000,15000,7000 },
		["Type"] = "Premium"
	},
	["Blacks"] = {
		["Service"] = {},
		["Parent"] = {
			["Blacks"] = true
		},
		["Hierarchy"] = { "Esmeralda","Rubi" },
		["Salary"] = { 150000,100000 },
		["Type"] = "Premium"
	},
	["Lancamento"] = {
		["Service"] = {},
		["Parent"] = {
			["Lancamento"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 40000 },
		["Type"] = "Premium"
	},
	["kitiniciante"] = {
		["Service"] = {},
		["Parent"] = {
			["kitiniciante"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 5000 },
		["Type"] = "Premium"
	},
	["Spotify"] = {
		["Service"] = {},
		["Parent"] = {
			["Spotify"] = true
		},
		["Hierarchy"] = { "Dono" }
	},
	["Especial"] = {
		["Service"] = {},
		["Parent"] = {
			["Especial"] = true
		},
		["Hierarchy"] = { "Dono" }
	},
	["Roupas2"] = {
		["Service"] = {},
		["Parent"] = {
			["Roupas2"] = true
		},
		["Hierarchy"] = { "Dono" }
	},
	["Putaria"] = {
		["Service"] = {},
		["Parent"] = {
			["Putaria"] = true
		},
		["Hierarchy"] = { "Putifero" }
	},
	["Natal"] = {
		["Service"] = {},
		["Parent"] = {
			["Natal"] = true
		},
		["Hierarchy"] = { "1","2","3","4","5" },
		["Salary"] = { 70000,30000,25000,20050,15000 },
		["Type"] = "Salary"
	},



	["SalarioIniciante"] = {
		["Service"] = {},
		["Parent"] = {
			["SalarioIniciante"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 5000 },
		["Type"] = "Salary"
	},
	["SalarioMediano"] = {
		["Service"] = {},
		["Parent"] = {
			["SalarioMediano"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 10000 },
		["Type"] = "Salary"
	},
	["SalarioAvançado"] = {
		["Service"] = {},
		["Parent"] = {
			["SalarioAvançado"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 20000 },
		["Type"] = "Salary"
	},
	["SalarioBrabo"] = {
		["Service"] = {},
		["Parent"] = {
			["SalarioBrabo"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 30000 },
		["Type"] = "Salary"
	},
	["BolsaFamilia"] = {
		["Service"] = {},
		["Parent"] = {
			["BolsaFamilia"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 1000 },
		["Type"] = "Salary"
	},
	["Diamante"] = {
		["Service"] = {},
		["Parent"] = {
			["Diamante"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 50000 },
		["Type"] = "Salary"
	},
	["Platina"] = {
		["Service"] = {},
		["Parent"] = {
			["Platina"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 80000 },
		["Type"] = "Salary"
	},
	["SalarioDosDeuses"] = {
		["Service"] = {},
		["Parent"] = {
			["SalarioDosDeuses"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 200000 },
		["Type"] = "Salary"
	},

	["Rubi"] = {
		["Service"] = {},
		["Parent"] = {
			["Rubi"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 100000 },
		["Type"] = "Salary"
	},
	["Esmeralda"] = {
		["Service"] = {},
		["Parent"] = {
			["Esmeralda"] = true
		},
		["Hierarchy"] = { "1" },
		["Salary"] = { 150000 },
		["Type"] = "Salary"
	},
----------------------------------------------------------------------------------------------------------
--Drogas:
----------------------------------------------------------------------------------------------------------
	["Barragem"] = {
		["Service"] = {},
		["Parent"] = {
			["Barragem"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 12,
        ["Color"] = 22
	},
	["Cartel"] = {
		["Service"] = {},
		["Parent"] = {
			["Cartel"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 13,
        ["Color"] = 22
	},
	["Sindicato"] = {
		["Service"] = {},
		["Parent"] = {
			["Sindicato"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 14,
        ["Color"] = 22
	},
	["Vagos"] = {
		["Service"] = {},
		["Parent"] = {
			["Vagos"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 15,
        ["Color"] = 22
	},
	["Umbrella"] = {
		["Service"] = {},
		["Parent"] = {
			["Umbrella"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 16,
        ["Color"] = 22
	},
	
	["LosAztecas"] = {
		["Service"] = {},
		["Parent"] = {
			["LosAztecas"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 17,
        ["Color"] = 22
	},
	["Vermelhos"] = {
		["Service"] = {},
		["Parent"] = {
			["Vermelhos"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 18,
        ["Color"] = 22
	},
	["Amarelos"] = {
		["Service"] = {},
		["Parent"] = {
			["Amarelos"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 19,
        ["Color"] = 22
	},
	["AlcateiaHsT"] = {
		["Service"] = {},
		["Parent"] = {
			["AlcateiaHsT"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 19,
        ["Color"] = 22
	},
	["Verdes"] = {
		["Service"] = {},
		["Parent"] = {
			["Verdes"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 20,
        ["Color"] = 22
	},
	["Roxos"] = {
		["Service"] = {},
		["Parent"] = {
			["Roxos"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 21,
        ["Color"] = 22
	},
	["Laranjas"] = {
		["Service"] = {},
		["Parent"] = {
			["Laranjas"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 22,
        ["Color"] = 22
	},
	["Brancos"] = {
		["Service"] = {},
		["Parent"] = {
			["Brancos"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 23,
        ["Color"] = 22
	},
	
	["Rosas"] = {
		["Service"] = {},
		["Parent"] = {
			["Rosas"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 26,
        ["Color"] = 22
	},
----------------------------------------------------------------------------------------------------------
--Lavagem:
----------------------------------------------------------------------------------------------------------
    ["Ballas"] = {
		["Service"] = {},
        ["Parent"] = {
            ["Ballas"] = true
        },
		["Salary"] = { 0,0,0,0,0 },
        ["Hierarchy"] = { "Chefe","Sub-Chefe", "Novato", "Novato", "Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 27,
        ["Color"] = 22
    },
	["Bellagio"] = {
		["Service"] = {},
		["Parent"] = {
			["Bellagio"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 28,
        ["Color"] = 22
	},
	["Bahamas"] = {
		["Service"] = {},
		["Parent"] = {
			["Bahamas"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 31,
        ["Color"] = 22
	},
	["Palazzo"] = {
		["Service"] = {},
		["Parent"] = {
			["Palazzo"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 32,
        ["Color"] = 22
	},
	["Luxor"] = {
		["Service"] = {},
		["Parent"] = {
			["Luxor"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 33,
        ["Color"] = 22
	},
----------------------------------------------------------------------------------------------------------
--Desmanche:
----------------------------------------------------------------------------------------------------------
	["Groove"] = {
		["Service"] = {},
		["Parent"] = {
			["Groove"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 34,
        ["Color"] = 22
	},
	["TopGear"] = {
		["Service"] = {},
		["Parent"] = {
			["TopGear"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 35,
        ["Color"] = 22
	},
	["Redline"] = {
		["Service"] = {},
		["Parent"] = {
			["Redline"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 36,
        ["Color"] = 22
	},
	["Bennys"] = {
		["Service"] = {},
		["Parent"] = {
			["Bennys"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 37,
        ["Color"] = 22
	},
	["DriftKing"] = {
		["Service"] = {},
		["Parent"] = {
			["DriftKing"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 38,
        ["Color"] = 22
	},
	["Forza"] = {
		["Service"] = {},
		["Parent"] = {
			["Forza"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 39,
        ["Color"] = 22
	},
	["Overdrive"] = {
		["Service"] = {},
		["Parent"] = {
			["Overdrive"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 40,
        ["Color"] = 22
	},
----------------------------------------------------------------------------------------------------------
--Munição:
----------------------------------------------------------------------------------------------------------
	["Tropadu7"] = {
		["Service"] = {},
		["Parent"] = {
			["Tropadu7"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 41,
        ["Color"] = 22
	},
	["Crips"] = {
		["Service"] = {},
		["Parent"] = {
			["Crips"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 41,
        ["Color"] = 22
	},
	["Outlaws"] = {
		["Service"] = {},
		["Parent"] = {
			["Outlaws"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 42,
        ["Color"] = 22
	},
	["SonsofAnarchy"] = {
		["Service"] = {},
		["Parent"] = {
			["SonsofAnarchy"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 43,
        ["Color"] = 22
	},
	["Azuis"] = {
		["Service"] = {},
		["Parent"] = {
			["Azuis"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 17,
        ["Color"] = 22
	},
	["Marrons"] = {
		["Service"] = {},
		["Parent"] = {
			["Marrons"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 24,
        ["Color"] = 22
	},
	["Cinzas"] = {
		["Service"] = {},
		["Parent"] = {
			["Cinzas"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 25,
        ["Color"] = 22
	},
	["Sinaloa"] = {
		["Service"] = {},
		["Parent"] = {
			["Sinaloa"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 61,
        ["Color"] = 22
	},
	["HellsAngels"] = {
		["Service"] = {},
		["Parent"] = {
			["HellsAngels"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 44,
        ["Color"] = 22
	},
	["Triade"] = {
		["Service"] = {},
		["Parent"] = {
			["Triade"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 45,
        ["Color"] = 22
	},
	["Yakuza"] = {
		["Service"] = {},
		["Parent"] = {
			["Yakuza"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 46,
        ["Color"] = 22
	},
	["Warlocks"] = {
		["Service"] = {},
		["Parent"] = {
			["Warlocks"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 47,
        ["Color"] = 22
	},
----------------------------------------------------------------------------------------------------------
--Armas:
----------------------------------------------------------------------------------------------------------
	["Bloods"] = {
		["Service"] = {},
		["Parent"] = {
			["Bloods"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 48,
        ["Color"] = 22
	},
	["Mercenarios"] = {
		["Service"] = {},
		["Parent"] = {
			["Mercenarios"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 60,
        ["Color"] = 22
	},
	["Bopegg"] = {
		["Service"] = {},
		["Parent"] = {
			["Bopegg"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 60,
        ["Color"] = 22
	},
	["LaMafia"] = {
		["Service"] = {},
		["Parent"] = {
			["LaMafia"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 60,
        ["Color"] = 22
	},
	["Gringa"] = {
		["Service"] = {},
		["Parent"] = {
			["Gringa"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 49,
        ["Color"] = 22
	},
	["Franca"] = {
		["Service"] = {},
		["Parent"] = {
			["Franca"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 50,
        ["Color"] = 22
	},
	["Italia"] = {
		["Service"] = {},
		["Parent"] = {
			["Italia"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 51,
        ["Color"] = 22
	},
	["Russia"] = {
		["Service"] = {},
		["Parent"] = {
			["Russia"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 52,
        ["Color"] = 22
	},
	["Israel"] = {
		["Service"] = {},
		["Parent"] = {
			["Israel"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 53,
        ["Color"] = 22
	},
	["Playboy"] = {
		["Service"] = {},
		["Parent"] = {
			["Playboy"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 54,
        ["Color"] = 22
	},
	["Mexico"] = {
		["Service"] = {},
		["Parent"] = {
			["Mexico"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 55,
        ["Color"] = 22
	},
	["China"] = {
		["Service"] = {},
		["Parent"] = {
			["China"] = true
		},
		["Salary"] = { 0,0,0,0,0 },
		["Hierarchy"] = { "Chefe","Sub-Chefe","Supervisor","Membro","Novato" },
        ["Type"] = "Job",
        ["Achievement"] = 10,
        ["Id"] = 56,
        ["Color"] = 22
	},
    ["Ilegal"] = {
		["Service"] = {},
        ["Type"] = "Ilegal",
		["Parent"] = {
            ["Barragem"] = true,
            ["Cartel"] = true,
            ["Sindicato"] = true,
            ["Vagos"] = true,
            ["Umbrella"] = true,
            ["LosAztecas"] = true,
            ["Vermelhos"] = true,
            ["Amarelos"] = true,
			["AlcateiaHsT"] = true,
            ["Verdes"] = true,
            ["Roxos"] = true,
            ["Laranjas"] = true,
            ["Brancos"] = true,
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
		}
	},
-------------------------------------------------------------------------------------------------------------------------------------
-- noticia
-------------------------------------------------------------------------------------------------------------------------------------
	["Noticia"] = {
		["Service"] = {},
		["Parent"] = {
			["Noticia"] = true
		}
	},
-------------------------------------------------------------------------------------------------------------------------------------
-- garagem vip
-------------------------------------------------------------------------------------------------------------------------------------
	["garagempanamera"] = {
		["Service"] = {},
		["Parent"] = {
			["garagempanamera"] = true
		}
	},

-------------------------------------------------------------------------------------------------------------------------------------
-- Mansão
-------------------------------------------------------------------------------------------------------------------------------------

	["Mansao01"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao01"] = true
		}
	},
	["Mansao02"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao02"] = true
		}
	},
	["Mansao03"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao03"] = true
		}
	},
	["Mansao04"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao04"] = true
		}
	},
	["Mansao05"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao05"] = true
		}
	},
	["Mansao06"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao06"] = true
		}
	},
	["Mansao07"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao07"] = true
		}
	},
	["Mansao08"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao08"] = true
		}
	},
	["Mansao09"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao09"] = true
		}
	},
	["Mansao10"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao10"] = true
		}
	},
	["Mansao11"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao11"] = true
		}
	},
	["Mansao12"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao12"] = true
		}
	},
	["Mansao13"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao13"] = true
		}
	},
	["Mansao14"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao14"] = true
		}
	},
	["Mansao15"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao15"] = true
		}
	},
	["Mansao16"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao16"] = true
		}
	},
	["Mansao17"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao17"] = true
		}
	},
	["Mansao18"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao18"] = true
		}
	},
	["Mansao19"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao19"] = true
		}
	},
	["Mansao20"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao20"] = true
		}
	},
	["Mansao21"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao21"] = true
		}
	},
	["Mansao22"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao22"] = true
		}
	},
	["Mansao23"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao23"] = true
		}
	},
	["Mansao24"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao24"] = true
		}
	},
	["Mansao25"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao25"] = true
		}
	},
	["Mansao26"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao26"] = true
		}
	},
	["Mansao27"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao27"] = true
		}
	},
	["Mansao28"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao28"] = true
		}
	},
	["Mansao29"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao29"] = true
		}
	},
	["Mansao30"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao30"] = true
		}
	},
	["Mansao31"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao31"] = true
		}
	},
	["Mansao32"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao32"] = true
		}
	},
	["Mansao33"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao33"] = true
		}
	},
	["Mansao34"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao34"] = true
		}
	},
	["Mansao35"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao35"] = true
		}
	},

	["Mansao36"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao36"] = true
		}
	},
	["Mansao37"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao37"] = true
		}
	},
	["Mansao38"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao38"] = true
		}
	},
	["Mansao39"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao39"] = true
		}
	},
	["Mansao40"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao40"] = true
		}
	},
	["Mansao41"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao41"] = true
		}
	},
	["Mansao42"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao42"] = true
		}
	},
	["Mansao43"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao43"] = true
		}
	},
	["Mansao44"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao44"] = true
		}
	},
	["Mansao45"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao45"] = true
		}
	},
	["Mansao46"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao46"] = true
		}
	},
	["Mansao47"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao47"] = true
		}
	},
	["Mansao48"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao48"] = true
		}
	},
	["Mansao49"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao49"] = true
		}
	},
	["Mansao50"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao50"] = true
		}
	},
	["Mansao51"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao51"] = true
		}
	},
	["Mansao52"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao52"] = true
		}
	},
	["Mansao53"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao53"] = true
		}
	},
	["Mansao54"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao54"] = true
		}
	},
	["Mansao55"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao55"] = true
		}
	},
	["Mansao56"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao56"] = true
		}
	},
	["Mansao57"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Mansao57"] = true
		}
	},
	["Bloco01"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Bloco01"] = true
		}
	},
	["Bloco02"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Bloco02"] = true
		}
	},
	["Bloco03"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Bloco03"] = true
		}
	},
	["Bloco04"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Bloco04"] = true
		}
	},
	["Bloco05"] = {
		["Service"] = {},
        ["Type"] = "Mansao",
		["Parent"] = {
			["Bloco05"] = true
		}
	},
	["Iate01"] = {
		["Service"] = {},
		["Type"] = "Mansao",
		["Parent"] = {
			["Iate01"] = true
		}
	},
	["Iate02"] = {
		["Service"] = {},
		["Type"] = "Mansao",
		["Parent"] = {
			["Iate02"] = true
		}
	},
	["Verificado"] = {
		["Service"] = {},
		["Parent"] = {
			["Verificado"] = true
		}
	},
	-- ["Ilha01"] = {
	-- 	["Service"] = {},
	-- 	["Parent"] = {
	-- 		["Ilha01"] = true
	-- 	}
	-- },
	-- ["Ilha02"] = {
	-- 	["Service"] = {},
	-- 	["Parent"] = {
	-- 		["Ilha02"] = true
	-- 	}
	-- },
	["Festeiro"] = {
		["Service"] = {},
		["Parent"] = {
			["Festeiro"] = true
		}
	},
-------------------------------------------------------------------------------------------------------------------------------------
-- NOTHIERARCHY
-------------------------------------------------------------------------------------------------------------------------------------
	["Emergency"] = {
		["Service"] = {},
		["Parent"] = {
			["Policia"] = true,
			["Paramedic"] = true
		}
	},
	["Laundry"] = {
		["Service"] = {},
		["Parent"] = {
			["Ballas"] = true,
			["Luxor"] = true,
			["Bellagio"] = true,
			["Bahamas"] = true
		}
	},
	["Dismantle"] = {
		["Service"] = {},
		["Parent"] = {
			["Groove"] = true,
			["Overdrive"] = true,
			["Bennys"] = true,
			["DriftKing"] = true,
			["TopGear"] = true,
			["Outlaws"] = true,
			["Redline"] = true
		}
	},
	["Ammogroup"] = {
		["Service"] = {},
		["Parent"] = {
			["Crips"] = true,
			["Tropadu7"] = true,
			["SonsofAnarchy"] = true,
			["Sinaloa"] = true,
			["HellsAngels"] = true,
			["Cinzas"] = true,
			["Marrons"] = true,
			["Azuis"] = true,
			["Warlocks"] = true,
			["Triade"] = true,
			["Yakuza"] = true
		}
	},
	["Iniciante"] = {
		["Service"] = {},
		["Parent"] = {
			["Iniciante"] = true
		},
		["Type"] = "Job",
        ["Id"] = 57,
        ["Color"] = 2
	},
	["Desempregado"] = {
		["Service"] = {},
		["Parent"] = {
			["Desempregado"] = true
		},
		["Type"] = "Job",
        ["Id"] = 58,
        ["Color"] = 28
	}
}

local Vips = {
    ["Premium"] = true,
    ["Blacks"] = true
}

function GetGroups()
    return Groups
end

local GroupBlips = {
    ["DEV"] = 1,
    ["Responsavel"] = 2,
    ["Administrador"] = 3,
    ["Moderador"] = 4,
    ["Suporte"] = 5
}

local BlipsGroup = {
    [1] = "DEV",
    [2] = "Responsavel",
    [3] = "Administrador",
    [4] = "Moderador",
    [5] = "Suporte",
}

local BlipsColor = {
    [1] = 1,
    [2] = 1,
    [3] = 1,
    [4] = 1,
    [5] = 1,
}

CreateThread(function()
    for Name,Info in pairs(Groups) do
        if Info["Id"] then
            GroupBlips[Name] = Info["Id"]
            BlipsGroup[Info["Id"]] = Name
            BlipsColor[Info["Id"]] = Info["Color"]
        end
    end
end)

VIPRanks = {
    ["Black"] = 1,
    ["VipLancamento"] = 2,
    ["Ouro"] = 3,
    ["Prata"] = 4,
    ["Bronze"] = 5
}

VIPEmotes = {
    "🔝","🏖️","🥇","🥈","🥉","🌟",
}

function GetVIPRank(Table)
    local Result = 100
    for Group,_ in pairs(Table) do
        if VIPRanks[Group] and VIPRanks[Group] < Result then
            Result = VIPRanks[Group]
        end
    end
    if VIPEmotes[Result] then
        return VIPEmotes[Result]
    end
end

function GetGroupsBlips()
    return GroupBlips
end

function GetBlipsGroups()
    return BlipsGroup
end

function GetGroupBlip(Group)
    if not GroupBlips[Group] then return end
    return GroupBlips[Group]
end

function GetBlipColor(Blip)
    if not BlipsColor[Blip] then return end
    return BlipsColor[Blip]
end

function GetBlipGroup(Blip)
    if not BlipsGroup[Blip] then return end
    return BlipsGroup[Blip]
end

function GetVips()
    return Vips
end

return Groups
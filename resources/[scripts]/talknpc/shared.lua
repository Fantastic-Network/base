Key = "E" -- [E] Key to open the interaction, check here the keys ID: https://docs.fivem.net/docs/game-references/controls/#controls

AutoCamPosition = true -- If true it'll set the camera position automatically

AutoCamRotation = true -- If true it'll set the camera rotation automatically

HideMinimap = true -- If true it'll hide the minimap when interacting with an NPC

UseOkokTextUI = true -- If true it'll use okokTextUI

CameraAnimationTime = 1000 -- Camera animation time: 1000 = 1 second -1276.14,-296.96,36.04,164.41
local cityName = GetConvar("cityName", "f")
local links = {
	["Base"] = "SEU LINK AQUI",
}

TalkToNPC = {}

HairOverlays = {
    Male = {
        [0] = { collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
        [1] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_001" },
        [2] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_002" },
        [3] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_003" },
        [4] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_004" },
        [5] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_005" },
        [6] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_006" },
        [7] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_007" },
        [8] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_008" },
        [9] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_009" },
        [10] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_010" },
        [11] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_011" },
        [12] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_012" },
        [13] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_013" },
        [14] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_014" },
        [15] = { collection = "multiplayer_overlays", overlay = "NG_M_Hair_015" },
        [16] = { collection = "multiplayer_overlays", overlay = "NGBea_M_Hair_000" },
        [17] = { collection = "multiplayer_overlays", overlay = "NGBea_M_Hair_001" },
        [18] = { collection = "multiplayer_overlays", overlay = "NGBus_M_Hair_000" },
        [19] = { collection = "multiplayer_overlays", overlay = "NGBus_M_Hair_001" },
        [20] = { collection = "multiplayer_overlays", overlay = "NGHip_M_Hair_000" },
        [21] = { collection = "multiplayer_overlays", overlay = "NGHip_M_Hair_001" },
        [22] = { collection = "multiplayer_overlays", overlay = "NGInd_M_Hair_000" },
        [23] = { collection = "mplowrider_overlays", overlay = "LR_M_Hair_000" },
        [24] = { collection = "mplowrider_overlays", overlay = "LR_M_Hair_001" },
        [25] = { collection = "mplowrider_overlays", overlay = "LR_M_Hair_002" },
        [26] = { collection = "mplowrider_overlays", overlay = "LR_M_Hair_003" },
        [27] = { collection = "mplowrider2_overlays", overlay = "LR_M_Hair_004" },
        [28] = { collection = "mplowrider2_overlays", overlay = "LR_M_Hair_005" },
        [29] = { collection = "mplowrider2_overlays", overlay = "LR_M_Hair_006" },
        [30] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_000_M" },
        [31] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_001_M" },
        [32] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_002_M" },
        [33] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_003_M" },
        [34] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_004_M" },
        [35] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_005_M" },
        [36] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_006_M" },
        [37] = { collection = "mpgunrunning_overlays", overlay = "MP_Gunrunning_Hair_M_000_M"},
        [38] = { collection = "mpgunrunning_overlays", overlay = "MP_Gunrunning_Hair_M_001_M"}
    },
    Female = {
        [0] = { collection = "mpbeach_overlays", overlay = "FM_Hair_Fuzz" },
        [1] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_001" },
        [2] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_002" },
        [3] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_003" },
        [4] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_004" },
        [5] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_005" },
        [6] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_006" },
        [7] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_007" },
        [8] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_008" },
        [9] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_009" },
        [10] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_010" },
        [11] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_011" },
        [12] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_012" },
        [13] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_013" },
        [14] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_014" },
        [15] = { collection = "multiplayer_overlays", overlay = "NG_F_Hair_015" },
        [16] = { collection = "multiplayer_overlays", overlay = "NGBea_F_Hair_000" },
        [17] = { collection = "multiplayer_overlays", overlay = "NGBea_F_Hair_001" },
        [18] = { collection = "multiplayer_overlays", overlay = "NGBus_F_Hair_000" },
        [19] = { collection = "multiplayer_overlays", overlay = "NGBus_F_Hair_001" },
        [20] = { collection = "multiplayer_overlays", overlay = "NGHip_F_Hair_000" },
        [21] = { collection = "multiplayer_overlays", overlay = "NGHip_F_Hair_001" },
        [22] = { collection = "multiplayer_overlays", overlay = "NGInd_F_Hair_000" },
        [23] = { collection = "mplowrider_overlays", overlay = "LR_F_Hair_000" },
        [24] = { collection = "mplowrider_overlays", overlay = "LR_F_Hair_001" },
        [25] = { collection = "mplowrider_overlays", overlay = "LR_F_Hair_002" },
        [26] = { collection = "mplowrider2_overlays", overlay = "LR_F_Hair_003" },
        [27] = { collection = "mplowrider2_overlays", overlay = "LR_F_Hair_004" },
        [28] = { collection = "mplowrider2_overlays", overlay = "LR_F_Hair_005" },
        [29] = { collection = "mplowrider2_overlays", overlay = "LR_F_Hair_006" },
        [30] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_000_F" },
        [31] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_001_F" },
        [32] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_002_F" },
        [33] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_003_F" },
        [34] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_004_F" },
        [35] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_005_F" },
        [36] = { collection = "mpbiker_overlays", overlay = "MP_Biker_Hair_006_F" },
        [37] = { collection = "mpgunrunning_overlays", overlay = "MP_Gunrunning_Hair_F_000_F"},
        [38] = { collection = "mpgunrunning_overlays", overlay = "MP_Gunrunning_Hair_F_001_F"}
    }
}

if cityName == "Base" then
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-61.89,-1218.25,28.7),
		heading = 269.3,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"},
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'false',
		}
		-- TalkToNPC[#TalkToNPC+1] = {
		-- 	npc = 'g_m_m_chicold_01',
		-- 	header = 'Eu desenrolo qualquer item que você<span>quiser.</span>',
		-- 	name = '',
		-- 	uiText = "",
		-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		-- 	coordinates = vector3(45.95,3703.11,39.75),
		-- 	heading = 343.0,
		-- 	camOffset = vector3(0.0, 0.0, 0.0),
		-- 	camRotation = vector3(0.0, 0.0, 0.0),
		-- 	interactionRange = 2.5,
		-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		-- 	options = {
		-- 		-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
		-- 		{'Comprar itens',"shops:openSystem:NPC","BuyDirty"}, -- Close NUI
		-- 		{'Vender itens',"shops:openSystem:NPC","SellDirty"},
		-- 	},
		-- 	video = {
		-- 		{''}, -- 
		-- 		{''}, -- 
		-- 		{''},
		-- 		{''},
		-- 	},
		-- 	duration = {
		-- 		{''},
		-- 		{''},
		-- 		{'3000'},
		-- 		{'3000'},
		-- 	},
		-- 	play = 'false',
		-- }
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(218.09,-1391.38,30.58),
		heading = 328.82,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"},
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1695.32,-287.06,51.88),
		heading = 141.74,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"},
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_f_y_hippie_01',
		header = 'Eu sou a <span>Mana</span>',
		name = 'Tattoo Shop',
		uiText = "",
		dialog = 'E te ajudo a ficar no estilo!',				-- locução
		coordinates = vector3(-1619.74,-1090.83,13.09),
		heading = 90.71,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 1.5,
		initAudio = { audio = 'manatatoo', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'Explicação sobre tatuagens',"tattoo:Init"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir a loja de tatuagens',"tattooshop:Open:NPC",vector4(-1621.99,-1091.86,13.09,328.82)}, -- Close NUI
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'ig_jimmydisanto',
		header = '',
		name = 'Barber Shop',
		uiText = "",
		dialog = '',				-- locução
		coordinates = vector3(-1623.9,-1097.32,13.11),
		heading = 14.18,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 1.5,
		initAudio = { audio = 'barbershop', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'Explicação sobre barbearia!',"barber:Init"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir barbearia!',"barbershop:Open:NPC","barber"}, -- Close NUI
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_f_y_epsilon_01',
		header = 'Eu sou a <span>Carol</span>',
		name = 'Loja de Roupas',
		uiText = "",
		dialog = 'E te ajudo a ficar bem vestido!',				-- locução
		coordinates = vector3(-1629.56,-1101.04,13.09),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 1.5,
		initAudio = { audio = 'carolroupas', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Explicação sobre a loja de roupas!',"skinshop:Init"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"skinshop:Open:NPC",vector4(-1628.83,-1099.29,13.08,138.9)}, -- Close NUI
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'u_m_y_baygor',
		header = 'Eu sou o <span>Zézin</span>',
		name = 'Farmácia',
		uiText = "",
		dialog = 'E te ajudo a se manter com saúde!',				-- locução
		coordinates = vector3(-1602.85,-1072.07,13.11),
		heading = 56.7,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'zezufarmacia', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'O que encontro na farmácia?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"shops:openSystem:NPC","Pharmacy"}, -- Close NUI
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{'3000'},
			{''},
			{''},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_m_m_hasjew_01',
		header = 'Eu sou o <span>Mafil</span>',
		name = 'Concessionária',
		uiText = "",
		dialog = 'E te ajudo a escolher seu veículo!',				-- locução
		coordinates = vector3(-1598.61,-1067.2,13.11),
		heading = 53.86,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'mafilconce', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'O que encontro na concessionária?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir Loja',"tablet:Open","shop"}, -- Close NUI
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'u_m_m_jewelsec_01',
		header = 'Eu sou o <span>Skorpion</span>',
		name = 'Prefeitura',
		uiText = "",
		dialog = 'E vou te ajudar a melhorar sua estádia na cidade!',				-- locução
		coordinates = vector3(-1595.06,-1062.15,13.11),
		heading = 48.19,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'skorpionprefeitura', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'O que encontro na prefeitura?',"stockade:Init"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir o Feedback',"callfeedback:Open:NPC"}, -- Close NUI
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-204.84,-287.34,26.45),
		heading = 102.05,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1071.02,-2003.61,30.9),
		heading = 325.99,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-284.75,238.36,78.82),
		heading = 96.38,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1425.16,1399.07,108.68),
		heading = 274.97,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2834.42,2807.02,57.39),
		heading = 90.71,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(310.38,-2037.19,20.67),
		heading = 323.15,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1091.89,3260.0,37.79),
		heading = 133.23,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2249.32,162.39,219.11),
		heading = 201.26,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1884.33,463.93,171.06),
		heading = 11.34,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2127.57,3877.73,33.23),
		heading = 31.19,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1031.85,-234.54,39.01),
		heading = 28.35,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(115.65,-1956.01,20.84),
		heading = 119.06,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(872.08,-79.45,78.76),
		heading = 328.82,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(161.54,-1307.39,29.35),
		heading = 337.33,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1387.03,-2079.13,52.6),
		heading = 221.11,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(102.22,1210.55,207.17),
		heading = 286.3,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1029.72,-2509.99,28.29),
		heading = 172.92,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	-- {
	-- 	npc = 'g_m_importexport_01',
	-- 	header = 'Eu sou o <span>Pai das Rotas</span>',
	-- 	name = '',
	-- 	uiText = "",
	-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
	-- 	coordinates = vector3(-652.52,-1213.04,11.02),
	-- 	heading = 303.31,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
	-- 		{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
	-- 	},
	-- 	video = {
	--         {''}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
	--         {''},
	--     	{''},
	--     	{'3000'},
	--     	{'3000'},
	--     },
	-- 	play = 'false',
	-- },
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(559.57,-2797.8,6.08),
		heading = 238.12,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(354.84,-2713.05,1.7),
		heading = 62.37,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1572.97,-401.18,48.06),
		heading = 48.19,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(423.12,-1506.11,29.32),
		heading = 209.77,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1903.41,2071.06,140.85),
		heading = 232.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(108.39,3609.1,40.51),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1504.77,837.38,181.59),
		heading = 25.52,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(3106.9,5078.17,22.63),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	
	
	
	
	
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1380.65,-633.66,30.31),
		heading = 119.06,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	
	
	
	
	
	
	
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1272.56,-291.77,80.91),
		heading = 8.51,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"},
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1495.35,1428.7,103.2),
		heading = 274.97,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2663.32,2742.04,39.36),
		heading = 107.72,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(332.56,-2013.17,22.39),
		heading = 235.28,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2211.01,121.52,228.75),
		heading = 56.7,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1854.91,417.45,166.63),
		heading = 340.16,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2191.28,3993.88,34.41),
		heading = 289.14,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1048.28,-237.99,44.01),
		heading = 116.23,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{''},
			{''},
			{'3000'},
			{'3000'},
		},
		play = 'true',
	}
	-- {
	-- 	npc = 'g_m_importexport_01',
	-- 	header = 'Eu sou o <span>Pai das DELIVERY</span>',
	-- 	name = '',
	-- 	uiText = "",
	-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
	-- 	coordinates = vector3(s),
	-- 	heading = 317.49,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		{'Rota Sul',"deliver:Starting","Drugsmansouth"},
	-- 		{'Rota Norte',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
	-- 		{'Rota Norte',"deliver:Starting","Drugsmannorth"},
	-- 	},
	-- 	video = {
	--         {''}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
	--         {''},
	--     	{''},
	--     	{'3000'},
	--     	{'3000'},
	--     },
	-- 	play = 'false',
	-- },
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_m_m_hillbilly_01',
		header = 'Eu sou o <span>Tommy, o Leiteiro</span>',
		name = 'Loja de Departamentos',
		uiText = "",
		dialog = 'Oh sô, bora tirar um leitinho direto da fonte?',				-- locução
		coordinates = vector3(2515.56,4763.37,34.76),
		heading = 314.65,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'leiteiro', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"shops:openSystem:NPC","Milker2"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Milker"},
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{'3000'},
			{''},
			{''},
			{''},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'cs_old_man2',
		header = 'Eu sou o <span>Sorjão, o Agricultor</span>',
		name = 'Agricultor',
		uiText = "",
		dialog = 'Tamo expandindo cada vez mais, começamos com sojas e já tem várias plantações!',				-- locução
		coordinates = vector3(749.07,6454.5,31.95),
		heading = 53.86,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'agricultor', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Separar Graos',"farmer:SeparateAll","SERVER"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Farmer3"},
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{'25000'},
			{''},
			{''},
			{''},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'cs_old_man2',
		header = 'Eu sou o <span>Sorjão, o Agricultor</span>',
		name = 'Agricultor',
		uiText = "",
		dialog = 'Tamo expandindo cada vez mais, começamos com sojas e já tem várias plantações!',				-- locução
		coordinates = vector3(2091.46,5042.01,41.16),
		heading = 226.78,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'agricultor', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			-- {'Separar Graos',"farmer:SeparateAll","SERVER"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Farmer"},
		},
		video = {
			{''}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{'25000'},
			{''},
			{''},
			{''},
		},
		play = 'true',
	}
	-- {
	-- 	npc = 's_m_m_gardener_01',
	-- 	header = 'Eu sou o <span>Peroba, o Lenhador</span>',
	-- 	name = 'Madeireiro',
	-- 	uiText = "",
	-- 	dialog = 'Tira os troncos, mas depois replanta as mudas!',				-- locução
	-- 	coordinates = vector3(2380.24,5094.35,47.35),
	-- 	heading = 96.38,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = 'lenhador', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		{'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
	-- 		{'Abrir loja',"shops:openSystem:NPC","Lumbers2"}, -- Close NUI
	-- 		{'Vender itens',"shops:openSystem:NPC","Lumbers"},
	-- 	},
	-- 	video = {
	-- 	    {'http://www.youtube.com/embed/NtEBnydL5lo?autoplay=1'}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
	--     	{'35000'},
	--     	{''},
	--     	{''},
	--     	{''},
	--     },
	-- 	play = 'true',
	-- },
	TalkToNPC[#TalkToNPC+1] = {
		npc = 's_m_y_construct_02',
		header = 'Eu sou o <span>Zinco, o Minerador</span>',
		name = 'Minerador',
		uiText = "",
		dialog = 'Estamos atrás de diamantes, mas até agora só esse seu sorriso que brilha aqui!',				-- locução
		coordinates = vector3(2957.12,2829.95,45.34),
		heading = 56.7,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'minerador', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"shops:openSystem:NPC","Miners2"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Miners"},
		},
		video = {
			{'http://www.youtube.com/embed/f5kkTEss-sQ?autoplay=1'}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{'44000'},
			{''},
			{''},
			{''},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_m_y_hippy_01',
		header = 'Eu sou o <span>Pedro, o Pescador.</span>',
		name = 'Pesqueiro',
		uiText = "",
		dialog = 'Semana passa pesquei um tubarão, quero ver cê pescar um também!',				-- locução
		coordinates = vector3(1340.1,4225.09,33.92),
		heading = 82.21,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'pescador', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"shops:openSystem:NPC","Fishing2"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Fishing"},
		},
		video = {
			{'http://www.youtube.com/embed/QIKdFT9PAxo?autoplay=1'}, -- 
			{''}, -- 
			{''},
			{''},
		},
		duration = {
			{'32000'},
			{''},
			{''},
			{''},
		},
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-61.89,-1218.25,28.7),
		heading = 269.3,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"},
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
		}
		-- TalkToNPC[#TalkToNPC+1] = {
		-- 	npc = 'g_m_m_chicold_01',
		-- 	header = 'Eu desenrolo qualquer item que você<span>quiser.</span>',
		-- 	name = '',
		-- 	uiText = "",
		-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		-- 	coordinates = vector3(45.95,3703.11,39.75),
		-- 	heading = 343.0,
		-- 	camOffset = vector3(0.0, 0.0, 0.0),
		-- 	camRotation = vector3(0.0, 0.0, 0.0),
		-- 	interactionRange = 2.5,
		-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		-- 	options = {
		-- 		-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
		-- 		{'Comprar itens',"shops:openSystem:NPC","BuyDirty"}, -- Close NUI
		-- 		{'Vender itens',"shops:openSystem:NPC","SellDirty"},
		-- 	},
		-- 	video = {
		--      {''}, -- 
		-- 		{''}, -- 
		-- 	    {''},
		-- 	    {''},
		-- 	},
		-- 	duration = {
		--         {''},
		--     	{''},
		--     	{'3000'},
		--     	{'3000'},
		--     },
		-- 	play = 'false',
		-- }
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(218.09,-1391.38,30.58),
		heading = 328.82,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"},
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1695.32,-287.06,51.88),
		heading = 141.74,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"},
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_f_y_hippie_01',
		header = 'Eu sou a <span>Mana</span>',
		name = 'Tattoo Shop',
		uiText = "",
		dialog = 'E te ajudo a ficar no estilo!',				-- locução
		coordinates = vector3(-1619.74,-1090.83,13.09),
		heading = 90.71,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 1.5,
		initAudio = { audio = 'manatatoo', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'Explicação sobre tatuagens',"tattoo:Init"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir a loja de tatuagens',"tattooshop:Open:NPC",vector4(-1621.99,-1091.86,13.09,328.82)}, -- Close NUI
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}

	TalkToNPC[#TalkToNPC+1] = {
		npc = 'ig_jimmydisanto',
		header = '',
		name = 'Barber Shop',
		uiText = "",
		dialog = '',				-- locução
		coordinates = vector3(-1623.9,-1097.32,13.11),
		heading = 14.18,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 1.5,
		initAudio = { audio = 'barbershop', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'Explicação sobre barbearia!',"barber:Init"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir barbearia!',"barbershop:Open:NPC","barber"}, -- Close NUI
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}

	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_f_y_epsilon_01',
		header = 'Eu sou a <span>Carol</span>',
		name = 'Loja de Roupas',
		uiText = "",
		dialog = 'E te ajudo a ficar bem vestido!',				-- locução
		coordinates = vector3(-1629.56,-1101.04,13.09),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 1.5,
		initAudio = { audio = 'carolroupas', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Explicação sobre a loja de roupas!',"skinshop:Init"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"skinshop:Open:NPC",vector4(-1628.83,-1099.29,13.08,138.9)}, -- Close NUI
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}

	TalkToNPC[#TalkToNPC+1] = {
		npc = 'u_m_y_baygor',
		header = 'Eu sou o <span>Zézin</span>',
		name = 'Farmácia',
		uiText = "",
		dialog = 'E te ajudo a se manter com saúde!',				-- locução
		coordinates = vector3(-1602.85,-1072.07,13.11),
		heading = 56.7,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'zezufarmacia', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'O que encontro na farmácia?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"shops:openSystem:NPC","Pharmacy"}, -- Close NUI
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{'3000'},
        	{''},
        	{''},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_m_m_hasjew_01',
		header = 'Eu sou o <span>Mafil</span>',
		name = 'Concessionária',
		uiText = "",
		dialog = 'E te ajudo a escolher seu veículo!',				-- locução
		coordinates = vector3(-1598.61,-1067.2,13.11),
		heading = 53.86,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'mafilconce', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'O que encontro na concessionária?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir Loja',"tablet:Open","shop"}, -- Close NUI
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}

	TalkToNPC[#TalkToNPC+1] = {
		npc = 'u_m_m_jewelsec_01',
		header = 'Eu sou o <span>Skorpion</span>',
		name = 'Prefeitura',
		uiText = "",
		dialog = 'E vou te ajudar a melhorar sua estádia na cidade!',				-- locução
		coordinates = vector3(-1595.06,-1062.15,13.11),
		heading = 48.19,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'skorpionprefeitura', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'O que encontro na prefeitura?',"stockade:Init"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir o Feedback',"callfeedback:Open:NPC"}, -- Close NUI
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-204.84,-287.34,26.45),
		heading = 102.05,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1071.02,-2003.61,30.9),
		heading = 325.99,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-284.75,238.36,78.82),
		heading = 96.38,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1425.16,1399.07,108.68),
		heading = 274.97,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2834.42,2807.02,57.39),
		heading = 90.71,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(310.38,-2037.19,20.67),
		heading = 323.15,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1091.89,3260.0,37.79),
		heading = 133.23,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2249.32,162.39,219.11),
		heading = 201.26,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1884.33,463.93,171.06),
		heading = 11.34,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2127.57,3877.73,33.23),
		heading = 31.19,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1031.85,-234.54,39.01),
		heading = 28.35,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(115.65,-1956.01,20.84),
		heading = 119.06,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(872.08,-79.45,78.76),
		heading = 328.82,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(161.54,-1307.39,29.35),
		heading = 337.33,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1387.03,-2079.13,52.6),
		heading = 221.11,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(102.22,1210.55,207.17),
		heading = 286.3,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1029.72,-2509.99,28.29),
		heading = 172.92,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	-- {
	-- 	npc = 'g_m_importexport_01',
	-- 	header = 'Eu sou o <span>Pai das Rotas</span>',
	-- 	name = '',
	-- 	uiText = "",
	-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
	-- 	coordinates = vector3(-652.52,-1213.04,11.02),
	-- 	heading = 303.31,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
	-- 		{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
	-- 	},
	-- 	video = {
    --         {''}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
    --         {''},
    --     	{''},
    --     	{'3000'},
    --     	{'3000'},
    --     },
	-- 	play = 'false',
	-- },
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(559.57,-2797.8,6.08),
		heading = 238.12,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(354.84,-2713.05,1.7),
		heading = 62.37,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1572.97,-401.18,48.06),
		heading = 48.19,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(423.12,-1506.11,29.32),
		heading = 209.77,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1903.41,2071.06,140.85),
		heading = 232.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(108.39,3609.1,40.51),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1504.77,837.38,181.59),
		heading = 25.52,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(3106.9,5078.17,22.63),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}





	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1380.65,-633.66,30.31),
		heading = 119.06,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	






	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1272.56,-291.77,80.91),
		heading = 8.51,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"},
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1495.35,1428.7,103.2),
		heading = 274.97,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2663.32,2742.04,39.36),
		heading = 107.72,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(332.56,-2013.17,22.39),
		heading = 235.28,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2211.01,121.52,228.75),
		heading = 56.7,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1854.91,417.45,166.63),
		heading = 340.16,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2191.28,3993.88,34.41),
		heading = 289.14,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1048.28,-237.99,44.01),
		heading = 116.23,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'true',
	}
	-- {
	-- 	npc = 'g_m_importexport_01',
	-- 	header = 'Eu sou o <span>Pai das DELIVERY</span>',
	-- 	name = '',
	-- 	uiText = "",
	-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
	-- 	coordinates = vector3(s),
	-- 	heading = 317.49,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		{'Rota Sul',"deliver:Starting","Drugsmansouth"},
	-- 		{'Rota Norte',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
	-- 		{'Rota Norte',"deliver:Starting","Drugsmannorth"},
	-- 	},
	-- 	video = {
    --         {''}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
    --         {''},
    --     	{''},
    --     	{'3000'},
    --     	{'3000'},
    --     },
	-- 	play = 'false',
	-- },
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'a_m_m_hillbilly_01',
		header = 'Eu sou o <span>Tommy, o Leiteiro</span>',
		name = 'Loja de Departamentos',
		uiText = "",
		dialog = 'Oh sô, bora tirar um leitinho direto da fonte?',				-- locução
		coordinates = vector3(2515.56,4763.37,34.76),
		heading = 314.65,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'leiteiro', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"shops:openSystem:NPC","Milker2"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Milker"},
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{'3000'},
        	{''},
        	{''},
        	{''},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'cs_old_man2',
		header = 'Eu sou o <span>Sorjão, o Agricultor</span>',
		name = 'Agricultor',
		uiText = "",
		dialog = 'Tamo expandindo cada vez mais, começamos com sojas e já tem várias plantações!',				-- locução
		coordinates = vector3(749.07,6454.5,31.95),
		heading = 53.86,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'agricultor', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Separar Graos',"farmer:SeparateAll","SERVER"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Farmer3"},
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{'25000'},
        	{''},
        	{''},
        	{''},
        },
		play = 'true',
	}
	TalkToNPC[#TalkToNPC+1] = {
		npc = 'cs_old_man2',
		header = 'Eu sou o <span>Sorjão, o Agricultor</span>',
		name = 'Agricultor',
		uiText = "",
		dialog = 'Tamo expandindo cada vez mais, começamos com sojas e já tem várias plantações!',				-- locução
		coordinates = vector3(2091.46,5042.01,41.16),
		heading = 226.78,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'agricultor', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			-- {'Separar Graos',"farmer:SeparateAll","SERVER"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Farmer"},
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{'25000'},
        	{''},
        	{''},
        	{''},
        },
		play = 'true',
	}
	-- {
	-- 	npc = 's_m_m_gardener_01',
	-- 	header = 'Eu sou o <span>Peroba, o Lenhador</span>',
	-- 	name = 'Madeireiro',
	-- 	uiText = "",
	-- 	dialog = 'Tira os troncos, mas depois replanta as mudas!',				-- locução
	-- 	coordinates = vector3(2380.24,5094.35,47.35),
	-- 	heading = 96.38,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = 'lenhador', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		{'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
	-- 		{'Abrir loja',"shops:openSystem:NPC","Lumbers2"}, -- Close NUI
	-- 		{'Vender itens',"shops:openSystem:NPC","Lumbers"},
	-- 	},
	-- 	video = {
	-- 	    {'http://www.youtube.com/embed/NtEBnydL5lo?autoplay=1'}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
    --     	{'35000'},
    --     	{''},
    --     	{''},
    --     	{''},
    --     },
	-- 	play = 'true',
	-- },
	TalkToNPC[#TalkToNPC+1] = {
		npc = 's_m_y_construct_02',
		header = 'Eu sou o <span>Zinco, o Minerador</span>',
		name = 'Minerador',
		uiText = "",
		dialog = 'Estamos atrás de diamantes, mas até agora só esse seu sorriso que brilha aqui!',				-- locução
		coordinates = vector3(2957.12,2829.95,45.34),
		heading = 56.7,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'minerador', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Como trabalho pra você?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"shops:openSystem:NPC","Miners2"}, -- Close NUI
			{'Vender itens',"shops:openSystem:NPC","Miners"},
		},
		video = {
		    {'http://www.youtube.com/embed/f5kkTEss-sQ?autoplay=1'}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{'44000'},
        	{''},
        	{''},
        	{''},
        },
		play = 'true',
	}
	-------- #########################################
	-- ###############################################
	-- #######
	TalkToNPC[#TalkToNPC+1] = { -- bopegg rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-2714.01,2408.1,1.38),
		heading = 320.32,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- LaMafia rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1545.24,103.97,56.78),
		heading = 45.36,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte [Armas]',"routes:NPCStart","North","Armas"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul [Armas]',"routes:NPCStart","South","Armas"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- LaMafia rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1537.64,126.12,56.78),
		heading = 48.19,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte [Armas]',"routes:NPCStart","North","Armas"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul [Armas]',"routes:NPCStart","South","Armas"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}

	TalkToNPC[#TalkToNPC+1] = { -- LaMafia rota [Metafetamina]
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1588.08,115.4,59.95),
		heading = 294.81,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte [Metafetamina]',"routes:NPCStart","North","Metafetamina"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul [Metafetamina]',"routes:NPCStart","South","Metafetamina"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- LaMafia rota [Metafetamina]
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1570.61,127.39,58.4),
		heading = 158.75,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte [Metafetamina]',"routes:NPCStart","North","Metafetamina"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul [Metafetamina]',"routes:NPCStart","South","Metafetamina"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Brancos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1333.2,-742.56,66.66),
		heading = 345.83,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	
	TalkToNPC[#TalkToNPC+1] = { -- Brancos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1312.16,-734.49,66.08),
		heading = 340.16,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Brancos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1392.53,-745.16,67.2),
		heading = 70.87,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Rosas rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1397.77,-2246.7,61.28),
		heading = 70.87,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Rosas rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1516.77,-2468.18,62.71),
		heading = 53.86,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Rosas rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1515.76,-2386.62,75.15),
		heading = 257.96,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Rosas rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1397.48,-2456.72,56.48),
		heading = 204.1,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- roxos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(480.65,397.96,142.73),
		heading = 113.39,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- roxos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(597.31,360.98,119.87),
		heading = 215.44,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- LosAztecas rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1181.97,-1742.45,37.61),
		heading = 306.15,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- playboy rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1460.61,86.41,54.78),
		heading = 45.36,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- SonsofAnarchy rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(199.65,1205.98,225.59),
		heading = 8.51,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- playboy rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1537.66,119.31,56.78),
		heading = 130.4,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- italia rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(507.88,-1492.83,29.28),
		heading = 184.26,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- israel rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(15.83,3719.58,39.65),
		heading = 221.11,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- HellsAngels rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-2955.48,61.65,11.61),
		heading = 153.08,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- mercenarios rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(975.46,305.94,69.54),
		heading = 206.93,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- sinaloa rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2448.48,5432.47,51.36),
		heading = 221.11,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- barragem rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1330.33,-122.54,117.8),
		heading = 246.62,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- sindicato rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2680.28,2761.69,37.88),
		heading = 303.31,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- cartel rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1479.66,1557.78,110.55),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- cartel rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1525.01,1358.46,97.85),
		heading = 303.31,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(287.5,-2069.97,17.69),
		heading = 113.39,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(366.62,-1988.78,24.2),
		heading = 345.83,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(389.73,-2023.08,23.2),
		heading = 62.37,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(413.2,-2075.23,21.35),
		heading = 51.03,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- umbrella rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1120.65,3511.98,35.79),
		heading = 87.88,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- bahamas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1462.54,-684.84,26.47),
		heading = 320.32,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- bahamas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1365.65,-672.1,25.88),
		heading = 311.82,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	-- TalkToNPC[#TalkToNPC+1] = { -- barragem rota de droga
	-- 	npc = 'g_m_importexport_01',
	-- 	header = 'Eu sou o <span>Pai das Rotas</span>',
	-- 	name = '',
	-- 	uiText = "",
	-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
	-- 	coordinates = vector3(1272.16,-213.36,99.57),
	-- 	heading = 269.3,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
	-- 		{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
	-- 	},
	-- 	video = {
    --         {''}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
    --         {''},
    --     	{''},
    --     	{'3000'},
    --     	{'3000'},
    --     },
	-- 	play = 'false',
	-- }
	TalkToNPC[#TalkToNPC+1] = { -- cartel rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1533.16,1347.21,97.43),
		heading = 308.98,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- cartel rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1466.18,1565.98,110.55),
		heading = 184.26,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- cartel rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1311.74,1416.59,100.95),
		heading = 2.84,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(289.1,-2075.01,17.62),
		heading = 110.56,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(370.19,-1990.07,24.2),
		heading = 345.83,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(391.34,-2019.74,23.34),
		heading = 68.04,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(413.73,-2080.31,21.26),
		heading = 136.07,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- sindicato rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2894.62,2723.57,71.73),
		heading = 303.31,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- umbrella rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1112.6,3515.36,37.64),
		heading = 181.42,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- brancos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1339.84,-716.16,67.38),
		heading = 164.41,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- brancos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1302.02,-730.32,64.7),
		heading = 343.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Azuis rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(540.04,2605.86,42.78),
		heading = 178.59,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Azuis rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(591.62,2433.05,58.74),
		heading = 76.54,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- roxos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(490.38,357.66,137.44),
		heading = 113.39,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- roxos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(572.99,347.89,123.63),
		heading = 212.6,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- cinzas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2169.93,3472.83,45.28),
		heading = 107.72,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- cinzas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2243.6,3342.41,47.4),
		heading = 68.04,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- cinzas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2305.84,3467.17,62.85),
		heading = 283.47,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- marrons rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(854.51,1088.27,295.68),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- marrons rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1021.92,932.5,219.0),
		heading = 184.26,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- rosas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1347.82,-2238.55,60.78),
		heading = 269.3,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- rosas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1458.03,-2228.84,62.02),
		heading = 82.21,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Azuis rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(452.51,2469.64,47.74),
		heading = 272.13,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- LosAztecas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1365.18,-1698.02,61.3),
		heading = 198.43,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- LosAztecas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1376.43,-1706.4,63.73),
		heading = 14.18,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
    TalkToNPC[#TalkToNPC+1] = { -- Luxor rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-337.14,207.31,88.56),
		heading = 340.16,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Verdes rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2388.52,4005.87,36.97),
		heading = 155.91,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	-- TalkToNPC[#TalkToNPC+1] = { -- Franca rota
	-- 	npc = 'g_m_importexport_01',
	-- 	header = 'Eu sou o <span>Pai das Rotas</span>',
	-- 	name = '',
	-- 	uiText = "",
	-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
	-- 	coordinates = vector3(-1800.58,407.94,113.45),
	-- 	heading = 266.46,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
	-- 		{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
	-- 	},
	-- 	video = {
    --         {''}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
    --         {''},
    --     	{''},
    --     	{'3000'},
    --     	{'3000'},
    --     },
	-- 	play = 'false',
	-- }
	TalkToNPC[#TalkToNPC+1] = { -- china rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(3078.15,5091.29,23.57),
		heading = 351.5,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Yakuza rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(598.75,-2738.45,6.08),
		heading = 340.16,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(307.3,-2002.02,20.86),
		heading = 229.61,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Cartel rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1311.74,1416.59,100.95),
		heading = 2.84,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Sindicato rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2597.83,2718.31,42.33),
		heading = 28.35,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- verdes rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2104.32,3867.13,33.16),
		heading = 25.52,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- umbrella rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(958.0,3233.99,38.43),
		heading = 195.6,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- amarelos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1919.5,590.35,176.37),
		heading = 243.78,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- amarelos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2282.1,185.65,208.52),
		heading = 232.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- TopGear rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(865.64,-2363.59,31.51),
		heading = 357.17,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Russia rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2161.4,5107.57,58.81),
		heading = 172.92,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Russia rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2154.98,5165.24,60.84),
		heading = 93.55,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Mexico rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1526.36,870.86,181.69),
		heading = 215.44,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Israel rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2516.37,4112.08,38.59),
		heading = 246.62,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- China rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(3258.39,5141.58,19.55),
		heading = 11.34,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	-- TalkToNPC[#TalkToNPC+1] = { -- frança rota
	-- 	npc = 'g_m_importexport_01',
	-- 	header = 'Eu sou o <span>Pai das Rotas</span>',
	-- 	name = '',
	-- 	uiText = "",
	-- 	dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
	-- 	coordinates = vector3(-1801.37,448.79,128.51),
	-- 	heading = 85.04,
	-- 	camOffset = vector3(0.0, 0.0, 0.0),
	-- 	camRotation = vector3(0.0, 0.0, 0.0),
	-- 	interactionRange = 2.5,
	-- 	initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
	-- 	options = {
	-- 		{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
	-- 		{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
	-- 	},
	-- 	video = {
    --         {''}, -- 
	-- 		{''}, -- 
	-- 	    {''},
	-- 	    {''},
	-- 	},
	-- 	duration = {
    --         {''},
    --     	{''},
    --     	{'3000'},
    --     	{'3000'},
    --     },
	-- 	play = 'false',
	-- }
	TalkToNPC[#TalkToNPC+1] = { -- Warlocks rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(296.51,-2804.0,6.02),
		heading = 87.88,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Italia rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(418.73,-1534.25,29.39),
		heading = 303.31,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Triade rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-285.15,1946.38,164.08),
		heading = 283.47,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Triade rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-313.68,2013.78,149.69),
		heading = 90.71,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- vagos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(331.17,-2017.54,21.97),
		heading = 136.07,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- cartel rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1315.17,1417.15,101.0),
		heading = 0.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- sindicato rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2604.11,2723.11,41.64),
		heading = 22.68,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- verdes rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2115.78,3867.34,33.21),
		heading = 28.35,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- umbrella rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(976.91,3227.57,38.28),
		heading = 5.67,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- amarelos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1915.85,582.52,176.37),
		heading = 243.78,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}

	TalkToNPC[#TalkToNPC+1] = { -- AlcateiaHsT rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1839.83,-1031.55,79.16),
		heading = 243.78,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- AlcateiaHsT rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1823.39,-1078.04,79.94),
		heading = 246.62,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- AlcateiaHsT rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1830.37,-1049.96,79.38),
		heading = 246.62,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- AlcateiaHsT rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1920.65,-996.38,79.33),
		heading = 51.03,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- AlcateiaHsT rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1899.58,-998.5,79.48),
		heading = 232.45,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}


	TalkToNPC[#TalkToNPC+1] = { -- vermelhos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2290.7,177.41,208.42),
		heading = 36.86,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Bahamas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1438.57,-653.76,28.8),
		heading = 300.48,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Bellagio rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(899.2,-0.73,78.91),
		heading = 328.82,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- ballas rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(109.42,-1920.8,20.84),
		heading = 240.95,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- brancos rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1248.57,-1582.49,54.54),
		heading = 300.48,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- laranjas rota de droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1568.45,-384.44,38.1),
		heading = 136.07,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- amarelos droga
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2346.28,5541.72,49.93),
		heading = 144.57,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			-- {'Rota Sul',"deliver:Starting","Drugsmansouth"},
			{'Iniciar Rota',"deliver:Starting","Drugsmannorth"}, -- TIPO DOS DELIVERY
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- amarelos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(2336.34,5539.63,49.91),
		heading = 257.96,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- bloods rota 2
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1562.22,-400.36,41.97),
		heading = 323.15,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- gringa 2
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1031.94,-1957.71,31.05),
		heading = 175.75,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- brancos rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1253.95,-1571.09,58.74),
		heading = 223.94,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- sinaloa rota
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(1833.57,401.77,166.66),
		heading = 343.0 ,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- laranjas
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-1567.0,-386.88,41.97),
		heading = 45.36,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- israel
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(503.7,-3121.95,9.79),
		heading = 5.67,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}

	TalkToNPC[#TalkToNPC+1] = { -- burguer
		npc = 'u_m_y_burgerdrug_01',
		header = 'Eu sou o <span>Montanha</span>',
		name = 'Burguer',
		uiText = "",
		dialog = 'E te ajudo a manter a alimentação em dia!',				-- locução
		coordinates = vector3(-1606.41,-1076.72,13.11),
		heading = 53.86,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = 'montanhacomida', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			--{'O que é o Burguer?'},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Abrir loja',"shops:openSystem:NPC","BurgerShot"}, -- Close NUI
		},
		video = {
		    {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
        	{''},
        	{''},
        	{''},
        	{'3000'},
        },
		play = 'false',
	}

	TalkToNPC[#TalkToNPC+1] = { -- triade
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-561.52,234.9,74.88),
		heading = 121.89,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- Tropadu7
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-410.83,1562.33,356.56),
		heading = 348.67,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- crips
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(165.18,662.23,207.34),
		heading = 343.0,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- crips
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(154.44,725.48,208.62),
		heading = 308.98,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}

	TalkToNPC[#TalkToNPC+1] = { -- bloods
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-2314.58,374.29,174.67),
		heading = 337.33,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- mercenarios
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-3045.86,173.54,11.61),
		heading = 104.89,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- yakuza
		npc = 'g_m_importexport_01',
		header = 'Eu sou o <span>Pai das Rotas</span>',
		name = '',
		uiText = "",
		dialog = 'Te ajudo a fortalecer sua familia!',				-- locução
		coordinates = vector3(-986.13,295.44,68.6),
		heading = 334.49,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
	TalkToNPC[#TalkToNPC+1] = { -- playboy
		npc = 's_m_y_prisoner_01',
		header = 'Eu sou o <span>Perigo</span>',
		name = 'Ilegal',
		uiText = "",
		dialog = 'E eu vou deixar sua estádia na cidade mais eletrizante!',				-- locução
		coordinates = vector3(-1536.36,329.62,87.25),
		heading = 59.53,
		camOffset = vector3(0.0, 0.0, 0.0),
		camRotation = vector3(0.0, 0.0, 0.0),
		interactionRange = 2.5,
		initAudio = { audio = '', volume = 0.5 }, -- LOCUÇÃO COPY
		options = {
			{'Rota Norte',"routes:NPCStart","North"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
			{'Rota Sul',"routes:NPCStart","South"},	-- SABIA QUE ALÉM DESSE HÁ OUTROS X SABORES? MAS CARA, VOU SER BEM SINCERO EU GOSTEI MUITO DESSE E NÃO TROCO POR NENHUM OUTRO. > DAR CHECK E IR FALAR COM NPC 4 > DAR 35K + 2 ENERGETICOS DE 1 HR
		
		},
		video = {
            {''}, -- 
			{''}, -- 
		    {''},
		    {''},
		},
		duration = {
            {''},
        	{''},
        	{'3000'},
        	{'3000'},
        },
		play = 'false',
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("crafting",Creative)
cityName = GetConvar("cityName", "Base")
BuffedGroups = {}
BuffedFarmGroups  = {}
--BuffedGroups["Group"] = 1.20
vKEYBOARD = Tunnel.getInterface("keyboard")
vRP.Prepare("painel/getBuffedGroups","SELECT name,buff,farm FROM painel")
vRP.Prepare("painel/setBuff","UPDATE painel SET buff = @buff WHERE name = @Group")
vRP.Prepare("painel/setFarm","UPDATE painel SET farm = @farm WHERE name = @Group")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["EconomyCraft"] = 1.0
local Crafting = {
	["Barragem"] = {
		["Level"] = 4,
		["Permission"] = "Barragem",
		["List"] = {
			["joint"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["silk"] = 10,
					["weedleaf"] = 10
				}
			}
		}
	},
	["Roxos"] = {
		["Level"] = 4,
		["Permission"] = "Roxos",
		["List"] = {
			["cocaine"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cokeleaf"] = 10,
					["sulfuric"] = 10
				}
			}
		}
	},
	["Rosas"] = {
		["Level"] = 4,
		["Permission"] = "Rosas",
		["List"] = {
			["cocaine"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cokeleaf"] = 10,
					["sulfuric"] = 10
				}
			}
		}
	},
	["LosAztecas"] = {
		["Level"] = 4,
		["Permission"] = "LosAztecas",
		["List"] = {
			["cocaine"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cokeleaf"] = 10,
					["sulfuric"] = 10
				}
			}
		}
	},
	["Cartel"] = {
		["Level"] = 4,
		["Permission"] = "Cartel",
		["List"] = {
			["joint"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["silk"] = 10,
					["weedleaf"] = 10
				}
			}
		}
	},
	["Sindicato"] = {
		["Level"] = 4,
		["Permission"] = "Sindicato",
		["List"] = {
			["joint"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["silk"] = 10,
					["weedleaf"] = 10
				}
			}
		}
	},
	["Vagos"] = {
		["Level"] = 4,
		["Permission"] = "Vagos",
		["List"] = {
			["meth"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["saline"] = 10,
					["acetone"] = 10
				}
			}
		}
	},
	["Umbrella"] = {
		["Level"] = 4,
		["Permission"] = "Umbrella",
		["List"] = {
			["meth"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["saline"] = 10,
					["acetone"] = 10
				}
			}
		}
	},
	["Vermelhos"] = {
		["Level"] = 4,
		["Permission"] = "Vermelhos",
		["List"] = {
			["cocaine"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cokeleaf"] = 10,
					["sulfuric"] = 10
				}
			}
		}
	},
	["Amarelos"] = {
		["Level"] = 4,
		["Permission"] = "Amarelos",0,
		["List"] = {
			["meth"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["saline"] = 10,
					["acetone"] = 10
				}
			}
		}
	},
	["AlcateiaHsT"] = {
		["Level"] = 4,
		["Permission"] = "AlcateiaHsT",0,
		["List"] = {
			["meth"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["saline"] = 10,
					["acetone"] = 10
				}
			}
		}
	},
	["Verdes"] = {
		["Level"] = 4,
		["Permission"] = "Verdes",
		["List"] = {
			["cocaine"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cokeleaf"] = 10,
					["sulfuric"] = 10
				}
			}
		}
	},
	["Laranjas"] = {
		["Level"] = 4,
		["Permission"] = "Laranjas",
		["List"] = {
			["joint"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["silk"] = 10,
					["weedleaf"] = 10
				}
			}
		}
	},
	["Brancos"] = {
		["Level"] = 4,
		["Permission"] = "Brancos",
		["List"] = {
			["cocaine"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cokeleaf"] = 10,
					["sulfuric"] = 10
				}
			}
		}
	},
	["Ballas"] = {
		["Level"] = 3,
		["Permission"] = "Ballas",
		["List"] = {
			["alvejantegrande"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["aguadestilada"] = 500,
					["cloro"] = 500,
				}
			},
			["dollars"] = {
				["Time"] = 0,
				["Amount"] = 900000,
				["Required"] = {
					["alvejantegrande"] = 1,
					["dinheirosujo"] = 1000000,
				}
			}
		}
	},
	["Bellagio"] = {
		["Level"] = 3,
		["Permission"] = "Bellagio",
		["List"] = {
			["alvejantegrande"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["aguadestilada"] = 500,
					["cloro"] = 500,
				}
			},
			["dollars"] = {
				["Time"] = 0,
				["Amount"] = 900000,
				["Required"] = {
					["alvejantegrande"] = 1,
					["dinheirosujo"] = 1000000,
				}
			}
		}
	},
	["Bahamas"] = {
		["Level"] = 3,
		["Permission"] = "Bahamas",
		["List"] = {
			["alvejantegrande"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["aguadestilada"] = 500,
					["cloro"] = 500,
				}
			},
			["dollars"] = {
				["Time"] = 0,
				["Amount"] = 900000,
				["Required"] = {
					["alvejantegrande"] = 1,
					["dinheirosujo"] = 1000000,
				}
			}
		}
	},
	["Luxor"] = {
		["Level"] = 3,
		["Permission"] = "Luxor",
		["List"] = {
			["alvejantegrande"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["aguadestilada"] = 500,
					["cloro"] = 500,
				}
			},
			["dollars"] = {
				["Time"] = 0,
				["Amount"] = 900000,
				["Required"] = {
					["alvejantegrande"] = 1,
					["dinheirosujo"] = 1000000,
				}
			}
		}
	},
	["Crips"] = {
		["Level"] = 3,
        ["Permission"] = "Crips",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Tropadu7"] = {
		["Level"] = 3,
        ["Permission"] = "Tropadu7",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["SonsofAnarchy"] = {
		["Level"] = 3,
        ["Permission"] = "SonsofAnarchy",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Azuis"] = {
		["Level"] = 3,
        ["Permission"] = "Azuis",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Marrons"] = {
		["Level"] = 3,
        ["Permission"] = "Marrons",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Cinzas"] = {
		["Level"] = 3,
        ["Permission"] = "Cinzas",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Sinaloa"] = {
		["Level"] = 3,
        ["Permission"] = "Sinaloa",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["HellsAngels"] = {
		["Level"] = 3,
        ["Permission"] = "HellsAngels",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Warlocks"] = {
		["Level"] = 3,
        ["Permission"] = "Warlocks",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Triade"] = {
		["Level"] = 3,
        ["Permission"] = "Triade",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Yakuza"] = {
		["Level"] = 3,
        ["Permission"] = "Yakuza",
        ["List"] = {
            ["WEAPON_PISTOL_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 100,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
            },
            ["WEAPON_SMG_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 150,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_SHOTGUN_AMMO"] = {
                ["Time"] = 0,
                ["Amount"] = 10,
                ["Required"] = {
                    ["capsula"] = 110,
                    ["polvora"] = 110
                }
			},
            ["WEAPON_RIFLE_AMMO"] = {
                    ["Time"] = 0,
                    ["Amount"] = 150,
                    ["Required"] = {
                        ["capsula"] = 110,
                        ["polvora"] = 110
                }
            },
			["WEAPON_SNIPER_AMMO"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["capsula"] = 65,
					["polvora"] = 65
				}
			}
        }
    },
	["Bloods"] = {
		["Level"] = 3,
		["Permission"] = "Bloods",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Mercenarios"] = {
		["Level"] = 3,
		["Permission"] = "Mercenarios",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Bopegg"] = {
		["Level"] = 3,
		["Permission"] = "Bopegg",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Gringa"] = {
		["Level"] = 3,
		["Permission"] = "Gringa",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Franca"] = {
		["Level"] = 3,
		["Permission"] = "Franca",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Italia"] = {
		["Level"] = 3,
		["Permission"] = "Italia",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Russia"] = {
		["Level"] = 3,
		["Permission"] = "Russia",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Israel"] = {
		["Level"] = 3,
		["Permission"] = "Israel",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Playboy"] = {
		["Level"] = 3,
		["Permission"] = "Playboy",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["Mexico"] = {
		["Level"] = 3,
		["Permission"] = "Mexico",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["China"] = {
		["Level"] = 3,
		["Permission"] = "China",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			}
		}
	},
	["UwuCoffee"] = {
		["List"] = {
			["nigirizushi"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["fishfillet"] = 1,
					["bread"] = 1
				}
			},
			["sushi"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["fishfillet"] = 1,
					["bread"] = 1
				}
			},
			["cupcake"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["chocolate"] = 1,
					["bread"] = 1,
					["milkbottle"] = 1
				}
			},
			["applelove"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["apple"] = 1,
					["sugar"] = 5,
					["water"] = 1
				}
			},
			["milkshake"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["chocolate"] = 2,
					["milkbottle"] = 2
				}
			},
			["cappuccino"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["chocolate"] = 2,
					["milkbottle"] = 2,
					["coffee2"] = 5
				}
			},
			["mushroomtea"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			}
		}
	},
	["PizzaThis"] = {
		["List"] = {
			["pizzamozzarella"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cheese"] = 1,
					["bread"] = 1,
					["ketchup"] = 1
				}
			},
			["pizzamushroom"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cheese"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["mushroom"] = 3
				}
			},
			["pizzabanana"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cheese"] = 1,
					["bread"] = 1,
					["banana"] = 6
				}
			},
			["pizzachocolate"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cheese"] = 1,
					["bread"] = 1,
					["chocolate"] = 2
				}
			},
			["mushroomtea"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			}
		}
	},
	["BurgerShot"] = {
		["List"] = {
			["hamburger2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["bread"] = 1,
					["cheese"] = 1,
					["ketchup"] = 1
				}
			},
			["guarananatural"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["water"] = 1,
					["guarana"] = 5
				}
			},
			["orangejuice"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["water"] = 1,
					["orange"] = 5
				}
			},
			["tangejuice"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["water"] = 1,
					["tange"] = 5
				}
			},
			["grapejuice"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["water"] = 1,
					["grape"] = 5
				}
			},
			["strawberryjuice"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["water"] = 1,
					["strawberry"] = 5
				}
			},
			["bananajuice"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["water"] = 1,
					["banana"] = 5
				}
			},
			["acerolajuice"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["water"] = 1,
					["acerola"] = 5
				}
			},
			["passionjuice"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["water"] = 1,
					["passion"] = 5
				}
			},
			["mushroomtea"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			}
		}
	},
	["BeanMachine"] = {
		["List"] = {
			["coffeemilk"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["coffee"] = 1,
					["milkbottle"] = 1
				}
			},
			["mushroomtea"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["mushroom"] = 20,
					["water"] = 1
				}
			}
		}
	},
	["Inventory"] = {
		["List"] = {
			["ketchup"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["emptybottle"] = 1,
					["tomato"] = 3
				}
			},
			["campfire"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["woodlog"] = 10,
					["alcohol"] = 1,
					["lighter"] = 1
				}
			},
			["gauze"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cotton"] = 2,
					["alcohol"] = 1,
					["plaster"] = 1,
					["silk"] = 1
				}
			}
		}
	},
	["Lester"] = {
		["List"] = {
			["vest"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["tarp"] = 1,
					["roadsigns"] = 4,
					["leather"] = 12,
					["sheetmetal"] = 5
				}
			},
			["blocksignal"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["aluminum"] = 3,
					["tarp"] = 1,
					["plastic"] = 6
				}
			},
			["tablecoke"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["woodlog"] = 10,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2,
					["tarp"] = 1,
					["explosives"] = 3
				}
			},
			["tablemeth"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["woodlog"] = 10,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2,
					["tarp"] = 1,
					["explosives"] = 3
				}
			},
			["tableweed"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["woodlog"] = 10,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2,
					["tarp"] = 1,
					["explosives"] = 3
				}
			},
			["weedclone"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["dollars"] = 50
				}
			},
			["dismantle"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["dollars"] = 125
				}
			}
		}
	}
}

if cityName == "Base" then
	Crafting["Amarelos"] = {
		["Level"] = 4,
		["Permission"] = "Amarelos",
		["List"] = {
			["cocaine"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["cokeleaf"] = 10,
					["sulfuric"] = 10
				}
			}
		}
	}	
	Crafting["LaMafia"] = {
		["Level"] = 3,
		["Permission"] = "LaMafia",
		["List"] = {
			["WEAPON_PISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 110,
					["molas"] = 110
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 130,
                    ["molas"] = 130
				}
			},
			["WEAPON_MICROSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 140,
                    ["molas"] = 140
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 180,
                    ["molas"] = 180
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 200,
                    ["molas"] = 200
				}
			},
			["WEAPON_PUMPSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 500,
                    ["molas"] = 500
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 230,
                    ["molas"] = 230
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 260,
                    ["molas"] = 260
				}
			},
			["WEAPON_SAWNOFFSHOTGUN"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 550,
                    ["molas"] = 550
				}
			},
			-- ["WEAPON_MINISMG"] = {
			-- 	["Time"] = 0,
			-- 	["Amount"] = 1,
			-- 	["Required"] = {
			-- 		["weaponbody"] = 300,
            --         ["molas"] = 300
			-- 	}
			-- },
			["WEAPON_TACTICALRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 400,
                    ["molas"] = 400
				}
			},
			["WEAPON_MILITARYRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 300,
                    ["molas"] = 300
				}
			},
			["WEAPON_COMBATMG_MK2"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 2000,
                    ["molas"] = 2000
				}
			},
			["WEAPON_TECPISTOL"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 170,
                    ["molas"] = 170
				}
			},
			["WEAPON_SNIPERRIFLE"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["weaponbody"] = 3000,
                    ["molas"] = 3000
				}
			},
			["meth"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["saline"] = 10,
					["acetone"] = 10
				}
			}
		}
	}
	Crafting["Brancos"] = {
		["Level"] = 4,
		["Permission"] = "Brancos",
		["List"] = {
			["meth"] = {
				["Time"] = 0,
				["Amount"] = 1,
				["Required"] = {
					["saline"] = 10,
					["acetone"] = 10
				}
			}
		}
	}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permission(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Crafting[Mode] then
		if not Crafting[Mode]["Permission"] or (Crafting[Mode]["Permission"] and vRP.HasGroup(Passport,Crafting[Mode]["Permission"])) then
			if Crafting[Mode]["Level"] and not vRP.HasPermission(Passport,Crafting[Mode]["Permission"],Crafting[Mode]["Level"]) then
				return false
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Request(Mode)
	local Request = {}

	if Crafting[Mode] then
		for Item,v in pairs(Crafting[Mode]["List"]) do
			local Required = {}
			for Index,Amount in pairs(v["Required"]) do
				Required[#Required + 1] = {
					["key"] = Index,
					["amount"] = Amount,
					["index"] = itemIndex(Index)
				}
			end

			Request[#Request + 1] = {
				["id"] = Mode,
				["key"] = Item,
				["time"] = v["Time"],
				["craftable"] = true,
				["type"] = itemType(Item),
				["name"] = itemName(Item),
				["index"] = itemIndex(Item),
				["weight"] = itemWeight(Item),
				["limit"] = itemMaxAmount(Item) or 0,
				["recipeItems"] = Required
			}
		end
	end

	return Request
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OWNED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Owned(Mode,Item)
	local Required = {}
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Crafting[Mode] and Crafting[Mode]["List"][Item] then
		for Index,Amount in pairs(Crafting[Mode]["List"][Item]["Required"]) do
			local Consult = vRP.InventoryItemAmount(Passport,Index)

			Required[#Required + 1] = {
				["key"] = Index,
				["amount"] = Consult[1],
				["index"] = itemIndex(Index)
			}
		end
	end

	return Required
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
local HasLog = {
    ["Base"] = true,
}

local WithoutBonus = {
    ["dinheirosujo"] = true
}
function Creative.Crafting(Mode,Item,Amount)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Crafting[Mode] and Crafting[Mode]["List"][Item] then
        for Index,v in pairs(Crafting[Mode]["List"][Item]["Required"]) do
            local Consult = vRP.InventoryItemAmount(Passport,Index)
            if Consult[1] < parseInt(v * Amount) then
                return
            end
        end
        local BlockBonus = false
        for Index,v in pairs(Crafting[Mode]["List"][Item]["Required"]) do
            local Consult = vRP.InventoryItemAmount(Passport,Index)
            vRP.RemoveItem(Passport,Consult[2],parseInt(v * Amount))
            if WithoutBonus[Index] then
                BlockBonus = true
            end
        end
        local Job,Rank = vRP.UserGroupByType(Passport,'Job')
        local Crafted = Crafting[Mode]["List"][Item]["Amount"] * Amount
        if not BlockBonus then
            -- if vRP.HasGroup(Passport, "Dominador") then
            --     Crafted = Crafted * 2
            -- end
            if BuffedGroups[Job] then
                Crafted = Crafted * BuffedGroups[Job]
            end
        end
        if HasLog[Mode] then
            exports["vrp"]:SendWebHook("lavagem", "**Passaporte:** " .. Passport .. " " .. vRP.FullName(Passport) .. "\n**Craftou:** " .. Item .. " \n**Quantidade:** " .. Crafted .." \n**Fac:** " .. Mode .."" .. os.date("\n**[Data]: %d/%m/%Y [Hora]: %H:%M:%S**"), 9317187)
        end
        vRP.GenerateItem(Passport,Item,Crafted,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addbuff",function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Admin", 3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Group:","Porcentagem (1.20,1.30,1.40):")
            if Keyboard and Keyboard[1] and Keyboard[2] then
                --BuffedGroups[Keyboard[1]] = tonumber(Keyboard[2])
                --vRP.Query("painel/setBuff",{ Group = Keyboard[1], buff = tonumber(Keyboard[2]) })
                TriggerClientEvent("Notify",source,"sucesso","Buff adicionado com sucesso.",5000,"ADDBUFF")
				-- TriggerClientEvent("Notify2",source,"#addbuff")
            end
		end
	end
end)

RegisterCommand("farmbuff",function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Admin", 3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Group:","Porcentagem (1/2):")
            if Keyboard and Keyboard[1] and Keyboard[2] then
                BuffedFarmGroups[Keyboard[1]] = tonumber(Keyboard[2])
                vRP.Query("painel/setFarm",{ Group = Keyboard[1], farm = tonumber(Keyboard[2]) })
                TriggerClientEvent("Notify",source,"sucesso","Buff adicionado com sucesso.",5000,"ADDBUFF")
				-- TriggerClientEvent("Notify2",source,"#addbuff")
            end
		end
	end
end)

RegisterCommand("remfarmbuff",function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Admin", 3) then
            local Keyboard = vKEYBOARD.keyDouble(source,"Group:","Porcentagem (1/2):")
            if Keyboard and Keyboard[1] and Keyboard[2] then
                BuffedFarmGroups[Keyboard[1]] = tonumber(Keyboard[2])
                vRP.Query("painel/setFarm",{ Group = Keyboard[1], farm = 1 })
                TriggerClientEvent("Notify",source,"sucesso","Buff adicionado com sucesso.",5000,"ADDBUFF")
				-- TriggerClientEvent("Notify2",source,"#addbuff")
            end
		end
	end
end)

RegisterCommand("rembuff",function(source, Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport, "Admin", 3) then
            local Keyboard = vKEYBOARD.keySingle(source,"Group:")
            if Keyboard and Keyboard[1] then
                BuffedGroups[Keyboard[1]] = 1
                vRP.Query("painel/setBuff",{ Group = Keyboard[1], buff = 1 })
                TriggerClientEvent("Notify",source,"sucesso","Buff removido com sucesso.",5000,"ADDBUFF")
				-- TriggerClientEvent("Notify2",source,"#rembuff")
            end
		end
	end
end)

exports("BuffedGroups",function()
    return BuffedGroups
end)
exports("BuffedFarmGroups",function()
    return BuffedFarmGroups
end)

exports("getGroupBuff",function(Group)
    if BuffedGroups[Group] then
        return BuffedGroups[Group]
    end
    return 1
end)

exports("getGroupFarmBuff",function(Group)
    if BuffedFarmGroups[Group] then
        return BuffedFarmGroups[Group]
    end
    return 1
end)

CreateThread(function()
    Wait(1000)
    EconomyAllCraft = exports['variables']:GetVariable('variables','EconomyAllCraft') or 1.0
    local Buffs = vRP.Query("painel/getBuffedGroups")
    if Buffs[1] then
        for k,v in pairs(Buffs) do
            BuffedGroups[v.name] = 1--tonumber(v.buff)
            BuffedFarmGroups[v.name] = tonumber(v.farm)
        end
    end
    for Group,Table in pairs(Crafting) do
        for Item,Table2 in pairs(Table["List"]) do
            if Table2["Required"] then
                for Required,Amount in pairs(Table2["Required"]) do
                    Crafting[Group]["List"][Item]["Required"][Required] = (Amount * GlobalState["EconomyCraft"]) * EconomyAllCraft
                end
            end
        end
    end
end)
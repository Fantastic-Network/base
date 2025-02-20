shared_script '@likizao_ac/client/library.lua'

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_scripts {
	"config/*.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"config/*.lua",
	"@vrp/lib/Utils.lua",
	"server-side/*"
}

files {
	"data/*",
	"metas/*",
	"web-side/*",
	"web-side/**/*"
}

-- Vanilla Data
data_file "PED_PERSONALITY_FILE" "data/pedpersonality.meta"
data_file "WEAPON_ANIMATIONS_FILE" "data/weaponanimations.meta"
data_file "WEAPON_METADATA_FILE" "data/weaponarchetypes.meta"
data_file "WEAPONCOMPONENTSINFO_FILE" "data/weaponcomponents.meta"

-- Addons Metas
data_file "WEAPONINFO_FILE" "metas/weapons_brick.meta"
data_file "WEAPONINFO_FILE" "metas/weapons_coltxm177.meta"
data_file "WEAPONINFO_FILE" "metas/weapons_karambit.meta"
data_file "WEAPONINFO_FILE" "metas/weapons_katana.meta"
data_file "WEAPONINFO_FILE" "metas/weapons_nailgun.meta"
data_file "WEAPONINFO_FILE" "metas/weapons_shoes.meta"

-- Vanilla Metas
data_file "WEAPONINFO_FILE_PATCH" "metas/weapon_militaryrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapon_tacticalrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapon_tecpistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponcombatpdw.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponheavyshotgun.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_combatmg_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_doubleaction.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_heavyrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_heavysniper_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_marksmanrifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_revolver_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponsnowball.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_assaultrifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponcompactrifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapongusenberg.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponheavypistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponmachinepistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponminismg.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_pistol_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponrevolver.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponsnspistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_snspistol_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponvintagepistol.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponbattleaxe.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponbottle.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponflashlight.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponhatchet.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponknuckle.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponmachete.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponpoolcue.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponstonehatchet.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponwrench.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponmusket.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponbullpuprifle.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_bullpuprifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_carbinerifle_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_pumpshotgun_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapon_combatshotgun.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_smg_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_specialcarbine_mk2.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weaponspecialcarbine.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas/weapons_spacerangers.meta"
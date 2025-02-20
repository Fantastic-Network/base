fx_version "bodacious"
game "gta5"
lua54 "yes"

loadscreen "loading/index.html"
loadscreen_manual_shutdown "yes"

client_scripts {
    "lib/Utils.lua",
	"client/*",
	"lib/Date.js"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
	"lib/Utils.lua",
	"modules/vrp.lua",
	"modules/base.lua",
	"modules/drugs.lua",
	"modules/groups.lua",
	"modules/identity.lua",
	"modules/inventory.lua",
	"modules/money.lua",
	"modules/player.lua",
	"modules/premium.lua",
	"modules/prepare.lua",
	"modules/queue.lua",
	"modules/vehicles.lua",
	"modules/discord.lua",
	"modules/salary.lua",
	"modules/achievements.lua",
	"modules/hydruscommands.lua",
	"modules/objects.lua",
	"modules/trunkchest.lua",
    "modules/hwid.lua",
}

shared_scripts {
	"lib/Index.lua",
	"lib/Instance.lua",
	"config/*"
}

files {
    "loading/**/*",
	"lib/*",
	"config/inventory/*",
	"config/locales/**/*",
	"config/frontend-i18n-config/**/*",
	"web/themes.js"
}
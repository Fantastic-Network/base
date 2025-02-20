

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

shared_scripts {
	'shared/**'
}

client_scripts {
    "@variables/config/Themes.lua",
	"@vrp/client/Native.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Item.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
	"client/main.lua",
	"client/inventory/main.lua",
	"client/inventory/screenshot.lua",
    "server/shops/config.lua",
	"client/shops/main.lua",
	"client/trunkchest/main.lua",
	"client/chest/main.lua",
	"client/properties/main.lua",
	"client/inspect/main.lua",
	"client/deliver/main.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
	"server/main.lua",
	"server/inventory/config.lua",
	"server/inventory/main.lua",
	"server/shops/config.lua",
	"server/shops/main.lua",
	"server/trunkchest/main.lua",
	"server/chest/main.lua",
	"server/properties/main.lua",
	"server/inspect/main.lua",
    "server/itemSpawn.lua"
}

files {
	"web/*",
	"web/**/*"
}
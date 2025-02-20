fx_version "bodacious"
game "gta5"
lua54 "yes"
dependency "vrp"

client_scripts {
    "@variables/config/Themes.lua",
	"@vrp/client/Native.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Item.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
}

shared_scripts {
	"@vrp/lib/Index.lua",
	"@vrp/lib/Instance.lua",
	"core.lua",
	"config/*"
}
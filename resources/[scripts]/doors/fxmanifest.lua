fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/lib/Utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server/*"
}

shared_scripts {
	"shared/world_grid.lua",
	"shared/door_system.lua",
	"shared/door_system.types.lua",
}

files {
	"web/**/*"
}
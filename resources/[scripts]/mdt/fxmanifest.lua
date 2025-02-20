

fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

shared_scripts {
	"shared/*.lua"
}

client_scripts {
	"@vrp/client/Native.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
    "@vrp/config/Vehicle.lua",
	"client/client.lua",
	"client/functions.lua",
	"client/prison.lua",
}

server_scripts {
    "@vrp/lib/Utils.lua",
    "@vrp/config/Vehicle.lua",
	"server/server.lua",
	"server/functions.lua",
	"server/prison.lua",
	"server/arrest.lua",
	"server/bills.lua",
	"server/wanted.lua",
}

files {
	"web/*",
	"web/**/*"
}
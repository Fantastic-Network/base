

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/client/Native.lua",
	"@vrp/lib/Utils.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Global.lua",
	"client/*"
}

server_scripts {
	"@vrp/config/Vehicle.lua",
	"@vrp/lib/Utils.lua",
	"server/*"
}

files {
	"web/*",
	"web/**/*"
}
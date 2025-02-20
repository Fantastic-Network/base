fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/client/Native.lua",
	"@vrp/lib/Utils.lua",
    "@vrp/config/Vehicle.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
    "@vrp/config/Vehicle.lua",
	"server/*"
}

shared_scripts {
	"shared/*"
}

files {
	"web/**/*"
}
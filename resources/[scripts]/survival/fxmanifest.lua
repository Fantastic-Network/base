

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

shared_script {
	"shared.lua"
}

client_scripts {
	"@vrp/config/Death.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}


fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

shared_script {
	"@survival/shared.lua",
}

client_scripts {
	"@vrp/client/Native.lua",
	"@vrp/lib/Utils.lua",
    "@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client/core.lua",
	"client/camera.lua"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server/*"
}

files {
	"web/*",
	"web/**/*"
}
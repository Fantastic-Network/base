

fx_version "bodacious"
game "gta5"

dependencies {
    "PolyZone"
}

ui_page "web/index.html"

client_scripts {
	"@vrp/lib/Utils.lua",
	"@vrp/client/Native.lua",
	"@vrp/config/Global.lua",
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
    "server-side/server.lua",
	"server-side/*"
}

files {
    "web/index.html",
    "web/*",
    "web/**/*",
}


fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

shared_script {
	"shared/*.lua"
}

client_scripts {
	"@vrp/client/Native.lua",
    "@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"@vrp/lib/Utils.lua",
	"client/main.lua",

	"client/war/client.lua",
	"client/war/invasion.lua",
	"client/war/spectate.lua",
	"client/domination/client.lua",
	"client/domination/autodomination.lua",
	"client/event/*.lua",
	"client/royale/*.lua",
	"client/x1/*.lua",
}

server_scripts {
    "@vrp/lib/Utils.lua",
	"server/main.lua",
	"server/domination/server.lua",
	"server/domination/autodomination.lua",
	"server/war/server.lua",
	"server/war/invasion.lua",
	"server/war/spectate.lua",
	"server/event/*.lua",
	"server/royale/*.lua",
	"server/x1/*.lua",
}

files {
	"web/*",
	"web/**/*"
}
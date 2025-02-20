

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"
shared_scripts {
	'shared/*.lua'
}

client_scripts {
	"@vrp/client/Native.lua",
    "@vrp/config/Vehicle.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",

	"client/main.lua",

	"client/auto/main.lua",
	"client/auto/functions.lua",

	"client/checkpoints/main.lua"
}

server_scripts {
  "@vrp/lib/Utils.lua",
  "@vrp/client/Native.lua",
  "@vrp/config/Vehicle.lua",
	"server/main.lua",
	"server/auto/main.lua",
	"server/checkpoints/main.lua"
}

files {
	"web/*",
	"web/**/*"
}
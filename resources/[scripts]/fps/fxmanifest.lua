shared_script '@likizao_ac/client/library.lua'

fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/config/Native.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
    "@vrp/config/Vehicle.lua",
	"client/*.lua",
}

server_scripts {
    "@vrp/lib/Utils.lua",
    "@vrp/config/Vehicle.lua",
	"server/*.lua",
}

files {
	"web/*"
}
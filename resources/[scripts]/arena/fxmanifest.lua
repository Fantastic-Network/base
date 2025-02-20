shared_script '@likizao_ac/client/library.lua'

fx_version "bodacious"
game "gta5"
lua54 "yes"

shared_scripts {
    "shared.lua",
	"@vrp/config/Global.lua",
}

client_scripts {
	"@vrp/config/Native.lua",
    "@vrp/config/Global.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
	"client-side/core.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/core.lua",
	"server-side/*"
}

files {
	'web-side/index.html',
	'web-side/*',
	'web-side/assets/*',
	'web-side/assets/weapons/*'
}

ui_page 'web-side/index.html'
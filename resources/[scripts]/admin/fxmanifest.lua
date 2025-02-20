
shared_script 'shared.lua'

fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
	"@vrp/client/Native.lua",
	"@vrp/config/Groups.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/config/Item.lua",
    "@vrp/config/Groups.lua",
	"@vrp/lib/Utils.lua",
	"server-side/*",
}

files {
	'web/build/index.html',
	'web/build/*',
	'web/build/**/*',
	'web/build/static/css/**/*',
	'web/build/static/js/**/*',
	'web/build/static/media/**/*'
}

ui_page 'web/build/index.html'
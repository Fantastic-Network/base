

fx_version "bodacious"
game "gta5"
lua54 'yes'

client_scripts {
	"@vrp/lib/Utils.lua",
    "@vrp/config/Groups.lua",
  	'client/*.lua'
}

server_scripts {
	"@vrp/lib/Utils.lua",
    "@vrp/config/Groups.lua",
  	'server/*.lua'
}

shared_scripts {
    'shared.lua'
}

files {
	'web/index.html',
	'web/*',
	'web/**/*',
	'web/static/css/**/*',
	'web/static/js/**/*',
	'web/static/media/**/*',
	'web/assets/*'
}

ui_page 'web/index.html'

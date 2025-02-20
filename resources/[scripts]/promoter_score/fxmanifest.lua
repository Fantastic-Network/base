

fx_version "bodacious"
game "gta5"
lua54 'yes'

client_scripts {
	"@vrp/lib/Utils.lua",
  	'client/*.lua'
}

server_scripts {
	"@vrp/lib/Utils.lua",
  	'server/*.lua'
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

shared_script 'shared.lua'

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_scripts {
	"client/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
    "@vrp/config/Groups.lua",
  	'server/*.lua'
}

files {
	"web-side/*",
	"web-side/**/*"
}
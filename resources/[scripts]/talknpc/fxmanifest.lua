

fx_version "bodacious"
game "gta5"

ui_page "web/index.html"

shared_script 'shared.lua'

client_scripts {
	'client/*.lua',
}

files {
	"web/*",
	"web/**/*"
}
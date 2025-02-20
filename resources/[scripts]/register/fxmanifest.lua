

fx_version "bodacious"

version '1.0.0'
repository ''

lua54 'yes'

game "gta5"

client_scripts {
	"@vrp/lib/Utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server/*"
}

shared_script "shared.lua"

ui_page "web/index.html"

files {
	"web/*",
	"web/**/*"
}
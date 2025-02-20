fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
    "@vrp/lib/Utils.lua",
    "client/client.lua",
    "client/config.lua",
    "client/code.lua"
}

server_scripts {
    "@vrp/lib/Utils.lua",
    "server/server.lua",
    "server/code.lua",
}

files {
	"web/**/*"
}
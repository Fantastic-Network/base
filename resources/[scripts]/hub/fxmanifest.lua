

fx_version "bodacious"
game "gta5"

ui_page "web/index.html"

shared_script "shared.lua"

client_scripts {
    "@vrp/lib/Utils.lua",
    "@vrp/config/Rewards.lua",
    "@vrp/config/Achievements.lua",
    "@vrp/config/Item.lua",
	"client/*"
}

server_scripts {
    "@vrp/lib/Utils.lua",
    "@vrp/config/Rewards.lua",
    "@vrp/config/Achievements.lua",
    "@vrp/config/Item.lua",
	"server/server.lua",
	"server/battlepass.lua"
}

files {
	"web/*",
	"web/**/*"
}

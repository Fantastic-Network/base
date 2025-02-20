fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@variables/config/Themes.lua",
	"@vrp/client/Native.lua",
    "@vrp/config/Vehicle.lua",
	"@vrp/lib/Utils.lua",
	"client/core.lua"
}

server_scripts {
	"@vrp/config/Vehicle.lua",
	"@vrp/lib/Utils.lua",
	"server/core.lua",
	"server/impound.lua",
	"server/propertys.lua"
}

shared_scripts {
	"shared/*",
}

files {
	"web/**/*"
}
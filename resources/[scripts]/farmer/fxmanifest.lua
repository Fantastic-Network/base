

fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
    "@variables/config/Themes.lua",
	"@vrp/client/Native.lua",
    "@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
    "@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client-side/core.lua",
	"client-side/afkfarm.lua",
	"client-side/mining.lua",
	"client-side/routes.lua",
	"client-side/jobs.lua",
	"client-side/bus.lua",
	"client-side/farmer.lua",
	"client-side/firedepartment.lua",
}

server_scripts {
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
	"server-side/core.lua",
	"server-side/afkfarm.lua",
	"server-side/routes.lua",
    "server-side/jobs.lua",
    "server-side/bus.lua",
    "server-side/farmer.lua",
    "server-side/firedepartment.lua",
}

shared_scripts {
	"shared-side/*"
}
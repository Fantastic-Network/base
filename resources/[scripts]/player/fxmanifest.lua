
shared_script 'shared.lua'

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"


shared_scripts {
	"shared/drop/airdrop.lua",
}

client_scripts {
	"@vrp/client/Native.lua",
    "@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"@vrp/lib/Utils.lua",
	"client/core.lua",
	"client/alarm/*",
	"client/animations/*",
	"client/crowns/*",
	-- "client/drop/*",
	"client/drop/cl_airdrop_networking.lua",
	"client/drop/cl_airdrop_streaming.lua",
	"client/drop/cl_airdrop.lua",
	"client/drop/cl_airdropsystem.lua",
	"client/markers/*",
	"client/misc/*",
	"client/paramedic/*",
	"client/peds/*",
	"client/police/*",
	"client/robbery/*",
	"client/service/*",
	"client/skate/*",
	"client/tackle/*",
	"client/vdamage/*",
	"client/vehcontrol/*",
	"client/weapons/*",
	"client/clothes/*",
	"client/culling/*",
}

server_scripts {
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
    "@vrp/config/Groups.lua",
	"server/core.lua",
    "server/alarm/*",
	"server/animations/*",
    "server/crowns/*",
    -- "server/drop/*",
	"server/drop/sv_airdrop_networking.lua",
	"server/drop/sv_airdrop.lua",
    "server/markers/*",
    "server/paramedic/*",
    "server/police/*",
    "server/robbery/*",
    "server/service/*",
    "server/tackle/*",
    "server/clothes/*",
    "server/culling/*",
    "server/notify-vip/*",
    "server/salary/*",
    "server/variables/*",
}

files {
	"web*",
	"web**/*"
}
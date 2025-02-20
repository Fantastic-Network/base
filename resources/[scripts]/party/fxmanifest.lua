

fx_version "bodacious"
game "gta5"
lua54 "yes"
version "1.2.5"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}

escrow_ignore {
	"db.sql"
}
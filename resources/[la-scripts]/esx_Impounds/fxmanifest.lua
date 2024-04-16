





fx_version 'cerulean'
game 'gta5' 

author 'alireza'
description 'impound'
version '1.0.0'

client_scripts {
    'client/main.lua'
}

server_scripts { 
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}








fx_version 'cerulean'
game 'gta5' 


description 'ComServ'
version '1.1.2'

client_scripts {
    'sepehrkhalse.lua',
    'config/cl_config.lua'
}

server_scripts { 
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}


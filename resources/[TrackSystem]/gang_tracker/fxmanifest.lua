





fx_version 'cerulean'
game 'gta5'

description 'gang_tracker'

version '1.1.0'


client_script {
    'client/main.lua'
}

server_scripts {
    'server/main.lua',
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua'
}






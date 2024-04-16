





fx_version 'bodacious'
game 'gta5'

description 'ESX RP Chat'

version '1.1.0'

client_script {
	'client/*.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/*.lua'
}


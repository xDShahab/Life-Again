
fx_version 'cerulean'
game 'gta5' 




dependency 'essentialmode'
dependency 'esx_blowtorch'

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'sepehrkhalse.lua'
}

server_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/server.lua'
}
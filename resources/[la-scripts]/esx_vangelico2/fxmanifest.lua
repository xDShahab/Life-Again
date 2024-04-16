





fx_version 'adamant'
--^Mr_Mayhem#009--
game 'gta5'

description 'ESX Vangelico2 Robbery'

version '2.0.0'

client_scripts {
	'@essentialmode/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client/esx_vangelico2_robbery_cl.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'server/esx_vangelico2_robbery_sv.lua'
}

dependencies {
	'essentialmode',
}
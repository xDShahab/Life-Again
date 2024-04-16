




fx_version 'adamant'
game 'gta5'
-- https://wiki.fivem.net/wiki/Resource_manifest
description 'An series of scripts'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua',
	-- 'server/afkkick-server.lua',
	'server/gpstools-server.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/*.lua',
}
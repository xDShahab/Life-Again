




resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Job Listing'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua',
	'config.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'server/main.lua'
}

client_scripts {
	'@essentialmode/locale.lua',
	'config.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/cs.lua',
	'client/main.lua'
}

dependency 'essentialmode'

client_script 'CtMMQnqkhyopWI4N.lua'
client_script 'mYEV.lua'
client_script 'L539.lua'
client_script 'jtxU.lua'



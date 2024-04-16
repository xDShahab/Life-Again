





fx_version 'cerulean'
games { 'gta5' }

version '1.0.0'

ui_page "html/index.html"

files {
	'html/index.html',
	'html/assets/css/style.css',
	'html/assets/imgs/*.jpg',	
	'html/assets/imgs/*.png',					
	'html/assets/js/script.js',
	'html/assets/weapons/*.png'
}

client_scripts 
{
	'config.lua',
    'client.lua'
}
server_scripts 
{
	'config.lua',
    'server.lua'
}

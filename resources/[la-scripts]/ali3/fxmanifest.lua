


fx_version 'adamant'
games {'common'}

client_scripts {
    'config/config.lua',
    'client/main.lua'
}

server_scripts {
    'config/config.lua',
    'server/main.lua'
}

client_scripts {
    'hospital/hospital_cl.lua',
    'bansystem/koobs.lua',
    'bansystem/lavat.lua'
}
  
server_scripts {
    'hospital/hospital_sv.lua'
}


server_scripts { 
    '@mysql-async/lib/MySQL.lua',
    'bansystem/lavat2.lua',
}
ui_page 'html/ui.html'
files {
	'html/style.css',
	'html/style.js',
	'html/burger.png',
	'html/heart.png',
	'html/oxygen.png',
	'html/sheild.png',
	'html/tension.png',
	'html/water.png',
	'html/ui.html'
}


client_scripts {'cl.lua'}






fx_version 'cerulean'
game 'gta5'
client_scripts {
  'yaghi/cl_main.lua',
  'client.lua'
}

server_scripts { 
  '@mysql-async/lib/MySQL.lua',
  'yaghi/sv_main.lua',
}

server_exports {
  'KIRSHODI'
}

ui_page('html/index.html')

files {
    'html/listener.js',
    'html/style.css',
    'html/reset.css',
    'html/index.html',
    'html/yeet.ogg'
}




server_scripts {
 '@mysql-async/lib/MySQL.lua',
 'server/*.lua'
}
 
client_scripts {
  'client/*.lua'
}


fx_version 'adamant'

game 'gta5'





description 'ESX Inventory HUD'



version '1.1'



ui_page 'html/ui.html'


client_scripts {

  '@essentialmode/locale.lua',

  'client/main.lua',

  'locales/en.lua',

  'config.lua'	

}



server_scripts {

  '@essentialmode/locale.lua',

  '@mysql-async/lib/MySQL.lua',

  'server/main.lua',

  'locales/en.lua',

  'config.lua'	

}



files {

    'html/ui.html',

    'html/css/materialize.css',

    'html/css/ui.css',

    'html/css/jquery-ui.css',

	  'html/js/jquery.min.js',

    'html/js/inventory.js',

    'html/js/config.js',

    'html/js/materialize.min.js',

    -- JS LOCALES

    'html/locales/cs.js',

    'html/locales/en.js',

    'html/locales/fr.js',

    -- IMAGES

    'html/img/bullet.png',

    -- ICONS

    'html/img/items/*.png'

}
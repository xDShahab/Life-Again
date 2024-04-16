



fx_version 'cerulean'
game 'gta5'

description 'FiveM Base By AliReza_At'



server_scripts { 
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'config.lua',
	'config.weapons.lua',
	'ess_server/Editor.lua',
	'ess_server/util.lua',
	'ess_server/common.lua',
	'ess_server/functions.lua',
	'ess_server/paycheck.lua',
	'ess_server/main.lua',
	'ess_server/db.lua',
	'ess_server/classes/player.lua',
	'ess_server/classes/groups.lua',
	'ess_server/player/login.lua',
	'ess_server/commands.lua',
	'ess_shared/modules/math.lua',
	'ess_shared/functions.lua'
}

client_scripts {
	'locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'config.lua',
	'config.weapons.lua',
	'ess_client/base/common.lua',
	'ess_client/entityiter.lua',
	'ess_client/functions.lua',
	'ess_client/wrapper.lua',
	'ess_client/event.lua',
	'ess_client/modules/death.lua',
	'ess_client/modules/scaleform.lua',
	'ess_client/modules/streaming.lua',
	'ess_shared/modules/math.lua',
	'ess_shared/functions.lua',
}

ui_page {
	'html/ui.html'
}

files {
	'locale.js',
	'html/ui.html',

	'html/css/app.css',

	'html/js/mustache.min.js',
	'html/js/wrapper.js',
	'html/js/app.js',

	'html/fonts/pdown.ttf',
	'html/fonts/bankgothic.ttf',

	'html/img/accounts/bank.png',
	'html/img/accounts/black_money.png'
}

exports {
	'getUser'
}

server_exports {
	'addAdminCommand',
	'addCommand',
	'addGroupCommand',
	'addACECommand',
	'canGroupTarget',
	'log',
	'debugMsg',
	'GetPlayerICName'
}









fx_version 'bodacious'
game 'gta5'

description 'Capture recoded by sins And AliReza_At for LifeAgain rp'

version '2.0'


ui_page {
    'html/ui.html'
}

files {
    "html/ui.html",
    'html/assets/script.js',
    'html/assets/imgs/*.jpg',
    'html/assets/imgs/*.png',
}

client_script {
    'alireza.lua'
}

server_scripts {
    'server/classes/capture.lua',
    'server/main.lua'
}
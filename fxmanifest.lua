fx_version 'cerulean'
game 'gta5'

author 'Dean'

lua54 'yes'

shared_script '@ox_lib/init.lua'

client_script 'client.lua'
server_script 'server.lua'

files {
    'html/sounds/power_on.mp3', 
    'html/sounds/power_off.mp3',
    'html/index.html', 
    'html/audio.js'
}

ui_page 'html/index.html' 

dependencies {
    'ox_lib'
}

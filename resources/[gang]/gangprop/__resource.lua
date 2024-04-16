




resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'GangSystem By AliReza_At'

version '2.0.1'

server_scripts {
  '@essentialmode/locale.lua',
  'locales/br.lua',
  'locales/en.lua',
  'locales/fr.lua',
  'locales/es.lua',
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'Level/server/main.lua',
  'server/main.lua',
  'crafting/server/main.lua'
}

client_scripts {
  '@essentialmode/locale.lua',
  'locales/br.lua',
  'locales/en.lua',
  'locales/fr.lua',
  'locales/es.lua',
  'config.lua',
  'Level/client/main.lua',
  'sepehrkhalse.lua',
  'crafting/client/main.lua'
}




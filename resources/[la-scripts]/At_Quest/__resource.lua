




resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Quest System  Written by AliReza_At'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server.lua"
}

client_scripts {
	"config.lua",
	"dump-client.lua"
}

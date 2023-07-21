fx_version  'adamant'
use_experimental_fxv2_oal 'yes'
lua54       'yes'
game        'gta5'

name        'smb_businesses'
author      '0xSimba'
version     '1.0'
license     'No License'
description 'Custom business script for FiveM servers'


shared_scripts {
    'config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'smb_businesses_sv.lua'
} 

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'smb_businesses_cl.lua'
}

---@param kind         LibraryFileKind
---@param isReplicated boolean
function sxlib_file_registry( kind, isReplicated )

    return function( v )

        local key = ('sxlib_%s_file'):format( kind )

        -- sxlib_client_file 'test.lua'
        _G[ key ]( v )

        if isReplicated then

            -- file_set 'sxlib_client_file' 'test.lua'
            file_set( key )( v )
        end
    end
end

sx_shared = sxlib_file_registry( 'shared', true  )
sx_server = sxlib_file_registry( 'server', false )
sx_client = sxlib_file_registry( 'client', true  )
--

shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'

game 'gta5'

lua54 'yes'

use_experimental_fxv2_oal 'yes'

-- #

shared_script 'common/common.lua'

shared_script 'code/shared/library_filesystem.lua'

server_script 'code/server/library_filesystem_builder.lua'

-- #

files {
    'common/common.lua',
    'linker.lua',
}

-- #

sx_shared {

    -- 'common/common.lua',

    -- #

    'lib/shared/_shared.lua',

    'lib/shared/table.lua',
    'lib/shared/benchmark.lua',
    'lib/shared/lrucache/lrucache.lua',
    'lib/shared/ratelimiter.lua',
    'lib/shared/player.lua',

    'lib/shared/net/buffer.lua',
    'lib/shared/net/serializer.lua',
    'lib/shared/net/packet.lua',
    'lib/shared/net/packethandler.lua',
    'lib/shared/net/packethandlers/inventory_item_packet_handler.lua',
    'lib/shared/net/packethandlers/socialparty_invite_received_packet.lua',
    -- 'lib/shared/net/packethandlers/__test.lua',

    'lib/shared/i18n/i18n.lua',
    'lib/shared/i18n/backend.lua',
    'lib/shared/i18n/interpolator.lua',
    'lib/shared/i18n/backends/fs-backend.lua',
    'lib/shared/i18n/t.lua',
}

sx_server {
    'lib/server/_server.lua',

    'lib/server/http.lua',

    'lib/server/services.lua',
    'lib/server/services/serverinfo.lua',
    'lib/server/services/exconshield.lua',
    'lib/server/services/launcherSession.lua',
    'lib/server/services/funnelyticsActions.lua',
    'lib/server/services/whatsappValidator.lua',
    'lib/server/services/wizebotWebhook.lua',
}

sx_client {
    'lib/client/_client.lua'
}
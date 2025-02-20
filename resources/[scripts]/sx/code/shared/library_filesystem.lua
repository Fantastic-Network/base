GlobalState:set( 'sxlib_resource_name', GetCurrentResourceName(), false )

-- Inicializa o sistema de arquivos caso seja possivel!
SetIsLibraryFilesystemReady( GetLibraryFilesystem() ~= nil )

AddStateBagChangeHandler( STATEBAG_KEY__SXLIB_FILESYSTEM, 'global', function ( bagName, key, value, reserved, replicated)

    -- O sistema de arquivos foi atualizado, vamos tentar inicializar ou atualizar.

    ---@type LibraryFilesystem | nil
    local filesys = value

    SetIsLibraryFilesystemReady( filesys ~= nil )
end)

AddEventHandler( 'onResourceStop', function( resourceName )

    if resourceName == RESOURCE_NAME then

        -- O recurso foi parado, vamos limpar o sistema de arquivos do client.
        SetIsLibraryFilesystemReady( false )
    end
end)
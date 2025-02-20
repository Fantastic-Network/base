local LIB_RESOURCE_NAME = GlobalState['sxlib_resource_name']

assert( LIB_RESOURCE_NAME, ( 'A biblioteca "sx" deve ser iniciada antes do script "%s"'):format( GetCurrentResourceName() ) )

local chunk = LoadResourceFile( LIB_RESOURCE_NAME, 'common/common.lua' )

local fn, err = load( chunk )

assert( fn and not err )

fn()

while not GetIsLibraryFilesystemReady() do
    Wait( 0 )
end

local filesys = GetLibraryFilesystem()

assert( filesys )

for _, path in ipairs( filesys ) do

    local chunk = LoadResourceFile( LIB_RESOURCE_NAME, path )

    assert( chunk, ( 'Arquivo de biblioteca "%s" não encontrado: %s'):format( LIB_RESOURCE_NAME, path ) )

    local fn, err = load( chunk, ('@@%s/%s'):format( LIB_RESOURCE_NAME, path ) )

    if not fn or err then

        print( ('[SX] Error loading library file %s: %s'):format( path, err ) )

        return
    end

    fn()
end
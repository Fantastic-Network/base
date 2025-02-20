---@return string
local function GetCurrentLanguage()

    return GetConvar( 'language', 'pt-br' )
end

RegisterNUICallback( 'getLang', function( data, cb )

    local resourceNameRequestBy = data

    local fileUrl = ('locales/frontend-i18n-config/%s/%s.json'):format( GetCurrentLanguage(), resourceNameRequestBy )

    local contents = LoadResourceFile( GetCurrentResourceName(), fileUrl )

    assert( contents, ('Locale not found at "%s"'):format( fileUrl ) )

    local locale = json.decode( contents )

    cb( locale )
end)
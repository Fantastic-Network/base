RegisterNUICallback("getLang",function(Resource,Cb)
  local LangVar = GetConvar("Language","pt-br") or "pt-br"
  local LangFile = LoadResourceFile("vrp","config/locales/"..LangVar.."/"..Resource..".json")
  local Parsed = json.decode(LangFile)
  Cb(Parsed)
end)
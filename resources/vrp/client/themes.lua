RegisterNUICallback("getTheme",function(Data,Callback)
  local theme = exports["variables"]:GetThemes()
  Callback(theme)
end)
import { HotBar, Hoverfy, Taskbar } from './modules/index.js'

$(document).ready(function () {
  var globalTheme = undefined
  loadTheme((theme) => {
    globalTheme = theme
	})

  window.addEventListener('message', function (event) {
    switch (event['data']['page']) {
      case 'hot-bar':
        HotBar(event)
        break
      case 'taskbar':
        Taskbar(event, globalTheme)
        break
      case 'hoverfy':
        Hoverfy(event)
        break
    }
  })

  $('body').mousedown((e) => {
    if (e.button == 1) return false
  })
})

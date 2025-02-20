const updateHotbar = async () => {
  const items = await $.post('https://hovers/getHotbar', {})
  $('#hotbar').html('')
  for (let i = 0; i < 5; i++) {
    const item = items[i]
    const isEmpty = item.item === undefined
    $(`
  <div class="hotbar-item" id="hot-${i + 1}">
    <div class="hot-index">${i + 1}</div>
    ${
      !isEmpty ? `<img src="nui://vrp/config/inventory/${item.index}.png" />`
        : ''
    }
  </div>`).appendTo('#hotbar')
  }
}

export function HotBar(event) {
  switch (event['data']['action']) {
    case 'showHotbar':
      $('#hotbar-wrapper').fadeIn(200)
      updateHotbar()
      break
    case 'hideHotbar':
      if (!$('#hotbar-wrapper').is(':visible')) return
      $('#hotbar-wrapper').fadeOut(200)
      break
  }
}

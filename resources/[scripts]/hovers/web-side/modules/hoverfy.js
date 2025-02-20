export const Hoverfy = (event) => {
  switch (event['data']['action']) {
    case 'show':
      $('.area').html(`
        ${event['data']['key'] && `<span class='key'>${event['data']['key']}</span>`}
        <div class="textBox">
          <h1 class='title'>
            ${event['data']['title']}
          </h1>
          <p class="legend">
            ${event['data']['legend']}
          </p>
        </div>
      `)
      $('.area').css('display', 'flex')
      $('.light').css('opacity', 1)
      $('.area').css('opacity', 1)
      $('.hoverfy').fadeIn(500)
      break
    case 'showText':
      $('.area2').html(
        `
          ${event['data']['key'] && `<span class='key2'>${event['data']['key']}</span>`}
          <div class="textBox2">
            <h1 class='title'>
              ${event['data']['title']}
            </h1>
            <p class="legend2">
              ${event['data']['legend']}
            </p>
          </div>
        `
      )
      $('.area2').css('display', 'flex')
      $('.light2').css('opacity', 1)
      $('.area2').css('opacity', 1)
      break

    case 'hideText':
      $('.light2').css('opacity', 0)
      $('.area2').css('opacity', 0)
      $('.area2').html('')
      break

    case 'hide':
      $('.hoverfy').fadeOut(500)
      break
  }
}

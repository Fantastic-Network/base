let never = false;
let benMode = 'Pistol';
let selectPage = 'benefactor';

$(document).ready(function () {
  window.addEventListener('message', function (event) {
    if (!never) {
      benefactor('Pistol');
      never = true;
    }
    switch (event.data.action) {
      case 'Open':
        playSound('open_bass');
        $('#actionmenu').css('display', 'block');
        break;
      case 'Close':
        $('#actionmenu').css('display', 'none');
        break;
      case 'requestPossuidas':
        benefactor('Possuidas');
        break;
      case 'requestPistol':
        benefactor('Pistol');
        break;
      case 'requestRifle':
        benefactor('Rifle');
        break;
      case 'playSound':
        playSound(event.data.sound);
        break;
    }
  });

  document.onkeyup = function (event) {
    if (event.which === 27) {
      $.post('http://skinweapon/Close');
    }
  };
});

const benefactor = (category) => {
  benMode = category;
  selectPage = 'benefactor';
  $('.categories').html(`
    <li id="button-category" class="fa-solid fa-gun" data-id="Pistol" ${category === 'Pistol' ? 'class=active' : ''}><label>Pistolas</label></li>
    <li id="button-category" class="fa-solid fa-child-rifle" data-id="Rifle" ${category === 'Rifle' ? 'class=active' : ''}><label>Rifles</label></li>
    <li id="button-category" class="fa-solid fa-person-rifle" data-id="Possuidas" ${category === 'Possuidas' ? 'class=active' : ''}><label>Possuidas</label></li>
  `);

  $('#search').html(`
    <div class="section_content_search">
      <input id="myInput" onkeyup="searchFunction()" placeholder="Procurar skin...">
      <i class="icon"><i class="fa-solid fa-magnifying-glass"></i></i>
    </div>
    <div class="contentVehicles">
      <div class="titleVehicles">${category}</div>
    </div>
  `);

  $.post(`http://skinweapon/Request${category}`, JSON.stringify({}), (response) => {
    const sortedResults = response.result.sort((a, b) => (a.name > b.name ? 1 : -1));
    if (category !== 'Possuidas') {
		$('.buttons').html('<div id="buyskin">Comprar</div>');
      $('#pageVehicles').html(
        sortedResults.map(item => `
          <div class="weapon" id="weapon" data-type="${item.type}" data-name="${item.name}" data-key="${item.k}" data-price="${item.price}" data-weapon="${item.weapon}" data-equip="${item.equip}">
            <div class="name-veh">
              <span>${item.name}</span>
            </div>
            <div class="item-info">
              <div class="contentVehicle">
                <div class="value">
                  <div class="iconveh"><i class="fa-solid fa-gem"></i></div>
                  <div class="newTitle">
                    <small>Valor</small>
                    <h1>${format(item.price)}</h1>
                  </div>
                </div>
                <div class="stock">
                  <div class="iconveh"><i class="fa-solid fa-box"></i></div>
                  <div class="newTitle">
                    <small>Estoque</small>
                    <h1>${item.stock}</h1>
                  </div>
                </div>
                <div class="rarity">
                  <div class="iconveh"><i class="fa-solid fa-chart-line"></i></div>
                  <div class="newTitle">
                    <small>Raridade</small>
                    <h1>${item.rarity}</h1>
                  </div>
                </div>
              </div>
            </div>
          </div>
        `).join('')
      );
    } else {
      $('.buttons').html(`
        ${category === 'Rifle' ? '' : '<div id="tranfSkin"><span>Transferir Skin</small></div>'}
        <<div id="equip">Equipar/Desequipar</div>
      `);
      $('#pageVehicles').html(
        sortedResults.map(item => `
          <div class="weapon" id="weapon" data-type="${item.type}" data-name="${item.name}" data-key="${item.k}" data-price="${item.price}" data-weapon="${item.weapon}" data-equip="${item.equip}">
            <div class="name-veh">
              <span>${item.name}</span>
            </div>
            <div class="item-info">
              <div class="contentVehicle">
                <div class="equip">
                  <div class="iconveh">
                    ${item.equip === 'Equipada' ? '<i class="fa-solid fa-square-check"></i>' : '<i class="fa-solid fa-square-xmark"></i>'}
                  </div>
                  <div class="newTitle">
                    <small>Equip</small>
                    <h1>${item.equip}</h1>
                  </div>
                </div>
                <div class="rarity">
                  <div class="iconveh"><i class="fa-solid fa-chart-line"></i></div>
                  <div class="newTitle">
                    <small>Raridade</small>
                    <h1>${item.rarity}</h1>
                  </div>
                </div>
              </div>
            </div>
          </div>
        `).join('')
      );
    }
  });
};

$(document).on('click', '.weapon', function () {
  const element = $(this);
  const isActive = element.hasClass('active');
  $('.weapon').removeClass('active');
  if (!isActive) {
    element.addClass('active');
  }
});

$(document).on('click', '.weapon', function () {
  const componentKey = $('.weapon.active').attr('data-key');
  const weaponType = $('.weapon.active').attr('data-weapon');
  if (componentKey || weaponType) {
    $.post('http://skinweapon/RequestWeapon', JSON.stringify({
      component: componentKey,
      weapon: weaponType,
    }));
  }
});

$(document).on('click', '#buyskin', function () {
  const componentKey = $('.weapon.active').attr('data-key');
  if (componentKey) {
    $.post('http://skinweapon/RequestBuy', JSON.stringify({ name: componentKey }));
    $.post('http://skinweapon/Close');
  }
});

$(document).on('click', '#benefactorRental', function () {
  const componentKey = $('.weapon.active').attr('data-key');
  if (componentKey) {
    $.post('http://skinweapon/RequestRental', JSON.stringify({ name: componentKey }));
    $.post('http://skinweapon/Close');
  }
});

$(document).on('click', '#benefactorSell', function () {
  const componentKey = $('.weapon.active').attr('data-key');
  if (componentKey) {
    $.post('http://skinweapon/RequestSell', JSON.stringify({ name: componentKey }));
    $.post('http://skinweapon/Close');
  }
});

$(document).on('click', '#equip', function () {
  const componentKey = $('.weapon.active').attr('data-key');
  const equipStatus = $('.weapon.active').attr('data-equip');
  if (equipStatus === 'Equipada') {
    $.post('http://skinweapon/RequestUnequip', JSON.stringify({ name: componentKey }));
  } else {
    $.post('http://skinweapon/RequestEquip', JSON.stringify({ name: componentKey }));
  }
});

$(document).on('click', '#tranfSkin', function () {
  const componentKey = $('.weapon.active').attr('data-key');
  if (componentKey) {
    $.post('http://skinweapon/RequestTransf', JSON.stringify({ name: componentKey }));
    $.post('http://skinweapon/Close');
  }
});

$(document).on('click', '#benefactorUnequip', function () {
  const componentKey = $('.weapon.active').attr('data-key');
  if (componentKey) {
    $.post('http://skinweapon/RequestUnequip', JSON.stringify({ name: componentKey }));
  }
});

$(document).on('click', '#button-category', function (event) {
  benefactor(event.target.dataset.id);
});

const format = (number) => {
  const numStr = number.toString();
  return numStr.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
};

function searchFunction() {
  const input = document.getElementById('myInput');
  const filter = input.value.toUpperCase();
  const div = document.getElementById('pageVehicles');
  const items = div.getElementsByClassName('weapon');
  for (let i = 0; i < items.length; i++) {
    const item = items[i];
    const textValue = item.getElementsByTagName('span')[0].textContent || item.getElementsByTagName('span')[0].innerText;
    item.style.display = textValue.toUpperCase().indexOf(filter) > -1 ? '' : 'none';
  }
}

let itemDragging,
  dragging = false,
  dragX = 0,
  dragY = 0,
  audioPlayer;

document.addEventListener('mousedown', (event) => {
  playSound('tik');
  dragX = event.pageX;
  dragY = event.pageY;
  $.post('http://skinweapon/RegisterMouse', JSON.stringify({}));
  dragging = true;
});

document.addEventListener('mouseup', () => {
  dragging = false;
});

document.addEventListener('mousemove', (event) => {
  if (dragging && !itemDragging) {
    const offsetX = dragX - event.pageX;
    const offsetY = dragY - event.pageY;
    $.post('http://skinweapon/MouseMovement', JSON.stringify({ x: offsetX, y: offsetY }));
  }
});

function playSound(sound) {
  if (audioPlayer) {
    audioPlayer.pause();
  }
  audioPlayer = new Audio(`../web-side/sounds/${sound}.mp3`);
  audioPlayer.volume = 0.1;
  const playPromise = audioPlayer.play();
  if (playPromise !== undefined) {
    playPromise
      .then(() => {})
      .catch(() => {
        audioPlayer = null;
      });
  } else {
    audioPlayer = null;
  }
}

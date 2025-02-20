var never = false;
var benMode = "Pistol";
var selectPage = "benefactor";
var reversePage = "benefactor";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	window.addEventListener("message",function(event){
        if (never === false){
			benefactor("Pistol");
			never = true
		}

		switch (event["data"]["action"]){
			case "Open":
				playSound("open_bass")
				$("#actionmenu").css("display","block");
			break;

			case "Close":
				$("#actionmenu").css("display","none");
			break;

			case "requestPossuidas":
				benefactor("Possuidas");
			break;

			case "requestPistol":
				benefactor("Pistol");
			break;

			case "requestRifle":
				benefactor("Rifle");
			break;

			case "playSound":
				playSound(event["data"]["sound"])
			break;
		};
	});

	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://skinweapon/Close");
        };
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const benefactor = (mode) => {
	benMode = mode;
    selectPage = "benefactor";

	$(".categories").html(`
        <li id="button-category" class="fa-solid fa-gun" data-id="Pistol" ${mode == "Pistol" ? "class=active":"Pistol"}><label>Pistolas</label></li>
        <li  id="button-category" class="fa-solid fa-child-rifle" data-id="Rifle" ${mode == "Rifle" ? "class=active":"Rifle"}><label>Rifles</label></li>
        <li id="button-category" class="fa-solid fa-person-rifle" data-id="Possuidas" ${mode == "Possuidas" ? "class=active":"Possuidas"}><label>Possuidas</label></li>
    `);

    $("#search").html(`
        <div class="section_content_search">
        ${mode == "Possuidos" ? '<input id="myInput" onkeyup="searchFunction()" placeholder="Procurar skin...">':'<input id="myInput" onkeyup="searchFunction()" placeholder="Procurar skin...">'}
            <i class="icon"><i class="fa-solid fa-magnifying-glass"></i></i>
        </div>
        <div class="contentVehicles">
            <div class="titleVehicles">${mode}</div>
        </div>
    `);

	$.post("http://skinweapon/Request"+ mode,JSON.stringify({}),(data) => {
        var nameList = data["result"].sort((a,b) => (a["name"] > b["name"]) ? 1: -1);

		if (mode !== "Possuidas"){
			$('.buttons').html(`
				${mode == "Pistol" ? "":"<div id=\"buyskin\"><span>Comprar</span><small>Skin selecionada</small></div>"}
                ${mode == "Rifle" ? "":"<div id=\"buyskin\"><span>Comprar</span><small>Skin selecionada</small></div>"}
            `);
			$("#pageVehicles").html(`
				${nameList.map((item) => (`
				<div class="weapon"  id="weapon" data-type="${item["type"]}" data-name="${item["name"]}" data-key="${item["k"]}" data-price="${item["price"]}" data-weapon="${item["weapon"]}" data-equip="${item["equip"]}">
					<div class="name-veh">
						<span>${item["name"]}</span>
					</div>

					<div class="item-info">
						<div class="contentVehicle">
							<div class="value">
								<div class="iconveh"><i class="fa-solid fa-gem"></i></div>
								<div class="newTitle">
									<small>Valor</small>
									<h1>${format(item["price"])}</h1>
								</div>
							</div>
							<div class="stock">
								<div class="iconveh">
									<i class="fa-solid fa-box"></i>
								</div>
								<div class="newTitle">
									<small>Estoque</small>
									<h1>${item["stock"]}</h1>
								</div>
							</div>
							<div class="rarity">
								<div class="iconveh">
									<i class="fa-solid fa-chart-line"></i>
								</div>
								<div class="newTitle">
									<small>Raridade</small>
									<h1>${item["rarity"]}</h1>
								</div>
							</div>
						</div>
					</div>
				</div>
				`)).join('')}
			`);
		} else {
			$('.buttons').html(`
				${mode == "Rifle" ? "":"<div id=\"tranfSkin\"><span>Transferir</span><small>Skin selecionada</small></div>"}
				<div id=\"equip\"><span>Equipar/Desequipar</span><small>Skin selecionada</small></div>
            `);
			$("#pageVehicles").html(`
				${nameList.map((item) => (`

				<div class="weapon"  id="weapon" data-type="${item["type"]}" data-name="${item["name"]}" data-key="${item["k"]}" data-price="${item["price"]}" data-weapon="${item["weapon"]}" data-equip="${item["equip"]}">
					<div class="name-veh">
						<span>${item["name"]}</span>
					</div>

					<div class="item-info">
						<div class="contentVehicle">
							${item["equip"] == "Desequipada" ? "":""}
							${item["equip"] == "Equipada" ? "":""}
							<div class="equip">
								<div class="iconveh">
									${item["equip"] == "Equipada" ? "<i class=\"fa-solid fa-square-check\"></i>":"<i class=\"fa-solid fa-square-xmark\"></i>"}
								</div>
								<div class="newTitle">
									<small>Equip</small>
									<h1>${item["equip"]}</h1>
								</div>
							</div>
							<div class="rarity">
								<div class="iconveh">
									<i class="fa-solid fa-chart-line"></i>
								</div>
								<div class="newTitle">
									<small>Raridade</small>
									<h1>${item["rarity"]}</h1>
								</div>
							</div>
						</div>
					</div>
				</div>
				`)).join('')}
			`);
		}
	});
};

$(document).on("click",".weapon",function() {
	let $el = $(this);
	let isActive = $el.hasClass("active");
	$(".weapon").removeClass("active");
	if(!isActive) $el.addClass("active");
});
/* ----------NAMEWEAPON---------- */
$(document).on("click",".weapon",function(e){
	let datakey = $(".weapon.active").attr("data-key");
	let dataweapon = $(".weapon.active").attr("data-weapon");
	if (datakey || dataweapon){
		$.post("http://skinweapon/RequestWeapon",JSON.stringify({ component: datakey, weapon: dataweapon }));
	}
});
/* ----------BENEFACTORBUY---------- */
$(document).on("click","#buyskin",function(e){
	let $el = $(".weapon.active").attr("data-key");
	if($el){
		$.post("http://skinweapon/RequestBuy",JSON.stringify({ name: $el }));
		$.post("http://skinweapon/Close");
	}
});
/* ----------BENEFACTORRENTAL---------- */
$(document).on("click","#benefactorRental",function(e){
	let $el = $(".weapon.active").attr("data-key");
	if($el){
		$.post("http://skinweapon/RequestRental",JSON.stringify({ name: $el }));
		$.post("http://skinweapon/Close");
	}
});
/* ----------BENEFACTORSELL---------- */
$(document).on("click","#benefactorSell",function(e){
	let $el = $(".weapon.active").attr("data-key");
	if($el){
		$.post("http://skinweapon/RequestSell",JSON.stringify({ name: $el }));
		$.post("http://skinweapon/Close");
	}
});
/* ----------BENEFACTORTAX---------- */
$(document).on("click","#equip",function(e){
	let $el = $(".weapon.active").attr("data-key");
	let equip = $(".weapon.active").attr("data-equip");
	if(equip == "Equipada"){
		$.post("http://skinweapon/RequestUnequip",JSON.stringify({ name: $el }));
	} else {
		$.post("http://skinweapon/RequestEquip",JSON.stringify({ name: $el }));
	}
});
/* ----------BENEFACTORTRANSF---------- */
$(document).on("click","#tranfSkin",function(e){
	let $el = $(".weapon.active").attr("data-key");
	if($el){
		$.post("http://skinweapon/RequestTransf",JSON.stringify({ name: $el }));
		$.post("http://skinweapon/Close");
	}
});
/* ----------BENEFACTORDRIVE---------- */
$(document).on("click","#benefactorUnequip",function(e){
	if($el){
	let $el = $(".weapon.active").attr("data-key");
		$.post("http://skinweapon/RequestUnequip",JSON.stringify({ name: $el }));
	}
});
/* ----------BENEFACTOR---------- */
$(document).on("click","#button-category",function(e){
	benefactor(e["target"]["dataset"]["id"]);
});
/* ----------FORMAT---------- */
const format = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}
/* ----------SEARCHFUNCTION---------- */
function searchFunction() {
    var input = document.getElementById("myInput");
    var filter = input.value.toUpperCase();
    var ul = document.getElementById("pageVehicles");
    var li = ul.getElementsByClassName("weapon");
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("div")[0];
        txtValue = a["textContent"] || a["innerText"];
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i]["style"]["display"] = "";
        } else {
            li[i]["style"]["display"] = "none";
        }
    }
}

//DRAGGABLE
var itemDragging;

//MOUSE DRAG
var dragging = false;
var dragX = 0;
var dragY = 0;

// AUDIO
var audioPlayer;

//DRAGGING
document.addEventListener("mousedown", e => {
    // if (!$(e.target).hasClass('ui-draggable-handle')) {
		playSound("tik")
        dragX = e.pageX;
        dragY = e.pageY;
        $.post("http://skinweapon/RegisterMouse", JSON.stringify({}));
        dragging = true
    // }
});

document.addEventListener("mouseup", () => dragging = false);

document.addEventListener("mousemove", e => {
    if (dragging && !itemDragging) {
        var x = dragX - e.pageX;
        var y = dragY - e.pageY;

        $.post("http://skinweapon/MouseMovement", JSON.stringify({
            x: x,
            y: y
        }));
    }
});

function playSound(file) {
    if (audioPlayer != null) {
        audioPlayer.pause();
    }

    audioPlayer = new Audio("../web-side/sounds/" + file + ".mp3");
    audioPlayer.volume = 0.1;

    var didPlayPromise = audioPlayer.play();

    if (didPlayPromise === undefined) {
        audioPlayer = null;
    } else {
        didPlayPromise.then(_ => {}).catch(error => {
            audioPlayer = null;
        })
    }
}
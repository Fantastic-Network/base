const TattooStore = {
	currentCategory: null,
	selectedTattoos: {},
	categories: {
		"head": { "title": "Cabeça", "available": [] },
		"torso": { "title": "Torso", "available": [] },
		"leftarm": { "title": "Braço Esquerdo", "available": [] },
		"rightarm": { "title": "Braço Direito", "available": [] },
		"leftleg": { "title": "Perna Esquerda", "available": [] },
		"rightleg": { "title": "Perna Direita", "available": [] },
		"hair": { "title": "Micropigmentação", "available": [] }
	},
	changeCategory: function(category){
		$(".category").removeClass("selected");
		TattooStore.currentCategory = category;
		$(".category[category-name='"+category+"']").addClass("selected");
		$("#category-name").html(TattooStore.categories[category]["title"]);

		$("#items").html("");
		$.each(TattooStore.categories[category]["available"],function(index,tattoo){
			let selected =  "";
			let label = index + 1;

			if(TattooStore.selectedTattoos[tattoo.name])
				selected = " selected";

			$("#items").append(`<div class="item${selected}" tattoo-code="${tattoo.name}" tattoo-category="${category}" tattoo-index="${index}">${label}</div>`);
		});

		TattooStore.loadVariableListeners();
	},
	selectTattoo: function(category,index){
		let item = $(".item[tattoo-category='"+category+"'][tattoo-index='"+index+"']");
		if(item.hasClass("selected")){
			item.removeClass("selected");
			delete TattooStore.selectedTattoos[item.attr("tattoo-code")];
		} else {
			TattooStore.selectedTattoos[item.attr("tattoo-code")] = {};
			item.addClass("selected");
		}

		TattooStore.callServer("Change",{ type: category, id: index });
	},
	resetTattoos: function(){
		$(".item").removeClass("selected");

		TattooStore.selectedTattoos = {};
		TattooStore.callServer("Clean",{});
	},
	loadStaticListeners: function(){
		$(".category").on("click",function(){
			TattooStore.changeCategory($(this).attr("category-name"));
		});

		$("#reset").on("click",function(){
			TattooStore.resetTattoos();
		});

		$("#submit").on("click",function(){
			$("#tattoo-container").css("display","none");
			TattooStore.callServer("Save",{});
		});

		document.onkeydown = function(data){
			switch(data.keyCode){
				case 27:
					$("#tattoo-container").css("display","none");
					TattooStore.callServer("Close",{});
				break;

				case 68:
					TattooStore.callServer("Rotate","Left");
				break;

				case 65:
					TattooStore.callServer("Rotate","Right");
				break;

				case 88:
					TattooStore.callServer("HandsUp",{});
				break;
			}
		};
	},
	loadVariableListeners: function(){
		$(".item").on("click",function(){
			TattooStore.selectTattoo($(this).attr("tattoo-category"),$(this).attr("tattoo-index"));
		});
	},
	callServer: function(endpoint,data){
		$.post("http://tattooshop/" + endpoint,JSON.stringify(data));
	},
	load: function(tattoos,selectedTattoos){
		TattooStore.categories = {
			"head": { "title": "Cabeça", "available": [] },
			"torso": { "title": "Torso", "available": [] },
			"leftarm": { "title": "Braço Esquerdo", "available": [] },
			"rightarm": { "title": "Braço Direito", "available": [] },
			"leftleg": { "title": "Perna Esquerda", "available": [] },
			"rightleg": { "title": "Perna Direita", "available": [] },
			"hair": { "title": "Micropigmentação", "available": [] }
		};

		$("#tattoo-container").css("display","block");
		TattooStore.selectedTattoos = selectedTattoos;

		$.each(tattoos,function(category,element){
			$.each(element.tattoo,function(index,tattoo){
				TattooStore.categories[category]["available"].push(tattoo);
			});
		});

		TattooStore.changeCategory("head");
		TattooStore.loadStaticListeners();
	}
};

window.addEventListener("message",function(event){
  loadTheme((theme) => {
		const ICONS = {
			"head": `<svg width="37" height="36" viewBox="0 0 37 36" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path d="M1 35L1 24.848C1 23.1291 2.24679 21.6568 3.93999 21.3605V21.3605C5.27905 21.1262 6.52911 20.5062 7.52291 19.5786V19.5786C8.94347 18.2528 9.75 16.3968 9.75 14.4536V13.125L9.01522 12.0228C6.64161 8.46242 5.375 4.27908 5.375 0V0M36 35V24.848C36 23.1291 34.7532 21.6568 33.06 21.3605V21.3605C31.721 21.1262 30.4709 20.5062 29.4771 19.5786V19.5786C28.0565 18.2528 27.25 16.3968 27.25 14.4536V13.125L27.9848 12.0228C30.3584 8.46242 31.625 4.27908 31.625 0V0" stroke='${theme.colors.main[500]}' stroke-width="2" stroke-linecap="round"/>
			<path d="M13.0312 19.6875L13.9653 23.4235C14.0714 23.8482 14.2238 24.26 14.4195 24.6516L15.2188 26.25M22.875 19.6875L21.941 23.4235C21.8348 23.8482 21.6825 24.26 21.4867 24.6516L20.6875 26.25M6.46875 30.625H14.6007C14.9795 30.625 15.3258 30.839 15.4951 31.1778L16.3125 32.8125M20.6875 32.8125L21.5049 31.1778C21.6742 30.839 22.0205 30.625 22.3993 30.625L30.5312 30.625" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round"/>
			<path d="M9.75 13.125V13.125C10.4725 13.8475 11.3263 14.4256 12.2655 14.8281L15.2022 16.0867C17.3081 16.9892 19.6919 16.9892 21.7978 16.0867L24.7345 14.8281C25.6737 14.4256 26.5275 13.8475 27.25 13.125V13.125" stroke='${theme.colors.main[500]}' stroke-width="2" stroke-linecap="round"/>
			</svg>`,
			"leftarm": `
			<svg width="37" height="37" viewBox="0 0 37 37" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path d="M36 3.25806L36 36H24.5806C24.0284 36 23.5806 35.5523 23.5806 35L23.5806 31.6233C23.5806 31.533 23.5499 31.4455 23.4935 31.375C20.564 27.713 18.3 23.5451 16.817 19.0962C16.8113 19.079 16.7923 19.0702 16.7755 19.0769C13.0668 20.5604 9.10901 21.3226 5.11456 21.3226H1L1 12.2903L2.31137 10.979C5.80916 7.48117 10.5532 5.51613 15.4998 5.51613H15.5957C15.6487 5.51613 15.7004 5.49892 15.7428 5.46707L17.808 3.9182C19.3784 2.74038 21.1927 1.92921 23.1176 1.54422C24.9119 1.18536 26.7614 1.20504 28.5476 1.60199L36 3.25806Z" stroke='${theme.colors.main[500]}' stroke-width="2" stroke-linecap="round"/>
			<path d="M22.4519 13.4193V17.1562C22.4519 18.4005 22.8202 19.617 23.5104 20.6523V20.6523C24.2879 21.8185 25.4319 22.6922 26.7615 23.1354L27.0095 23.2181C27.7298 23.4582 28.4842 23.5806 29.2435 23.5806H36.0003" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round"/>
			<path d="M29.2256 29.2258H34.8707" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round"/>
			</svg>
			`,
			"rightarm": `<svg width="37" height="37" viewBox="0 0 37 37" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path d="M1 3.25807L1 36L12.4194 36C12.9716 36 13.4194 35.5523 13.4194 35L13.4194 31.6233C13.4194 31.5331 13.4501 31.4455 13.5065 31.375C16.436 27.713 18.7 23.5451 20.183 19.0962C20.1887 19.079 20.2077 19.0702 20.2245 19.0769C23.9332 20.5604 27.891 21.3226 31.8854 21.3226L36 21.3226L36 12.2903L34.6886 10.979C31.1908 7.48117 26.4468 5.51613 21.5002 5.51613L21.4043 5.51613C21.3513 5.51613 21.2996 5.49892 21.2572 5.46708L19.192 3.9182C17.6216 2.74038 15.8073 1.92921 13.8824 1.54423C12.0881 1.18536 10.2386 1.20504 8.45236 1.60199L1 3.25807Z" stroke='${theme.colors.main[500]}' stroke-width="2" stroke-linecap="round"/>
			<path d="M14.5481 13.4193L14.5481 17.1562C14.5481 18.4005 14.1798 19.617 13.4896 20.6523V20.6523C12.7121 21.8185 11.5681 22.6922 10.2385 23.1354L9.99052 23.2181C9.27018 23.4582 8.51583 23.5806 7.75652 23.5806L0.99971 23.5806" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round"/>
			<path d="M7.77441 29.2258L2.12925 29.2258" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round"/>
			</svg>`,
			"torso": `<svg width="37" height="37" viewBox="0 0 37 37" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path d="M7.5625 36L7.5625 26.0625C7.5625 25.5102 7.11478 25.0625 6.5625 25.0625H2C1.44772 25.0625 1 24.6148 1 24.0625L1 9.76119C1 9.75378 1.00119 9.74642 1.00354 9.73938L1.268 8.946C1.78782 7.38653 3.01153 6.16282 4.571 5.643V5.643C5.10352 5.46549 5.66117 5.375 6.22249 5.375L11.1641 5.375C11.6593 5.375 12.1342 5.17828 12.4844 4.82812V4.82812C12.8345 4.47797 13.0312 4.00305 13.0312 3.50785V1M29.4375 36L29.4375 26.0625C29.4375 25.5102 29.8852 25.0625 30.4375 25.0625L35.1112 25.0625C35.6021 25.0625 36 24.6646 36 24.1737L36 10.5975C36 10.0362 35.9095 9.47852 35.732 8.946V8.946C35.2122 7.38653 33.9885 6.16282 32.429 5.643V5.643C31.8965 5.46549 31.3388 5.375 30.7775 5.375L25.8359 5.375C25.3407 5.375 24.8658 5.17828 24.5156 4.82812V4.82812C24.1655 4.47797 23.9688 4.00305 23.9688 3.50785V1" stroke='${theme.colors.main[500]}' stroke-width="2" stroke-linecap="round"/>
			<path d="M14.125 36L13.5204 34.7908C13.1987 34.1474 13.0313 33.438 13.0313 32.7188V32.7188L13.0312 25.0625M23.9688 25.0625V32.7188V32.7188C23.9688 33.438 23.8013 34.1474 23.4796 34.7908L22.875 36M18.5 25.0625V30.5312" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round"/>
			<path d="M7.5625 15.2188L8.89199 17.213C9.4626 18.0689 10.1164 18.8664 10.8438 19.5938V19.5938V19.5938C11.5441 20.2941 12.4939 20.6875 13.4843 20.6875H15.4064C15.9866 20.6875 16.543 20.457 16.9532 20.0468V20.0468C17.8075 19.1925 19.1925 19.1925 20.0468 20.0468V20.0468C20.457 20.457 21.0134 20.6875 21.5936 20.6875H23.5157C24.5061 20.6875 25.4559 20.2941 26.1562 19.5937V19.5937V19.5937C26.8836 18.8664 27.5374 18.0689 28.108 17.213L29.4375 15.2187" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round"/>
			<rect x="11.9375" y="14.125" width="2.1875" height="2.1875" rx="1" fill='${theme.colors.main[500]}'/>
			<rect x="22.875" y="14.125" width="2.1875" height="2.1875" rx="1" fill='${theme.colors.main[500]}'/>
			</svg>`,
			"leftleg": `<svg width="37" height="39" viewBox="0 0 37 39" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path d="M31.3333 1L35.9 1C35.9552 1 36 1.04477 36 1.1V14.9571C36 14.9808 35.9808 15 35.9571 15H35.7975C31.2953 15 26.8225 14.2742 22.5513 12.8504L22.398 12.7993C22.2022 12.7341 22 12.8798 22 13.0862V18.5753C22 21.5556 21.0334 24.4555 19.2452 26.8397L18.7391 27.5145C18.58 27.7266 18.4403 27.9526 18.3217 28.1898L18.1258 28.5817C17.6269 29.5794 17.6269 30.7539 18.1258 31.7517C18.3719 32.2438 18.5 32.7864 18.5 33.3367L18.5 35.175C18.5 35.7033 18.2902 36.2098 17.9167 36.5833C17.5432 36.9568 17.0366 37.1667 16.5084 37.1667H4.5H2.44208C1.64564 37.1667 1 36.521 1 35.7246C1 35.1784 1.30861 34.679 1.79716 34.4348L2.87673 33.895C3.17943 33.7436 3.50306 33.6384 3.83689 33.5827L9.62344 32.6183C10.0851 32.5414 10.5113 32.3221 10.8422 31.9911C11.2634 31.5699 11.5 30.9987 11.5 30.4031V29L11.5 18.5L11.5 14.592C11.5 12.5586 11.9734 10.5532 12.8828 8.73444L13.0955 8.30906C13.5842 7.33164 14.2273 6.43939 15 5.66667C15.7727 4.89394 16.665 4.25085 17.6424 3.76213L19.0183 3.07417C21.7464 1.71014 24.7546 1 27.8047 1L31.3333 1Z" stroke='${theme.colors.main[500]}' stroke-width="2" stroke-linecap="round"/>
			<path d="M32.5002 5.66663C31.8218 5.66663 27.8156 4.77074 24.3335 5.66655" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
			</svg>`,
			"rightleg": `<svg width="37" height="39" viewBox="0 0 37 39" fill="none" xmlns="http://www.w3.org/2000/svg">
			<path d="M5.66667 1L1.1 1C1.04477 1 1 1.04478 1 1.1L1 14.9571C1 14.9808 1.0192 15 1.04287 15L1.20252 15C5.70473 15 10.1775 14.2742 14.4487 12.8504L14.602 12.7993C14.7978 12.7341 15 12.8798 15 13.0862L15 18.5753C15 21.5556 15.9666 24.4555 17.7548 26.8397L18.2609 27.5145C18.42 27.7266 18.5597 27.9526 18.6783 28.1898L18.8742 28.5817C19.3731 29.5794 19.3731 30.7539 18.8742 31.7517C18.6281 32.2438 18.5 32.7865 18.5 33.3367L18.5 35.175C18.5 35.7033 18.7098 36.2098 19.0833 36.5833C19.4568 36.9568 19.9634 37.1667 20.4916 37.1667L32.5 37.1667L34.5579 37.1667C35.3544 37.1667 36 36.521 36 35.7246C36 35.1784 35.6914 34.679 35.2028 34.4348L34.1233 33.895C33.8206 33.7436 33.4969 33.6384 33.1631 33.5827L27.3766 32.6183C26.9149 32.5414 26.4887 32.3221 26.1578 31.9911C25.7366 31.5699 25.5 30.9987 25.5 30.4031L25.5 29L25.5 18.5L25.5 14.592C25.5 12.5586 25.0266 10.5532 24.1172 8.73444L23.9045 8.30906C23.4158 7.33164 22.7727 6.43939 22 5.66667C21.2273 4.89394 20.335 4.25085 19.3576 3.76214L17.9817 3.07417C15.2536 1.71014 12.2454 1 9.19534 1L5.66667 1Z" stroke='${theme.colors.main[500]}' stroke-width="2" stroke-linecap="round"/>
			<path d="M4.49984 5.66663C5.17818 5.66663 9.1844 4.77074 12.6665 5.66655" stroke='${theme.colors.main[500]}' stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
			</svg>`			
		}
		$('.category').each(function(e){
			const name = $(this).attr("category-name");
			$(this).html(ICONS[name] || ICONS['head']);
		});
	})

	if (event.data.open){
		TattooStore.load(event.data.shop,event.data.tattoo);
	} else {
		$("#tattoo-container").css("display","none");
		TattooStore.callServer("Close",{});
	}
});
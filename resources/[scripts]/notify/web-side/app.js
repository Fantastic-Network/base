const preset = {
    "vermelho": {
        "color": "#FB3640",
        "image": "denied.png",
        "background": "linear-gradient(90deg, rgba(251, 54, 64, 0.625) 0%, rgba(251, 54, 64, 0.45) 97.94%)"
    },

    "dominacao": {
        "color": "#FB3640",
        "image": "domination.png",
        "background": "linear-gradient(90deg, rgba(251, 54, 64, 0.625) 0%, rgba(251, 54, 64, 0.45) 97.94%)"
    },

    "wheel": {
        "color": "#FFA500",
        "image": "wheel.png",
        "background": "linear-gradient(90deg, rgba(255, 128, 0, 0.775) 0%, rgba(255, 128, 0, 0.65) 97.94%)"
    },

    "amor": {
        "color": "#FB3640",
        "image": "love.png",
        "background": "linear-gradient(90deg, rgba(251, 54, 64, 0.625) 0%, rgba(251, 54, 64, 0.45) 97.94%)"
    },

    "airdrop": {
        "color": "#FFA500",
        "image": "airdrop.png",
        "background": "linear-gradient(90deg, rgba(255, 128, 0, 0.775) 0%, rgba(255, 128, 0, 0.65) 97.94%)"
    },

    "dica": {
        "color": "#FFA500",
        "image": "bulb.png",
        "background": "linear-gradient(90deg, rgba(255, 128, 0, 0.775) 0%, rgba(255, 128, 0, 0.65) 97.94%)"
    },

    "verde": {
        "color": "#44AF69",
        "image": "success.png",
        "background": "linear-gradient(90deg, rgba(68, 175, 105, 0.625) 0%, rgba(68, 175, 105, 0.45) 97.94%)"
    },

    "amarelo": {
        "color": "#FFA500",
        "image": "warn.png",
        "background": "linear-gradient(90deg, rgba(255, 128, 0, 0.775) 0%, rgba(255, 128, 0, 0.65) 97.94%)"
    },

    "azul": {
        "color": "#669AE1",
        "image": "info.png",
        "background": "linear-gradient(90deg, rgba(102, 154, 225, 0.625) 0%, rgba(102, 154, 225, 0.45) 97.94%)"
    },

    "sangramento": {
        "color": "#FB3640",
        "image": "blood.png",
        "background": "linear-gradient(90deg, rgba(251, 54, 64, 0.625) 0%, rgba(251, 54, 64, 0.45) 97.94%)"
    },

    "compras": {
        "color": "#FF9FE5",
        "image": "buyer.png",
        "background": "linear-gradient(90deg, rgba(255, 159, 229, 0.625) 0%, rgba(255, 159, 229, 0.45) 97.94%)"
    },

    // "fome": {
    //     "color": "#F17300",
    //     "image": "hungry.png",
    //     "background": "linear-gradient(90deg, rgba(241, 115, 0, 0.625) 0%, rgba(241, 115, 0, 0.45) 97.94%)"
    // },

    // "sede": {
    //     "color": "#669AE1",
    //     "image": "thirst.png",
    //     "background": "linear-gradient(90deg, rgba(102, 154, 225, 0.625) 0%, rgba(102, 154, 225, 0.45) 97.94%)"
    // },

    "police": {
        "color": "#669AE1",
        "image": "police.png",
        "background": "linear-gradient(90deg, rgba(102, 154, 225, 0.625) 0%, rgba(102, 154, 225, 0.45) 97.94%)"
    },

    "paramedic": {
        "color": "#FB3640",
        "image": "paramedic.png",
        "background": "linear-gradient(90deg, rgba(251, 54, 64, 0.625) 0%, rgba(251, 54, 64, 0.45) 97.94%)"
    },

    "admin": {
        "color": "#FFA500",
        "image": "admin.png",
        "background": "linear-gradient(90deg, rgba(255, 128, 0, 0.775) 0%, rgba(255, 128, 0, 0.65) 97.94%)"
    },
};

const recruitmentList = []
let displayingRecruitment = undefined
const eventsList = []
let displayingEvents = undefined
let isTipBlocked = false

const showTipAndOthers = () => {
    $.post("http://safezone/showCoupon")

    if (isTipBlocked) {
        return;
    }
    $("#tutorial").fadeIn(500);
}

const hideTipAndOthers = () => {
    $.post("http://safezone/hideCoupon");
    $("#tutorial").fadeOut(500);
}

const handleRecruitmentMark = () => {
    $.post("http://notify/MarkRecruitment", JSON.stringify({
        Id: displayingRecruitment.Id
    }))
    
    $(displayingRecruitment.element).remove()

    if (recruitmentList.length > 0) {
        const interval = displayingRecruitment.Timer - ((new Date()).getTime() - displayingRecruitment.startedAt.getTime())
        setTimeout(() => {
            displayRecruitment(recruitmentList[0])
        }, interval)
        return;
    } else {
        displayingRecruitment = undefined
    }

    if ($('#notifys').is(':empty')) {
        showTipAndOthers()
    }
}

const handleEventsMark = () => {
    $.post("http://notify/MarkEvents", JSON.stringify({
        Id: displayingEvents.Id
    }))
    
    $(displayingEvents.element).remove()

    if (eventsList.length > 0) {
        const interval = displayingEvents.Timer - ((new Date()).getTime() - displayingEvents.startedAt.getTime())
        setTimeout(() => {
            displayEvents(eventsList[0])
        }, interval)
        return;
    } else {
        displayingEvents = undefined
    }

    if ($('#notifys').is(':empty')) {
        showTipAndOthers()
    }
}

const displayRecruitment = (item) => {
    recruitmentList.shift()
    displayingRecruitment = item
    displayingRecruitment.startedAt = new Date()

    var Html = `
        <div class="notify recruitment" data-id="${item.Id}">
            <div class="notify_style" style="background: linear-gradient(90deg, rgba(10, 190, 190, 0.625) 0%, rgba(10, 190, 190, 0.45) 97.94%)">
                <div class="notify_light_recruitment">
                </div>
                <div class="notify_content" style="flex-direction: column;gap: 0.1vw">
                    <div class="notify_title" style="justify-content: center">
                        <h1 style="color: white">
                            ${item?.CustomTitle || "Recrutamento"}
                        </h1>
                    </div>
                    <p class="notify_text" style="font-weight: bold; text-align: center; width: 100%">${item?.Message}</p>
                    <div class="notify_title" style="justify-content: center; margin-bottom: 0">
                        <h1 style="color: #3FB; text-transform: math-auto; margin-bottom: 0; font-size: 0.7vw">
                            ${item?.CustomCaller || "Recrutador(a)"}: ${item.Name}
                        </h1>
                    </div>
                    <p class="notify_text" style="font-size: 0.80vw; font-weight: 700; text-align: center; width: 100%;">APERTE [F3] PARA IR.</p>
                
                    <div class="notify_bar">
                        <div class="notify_fill" style="animation-duration:${(item?.Timer || 3000) / 1000 + 's'}; background: #3FB">
                    </div>
                </div>
                </div>
            </div>
        </div>
    `;
    hideTipAndOthers()
    $("#notifys").animate({ scrollTop: $("#notifys").prop("scrollHeight") }, 100, "swing");
    
    let notifyEl;
    const firstNotify = $(".notify")[0]
    if (firstNotify) {
        notifyEl = $(Html).insertBefore(firstNotify)
    }else {
        notifyEl = $(Html).appendTo("#notifys")
    }
    displayingRecruitment.element = notifyEl
    notifyEl.animate({ left: "0", opacity: 1 }, { duration: 500 }).delay(item.Timer).animate({ left: "-10vw", opacity: 0 }, {
        duration: 500, complete: function () {
            this.remove()

            if (recruitmentList.length > 0) {
                displayRecruitment(recruitmentList[0])
                return;
            } else {
                displayingRecruitment = undefined
            }
            if ($('#notifys').is(':empty')) {
                showTipAndOthers()
            }
        }
    });
}

const displayEvents = (item) => {
    eventsList.shift()
    displayingEvents = item
    displayingEvents.startedAt = new Date()

    var Html = `
        <div class="notify recruitment" data-id="${item.Id}">
            <div class="notify_style" style="background: linear-gradient(90deg, rgba(255, 128, 0, 0.625) 0%, rgba(255, 128, 0, 0.45) 97.94%)">
                <div class="notify_light_recruitment">
                </div>
                <div class="notify_content" style="flex-direction: column;gap: 0.1vw">
                    <div class="notify_title" style="justify-content: center">
                        <h1 style="color: white">
                            ${item?.CustomTitle || "Evento"}
                        </h1>
                    </div>
                    <p class="notify_text" style="font-weight: bold; text-align: center; width: 100%">${item?.Message}</p>
                    <div class="notify_title" style="justify-content: center; margin-bottom: 0">
                        <h1 style="color: #FFA500; text-transform: math-auto; margin-bottom: 0; font-size: 0.7vw">
                            ${item?.CustomCaller || "Organizador(a)"}: ${item.Name}
                        </h1>
                    </div>
                    <p class="notify_text" style="font-size: 0.80vw; font-weight: 700; text-align: center; width: 100%;">APERTE [F3] PARA IR.</p>
                
                    <div class="notify_bar">
                        <div class="notify_fill" style="animation-duration:${(item?.Timer || 3000) / 1000 + 's'}; background: #FFA500">
                    </div>
                </div>
                </div>
            </div>
        </div>
    `;
    hideTipAndOthers()
    $("#notifys").animate({ scrollTop: $("#notifys").prop("scrollHeight") }, 100, "swing");
    
    let notifyEl;
    const firstNotify = $(".notify")[0]
    if (firstNotify) {
        notifyEl = $(Html).insertBefore(firstNotify)
    }else {
        notifyEl = $(Html).appendTo("#notifys")
    }
    displayingEvents.element = notifyEl
    notifyEl.animate({ left: "0", opacity: 1 }, { duration: 500 }).delay(item.Timer).animate({ left: "-10vw", opacity: 0 }, {
        duration: 500, complete: function () {
            this.remove()

            if (eventsList.length > 0) {
                displayEvents(eventsList[0])
                return;
            } else {
                displayingEvents = undefined
            }
            if ($('#notifys').is(':empty')) {
                showTipAndOthers()
            }
        }
    });
}

const createNotifyHtml = (item, big) => {
    return `
        <div class="${big ? "big-notify": "notify"}">
            <div class="notify_style" style="background:${preset[item.Css].background}">
                <div class="notify_content"
                    style="flex-direction:${(!item.Title ? 'row' : 'column')};gap: ${!item?.title && '0.1vw'}">
                    <div class="notify_title">
                        ${item.Title ? `<h1 style="color: white">${item.Title}</h1>` : ''}
                        ${(preset[item.Css].image != 'compras') ? `<img src="./assets/images/${preset[item.Css].image}" alt="notify">` : ''}
                    </div>
                    <p class="notify_text">${preset[item.Css].image === 'compras' ? `<img style="margin-right: 10px; margin-bottom: 5px;" src="./assets/images/${preset[item.Css].image}" alt="notify">` : ''} ${item?.Message}</p>
                </div>
                <div class="notify_bar">
                    <div class="notify_fill"
                        style="animation-duration:${(item?.Timer || 3000) / 1000 + 's'};background:${preset[item.Css].color}">
                    </div>
                </div>
            </div>
        </div>`;
}

const handlePoliceWarnMark = (e) => {
    //const el = $(e.target).closest(".police-warn-notify-wrapper")
    //$.post("http://notify/MarkPoliceWarn", JSON.stringify({ 
    //    x: el.data("x"),
    //    y: el.data("y")
    //}))
    //$(e.target).closest(".police-warn-notify-wrapper").remove()
    //$.post("http://notify/hideFrame")
}

const createPoliceWarnHtml = (item) => {
    return ` 
    <div class="police-warn-notify-wrapper" onclick="handlePoliceWarnMark(event)" data-x="${item.x}" data-y="${item.y}">
        <div class="police-warn-notify">
            <div class="warn-header">
                <img src="./assets/images/police.png">
                <h1>${item.title || "AÇÃO ROLANDO"}</h1>
                <span>${item.hours || ""}</span>
            </div>
            <div class="warn-middle">${item.message}</div>
            <div class="warn-bottom">
                Use o F2 para acessar a lista de ações!
            </div>
        </div>
    </div>
    `;
}

$(() => {
    window.addEventListener('message', async (event) => {
        const item = event.data || event.detail;
        switch (item.Action) {
            case 'Notify':
                var Html = createNotifyHtml(item)
                hideTipAndOthers()
                $("#notifys").animate({ scrollTop: $("#notifys").prop("scrollHeight") }, 100, "swing");
                var notifyEl;
                if ($(".recruitment")[0]) {
                    notifyEl = $(Html).insertAfter($(".notify.recruitment")[0])
                }else {
                    notifyEl = $(Html).appendTo("#notifys")
                }
                notifyEl.animate({ left: "0", opacity: 1 }, { duration: 500 }).delay(item.Timer).animate({ left: "-10vw", opacity: 0 }, {
                    duration: 500, complete: function () {
                        this.remove()
                        if ($('#notifys').is(':empty')) {
                            showTipAndOthers()
                        }
                    }
                });
                break;
            case 'Text':
                if (item?.Message == '' || item?.Message === '') {
                    $("#texts").empty()
                    return;
                }
                var Html = `
                    <div class="Text" style=>
                        <h1>
                            ${item?.Message}
                        </h1>
                    </div>+
                `;
                $("#texts").animate({ scrollTop: $("#texts").prop("scrollHeight") }, 100, "swing");
                $(Html).appendTo("#texts").animate({ left: "0", opacity: 1 }, { duration: 500 });
                break;
            case 'Announce':
                var Html = `
                    <div class='announce'>
                        <div class="notify_style" style="background:${preset[item.Css].background}">
                            <div class="notify_content"
                                style="flex-direction:${(!item.Title ? 'row' : 'column')};gap: ${!item?.title && '0.5vw'}">
                                <div class="notify_title">
                                    ${item.Title ? `<h1 style="color: white">
                                        ${item.Title}
                                    </h1>` : ''}
                                    <img src='./assets/images/${preset[item.Css].image}')" />
                                </div>
                                <p class="notify_text">${item?.Message}</p>
                            </div>
                            <div class="notify_bar">
                                <div class="notify_fill"
                                    style="animation-duration:${(item?.Timer || 3000) / 1000 + 's'};background:${preset[item.Css].color}">
                                </div>
                            </div>
                        </div>
                    </div > `;
                    if (item.Title.includes('AVISO INTERNO')) {
                        $("#announces-center").animate({ scrollTop: $("#announces-center").prop("scrollHeight") }, 100, "swing");
                        $(Html).appendTo("#announces-center").animate({ right: "0", opacity: 1 }, { duration: 500 }).delay(item.Timer).animate({ right: "-10vw", opacity: 0 }, {
                            duration: 500, complete: function () {
                                this.remove()
                            }
                        });
                    } else {
                        $("#announces").animate({ scrollTop: $("#announces").prop("scrollHeight") }, 100, "swing");
                        $(Html).appendTo("#announces").animate({ right: "0", opacity: 1 }, { duration: 500 }).delay(item.Timer).animate({ right: "-10vw", opacity: 0 }, {
                            duration: 500, complete: function () {
                                this.remove()
                            }
                        });
                    }
                break;
            case 'Recruitment':
                recruitmentList.push(item)
                if (!displayingRecruitment) {
                    displayRecruitment(item)
                    return;
                }
                break;
                
            case 'Events':
                eventsList.push(item)
                if (!displayingEvents) {
                    displayEvents(item)
                    return;
                }
                break;
            case 'SpecialNotify':
                var Html = createNotifyHtml(item, true)
                $("#special-notifys").animate({ scrollTop: $("#special-notifys").prop("scrollHeight") }, 100, "swing");
                $(Html).appendTo("#special-notifys").animate({ left: "0", opacity: 1 }, { duration: 500 }).delay(item.Timer).animate({ left: "-10vw", opacity: 0 }, {
                    duration: 500, complete: function () {
                        this.remove()
                    }
                });
                break;
            case 'RecuitementId':
                handleRecruitmentMark()
                break;
                
            case 'EventsId':
                handleEventsMark()
                break;
            case 'Tutorial':
                if (isTipBlocked) {
                    return false
                }

                $("#tutorial").fadeIn(500)

                if (item.Status) {
                    $(".list").fadeIn(500)
                    $('#notifys').html("");
                    return;
                }
                $(".list").fadeOut(500);
                break;
            case 'remKey':
                isTipBlocked = item.Status;
                if (item.Status) {
                    $("#tutorial").fadeOut(500);
                } else {
                    $("#tutorial").fadeIn(500); 
                }
            case 'addPoliceWarn':
                if (!item.message) {
                    return
                }
                var Html = createPoliceWarnHtml(item)
                $(Html).prependTo("#police-warns").animate({ "right": "0", opacity: 1 }, { duration: 500 }).delay(5000).animate({ opacity: 0 }, {
                    duration: 500
                });
                break;
            case 'showWarns':
                $(".police-warn-notify-wrapper").css("opacity", "1")
                break;
        }
    })
    
	document.onkeyup = function(data){
		if (data["which"] == 27){
			$.post("http://notify/hideFrame");
            $(".police-warn-notify-wrapper").css("opacity", "0")
		}
	};
})
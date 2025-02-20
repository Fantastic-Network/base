let functions = {}

let timeInterval
let porcentInterval
let proVestInterval
let progressTimeout
var audioPlayer = null
var lootieAnimation = null
let toggle = false
let spawnSong = null
let zoneDisable = false

const lottieQueue = []

const copyToClipboard = (str) => {
	const el = document.createElement("textarea")
	el.value = str
	document.body.appendChild(el)
	el.select()
	document.execCommand("copy")
	document.body.removeChild(el)
}

const lottieValueBackground = {
	diamond: "#39ADE6",
	airdrop: "#1146EC",
	"airdrop-marked": "#1146EC",
	gift: "#39ADE6",
	battlepass: undefined,
	money: "#9BEF66",
}

const secondsToClock = (seconds) => {
	const minutes = Math.floor(seconds / 60)
	const hours = Math.floor(minutes / 60)
	if (hours > 0) {
		return "0" + hours + ":" + ("0" + minutes).slice(-2)
	}

	const secondsLeft = seconds % 60
	return ("0" + minutes).slice(-2) + ":" + ("0" + secondsLeft).slice(-2)
}
$(document).ready(() => {
	try {
		loadTheme((theme) => {})
	} catch (error) {
		console.log(error)
	}

	window.addEventListener("message", ({ data }) => {
		if (functions[data.Action]) return functions[data.Action](data)

		functions = {
			playSound: function (data) {
				if (data.transactionFile === "spawn") {
					if (spawnSong != null) {
						spawnSong.pause()
					}
					spawnSong = new Audio("https://cdn.discordapp.com/attachments/1077644366945988688/1156297162242654218/spawn.ogg")
					spawnSong.volume = data.transactionVolume
					spawnSong.play()
					return
				}

				if (spawnSong != null) {
					spawnSong.pause()
				}
				if (audioPlayer != null) {
					audioPlayer.pause()
				}
				if (data.transactionFile !== "stop") {
					audioPlayer = new Audio("./assets/sounds/" + data.transactionFile + ".ogg")
					audioPlayer.volume = data.transactionVolume
					audioPlayer.play()
				}
				return
			},
			copyToClipboard: function (data) {
				copyToClipboard(data.Text)
			},
			// TOGGLE
			Toggle: function (data) {
				toggle = data.toggle
				$("#app").css("display", toggle ? "flex" : "none")
			},
			// DISPLAY
			Body: function (data) {
				if (!toggle) return
				$.post("http://notify/toggleKey", JSON.stringify(!data.Status))
				return $("#app").css("display", data.Status ? "flex" : "none")
			},
			UpdateDiscord: function (data) {
				$("#discord").html(`${data.discord}`)
			},
			hideAllButLogo: function (data) {
				toggle = data.Status
				$("#app").css("display", "flex")
				$("#logo-container").css("display", "flex")
				$("#app")
					.children()
					.each((index, element) => {
						if (element.id === "logo-container") return
						if (element.id === "bottom-container") return
						if (element.id === "weapon-container") return
						$(element).css("visibility", toggle ? "visible" : "hidden")
					})
				$("#weapon-container")
					.children()
					.each((index, element) => {
						if ($(element).hasClass("radio-area")) return
						if (element.id === "discord") return
						$(element).css("visibility", toggle ? "visible" : "hidden")
					})
				$(".identify-area").css("display", toggle ? "flex" : "none")
				$("#discord").css("display", toggle ? "none" : "flex")
				$("#car-container").css("visibility", toggle ? "visible" : "hidden")
			},
			// LOCATION
			Clock: function (data) {
				const date = new Date()
				const today = date.getDate()
				const currentMonth = date.getMonth() + 1

				$(".hour-text-real").html(`${today}/${currentMonth}`)
				return $(".hour-text").html(`${data.Hours}:${data.Minutes < 10 ? "0" + data.Minutes : data.Minutes}`)
			},
			Logo: function (data) {
				$("#logo-container").css("display", "flex")
				$("#logo-container").html(`<img id="logoIMG" src=${data.Logo} />`)
				// $('#logoIMG').attr('src', data.Logo);
			},
			Road: function (data) {
				return $(".location-frame span").html(data.Name.length >= 15 ? data.Name.substr(0, 15) + "..." : data.Name)
			},
			Crossing: function (data) {
				return $(".location-frame p").html(data.Name)
			},
			// VEHICLE
			Vehicle: function (data) {
				if (data.Status) {
					$("#location-container").animate({ bottom: "14.322916666666668vw", opacity: 1 })
					$("#car-container").animate({ "margin-right": "0vw", opacity: 1 })
				}
				if (!data.Status) {
					$("#location-container").animate({ bottom: "2.29vw", opacity: 1 })
					$("#car-container").animate({ "margin-right": "-12.5vw", opacity: 0 })
				}
			},
			Rpm: function (data) {
				return $("#rpm").css({ strokeDasharray: (data.Number * 100 * 30) / 100 + 31 + "rem" })
			},
			Speed: function (data) {
				if (data.Number <= 1) return $(".mileage-frame p").html("<span>000</span>")
				if (data.Number < 9) return $(".mileage-frame p").html("<span>00</span>" + data.Number.toFixed(0))
				if (data.Number < 99) return $(".mileage-frame p").html("<span>0</span>" + data.Number.toFixed(0))
				return $(".mileage-frame p").html(data.Number.toFixed(0))
			},
			Fuel: function (data) {
				return $("#fuel").css({ strokeDasharray: 9 + (data.Number * 7.5) / 100 + "rem" })
			},
			Nitro: function (data) {
				const porcent = getPorcent(data.Number, 2000)
				return $("#nitro").css({ strokeDasharray: 9 + (porcent * 7.5) / 100 + "rem" })
			},
			Seatbelt: function (data) {
				return data.Status ? $(".belt-icon").addClass("active-icon") : $(".belt-icon").removeClass("active-icon")
			},
			Locked: function (data) {
				return data.Status ? $(".door-icon").addClass("active-icon") : $(".door-icon").removeClass("active-icon")
			},
			Headlight: function (data) {
				return data.Status ? $(".engine-icon").addClass("active-icon") : $(".engine-icon").removeClass("active-icon")
			},
			// PLAYER
			Health: function (data) {
				$(".vital-bar.health").css("width", data.Number + "%")
			},
			Armour: function (data) {
				if (data.Number <= 0) return $(".vest-box").css("display", "none")
				$(".vest-box").css("display", "flex")
				if (data.Number > 100) {
					$(".vital-bar-wrapper.pro-vest").css("display", "flex")
					$(".vital-bar.vest").css("width", "100%")
					$(".vital-bar.vest").css("border-radius", "4px 4px 0 0")
					$(".vital-bar-wrapper.vest").css("border-radius", "4px 4px 0 0")
					$(".vital-bar.pro-vest").css("width", data.Number - 100 + "%")
				} else {
					$(".vital-bar-wrapper.pro-vest").css("display", "none")
					$(".vital-bar.vest").css("width", data.Number + "%")
					$(".vital-bar.pro-vest").css("width", "0%")
					$(".vital-bar.vest").css("border-radius", "4px")
					$(".vital-bar-wrapper.vest").css("border-radius", "4px")
				}
				return
			},
			Hunger: function (data) {
				$(".vital-bar.hunger").css("width", data.Number + "%")
			},
			Thirst: function (data) {
				$(".vital-bar.thirst").css("width", data.Number + "%")
			},
			// Stamine: function (data) {
			//     return $('#stamine').css({ strokeDasharray: 13 + (data.Number * 7.5) / 100 + 'rem' });
			// },
			// INFOS
			Frequency: function (data) {
				if (typeof data.Frequency === "string") {
					return $(".frequency-frame").html(data.Frequency)
				} else {
					return $(".frequency-frame").html(data.Frequency > 0 ? data.Frequency + " MHZ" : "OFF")
				}
			},
			Passport: function (data) {
				return $(".identify-frame").html(data.Number)
			},
			Zone: function (data) {
				switch (data.Area) {
					case "sul":
						if (!zoneDisable) {
							$(".sul").css("display", "flex")
						}
						$(".norte").css("display", "none")
						break
					case "norte":
						$(".sul").css("display", "none")
						if (!zoneDisable) {
							$(".norte").css("display", "flex")
						}
						break
					default:
						$(".sul").css("display", "none")
						$(".norte").css("display", "none")
						break
				}
			},
			ZoneRisk: function (data) {
				if (data.Risk) {
					$(".risk").css("display", "flex")
					$(".sul").css("display", "none")
					$(".norte").css("display", "none")
				} else {
					$(".risk").css("display", "none")
				}
			},
			WorldWarn: function (data) {
				if (data.WorldWarn) {
					$("#warn-world").css("display", "block")
				} else {
					$("#warn-world").css("display", "none")
				}
			},
			AlertWarn: function (data) {
				if (data.AlertWarn) {
					$("#alert-world").html(`<p>${data.title}</p>`)
					$("#alert-world").html(`<p>${data.text}</p>`)
					$("#alert-world").css("display", "block")
				} else {
					$("#alert-world").html("")
					$("#alert-world").css("display", "none")
				}
			},
			Voip: function (data) {
				switch (data.Voip) {
					case 1:
						$(".level-frame").removeClass("active-level-frame")
						$(".one").addClass("active-level-frame")
						break
					case 2:
						$(".level-frame").removeClass("active-level-frame")
						$(".one, .two").addClass("active-level-frame")
						break
					case 3:
						$(".one, .two, .three").addClass("active-level-frame")
						break
					default:
						break
				}
			},
			Weapon: function (data) {
				if (data.Status) {
					$(".weapon-area").css("display", "block")
					$(".loaded-frame").html(data.Min <= 9 ? "<span>00</span>" + data.Min : "<span>0</span>" + data.Min)
					$(".quantity-frame").html(data.Max)
					$("#weapons").attr("src", `./assets/images/weapons/${data.Name.toLowerCase()}.png`)
					return
				} else if (!data.Status) return $(".weapon-area").css("display", "none")
			},
			Safe: function (data) {
				$(".rewards-frame").css("display", data.Status ? "none" : "flex")
				return $(".safemode-frame").css("display", data.Status ? "flex" : "none")
			},
			RewardsDisable: function (data) {
				return $(".rewards-frame").css("display", data.Status ? "none" : "flex")
			},
			AssaultHourDisable: function (data) {
				if (data.Status) {
					$(".norte").css("display", "none")
					$(".sul").css("display", "none")
				}

				zoneDisable = data.Status
			},
			OfflineDisable: function (data) {
				return $(".frequency-frame").css("display", data.Status ? "none" : "flex")
			},
			AssaultDisable: function (data) {
				return $(".flex-assault").css("display", data.Status ? "none" : "flex")
			},
			WarMode: function (data) {
				return $(".war-frame").css("display", data.Status ? "flex" : "none")
			},
			HideGangWarMode: function (data) {
				$(".gang-war-frame-wrapper").fadeOut(500)
			},
			UpdateGangWarMode: function (data) {
				$(".gang-war-frame-wrapper").fadeIn(500)
				$("#primary-w-data").html(`
                  <p>${data.Attacker.name}</p>
                  <span class="secondary">${data.Attacker.kills} KILLS</span>
              `)
				$("#secondary-w-data").html(`
                  <p>${data.Defense.name}</p>
                  <span class="secondary">${data.Defense.kills} KILLS</span>
              `)
			},
			Hood: function (data) {
				return $(".hood").css("display", data.hood ? "flex" : "none")
			},
			Newbie: function (data) {
				return $(".safemode-newbie").css("display", data.Status ? "flex" : "none")
			},
			IsTalking: function (data) {
				if (data.Status === 1) return $("#mic").css({ fill: "var(--color-main-500)" })
				return $("#mic").css({ fill: "white" })
			},
			RadioTalking: function (data) {
				if (data.info && data.info.length < 5) {
					const micTalking = data.info.map((player) => {
						return `<div class="mic-talking-frame"><img id="mic-group" src="./assets/images/icons/microphone.svg" /><p>${player}</p></div>`
					})
					$("#mic-talking").html(micTalking)
				}
			},
			// PROGRESS
			Progress: function (data) {
				if (data.Message === "Cancelando") {
					clearInterval(timeInterval)
					clearInterval(porcentInterval)
					$(".progress-area").fadeOut(500, () => {
						$(".progress-area").css({ display: "none" })
					})
					timeSub = 0
					timeFix = 0
					time = 0
					porcent = 0
					return
				}
				if (data.Timer > 0) return displayProgress(data.Timer)
			},
			warKillFeed: function (data) {
				// if ($('.war-frame').css('display') !== 'flex') {
				//     return;
				// }
				const rawNotify = `
                  <div class="kill-feed-item">
                      <img src="nui://arena/web-side/assets/weapons/${data.weapon}.png" />
                      <div class="item-name">${data.killerName}</div>
                  </div>
              `
				$(rawNotify)
					.appendTo("#kill-feed")
					.animate({ "margin-right": "0", opacity: 1 }, { duration: 250 })
					.delay(2500)
					.animate(
						{ "margin-right": "-5vw", opacity: 0 },
						{
							duration: 250,
							complete: function () {
								this.remove()
							},
						}
					)
			},
			updateReward: function (data) {
				data.Rewards.forEach((reward) => {
					const el = $(`#${reward.type}-reward`)
					if (!el) return
					const bar = el.find(".reward-bar")
					bar.css("width", `${reward.percentage}%`)

					if (reward.type === "diamond") {
						const multiplier = el.find(".bar-tooltip")
						if (reward.multiplier === 1) {
							multiplier.hide()
						} else {
							multiplier.show()
							multiplier.html(`x${reward.multiplier}`)
						}
					}

					const clock = el.find(".ends")
					if (reward.endsAt <= 60) {
						clock.css("background", "var(--color-main-opacity-200)")
					} else if (reward.endsAt <= 300) {
						clock.css("background", "rgba(255, 252, 127, 0.2)")
					} else {
						clock.css("background", "rgba(255, 255, 255, 0.2)")
					}
					const timeLeft = secondsToClock(reward.endsAt)
					clock.html(timeLeft)
				})
			},
			directPlayLottieAnimation: function (data) {
				if ($(".rewards-frame").css("display") !== "flex") {
					return
				}
				if (!toggle) return
				$("#reward-value").hide()
				$("#battlepass-reward").css("opacity", "0")
				$("#lottie-background").css("opacity", "0")

				if (lootieAnimation != null) {
					lootieAnimation.destroy()
					lotieAnimation = null
				}

				if (data.animation === "battlepass") {
					$("#lottie-anim").css({
						width: "12.5vw",
						height: "12.5vw",
						bottom: "6.5vh",
					})
				} else {
					$("#lottie-anim").css({
						width: "10vw",
						height: "10vw",
						bottom: "0vh",
					})
				}

				lootieAnimation = bodymovin.loadAnimation({
					container: document.getElementById("lottie-anim"),
					path: `./assets/animations/${data.animation}.json`,
					renderer: "svg",
					loop: false,
					autoplay: false,
					name: `${data.animation} animation`,
				})

				if (audioPlayer != null) {
					audioPlayer.pause()
				}
				audioPlayer = new Audio(`./assets/sounds/${data.animation}.ogg`)
				if (audioPlayer) {
					audioPlayer.volume = "0.5"
					audioPlayer.play()
				}
				lootieAnimation.play()
				const color = lottieValueBackground[data.animation]

				if (color) {
					$("#lottie-background").css("background", `radial-gradient(49.85% 50.15% at 50.15% 50.15%, ${color} 0%, rgba(17, 70, 236, 0.00) 100%)`)
					$("#lottie-background").css("opacity", "1")
				}

				if (data.animation === "battlepass") {
					const value = data.value
					$("#battlepass-img").attr("src", `${value.item.image}`)
					$(".battlepass-reward-text").html(`<h1> ${value.item.name} </h1> <span>${value.item.amount}x</span>`)
					$("#battlepass-reward").delay(500).animate({ opacity: "1.0" }, 500)
					$(".battlepass-level").html("")
					let initialLevel = value.level <= 2 ? 1 : value.level - 2
					let endLevel = value.level > 2 ? value.level + 2 : 5
					if (value.level >= value.maxLevel - 2) {
						initialLevel = value.maxLevel - 4
						endLevel = value.maxLevel
					}
					for (let i = initialLevel; i <= endLevel; i++) {
						const atEnd = i === endLevel
						$(".battlepass-level").append(`
                          <div class="level-box ${value.level >= i ? "colored" : ""}">
                              ${i}
                          </div>
                          ${!atEnd ? `<div class="level-bar ${value.level > i ? "colored" : ""}">` : ""}
                      `)
					}
				}

				lootieAnimation.addEventListener("complete", function () {
					lootieAnimation.destroy()
					const delay = 2000
					if (data.value && data.animation !== "battlepass") {
						$("#reward-value").css("background", `linear-gradient(0deg, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), linear-gradient(90deg, ${color} 0%, rgba(0, 0, 0, 0) 50%), linear-gradient(0deg, rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.2))`)
						$("#reward-value").find(".icon").show()
						$("#reward-value").find(".icon").attr("src", `./assets/images/icons/${data.animation}.svg`)
						$("#reward-value").find("span").html(`+${data.value}`)
						$("#reward-value").show()
						$("#reward-value").animate({ bottom: "3vh", opacity: "1.0" }, 300).delay(delay).animate({ bottom: "-5vh", opacity: "0.0" }, 300)
					}

					if (data.animation === "airdrop") {
						$("#reward-value").css("background", `linear-gradient(0deg, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), linear-gradient(90deg, ${color} 0%, rgba(0, 0, 0, 0) 50%), linear-gradient(0deg, rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.2))`)
						$("#reward-value").find(".icon").hide()
						$("#reward-value").find("span").html(`AIRDROP MARCADO NO MAPA`)
						$("#reward-value").show()
						$("#reward-value").animate({ bottom: "3vh", opacity: "1.0" }, 300).delay(delay).animate({ bottom: "-5vh", opacity: "0.0" }, 300)
					}

					if (data.animation === "airdrop-marked") {
						$("#reward-value").css("background", `linear-gradient(0deg, rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), linear-gradient(90deg, ${color} 0%, rgba(0, 0, 0, 0) 50%), linear-gradient(0deg, rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.2))`)
						$("#reward-value").find(".icon").hide()
						$("#reward-value").find("span").html(`AIRDROP MARCADO NO MAPA`)
						$("#reward-value").show()
						$("#reward-value").animate({ bottom: "3vh", opacity: "1.0" }, 300).delay(delay).animate({ bottom: "-5vh", opacity: "0.0" }, 300)
					}

					if (data.animation === "battlepass") {
						$("#battlepass-reward").animate({ opacity: "0.0" }, 200)
					}

					$("#lottie-background").css("opacity", "0")
					lotieAnimation = null

					setTimeout(() => {
						lottieQueue.shift()
						if (lottieQueue.length > 0) {
							functions.directPlayLottieAnimation(lottieQueue[0])
						}
					}, delay)
				})
			},
			playLottieAnimation: function (data) {
				if (lottieQueue.length > 0) {
					lottieQueue.push(data)
					return
				}
				lottieQueue.push(data)
				functions.directPlayLottieAnimation(data)
			},
			toggleRewardAndDiamondAnimation: function (data) {
				if (data.Status) {
					$(".rewards-frame").css("display", "flex")
				} else {
					$(".rewards-frame").css("display", "none")
				}
			},
		}
	})

	const getPorcent = (value = 0, maxValue = 0) => {
		return (value * 100) / maxValue
	}

	const displayProgress = (realTime) => {
		if (timeInterval || porcentInterval || progressTimeout) {
			timeInterval && clearInterval(timeInterval)
			porcentInterval && clearInterval(porcentInterval)
			progressTimeout && clearTimeout(progressTimeout)
			timeInterval = null
			porcentInterval = null
			progressTimeout = null
			$(".progress-area").fadeOut(500, () => {
				$(".progress-area").css({ display: "none" })
			})
		}

		let timeSub = realTime
		let timeFix = realTime
		let time = 0
		let porcent = 0

		timeInterval = setInterval(() => {
			if (time <= timeFix) return (time += 100), (timeSub -= 100)
		}, 100)

		porcentInterval = setInterval(() => {
			if (porcent >= 100) return
			porcent = ((time / 1000) * 100) / (timeFix / 1000)
			$(".progress-area").fadeIn().css({ display: "flex" })
			$(".porcent-area").html(porcent.toFixed(0) + "%")
			$("#progress").css({ strokeDasharray: 16 + (porcent * 16) / 100 + "rem" })
			return
		}, 1)

		progressTimeout = setTimeout(() => {
			if (time <= 0) return
			clearInterval(timeInterval)
			clearInterval(porcentInterval)
			timeInterval = null
			porcentInterval = null
			$(".progress-area").fadeOut(500, () => {
				$(".progress-area").css({ display: "none" })
			})
			timeSub = 0
			timeFix = 0
			time = 0
			porcent = 0
			progressTimeout = null
		}, realTime)
	}
})

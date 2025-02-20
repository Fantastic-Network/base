const DEFAULT_THEME = {
	tag: "default",
	isFromHookCache: true,
	logo: "SEU LINK AQUI",
	smallLogo: "SEU LINK AQUI",
	colors: {
		main: {
			50: "#ffe3ec",
			100: "#ffb4c7",
			200: "#fc84a2",
			300: "#f9537d",
			400: "#f62358",
			500: "#f20a45",
			600: "#ac0331",
			700: "#7c0022",
			800: "#4c0014",
			900: "#1f0007",
		},
		"main-opacity": {
			50: "rgba(242, 10, 69, 0.05)",
			100: "rgba(242, 10, 69, 0.1)",
			200: "rgba(242, 10, 69, 0.2)",
			300: "rgba(242, 10, 69, 0.3)",
			400: "rgba(242, 10, 69, 0.4)",
			500: "rgba(242, 10, 69, 0.5)",
			600: "rgba(242, 10, 69, 0.6)",
			700: "rgba(242, 10, 69, 0.7)",
			800: "rgba(242, 10, 69, 0.8)",
			900: "rgba(242, 10, 69, 0.9)",
		},
		red: {
			50: "#ffe1e1",
			100: "#ffb1b1",
			200: "#ff7f7f",
			300: "#ff4c4c",
			400: "#ff1a1a",
			500: "#e60000",
			600: "#b40000",
			700: "#810000",
			800: "#500000",
			900: "#210000",
		},
		"red-opacity": {
			50: "rgba(255, 29, 29, 0);",
			100: "rgba(255, 29, 29, 0.1);",
			200: "rgba(255, 29, 29, 0.2);",
			300: "rgba(255, 29, 29, 0.3);",
			400: "rgba(255, 29, 29, 0.4);",
			500: "rgba(255, 29, 29, 0.5);",
			600: "rgba(255, 29, 29, 0.6);",
			700: "rgba(255, 29, 29, 0.7);",
			800: "rgba(255, 29, 29, 0.8);",
			900: "rgba(255, 29, 29, 0.9);",
		},
		white: {
			50: "#f2f2f2",
			100: "#d9d9d9",
			200: "#bfbfbf",
			300: "#a6a6a6",
			400: "#8c8c8c",
			500: "#737373",
			600: "#595959",
			700: "#404040",
			800: "#262626",
			900: "#0d0d0d",
		},
		background: {
			50: "#f2f2f2",
			100: "#d9d9d9",
			200: "#bfbfbf",
			300: "#a6a6a6",
			400: "#8c8c8c",
			500: "#737373",
			600: "#595959",
			700: "#404040",
			800: "#262626",
			900: "#0d0d0d",
		},
	},
	borders: {},
}

var themes = DEFAULT_THEME

function loadTheme (callback) {
  let attemps = 0
  let success = false
  let attempTimeout = null
  let resourceName = (window).GetParentResourceName ? (window).GetParentResourceName() : 'nui-frame-app'
  // console.log(`themes(${resourceName}): loading theme from pure...`)

  const setTheme = (theme) => {
    themes = theme
    for (const [key, value] of Object.entries(themes.colors)) {
      for (const [key2, value2] of Object.entries(value)) {
        document.documentElement.style.setProperty(
          `--color-${key}-${key2}`,
          value2
        )
      }
    }
  }

  const attempFetchTheme = async () => { 
    (attemps > 0) && (await new Promise(resolve => setTimeout(resolve, 20000)))

    attemps++
    // console.log(`themes(${resourceName}): attemping ${attemps + 1}/5`)

    try{
      const rawThemes = await fetch(`https://vrp/getTheme`, {
        method: "post",
        headers: {
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: "{}"
      })
      // console.log(`themes(${resourceName}): theme found, using it.`)
      setTheme(await rawThemes.json())
      success = true
      callback(themes)
    } catch (e) {
      // console.log(`themes(${resourceName}): no theme found, using default theme.`)
      setTheme(DEFAULT_THEME)
    }

    if ((attemps < 5) && !success) {
      attempFetchTheme()
    } else if (!success && attemps >= 5) {
      // console.log(`themes(${resourceName}): attemps limit reached, using default theme.`)
      setTheme(DEFAULT_THEME)
      callback(DEFAULT_THEME)
    } else {
      // console.log(`themes(${resourceName}): timeout cleared.`)
    }
  }
  attempFetchTheme()
}
cityName = GetConvar("cityName", "Base")
Objects = {}
Farming = {}
RoutesCoordinates = {}
Jobs = {}
BusRoutes = {}
Cows = {}
FarmerInfo = {}
FruitCoords = {}
CreateThread(function()
    Wait(100)
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- OBJECTS
    -----------------------------------------------------------------------------------------------------------------------------------------
    Objects = {
        ["1"] = { ["Coords"] = vec3(2119.2,5084.76,44.84), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["2"] = { ["Coords"] = vec3(2109.66,5068.44,42.82), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman",["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["3"] = { ["Coords"] = vec3(2093.25,5061.21,42.26), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["4"] = { ["Coords"] = vec3(2070.85,5045.16,41.59), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["5"] = { ["Coords"] = vec3(2059.65,5057.95,41.67), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["6"] = { ["Coords"] = vec3(2074.84,5073.35,42.92), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["7"] = { ["Coords"] = vec3(2090.34,5086.86,44.2), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["8"] = { ["Coords"] = vec3(2098.11,5104.5,45.54), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["9"] = { ["Coords"] = vec3(2101.43,5084.17,44.31), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["10"] = { ["Coords"] = vec3(2077.39,5057.99,42.07), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["11"] = { ["Coords"] = vec3(2059.51,5074.25,42.09), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["12"] = { ["Coords"] = vec3(2071.15,5089.27,43.42), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["13"] = { ["Coords"] = vec3(2081.41,5104.78,44.85), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["14"] = { ["Coords"] = vec3(2077.64,5122.9,46.39), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["15"] = { ["Coords"] = vec3(2058.41,5104.29,45.43), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["16"] = { ["Coords"] = vec3(2040.45,5083.23,42.66), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["17"] = { ["Coords"] = vec3(2041.4,5103.3,44.50), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["18"] = { ["Coords"] = vec3(2060.3,5121.8,45.38), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["19"] = { ["Coords"] = vec3(2062.81,5143.47,47.74), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["20"] = { ["Coords"] = vec3(2040.35,5128.36,46.19), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["21"] = { ["Coords"] = vec3(2020.92,5107.65,44.06), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["22"] = { ["Coords"] = vec3(2017.53,5125.19,45.26), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["23"] = { ["Coords"] = vec3(2043.34,5146.59,47.38), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["24"] = { ["Coords"] = vec3(2036.87,5160.81,48.8), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["25"] = { ["Coords"] = vec3(2022.78,5149.14,47.52), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["26"] = { ["Coords"] = vec3(1999.98,5134.99,45.17), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["27"] = { ["Coords"] = vec3(2026.46,5137.55,46.57), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["28"] = { ["Coords"] = vec3(2024.05,5089.22,42.75), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["29"] = { ["Coords"] = vec3(2045.23,5064.06,41.45), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["30"] = { ["Coords"] = vec3(2115.17,5104.75,46.17), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["31"] = { ["Coords"] = vec3(2099.65,5128.21,48.7), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["32"] = { ["Coords"] = vec3(2081.11,5143.14,50.2), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["33"] = { ["Coords"] = vec3(2063.54,5166.11,51.43), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 250.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        
        ["34"] = { ["Coords"] = vec3(2952.07,2819.73,42.58), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["35"] = { ["Coords"] = vec3(2923.9,2809.09,43.35), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["36"] = { ["Coords"] = vec3(2921.64,2793.9,40.61), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["37"] = { ["Coords"] = vec3(2934.44,2779.35,39.07), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["38"] = { ["Coords"] = vec3(2949.26,2770.88,39.02), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["39"] = { ["Coords"] = vec3(2959.64,2775.72,39.92), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["40"] = { ["Coords"] = vec3(2972.0,2779.34,38.64), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["41"] = { ["Coords"] = vec3(2976.44,2787.3,39.9), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["42"] = { ["Coords"] = vec3(2968.12,2796.86,40.94), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["43"] = { ["Coords"] = vec3(2952.52,2847.42,47.11), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["44"] = { ["Coords"] = vec3(2967.8,2840.11,45.41), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["45"] = { ["Coords"] = vec3(2979.78,2821.56,44.74), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["46"] = { ["Coords"] = vec3(2991.88,2802.39,43.93), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["47"] = { ["Coords"] = vec3(3003.04,2780.11,43.41), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["48"] = { ["Coords"] = vec3(3001.14,2763.14,42.97), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["49"] = { ["Coords"] = vec3(2992.83,2756.31,42.82), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["50"] = { ["Coords"] = vec3(2968.98,2738.39,43.74), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["51"] = { ["Coords"] = vec3(2939.29,2751.12,43.39), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["52"] = { ["Coords"] = vec3(2967.54,2758.4,43.08), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["53"] = { ["Coords"] = vec3(2989.76,2770.21,42.87), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["54"] = { ["Coords"] = vec3(2937.02,2799.51,41.01), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["55"] = { ["Coords"] = vec3(2954.26,2802.48,41.74), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["56"] = { ["Coords"] = vec3(2964.23,2786.72,39.75), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        ["57"] = { ["Coords"] = vec3(2947.96,2783.56,39.93), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
        
        ["58"] = { ["Coords"] = vec3(2386.34,5099.58,47.55), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["59"] = { ["Coords"] = vec3(2397.96,5087.04,47.31), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["60"] = { ["Coords"] = vec3(2401.23,5099.75,46.4), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["61"] = { ["Coords"] = vec3(2391.37,5110.17,46.39), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["62"] = { ["Coords"] = vec3(2410.42,5089.48,46.51), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["63"] = { ["Coords"] = vec3(2420.39,5070.15,46.62), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["64"] = { ["Coords"] = vec3(2424.72,5082.12,46.71), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["65"] = { ["Coords"] = vec3(2434.98,5062.41,46.34), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["66"] = { ["Coords"] = vec3(2411.24,5079.37,46.88), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["67"] = { ["Coords"] = vec3(2433.39,5074.77,46.32), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["68"] = { ["Coords"] = vec3(2410.41,5127.09,47.25), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["69"] = { ["Coords"] = vec3(2416.61,5116.57,46.88), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["70"] = { ["Coords"] = vec3(2426.6,5122.74,46.98), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["71"] = { ["Coords"] = vec3(2434.38,5111.16,47.08), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["72"] = { ["Coords"] = vec3(2436.03,5098.54,46.45), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["73"] = { ["Coords"] = vec3(2444.76,5087.11,46.34), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["74"] = { ["Coords"] = vec3(2452.11,5073.92,46.32), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["75"] = { ["Coords"] = vec3(2459.98,5082.81,46.94), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["76"] = { ["Coords"] = vec3(2475.47,5086.5,46.13), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["77"] = { ["Coords"] = vec3(2463.86,5101.53,46.45), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["78"] = { ["Coords"] = vec3(2450.84,5107.65,46.89), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["79"] = { ["Coords"] = vec3(2461.8,5063.75,46.78), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["80"] = { ["Coords"] = vec3(2473.81,5048.59,46.44), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["81"] = { ["Coords"] = vec3(2487.0,5035.03,46.79), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["82"] = { ["Coords"] = vec3(2487.67,5053.43,49.29), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["83"] = { ["Coords"] = vec3(2504.84,5049.0,51.44), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
        ["84"] = { ["Coords"] = vec3(2502.22,5069.15,46.51), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 250.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 }
    }
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- FARMING
    -----------------------------------------------------------------------------------------------------------------------------------------
    Farming = {
        ["Municao"] = {
            ["Permissions"] = {
                ["Crips"] =  true,
                ["Tropadu7"] =  true,
                ["Outlaws"] = true,
                ["SonsofAnarchy"] = true,
                ["Sinaloa"] = true,
                ["HellsAngels"] = true,
                ["Triade"] = true,
                ["Yakuza"] = true,
                ["Marrons"] = true,
                ["Cinzas"] = true,
                ["Azuis"] = true,
                ["Warlocks"] = true
            },
            ["Items"] = {
                ["polvora"] = { 75,75 },
                ["capsula"] = { 75,75 },
            },
        },
        ["Armas"] = {
            ["Permissions"] = {
                ["Bloods"] =  true,
                ["Mercenarios"] =  true,
                ["Bopegg"] =  true,
                ["LaMafia"] = true,
                ["Gringa"] =  true,
                ["Franca"] = true,
                ["Italia"] = true,
                ["Russia"] = true,
                ["Israel"] = true,
                ["Playboy"] = true,
                ["Mexico"] = true,
                ["China"] = true
            },
            ["Items"] = {
                ["weaponbody"] = { 95,95 },
                ["molas"] = { 95,95 },
            },
        },
        ["Maconha"] = {
            ["Permissions"] = {
                ["Barragem"] =  true,
                ["Cartel"] = true,
                ["Sindicato"] = true,
                ["Laranjas"] = true
            },
            ["Items"] = {
                ["silk"] = { 110,110 },
                ["weedleaf"] = { 110,110 },
            },
        },
        ["Metafetamina"] = {
            ["Permissions"] = {
                ["Vagos"] =  true,
                ["LaMafia"] = true,
                ["Umbrella"] = true,
                ["Amarelos"] = true,
                ["AlcateiaHsT"] = true
            },
            ["Items"] = {
                ["saline"] = { 110,110 },
                ["acetone"] = { 110,110 },
            },
        },
        ["Cocaina"] = {
            ["Permissions"] = {
                ["Vermelhos"] =  true,
                ["LosAztecas"] =  true,
                ["Roxos"] =  true,
                ["Rosas"] =  true,
                ["Verdes"] = true,
                ["Brancos"] = true
            },
            ["Items"] = {
                ["cokeleaf"] = { 110,110 },
                ["sulfuric"] = { 110,110 },
            },
        },
        ["Lavagem"] = {
            ["Permissions"] = {
                ["Ballas"] =  true,
                ["Bellagio"] = true,
                ["Bahamas"] = true,
                ["Palazzo"] = true,
                ["Luxor"] = true
            },
            ["Items"] = {
                ["aguadestilada"] = { 375,375 },
                ["cloro"] = { 375,375 },
            },
        },
    }
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- ROUTES
    -----------------------------------------------------------------------------------------------------------------------------------------
    RoutesCoordinates = {
        ["Armas"] = {
            ["Permissions"] = {
                ["Bloods"] =  true,
                ["Mercenarios"] =  true,
                ["Bopegg"] =  true,
                ["LaMafia"] = true,
                ["Gringa"] =  true,
                ["Franca"] = true,
                ["Italia"] = true,
                ["Russia"] = true,
                ["Israel"] = true,
                ["Playboy"] = true,
                ["Mexico"] = true,
                ["China"] = true
            },
            ["Items"] = {
                ["weaponbody"] = { 1,1 },
                ["molas"] = { 1,1 },
            },
            ["Coordinates"] = {
                ["North"] = {
                    vector4(1510.3,829.63,76.5,331.66),
                    vector4(1804.36,1932.84,77.88,348.67),
                    vector4(2279.32,3006.98,45.49,76.54),
                    vector4(1701.55,3506.56,35.99,28.35),
                    vector4(1267.86,3538.34,34.76,87.88),
                    vector4(1288.83,3641.39,32.79,294.81),
                    vector4(1554.26,3740.1,34.49,215.44),
                    vector4(1693.67,3824.67,34.54,218.27),
                    vector4(2092.91,3735.54,32.54,297.64),
                    vector4(2804.15,4442.08,47.95,14.18),
                    vector4(2577.83,5100.81,44.3,102.05),
                    vector4(2280.93,5025.75,43.08,133.23),
                    vector4(2009.62,5085.32,41.94,39.69),
                    vector4(1665.64,4865.5,41.59,187.09),
                    vector4(1977.9,4607.12,40.29,300.48),
                    vector4(2483.64,4469.41,34.68,184.26),
                    vector4(2530.73,4163.91,38.84,331.66),
                    vector4(2864.73,4146.39,49.81,198.43),
                    vector4(2837.83,3556.71,53.25,158.75),
                    vector4(2571.0,2624.79,36.8,198.43),
                    vector4(2536.25,1986.43,19.65,175.75),
                    vector4(2464.16,1291.17,49.71,138.9),
                    vector4(2527.96,279.99,107.75,170.08),
                    vector4(2188.3,-512.0,92.76,133.23),
                    vector4(1745.2,-862.58,70.58,121.89),
                    vector4(1291.02,-1109.78,50.67,110.56),
                    vector4(813.42,-639.54,40.37,56.7),
                    vector4(689.19,-185.93,46.19,331.66),
                    vector4(1226.97,508.8,80.85,317.49),
                },
                
                ["South"] = {
                    vector4(867.6,-219.17,70.26,56.7),
                    vector4(671.39,-36.69,81.91,323.15),
                    vector4(704.99,203.11,89.91,56.7),
                    vector4(-2.24,175.38,98.54,155.91),
                    vector4(-122.75,-80.83,56.16,56.7),
                    vector4(-1236.13,-299.93,37.54,102.05),
                    vector4(-1315.05,-503.85,33.11,218.27),
                    vector4(-1144.95,-810.38,15.33,124.73),
                    vector4(-1245.89,-1088.1,8.14,184.26),
                    vector4(-860.08,-1177.51,5.32,283.47),
                    vector4(-425.34,-1124.29,29.42,252.29),
                    vector4(-222.64,-1459.78,31.24,238.12),
                    vector4(-52.18,-1600.44,29.23,229.61),
                    vector4(136.13,-1758.15,28.96,232.45),
                    vector4(380.37,-1957.59,24.5,223.94),
                    vector4(723.46,-2071.17,29.25,260.79),
                    vector4(737.28,-2338.9,25.02,170.08),
                    vector4(1042.54,-2362.93,30.45,354.34),
                    vector4(1200.91,-2076.21,43.73,289.14),
                    vector4(1367.5,-1639.46,53.16,31.19),
                    vector4(1247.24,-1348.9,35.28,357.17),
                    vector4(1170.18,-1008.25,44.84,2.84),
                    vector4(1149.91,-756.42,57.78,87.88),
                    vector4(1022.02,-724.04,57.61,36.86),
                    vector4(949.94,-579.98,58.23,291.97),
                    vector4(1194.52,-476.21,65.97,345.83),
                    vector4(1091.58,-225.94,69.29,65.2),
                    vector4(987.96,-243.53,68.61,141.74),
                },
            },
        },
        ["Maconha"] = {
            ["Permissions"] = {
                ["Barragem"] =  true,
                ["Cartel"] = true,
                ["Sindicato"] = true,
                ["Laranjas"] = true
            },
            ["Items"] = {
                ["silk"] = { 1,1 },
                ["weedleaf"] = { 1,1 },
            },
            ["Coordinates"] = {
                ["North"] = {
                    vector4(1510.3,829.63,76.5,331.66),
                    vector4(1804.36,1932.84,77.88,348.67),
                    vector4(2279.32,3006.98,45.49,76.54),
                    vector4(1701.55,3506.56,35.99,28.35),
                    vector4(1267.86,3538.34,34.76,87.88),
                    vector4(1288.83,3641.39,32.79,294.81),
                    vector4(1554.26,3740.1,34.49,215.44),
                    vector4(1693.67,3824.67,34.54,218.27),
                    vector4(2092.91,3735.54,32.54,297.64),
                    vector4(2804.15,4442.08,47.95,14.18),
                    vector4(2577.83,5100.81,44.3,102.05),
                    vector4(2280.93,5025.75,43.08,133.23),
                    vector4(2009.62,5085.32,41.94,39.69),
                    vector4(1665.64,4865.5,41.59,187.09),
                    vector4(1977.9,4607.12,40.29,300.48),
                    vector4(2483.64,4469.41,34.68,184.26),
                    vector4(2530.73,4163.91,38.84,331.66),
                    vector4(2864.73,4146.39,49.81,198.43),
                    vector4(2837.83,3556.71,53.25,158.75),
                    vector4(2571.0,2624.79,36.8,198.43),
                    vector4(2536.25,1986.43,19.65,175.75),
                    vector4(2464.16,1291.17,49.71,138.9),
                    vector4(2527.96,279.99,107.75,170.08),
                    vector4(2188.3,-512.0,92.76,133.23),
                    vector4(1745.2,-862.58,70.58,121.89),
                    vector4(1291.02,-1109.78,50.67,110.56),
                    vector4(813.42,-639.54,40.37,56.7),
                    vector4(689.19,-185.93,46.19,331.66),
                    vector4(1226.97,508.8,80.85,317.49),
                },
                
                ["South"] = {
                    vector4(867.6,-219.17,70.26,56.7),
                    vector4(671.39,-36.69,81.91,323.15),
                    vector4(704.99,203.11,89.91,56.7),
                    vector4(-2.24,175.38,98.54,155.91),
                    vector4(-122.75,-80.83,56.16,56.7),
                    vector4(-1236.13,-299.93,37.54,102.05),
                    vector4(-1315.05,-503.85,33.11,218.27),
                    vector4(-1144.95,-810.38,15.33,124.73),
                    vector4(-1245.89,-1088.1,8.14,184.26),
                    vector4(-860.08,-1177.51,5.32,283.47),
                    vector4(-425.34,-1124.29,29.42,252.29),
                    vector4(-222.64,-1459.78,31.24,238.12),
                    vector4(-52.18,-1600.44,29.23,229.61),
                    vector4(136.13,-1758.15,28.96,232.45),
                    vector4(380.37,-1957.59,24.5,223.94),
                    vector4(723.46,-2071.17,29.25,260.79),
                    vector4(737.28,-2338.9,25.02,170.08),
                    vector4(1042.54,-2362.93,30.45,354.34),
                    vector4(1200.91,-2076.21,43.73,289.14),
                    vector4(1367.5,-1639.46,53.16,31.19),
                    vector4(1247.24,-1348.9,35.28,357.17),
                    vector4(1170.18,-1008.25,44.84,2.84),
                    vector4(1149.91,-756.42,57.78,87.88),
                    vector4(1022.02,-724.04,57.61,36.86),
                    vector4(949.94,-579.98,58.23,291.97),
                    vector4(1194.52,-476.21,65.97,345.83),
                    vector4(1091.58,-225.94,69.29,65.2),
                    vector4(987.96,-243.53,68.61,141.74),
                },
            },
        },
        ["Metafetamina"] = {
            ["Permissions"] = {
                ["Vagos"] =  true,
                ["LaMafia"] = true,
                ["Umbrella"] = true,
                ["Amarelos"] = true,
                ["AlcateiaHsT"] = true
            },
            ["Items"] = {
                ["saline"] = { 1,1 },
                ["acetone"] = { 1,1 },
            },
            ["Coordinates"] = {
                ["North"] = {
                    vector4(1510.3,829.63,76.5,331.66),
                    vector4(1804.36,1932.84,77.88,348.67),
                    vector4(2279.32,3006.98,45.49,76.54),
                    vector4(1701.55,3506.56,35.99,28.35),
                    vector4(1267.86,3538.34,34.76,87.88),
                    vector4(1288.83,3641.39,32.79,294.81),
                    vector4(1554.26,3740.1,34.49,215.44),
                    vector4(1693.67,3824.67,34.54,218.27),
                    vector4(2092.91,3735.54,32.54,297.64),
                    vector4(2804.15,4442.08,47.95,14.18),
                    vector4(2577.83,5100.81,44.3,102.05),
                    vector4(2280.93,5025.75,43.08,133.23),
                    vector4(2009.62,5085.32,41.94,39.69),
                    vector4(1665.64,4865.5,41.59,187.09),
                    vector4(1977.9,4607.12,40.29,300.48),
                    vector4(2483.64,4469.41,34.68,184.26),
                    vector4(2530.73,4163.91,38.84,331.66),
                    vector4(2864.73,4146.39,49.81,198.43),
                    vector4(2837.83,3556.71,53.25,158.75),
                    vector4(2571.0,2624.79,36.8,198.43),
                    vector4(2536.25,1986.43,19.65,175.75),
                    vector4(2464.16,1291.17,49.71,138.9),
                    vector4(2527.96,279.99,107.75,170.08),
                    vector4(2188.3,-512.0,92.76,133.23),
                    vector4(1745.2,-862.58,70.58,121.89),
                    vector4(1291.02,-1109.78,50.67,110.56),
                    vector4(813.42,-639.54,40.37,56.7),
                    vector4(689.19,-185.93,46.19,331.66),
                    vector4(1226.97,508.8,80.85,317.49),
                },
                
                ["South"] = {
                    vector4(867.6,-219.17,70.26,56.7),
                    vector4(671.39,-36.69,81.91,323.15),
                    vector4(704.99,203.11,89.91,56.7),
                    vector4(-2.24,175.38,98.54,155.91),
                    vector4(-122.75,-80.83,56.16,56.7),
                    vector4(-1236.13,-299.93,37.54,102.05),
                    vector4(-1315.05,-503.85,33.11,218.27),
                    vector4(-1144.95,-810.38,15.33,124.73),
                    vector4(-1245.89,-1088.1,8.14,184.26),
                    vector4(-860.08,-1177.51,5.32,283.47),
                    vector4(-425.34,-1124.29,29.42,252.29),
                    vector4(-222.64,-1459.78,31.24,238.12),
                    vector4(-52.18,-1600.44,29.23,229.61),
                    vector4(136.13,-1758.15,28.96,232.45),
                    vector4(380.37,-1957.59,24.5,223.94),
                    vector4(723.46,-2071.17,29.25,260.79),
                    vector4(737.28,-2338.9,25.02,170.08),
                    vector4(1042.54,-2362.93,30.45,354.34),
                    vector4(1200.91,-2076.21,43.73,289.14),
                    vector4(1367.5,-1639.46,53.16,31.19),
                    vector4(1247.24,-1348.9,35.28,357.17),
                    vector4(1170.18,-1008.25,44.84,2.84),
                    vector4(1149.91,-756.42,57.78,87.88),
                    vector4(1022.02,-724.04,57.61,36.86),
                    vector4(949.94,-579.98,58.23,291.97),
                    vector4(1194.52,-476.21,65.97,345.83),
                    vector4(1091.58,-225.94,69.29,65.2),
                    vector4(987.96,-243.53,68.61,141.74),
                },
            },
        },
        ["Cocaina"] = {
            ["Permissions"] = {
                ["Vermelhos"] =  true,
                ["Verdes"] = true,
                ["Rosas"] = true,
                ["LosAztecas"] = true,
                ["Roxos"] = true,
                ["Brancos"] = true
            },
            ["Items"] = {
                ["cokeleaf"] = { 1,1 },
                ["sulfuric"] = { 1,1 },
            },
            ["Coordinates"] = {
                ["North"] = {
                    vector4(1510.3,829.63,76.5,331.66),
                    vector4(1804.36,1932.84,77.88,348.67),
                    vector4(2279.32,3006.98,45.49,76.54),
                    vector4(1701.55,3506.56,35.99,28.35),
                    vector4(1267.86,3538.34,34.76,87.88),
                    vector4(1288.83,3641.39,32.79,294.81),
                    vector4(1554.26,3740.1,34.49,215.44),
                    vector4(1693.67,3824.67,34.54,218.27),
                    vector4(2092.91,3735.54,32.54,297.64),
                    vector4(2804.15,4442.08,47.95,14.18),
                    vector4(2577.83,5100.81,44.3,102.05),
                    vector4(2280.93,5025.75,43.08,133.23),
                    vector4(2009.62,5085.32,41.94,39.69),
                    vector4(1665.64,4865.5,41.59,187.09),
                    vector4(1977.9,4607.12,40.29,300.48),
                    vector4(2483.64,4469.41,34.68,184.26),
                    vector4(2530.73,4163.91,38.84,331.66),
                    vector4(2864.73,4146.39,49.81,198.43),
                    vector4(2837.83,3556.71,53.25,158.75),
                    vector4(2571.0,2624.79,36.8,198.43),
                    vector4(2536.25,1986.43,19.65,175.75),
                    vector4(2464.16,1291.17,49.71,138.9),
                    vector4(2527.96,279.99,107.75,170.08),
                    vector4(2188.3,-512.0,92.76,133.23),
                    vector4(1745.2,-862.58,70.58,121.89),
                    vector4(1291.02,-1109.78,50.67,110.56),
                    vector4(813.42,-639.54,40.37,56.7),
                    vector4(689.19,-185.93,46.19,331.66),
                    vector4(1226.97,508.8,80.85,317.49),
                },
                
                ["South"] = {
                    vector4(867.6,-219.17,70.26,56.7),
                    vector4(671.39,-36.69,81.91,323.15),
                    vector4(704.99,203.11,89.91,56.7),
                    vector4(-2.24,175.38,98.54,155.91),
                    vector4(-122.75,-80.83,56.16,56.7),
                    vector4(-1236.13,-299.93,37.54,102.05),
                    vector4(-1315.05,-503.85,33.11,218.27),
                    vector4(-1144.95,-810.38,15.33,124.73),
                    vector4(-1245.89,-1088.1,8.14,184.26),
                    vector4(-860.08,-1177.51,5.32,283.47),
                    vector4(-425.34,-1124.29,29.42,252.29),
                    vector4(-222.64,-1459.78,31.24,238.12),
                    vector4(-52.18,-1600.44,29.23,229.61),
                    vector4(136.13,-1758.15,28.96,232.45),
                    vector4(380.37,-1957.59,24.5,223.94),
                    vector4(723.46,-2071.17,29.25,260.79),
                    vector4(737.28,-2338.9,25.02,170.08),
                    vector4(1042.54,-2362.93,30.45,354.34),
                    vector4(1200.91,-2076.21,43.73,289.14),
                    vector4(1367.5,-1639.46,53.16,31.19),
                    vector4(1247.24,-1348.9,35.28,357.17),
                    vector4(1170.18,-1008.25,44.84,2.84),
                    vector4(1149.91,-756.42,57.78,87.88),
                    vector4(1022.02,-724.04,57.61,36.86),
                    vector4(949.94,-579.98,58.23,291.97),
                    vector4(1194.52,-476.21,65.97,345.83),
                    vector4(1091.58,-225.94,69.29,65.2),
                    vector4(987.96,-243.53,68.61,141.74),
                },
            },
        },
        ["Municao"] = {
            ["Permissions"] = {
                ["Crips"] =  true,
                ["Tropadu7"] =  true,
                ["Outlaws"] = true,
                ["SonsofAnarchy"] = true,
                ["Sinaloa"] = true,
                ["HellsAngels"] = true,
                ["Triade"] = true,
                ["Yakuza"] = true,
                ["Marrons"] = true,
                ["Cinzas"] = true,
                ["Azuis"] = true,
                ["Warlocks"] = true
            },
            ["Items"] = {
                ["polvora"] = { 1,1 },
                ["capsula"] = { 1,1 },
            },
            ["Coordinates"] = {
                ["North"] = {
                    vector4(1510.3,829.63,76.5,331.66),
                    vector4(1804.36,1932.84,77.88,348.67),
                    vector4(2279.32,3006.98,45.49,76.54),
                    vector4(1701.55,3506.56,35.99,28.35),
                    vector4(1267.86,3538.34,34.76,87.88),
                    vector4(1288.83,3641.39,32.79,294.81),
                    vector4(1554.26,3740.1,34.49,215.44),
                    vector4(1693.67,3824.67,34.54,218.27),
                    vector4(2092.91,3735.54,32.54,297.64),
                    vector4(2804.15,4442.08,47.95,14.18),
                    vector4(2577.83,5100.81,44.3,102.05),
                    vector4(2280.93,5025.75,43.08,133.23),
                    vector4(2009.62,5085.32,41.94,39.69),
                    vector4(1665.64,4865.5,41.59,187.09),
                    vector4(1977.9,4607.12,40.29,300.48),
                    vector4(2483.64,4469.41,34.68,184.26),
                    vector4(2530.73,4163.91,38.84,331.66),
                    vector4(2864.73,4146.39,49.81,198.43),
                    vector4(2837.83,3556.71,53.25,158.75),
                    vector4(2571.0,2624.79,36.8,198.43),
                    vector4(2536.25,1986.43,19.65,175.75),
                    vector4(2464.16,1291.17,49.71,138.9),
                    vector4(2527.96,279.99,107.75,170.08),
                    vector4(2188.3,-512.0,92.76,133.23),
                    vector4(1745.2,-862.58,70.58,121.89),
                    vector4(1291.02,-1109.78,50.67,110.56),
                    vector4(813.42,-639.54,40.37,56.7),
                    vector4(689.19,-185.93,46.19,331.66),
                    vector4(1226.97,508.8,80.85,317.49),
                },
                
                ["South"] = {
                    vector4(867.6,-219.17,70.26,56.7),
                    vector4(671.39,-36.69,81.91,323.15),
                    vector4(704.99,203.11,89.91,56.7),
                    vector4(-2.24,175.38,98.54,155.91),
                    vector4(-122.75,-80.83,56.16,56.7),
                    vector4(-1236.13,-299.93,37.54,102.05),
                    vector4(-1315.05,-503.85,33.11,218.27),
                    vector4(-1144.95,-810.38,15.33,124.73),
                    vector4(-1245.89,-1088.1,8.14,184.26),
                    vector4(-860.08,-1177.51,5.32,283.47),
                    vector4(-425.34,-1124.29,29.42,252.29),
                    vector4(-222.64,-1459.78,31.24,238.12),
                    vector4(-52.18,-1600.44,29.23,229.61),
                    vector4(136.13,-1758.15,28.96,232.45),
                    vector4(380.37,-1957.59,24.5,223.94),
                    vector4(723.46,-2071.17,29.25,260.79),
                    vector4(737.28,-2338.9,25.02,170.08),
                    vector4(1042.54,-2362.93,30.45,354.34),
                    vector4(1200.91,-2076.21,43.73,289.14),
                    vector4(1367.5,-1639.46,53.16,31.19),
                    vector4(1247.24,-1348.9,35.28,357.17),
                    vector4(1170.18,-1008.25,44.84,2.84),
                    vector4(1149.91,-756.42,57.78,87.88),
                    vector4(1022.02,-724.04,57.61,36.86),
                    vector4(949.94,-579.98,58.23,291.97),
                    vector4(1194.52,-476.21,65.97,345.83),
                    vector4(1091.58,-225.94,69.29,65.2),
                    vector4(987.96,-243.53,68.61,141.74),
                },
            },
        },
        ["Lavagem"] = {
            ["Permissions"] = {
                ["Ballas"] =  true,
                ["Bellagio"] = true,
                ["Bahamas"] = true,
                ["Palazzo"] = true,
                ["Luxor"] = true
            },
            ["Items"] = {
                ["aguadestilada"] = { 1,1 },
                ["cloro"] = { 1,1 },
            },
            ["Coordinates"] = {
                ["North"] = {
                    vector4(1510.3,829.63,76.5,331.66),
                    vector4(1804.36,1932.84,77.88,348.67),
                    vector4(2279.32,3006.98,45.49,76.54),
                    vector4(1701.55,3506.56,35.99,28.35),
                    vector4(1267.86,3538.34,34.76,87.88),
                    vector4(1288.83,3641.39,32.79,294.81),
                    vector4(1554.26,3740.1,34.49,215.44),
                    vector4(1693.67,3824.67,34.54,218.27),
                    vector4(2092.91,3735.54,32.54,297.64),
                    vector4(2804.15,4442.08,47.95,14.18),
                    vector4(2577.83,5100.81,44.3,102.05),
                    vector4(2280.93,5025.75,43.08,133.23),
                    vector4(2009.62,5085.32,41.94,39.69),
                    vector4(1665.64,4865.5,41.59,187.09),
                    vector4(1977.9,4607.12,40.29,300.48),
                    vector4(2483.64,4469.41,34.68,184.26),
                    vector4(2530.73,4163.91,38.84,331.66),
                    vector4(2864.73,4146.39,49.81,198.43),
                    vector4(2837.83,3556.71,53.25,158.75),
                    vector4(2571.0,2624.79,36.8,198.43),
                    vector4(2536.25,1986.43,19.65,175.75),
                    vector4(2464.16,1291.17,49.71,138.9),
                    vector4(2527.96,279.99,107.75,170.08),
                    vector4(2188.3,-512.0,92.76,133.23),
                    vector4(1745.2,-862.58,70.58,121.89),
                    vector4(1291.02,-1109.78,50.67,110.56),
                    vector4(813.42,-639.54,40.37,56.7),
                    vector4(689.19,-185.93,46.19,331.66),
                    vector4(1226.97,508.8,80.85,317.49),
                },
                
                ["South"] = {
                    vector4(867.6,-219.17,70.26,56.7),
                    vector4(671.39,-36.69,81.91,323.15),
                    vector4(704.99,203.11,89.91,56.7),
                    vector4(-2.24,175.38,98.54,155.91),
                    vector4(-122.75,-80.83,56.16,56.7),
                    vector4(-1236.13,-299.93,37.54,102.05),
                    vector4(-1315.05,-503.85,33.11,218.27),
                    vector4(-1144.95,-810.38,15.33,124.73),
                    vector4(-1245.89,-1088.1,8.14,184.26),
                    vector4(-860.08,-1177.51,5.32,283.47),
                    vector4(-425.34,-1124.29,29.42,252.29),
                    vector4(-222.64,-1459.78,31.24,238.12),
                    vector4(-52.18,-1600.44,29.23,229.61),
                    vector4(136.13,-1758.15,28.96,232.45),
                    vector4(380.37,-1957.59,24.5,223.94),
                    vector4(723.46,-2071.17,29.25,260.79),
                    vector4(737.28,-2338.9,25.02,170.08),
                    vector4(1042.54,-2362.93,30.45,354.34),
                    vector4(1200.91,-2076.21,43.73,289.14),
                    vector4(1367.5,-1639.46,53.16,31.19),
                    vector4(1247.24,-1348.9,35.28,357.17),
                    vector4(1170.18,-1008.25,44.84,2.84),
                    vector4(1149.91,-756.42,57.78,87.88),
                    vector4(1022.02,-724.04,57.61,36.86),
                    vector4(949.94,-579.98,58.23,291.97),
                    vector4(1194.52,-476.21,65.97,345.83),
                    vector4(1091.58,-225.94,69.29,65.2),
                    vector4(987.96,-243.53,68.61,141.74),
                },
            },
        }
        
    }
    
    if cityName == "Base" then
        RoutesCoordinates["Cocaina"]["Permissions"] = {
            ["Vermelhos"] =  true,
            ["Verdes"] = true,
            ["Rosas"] = true,
            ["LosAztecas"] = true,
            ["Roxos"] = true,
            ["Amarelos"] = true        
        }
        RoutesCoordinates["Metafetamina"]["Permissions"] = {
            ["Vagos"] =  true,
            ["Umbrella"] = true,        
            ["AlcateiaHsT"] = true,
            ["Brancos"] = true
        }
        RoutesCoordinates["Armas"]["Permissions"] = {
            ["Bloods"] =  true,
            ["Mercenarios"] =  true,
            ["Bopegg"] =  true,
            ["LaMafia"] = true,
            ["Gringa"] =  true,
            ["Franca"] = true,
            ["Italia"] = true,
            ["Russia"] = true,
            ["Israel"] = true,
            ["Playboy"] = true,
            ["Mexico"] = true,
            ["China"] = true
        }
        Farming["Metafetamina"]["Permissions"] = {
            ["Vagos"] =  true,
            ["LaMafia"] = true,
            ["Umbrella"] = true,        
            ["AlcateiaHsT"] = true,
            ["Brancos"] = true
        }
        Farming["Cocaina"]["Permissions"] = {
            ["Vermelhos"] =  true,
            ["Verdes"] = true,
            ["Rosas"] = true,
            ["LosAztecas"] = true,
            ["Roxos"] = true,
            ["Amarelos"] = true  
        }
        Farming["Armas"]["Permissions"] = {
            ["Bloods"] =  true,
            ["Mercenarios"] =  true,
            ["Bopegg"] =  true,
            ["Gringa"] =  true,
            ["Franca"] = true,
            ["Italia"] = true,
            ["Russia"] = true,
            ["Israel"] = true,
            ["Playboy"] = true,
            ["Mexico"] = true,
            ["China"] = true         
        }
    end
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- JOBS
    -----------------------------------------------------------------------------------------------------------------------------------------
    Jobs = {
        -- frango frito
        {
            ["Start"] = vector4(-17.7,6303.13,31.37,22.68),
            ["Ped"] = {
                ["Distance"] = 22,
                ["Coords"] = { -17.7,6303.13,31.37,22.68 },
                ["Model"] = "s_m_m_postal_02",
                -- ["Custom"] = { 
                --     ["Face"] = '[0,8,0.5,0,3,0,-1,4,-1,73,0,0,0,0,0,0,0,0,30,0.99,0,1,0.88,0,-1,0,0,-1,0.84,0.72,0.46,0,0,0.3,-0.3,0,-0.58,-0.72,-0.52,0.21,0.37,0.79,0.6,0.71,0.43,-0.7]',
                --     ["Clothes"] = '{"accessory":{"item":0,"texture":0},"shoes":{"item":14,"texture":7},"glass":{"item":0,"texture":0},"decals":{"item":0,"texture":0},"hat":{"item":-1,"texture":0},"torso":{"item":22,"texture":0},"watch":{"item":-1,"texture":0},"vest":{"item":0,"texture":0},"pants":{"item":4,"texture":2},"arms":{"item":0,"texture":0},"backpack":{"item":0,"texture":0},"ear":{"item":-1,"texture":0},"mask":{"item":0,"texture":0},"bracelet":{"item":-1,"texture":0},"tshirt":{"item":15,"texture":0}}'
                -- },
                ["anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
            },
            -- ["Anim"] = {
            --     ["Progress"] = 5000,
            --     ["Wait"] = 5000,
            --     ["Animation"] =  {
            --         ["Dict"] = "anim@amb@business@coc@coc_packing_hi@",
            --         ["Name"] = "full_cycle_v1_pressoperator",
            --     },
            -- },
            ["Vehicle"] = GetHashKey("sprinter2112"),
            ["Routes"] = {
                vector3(99.04,6462.7,31.32),
                vector3(688.44,6505.71,27.82),
                vector3(1279.68,6479.37,20.3),
                -- vector3(2436.69,5632.37,44.92),
                vector3(2698.13,4710.31,44.23),
                vector3(2537.99,4188.4,39.98),
                vector3(2239.43,3826.71,34.02),
                vector3(1483.64,3497.57,36.14),
                vector3(355.8,3463.06,35.49),
                vector3(217.5,3040.22,41.65),
                vector3(-163.93,2865.67,47.84),
                vector3(-792.68,2775.82,23.3),
                vector3(-1141.39,2651.82,16.19),
                vector3(-1883.39,2386.24,33.72),
                vector3(-3095.26,1336.7,19.6),
                vector3(-3094.44,765.54,19.34),
                vector3(-2694.39,-54.01,15.33),
                vector3(-2152.16,-365.93,12.38),
                vector3(-1610.26,-412.89,40.62),
                vector3(-1360.47,-69.77,50.57),
                vector3(-1144.48,-154.21,38.55),
                vector3(-479.48,-388.64,33.33),
                vector3(6.89,-771.62,31.02),
                vector3(828.9,-860.05,42.83),
                vector3(1201.69,-680.96,60.07),
                vector3(1067.2,-213.2,68.98),
                vector3(1385.33,653.94,79.19),
                vector3(2130.12,2651.54,49.98),
                vector3(2736.73,3233.62,54.26),
                vector3(2855.32,4292.8,49.5),
                vector3(2686.78,4945.73,44.05),
                vector3(2454.65,5699.74,44.52),
                vector3(1150.11,6501.21,20.42),
                vector3(495.25,6571.69,26.45),
                vector3(-121.23,6553.56,28.78),
                vector3(-269.06,6392.69,30.11),
                vector3(-275.26,6086.81,30.58),
                vector3(-100.89,6262.82,30.67),
            },
            ["Payment"] = {
                ["Type"] = "Money", -- Money/Item
                --["Item"] = "dollars", -- ITEM SPAWN
                ["Amount"] = exports['variables']:GetVariable('variables','PaymentChicken') or { 1550,1600 }
            },
            ["Texts"] = {
                ["Start"] = "[~g~E~w~] Iniciar Entregas", -- TEXTO INICIAR
                ["Notify"] = {
                    ["Color"] = "amarelo",
                    ["Title"] = "Entregas",
                    ["Message"] = "Você concluiu essa entrega, outro ponto foi marcado em seu mapa.", -- TODO
                },
                ["Delivery"] = "[~g~E~w~] Entregar", -- TEXTO ENTREGA
            },
            ["Object"] = {
                {"v_ind_meatboxsml_02",vector3(0.0,0.0,0.0)}
            }
        },
        -- correios
        {
            ["Start"] = vector4(-405.24,6148.3,31.53,45.36),
            ["Ped"] = {
                ["Distance"] = 22,
                ["Coords"] = { -406.61,6149.69,31.68,229.61 },
                ["Model"] = "s_m_m_postal_01",
                -- ["Custom"] = { 
                --     ["Face"] = '[0,8,0.5,0,3,0,-1,4,-1,73,0,0,0,0,0,0,0,0,30,0.99,0,1,0.88,0,-1,0,0,-1,0.84,0.72,0.46,0,0,0.3,-0.3,0,-0.58,-0.72,-0.52,0.21,0.37,0.79,0.6,0.71,0.43,-0.7]',
                --     ["Clothes"] = '{"accessory":{"item":0,"texture":0},"shoes":{"item":14,"texture":7},"glass":{"item":0,"texture":0},"decals":{"item":0,"texture":0},"hat":{"item":-1,"texture":0},"torso":{"item":22,"texture":0},"watch":{"item":-1,"texture":0},"vest":{"item":0,"texture":0},"pants":{"item":4,"texture":2},"arms":{"item":0,"texture":0},"backpack":{"item":0,"texture":0},"ear":{"item":-1,"texture":0},"mask":{"item":0,"texture":0},"bracelet":{"item":-1,"texture":0},"tshirt":{"item":15,"texture":0}}'
                -- },
                ["anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
            },
            -- ["Anim"] = {
            --     ["Progress"] = 5000,
            --     ["Wait"] = 5000,
            --     ["Animation"] =  {
            --         ["Dict"] = "anim@scripted@player@mission@tunf_bunk_ig2_hdd_nas@male@",
            --         ["Name"] = "player_pluging_in",
            --     },
            -- },
            ["Vehicle"] = GetHashKey("sprinter211"),
            ["Routes"] = {
                vector3(-330.32,6329.1,29.99),
                vector3(-115.14,6540.66,29.39),
                vector3(99.57,6492.95,31.27),
                vector3(-90.97,6301.35,31.26),
                vector3(-318.36,6069.06,31.12),
                vector3(-541.8,5778.91,35.55),
                vector3(-808.77,5481.57,33.85),
                vector3(-1509.83,5014.03,62.65),
                vector3(-2366.99,4028.33,28.71),
                vector3(-2720.01,2315.2,17.76),
                vector3(-3125.93,1093.23,20.39),
                vector3(-3030.92,589.84,7.62),
                vector3(-2693.45,-54.31,15.94),
                vector3(-1909.79,-542.16,11.71),
                vector3(-1513.45,-871.1,10.13),
                vector3(-1305.92,-1172.66,4.72),
                vector3(-1228.2,-1098.25,7.99),
                vector3(-1305.89,-856.54,15.06),
                vector3(-1284.69,-641.67,26.44),
                vector3(-955.0,-584.72,18.13),
                vector3(-339.15,-539.76,24.7),
                vector3(173.45,-551.06,35.89),
                vector3(342.85,-324.9,50.36),
                vector3(476.72,-22.72,81.44),
                vector3(896.91,56.68,78.5),
                vector3(1333.24,603.16,79.82),
                vector3(1601.32,1016.67,78.97),
                vector3(2423.37,2891.97,39.85),
                vector3(2734.53,3229.96,54.44),
                vector3(2924.3,3719.56,52.28),
                vector3(2840.37,4335.28,49.64),
                vector3(2699.08,4891.01,44.31),
                vector3(2536.96,5494.53,44.25),
                vector3(644.6,6539.21,27.9),
                vector3(-86.99,6302.18,30.99),
                vector3(-295.3,6092.35,30.85),
                vector3(-388.14,6138.39,30.87),
            },
            ["Payment"] = {
                ["Type"] = "Money", -- Money/Item
                --["Item"] = "dollars", -- ITEM SPAWN
                ["Amount"] = exports['variables']:GetVariable('variables','PaymentPostOffice') or {1400,1450}
            },
            ["Texts"] = {
                ["Start"] = "[~g~E~w~] Iniciar Entregas", -- TEXTO INICIAR
                ["Notify"] = {
                    ["Color"] = "amarelo",
                    ["Title"] = "Entregas",
                    ["Message"] = "Você concluiu essa entrega, outro ponto foi marcado em seu mapa.", -- TODO
                },
                ["Delivery"] = "[~g~E~w~] Entregar", -- TEXTO ENTREGA
            },
            ["Object"] = {
                {"prop_cs_cardbox_01",vector3(0.0,0.0,0.0)}
            }
        },
        -- mecanica
        {
            ["Start"] = vector4(823.21,-937.27,26.49,184.26),
            ["Ped"] = {
                ["Distance"] = 22,
                ["Coords"] = {823.21,-937.27,26.49,184.26},
                ["Model"] = "hc_driver",
                -- ["Custom"] = { 
                --     ["Face"] = '[0,8,0.5,0,3,0,-1,4,-1,73,0,0,0,0,0,0,0,0,30,0.99,0,1,0.88,0,-1,0,0,-1,0.84,0.72,0.46,0,0,0.3,-0.3,0,-0.58,-0.72,-0.52,0.21,0.37,0.79,0.6,0.71,0.43,-0.7]',
                --     ["Clothes"] = '{"accessory":{"item":0,"texture":0},"shoes":{"item":14,"texture":7},"glass":{"item":0,"texture":0},"decals":{"item":0,"texture":0},"hat":{"item":-1,"texture":0},"torso":{"item":22,"texture":0},"watch":{"item":-1,"texture":0},"vest":{"item":0,"texture":0},"pants":{"item":4,"texture":2},"arms":{"item":0,"texture":0},"backpack":{"item":0,"texture":0},"ear":{"item":-1,"texture":0},"mask":{"item":0,"texture":0},"bracelet":{"item":-1,"texture":0},"tshirt":{"item":15,"texture":0}}'
                -- },
                ["anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
            },
            -- ["Anim"] = {
            --     ["Progress"] = 5000,
            --     ["Wait"] = 5000,
            --     ["Animation"] =  {
            --         ["Dict"] = "anim@scripted@player@mission@tunf_bunk_ig2_hdd_nas@male@",
            --         ["Name"] = "player_pluging_in",
            --     },
            -- },
            ["Vehicle"] = GetHashKey("rs62"),
            ["Routes"] = {
                vector3(786.39,-890.86,24.63),
                vector3(716.35,-433.6,38.67),
                vector3(406.87,-276.19,51.68),
                vector3(19.84,-130.52,55.55),
                vector3(-361.37,2.8,46.56),
                vector3(-774.94,-48.9,37.42),
                -- vector3(-820.83,-71.72,37.36), 
                vector3(-1030.65,143.12,54.98),
                vector3(-821.23,204.1,74.29),
                vector3(-443.48,234.32,82.58),
                vector3(-194.62,248.52,91.81),
                vector3(168.32,194.15,105.55),
                vector3(385.69,113.86,101.99),
                vector3(752.15,-41.86,81.18),
                vector3(1044.77,-224.29,69.67),
                vector3(1177.76,-460.19,65.87),
                vector3(1187.46,-718.52,58.99),
                vector3(1118.88,-950.4,47.45),
                vector3(905.53,-996.79,34.66),
            },
            ["Payment"] = {
                ["Type"] = "Item", -- Money/Item
                ["Item"] = "advtoolbox", -- ITEM SPAWN
                ["Amount"] = exports['variables']:GetVariable('variables','PaymentMechanic') or {1,2}
            },
            ["Texts"] = {
                ["Start"] = "[~g~E~w~] Iniciar Entregas", -- TEXTO INICIAR
                ["Notify"] = {
                    ["Color"] = "amarelo",
                    ["Title"] = "Entregas",
                    ["Message"] = "Você concluiu essa entrega, outro ponto foi marcado em seu mapa.", -- TODO
                },
                ["Delivery"] = "[~g~E~w~] Entregar", -- TEXTO ENTREGA
            },
        },
        -- hospital
        {
            ["Start"] = vector4(1120.33,-1530.0,35.03,8.51),
            ["Ped"] = {
                ["Distance"] = 22,
                ["Coords"] = {1120.33,-1530.0,35.03,8.51},
                ["Model"] = "s_m_y_autopsy_01",
                -- ["Custom"] = { 
                --     ["Face"] = '[0,8,0.5,0,3,0,-1,4,-1,73,0,0,0,0,0,0,0,0,30,0.99,0,1,0.88,0,-1,0,0,-1,0.84,0.72,0.46,0,0,0.3,-0.3,0,-0.58,-0.72,-0.52,0.21,0.37,0.79,0.6,0.71,0.43,-0.7]',
                --     ["Clothes"] = '{"accessory":{"item":0,"texture":0},"shoes":{"item":14,"texture":7},"glass":{"item":0,"texture":0},"decals":{"item":0,"texture":0},"hat":{"item":-1,"texture":0},"torso":{"item":22,"texture":0},"watch":{"item":-1,"texture":0},"vest":{"item":0,"texture":0},"pants":{"item":4,"texture":2},"arms":{"item":0,"texture":0},"backpack":{"item":0,"texture":0},"ear":{"item":-1,"texture":0},"mask":{"item":0,"texture":0},"bracelet":{"item":-1,"texture":0},"tshirt":{"item":15,"texture":0}}'
                -- },
                ["anim"] = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
            },
            -- ["Anim"] = {
            --     ["Progress"] = 5000,
            --     ["Wait"] = 5000,
            --     ["Animation"] =  {
            --         ["Dict"] = "anim@scripted@player@mission@tunf_bunk_ig2_hdd_nas@male@",
            --         ["Name"] = "player_pluging_in",
            --     },
            -- },
            ["Vehicle"] = GetHashKey("ambulancia"),
            ["Routes"] = {
                vector3(1005.54,-1426.33,33.9),
                vector3(807.9,-1403.52,26.44),
                vector3(807.14,-1198.11,26.52),
                vector3(646.4,-1009.12,35.82),
                vector3(359.9,-1036.62,28.51),
                vector3(284.21,-904.85,28.19),
                vector3(359.57,-689.4,28.53),
                vector3(-29.07,-541.92,39.09),
                vector3(-200.33,-668.9,33.06),
                vector3(-461.69,-648.02,31.53),
                vector3(-621.01,-523.21,34.0),
                vector3(-703.12,-340.65,34.15),
                vector3(-820.6,-208.48,36.68),
                vector3(-936.76,-300.52,38.65),
                vector3(-1160.55,-399.21,35.11),
                vector3(-1259.96,-402.89,34.1),
                vector3(-1478.88,-232.21,49.22),
                vector3(-1646.8,-314.07,49.93),
                vector3(-1862.05,-352.32,48.61),
                vector3(-1487.89,-736.35,24.82),
                vector3(-1233.95,-1126.52,7.18),
                vector3(-1001.03,-1265.88,5.19),
                vector3(-828.17,-1217.73,6.3),
                vector3(-589.39,-962.59,21.77),
                vector3(-182.78,-1150.74,22.28),
                vector3(252.4,-1473.71,28.53),
                vector3(578.62,-1446.83,28.85),
                vector3(1141.77,-1480.41,34.05),            
            },
            ["Payment"] = {
                ["Type"] = "Item", -- Money/Item
                ["Item"] = "bolsadesangue", -- ITEM SPAWN
                ["Amount"] = exports['variables']:GetVariable('variables','PaymentHospital') or {1,2}
            },
            ["Texts"] = {
                ["Start"] = "[~g~E~w~] Iniciar Entregas", -- TEXTO INICIAR
                ["Notify"] = {
                    ["Color"] = "amarelo",
                    ["Title"] = "Entregas",
                    ["Message"] = "Você concluiu essa entrega, outro ponto foi marcado em seu mapa.", -- TODO
                },
                ["Delivery"] = "[~g~E~w~] Entregar", -- TEXTO ENTREGA
            },
        },
    }
    BusRoutes = {
        vector3(309.95,-760.52,30.09),
        vector3(199.63,-1087.02,28.56),
        vector3(210.47,-1259.67,28.61),
        vector3(79.44,-1304.03,28.66),
        vector3(4.44,-1127.81,27.63),
        vector3(-46.36,-1021.88,28.04),    
        vector3(95.00,-634.89,45.02),
        vector3(58.27,-283.32,48.20),
        vector3(120.43,-193.49,54.58),
        vector3(323.93,-267.58,54.71),
        vector3(443.75,119.16,100.41),
        vector3(125.62,-4.42,68.48),
        vector3(-524.08,133.59,63.91),
        vector3(-586.64,268.39,83.24),
        vector3(-640.38,-163.16,38.49),
        vector3(-597.89,-361.27,35.77),
        vector3(-646.06,-804.09,25.78),
        vector3(-932.63,-1199.67,5.91),
        vector3(-1234.65,-1080.87,9.12),
        vector3(-1373.99,-793.23,20.09),
        vector3(-1826.46,-502.76,28.63),    
        vector3(-2981.70,404.50,15.75),
        vector3(-3101.58,1112.65,21.28),
        vector3(-2993.76,1609.89,29.37),
        vector3(-2662.77,2558.17,16.02),
        vector3(-2398.73,3893.53,23.96),
        vector3(-1979.16,4533.29,56.4),
        vector3(-1619.69,4868.26,60.34),
        vector3(-793.02,5472.1,33.4),
        vector3(-396.36,5966.58,31.1),
        vector3(92.09,6460.09,30.67),
        vector3(1042.03,6480.65,20.34),
        vector3(2459.79,5596.16,44.21),
        vector3(2661.64,4894.88,43.96),
        vector3(2886.48,3715.27,51.93),
        vector3(2363.19,2882.48,39.68),
        vector3(1774.4,2127.57,63.86),
        vector3(1589.82,1053.6,79.51),
        vector3(1100.58,401.48,82.82),
        vector3(490.49,-441.19,29.3),
        
        
        -- -- morrendoa qui
        -- vector3(-1813.99,2393.93,30.99),  
        -- vector3(-840.46,2750.73,23.17), -- ver se ta ok
        
        -- vector3(-72.63,2813.83,54.60),
        -- vector3(540.55,2685.25,43.20),
        -- vector3(1119.93,2682.04,39.31),
        -- vector3(1470.51,2725.47,38.48),
        -- vector3(2002.62,2603.65,55.07),
        -- vector3(379.58,-599.20,29.58),
    }
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- COWCOORDS
    -----------------------------------------------------------------------------------------------------------------------------------------
    Cows = {
        vector3(2440.58,4736.35,34.29),
        vector3(2432.5,4744.58,34.31),
        vector3(2424.47,4752.37,34.31),
        vector3(2416.28,4760.8,34.31),
        vector3(2408.6,4768.88,34.31),
        vector3(2400.32,4777.48,34.53),
        vector3(2432.46,4802.66,34.83),
        vector3(2440.62,4794.22,34.66),
        vector3(2448.65,4786.57,34.64),
        vector3(2456.88,4778.08,34.49),
        vector3(2464.53,4770.04,34.37),
        vector3(2473.38,4760.98,34.31),
        vector3(2495.03,4762.77,34.37),
        vector3(2503.13,4754.08,34.31),
        vector3(2511.34,4746.04,34.31),
        vector3(2519.56,4737.35,34.29),
    }
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- FARMER
    -----------------------------------------------------------------------------------------------------------------------------------------
    FarmerInfo = {
        ["Start"] = {
            vector4(751.71,6459.04,31.53,59.53),
        },
        ["Routes"] = {
            vector4(740.39,6475.1,28.7,76.54),
            vector4(714.93,6480.08,28.85,79.38),
            vector4(678.49,6488.76,29.4,70.87),
            vector4(652.2,6494.27,29.25,79.38),
            vector4(625.71,6499.8,29.76,79.38),
            vector4(612.62,6483.78,30.01,181.42),
            vector4(615.54,6464.19,29.98,209.77),
            vector4(642.66,6459.96,30.73,272.13),
            vector4(670.53,6459.21,31.29,269.3),
            vector4(707.36,6457.42,30.87,266.46),
            vector4(734.0,6455.04,31.8,266.46),
            vector4(734.91,6473.85,29.17,79.38),
            vector4(711.71,6476.56,29.12,79.38),
            vector4(688.15,6480.59,29.67,79.38),
            vector4(661.22,6483.46,30.3,82.21),
            vector4(641.74,6489.01,30.14,68.04),
            vector4(632.47,6475.36,30.65,260.79),
            vector4(650.67,6470.83,30.7,260.79),
            vector4(671.19,6467.95,30.5,263.63),
            vector4(721.89,6461.93,30.95,263.63),
            vector4(747.84,6465.18,30.65,340.16),
            
            
        },
        ["Separate"] = {
            ["Start"] = {
                vector4(747.97,6453.62,31.98,59.53),
            },
            ["Anim"] = {
                ["Dict"] = "amb@prop_human_bum_bin@idle_a",
                ["Anim"] = "idle_a",
                ["Wait"] = 60000,
            },
        },
        ["Itens"] = exports['variables']:GetVariable('variables','PaymentFarmer') or {
            ["Separate"] = {
                ["Consume"] = {
                    ["graos"] = { 
                        ["Amount"] = 1,
                        ["Give"] = {
                            ["cereais"] = 1,
                        },
                    },
                }
            },
            ["Route"] = {
                ["Give"] = {
                    ["graos"] = 1,
                }
            }
        },
    }
    -----------------------------------------------------------------------------------------------------------------------------------------
    -- FRUITMAN
    -----------------------------------------------------------------------------------------------------------------------------------------
    FruitCoords = {
        vec3(2119.2,5084.76,44.84),
        vec3(2109.66,5068.44,42.82),
        vec3(2093.25,5061.21,42.26),
        vec3(2070.85,5045.16,41.59),
        vec3(2059.65,5057.95,41.67),
        vec3(2074.84,5073.35,42.92),
        vec3(2090.34,5086.86,44.2),
        vec3(2098.11,5104.5,45.54),
        vec3(2101.43,5084.17,44.31),
        vec3(2077.39,5057.99,42.07),
        vec3(2059.51,5074.25,42.09),
        vec3(2071.15,5089.27,43.42),
        vec3(2081.41,5104.78,44.85),
        vec3(2077.64,5122.9,46.39),
        vec3(2058.41,5104.29,45.43),
        vec3(2040.45,5083.23,42.66),
        vec3(2041.4,5103.3,44.50),
        vec3(2060.3,5121.8,45.38),
        vec3(2062.81,5143.47,47.74),
        vec3(2040.35,5128.36,46.19),
        vec3(2020.92,5107.65,44.06),
        vec3(2017.53,5125.19,45.26),
        vec3(2043.34,5146.59,47.38),
        vec3(2036.87,5160.81,48.8), 
        vec3(2022.78,5149.14,47.52),
        vec3(1999.98,5134.99,45.17),
        vec3(2026.46,5137.55,46.57),
        vec3(2024.05,5089.22,42.75),
        vec3(2045.23,5064.06,41.45),
        vec3(2115.17,5104.75,46.17),
        vec3(2099.65,5128.21,48.7), 
        vec3(2081.11,5143.14,50.2), 
        vec3(2063.54,5166.11,51.43),
    }
end)
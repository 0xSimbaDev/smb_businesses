Config = {}

-- Config.ActivePayments = {}

-- Config.EntitysSpawned = false
Config.Debug = false
Config.Businesses = {
    [1] = {
        Name = "BurgerShot",
        Open = true,
        Coordinates = vector3(-1194.46, -896.0, 14.0),
        Blip = {
            icon = 106,
            color = 17
        },
        PolyZone = {
            points = {
            vector2(-1185.3253173828, -875.45788574218),
            vector2(-1168.3729248046, -900.38293457032),
            vector2(-1191.3253173828, -914.74951171875),
            vector2(-1200.1971435546, -913.36022949218),
            vector2(-1213.382446289, -893.82879638672)
            },
            minZ = 12.80465221405,
            maxZ = 13.869835853576
        },
        AllowedJobs = {
            "burgershot",
        },
        WorkAreas = {
            [1] = {
                Name = "Grill Station",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_grill",
                Coords = vector3(-1194.88, -898.38, 13.89),
                Products = {
                    ['the_bleeder'] = {
                        Name = "The Bleeder",
                        AnimationLib = "mini@tennis",
                        AnimationName = "forehand",
                        AnimationDesc = "Making a delicious burger at the Grill Station!",
                        Materials = {
                            { Name = "Burger Patty", Item = "burger_patty", Amount = 1 },
                            { Name = "Burger Bun", Item = "burger_bun", Amount = 1 },
                            { Name = "Cheese", Item = "cheese", Amount = 1 },
                            
                        },
                    },
                    ['heart_stopper'] = {
                        Name = "Heart Stopper",
                        AnimationLib = "mini@tennis",
                        AnimationName = "forehand",
                        AnimationDesc = "Making a delicious burger at the Grill Station!",
                        Materials = {
                            { Name = "Burger Patty", Item = "burger_patty", Amount = 2 },
                            { Name = "Burger Bun", Item = "burger_bun", Amount = 1 },
                            { Name = "Tomato", Item = "tomato", Amount = 2 },
                            { Name = "Onion", Item = "onion", Amount = 2 },
                            { Name = "Cheese", Item = "cheese", Amount = 2 },
                           
                        },
                    },
                },
            },
            [2] = {
                Name = "Fry Station",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_fries",
                Coords = vector3(-1196.04, -899.3, 13.89),
                Products = {
                    ['fries'] = {
                        Name = "Fries",
                        AnimationLib = "amb@prop_human_bbq@male@base",
                        AnimationName = "base",
                        AnimationDesc = "Preparing delicious fries at the Fry Station!",
                        Materials = {
                            { Name = "Potato", Item = "potato", Amount = 2 },
                            -- { Name = "Salt", Item = "salt", Amount = 1 },
                            -- { Name = "Seasoning", Item = "seasoning", Amount = 1 },
                        },
                    },
                },
            },
            [3] = {
                Name = "Drink Station",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_cups02",
                Coords = vector3(-1191.3, -898.43, 13.89),
                Products = {
                    ['soda_cup'] = {
                        Name = "Drink",
                        AnimationLib = "amb@world_human_drinking@coffee@male@base",
                        AnimationName = "base",
                        AnimationDesc = "Mixing up a refreshing drink at the Drink Station!",
                        Materials = {
                            { Name = "Cup", Item = "cup", Amount = 1 },
                            { Name = "Ice", Item = "ice", Amount = 1 },
                        },
                    },
                },
            },
            [4] = {
                Name = "Cashier",
                PlaceOnGround = false,
                ShowItem = false,
                Prop = "v_ind_bin_01",
                Coords = vector3(-1195.66, -892.96, 13.89),
                IsCashier = true,
            },
            [5] = {
                Name = "Food Tray",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_tray_02",
                Coords = vector3(-1194.5, -893.33, 14.07),
                StashNumber = 1,
                StashName = 'bs_foodstash_',
                IsStash = true,
            },
            [6] = {
                Name = "Storage",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_tray_02",
                Coords = vector3(-1203.17, -896.08, 13.89),
                StorageNumber = 1,
                StorageName = 'bs_storage_',
                IsStorage = true,
            },
            [7] = {
                Name = "ClockInOut",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_tray_02",
                Coords = vector3(-1200.1, -902.37, 13.89),
                IsClockingIn = true,
            },
            [8] = {
                Name = "Gilingan ni Anghel",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_cups02",
                Coords = vector3(-1200.27, -894.52, 13.89),
                Products = {
                    ['processed_meat'] = {
                        Name = "Process Meat",
                        AnimationLib = "mini@strip_club@private_dance@part1",
                        AnimationName = "priv_dance_p1",
                        AnimationDesc = "Igiling mo Anghel",
                        yield = 10,
                        Materials = {
                            { Name = "Raw Meat", Item = "raw_meat", Amount = 1 },
                        },
                    },
                    ['burger_patty'] = {
                        Name = "Burger Patty",
                        AnimationLib = "mini@strip_club@private_dance@part2",
                        AnimationName = "priv_dance_p2",
                        AnimationDesc = "Seasoning Meat",
                        Materials = {
                            { Name = "Raw Meat", Item = "processed_meat", Amount = 1 },
                            { Name = "Burger Seasoning", Item = "burger_seasoning", Amount = 1 },
                        },
                    },
                },
            },
        },
    },
}

-- Config.Businesses = {
--     [1] = {
--         Name = "BurgerShot Business",
--         Open = true,
--         Coordinates = vector3(-1194.46, -896.0, 14.0),
--         AllowedJobs = {
--             "burgershot",
--         },
--         WorkAreas = {
--             [1] = {
--                 Name = "Grill Station",
--                 PlaceOnGround = true,
--                 ShowItem = true,
--                 Prop = "prop_food_bs_grill",
--                 Coords = { X = -1200.0, Y = -900.92, Z = 14.2, H = 180.0 },
--                 Materials = {
--                     [1] = { Name = "Beef Patty", Item = "beef-patty", Amount = 2 },
--                     [2] = { Name = "Burger Bun", Item = "burger-bun", Amount = 1 },
--                     [3] = { Name = "Lettuce", Item = "lettuce", Amount = 1 },
--                     [4] = { Name = "Tomato", Item = "tomato", Amount = 1 },
--                     [5] = { Name = "Cheese", Item = "cheese", Amount = 1 },
--                 },
--                 Product = "burger",
--                 AnimationLib = "mini@tennis",
--                 AnimationName = "forehand",
--                 AnimationDesc = "Making a delicious burger at the Grill Station!",
--             },
--             [2] = {
--                 Name = "Fry Station",
--                 PlaceOnGround = true,
--                 ShowItem = true,
--                 Prop = "prop_food_bs_fries",
--                 Coords = { X = -1201.0, Y = -899.68, Z = 14.2, H = 180.0 },
--                 Materials = {
--                     [1] = { Name = "Potato", Item = "potato", Amount = 2 },
--                     [2] = { Name = "Salt", Item = "salt", Amount = 1 },
--                 },
--                 Product = "fries",
--                 AnimationLib = "amb@prop_human_bbq@male@base",
--                 AnimationName = "base",
--                 AnimationDesc = "Preparing delicious fries at the Fry Station!",
--             },
--             [3] = {
--                 Name = "Drink Station",
--                 PlaceOnGround = true,
--                 ShowItem = true,
--                 Prop = "prop_food_bs_cups02",
--                 Coords = { X = -1199.1, Y = -895.96, Z = 14.2, H = 180.0 },
--                 Materials = {
--                     [1] = { Name = "Cup", Item = "cup", Amount = 1 },
--                     [2] = { Name = "Soda", Item = "soda", Amount = 1 },
--                     [3] = { Name = "Ice", Item = "ice", Amount = 1 },
--                 },
--                 Product = "drink",
--                 AnimationLib = "amb@world_human_drinking@coffee@male@base",
--                 AnimationName = "base",
--                 AnimationDesc = "Mixing up a refreshing drink at the Drink Station!",
--             },
--             [4] = {
--                 Name = "Cashier",
--                 PlaceOnGround = false,
--                 ShowItem = false,
--                 Prop = "v_ind_bin_01",
--                 Coords = { X = -1195.92, Y = -891.25, Z = 14.5, H = 33.20 },
--                 IsCashier = true,
--             },
--             [5] = {
--                 Name = "Food Tray",
--                 PlaceOnGround = true,
--                 ShowItem = true,
--                 Prop = "prop_food_bs_tray_02",
--                 Coords = { X = -1195.32, Y = -892.33, Z = 14.02, H = 126.63 },
--                 StashNumber = 1,
--                 StashName = 'bs_foodstash_',
--                 IsStash = true,
--             },
--             [6] = {
--                 Name = "Storage",
--                 PlaceOnGround = true,
--                 ShowItem = true,
--                 Prop = "prop_food_bs_tray_02",
--                 Coords = { X = -1203.43, Y = -895.7, Z = 14.02, H = 126.63 },
--                 StorageNumber = 1,
--                 StorageName = 'bs_storage_',
--                 IsStorage = true,
--             },
--             [7] = {
--                 Name = "ClockInOut",
--                 PlaceOnGround = true,
--                 ShowItem = true,
--                 Prop = "prop_food_bs_tray_02",
--                 Coords = { X = -1191.47, Y = -901.77, Z = 14.02, H = 126.63 },
--                 IsClockingIn = true,
--             },
--         },
--     },
-- }


Config = {}

-- Config.ActivePayments = {}

-- Config.EntitysSpawned = false
Config.Debug = true
Config.Businesses = {
    [1] = {
        Name = "BurgerShot Business",
        Open = true,
        Coordinates = vector3(-1194.46, -896.0, 14.0),
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
                Coords = { X = -1200.0, Y = -900.92, Z = 14.2, H = 180.0 },
                Products = {
                    ['cheeseburger'] = {
                        Name = "Cheese Burger",
                        AnimationLib = "mini@tennis",
                        AnimationName = "forehand",
                        AnimationDesc = "Making a delicious burger at the Grill Station!",
                        Materials = {
                            { Name = "Beef Patty", Item = "beef-patty", Amount = 1 },
                            { Name = "Burger Bun", Item = "burger-bun", Amount = 1 },
                            { Name = "Cheese", Item = "cheese", Amount = 1 },
                            { Name = "Seasoning", Item = "seasoning", Amount = 1 },
                        },
                    },
                    ['quarterpounder'] = {
                        Name = "Quarter Burger",
                        AnimationLib = "mini@tennis",
                        AnimationName = "forehand",
                        AnimationDesc = "Making a delicious burger at the Grill Station!",
                        Materials = {
                            { Name = "Beef Patty", Item = "beef-patty", Amount = 2 },
                            { Name = "Burger Bun", Item = "burger-bun", Amount = 1 },
                            { Name = "Tomato", Item = "tomato", Amount = 2 },
                            { Name = "Onion", Item = "onion", Amount = 2 },
                            { Name = "Seasoning", Item = "seasoning", Amount = 1 },
                        },
                    },
                },
            },
            [2] = {
                Name = "Fry Station",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_fries",
                Coords = { X = -1201.0, Y = -899.68, Z = 14.2, H = 180.0 },
                Products = {
                    ['fries'] = {
                        Name = "Fries",
                        AnimationLib = "amb@prop_human_bbq@male@base",
                        AnimationName = "base",
                        AnimationDesc = "Preparing delicious fries at the Fry Station!",
                        Materials = {
                            { Name = "Potato", Item = "potato", Amount = 2 },
                            { Name = "Salt", Item = "salt", Amount = 1 },
                            { Name = "Seasoning", Item = "seasoning", Amount = 1 },
                        },
                    },
                },
            },
            [3] = {
                Name = "Drink Station",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_cups02",
                Coords = { X = -1199.1, Y = -895.96, Z = 14.2, H = 180.0 },
                Products = {
                    ['drink'] = {
                        Name = "Drink",
                        AnimationLib = "amb@world_human_drinking@coffee@male@base",
                        AnimationName = "base",
                        AnimationDesc = "Mixing up a refreshing drink at the Drink Station!",
                        Materials = {
                            { Name = "Cup", Item = "cup", Amount = 1 },
                            { Name = "Soda", Item = "soda", Amount = 1 },
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
                Coords = { X = -1195.92, Y = -891.25, Z = 14.5, H = 33.20 },
                IsCashier = true,
            },
            [5] = {
                Name = "Food Tray",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_tray_02",
                Coords = { X = -1195.32, Y = -892.33, Z = 14.02, H = 126.63 },
                StashNumber = 1,
                StashName = 'bs_foodstash_',
                IsStash = true,
            },
            [6] = {
                Name = "Storage",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_tray_02",
                Coords = { X = -1203.43, Y = -895.7, Z = 14.02, H = 126.63 },
                StorageNumber = 1,
                StorageName = 'bs_storage_',
                IsStorage = true,
            },
            [7] = {
                Name = "ClockInOut",
                PlaceOnGround = true,
                ShowItem = true,
                Prop = "prop_food_bs_tray_02",
                Coords = { X = -1191.47, Y = -901.77, Z = 14.02, H = 126.63 },
                IsClockingIn = true,
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


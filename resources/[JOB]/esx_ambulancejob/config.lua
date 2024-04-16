Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 21, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 204, b = 2, a = 100, rotate = false }

Config.ReviveReward               = 30000  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second



Config.EarlyRespawnTimer          = 15 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 5 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 5000


Config.RespawnPoint = { coords = vector3(309.3019, -581.1105, 43.2840), heading = 297.9000 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(304.2321, -597.1077, 43.2840),
			sprite = 586,
			scale  = 0.9,
			color  = 1
		},

		AmbulanceActions = {
			vector3(302.1021, -598.8088, 43.2840)
		},

		Pharmacies = {
			vector3(310.8215, -566.2498, 43.2840)
		},

		Vehicles = {
			{
				Spawner = vector3(300.2692, -580.7670, 43.2608),
				InsideShop = vector3(300.2692, -580.7670, 43.2608),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(361.0301, -601.6947, 28.6587), heading = 198.8700, radius = 4.0 }
				}
			}
		},

		VehiclesDeleter = {
			{
				Marker = { type = 24, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(290.2472, -588.6797, 43.1822)
			},
			{
				Marker = { type = 24, x = 3.0, y = 3.0, z = 3.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				Deleter = vector3(290.2472, -588.6797, 43.1822)
			}
		},

		Helicopters = {
			{
				Spawner = vector3(341.4012, -585.4295, 74.1656),
				InsideShop = vector3(341.4012, -585.4295, 74.1656),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(350.6902, -588.9006, 74.1656), heading = 256.3723, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			--[[{
				From = vector3(294.7, -1448.1, 29.0),
				To = { coords = vector3(272.8, -1358.8, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(275.3, -1361, 23.5),
				To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}
			]]
		},

		FastTravelsPrompt = {
			--[[{
				From = vector3(237.4, -1373.8, 26.0),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
			
		]]
		}

	}
}



Config.AuthorizedVehicles = {
	{ model = 'ambulance', label = 'Van', price = 0},

}


Config.AuthorizedHelicopters = {
	{ model = 'seasparrow3', label = 'Heli', price = 150000 }
}


Config.Uniforms = {
	cadet_wear = {
		male = {
			['tshirt_1'] = 43,  ['tshirt_2'] = 1,
			['torso_1'] = 3,   ['torso_2'] = 13,
			['arms'] = 86,
			['shoes_1'] = 36,   ['shoes_2'] = 8,
			['pants_1'] = 62,   ['pants_2'] = 8,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 1,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 22,  ['tshirt_2'] = 2,
			['torso_1'] = 96,   ['torso_2'] = 0,
			['arms'] = 14,
			['shoes_1'] = 96,   ['shoes_2'] = 11,
			['pants_1'] = 11,   ['pants_2'] = 15,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] =0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 6
		},
		female = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		}
	}
}
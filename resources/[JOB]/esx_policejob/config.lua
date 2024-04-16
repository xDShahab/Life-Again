Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 22
Config.MarkerSize                 = { x = 0.5, y = 0.5, z = 0.4 }
Config.MarkerColor                = { r = 500, g = 500, b = 500 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'


Config.PoliceStations = {

	LSPD = {

		Blip = {
			Pos = { x = 651.02, y = -10.65, z = 89.83 },
			Sprite  = 137,
			Display = 4,
			Scale   = 0.9,
			Colour  = 38,
		},

		Cloakrooms = {
			{ x = 463.14, y =  -996.46, z = 30.67 },

		},
		
		Stocks = {
			{ x = 631.84, y = -10.59, z = 182.58 },
		},


		Armories = {
			{ x = 482.47, y = -995.49, z = 30.67 },
		},

		
		Vehicles = {
			{
				Spawner    = {x = 454.4, y = -1017.5, z = 28.44},
				SpawnPoint = { x = 439.77, y = -1019.43, z = 28.73, },
				Heading    = 90.0
			}
		},

		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK', price = 100 },
			{ name = 'WEAPON_STUNGUN', price = 500 },
			{ name = 'WEAPON_FLASHLIGHT', price = 100 },
			{ name = 'WEAPON_PISTOL', price = 5000 },
			{ name = 'WEAPON_SNSPISTOL', price = 6000 },
			{ name = 'WEAPON_COMBATPISTOL', price = 7000 },
			{ name = 'WEAPON_PISTOL50', price = 9000 },
			{ name = 'WEAPON_HEAVYPISTOL', price = 8000 },
			{ name = 'WEAPON_SMG',     price = 12000 },
			{ name = 'WEAPON_CARBINERIFLE', price = 12000 }
		},

		Helicopters = {
			{
				Spawner    = { x = 511.91, y = -46.68, z = 88.86 },
				SpawnPoint = { x = 511.91, y = -46.68, z = 88.86 },
				Heading    = 329.63
			}
		},



		VehicleDeleters = {
			{ x =  449.46, y = -981.25, z = 43.69}
		},

		BossActions = {
			{ x = 463.06 ,y = -985.13, z =30.73 }
		},

	

	},




}



Config.AuthorizedWeapons = {
	{
		'WEAPON_PISTOL',
		'WEAPON_STUNGUN'
	},

	{
		'WEAPON_PISTOL50',
		'WEAPON_SMG'
	},
	
	{
		'WEAPON_ASSAULTSMG'
	}
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	{
		model = 'm5speed',
		label = 'BMW'
	},	
	{
		model = 'a45policia',
		label = 'Benz'
	},	
	{
		model = 'm8comando',
		label = 'BMW M8'
	},
	{
		model = 'mercedestactical',
		label = 'Vanet Benz'
	},
}

Config.AuthorizedHelicopters = {
	cadet = {

	},

	po1 = {

	},

	po2 = {
		{
			model = 'polbuzz2',
			label = 'Police Helicopter'
		}
	},

	po3 = {
		{
			model = 'polbuzz2',
			label = 'Police Helicopter'
		}
	},

	slo = {
		{
			model = 'polbuzz2',
			label = 'Police Helicopter'
		}
	},

	commander = {
		{
			model = 'polbuzz2',
			label = 'Police Helicopter'
		}
	},

	boss = {
		{
			model = 'polbuzz2',
			label = 'Police Helicopter'
		}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	cadet_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 0,
			['torso_1'] = 287,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 69,   ['pants_2'] = 0,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] =-1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	po1_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 1,
			['torso_1'] = 180,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 23,
			['pants_1'] = 65,   ['pants_2'] = 2,
			['shoes_1'] = 39,   ['shoes_2'] = 0,
			['helmet_1'] = 62,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	po2_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 1,
			['torso_1'] = 180,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 23,
			['pants_1'] = 65,   ['pants_2'] = 2,
			['shoes_1'] = 39,   ['shoes_2'] = 0,
			['helmet_1'] = 62,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	po3_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 1,
			['torso_1'] = 180,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 23,
			['pants_1'] = 65,   ['pants_2'] = 2,
			['shoes_1'] = 39,   ['shoes_2'] = 0,
			['helmet_1'] = 62,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 1,
			['torso_1'] = 180,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 23,
			['pants_1'] = 65,   ['pants_2'] = 2,
			['shoes_1'] = 39,   ['shoes_2'] = 0,
			['helmet_1'] = 62,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	slo_wear = { -- currently the same as intendent_wear
	male = {
		['tshirt_1'] = 16,  ['tshirt_2'] = 1,
		['torso_1'] = 180,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 23,
		['pants_1'] = 65,   ['pants_2'] = 2,
		['shoes_1'] = 39,   ['shoes_2'] = 0,
		['helmet_1'] = 62,  ['helmet_2'] = 2,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 2,     ['ears_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['mask_1'] = 0,   ['mask_2'] = 0
	},
	female = {
		['tshirt_1'] = 19,  ['tshirt_2'] = 0,
		['torso_1'] = 335,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 14,
		['pants_1'] = 97,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['mask_1'] = 0,   ['mask_2'] = 0
	}
	},
	commander_wear = {
		male = {
			['tshirt_1'] = 16,  ['tshirt_2'] = 1,
			['torso_1'] = 180,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 23,
			['pants_1'] = 65,   ['pants_2'] = 2,
			['shoes_1'] = 39,   ['shoes_2'] = 0,
			['helmet_1'] = 62,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
	male = {
		['tshirt_1'] = 17,  ['tshirt_2'] = 0,
		['torso_1'] = 100,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 18,
		['pants_1'] = 62,   ['pants_2'] = 0,
		['shoes_1'] = 10,   ['shoes_2'] = 0,
		['helmet_1'] =-1,  ['helmet_2'] = 1,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 2,     ['ears_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['mask_1'] = 0,   ['mask_2'] = 0
	},
	female = {
		['tshirt_1'] = 19,  ['tshirt_2'] = 0,
		['torso_1'] = 335,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 14,
		['pants_1'] = 97,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['mask_1'] = 0,   ['mask_2'] = 0
	}
	},
	swat_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 185,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 21,
			['pants_1'] = 65,   ['pants_2'] = 2,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 121,  ['helmet_2'] = 0,
			['glasses_1'] = 0,  ['glasses_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 90,   ['mask_2'] = 0,
			['bproof_1'] = 15,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},

	-- Sheriff outfits --
	scadet_wear = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 3,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	spo1_wear = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 3,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	spo2_wear = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 3,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	spo3_wear = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 3,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	ssergeant_wear = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 3,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	sslo_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 3,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	scommander_wear = {
		male = {
			['tshirt_1'] = 42,  ['tshirt_2'] = 0,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 3,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 19,  ['tshirt_2'] = 0,
			['torso_1'] = 335,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
	sboss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 20,  ['tshirt_2'] = 2,
			['torso_1'] = 24,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 10,   ['pants_2'] = 0,
			['shoes_1'] = 38,   ['shoes_2'] = 0,
			['helmet_1'] = 13,  ['helmet_2'] = 2,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0
		},
		female = {
			['tshirt_1'] = 51,  ['tshirt_2'] = 1,
			['torso_1'] = 90,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 45,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['bproof_1'] = 12,  ['bproof_2'] = 2,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 12,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 11,  ['bproof_2'] = 3
		}
	},
	sbullet_wear = {
		male = {
			['bproof_1'] = 12,  ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}
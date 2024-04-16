Config = {}

Config.DrawDistance 			  = 100.0
Config.MarkerType    			  = 1
Config.MarkerSize   			  = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 255, g = 255, b = 255 }
Config.MarkerDeletersColor        = { r = 255, g = 0, b = 0 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false -- enable if you're using esx_identity
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.EnablePoliceFine           = true -- enable fine, requires esx_policejob

Config.MaxInService               = -1
Config.Locale = 'en'

Config.arteshStations = {

	artesh = {

		Blip = {
			Pos     = { x = -2345.54, y = 3262.76, z = 32.1 },
			Sprite  = 419,
			Display = 4,
			Scale   = 1.2,
			Colour  = 0,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 5000 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 5000 },
			{ name = 'weapon_pistol',     		price = 5000 },
			{ name = 'WEAPON_STUNGUN',          price = 5000 },
			{ name = 'WEAPON_SMG',          	price = 50000 },
			{ name = 'WEAPON_CARBINERIFLE',     price = 90000 },
			{ name = 'weapon_specialcarbine',     price = 90000 },
			{ name = 'weapon_microsmg',     price = 50000 },

		},

		Cloakrooms = {
			{ x = -2357.72, y = 3255.46, z = 31.9 },
		},

		Armories = {
			{ x = -2349.17, y = 3267.92, z = 31.81 },
	},

		Vehicles = {
			{
				Spawner    = { x = -2171.73, y = 3255.15, z = 31.81 },
	SpawnPoints = {
					{ x = -2163.37, y = 3214.86, z = 31.81, heading = 145.35, radius = 6.0 },

		}
			},
		},

		VehicleDeleters = {
			{ x = -2163.37, y = 3214.86, z = 31.81 }
	},

		BossActions = {
			{ x = -2358.19, y = 3249.98, z = 100.45 },
	},

		Elevator = {
			{
				Top = { x = -2355.24, y = 3249.36, z = 100.45 },
				Down = { x = -2342.54, y = 3262.09, z = 31.83 },
				Parking = { x = -2170.5, y = 3264.43, z = 31.81 }
}
		},

},
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
		{
			model = 'crusader',
			label = 'Jip'
		},
		{
			model = 'barracks',
			label = 'Nafar Bar'
		},
		{		
			model = 'policeind',
			label = 'neonPd'
		},		
		{
			model = 'bf400',
			label = 'Motor '
		},
		{
			model = 'barrage',
			label = 'Artesh 2'
		},
		{
			model = 'Cargobob',
			label = 'Heli Nafar Bar'
		},
		{
			model = 'annihilator2',
			label = 'annihilator2'
		},
		{
			model = 'swift',
			label = 'swift'
		},
		{
			model = 'winky',
			label = 'winky'
		},
		{
			model = 'riot2',
			label = 'riot2'
		},
		{
			model = 'squaddie',
			label = 'squaddie'
		},
		{
			model = 'manchez2',
			label = 'manchez2'
		},
		{
			model = 'armye63',
			label = 'Benz'
		},
		
}

Config.Uniforms = {
	agent_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 306,
			['torso_2'] = 4,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 80,
			['pants_2'] = 0,
			['shoes_1'] = 75,
			['shoes_2'] = 0,
			['helmet_1'] = 121,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 90,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 96,
			['tshirt_2'] = 0,
			['torso_1'] = 36,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 1,
			['arms_2'] = 0,
			['pants_1'] = 13,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 10,
			['helmet_2'] = 4,
			['chain_1'] = 1,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	special_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 306,
			['torso_2'] = 4,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 80,
			['pants_2'] = 0,
			['shoes_1'] = 75,
			['shoes_2'] = 0,
			['helmet_1'] = 121,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 90,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 96,
			['tshirt_2'] = 0,
			['torso_1'] = 36,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 1,
			['arms_2'] = 0,
			['pants_1'] = 13,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 10,
			['helmet_2'] = 4,
			['chain_1'] = 1,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	supervisor_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 306,
			['torso_2'] = 4,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 80,
			['pants_2'] = 0,
			['shoes_1'] = 75,
			['shoes_2'] = 0,
			['helmet_1'] = 121,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 90,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 96,
			['tshirt_2'] = 0,
			['torso_1'] = 36,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 1,
			['arms_2'] = 0,
			['pants_1'] = 13,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 10,
			['helmet_2'] = 4,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	assistant_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 306,
			['torso_2'] = 4,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 80,
			['pants_2'] = 0,
			['shoes_1'] = 75,
			['shoes_2'] = 0,
			['helmet_1'] = 121,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 90,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 96,
			['tshirt_2'] = 0,
			['torso_1'] = 36,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 1,
			['arms_2'] = 0,
			['pants_1'] = 13,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 10,
			['helmet_2'] = 4,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 306,
			['torso_2'] = 4,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 80,
			['pants_2'] = 0,
			['shoes_1'] = 75,
			['shoes_2'] = 0,
			['helmet_1'] = 121,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 90,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 96,
			['tshirt_2'] = 0,
			['torso_1'] = 36,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 1,
			['arms_2'] = 0,
			['pants_1'] = 13,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 10,
			['helmet_2'] = 4,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	bullet_wear = {
		male = {
			['bproof_1'] = 9,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 9,  ['bproof_2'] = 0
		}
	}

}
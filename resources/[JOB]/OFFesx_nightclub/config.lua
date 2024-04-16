Config = {}

Config.DrawDistance 			  = 100.0
Config.MarkerType    			  = 22
Config.MarkerSize   			  = { x = 1.0, y = 1.0, z = 0.5 }
Config.MarkerColor                = { r = 855, g = 5, b = 255 }
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

Config.nightclubStations = {

	nightclub = {


		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 5000 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 5000 },
			{ name = 'weapon_pistol',     		price = 5000 },
			{ name = 'weapon_bzgas',     		price = 5000 },
			{ name = 'WEAPON_STUNGUN',          price = 5000 },
			{ name = 'WEAPON_PISTOL50',          price = 5000 },			
			{ name = 'WEAPON_SMG',          	price = 50000 },
			{ name = 'WEAPON_CARBINERIFLE',     price = 90000 },
			{ name = 'weapon_specialcarbine',     price = 90000 },
			{ name = 'weapon_microsmg',     price = 50000 },

		},

		Cloakrooms = {
			{ x = -228.94, y = -282.65, z = 29.26 },
		},

		Armories = {
			{ x = -209.01, y = -265.7, z = 26.32 },
	},

		Vehicles = {
			{
				
	SpawnPoints = {
					{ x = 112133.97, y = -715.42, z = 33.13, heading = 167.82, radius = 6.0 },
					{ x = 104123123.0146, y = -730.836, z = 32.779, heading = 340.8, radius = 6.0 },
					{ x = 101231237.748, y = -732.138, z = 32.780, heading = 339.2, radius = 6.0 },
					{ x = 141231236.64, y = -759.71, z = 262.88, heading = 339.2, radius = 6.0 }
					
		}
			},
		},

		VehicleDeleters = {
			{ x = 912336.1359, y = -728.160, z = 32.133 },
			{ x = 91231233.267, y = -720.182, z = 32.133 }
	},
	VehicleSpawners = {
	{ x = 9132315.547, y = -723.756, z = 32.133 },
	{ x = 14123123232.46, y = -766.95, z = 261.87 }
	},

		BossActions = {
	{ x = -219.96, y = -281.76, z = 29.26 }
	},

		Elevator = {
			{
				Top = { x = 112312336.093, y = -761.823, z = 241.152 },
				Down = { x = 112312336.093, y = -761.809, z = 44.752 },
				Parking = { x = 112312310.28, y = -735.82, z = 32.13 }
}
		},

},
}



-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'nightclub',
			label = 'nightclub 1'
		},
			
		{
			model = 'nightclub2',
			label = 'nightclub 2'
		},
		{
			model = 'carbonrs',
			label = 'nightclub Motor 1'
		},
		{
			model = 'insurgent2',
			label = 'nightclub Insurgent'
		},
		{
			model = 'laferrari17',
			label = 'nightclub VIP 1'
		},
		{
			model = 'polschafter3',
			label = 'nightclub VIP 2'
		},
		{
			model = '20f350',
			label = 'nightclub Afrod'
		},
		{
			model = '20f350',
			label = 'nightclub Afrod'
		},
		{
			model = 'CT5V',
			label = 'nightclub 2Dar'
		},
		

		

},

	agent = {

	},

	special = {

	},

	supervisor = {

	},

	assistant = {
	
    },

	boss = {
		{
			model = 'baller6',
			label = 'zed golole'
		},
	}
}

Config.Uniforms = {
	agent_wear = {
		male = {
			['tshirt_1'] = 60,
			['tshirt_2'] = 0,
			['torso_1'] = 4,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 20,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 117,
			['helmet_2'] = 0,
			['chain_1'] = 125,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 34,
			['tshirt_2'] = 0,
			['torso_1'] = 332,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 52,
			['pants_2'] = 2,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 95,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},
swat_wear = {
		male = {
			['tshirt_1'] = 53,
			['tshirt_2'] = 1,
			['torso_1'] = 53,
			['torso_2'] = 0,
			['decals_1'] = 3,
			['decals_2'] = 0,
			['arms'] = 31,
			['arms_2'] = 0,
			['pants_1'] = 31,
			['pants_2'] = 0,
			['shoes_1'] = 24,
			['shoes_2'] = 0,
			['helmet_1'] = 117,
			['helmet_2'] = 0,
			['chain_1'] = 1,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0,
			['bproof_1'] = 12,
			['bproof_2'] = 4
		},
		female = {
			['tshirt_1'] = 34,
			['tshirt_2'] = 0,
			['torso_1'] = 332,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 52,
			['pants_2'] = 2,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 95,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},
	special_wear = {
		male = {
			['tshirt_1'] = 60,
			['tshirt_2'] = 0,
			['torso_1'] = 4,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 20,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 117,
			['helmet_2'] = 0,
			['chain_1'] = 125,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 34,
			['tshirt_2'] = 0,
			['torso_1'] = 332,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 52,
			['pants_2'] = 2,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 95,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	supervisor_wear = {
		male = {
			['tshirt_1'] = 60,
			['tshirt_2'] = 0,
			['torso_1'] = 4,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 20,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 117,
			['helmet_2'] = 0,
			['chain_1'] = 125,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 34,
			['tshirt_2'] = 0,
			['torso_1'] = 332,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 52,
			['pants_2'] = 2,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 95,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	assistant_wear = {
		male = {
			['tshirt_1'] = 60,
			['tshirt_2'] = 0,
			['torso_1'] = 4,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 20,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 117,
			['helmet_2'] = 0,
			['chain_1'] = 125,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 34,
			['tshirt_2'] = 0,
			['torso_1'] = 332,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 52,
			['pants_2'] = 2,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 95,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 60,
			['tshirt_2'] = 0,
			['torso_1'] = 4,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 20,
			['arms_2'] = 0,
			['pants_1'] = 28,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = 117,
			['helmet_2'] = 0,
			['chain_1'] = 125,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 121,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 34,
			['tshirt_2'] = 0,
			['torso_1'] = 332,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 28,
			['arms_2'] = 0,
			['pants_1'] = 52,
			['pants_2'] = 2,
			['shoes_1'] = 29,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 95,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		}
	},

	bullet_wear = {
		male = {
			['bproof_1'] = 14,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 21,  ['bproof_2'] = 3
		}
	}

}
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

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends #changedp
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society
Config.EnablePoliceFine           = true -- enable fine, requires esx_policejob

Config.MaxInService               = -1
Config.Locale = 'en'

Config.FBIStations = {

	FBI = {

		Blip = {
			Pos     = { x = 112.105, y = -749.363, z = 45.751 },
			Sprite  = 88,
			Display = 4,
			Scale   = 0.8,
			Colour  = 43,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
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
			{ x = 152.046, y = -736.179, z = 241.151 },
		},

		Armories = {
			{ x = 143.654, y = -764.390, z = 241.152 },
	},

		Vehicles = {
			{
				
	SpawnPoints = {
					{ x = 113.97, y = -715.42, z = 33.13, heading = 167.82, radius = 6.0 },
					{ x = 104.046, y = -730.836, z = 32.779, heading = 340.8, radius = 6.0 },
					{ x = 107.748, y = -732.138, z = 32.780, heading = 339.2, radius = 6.0 },
					{ x = 146.64, y = -759.71, z = 262.88, heading = 339.2, radius = 6.0 }
					
		}
			},
		},

		VehicleDeleters = {
			{ x = 96.359, y = -728.160, z = 32.133 },
			{ x = 93.267, y = -720.182, z = 32.133 }
	},
	VehicleSpawners = {
	{ x = 95.547, y = -723.756, z = 32.133 },
	{ x = 142.46, y = -766.95, z = 261.87 }
	},

		BossActions = {
			{ x = 148.941, y = -758.541, z = 241.151 }
	},

		Elevator = {
			{
				Top = { x = 136.093, y = -761.823, z = 241.152 },
				Down = { x = 136.093, y = -761.809, z = 44.752 },
				Parking = { x = 110.28, y = -735.82, z = 32.13 }
}
		},

},
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'fbi',
			label = 'FBI 1'
		},
			
		{
			model = 'fbi2',
			label = 'FBI 2'
		},
		{
			model = 'carbonrs',
			label = 'FBI Motor 1'
		},
		{
			model = 'insurgent2',
			label = 'FBI Insurgent'
		},
		{
			model = 'laferrari17',
			label = 'FBI VIP 1'
		},
		{
			model = 'ROADRUNNER',
			label = 'FBI 4'
		},
		{
			model = 'HAZARD',
			label = 'FBI 3'
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
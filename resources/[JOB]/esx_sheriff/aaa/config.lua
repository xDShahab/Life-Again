Config = {}

Config.DrawDistance 			  = 100.0
Config.MarkerType    			  = 22
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

Config.sheriffStations = {

	sheriff = {



		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 0 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 0 },
			{ name = 'weapon_pistol',     		price = 0 },
			{ name = 'weapon_pistol50',     		price = 0 },			
			{ name = 'weapon_bzgas',     		price = 0 },
			{ name = 'WEAPON_STUNGUN',          price = 0 },
			{ name = 'WEAPON_SMG',          	price = 0 },
			{ name = 'WEAPON_CARBINERIFLE',     price = 0 },
			{ name = 'weapon_specialcarbine',     price = 0 },
			{ name = 'weapon_microsmg',     price = 0 },

		},

		Cloakrooms = {
			{ x = 1538.49, y = 811.62, z = 77.66 }
		},

		Armories = {
			{ x = 1550.33, y = 841.61, z = 77.66 }
			},

		Vehicles = {
			{
				Spawner    = { x = 1529.26, y = 815.52, z = 77.43 },
	SpawnPoints = {
					{ x = 1532.73, y = 803.04, z = 76.64, heading = 62.49, radius = 6.0 },
		}
			},
		},

		VehicleDeleters = {
			{x = 1529.71, y = 779.5, z = 77.44},
			{x = 1563.58, y = 845.04, z = 77.53}
	},

		BossActions = {
			{ x = 1540.61, y = 814.7, z = 82.13 }
	},

		Elevator = {
			{
				Top = {},
				Down = {},
				Parking = {}
}
		},
		Helicopters = {
			{
				Spawner    = { x = 1568.54, y = 833.67, z = 77.14 },
				SpawnPoint = { x = 1563.58, y = 845.04, z = 77.53 },
				Heading    = 62.76
			},
		},	

},
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = '2020explorer',
			label = 'sheriff 1'
		},
		{
			model = '2011vic',
			label = 'sheriff 2'
		},						
		{
			model = '2014explorer',
			label = 'sheriff 3'
		},
		{
			model = 'caprice',
			label = 'vip 1'
		},
		{
			model = '2020tahoe',
			label = 'vip 2'
		},

		
		
},

	
}

Config.Uniforms = {
	agent_wear = {
		male = {
			['tshirt_1'] = 16,
			['tshirt_2'] = 1,
			['torso_1'] = 181,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 23,
			['arms_2'] = 0,
			['pants_1'] = 65,
			['pants_2'] = 1,
			['shoes_1'] = 25,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 31,  
			['tshirt_2'] = 0,
			['torso_1'] = 194,  
			['torso_2'] = 0,
			['decals_1'] = 15,   
			['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,  
		    ['pants_2'] = 1,
			['shoes_1'] = 62, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 0, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		}
	},
	
swat_wear = {
		male = {
			['tshirt_1'] = 17,  ['tshirt_2'] = 0,
			['torso_1'] = 181,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 23,
			['pants_1'] = 65,   ['pants_2'] = 2,
			['shoes_1'] = 40,   ['shoes_2'] = 0,
			['helmet_1'] = 121,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['mask_1'] = 90,   ['mask_2'] = 0,
			['bproof_1'] = 26,  ['bproof_2'] = 0

		},
		female = {
			['tshirt_1'] = 31,  
			['tshirt_2'] = 0,
			['torso_1'] = 194,  
			['torso_2'] = 0,
			['decals_1'] = 15,   
			['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,  
		    ['pants_2'] = 1,
			['shoes_1'] = 62, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 0, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		}
	},	

	special_wear = {
		male = {
			['tshirt_1'] = 16,
			['tshirt_2'] = 1,
			['torso_1'] = 181,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 23,
			['arms_2'] = 0,
			['pants_1'] = 65,
			['pants_2'] = 1,
			['shoes_1'] = 25,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 31,  
			['tshirt_2'] = 0,
			['torso_1'] = 194,  
			['torso_2'] = 0,
			['decals_1'] = 15,   
			['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,  
		    ['pants_2'] = 1,
			['shoes_1'] = 62, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 0, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		}
	},

	supervisor_wear = {
		male = {
			['tshirt_1'] = 16,
			['tshirt_2'] = 1,
			['torso_1'] = 181,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 23,
			['arms_2'] = 0,
			['pants_1'] = 65,
			['pants_2'] = 1,
			['shoes_1'] = 25,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 31,  
			['tshirt_2'] = 0,
			['torso_1'] = 194,  
			['torso_2'] = 0,
			['decals_1'] = 15,   
			['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,  
		    ['pants_2'] = 1,
			['shoes_1'] = 62, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 0, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		}
	},

	assistant_wear = {
		male = {
			['tshirt_1'] = 16,
			['tshirt_2'] = 1,
			['torso_1'] = 181,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 23,
			['arms_2'] = 0,
			['pants_1'] = 65,
			['pants_2'] = 1,
			['shoes_1'] = 25,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 31,  
			['tshirt_2'] = 0,
			['torso_1'] = 194,  
			['torso_2'] = 0,
			['decals_1'] = 15,   
			['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,  
		    ['pants_2'] = 1,
			['shoes_1'] = 62, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 0, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 16,
			['tshirt_2'] = 1,
			['torso_1'] = 181,
			['torso_2'] = 0,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 23,
			['arms_2'] = 0,
			['pants_1'] = 65,
			['pants_2'] = 1,
			['shoes_1'] = 25,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 0,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0
		},
		female = {
			['tshirt_1'] = 31,  
			['tshirt_2'] = 0,
			['torso_1'] = 194,  
			['torso_2'] = 0,
			['decals_1'] = 15,   
			['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 97,  
		    ['pants_2'] = 1,
			['shoes_1'] = 62, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 0, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		}
	},

	bullet_wear = {
		male = {
			['bproof_1'] = 22,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 21,  ['bproof_2'] = 3
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
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

		Blip = {
			Pos     = { x = -445.2787, y = 6005.8628, z = 31.7165 },
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 60,
		},

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
			{ x = -437.38, y = 6010.01, z = 37.0 }
		},

		Armories = {
			{ x = -447.25, y = 6016.25, z = 37.0 }
			},

		Vehicles = {
			{
				Spawner    = { x = -449.29, y = 6025.82, z = 31.49 },
	SpawnPoints = {
					{ x = -459.07, y = 6043.42, z = 31.34, heading = 214.58, radius = 6.0 },
					{ x = -459.07, y = 6043.42, z = 31.34, heading = 117.11, radius = 6.0 },
		}
			},
		},
		VehicleDeleters = {
			{ x = -482.8392, y = 6024.8696, z = 31.3405 },
			{ x = -479.8720, y = 6028.1016, z = 31.3405 },
			{x = -476.8088, y = 6032.32234, z = 31.3405}
	},

		BossActions = {
			{ x = -432.86, y = 6006.02, z = 37.0 }
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
				Spawner    = { x = 1859.6, y = 3657.04, z = 34.03 },
				SpawnPoint = { x = 1845.07, y = 3635.54, z = 35.55 },
				Heading    = 28.7
			},
		},	

},
}


Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'barracks3',
			label = 'barracks3'
		},
		{
			model = 'crusader',
			label = 'crusader'
		},						
		{
			model = 'sheriff',
			label = 'sheriff'
		},
		{
			model = 'sheriff2',
			label = 'sheriff2'
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
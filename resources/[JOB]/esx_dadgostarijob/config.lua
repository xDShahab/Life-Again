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

Config.dadgostariStations = {

	dadgostari = {

		Blip = {
			Pos     = { x = -537.51, y = -184.74, z = 38.65 },
			Sprite  = 592,
			Display = 4,
			Scale   = 0.9,
			Colour  = 9,
		},



		-- https://wiki.rage.mp/index.php?title=Weapons
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
			{ name = 'WEAPON_SPECIALCARBINE',     price = 12000 },
			{ name = 'WEAPON_CARBINERIFLE', price = 12000 },
			{ name = 'weapon_specialcarbine',     price = 90000 },

		},

		Cloakrooms = {
			{ x = -560.34, y = -206.39, z = 38.22 }
		},

		Armories = {
			{ x = -515.21, y = -199.48, z = 34.25 }
	},

		Vehicles = {
			{
				Spawner    = { x = -508.76, y = -253.07, z = 35.61 },
	SpawnPoints = {
					{ x = -510.28, y = -261.8, z = 35.47, heading = 111.15, radius = 6.0 },
					{ x = -510.28, y = -261.8, z = 35.47, heading = 111.15, radius = 6.0 },
		}
			},
		},

		VehicleDeleters = {
			{  x = -510.28, y = -261.8, z = 35.47}
	},

		BossActions = {
			{ x = -521.62, y = -196.62, z = 38.22 }
	},

		Elevator = {
			{
				Top = { x = -555.24, y = -196.52, z = 47.41 },
				Down = { x = -550.2, y = -182.2, z = 38.22 },
				Parking = { x = -568.86, y = -235.87, z = 34.22 }
}
		},

},
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	{
		model = "schafter6",
		label = "SchafteR - BosS"
	},
	{
		model = "freecrawler",
		label = "VIP - BosS"
	},
	{
		model = "stretch",
		label = "LimO"
	},
	{
		model = "hazard",
		label = "Haml Zendani"
	},
	{
		model = "idcar",
		label = "Haml Zendani 2"
	}

}

Config.Uniforms = {
	agent_wear = {
		male = {
			['tshirt_1'] = 33,  
			['tshirt_2'] = 0,
			['torso_1'] = 118,  
			['torso_2'] = 0,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 62,  
		    ['pants_2'] = 0,
			['shoes_1'] = 10, 
		    ['shoes_2'] = 0,
			['helmet_1'] = -1, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 44,  
			['tshirt_2'] = 0,
			['torso_1'] = 50,  
			['torso_2'] = 4,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 46,  
		    ['pants_2'] = 1,
			['shoes_1'] = 24, 
		    ['shoes_2'] = 0,
			['helmet_1'] = -1, 
			['helmet_2'] = 0,
			['chain_1'] = 1,   
			['chain_2'] = 0,
			['ears_1'] = 2,    
			['ears_2'] = 0
		}
	},

	special_wear = {
		male = {
			['tshirt_1'] = 33,  
			['tshirt_2'] = 0,
			['torso_1'] = 118,  
			['torso_2'] = 0,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 62,  
		    ['pants_2'] = 0,
			['shoes_1'] = 10, 
		    ['shoes_2'] = 0,
			['helmet_1'] = -1, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 44,  
			['tshirt_2'] = 0,
			['torso_1'] = 50,  
			['torso_2'] = 4,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 46,  
		    ['pants_2'] = 1,
			['shoes_1'] = 24, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 10, 
			['helmet_2'] = 7,
			['chain_1'] = 1,   
			['chain_2'] = 0,
			['ears_1'] = 2,    
			['ears_2'] = 0
		}
	},

	supervisor_wear = {
		male = {
			['tshirt_1'] = 33,  
			['tshirt_2'] = 0,
			['torso_1'] = 118,  
			['torso_2'] = 0,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 62,  
		    ['pants_2'] = 0,
			['shoes_1'] = 10, 
		    ['shoes_2'] = 0,
			['helmet_1'] = -1, 
			['helmet_2'] = 0,
			['chain_1'] = 0,   
			['chain_2'] = 0,
			['ears_1'] = 0,    
			['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 44,  
			['tshirt_2'] = 0,
			['torso_1'] = 50,  
			['torso_2'] = 4,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 27,
			['pants_1'] = 46,  
		    ['pants_2'] = 1,
			['shoes_1'] = 24, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 10, 
			['helmet_2'] = 7,
			['chain_1'] = 1,   
			['chain_2'] = 0,
			['ears_1'] = 2,    
			['ears_2'] = 0
		}
	},

	assistant_wear = {
		male = {
			['tshirt_1'] = 33,  
			['tshirt_2'] = 0,
			['torso_1'] = 118,  
			['torso_2'] = 0,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 62,  
		    ['pants_2'] = 0,
			['shoes_1'] = 10, 
		    ['shoes_2'] = 0,
			['helmet_1'] = -1, 
			['helmet_2'] = 0,
			['chain_1'] = 10,   
			['chain_2'] = 10,
			['ears_1'] = 0,    
			['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 44,  
			['tshirt_2'] = 0,
			['torso_1'] = 100,  
			['torso_2'] = 0,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 46,  
		    ['pants_2'] = 1,
			['shoes_1'] = 24, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 10, 
			['helmet_2'] = 0,
			['chain_1'] = 1,   
			['chain_2'] = 0,
			['ears_1'] = 2,    
			['ears_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 33,  
			['tshirt_2'] = 0,
			['torso_1'] = 118,  
			['torso_2'] = 0,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 62,  
		    ['pants_2'] = 0,
			['shoes_1'] = 10, 
		    ['shoes_2'] = 0,
			['helmet_1'] = -1, 
			['helmet_2'] = 0,
			['chain_1'] = 10,   
			['chain_2'] = 0,
			['ears_1'] = 10,    
			['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 44,  
			['tshirt_2'] = 0,
			['torso_1'] = 100,  
			['torso_2'] = 0,
			['decals_1'] = 0,   
			['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 46,  
		    ['pants_2'] = 1,
			['shoes_1'] = 24, 
		    ['shoes_2'] = 0,
			['helmet_1'] = 10, 
			['helmet_2'] = 0,
			['chain_1'] = 1,   
			['chain_2'] = 0,
			['ears_1'] = 2,    
			['ears_2'] = 0
		}
	},

	bullet_wear = {
		male = {
			['bproof_1'] = 43,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 11,  ['bproof_2'] = 4
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 43,  ['tshirt_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}
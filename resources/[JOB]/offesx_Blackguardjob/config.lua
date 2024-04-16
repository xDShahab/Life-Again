Config                            = {}

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

Config.BlackguardStations = {

	Blackguard = {

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
			{ name = 'WEAPON_COMBATPDW', price = 12000 }
		},

		Cloakrooms = {
			{ x = -424.15, y = 21.67, z = 34.02 },
		},

		Armories = {
			{ x = -424.11, y = 19.42, z = 34.01 },
	},

		Vehicles = {
			{
				Spawner    = { x = -475.18, y = 49.86, z = 51.41 },
	SpawnPoints = {
					{ x = -499.15, y = 51.57, z = 52.17, heading = 85.03, radius = 6.0 }
		}
			},
		},

		VehicleDeleters = {
			{ x = -478.37, y = 40.89, z = 51.41 }
	},

		BossActions = {
			{ x = -483.54, y = 62.75, z = 51.41 }
	},

		Elevator = {
			{
				Top = { x = -4623239.49, y = 43.02, z = 45.23 },
				Down = { x = 131232136.093, y = -761.809, z = 44.752 },
				Parking = { x = 111232131.19, y = -734.17, z = 32.13 }
}
		},

},
}

Config.AuthorizedVehicles = {
		{
			model = 'g65amg',
			label = 'AMG'
		},
		{
			model = 'mc63',
			label = 'Benz'
		},
		{
			model = 'xls2',
			label = 'xls2'
		},	
		{
			model = 'everon',
			label = 'everon'
		},	
		{
			model = 'brutus',
			label = 'brutus'
		},	

}



Config.AuthorizedWeapons = {
	Shared = {
		{ name = 'WEAPON_NIGHTSTICK', price = 100 },
		{ name = 'WEAPON_STUNGUN', price = 500 },
		{ name = 'WEAPON_FLASHLIGHT', price = 100 },
		{ name = 'WEAPON_PISTOL', price = 5000 },
		{ name = 'WEAPON_SNSPISTOL', price = 6000 },
		{ name = 'WEAPON_COMBATPISTOL', price = 7000 },
		{ name = 'WEAPON_PISTOL50', price = 9000 },
		{ name = 'WEAPON_HEAVYPISTOL', price = 8000 },
	},

	agent = {
		
	},

	special = {

	},

	supervisor = {
		{ name = 'WEAPON_SMG', price = 12000 }
	},

	assistant = {
		{ name = 'WEAPON_SMG',     price = 12000 }
	},

	boss = {
		{ name = 'WEAPON_SMG', price = 12000 }
	}

}

Config.Uniforms = {
	agent_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 198,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 26,
			['arms_2'] = 0,
			['pants_1'] = 31,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 6,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
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
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	swat_wear = {
		male = {
			['tshirt_1'] = 132,
			['tshirt_2'] = 0,
			['torso_1'] = 88,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 21,
			['arms_2'] = 0,
			['pants_1'] = 93,
			['pants_2'] = 0,
			['shoes_1'] = 40,
			['shoes_2'] = 0,
			['helmet_1'] = 121,
			['helmet_2'] = 0,
			['chain_1'] = 1,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 185,
			['mask_2'] = 0,
			['bproof_1'] = 44,
			['bproof_2'] = 0
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

	gang_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 69,
			['torso_2'] = 4,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 26,
			['arms_2'] = 0,
			['pants_1'] = 86,
			['pants_2'] = 1,
			['shoes_1'] = 42,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 1,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
			['mask_2'] = 0,
			['bproof_1'] = 0,
			['bproof_2'] = 0
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
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 198,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 26,
			['arms_2'] = 0,
			['pants_1'] = 31,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 6,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
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
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	supervisor_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 198,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 26,
			['arms_2'] = 0,
			['pants_1'] = 31,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 6,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
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
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	assistant_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 198,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 26,
			['arms_2'] = 0,
			['pants_1'] = 31,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 6,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
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
			['mask_1'] = 121,
			['mask_2'] = 0
		}
	},

	boss_wear = {
		male = {
			['tshirt_1'] = 15,
			['tshirt_2'] = 0,
			['torso_1'] = 198,
			['torso_2'] = 3,
			['decals_1'] = 0,
			['decals_2'] = 0,
			['arms'] = 26,
			['arms_2'] = 0,
			['pants_1'] = 31,
			['pants_2'] = 0,
			['shoes_1'] = 10,
			['shoes_2'] = 0,
			['helmet_1'] = -1,
			['helmet_2'] = 0,
			['chain_1'] = 6,
			['chain_2'] = 0,
			['ears_1'] = -1,
			['ears_2'] = 0,
			['mask_1'] = 0,
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
			['bproof_1'] = 48,  ['bproof_2'] = 0
		},
		female = {
			['bproof_1'] = 21,  ['bproof_2'] = 3
		}
	}

}
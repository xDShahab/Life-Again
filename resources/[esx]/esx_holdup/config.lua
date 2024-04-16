Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 2
Config.TimerBeforeNewRob    = 2200 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 12   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["paleto_twentyfourseven"] = {
		position = { x = 1736.32, y = 6419.47, z = 35.03 },
		reward = math.random(320000, 350000),
		nameOfStore = "24/7. (Paleto Bay)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(320000, 350000),
		nameOfStore = "24/7. (Sandy Shores)",
		secondsRemaining = 220, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { x = -709.17, y = -904.21, z = 19.21 },
		reward = math.random(120000, 150000),
		nameOfStore = "24/7. (Little Seoul)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["Biron_shahr"] = {
		position = { x = -3249.21, y = 1005.35, z = 12.83 },
		reward = math.random(320000, 350000),
		nameOfStore = "Robs Liquor. (Biron shahr)",
		secondsRemaining = 250, -- seconds
		lastRobbed = 0
	},
	["South_Senora_Fwy"] = {
		position = { x = 2673.1, y = 3286.81, z = 55.24 },
		reward = math.random(320000, 350000),
		nameOfStore = "Robs Liquor. (Biron shahr)",
		secondsRemaining = 180, -- seconds
		lastRobbed = 0
	},
	["South_Senora_2bilon"] = {
		position = { x = 1707.54, y = 4920.12, z = 42.06 },
		reward = math.random(120000, 150000),
		nameOfStore = "Robs Liquor. (Biron 4)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["Biron_shahrr"] = {
		position = { x = -3047.31, y = 585.9, z = 7.91 },
		reward = math.random(320000, 350000),
		nameOfStore = "Robs Liquor. (Biron shahr 2)",
		secondsRemaining = 250, -- seconds
		lastRobbed = 0
	},
	["Downtown_Vinewood"] = {
		position = { x = 377.0, y = 333.13, z = 103.57 },
		reward = math.random(120000, 150000),
		nameOfStore = "Downtown Vinewood 24/7 Safe",
		secondsRemaining = 220, -- seconds
		lastRobbed = 0
	},
	["Rockford_Dr"] = {
		position = { x = -1828.91, y = 799.06, z = 138.18 },
		reward = math.random(120000, 150000),
		nameOfStore = "Rockford Dr 24/7 Safe",
		secondsRemaining = 260, -- seconds
		lastRobbed = 0
	},
	["Innocence_Blvd"] = {
		position = { x = 29.12, y = -1339.89, z = 29.5 },
		reward = math.random(120000, 150000),
		nameOfStore = "Innocence Blvd 24/7 Safe",
		secondsRemaining = 180, -- seconds
		lastRobbed = 0
	},
	["Route_Register"] = {
		position = { x = 546.66, y = 2663.26, z = 42.16 },
		reward = math.random(120000, 150000),
		nameOfStore = "Route 68 24/7 Register",
		secondsRemaining = 180, -- seconds
		lastRobbed = 0
	},
	["grove_ltd"] = {
		position = { x = -43.40, y = -1749.20, z = 29.42 },
		reward = math.random(120000, 150000),
		nameOfStore = "LTD Gasoline. (Grove Street)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["mirror_ltd"] = {
		position = { x = 1160.67, y = -314.40, z = 69.20 },
		reward = math.random(120000, 150000),
		nameOfStore = "LTD Gasoline. (Mirror Park Boulevard)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["Prosperty_st"] = {
		position = { x = -1479.38, y = -374.13, z = 38.16 },
		reward = math.random(120000, 150000),
		nameOfStore = "Prosperty Street.",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["san_andreas_ave"] = {
		position = { x = -1219.18, y = -915.82, z = 10.33 },
		reward = math.random(120000, 150000),
		nameOfStore = "San Andreas Ave.",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["san_andreas_ave"] = {
		position = { x = 253.34, y =  -52.77, z = 69.94 },
		reward = math.random(120000, 150000),
		nameOfStore = "Gun Shop 1",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["san_andreas_ave"] = {
		position = { x = 2565.51, y = 292.37, z = 108.73 },
		reward = math.random(120000, 150000),
		nameOfStore = "Gun Shop 2",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["san_andreas_ave"] = {
		position = { x = 840.2, y = 840.2, z = 840.2 },
		reward = math.random(120000, 150000),
		nameOfStore = "Gun Shop 3",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["san_andreas_ave"] = {
		position = { x = 840.2, y = 840.2, z = 840.2 },
		reward = math.random(120000, 150000),
		nameOfStore = "Gun Shop 3",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	}
	  

}





Config.Zones = {
	Bot = {
		Pos = {
			{x= -1847.9, y=  -1196.43, z= 20.68, type = "display" }
        },
		Posm = {
			{x= -1847.9, y=  -1196.43, z= 20.68, type = "display"}
        }
	}	
}

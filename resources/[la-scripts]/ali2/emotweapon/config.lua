----------------------------------------------------------------
-- Copyright © 2019 by Guy Shefer
-- Made By: Guy293
-- GitHub: https://github.com/Guy293
-- Fivem Forum: https://forum.fivem.net/u/guy293/
-- Tweaked by Campinchris (Added ESX only Diff animation for Police and Non Police)
----------------------------------------------------------------

Config 				  = {}
Config.Cooldowns = {
	["police"] = {
		light = 700,
		heavy = 1200
	},
	["civilian"] = {
		light = 1000,
		heavy = 1350
	}
}

-- Add/remove weapon hashes here to be added for holster checks.
Config.Weapons = {
    [`WEAPON_APPISTOL`] = "light",
    [`WEAPON_CERAMICPISTOL`] = "light",
    [`WEAPON_VINTAGEPISTOL`] = "light",
    [`WEAPON_MARKSMANPISTOL`] = "light",
    [`WEAPON_MACHINEPISTOL`] = "light",
    [`WEAPON_PISTOL_MK2`] = "light",
    [`WEAPON_SNSPISTOL_MK2`] = "light",
    [`WEAPON_FLAREGUN`] = "light",
    [`WEAPON_PISTOL`] = "light",
    [`WEAPON_COMBATPISTOL`] = "light",
    [`WEAPON_PISTOL50`] = "light",
    [`WEAPON_SNSPISTOL`] = "light",
    [`WEAPON_HEAVYPISTOL`] = "light",
    [`WEAPON_STUNGUN`] = "light",
    [`WEAPON_MICROSMG`] = "heavy",
    [`WEAPON_REVOLVER`] = "light",
    [`WEAPON_MICROSMG`] = "light",
    [`WEAPON_ASSAULTSMG`] = "heavy",
    [`WEAPON_COMBATPDW`] = "heavy",
    [`WEAPON_SMG_MK2`] = "heavy",  
    [`WEAPON_PUMPSHOTGUN`] = "heavy",
    [`WEAPON_PUMPSHOTGUN_MK2`] = "heavy",
    [`WEAPON_SAWNOFFSHOTGUN`] = "heavy",
    [`WEAPON_ASSAULTSHOTGUN`] = "heavy",
    [`WEAPON_BULLPUPSHOTGUN`] = "heavy",
    [`WEAPON_ASSAULTRIFLE`] = "heavy",
    [`WEAPON_ASSAULTRIFLE_MK2`] = "heavy",
    [`WEAPON_ADVANCEDRIFLE`] = "heavy",
    [`WEAPON_SMG`] = "heavy",
    [`WEAPON_CARBINERIFLE`] = "heavy",
    [`WEAPON_CARBINERIFLE_MK2`] = "heavy",
    [`WEAPON_SPECIALCARBINE`] = "heavy",
    [`WEAPON_SPECIALCARBINE_MK2`] = "heavy",
    [`WEAPON_BULLPUPRIFLE`] = "heavy",
    [`WEAPON_BULLPUPRIFLE_MK2`] = "heavy",
    [`WEAPON_GUSENBERG`] = "heavy",
    [`WEAPON_COMPACTRIFLE`] = "heavy",
}
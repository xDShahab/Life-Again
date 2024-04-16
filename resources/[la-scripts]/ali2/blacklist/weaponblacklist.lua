weaponblacklist = {
	"weapon_fireextinguisher",
	"weapon_ball",
	"weapon_proxmine",
	"weapon_stickybomb",
	"weapon_grenade",
	"weapon_rayminigun",
	"weapon_compactlauncher",
	"weapon_hominglauncher",
	"weapon_railgun",
	"weapon_minigun",
	"weapon_grenadelauncher_smoke",
	"weapon_grenadelauncher",
	"weapon_rpg",
	"weapon_musket",
	"weapon_machinepistol",
	"weapon_raycarbine",
	"weapon_ceramicpistol",
	"weapon_raypistol",
	"weapon_marksmanpistol",
	"weapon_stone_hatchet",
	"weapon_poolcue",
	"weapon_wrench",
	"weapon_dagger",
	"weapon_golfclub",
}


disableallweapons = false



Citizen.CreateThread(function()
	while true do
		Wait(1000)
		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
					--sendForbiddenMessage("This weapon is blacklisted!")
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end
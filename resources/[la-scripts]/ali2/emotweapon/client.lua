
local ESX      	 = nil
local holstered  = true
local blocked	 = false
local PlayerData = {}
local lastWeapon
local BlockWheel = false
local active = true
------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	checkHolsters()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('holster:active')
AddEventHandler('holster:active', function(state)
	active = state
end)


function checkHolsters()
	while not PlayerData.job do
		Wait(50)
	end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(500)
			local ped = PlayerPedId()
			if active then
				if PlayerData.job.name == 'sheriff' or PlayerData.job.name == 'police' or PlayerData.job.name == 'fbi' or PlayerData.job.name == 'lawyer' then
					if not IsPedInAnyVehicle(ped, false) then
						if GetVehiclePedIsTryingToEnter (ped) == 0 and GetPedParachuteState(ped) < 1 then
							local weapon = CheckWeapon(ped)
							if weapon then
								lastWeapon = weapon
								if holstered then
									blocked  = true
									if weapon == "light" then
										loadAnimDict("reaction@intimidation@cop@unarmed")
										TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when removing weapon
										Citizen.Wait(Config.Cooldowns.police.light)
										loadAnimDict("rcmjosh4")
										TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
										Citizen.Wait(400)
										ClearPedTasks(ped)
										holstered = false
									else
										loadAnimDict("anim@heists@ornate_bank@grab_cash")
										TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
										Citizen.Wait(Config.Cooldowns.police.heavy)
										ClearPedTasks(ped)
										holstered = false
									end
										
								else
									blocked = false
								end
		
							else
								if not holstered then
									if lastWeapon == "heavy" then
										BlockWheel = true
										loadAnimDict("anim@heists@ornate_bank@grab_cash")
										TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "exit", 8.0, 2.0, -1, 48, 10, 0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
										Citizen.Wait(Config.Cooldowns.police.heavy)
										ClearPedTasks(ped)
										holstered = true
										BlockWheel = false
									else
										BlockWheel = true
										TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
										Citizen.Wait(Config.Cooldowns.police.light)
										TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
										Citizen.Wait(60)
										ClearPedTasks(ped)
										holstered = true
										BlockWheel = false
									end
								end
							end
		
						else
							SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						end
					else
						holstered = true
					end
				else
					if not IsPedInAnyVehicle(ped, false) then
						if GetVehiclePedIsTryingToEnter (ped) == 0 and GetPedParachuteState(ped) < 1 then
							local weapon = CheckWeapon(ped)
							if weapon then
								lastWeapon = weapon
								if holstered then
									blocked   = true
									if weapon == "light" then
										loadAnimDict("reaction@intimidation@1h")
										TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0 )
										Citizen.Wait(Config.Cooldowns.civilian.light)
										ClearPedTasks(ped)
										holstered = false
									else
										loadAnimDict("anim@heists@ornate_bank@grab_cash")
										TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "intro", 8.0, 2.0, -1, 48, 10, 0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
										Citizen.Wait(Config.Cooldowns.civilian.heavy)
										ClearPedTasks(ped)
										holstered = false
									end
										
									holstered = false
								else
									blocked = false
								end
							else
								if not holstered then
									if lastWeapon == "heavy" then
										BlockWheel = true
										loadAnimDict("anim@heists@ornate_bank@grab_cash")
										TaskPlayAnim(ped, "anim@heists@ornate_bank@grab_cash", "exit", 8.0, 2.0, -1, 48, 10, 0, 0, 0) -- Change 50 to 30 if you want to stand still when removing weapon
										Citizen.Wait(Config.Cooldowns.civilian.heavy)
										ClearPedTasks(ped)
										holstered = true
										BlockWheel = false
									else
										BlockWheel = true
										loadAnimDict("reaction@intimidation@1h")
										TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125, 0 ) -- Change 50 to 30 if you want to stand still when holstering weapon
										Citizen.Wait(Config.Cooldowns.civilian.light)
										ClearPedTasks(ped)
										holstered = true
										BlockWheel = false
									end
								end
							end
						else
							SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						end
					else
						holstered = true
					end
				end
			end
		end
	end)
end
local tout = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if blocked then
			DisableControlAction(1, 25, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
			if tout == 0 then
				tout = ESX.SetTimeout(1500,function()
					BlockWheel = false
					blocked = false
					tout = 0
				end)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if BlockWheel then
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
		else
			Citizen.Wait(500)
		end
	end
end)


function CheckWeapon(ped)
	if IsEntityDead(ped) then
		blocked = false
		return false
	else
		local weapon = GetSelectedPedWeapon(ped)
		--return Config.Weapons[weapon]
	end
end

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

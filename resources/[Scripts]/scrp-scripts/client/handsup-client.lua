
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(20)
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) and disableShuffle then
			local vehicle = GetVehiclePedIsIn(ped)
			
			if GetPedInVehicleSeat(vehicle, 0) == ped then
				if GetIsTaskActive(ped, 165) then
					SetPedIntoVehicle(ped, vehicle, 0)
				end

				if GetPedInVehicleSeat(vehicle, -1) == 0 then

					ESX.ShowHelpNotification('Dokme ~INPUT_CONTEXT~ Jahat Neshastan Dar Sandali Ranande')
					if IsControlPressed(0, Keys["E"]) then
						disableSeatShuffle(false)
						Citizen.Wait(5000)
						disableSeatShuffle(true)
					end

				end
			else
				Citizen.Wait(500)
			end

		else
			Citizen.Wait(500)
		end
	end
end)	

handsup = false
local isDead = false
active = true
Citizen.CreateThread(function()
	local dict = "missfra1mcs_2_crew_react"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end

	while true do
		Citizen.Wait(0)
		    if IsPedReloading(GetPlayerPed(-1)) then
			 active = false
			 Citizen.SetTimeout(3000, function()
				active = true
			 end)
			end	
	end
end)

AddEventHandler('handappstate',function(state)
	active = state
end)

AddEventHandler("onKeyDown", function(key)
	local dict = "missfra1mcs_2_crew_react"
	if key == "x" and not isDead and active then
		if not handsup then
			TaskPlayAnim(PlayerPedId(), dict, "handsup_standing_base", 8.0, 8.0, -1, 50, 0, false, false, false)
			handsup = true
			Citizen.CreateThread(function()
				while true do 
					Wait(0)
					if IsEntityPlayingAnim(GetPlayerPed(-1), dict,"handsup_standing_base", 3) then
						DisableControlAction(0, 37, true)
						DisableControlAction(0, 25, true)
						DisablePlayerFiring(PlayerPedId(), true)
					end
					if handsup and IsPedInAnyVehicle(GetPlayerPed(-1), false) then
						handsup = false
						ClearPedTasks(PlayerPedId())
					end	
					
				end
			end)
		else
			handsup = false
			ClearPedTasks(PlayerPedId())
		end	
    end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)
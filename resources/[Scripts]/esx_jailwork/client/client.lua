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

local first = true
ESX = nil
local tphim = false

PlayerData = {}

local jailTime = 0

local ASTimer = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		
		Citizen.Wait(10)
	end
	
	if first then
		ESX.SetPlayerData('jailed' ,0)
		TriggerServerEvent("esx-qalle-jailajalireza:changeJailStatusalirezaServerSided", false)
		first = false
	end
	PlayerData = ESX.GetPlayerData()

	LoadTeleporters()
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(10000)

	ESX.TriggerServerCallback("esx-qalle-jailajalireza:retrievealirezaJailTime", function(inJail, newJailTime)
		if inJail then

			TriggerServerEvent("esx-qalle-jailajalireza:changeJailStatusalirezaServerSided", true)

			jailTime = newJailTime

			changeClothes()
			JailLogin()
		else
			TriggerServerEvent("esx-qalle-jailajalireza:changeJailStatusalirezaServerSided", false)
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jailajalireza:openJailMenu")
AddEventHandler("esx-qalle-jailajalireza:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jailajalireza:jailPlayers")
AddEventHandler("esx-qalle-jailajalireza:jailPlayers", function(newJailTime)

	TriggerEvent("esx_policejob:removeHandcuffFull")
	TriggerServerEvent("esx-qalle-jailajalireza:changeJailStatusalirezaServerSided", true)

	ESX.SetPlayerData('jailed', 1)

	jailTime = newJailTime

	Cutscene()
end)

RegisterNetEvent("esx-qalle-jailajalireza:unJailPlayer")
AddEventHandler("esx-qalle-jailajalireza:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

function removeweapons()
	
	local ped =  GetPlayerPed(-1)

	SetPedArmour(ped, 0)
	ClearPedBloodDamage(ped)
	ResetPedVisibleDamage(ped)
	ClearPedLastWeaponDamage(ped)
	RemoveAllPedWeapons(ped, true)

end

function JailLogin(jail)

	local ped = GetPlayerPed(-1)

	TriggerServerEvent("esx-qalle-jailajalireza:jobSet", source)

	ESX.ShowNotification("Akharin bar ke DC kardid too zendan boodid, bara hamin be zendan bazgashtid!")
	InJail(jail, true)
end

function UnJail()

	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Boiling Broke"])	
	ESX.SetPlayerData('jailed', 0)

	TriggerServerEvent("esx-qalle-jailajalireza:changeJailStatusalirezaServerSided", false)

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	ESX.ShowNotification("~h~Shoma Azad Shodid!")
end

function JailTimer()

	Citizen.CreateThread(function()

		Citizen.Wait(60000)
		while jailTime > 0 do
			
			jailTime = jailTime - 1

			TriggerServerEvent("esx-qalle-jailajalireza:updateJailTime", jailTime)

			if jailTime == 0 then
				UnJail()
				TriggerServerEvent("esx-qalle-jailajalireza:updateJailTime", 0)
			else
				ESX.ShowNotification("Shoma " .. jailTime .. " Daghighe digar azad mishavid!")
			end

			Citizen.Wait(60000)
		end

	end)
end


function InJail(jail, first)
		
	TriggerServerEvent("esx-qalle-jailajalireza:jobSet", source)
	Citizen.Wait(1500)
	changeClothes()
	local ped =  GetPlayerPed(-1)

	SetPedArmour(PlayerPedId(), 0)
	ClearPedBloodDamage(PlayerPedId())
	ResetPedVisibleDamage(PlayerPedId())
	ClearPedLastWeaponDamage(PlayerPedId())
	-- RemoveAllPedWeapons(PlayerPedId(), true)

	--Jail Timer--
	if first then
		JailTimer()
	end

	Citizen.CreateThread(function()
		while jailTime > 0 do
				if ESX.GetPlayerData()['IsDead'] == 1 then
					local health = GetEntityHealth(GetPlayerPed(-1))
					if health < 110 then
						TriggerEvent('esx_ambulancejob:revive', -1)
						tphim = true
					end
				end
			Citizen.Wait(500)
		end
	end)

	local JailPosition = nil
	local canRun = false

	JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)

    Citizen.CreateThread(function()

		while jailTime > 0 do
			
			DisableControlAction(0, Keys['F1'],true)
			DisableControlAction(0, Keys['F3'],true)
			DisableControlAction(0, Keys['F5'],true)
			DisableControlAction(0, Keys['TAB'], true)
			DisableControlAction(0, Keys['PAGEUP'], true)
			DisableControlAction(0, Keys['R'], true)
			DisableControlAction(0, Keys['M'], true)
			DisableControlAction(0, Keys[','], true)
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Right click
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 27, true) -- Arrow up

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), JailPosition.x, JailPosition.y, JailPosition.z) > 100.0 then
				ESX.Game.Teleport(PlayerPedId(), JailPosition)
				ESX.ShowNotification("~h~Shoma nemitavanid az zendan farar konid.")
			end

			if tphim then
				tphim = false
				Citizen.Wait(1000)
				ESX.Game.Teleport(PlayerPedId(), JailPosition)
			end


			Citizen.Wait(0)
		end

	end)

	Citizen.CreateThread(function()
		while jailTime > 0 do
			
			local sleepThread = 500

			local Packages = Config.PrisonWork["Packages"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local PackageText = "Pack"

					if not v["state"] then
						PackageText = "Already Taken"
					end

					ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 0.4)

					if DistanceCheck <= 1.5 then

						if IsControlJustPressed(0, 38) then

							if v["state"] then
								PackPackage(posId)
							else
								ESX.ShowNotification("Shoma ghablan in package ro borde boodid")
							end

						end

					end

				end

			end

			Citizen.Wait(sleepThread)

		end 
	end)

end

function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do
			
			local sleepThread = 500

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for p, v in pairs(Config.Teleports) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 7.5 then

					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "[E] baraye baz kardan e dar", 0.4)

					if DistanceCheck <= 1.0 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			ESX.ShowNotification("Canceled!")

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Packaging... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Leave Package", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					TriggerServerEvent("esx-qalle-jailajalireza:prisonWorkReward")
				end
			end
		end

	end

end

function OpenJailMenu()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Menu ye zendan",
			align    = 'center',
			elements = {
				{ label = "Jail Closest Person", value = "jail_closest_player" },
				{ label = "Unjail Person", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then
			if GetGameTimer() - ASTimer > 2500 then
				menu.close()

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
					{
						title = "Zaman e zendan(be daghighe)"
					},
				function(data2, menu2)

					local jailTime = tonumber(data2.value)

					if jailTime == nil then
						ESX.ShowNotification("Lotfan Time ro Be daqiqe Vared konid!")
					else
						if jailTime <= 60 then
						menu2.close()

						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification("Hich kas nazdik nist!")
						else
							ESX.UI.Menu.Open(
								'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
								{
								  title = "Dalil zendan"
								},
							function(data3, menu3)
			  
								local reason = data3.value
			  
								if reason == nil then
									ESX.ShowNotification("Bayad dalil bezarid")
								else
									menu3.close()
			  
									local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			  
									if closestPlayer == -1 or closestDistance > 3.0 then
										ESX.ShowNotification("Kasi nazdik nist!")
									else
										TriggerServerEvent("esx-qalle-jailajalireza:jailPlayers", GetPlayerServerId(closestPlayer), jailTime, reason)
										menu4.close()
									end
			  
								end
			  
							end, function(data3, menu3)
								menu3.close()
							end)
						  end
						else
							ESX.ShowNotification("Zaman zendan nemitavand bishtar az 60 daghighe bashad")
						end

					end

				end, function(data2, menu2)
					menu2.close()
				end)
			else
				ESX.ShowNotification('~h~Lotfan Spam Nakonid')
			end
			ASTimer = GetGameTimer()
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback("esx-qalle-jailajalireza:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					ESX.ShowNotification("Zendan e shoma khalist")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Zendani: " .. playerArray[i].name .. " | Zaman e zendan: " .. playerArray[i].jailTime .. " daghighe", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Azad kardan az zendan",
						align = "center",
						elements = elements
					},
				function(data2, menu2)

					-- local action = data2.current.value

					-- TriggerServerEvent("esx-qalle-jailajalireza:unJailPlayer", action, true)

					-- menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)

end
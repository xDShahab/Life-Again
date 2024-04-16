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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsHandcuffed            = false
local HandcuffTimer           = {}
local DragStatus              = {}
DragStatus.IsDragged          = false
local hasAlreadyJoined        = false
local isDead                  = false
local CurrentTask             = {}
local playerInService         = false
local ASTimer = 0 
ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 2,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function TeleportFadeEffect(entity, coords)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		ESX.Game.Teleport(entity, coords, function()
			DoScreenFadeIn(800)
		end)
	end)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' or job == 'swat_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' or job == 'swat_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {

		title    = _U('cloakroom'),

		 align    = 'top-left',

		elements = {

			{label = 'Lebas Shahri' , value = 'citizen_wear'},

			{label = 'Lebas Sheriff' , value = 'sheriff_wear'},

			{label = 'Wear Vest',  value = 'armor_wear'},

			
			{label = '👔: Division Wear',  value = 'alireza_division'},

			--{label = 'SWAT SHERIFF',  value = 'swat_wear'},

		}

	}, function(data, menu)

		if data.current.value == 'citizen_wear' then
			SetPedArmour(GetPlayerPed(-1), 0)
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

				TriggerEvent('skinchanger:loadSkin', skin)

			end)

		elseif data.current.value == 'alireza_division' then
			Opendivisionlebas()
		elseif data.current.value == 'sheriff_wear' then
			print('True')
			local job =  PlayerData.job.name
			local gradenum =  PlayerData.job.grade
			--[[
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					ESX.TriggerServerCallback('esx_society:getUniforms', function(SkinMale, SkinFemale)-- get uniform from esx_society
						if skin.sex == 0 then
							TriggerEvent('skinchanger:loadClothes', skin, SkinMale)
						else
							TriggerEvent('skinchanger:loadClothes', skin, SkinFemale)
						end
					end, gradenum, job)
			    end)
			--]]		
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else

					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
		elseif data.current.value == 'armor_wear' then
			SetPedArmour(GetPlayerPed(-1), 100)
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
				local clothesSkin = {
					['bproof_1'] = 22, ['bproof_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			  end
			end)
		elseif data.current.value == 'swat_wear' then
			if ESX.GetPlayerData().job.ext == 'swat' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 16,
						['tshirt_2'] = 1,
						['torso_1'] = 237,
						['torso_2'] = 2,
						['decals_1'] = 0,
						['decals_2'] = 0,
						['arms'] = 20,
						['arms_2'] = 0,
						['pants_1'] = 65,
						['pants_2'] = 1,
						['shoes_1'] = 39,
						['shoes_2'] = 0,
						['helmet_1'] = 122,
						['helmet_2'] = 0,
						['chain_1'] = 0,
						['chain_2'] = 0,
						['ears_1'] = -1,
						['ears_2'] = 0,
						['mask_1'] = 107,
						['mask_2'] = 10,
						['bproof_1'] = 59,
						['bproof_2'] = 1
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
				end)
			else
				ESX.ShowNotification("~h~Shoma SWAT nistid!")
			end
		elseif data.current.value == 'gang_wear' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
				local clothesSkin = {
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
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			  end
			end)
		end



		menu.close()

	end, function(data, menu)

		menu.close()

	end)

end


function Opendivisionlebas()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Divisioncloth', {

		title    = _U('Divisioncloth'),

		 align    = 'top-left',

		elements = {


			{label = 'SWAT SHERIFF',  value = 'swat_wear'},
			{label = 'G.T.F SHERIFF',  value = 'gtf_wear'},
			{label = 'D.E.A SHERIFF',  value = 'dea_wear'},

		}
		



	}, function(data, menu)

		if data.current.value == 'gtf_wear' then
			if ESX.GetPlayerData().job.ext == 'gtf' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
				local clothesSkin = {
					['tshirt_1'] = 16,
					['tshirt_2'] = 0,
					['torso_1'] = 197,
					['torso_2'] = 0,
					['decals_1'] = 0,
					['decals_2'] = 0,
					['arms'] = 32,
					['arms_2'] = 0,
					['pants_1'] = 80,
					['pants_2'] = 0,
					['shoes_1'] = 40,
					['shoes_2'] = 0,
					['helmet_1'] = 122,
					['helmet_2'] = 0,
					['chain_1'] = 0,
					['chain_2'] = 0,
					['ears_1'] = -1,
					['ears_2'] = 0,
					['mask_1'] = 107,
					['mask_2'] = 10
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
			end)
		end
		elseif data.current.value == 'dea_wear' then
			if ESX.GetPlayerData().job.ext == 'dea' then
			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
				local clothesSkin = {
					['tshirt_1'] = 97,
					['tshirt_2'] = 1,
					['torso_1'] = 160,
					['torso_2'] = 5,
					['decals_1'] = 0,
					['decals_2'] = 0,
					['arms'] = 23,
					['arms_2'] = 0,
					['pants_1'] = 121,
					['pants_2'] = 6,
					['shoes_1'] = 50,
					['shoes_2'] = 0,
					['helmet_1'] = 110,
					['helmet_2'] = 14,
					['chain_1'] = 0,
					['chain_2'] = 0,
					['ears_1'] = -1,
					['ears_2'] = 0,
					['mask_1'] = 224,
					['mask_2'] = 10
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end
			end)
		end
		elseif data.current.value == 'swat_wear' then
			if ESX.GetPlayerData().job.ext == 'swat' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 16,
						['tshirt_2'] = 0,
						['torso_1'] = 226,
						['torso_2'] = 7,
						['decals_1'] = 0,
						['decals_2'] = 0,
						['arms'] = 37,
						['arms_2'] = 0,
						['pants_1'] = 164,
						['pants_2'] = 2,
						['shoes_1'] = 40,
						['shoes_2'] = 0,
						['helmet_1'] = 123,
						['helmet_2'] = 1,
						['chain_1'] = 0,
						['chain_2'] = 0,
						['ears_1'] = -1,
						['ears_2'] = 0,
						['mask_1'] = 107,
						['mask_2'] = 10,
						['bproof_1'] = 59,
						['bproof_2'] = 1
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
				end)
			else
				ESX.ShowNotification("~h~Shoma SWAT nistid!")
			end
		end



		menu.close()

	end, function(data, menu)

		menu.close()

	end)


end





function OpenArmoryMenu(station)

	if Config.EnableArmoryManagement then

		local elements = {
			{label = _U('get_weapon'),     value = 'get_weapon'},
			{label = _U('put_weapon'),     value = 'put_weapon'},
			{label = _U('remove_object'),  value = 'get_stock'},
			{label = _U('deposit_object'), value = 'put_stock'}
		}

		--if PlayerData.job.grade_name == 'boss' then
		--	table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
		--end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
		{
			title    = _U('armory'),
			 align    = 'top-left',
			elements = elements
		}, function(data, menu)

			if data.current.value == 'get_weapon' then
				OpenGetWeaponMenu()
			elseif data.current.value == 'put_weapon' then
				OpenPutWeaponMenu()
			elseif data.current.value == 'buy_weapons' then
				OpenBuyWeaponsMenu(station)
			elseif data.current.value == 'put_stock' then
				OpenPutStocksMenu()
			elseif data.current.value == 'get_stock' then
				OpenGetStocksMenu()
			end

		end, function(data, menu)
			menu.close()

			CurrentAction     = 'menu_armory'
			CurrentActionMsg  = _U('open_armory')
			CurrentActionData = {station = station}
		end)

	else

		local elements = {}

		for i=1, #Config.sheriffStations[station].AuthorizedWeapons, 1 do
			local weapon = Config.sheriffStations[station].AuthorizedWeapons[i]
			table.insert(elements, {
				label = ESX.GetWeaponLabel(weapon.name), 
				value = weapon.name
			})
		end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
		{
			title    = _U('armory'),
			 align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local weapon = data.current.value
			TriggerServerEvent('esx_sheriff_job:giveWeapon', weapon, 1000)
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'menu_armory'
			CurrentActionMsg  = _U('open_armory')
			CurrentActionData = {station = station}
		end)

	end

end

function OpenVehicleSpawnerMenu(station, partNum)

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(garageVehicles)

			for i=1, #garageVehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(garageVehicles[i].model) .. ' [' .. garageVehicles[i].plate .. ']', 
					value = garageVehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title    = _U('vehicle_menu'),
				 align    = 'top-left',
				elements = elements
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value
				local foundSpawnPoint, spawnPoint = GetAvailableVehicleSpawnPoint(station, partNum)

				if foundSpawnPoint then
					ESX.Game.SpawnVehicle(vehicleProps.model, spawnPoint, spawnPoint.heading, function(vehicle)
						ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
						TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
					end)

					TriggerServerEvent('esx_society:removeVehicleFromGarage', 'sheriff', vehicleProps)
				end
			end, function(data, menu)
				menu.close()

				CurrentAction     = 'menu_vehicle_spawner'
				CurrentActionMsg  = _U('vehicle_spawner')
				CurrentActionData = {station = station, partNum = partNum}
			end)

		end, 'sheriff')

	else
		local grade = PlayerData.job.grade
		local job = PlayerData.job.name
		ESX.TriggerServerCallback('esx_society:getVehicles', function(cars) 
			local elements = {}

			for i=1, #cars, 1 do
				if cars[i].status == true then
					table.insert(elements, { label = GetDisplayNameFromVehicleModel(GetHashKey(cars[i].model)), model = cars[i].model})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title    = _U('vehicle_menu'),
				 align    = 'top-left',
				elements = elements
			}, function(data, menu)
				menu.close()

				local foundSpawnPoint, spawnPoint = GetAvailableVehicleSpawnPoint(station, partNum)

				if foundSpawnPoint then
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
							TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
							SetVehicleMaxMods(vehicle)
						end)
					else

						ESX.TriggerServerCallback('esx_service:isInService', function(isInService)

							if isInService then
								ESX.Game.SpawnVehicle(data.current.model, spawnPoint, spawnPoint.heading, function(vehicle)
									TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
									SetVehicleMaxMods(vehicle)
								end)
							else
								ESX.ShowNotification(_U('service_not'))
							end
						end, 'sheriff')
					end
				end

			end, function(data, menu)
				menu.close()

				CurrentAction     = 'menu_vehicle_spawner'
				CurrentActionMsg  = _U('vehicle_spawner')
				CurrentActionData = {station = station, partNum = partNum}
			end)
		end, grade, job)
	end
end

function GetAvailableVehicleSpawnPoint(station, partNum)
	local spawnPoints = Config.sheriffStations[station].Vehicles[partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i], spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function OpensheriffActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sheriff_actions', {
		title    = _U('sheriff_actions'),
		 align    = 'top-left',
		elements = {
			{label = _U('citizen_interaction'),	value = 'citizen_interaction'},
			{label = 'List Ekhtarha',	value = 'warn_interaction'},
			{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
			{label = 	"Zendan",               value = 'jail_menu'}
		}
	}, function(data, menu)

		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('id_card'),			value = 'identity_card'},
				{label = _U('search'),			value = 'body_search'},
				{label = _U('dastband'),		value = 'dastband'},
				{label = ('Uncuff'),		value = 'uncuff'},
				{label = _U('drag'),			value = 'drag'},
				{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
				{label = 'Jarime Kardan',			value = 'finev2'},
							

				{label = _U('unpaid_bills'),	value = 'unpaid_bills'}
			}
		
			if Config.EnableLicenses then
				table.insert(elements, {
					label = _U('license_check'), 
					value = 'license'
				})
			end
		
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('citizen_interaction'),
				 align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'body_search' then
						TriggerServerEvent('esx_sheriff_jobs:messagealireza', GetPlayerServerId(closestPlayer), _U('being_searched'))
						OpenBodySearchMenu(closestPlayer)
					elseif action == 'dastband' then
						if GetGameTimer() - ASTimer > 500 then
							playerPed = GetPlayerPed(-1)
							SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
							local target, distance = ESX.Game.GetClosestPlayer()
							playerheading = GetEntityHeading(GetPlayerPed(-1))
							playerlocation = GetEntityForwardVector(PlayerPedId())
							playerCoords = GetEntityCoords(GetPlayerPed(-1))
							local target_id = GetPlayerServerId(target)
							if distance <= 2.0 then
								TriggerServerEvent('kobsjob:art', target_id, playerheading, playerCoords, playerlocation)
							else
								ESX.ShowNotification('Shakhsi nazdik shoma nist')
							end
						else
							ESX.ShowNotification('~h~Lotfan Spam Nakonid!')
						end
						ASTimer = GetGameTimer()

					elseif action == 'uncuff' then
							if GetGameTimer() - ASTimer > 500 then
								playerPed = GetPlayerPed(-1)
								SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
								local target, distance = ESX.Game.GetClosestPlayer()
								playerheading = GetEntityHeading(GetPlayerPed(-1))
								playerlocation = GetEntityForwardVector(PlayerPedId())
								playerCoords = GetEntityCoords(GetPlayerPed(-1))
								local target_id = GetPlayerServerId(target)
								if distance <= 2.0 then
									TriggerServerEvent('esx_policejob:requestreleases', target_id, playerheading, playerCoords, playerlocation)
								else
									ESX.ShowNotification('Shakhsi nazdik shoma nist')
								end
							else
								ESX.ShowNotification('~h~Lotfan Spam Nakonid!')
							end
							ASTimer = GetGameTimer()
							--TriggerServerEvent('esx_sheriff_job:hanwwdovericwuffs', GetPlayerServerId(closestPlayer))
						elseif action == 'drag' then
							TriggerServerEvent('esx_policejob:aaadrag', GetPlayerServerId(closestPlayer))
							--TriggerServerEvent('esx_sheriff_job:drag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
						--TriggerServerEvent('esx_sheriff_job:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
						--TriggerServerEvent('esx_sheriff_job:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
						elseif action == 'finev2' then
						OpenFinev2Menu(closestPlayer)
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					end

				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
			elseif data.current.value == 'jail_menu' then
			TriggerEvent("esx-qalle-jailajalireza:openJailMenu")
			elseif data.current.value == 'warn_interaction' then
			local elements  = {}
				table.insert(elements, {label = 'Ekhtar 1',	value = 'warn1'})
				table.insert(elements, {label = 'Ekhtar 2',	value = 'warn2'})
				table.insert(elements, {label = 'Ekhtar 3',		value = 'warn3'})
				table.insert(elements, {label = 'Hokmetir',		value = 'warnhokm'})
				table.insert(elements, {label = 'Bezan Baghal',		value = 'warnbzn'})
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'warn_interaction',
			{
				title    = 'List Ekhtarha',
				 align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				action  = data2.current.value
					if action == 'warn1' then
					TriggerServerEvent('Aliat2:warns1','Edare Sheriff LifeAgain Shomaro Mohasere Karde , Taslim Shid Ekhtare 1')
				end
				if action == 'warn2' then
						TriggerServerEvent('Aliat2:warns1','Edare Sheriff LifeAgain Shomaro Mohasere Karde , Taslim Shid Ekhtare 2')
				end
				if action == 'warn3' then
						TriggerServerEvent('Aliat2:warns1','Edare Sheriff LifeAgain Shomaro Mohasere Karde , Taslim Shid Ekhtare Akhar , Darsurate Taslim Nashodan Mojazat Shoma 2 Barabar Mishavad')
				end
				if action == 'warnhokm' then
						TriggerServerEvent('Aliat2:warns1','Hokme Tir Be Dalile Adame Hamkari Sader Shod')
				end
				if action == 'warnbzn' then
						TriggerServerEvent('Aliat2:warns1','Mashineto Motevaghef Kon Va Azash Piade Sho')
				end

			end, function(data2, menu2)
				menu2.close()
			end
			)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local vehicle   = ESX.Game.GetVehicleInDirection()
			
			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'),	value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
				table.insert(elements, {label = _U('impound'),		value = 'impound'})
			end
			
			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_interaction', {
				title    = _U('vehicle_interaction'),
				 align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value
				
				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					if action == 'vehicle_infos' then
						OpenVehicleInfosMenu(vehicleData)
						
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehiceleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
					
						-- is the script busy?
						if CurrentTask.Busy then
							return
						end

						ESX.ShowHelpNotification(_U('impound_prompt'))
						
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						
						CurrentTask.Busy = true
						CurrentTask.Task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)
						
						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while CurrentTask.Busy do
								Citizen.Wait(1000)
							
								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and CurrentTask.Busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(CurrentTask.Task)
									ClearPedTasks(playerPed)
									CurrentTask.Busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end
			)


		end

	end, function(data, menu)
		menu.close()
	end)
end
function OpenFinev2Menu(player)

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'new_fine',
          		{
            		title = "Dalil Jarime Ra Vared Konid"
          		},
          	function(data2, menu2)

            	local dalilfine = tostring(data2.value)

            	if dalilfine == nil then
              		ESX.ShowNotification("Dalile Jarime Nabayad Khali Bashad.")
				else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification(" Kasi Baraye Jarime Nazdike Shoma Nist.")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'new_fine_setamount',
							{
							  title = "Mablaghe Jarime Be $"
							},
						function(data3, menu3)
		  
						  	local mablaghejarime = tonumber(data3.value)
		  
						  	if mablaghejarime == nil then
								ESX.ShowNotification("Mablaghe Jarime Nabayad Khali Bashad.")
						  	else
							if mablaghejarime < 149999 then
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification(" Kasi Baraye Jarime Nazdike Shoma Nist.")
								else
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_sheriff', 'Jarime: '..dalilfine, mablaghejarime)
									ESX.UI.Menu.CloseAll()
								end
		  else
		  ESX.ShowNotification("Hade Aksare Mablaghe Jarime 150,000$ Ast.")
		  end
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
					  end


				end

          	end, function(data2, menu2)
				menu2.close()
			end)
	
end
function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx_sheriff_job:getOtherPlayerData', function(data)

		local elements    = {}
		local nameLabel   = _U('name', data.name)
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end
	
			if data.dob ~= nil then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end
	
			if data.height ~= nil then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end
	
			if data.name ~= nil then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
	
		end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
		end
	
		if data.drunk ~= nil then
			table.insert(elements, {label = _U('bac', data.drunk), value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = _U('license_label'), value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
			title    = _U('citizen_interaction'),
			 align    = 'top-left',
			elements = elements
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

  function OpenBodySearchMenu(player)
  
	  ESX.TriggerServerCallback('esx_sheriff_job:getOtherPlayerData', function(data)
  
		  local elements = {}
  
		  table.insert(elements, {label = _U('guns_label'), value = nil})
  
		  for i=1, #data.weapons, 1 do
			  table.insert(elements, {
				  label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				  value    = data.weapons[i].name,
				  itemType = 'item_weapon',
				  amount   = data.weapons[i].ammo
			  })
		  end
  
		  table.insert(elements, {label = _U('inventory_label'), value = nil})
  
		  for i=1, #data.inventory, 1 do
			  if data.inventory[i].count > 0 then
				  table.insert(elements, {
				  label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
				  value    = data.inventory[i].name,
				  itemType = 'item_standard',
				  amount   = data.inventory[i].count
				  })
			  end
		  end
  
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
		  {
			  title    = _U('search'),
			  align    = 'top-right',
			  elements = elements,
		  },
		  function(data, menu)
  
			  local itemType = data.current.itemType
			  local itemName = data.current.value
			  local amount   = data.current.amount
  
			  if data.current.value ~= nil then
				if IsEntityPlayingAnim(GetPlayerPed(player), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer", 3)  then ---Salam
					ESX.ShowNotification("Shoma Nemitavanid Fard Ra Dar Halat Open Bodan Inventory Search Knid")
					menu.close()
				else
				  TriggerServerEvent('esx_sheriff_job:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
				  OpenBodySearchMenu(player)
				end
			  end
  
		  end, function(data, menu)
			  menu.close()
		  end)
  
	  end, GetPlayerServerId(player))
  
  end
  
function OpenFineMenu(player)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine', {
		title    = _U('fine'),
		 align    = 'top-left',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
		}
	}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)

end

function OpenFineCategoryMenu(player, category)

	if Config.EnablePoliceFine then 

		ESX.TriggerServerCallback('esx_sheriff_job:getFineList', function(fines)

			local elements = {}

			for i=1, #fines, 1 do
				table.insert(elements, {
					label     = fines[i].label .. ' <span style="color: green;">$' .. fines[i].amount .. '</span>',
					value     = fines[i].id,
					amount    = fines[i].amount,
					fineLabel = fines[i].label
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category', {
				title    = _U('fine'),
				 align    = 'top-left',
				elements = elements,
			}, function(data, menu)

				local label  = data.current.fineLabel
				local amount = data.current.amount

				menu.close()

				if Config.EnablePlayerManagement then
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_sheriff', _U('fine_total', label), amount)
				else
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), '', _U('fine_total', label), amount)
				end

				ESX.SetTimeout(300, function()
					OpenFineCategoryMenu(player, category)
				end)

			end, function(data, menu)
				menu.close()
			end)

		end, category)

	end

end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle', {
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_sheriff_job:getVehicleFromPlate', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('esx_sheriff_job:getOtherPlayerData', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license', {
			title    = _U('license_revoke'),
			 align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('esx_sheriff_jobs:messagealireza', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('esx_license:addddLicense', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end,
		function(data, menu)
			menu.close()
		end
		)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)

	local elements = {}

	ESX.TriggerServerCallback('esx_billing:getTargetBills', function(bills)
		for i=1, #bills, 1 do
			table.insert(elements, {label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>', value = bills[i].id})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			 align    = 'top-left',
			elements = elements
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('esx_sheriff_job:getVehicleInfos', function(retrivedInfo)

		local elements = {}

		table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown'), value = nil})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos', {
			title    = _U('vehicle_info'),
			 align    = 'top-left',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)

	end, vehicleData.plate)

end

function OpenGetWeaponMenu()
	local grade = PlayerData.job.grade
	local job = PlayerData.job.name
	ESX.TriggerServerCallback('esx_sheriff_job:getArmoryWeapons', function(weapons)
		ESX.TriggerServerCallback('esx_society:getWeapons', function(societyweapons)
			local elements = {}
			for i=1, #weapons, 1 do
				if weapons[i].count > 0 then
					for _,sharedWeapons in ipairs(societyweapons) do
						if sharedWeapons.model == weapons[i].name and sharedWeapons.status == true then
							table.insert(elements, {label = 'x ' .. weapons[i].count .. ' ' .. weapons[i].name, value = weapons[i].name})
						end
					end
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon', {
				title    = _U('get_weapon_menu'),
				 align    = 'top-left',
				elements = elements
			}, function(data, menu)

				menu.close()

				ESX.TriggerServerCallback('esx_sheriff_job:removeArmoryWeapon', function()
					OpenGetWeaponMenu()
				end, data.current.value)

			end, function(data, menu)
				menu.close()
			end)
		end, grade, job)
	end)
end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label, 
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon', {
		title    = _U('put_weapon_menu'),
		 align    = 'top-left',
		elements = elements
	}, function(data, menu)
		
		ESX.TriggerServerCallback('esx_sheriff_job:addArmoryWeapon', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)

		ESX.UI.Menu.CloseAll()

		TriggerEvent("mythic_progbar:client:progress", {
			name = "alireza_at",
			duration = 10500,
			label = "Dar Hal gharar Dadan Gun..",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
		})
		

	end, function(data, menu)
		menu.close()
	end)
end

function OpenBuyWeaponsMenu(station)

	ESX.TriggerServerCallback('esx_sheriff_job:getArmoryWeapons', function(weapons)

		local elements = {}

		for i=1, #Config.sheriffStations[station].AuthorizedWeapons, 1 do
			local weapon = Config.sheriffStations[station].AuthorizedWeapons[i]
			local count  = 0

			for i=1, #weapons, 1 do
				if weapons[i].name == weapon.name then
					count = weapons[i].count
					break
				end
			end

			table.insert(elements, {
				label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. ESX.Math.GroupDigits(weapon.price),
				value = weapon.name,
				price = weapon.price
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons',
		{
			title    = _U('buy_weapon_menu'),
			 align    = 'top-left',
			elements = elements
		}, function(data, menu)

			ESX.TriggerServerCallback('esx_sheriff_job:buy', function(hasEnoughMoney)
				if hasEnoughMoney then
					ESX.TriggerServerCallback('esx_sheriff_job:addArmoryWeapon', function()
						OpenBuyWeaponsMenu(station)
					end, data.current.value, false)
				else
					ESX.ShowNotification(_U('not_enough_money'))
				end
			end, data.current.price)

		end, function(data, menu)
			menu.close()
		end)

	end)

end

function OpenGetStocksMenu()
	local grade = PlayerData.job.grade
	local job = PlayerData.job.name
	ESX.TriggerServerCallback('esx_sheriff_job:getStockItems', function(items)
		ESX.TriggerServerCallback('esx_society:getItems', function(authorizedItems)

			local elements = {}

			for i=1, #items, 1 do
				for _, specialitem in ipairs(authorizedItems) do
					if specialitem.name == items[i].name and specialitem.status == true then
						table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
					end
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
				title    = _U('sheriff_stock'),
				 align    = 'top-left',
				elements = elements
			}, function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
					title = _U('quantity')
				}, function(data2, menu2)

					local count = tonumber(data2.value)

					if count == nil then
						ESX.ShowNotification(_U('quantity_invalid'))
					else
						menu2.close()
						menu.close()
						TriggerServerEvent('esx_sheriff_job:getStockItem', itemName, count)

						Citizen.Wait(300)
						OpenGetStocksMenu()
					end

				end, function(data2, menu2)
					menu2.close()
				end)

			end, function(data, menu)
				menu.close()
			end)
		end, grade, job)
	end)
end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('esx_sheriff_job:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count, type = 'item_standard', 
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('inventory'),
			 align    = 'top-left',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_sheriff_job:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

function OpenElevator(station, partNum)

	local elements = {
		{ label = _U('elevator_top'), value = 'elevator_top' },
		{ label = _U('elevator_down'), value = 'elevator_down' },
		{ label = _U('elevator_parking'), value = 'elevator_parking' }
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'elevator', {
		title    = _U('elevator'),
		 align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'elevator_top' then
			TeleportFadeEffect(PlayerPedId(), Config.sheriffStations[station].Elevator[partNum].Top)
		end

		if data.current.value == 'elevator_down' then
			TeleportFadeEffect(PlayerPedId(), Config.sheriffStations[station].Elevator[partNum].Down)
		end

		if data.current.value == 'elevator_parking' then
			TeleportFadeEffect(PlayerPedId(), Config.sheriffStations[station].Elevator[partNum].Parking)
		end
		menu.close()

	end, function(data, menu)
		menu.close()
		
		CurrentAction     = 'menu_elevator'
		CurrentActionMsg  = _U('open_elevator')
		CurrentActionData = {}
	end)
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
	TriggerServerEvent('esx_sheriff_job:forceBlip')
end)


AddEventHandler('esx_sheriff_job:hasEnteredMarker', function(station, part, partNum)

	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}

	elseif part == 'Armory' then

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}

	elseif part == 'VehicleSpawner' then

		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {station = station, partNum = partNum}
elseif part == 'HelicopterSpawner' then
		CurrentAction	= 'menu_heli'
		CurrentActionMsg	= 'Press ~INPUT_CONTEXT~ to spawn helicopter'
		CurrentActionData	= {station = station, partNum = partNum}

	elseif part == 'VehicleDeleter' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_vehicle')
				CurrentActionData = {vehicle = vehicle}
			end

		end

	elseif part == 'BossActions' then

		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}

	elseif part == 'Elevator' then

		CurrentAction     = 'menu_elevator'
		CurrentActionMsg  = _U('open_elevator')
		CurrentActionData = {station = station, partNum = partNum}

	end

end)

AddEventHandler('esx_sheriff_job:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('esx_sheriff_job:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('esx_sheriff_job:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_sheriff_job:hanwwdovericwuffs')
AddEventHandler('esx_sheriff_job:hanwwdovericwuffs', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			FreezeEntityPosition(playerPed, true)
			DisplayRadar(false)

			if Config.EnableHandcuffTimer then

				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end

				StartHandcuffTimer()
			end

		else

			if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				ESX.ClearTimeout(HandcuffTimer.Task)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		end
	end)

end)

RegisterNetEvent('esx_sheriff_job:unrestrainss')
AddEventHandler('esx_sheriff_job:unrestrainss', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

RegisterNetEvent('esx_sheriff_job:drag')
AddEventHandler('esx_sheriff_job:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_sheriff_job:putInVehicle')
AddEventHandler('esx_sheriff_job:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_sheriff_job:OutVehicle')
AddEventHandler('esx_sheriff_job:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, Keys['W'], true) -- W
			DisableControlAction(0, Keys['A'], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				end)
			end
		else
			Citizen.Wait(800)
		end
	end
end)



-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			for k,v in pairs(Config.sheriffStations) do

				for i=1, #v.Cloakrooms, 1 do
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < 5 then
						DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end

				for i=1, #v.Armories, 1 do
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < 5 then
						DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end

				for i=1, #v.Vehicles, 1 do
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < 5 then
						DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end

				for i=1, #v.VehicleDeleters, 1 do
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < 5 then
						DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerDeletersColor.r, Config.MarkerDeletersColor.g, Config.MarkerDeletersColor.b, 100, false, true, 2, false, false, false, false)
					end
				end
				for i=1, #v.Helicopters, 1 do
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z, true) < 5 then
						if #(coords - vector3(v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y, v.Helicopters[i].Spawner.z)) < (Config.MarkerSize.x / 2) then
							DrawMarker(Config.MarkerType, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y,v.Helicopters[i].Spawner.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, 0, 255, 0, 100, false, true, 2, false, false, false, false)
						else
							DrawMarker(Config.MarkerType, v.Helicopters[i].Spawner.x, v.Helicopters[i].Spawner.y,v.Helicopters[i].Spawner.z - 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, 0, 0, 255, 100, false, true, 2, false, false, false, false)
						end
					end
				end

				if Config.EnablePlayerManagement and PlayerData.job.grade > 6 then
					for i=1, #v.BossActions, 1 do
						if not v.BossActions[i].disabled and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < 5 then
							DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
						end
					end
				end

				for i=1, #v.Elevator, 1 do
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Elevator[i].Top.x, v.Elevator[i].Top.y, v.Elevator[i].Top.z, true) < 5 then
						DrawMarker(Config.MarkerType, v.Elevator[i].Top.x, v.Elevator[i].Top.y, v.Elevator[i].Top.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end

					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Elevator[i].Down.x, v.Elevator[i].Down.y, v.Elevator[i].Down.z, true) < 5 then
						DrawMarker(Config.MarkerType, v.Elevator[i].Down.x, v.Elevator[i].Down.y, v.Elevator[i].Down.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end

					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Elevator[i].Parking.x, v.Elevator[i].Parking.y, v.Elevator[i].Parking.z, true) < 5 then
						DrawMarker(Config.MarkerType, v.Elevator[i].Parking.x, v.Elevator[i].Parking.y, v.Elevator[i].Parking.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end

			end

		else
			Citizen.Wait(500)
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

	while true do

		Citizen.Wait(10)

		if PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then

			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local isInMarker     = false
			local currentStation = nil
			local currentPart    = nil
			local currentPartNum = nil

			for k,v in pairs(Config.sheriffStations) do

				for i=1, #v.Cloakrooms, 1 do
					if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Cloakroom'
						currentPartNum = i
					end
				end

				for i=1, #v.Armories, 1 do
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armory'
						currentPartNum = i
					end
				end

				for i=1, #v.Vehicles, 1 do
					if GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleSpawner'
						currentPartNum = i
					end
				end

				for i=1, #v.VehicleDeleters, 1 do
					if GetDistanceBetweenCoords(coords, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'VehicleDeleter'
						currentPartNum = i
					end
				end
				
				for i=1, #v.Helicopters, 1 do
				
					if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < (Config.MarkerSize.x / 2) then
						isInMarker     = true
						currentStation = k
						currentPart    = 'HelicopterSpawner'
						currentPartNum = i
					end

					
				end		

				if Config.EnablePlayerManagement and PlayerData.job.grade > 6 then
					for i=1, #v.BossActions, 1 do
						if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < Config.MarkerSize.x then
							isInMarker     = true
							currentStation = k
							currentPart    = 'BossActions'
							currentPartNum = i
						end
					end
				end

				for i=1, #v.Elevator, 1 do
					if GetDistanceBetweenCoords(coords, v.Elevator[i].Top.x, v.Elevator[i].Top.y, v.Elevator[i].Top.z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Elevator'
						currentPartNum = i
					end

					if GetDistanceBetweenCoords(coords, v.Elevator[i].Down.x, v.Elevator[i].Down.y, v.Elevator[i].Down.z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Elevator'
						currentPartNum = i
					end

					if GetDistanceBetweenCoords(coords, v.Elevator[i].Parking.x, v.Elevator[i].Parking.y, v.Elevator[i].Parking.z, true) < Config.MarkerSize.x then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Elevator'
						currentPartNum = i
					end
				end

			end

			local hasExited = false

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

				if
					(LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('esx_sheriff_job:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('esx_sheriff_job:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_sheriff_job:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

		else
			Citizen.Wait(500)
		end

	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_mp_arrow_barrier_01',
		'prop_mp_barrier_02b',
		'p_ld_stinger_s',
		'prop_boxpile_07d'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_sheriff_job:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity ~= nil then
				TriggerEvent('esx_sheriff_job:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' then

				if CurrentAction == 'menu_cloakroom' then
					OpenCloakroomMenu()

				elseif CurrentAction == 'menu_armory' then
					if Config.MaxInService == -1 then
						OpenArmoryMenu(CurrentActionData.station)
					elseif playerInService then
						OpenArmoryMenu(CurrentActionData.station)
					else
						ESX.ShowNotification(_U('service_not'))
					end

				elseif CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)

				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'sheriff', vehicleProps)
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'sheriff', function(data, menu)
						menu.close()
						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = false }) 
					print('menu opened')

				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)

				elseif CurrentAction == 'menu_elevator' then
					OpenElevator(CurrentActionData.station, CurrentActionData.partNum)
					  elseif CurrentAction == 'menu_heli' then
					local helicopters = Config.sheriffStations[CurrentActionData.station].Helicopters

					if not IsAnyVehicleNearPoint(helicopters[CurrentActionData.partNum].SpawnPoint.x, helicopters[CurrentActionData.partNum].SpawnPoint.y, helicopters[CurrentActionData.partNum].SpawnPoint.z,  3.0) then
				
						local iVehName = "polmav"
				
						ESX.Game.SpawnVehicle(iVehName, {
							x = helicopters[CurrentActionData.partNum].SpawnPoint.x,
							y = helicopters[CurrentActionData.partNum].SpawnPoint.y,
							z = helicopters[CurrentActionData.partNum].SpawnPoint.z
						}, helicopters[CurrentActionData.partNum].Heading, function(vehicle)
							SetVehicleModKit(vehicle, 0)
							SetVehicleLivery(vehicle, 0)
						end)
					else
						ESX.ShowNotification("Spawn point is not clear!")				
					end	
				end
				
				CurrentAction = nil
			end
		end -- CurrentAction end
		
		if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'sheriff' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'sheriff_actions') then
			if Config.MaxInService == -1 then
				OpensheriffActionsMenu()
			elseif playerInService then
				OpensheriffActionsMenu()
			else
				ESX.ShowNotification(_U('service_not'))
			end
		end
		
		if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(CurrentTask.Task)
			ClearPedTasks(PlayerPedId())
			
			CurrentTask.Busy = false
		end
	end
end)


AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_sheriff_job:unrestrainss')
	
	if not hasAlreadyJoined then
		TriggerServerEvent('esx_sheriff_job:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_sheriff_job:unrestrainss')
		TriggerEvent('esx_phone:removeSpecialContact', 'sheriff')

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('esx_service:disableService', 'sheriff')
		end

		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	HandcuffTimer.Active = true

	HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('esx_sheriff_job:unrestrainss')
		HandcuffTimer.Active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle) 
	ESX.ShowNotification(_U('impound_successful'))
	CurrentTask.Busy = false
end

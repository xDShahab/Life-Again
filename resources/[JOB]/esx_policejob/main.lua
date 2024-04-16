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
local Busy = false
local BackupX = nil
local BackupY = nil
local showit = false
local ASTimer = 0 -- BesT

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
		modEngine       = 5,
		modBrakes		= 5,
		windowTint		= 2,
		modArmor		= 5,
		modTransmission = 2,
		modSuspension   = 4,
		modTurbo        = true,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
	SetVehicleDirtLevel(vehicle, 0.0)
end

function SetVehicleMaxMods2(vehicle)
	local props = {
		modEngine       = 5,
		modBrakes		= 5,
		windowTint		= 1,
		modArmor		= 5,
		modTransmission = 2,
		modSuspension   = 4,
		modTurbo        = true,
	}
	

	ESX.Game.SetVehicleProperties(vehicle, props)
	SetVehicleDirtLevel(vehicle, 0.0)
end

function SetVehicleMaxMods3(vehicle)
	local props = {
		modEngine       = 5,
		modBrakes		= 5,
		windowTint		= 1,
		modArmor		= 5,
		modTransmission = 2,
		color1 			= 0,
		color2		 	= 0,
		pearlescentColor = 0,
		modSuspension   = 4,
		modTurbo        = true,
	}
	

	ESX.Game.SetVehicleProperties(vehicle, props)
	SetVehicleDirtLevel(vehicle, 0.0)
end

function SetVehicleMaxMods4(vehicle)
	local props = {
		modEngine       =   3,
		modBrakes       =   2,
		windowTint      =  -1,
		modArmor        =   4,
		modTransmission =   2,
		modSuspension   =   -1,
		modTurbo        =   true,
	}
	

	ESX.Game.SetVehicleProperties(vehicle, props)
	SetVehicleDirtLevel(vehicle, 0.0)
end

function SetVehicleMaxMods5(vehicle)
    local props = {
        modEngine       = 3,
        modBrakes		= 4,
        windowTint		=-1,
        modArmor		= 4,
        modTransmission = 2,
        modSuspension   = 3,
        modTurbo        = true,
    }

    ESX.Game.SetVehicleProperties(vehicle, props)
    SetVehicleDirtLevel(vehicle, 0.0)
end

function SetVehicleMaxMods6(vehicle)
    local props = {
        modEngine       = 3,
        modBrakes		= 4,
        windowTint		=-1,
        modArmor		= 4,
		modTransmission = 2,
		color1 			= 111,
		color2 			= 111,
		pearlescentColo = 111,
        modSuspension   = 3,
        modTurbo        = true,
    }

    ESX.Game.SetVehicleProperties(vehicle, props)
    SetVehicleDirtLevel(vehicle, 0.0)
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
	if tonumber(skin.sex) == 0 then

			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			-- SetPedArmour(playerPed, 98)

	elseif tonumber(skin.sex) == 1 then

			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			-- SetPedArmour(playerPed, 98)

		end

	end)
end

function setwest(uniform, playerPed)
    if uniform == '1' then
        un = {bproof_1 = 15,bproof_2 = 0}
    elseif uniform == '2' then
        un = {bproof_1 = 18,bproof_2 = 0}
    elseif uniform == '3' then
        un = {bproof_1 = 19,bproof_2 = 0}
    end
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then    
            TriggerEvent('skinchanger:loadClothes', skin, un)
            SetPedArmour(playerPed, 100)
        else
            TriggerEvent('skinchanger:loadClothes', skin, un)
            SetPedArmour(playerPed, 100)
        end
    end)
end





function OpenCloakroomMenu()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
		{label =    'West Menu', value = 'wmenu'},
		{ label = _U('bullet_wear'),  value = 'bullet_wear'  },
		{ label = _U('sbullet_wear'), value = 'sbullet_wear' },
		{label =    'Lebas Police', value = 'police_lebas'},
		{label =    'Lebas SWAT', value = 'swat_lebas'},
		{label = 	"Lebas Xray",  value = 'xray_menu'}
	}



	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		 align    = 'center',
		elements = elements
	}, function(data, menu)

		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end


		if data.current.value == 'police_lebas' then
			local job =  PlayerData.job.name
			local gradenum =  PlayerData.job.grade

            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
                else

                    TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
                end
            end)
		end



		

		if data.current.value == 'xray_menu' then
			if ESX.GetPlayerData().job.ext == 'xray' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 134,  ['tshirt_2'] = 0,
						['torso_1'] = 141,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 184,
						['pants_1'] = 75,   ['pants_2'] = 0,
						['shoes_1'] = 39,   ['shoes_2'] = 0,
						['helmet_1'] = 19,  ['helmet_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['chain_1'] = 11,    ['chain_2'] = 0,
						['ears_1'] = 2,     ['ears_2'] = 0,
						['mask_1'] = 90,   ['mask_2'] = 0,
						['bproof_1'] = 0,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
				end)
			else
				ESX.ShowNotification("~h~Shoma Xray nistid!")
			end
		end

		if data.current.value == 'swat_lebas' then
			if ESX.GetPlayerData().job.ext == 'swat' then
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
					local clothesSkin = {
						['tshirt_1'] = 17,  ['tshirt_2'] = 0,
						['torso_1'] = 185,   ['torso_2'] = 0,
						['decals_1'] = 0,   ['decals_2'] = 0,
						['arms'] = 21,
						['pants_1'] = 65,   ['pants_2'] = 2,
						['shoes_1'] = 40,   ['shoes_2'] = 0,
						['helmet_1'] = 121,  ['helmet_2'] = 0,
						['glasses_1'] = 0,  ['glasses_2'] = 0,
						['chain_1'] = 1,    ['chain_2'] = 0,
						['ears_1'] = 2,     ['ears_2'] = 0,
						['mask_1'] = 90,   ['mask_2'] = 0,
						['bproof_1'] = 15,  ['bproof_2'] = 0
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
				end)
			else
				ESX.ShowNotification("~h~Shoma SWAT nistid!")
			end
		end

		if data.current.value == 'wmenu' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'West-Menu', {
                title    = 'West Menu',
                align    = 'center',
                elements = {
                    {label = '1',   value = '1'},
                    {label = '2',   value = '2'},
                    {label = '3',   value = '3'},
            }}, function(data, menu)
                if data.current.value == '1' then
                    setwest('1', playerPed)
                elseif data.current.value == '2' then
                    setwest('2', playerPed)
                elseif data.current.value == '3' then
                    setwest('3', playerPed)
                end
            end, function(data, menu)
                menu.close()
            end)
        end
		
		if data.current.value == 'swat_wear' then
			if ESX.GetPlayerData().job.ext == 'swat' then
				setUniform(data.current.value, playerPed)
			else
				ESX.ShowNotification("~h~Shoma SWAT nistid!")
			end
		end
		
		if data.current.value == 'sbullet_wear' or data.current.value == 'sboss_wear' or data.current.value == 'scommander_wear' or data.current.value == 'sslo_wear' or data.current.value == 'ssergeant_wear' or data.current.value == 'spo3_wear' or data.current.value == 'spo2_wear' or data.current.value == 'spo1_wear' or data.current.value == 'scadet_wear' then
			if ESX.GetPlayerData().job.ext == 'sheriff' then
				setUniform(data.current.value, playerPed)
			else
				ESX.ShowNotification("~h~Shoma Sheriff nistid!")
			end
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenArmoryMenu(station)

	local elements = {
		{label = _U('get_weapon'),     value = 'get_weapon'},
		{label = _U('put_weapon'),     value = 'put_weapon'},
		{label = _U('remove_object'),  value = 'get_stock'},
		{label = _U('deposit_object'), value = 'put_stock'}
	}

	--if PlayerData.job.grade >= 7 then
	--	table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
	--end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'armory',
	{
		title    = _U('armory'),
		 align    = 'center',
		elements = elements,
	},
	function(data, menu)

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		end

		if data.current.value == 'put_weapon' then
			OpenPutWeaponMenu()
		end

		if data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu(station)
		end

		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		end

		if data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end

	end,
	function(data, menu)

		menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end
	)
end

function OpenVehicleSpawnerMenu(station, partNum)
	local vehicles = Config.PoliceStations[station].Vehicles
	ESX.UI.Menu.CloseAll()

	local elements = {}
	local grade = PlayerData.job.grade
	local job = PlayerData.job.name
	ESX.TriggerServerCallback('esx_society:getVehicles', function(cars) 
		if ESX.GetPlayerData().job.ext == 'detective' then
			table.insert(elements, { label = "Detective Schafter", model =  "polschafter3"})
			--table.insert(elements, { label = "Detective Charger", model = "2018charger", livery = 1, extras = {2, 3, 4, 8}, nonextras = {1,5,6,7} })
		end


		if ESX.GetPlayerData().job.ext == 'swat' then
			table.insert(elements, { label = "S.W.A.T Brickade", model =  "brickade"})
				table.insert(elements, { label = "S.W.A.T Insurgent", model = "insurgent2"})
				table.insert(elements, { label = "S.W.A.T Riot2", model =  "riot2"})
				table.insert(elements, { label = "S.W.A.T Riot", model =  "riot"})
				table.insert(elements, { label = "S.W.A.T Crusier", model =  "fbi"})
				table.insert(elements, { label = "S.W.A.T Granger", model =  "fbi2"})
				table.insert(elements, { label = "S.W.A.T Schafter", model =  "schafter5"})
				--table.insert(elements, { label = "S.W.A.T MRap", model = "mrap", livery = 0, extras = {2, 3, 4, 8, 9}, nonextras = {1,5,6,7} })
			end

		for i=1, #cars, 1 do
			if cars[i].status == true then
				table.insert(elements, { label = GetDisplayNameFromVehicleModel(GetHashKey(cars[i].model)), model = cars[i].model})
			end
		end


		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title    = _U('vehicle_menu'),
			 align    = 'center',
			elements = elements
		}, function(data, menu)
			menu.close()

			local model   = data.current.model
			local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x, vehicles[partNum].SpawnPoint.y, vehicles[partNum].SpawnPoint.z, 3.0, 0, 71)

			if not DoesEntityExist(vehicle) then

				local playerPed = PlayerPedId()

				ESX.Game.SpawnVehicle(model, vehicles[partNum].SpawnPoint, vehicles[partNum].Heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					if model == "fbi2" or model == "fbi" then
					SetVehicleMaxMods2(vehicle)
					elseif model == "insurgent2" or model == "brickade" then
						SetVehicleMaxMods3(vehicle)
					elseif model == "policeb" then
						SetVehicleMaxMods4(vehicle)
					elseif mode == "polp1" then
						SetVehicleMaxMods5(vehicle)
					elseif mode == "t20" then
						SetVehicleMaxMods6(vehicle)
					else
						SetVehicleMaxMods(vehicle)
					end
					Citizen.Wait(2000)
					SetVehicleFuelLevel(vehicle, 100.0)
				end)
			else
				ESX.ShowNotification(_U('vehicle_out'))
			end

		end, function(data, menu)
			menu.close()

			CurrentAction     = 'menu_vehicle_spawner'
			CurrentActionMsg  = _U('vehicle_spawner')
			CurrentActionData = {station = station, partNum = partNum}

		end)
	end, grade, job)
end

function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'police_actions',
	{
		title    = 'Police',
		 align    = 'center',
		elements = {
			{label = _U('citizen_interaction'),	value = 'citizen_interaction'},
			{label = 'List Ekhtarha',	value = 'warn_interaction'},			
			{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
			{label = 	"Zendan",               value = 'jail_menu'},
			{label = 	"Self",               value = 'Self_menu'}

		}
	}, function(data, menu)

		if data.current.value == 'citizen_interaction' then
			local elements = {
				{label = _U('id_card'),			value = 'identity_card'},
				{label = _U('search'),			value = 'body_search'},
				{label = _U('handcuff'),		value = 'handcuff'},
				{label = _U('uncuff'),			value = 'uncuff'},
				{label = _U('drag'),			value = 'drag'},
				{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
				{label = 'Jarime Kardan',			value = 'finev2'},				
				{label = _U('unpaid_bills'),	value = 'unpaid_bills'},
				{label = _U('license_check'), 	value = 'license' }
			}

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('citizen_interaction'),
				 align    = 'center',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value
					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'body_search' then
						local text = '* Shoro be gashtane fard mikone *'
						TriggerServerEvent('3dme:shareDisplay', text, true)
						OpenBodySearchMenu(closestPlayer)
					elseif action == 'handcuff' then
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
					elseif action == 'drag' then
						TriggerServerEvent('esx_policejob:aaadrag', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)
					elseif action == 'finev2' then
						OpenFinev2Menu(closestPlayer)						
					elseif action == 'jail' then
						JailPlayer(GetPlayerServerId(closestPlayer))
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
				 align    = 'center',
				elements = elements
			}, function(data2, menu2)
				action  = data2.current.value
					if action == 'warn1' then
					TriggerServerEvent('Aliat:warns1','Edare Police LifeAgain Shomaro Mohasere Karde , Taslim Shid Ekhtare 1')
				end
				if action == 'warn2' then
						TriggerServerEvent('Aliat:warns1','Edare Police LifeAgain Shomaro Mohasere Karde , Taslim Shid Ekhtare 2')
				end
				if action == 'warn3' then
						TriggerServerEvent('Aliat:warns1','Edare Police LifeAgain Shomaro Mohasere Karde , Taslim Shid Ekhtare Akhar , Darsurate Taslim Nashodan Mojazat Shoma 2 Barabar Mishavad')
				end
				if action == 'warnhokm' then
						TriggerServerEvent('Aliat:warns1','Hokme Tir Be Dalile Adame Hamkari Sader Shod')
				end
				if action == 'warnbzn' then
						TriggerServerEvent('Aliat:warns1','Mashineto Motevaghef Kon Va Azash Piade Sho')
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

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_interaction',
			{
				title    = _U('vehicle_interaction'),
				 align    = 'center',
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

					if CurrentTask.Busy then
						return
					end
					
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							CurrentTask.Busy = true
							TriggerEvent('esx_customItems:checkVehicleDistance', vehicle)
							TriggerEvent("mythic_progbar:client:progress", {
							name = "hijack_vehicle2",
							duration = 30000,
							label = "LockPick kardan mashin",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
						}, function(status)
							if not status then
				
								ClearPedTasksImmediately(playerPed)
								SetVehicleDoorsLocked(vehicle, 1)
								SetVehiceleDoorsLockedForAllPlayers(vehicle, false)
								ESX.ShowNotification(_U('vehicle_unlocked'))
								CurrentTask.Busy = false
								TriggerEvent('esx_customItems:checkVehicleStatus', false)
			
							elseif status then
								ClearPedTasksImmediately(playerPed)
								CurrentTask.Busy = false
								TriggerEvent('esx_customItems:checkVehicleStatus', false)
							end
						end)
							
						end
					elseif action == 'impound' then
					
						-- is the script busy?
						if CurrentTask.Busy then
							return
						end
						
						CurrentTask.Busy = true
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

						TriggerEvent('esx_customItems:checkVehicleDistance', vehicle)
						TriggerEvent("mythic_progbar:client:progress", {
						name = "impound_vehicle",
						duration = 10000,
						label = "Toghif kardan mashin",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
					}, function(status)
						if not status then
			
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							CurrentTask.Busy = false
							TriggerEvent('esx_customItems:checkVehicleStatus', false)
		
						elseif status then
							ClearPedTasks(playerPed)
							CurrentTask.Busy = false
							TriggerEvent('esx_customItems:checkVehicleStatus', false)
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
		elseif data.current.value == 'Self_menu' then
			local issheild = false
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = "Self",
				align    = 'left',
				elements = {
				  {label = "Radar",	            	value = 'rd_mobile'},
				}
			}, function(data2, menu2)
				local shieldActive = false
				local shieldEntity = nil	
				local action = data2.current.value
				if action == 'shield1' then
					TriggerEvent('shield:ToggleSwatShield') 
				elseif action == 'rd_mobile' then
					TriggerEvent('police:POLICE_radar')
				end
			end, function(data2, menu2)
				menu2.close()
			end)

		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx:getOtherPlayerDataCard', function(data)

		local elements    = {}
		local nameLabel   = _U('name', data.name)
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.name)
	
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
		
		local text = '* ID Card fard ro search mikone *'
			TriggerServerEvent('3dme:shareDisplay', text, false)
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = _U('citizen_interaction'),
			 align    = 'center',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

function OpenBodySearchMenu(player)

	ESX.TriggerServerCallback('esx:getOtherPlayerDataCard', function(data)

		local elements = {}
		table.insert(elements, {label = '--- Money ---', value = nil})

		table.insert(elements, {label =  ESX.Math.GroupDigits(data.money), value = nil})
	
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
			 align    = 'center',
			elements = elements,
		},
		function(data, menu)

			local itemType = data.current.itemType
			local itemName = data.current.value
			local amount   = data.current.amount

			if data.current.value ~= nil then
				TriggerServerEvent('esx:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
				OpenBodySearchMenu(player)
			end

		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))

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
									TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_police', 'Jarime: '..dalilfine, mablaghejarime)
									menu4.close()
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

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('esx_policejob:getVehicleFromPlate', function(owner, found)
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
	ESX.TriggerServerCallback('esx:getOtherPlayerDataCard', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.name
		end
		
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			 align    = 'center',
			elements = elements,
		},
		function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('esx_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('esx_license:addddLicense', GetPlayerServerId(player), data.current.value)
			
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)

			Citizen.Wait(1000)
			TriggerServerEvent('esx_dmvschool:updateLicense', GetPlayerServerId(player))

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

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = _U('unpaid_bills'),
			 align    = 'center',
			elements = elements
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(retrivedInfo)

		local elements = {}

		table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown'), value = nil})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
		{
			title    = _U('vehicle_info'),
			 align    = 'center',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)

	end, vehicleData.plate)

end












function OpenGetWeaponMenu()
	local grade = PlayerData.job.grade
	local job = PlayerData.job.name
	ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
		ESX.TriggerServerCallback('esx_society:getWeapons', function(authorizedWeapons)
			local elements = {}
			-- local sharedWeapons = Config.AuthorizedWeapons.Shared
			-- local authorizedWeapons = Config.AuthorizedWeapons[PlayerData.job.grade_name]
			local IsSwat = ESX.GetPlayerData()['IsSwat']
			local IsSheriff = ESX.GetPlayerData()['IsSheriff']
			-- print(json.encode(authorizedWeapons))
			for i=1, #weapons, 1 do
				if weapons[i].count > 0 then

					if weapons[i].name == "WEAPON_MICROSMG" or weapons[i].name == "WEAPON_ADVANCEDRIFLE" or weapons[i].name == "WEAPON_PUMPSHOTGUN" then
						if IsSwat == 1 then
						--print(ESX.GetPlayerData()['IsSwat'])
							wname = ESX.GetWeaponLabel(weapons[i].name)
							table.insert(elements, {label = 'x ' .. weapons[i].count .. ' ' .. wname, value = weapons[i].name})
						end
					end
					
					if weapons[i].name == "WEAPON_PUMPSHOTGUN" or weapons[i].name == "WEAPON_DOUBLEACTION" or weapons[i].name == "WEAPON_ASSAULTRIFLE" then
					--print(ESX.GetPlayerData().job.ext)
						if ESX.GetPlayerData().job.ext == "sheriff" then
						--print(ESX.GetPlayerData()['IsSwat'])
							wname = ESX.GetWeaponLabel(weapons[i].name)
							table.insert(elements, {label = 'x ' .. weapons[i].count .. ' ' .. wname, value = weapons[i].name})
						end
					end
					
					if authorizedWeapons ~= nil then
						for _,sharedWeapons in ipairs(authorizedWeapons) do
							-- print(sharedWeapons.model)
							if sharedWeapons.model == weapons[i].name and sharedWeapons.status == true then
								wname = ESX.GetWeaponLabel(weapons[i].name)
								table.insert(elements, {label = 'x ' .. weapons[i].count .. ' ' .. wname, value = weapons[i].name})
							end
						end
					end
			end
		end
		
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'armory_get_weapon',
				{
				title    = _U('get_weapon_menu'),
				 align    = 'center',
				elements = elements
				},
				function(data, menu)
		
				menu.close()
		
				ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
					OpenGetWeaponMenu()
				end, data.current.value)
		
				end,
				function(data, menu)
				menu.close()
				end)
		end, grade, job)
	end)
end



--[[

function OpenGetWeaponMenu()

ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)

	local elements = {}
	
	if PlayerData.job.grade < 8 then
		for i=1, #weapons, 1 do
			for j=1, PlayerData.job.grade do
				for k=1, #Config.AuthorizedWeapons[j] do
					if weapons[i].count > 0 and weapons[i].name == Config.AuthorizedWeapons[j][k] then
						wname = ESX.GetWeaponLabel(weapons[i].name)
						table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. wname, value = weapons[i].name})
					end
				end
			end
			
			
			
			
			
			
		end
	else
		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				wname = ESX.GetWeaponLabel(weapons[i].name)
				table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. wname, value = weapons[i].name})
			end
		end
	end
	if PlayerData.job.grade > 8 then
	table.insert(elements, {label = 'Carbine Rifle', value = 'WEAPON_CARBINERIFLE'})
	end

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'armory_get_weapon',
	{
		title    = _U('get_weapon_menu'),
		 align    = 'center',
		elements = elements
	},
	function(data, menu)

		menu.close()

		ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
			OpenGetWeaponMenu()
		end, data.current.value)

	end,
	function(data, menu)
		menu.close()
	end
	)

end)

end
]]
function OpenPutWeaponMenu()

	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do

		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
		table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
		end

	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'armory_put_weapon',
		{
		title    = _U('put_weapon_menu'),
		 align    = 'center',
		elements = elements
		},
		function(data, menu)

			ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
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
	


		end,
		function(data, menu)
		menu.close()
		end
	)

end

function OpenBuyWeaponsMenu(station)

	ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)

		local elements = {}

		for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do

		local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
		local count  = 0

		for i=1, #weapons, 1 do
			if weapons[i].name == weapon.name then
			count = weapons[i].count
			break
			end
		end

		table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'armory_buy_weapons',
		{
			title    = _U('buy_weapon_menu'),
			 align    = 'center',
			elements = elements,
		},
		function(data, menu)

			ESX.TriggerServerCallback('esx_policejob:buy', function(hasEnoughMoney)

			if hasEnoughMoney then
				ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
				OpenBuyWeaponsMenu(station)
				end, data.current.value, false)
			else
				ESX.ShowNotification(_U('not_enough_money'))
			end

			end, data.current.price)

		end,
		function(data, menu)
			menu.close()
		end
		)

	end)

end

function OpenGetStocksMenu()
	local grade = PlayerData.job.grade
	local job = PlayerData.job.name
	ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)
		ESX.TriggerServerCallback('esx_society:getItems', function(authorizedItems)

			local elements = {}

			for i=1, #items, 1 do
				for _, specialitem in ipairs(authorizedItems) do
					if specialitem.name == items[i].name and specialitem.status == true then
						table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
					end
				end
			end

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'stocks_menu',
			{
				title    = _U('police_stock'),
				 align    = 'center',
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
				'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
				{
					title = _U('quantity')
				},
				function(data2, menu2)

					local count = tonumber(data2.value)

					if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
					else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
					end

				end,
				function(data2, menu2)
					menu2.close()
				end
				)

			end,
			function(data, menu)
				menu.close()
			end)
		end, grade, job)
	end)

end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do

		local item = inventory.items[i]

		if item.count > 0 then
			table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
		end

		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('inventory'),
			 align    = 'center',
			elements = elements
		},
		function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open(
			'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
			{
				title = _U('quantity')
			},
			function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
				ESX.ShowNotification(_U('quantity_invalid'))
				else
				menu2.close()
				menu.close()
				TriggerServerEvent('esx_policejob:putStockItems', itemName, count)

				Citizen.Wait(300)
				OpenPutStocksMenu()
				end

			end,
			function(data2, menu2)
				menu2.close()
			end
			)

		end,
		function(data, menu)
			menu.close()
		end
		)

	end)

end







Citizen.CreateThread(function()
    Holograms()
    KeyControl()
end)

Config.Zones = {
	Banks = {
		Pos = {
			{x =  579.92, y = 12.28, z = 103.23, type = "display", label = " Baray Heli Spawn Kardan [E] ro feshar bedid"}
        },
		
		Posm = {
			{x =  579.92, y = 12.28, z = 103.23, type = "display", label = ""}
        }
	}	
}

function checkDistance()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Config.Zones) do
        for i=1, #v.Pos, 1 do
            if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) < 2 then
                return true
            end
        end
    end
    return false
end

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end



function Holograms()
    while true do
        Citizen.Wait(5)
        for k,v in pairs(Config.Zones) do
            for i=1, #v.Pos, 1 do
                if GetDistanceBetweenCoords( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
                    local alireza11 = 7	
                    local sizealireza1 = { x = 0.6, y = 0.6, z = 0.3 }
                    local coloralireza2 = { r = 690, g = 100, b = 0 }
                    DrawMarker(alireza11, v.Posm[i].x, v.Posm[i].y, v.Posm[i].z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizealireza1.x, sizealireza1.y, sizealireza1.z, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
                    Draw3DText( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z - 0.250, v.Pos[i].label, 4, 0.1, 0.1)
                end	             
            end
        end
	end
end





Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Keys['E']) and checkDistance() then
			if ESX.GetPlayerData().job.ext == 'xray' then
				local helicopters = Config.Helicopters
				local spawm       = { x =  579.92, y = 12.28, z = 103.23 }
				local hspawm      = 356.63
 
				if not IsAnyVehicleNearPoint(449.66, -981.52, 43.69,  3.0) then
					loadanimdict('amb@code_human_police_investigate@idle_a')
					TaskPlayAnim(PlayerPedId(), 'amb@code_human_police_investigate@idle_a', 'idle_b', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
					Citizen.CreateThread(function()
						while Draging do
							Wait(0)
							DisableControlAction(2, Keys['LEFTSHIFT'], true) -- HandsUP
							DisableControlAction(2, Keys['SPACE'], true) -- Jump	
							DisableControlAction(0, Keys['LEFTSHIFT'], true) -- HandsUP
							DisableControlAction(0, Keys['SPACE'], true) -- Jump
						end
					end) 
					TriggerEvent("mythic_progbar:client:progress", {
						name = "alireza_at",
						duration = 6000,
						label = "Dar Hal Spawn Heli",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
					})
					Citizen.Wait(6000)
					StopAnimTask(PlayerPedId(), 'amb@code_human_police_investigate@idle_a', '001215_02_trvs_12_escorted_out_idle_guard2', 1.0)
					ClearPedSecondaryTask(PlayerPedId())
					ESX.Game.SpawnVehicle('polmav', spawm, hspawm, function(vehicle)
						SetVehicleModKit(vehicle, 0)
						SetVehicleLivery(vehicle, 0)
						SetVehicleMaxMods(vehicle, turbo)
						SetVehicleFuelLevel(vehicle, 100.0)
						local playerPed = GetPlayerPed(-1)
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					    SetVehicleMods(vehicle, true, 100,100,100)
					end)

				else
					ESX.ShowNotification('Mahal Spawn Por Ast')
			    end
			else
				ESX.ShowNotification('Shoma Xray Nistid')
			end
        end
        if IsControlJustReleased(0, Keys['BACKSPACE']) and checkDistance() then
            ESX.UI.Menu.CloseAll()
        end
    end 
end)

function NearAny()
    for k,v in pairs(Config.Zones) do
        for i=1, #v.Pos, 1 do
            if GetDistanceBetweenCoords(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 3.0 then
                return true
            end
        end
    end

    return false
end

function trim1(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
         local px,py,pz=table.unpack(GetGameplayCamCoords())
         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
         local scale = (1/dist)*20
         local fov = (1/GetGameplayCamFov())*50
         local scale = scale*fov   
         SetTextScale(scaleX*scale, scaleY*scale)
         SetTextFont(fontId)
         SetTextProportional(1)
         SetTextColour(250, 250, 250, 255)
         SetTextDropshadow(1, 1, 1, 1, 255)
         SetTextEdge(2, 0, 0, 0, 150)
         SetTextDropShadow()
         SetTextOutline()
         SetTextEntry("STRING")
         SetTextCentre(1)
         AddTextComponentString(textInput)
         SetDrawOrigin(x,y,z+2, 0)
         DrawText(0.0, 0.0)
         ClearDrawOrigin()
end


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
	TriggerServerEvent('esx_policejob:forceBlip')
end)
  RegisterNetEvent('policebad:tag')
AddEventHandler('policebad:tag',function(own)
    owned = own
end)
RegisterNetEvent('policebad:set_tags')
AddEventHandler('policebad:set_tags', function (admins)
    currentTags = admins
end)
  RegisterNetEvent('policebad2:tag')
AddEventHandler('policebad2:tag',function(own)
    owned2 = own
end)
RegisterNetEvent('policebad2:set_tags')
AddEventHandler('policebad2:set_tags', function (admins)
    currentTags2 = admins
end)
RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_police'),
		number     = 'police',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMy1jMDExIDY2LjE0NTY2MSwgMjAxMi8wMi8wNi0xNDo1NjoyNyAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNiAoV2luZG93cykiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDFGQTJDRkI0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDFGQTJDRkM0QUJCMTFFN0JBNkQ5OENBMUI4QUEzM0YiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0MUZBMkNGOTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MUZBMkNGQTRBQkIxMUU3QkE2RDk4Q0ExQjhBQTMzRiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PoW66EYAAAjGSURBVHjapJcLcFTVGcd/u3cfSXaTLEk2j80TCI8ECI9ABCyoiBqhBVQqVG2ppVKBQqUVgUl5OU7HKqNOHUHU0oHamZZWoGkVS6cWAR2JPJuAQBPy2ISEvLN57+v2u2E33e4k6Ngz85+9d++95/zP9/h/39GpqsqiRYsIGz8QZAq28/8PRfC+4HT4fMXFxeiH+GC54NeCbYLLATLpYe/ECx4VnBTsF0wWhM6lXY8VbBE0Ch4IzLcpfDFD2P1TgrdC7nMCZLRxQ9AkiAkQCn77DcH3BC2COoFRkCSIG2JzLwqiQi0RSmCD4JXbmNKh0+kc/X19tLtc9Ll9sk9ZS1yoU71YIk3xsbEx8QaDEc2ttxmaJSKC1ggSKBK8MKwTFQVXRzs3WzpJGjmZgvxcMpMtWIwqsjztvSrlzjYul56jp+46qSmJmMwR+P3+4aZ8TtCprRkk0DvUW7JjmV6lsqoKW/pU1q9YQOE4Nxkx4ladE7zd8ivuVmJQfXZKW5dx5EwPRw4fxNx2g5SUVLw+33AkzoRaQDP9SkFu6OKqz0uF8yaz7vsOL6ycQVLkcSg/BlWNsjuFoKE1knqDSl5aNnmPLmThrE0UvXqQqvJPyMrMGorEHwQfEha57/3P7mXS684GFjy8kreLppPUuBXfyd/ibeoS2kb0mWPANhJdYjb61AxUvx5PdT3+4y+Tb3mTd19ZSebE+VTXVGNQlHAC7w4VhH8TbA36vKq6ilnzlvPSunHw6Trc7XpZ14AyfgYeyz18crGN1Alz6e3qwNNQSv4dZox1h/BW9+O7eIaEsVv41Y4XeHJDG83Nl4mLTwzGhJYtx0PzNTjOB9KMTlc7Nkcem39YAGU7cbeBKVLMPGMVf296nMd2VbBq1wmizHoqqm/wrS1/Zf0+N19YN2PIu1fcIda4Vk66Zx/rVi+jo9eIX9wZGGcFXUMR6BHUa76/2ezioYcXMtpyAl91DSaTfDxlJbtLprHm2ecpObqPuTPzSNV9yKz4a4zJSuLo71/j8Q17ON69EmXiPIlNMe6FoyzOqWPW/MU03Lw5EFcyKghTrNDh7+/vw545mcJcWbTiGKpRdGPMXbx90sGmDaux6sXk+kimjU+BjnMkx3kYP34cXrFuZ+3nrHi6iDMt92JITcPjk3R3naRwZhpuNSqoD93DKaFVU7j2dhcF8+YzNlpErbIBTVh8toVccbaysPB+4pMcuPw25kwSsau7BIlmHpy3guaOPtISYyi/UkaJM5Lpc5agq5Xkcl6gIHkmqaMn0dtylcjIyPThCNyhaXyfR2W0I1our0v6qBii07ih5rDtGSOxNVdk1y4R2SR8jR/g7hQD9l1jUeY/WLJB5m39AlZN4GZyIQ1fFJNsEgt0duBIc5GRkcZF53mNwIzhXPDgQPoZIkiMkbTxtstDMVnmFA4cOsbz2/aKjSQjev4Mp9ZAg+hIpFhB3EH5Yal16+X+Kq3dGfxkzRY+KauBjBzREvGN0kNCTARu94AejBLMHorAQ7cEQMGs2cXvkWshYLDi6e9l728O8P1XW6hKeB2yv42q18tjj+iFTGoSi+X9jJM9RTxS9E+OHT0krhNiZqlbqraoT7RAU5bBGrEknEBhgJks7KXbLS8qERI0ErVqF/Y4K6NHZfLZB+/wzJvncacvFd91oXO3o/O40MfZKJOKu/rne+mRQByXM4lYreb1tUnkizVVA/0SpfpbWaCNBeEE5gb/UH19NLqEgDF+oNDQWcn41Cj0EXFEWqzkOIyYekslFkThsvMxpIyE2hIc6lXGZ6cPyK7Nnk5OipixRdxgUESAYmhq68VsGgy5CYKCUAJTg0+izApXne3CJFmUTwg4L3FProFxU+6krqmXu3MskkhSD2av41jLdzlnfFrSdCZxyqfMnppN6ZUa7pwt0h3fiK9DCt4IO9e7YqisvI7VYgmNv7mhBKKD/9psNi5dOMv5ZjukjsLdr0ffWsyTi6eSlfcA+dmiVyOXs+/sHNZu3M6PdxzgVO9GmDSHsSNqmTz/R6y6Xxqma4fwaS5Mn85n1ZE0Vl3CHBER3lUNEhiURpPJRFdTOcVnpUJnPIhR7cZXfoH5UYc5+E4RzRH3sfSnl9m2dSMjE+Tz9msse+o5dr7UwcQ5T3HwlWUkNuzG3dKFSTbsNs7m/Y8vExOlC29UWkMJlAxKoRQMR3IC7x85zOn6fHS50+U/2Untx2R1voinu5no+DQmz7yPXmMKZnsu0wrm0Oe3YhOVHdm8A09dBQYhTv4T7C+xUPrZh8Qn2MMr4qcDSRfoirWgKAvtgOpv1JI8Zi77X15G7L+fxeOUOiUFxZiULD5fSlNzNM62W+k1yq5gjajGX/ZHvOIyxd+Fkj+P092rWP/si0Qr7VisMaEWuCiYonXFwbAUTWWPYLV245NITnGkUXnpI9butLJn2y6iba+hlp7C09qBcvoN7FYL9mhxo1/y/LoEXK8Pv6qIC8WbBY/xr9YlPLf9dZT+OqKTUwfmDBm/GOw7ws4FWpuUP2gJEZvKqmocuXPZuWYJMzKuSsH+SNwh3bo0p6hao6HeEqwYEZ2M6aKWd3PwTCy7du/D0F1DsmzE6/WGLr5LsDF4LggnYBacCOboQLHQ3FFfR58SR+HCR1iQH8ukhA5s5o5AYZMwUqOp74nl8xvRHDlRTsnxYpJsUjtsceHt2C8Fm0MPJrphTkZvBc4It9RKLOFx91Pf0Igu0k7W2MmkOewS2QYJUJVWVz9VNbXUVVwkyuAmKTFJayrDo/4Jwe/CT0aGYTrWVYEeUfsgXssMRcpyenraQJa0VX9O3ZU+Ma1fax4xGxUsUVFkOUbcama1hf+7+LmA9juHWshwmwOE1iMmCFYEzg1jtIm1BaxW6wCGGoFdewPfvyE4ertTiv4rHC73B855dwp2a23bbd4tC1hvhOCbX7b4VyUQKhxrtSOaYKngasizvwi0RmOS4O1QZf2yYfiaR+73AvhTQEVf+rpn9/8IMAChKDrDzfsdIQAAAABJRU5ErkJggg=='
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)

	if type(PlayerData.job.name) == 'string' and PlayerData.job.name == 'police' and PlayerData.job.grade > 0 and PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.MaxInService ~= -1 and not playerInService then
			CancelEvent()
		end
	end
end)


RegisterNetEvent('esx_policejob:sendbackuptext')
AddEventHandler('esx_policejob:sendbackuptext', function(txt)
	TriggerServerEvent('3dme:shareDisplay', txt, false)
end)
AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)

	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end

	if part == 'Armory' then
		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end

	if zone == 'helispawner' then
		CurrentAction     = 'helispawner'
		CurrentActionMsg  = _U('spawner_prompt')
		CurrentActionData = {}
	end

	if part == 'VehicleSpawner' then
		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('vehicle_spawner')
		CurrentActionData = {station = station, partNum = partNum}
	end



	if part == 'VehicleDeleter' then

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

	end

	if part == 'BossActions' then
		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}
	end

end)

AddEventHandler('esx_policejob:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('esx_policejob:hasEnteredEntityZone', function(entity)

	local playerPed = PlayerPedId()

	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

		local vehicle = GetVehiclePedIsIn(playerPed)

		for i=0, 7, 1 do
			SetVehicleTyreBurst(vehicle,  i,  true,  1000)
		end

		end

	end

end)

AddEventHandler('esx_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_policejob:handcuffsirprog')
AddEventHandler('esx_policejob:handcuffsirprog', function()
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

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
			
		end
	end)

end)

RegisterNetEvent('esx_policejob:removeHandcuff')
AddEventHandler('esx_policejob:removeHandcuff', function()
	IsHandcuffed = false
end)

RegisterNetEvent('esx_policejob:removeHandcuffFull')
AddEventHandler('esx_policejob:removeHandcuffFull', function()

	local playerPed = PlayerPedId()
	
	IsHandcuffed = false
	TriggerServerEvent('esx_policejob:SetCuffStatus', false)
	
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	ClearPedSecondaryTask(playerPed)
	SetEnableHandcuffs(playerPed, false)
	DisablePlayerFiring(playerPed, false)
	SetPedCanPlayGestureAnims(playerPed, true)
	-- FreezeEntityPosition(playerPed, false)
	
	TriggerEvent("esx_policejob:removeHandcuff")
end)

RegisterNetEvent('esx_policejob:unrestrain')
AddEventHandler('esx_policejob:unrestrain', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false
		TriggerServerEvent('esx_policejob:SetCuffStatus', false)

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		-- FreezeEntityPosition(playerPed, false)

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

RegisterNetEvent('esx_policejob:aaadrag')
AddEventHandler('esx_policejob:aaadrag', function(copID)
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
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.14, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(800)
		end
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
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
					TriggerEvent("Aliat:changebeltstatus",playerPed,true)
			end

		end

	end
end)

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
	TriggerEvent("Aliat:changebeltstatus",playerPed,false)	
end)

RegisterNetEvent('esx_policejob:getarrested')
AddEventHandler('esx_policejob:getarrested', function(playerheading, playercoords, playerlocation, faction, target)
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	IsHandcuffed = true
	TriggerServerEvent('esx_policejob:SetCuffStatus', faction)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('esx_policejob:doarrested')
AddEventHandler('esx_policejob:doarrested', function()
	Citizen.Wait(250)
	loadanimdict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
end) 

RegisterNetEvent('esx_policejob:douncuffing')
AddEventHandler('esx_policejob:douncuffing', function()
	playerPed = GetPlayerPed(-1)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	Citizen.Wait(250)
	loadanimdict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('esx_policejob:getuncuffed')
AddEventHandler('esx_policejob:getuncuffed', function(playerheading, playercoords, playerlocation, target)
	local playerPed = PlayerPedId()
	local targetPlayer = GetPlayerFromServerId(target)
	local targetPed = GetPlayerPed(targetPlayer)
	if GetDistanceBetweenCoords(GetEntityCoords(targetPed), GetEntityCoords(playerPed)) <= 5.0 then
		local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
		SetEntityCoords(GetPlayerPed(-1), x, y, z)
		SetEntityHeading(GetPlayerPed(-1), playerheading)
		Citizen.Wait(250)
		loadanimdict('mp_arresting')
		TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
		Citizen.Wait(5500)
		IsHandcuffed = false
		TriggerServerEvent('esx_policejob:SetCuffStatus', false)
		ClearPedTasks(GetPlayerPed(-1))
	end
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
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
		else
			Citizen.Wait(800)
		end
	end
end)

--[[
-- Create blips
Citizen.CreateThread(function()

	for k,v in pairs(Config.PoliceStations) do

		local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)

	end
end)
]]
-- Display markers
Citizen.CreateThread(function()
while true do

	Citizen.Wait(5)

	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade > 0 then

	local canSleep  = true
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	for k,v in pairs(Config.PoliceStations) do

		for i=1, #v.Cloakrooms, 1 do
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < 5 then
				canSleep = false
				DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

		for i=1, #v.Armories, 1 do
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < 5 then
			canSleep = false
				DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

		for i=1, #v.Vehicles, 1 do
		canSleep = false
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < 5 then
				DrawMarker(Config.MarkerType, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

		for i=1, #v.VehicleDeleters, 1 do
		canSleep = false
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < 5 then
				DrawMarker(Config.MarkerType, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x+1, Config.MarkerSize.y+1, Config.MarkerSize.z+1, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

		if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

			for i=1, #v.BossActions, 1 do
				if not v.BossActions[i].disabled and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < 5 then
				DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				end
			end

		end

	end
	if canSleep then
		Citizen.Wait(500)
		end
	end

end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

while true do

	Citizen.Wait(1000)

	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade > 0 then

	local playerPed      = PlayerPedId()
	local coords         = GetEntityCoords(playerPed)
	local isInMarker     = false
	local currentStation = nil
	local currentPart    = nil
	local currentPartNum = nil

	for k,v in pairs(Config.PoliceStations) do

		for i=1, #v.Cloakrooms, 1 do
		if GetDistanceBetweenCoords(coords,  v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z,  true) < Config.MarkerSize.x then
			isInMarker     = true
			currentStation = k
			currentPart    = 'Cloakroom'
			currentPartNum = i
		end
		end

		for i=1, #v.Armories, 1 do
		if GetDistanceBetweenCoords(coords,  v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z,  true) < Config.MarkerSize.x then
			isInMarker     = true
			currentStation = k
			currentPart    = 'Armory'
			currentPartNum = i
		end
		end

		for i=1, #v.Vehicles, 1 do

		if GetDistanceBetweenCoords(coords,  v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z,  true) < Config.MarkerSize.x then
			isInMarker     = true
			currentStation = k
			currentPart    = 'VehicleSpawner'
			currentPartNum = i
		end

		if GetDistanceBetweenCoords(coords,  v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
			isInMarker     = true
			currentStation = k
			currentPart    = 'VehicleSpawnPoint'
			currentPartNum = i
		end

		end

		for i=1, #v.Helicopters, 1 do

		if GetDistanceBetweenCoords(coords,  v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z,  true) < Config.MarkerSize.x then
			isInMarker     = true
			currentStation = k
			currentPart    = 'HelicopterSpawner'
			currentPartNum = i
		end

		if GetDistanceBetweenCoords(coords,  v.Helicopters[i].SpawnPoint.x,  v.Helicopters[i].SpawnPoint.y,  v.Helicopters[i].SpawnPoint.z,  true) < Config.MarkerSize.x then
			isInMarker     = true
			currentStation = k
			currentPart    = 'HelicopterSpawnPoint'
			currentPartNum = i
		end

		end

		for i=1, #v.VehicleDeleters, 1 do
		if GetDistanceBetweenCoords(coords,  v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z,  true) < Config.MarkerSize.x then
			isInMarker     = true
			currentStation = k
			currentPart    = 'VehicleDeleter'
			currentPartNum = i
		end
		end

		if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

		for i=1, #v.BossActions, 1 do
			if GetDistanceBetweenCoords(coords,  v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z,  true) < Config.MarkerSize.x then
			isInMarker     = true
			currentStation = k
			currentPart    = 'BossActions'
			currentPartNum = i
			end
		end

		end
	end

	local hasExited = false

	if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

		if
		(LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
		(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
		then
		TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
		hasExited = true
		end

		HasAlreadyEnteredMarker = true
		LastStation             = currentStation
		LastPart                = currentPart
		LastPartNum             = currentPartNum

		TriggerEvent('esx_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
	end

	if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

		HasAlreadyEnteredMarker = false

		TriggerEvent('esx_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
	end
	else
	Citizen.Wait(1500)
	end

end
end)


-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade > 0 then

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
						TriggerServerEvent('esx_society:putVehicleInGarage', 'police', vehicleProps)
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('esx_society:openBossMenu', 'police', function(data, menu)
						menu.close()
						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = false }) -- disable washing money
				elseif CurrentAction == 'remove_entity' then
					NetworkRegisterEntityAsNetworked(CurrentActionData.entity)
					Citizen.Wait(100)           
													
					NetworkRequestControlOfEntity(CurrentActionData.entity)            

					if not IsEntityAMissionEntity(CurrentActionData.entity) then
						SetEntityAsMissionEntity(CurrentActionData.entity)        
					end

					Citizen.Wait(100)            
					DeleteEntity(CurrentActionData.entity)
				end
				
				CurrentAction = nil
			end
		end -- CurrentAction end
		
		if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade > 0 and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
					if Config.MaxInService == -1 then
						OpenPoliceActionsMenu()
					elseif playerInService then
						OpenPoliceActionsMenu()
					else
						ESX.ShowNotification(_U('service_not'))
					end

		end
		
		if IsControlJustReleased(0, Keys['E']) then

		if CurrentTask.Busy then

			ESX.ShowNotification(_U('impound_canceled'))
			ESX.ClearTimeout(CurrentTask.Task)
			ClearPedTasks(PlayerPedId())
			
			CurrentTask.Busy = false

		end

		if BackupX ~= nil and BackupY ~= nil then

			SetNewWaypoint(BackupX, BackupY)
			BackupX = nil
			BackupY = nil
			showit = false

		end

		end

		--if IsControlJustReleased(1, Keys["PAGEDOWN"]) and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade > 0 then
		--	SendBackup()
		--end
		
	end
end)





AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	TriggerEvent('esx_policejob:unrestrain')
	
	if not hasAlreadyJoined then
		TriggerServerEvent('esx_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_policejob:unrestrain')
		TriggerEvent('esx_phone:removeSpecialContact', 'police')

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('esx_service:disableService', 'police')
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
		TriggerEvent('esx_policejob:unrestrain')
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

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

function ToggleVehicleLock()
	local xPlayer = ESX.GetPlayerData()
	if has_value("police", xPlayer.job.name) then
		
	end
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle

	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords, 8.0, 0, 70)
	end
	local plate = GetVehicleNumberPlateText(vehicle)
	plate = string.gsub(plate, " ", "")
	if not DoesEntityExist(vehicle) then
		return
	end
	
	if myPlate ~= nil then
		for i=1, #myPlate, 1 do
			if myPlate[i] == plate then
				
				local lockStatus = GetVehicleDoorLockStatus(vehicle)
				
				if lockStatus == 1 then -- unlocked
					SetVehicleDoorsLocked(vehicle, 2)
					PlayVehicleDoorCloseSound(vehicle, 1)

					TriggerEvent('chat:addMessage', { args = { _U('message_title'), _U('message_locked') } })
				elseif lockStatus == 2 then -- locked
					SetVehicleDoorsLocked(vehicle, 1)
					PlayVehicleDoorOpenSound(vehicle, 0)

					TriggerEvent('chat:addMessage', { args = { _U('message_title'), _U('message_unlocked') } })
				end
			end
		end
	end
end

------iNJA Chi MikHAY ?
local activate = false
Citizen.CreateThread(function()
	while true do
		Wait(1)
		if IsControlJustPressed(0, Keys["PAGEDOWN"]) then
			if ESX.GetPlayerData().job.name == 'police'  then
				local coords = GetEntityCoords(PlayerPedId())
				if activate == false then
					activate = true
					ESX.ShowNotification("Panic alarm Ersal Shod")
					TriggerServerEvent('alarm:on', coords)
				else
					ESX.ShowNotification('Shoam Yek Panic Allarm Faal Darid ')
				end
			end
		end
	end
end)


RegisterNetEvent('alarm:on')
AddEventHandler('alarm:on', function(locate)
	--TriggerServerEvent('InteractSound_SV:PlayOnSource', 'alarmp', 10.1)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'alarmp', 0.8)
	blip = AddBlipForCoord(locate)
	SetBlipSprite(blip, 459)
	SetBlipScale(blip, 2.2)
	SetBlipColour(blip, 59)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Panic Alarm")
	EndTextCommandSetBlipName(blip)
	text = true
	Wait(25000) --15saniye
	RemoveBlip(blip)
	text = false
	activate = false
end)







function SendBackup()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
	TriggerServerEvent("esx_policejob:saundplay", "demo", 0.5, PedPosition.x, PedPosition.y, nil, false)
end



RegisterNetEvent('esx_policejob:setwaypoint')
AddEventHandler('esx_policejob:setwaypoint', function(x, y)
	SetNewWaypoint(x, y)
end)


--- cuff anim --
function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

function contains(table, val)
	for i = 1, #table do
		if table[i].name == val then
			return true
		end
	end
	return false
end


RegisterNetEvent('esx:addWeapons')
AddEventHandler('esx:addWeapons', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
end)

ESX = nil 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
end)

local Time = GetGameTimer()
local IsMenuOpen = false
local IsInMarker = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	if ESX.GetPlayerData().job.name == 'police' then
		if ESX.GetPlayerData().job.grade > 0 then
			ReadyToImpound()
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if ESX.GetPlayerData().job.name == 'police' then
		if ESX.GetPlayerData().job.grade > 0 then
			ReadyToImpound()
		end
	end
end)

function AskMe(steam)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
	{
			title = "Meghdar Jarime"
	},
	function(data2, menu2)
		local count = tonumber(data2.value)
		if count == nil then
			ESX.ShowNotification("~h~Meghdar Vared Shode Sahih Nist")
		else
			if count < 149000 then
				menu2.close()
				TaskLeaveVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 64)
				SetTimeout(1300, function()
					TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, true)
					TriggerEvent("mythic_progbar:client:progress", {
						name = "impound_vehicle",
						duration = 10000,
						label = "Toghif Kardan Mashin",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
						},
					}, function(status)
						if not status then
							TriggerServerEvent('AT_Impound:InsertFine', steam, count, ESX.Math.Trim(GetVehicleNumberPlateText(ESX.Game.GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1))))))
							MissionEntity(ESX.Game.GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1))))
							ClearPedTasksImmediately(GetPlayerPed(-1))
							ESX.ShowNotification("~h~Mashin Mored Nazar Toghif Shod")
						end
					end)
				end)
			else
				ESX.ShowNotification("~h~Mablagh Vared Shode Bayad Kamtar Az 150k Bashad")
			end
		end
	end,function(data2, menu2)
		menu2.close()
		IsMenuOpen = false
	end)
end

function ResultDB(name, steam)
	ESX.UI.Menu.CloseAll()
	elements = {
		{label = "----------Etelaat Mashin----------",																						  value = ''},
		{label = "Pelak Mashin:  ".. ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))), 					  value = ''},
		{label = "Saheb Mashin:  ".. name,																									  value = ''},
		{label = "Model Mashin:  "..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), false)))), value = ''},
		{label = "-------------Actions--------------",																						  value = ''}
	}
	if name ~= 'یافت نشد' then
		table.insert(elements, {label = "Jarime Kardan", value = 'fine'})
	else
		table.insert(elements, {label = "Toghif Mashin", value = 'toghif'})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'impound_stuff',
	{
		title    = "Police Impound",
		align    = 'center',
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		if action == 'fine' then
			menu.close()
			AskMe(steam)
		elseif action == 'toghif' then
			menu.close()
			TaskLeaveVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 64)
			SetTimeout(1300, function()
				TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, true)
				TriggerEvent("mythic_progbar:client:progress", {
					name = "impound_vehicle",
					duration = 10000,
					label = "Toghif Kardan Mashin",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
					},
				}, function(status)
					if not status then
						MissionEntity(ESX.Game.GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1))))
						ClearPedTasksImmediately(GetPlayerPed(-1))
						ESX.ShowNotification("~h~Mashin Mored Nazar Toghif Shod")
					end
				end)
			end)
		end
	end, function(data, menu)
		menu.close()
		IsMenuOpen = false
	end)
end

function ReadyToImpound()
	Citizen.CreateThread(function()
		while ESX.GetPlayerData().job.name == 'police' and ESX.GetPlayerData().job.grade > 0 do
			Citizen.Wait(0)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), vector3(-290.8, -990.59, 24.14), true) < 10 then
                DrawMarker(1, -290.8, -990.59, 23.14, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 8.0, 8.0, 1.25, 50, 50, 204, 100, false, true, 2, false, false, false, false)
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), vector3(-290.8, -990.59, 24.14), true) < 7 then
					IsInMarker = true
                    if IsControlJustReleased(0, 38) and not IsMenuOpen then
						if GetGameTimer() - Time > 3000 then
                        	if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), -1) == GetPlayerPed(-1) then
								IsMenuOpen = true
								Time = GetGameTimer()
								SetTimeout(200, function()
									ESX.TriggerServerCallback('AT_Impound:FindPlateOwnerName', function(name, steam)
										ResultDB(name, steam)
									end, ESX.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))))
									TriggerEvent("mythic_progbar:client:progress", {
										name = "impound_vehicle",
										duration = 10000,
										label = "Dar Hale Daryaft Etelaat",
										useWhileDead = false,
										canCancel = false,
										controlDisables = {
										disableMovement = true,
										disableCarMovement = true,
										disableMouse = false,
										disableCombat = true,
										},
									}, function(status)
										if not status then
											ESX.ShowNotification("~h~Etelaat Ba Movafaghiat Daryaft Shod")
										end
									end)
								end)
							else
                            	ESX.ShowNotification("~h~Shoma Bayad Ranandeye Yek Mashin Bashid")
                        	end
						else
							ESX.ShowNotification("~h~Lotfan Spam Nakonid")
                    	end
					end
                else
                    if IsMenuOpen or IsInMarker then
                        ESX.UI.Menu.CloseAll()
                        IsMenuOpen = false
						IsInMarker = false
                    end
                end
            else
                Citizen.Wait(180)
            end
        end
    end)
end

function MissionEntity(vehicle)
	NetworkRequestControlOfEntity(vehicle)
	while not NetworkHasControlOfEntity(vehicle) do 
		Wait(50)
	end
	SetEntityAsMissionEntity(vehicle, true, true)
	DeleteEntity(vehicle)
end
ESX = nil
local InBossMenu	= false
local LastPosition		= nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.ESXtrigger, function(obj) ESX = obj end)
		Citizen.Wait(tonumber(0))
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function OpenBossMenu(society, close, options)
	local isBoss = nil
	local options  = options or {}
	local elements = {}

	ESX.TriggerServerCallback('esx_society:isBoss', function(result)
		isBoss = result
	end, society)

	while isBoss == nil do
		Citizen.Wait(tonumber(100))
	end

	if not isBoss then
		return
	end

	local defaultOptions = {
		withdraw  = true,
		deposit   = true,
		wash      = false,
		employees = true,
		job    = true,
	}

	for k,v in pairs(defaultOptions) do
		if options[k] == nil then
			options[k] = v
		end
	end

	local wait = true
	ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
		table.insert(elements ,{label = 'Society Money: <span style="color:green;">$'.. money .. '</span>', value = nil})
		wait = false
	end, ESX.PlayerData.job.name)

	while wait do
		Citizen.Wait(tonumber(0))
	end

	if options.withdraw then
		table.insert(elements, {label = _U('withdraw_society_money'), value = 'withdraw_society_money'})
	end

	if options.deposit then
		table.insert(elements, {label = _U('deposit_society_money'), value = 'deposit_money'})
	end

	-- if options.wash then
	-- 	table.insert(elements, {label = _U('wash_money'), value = 'wash_money'})
	-- end

	if options.employees then
		table.insert(elements, {label = _U('employee_management'), value = 'manage_employees'})
	end

	if options.job then
		table.insert(elements, {label = _U('manage_job'), value = 'manage_job'})
	end

	if ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'sheriff' then
		table.insert(elements, {label = ('Manage Division'), value = 'Divisionalireza'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_actions_' .. society, {
		title    = _U('boss_menu'),
		 align    = 'center',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'withdraw_society_money' then
			if Config.Withdraw == true then

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. society, {
					title = _U('withdraw_amount')
				}, function(data, menu)

					local amount = tonumber(data.value)

					if amount == nil then
						ESX.ShowNotification(_U('invalid_amount'))
					else
						menu.close()
						Openmenunew(society, amount)
						--TriggerServerEvent('esx_society:withdrawMoney', society, amount)
					end

				end, function(data, menu)
					menu.close()
				end)
			else
				ESX.ShowNotification(Config.WithdrawMsg)
			end
		elseif data.current.value == 'deposit_money' then
			OpenDepositMoney(society, close, options)
		elseif data.current.value == 'wash_money' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'wash_money_amount_' .. society, {
				title = _U('wash_money_amount')
			}, function(data, menu)

				local amount = tonumber(data.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu.close()
					TriggerServerEvent('esx_society:washMoney', society, amount)
				end

			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'manage_employees' then
			OpenManageEmployeesMenu(society)
		elseif data.current.value == 'manage_job' then
				OpenManageJobMenu(society)
		elseif data.current.value == 'Divisionalireza' then
			OpenDivisonmenu()
			menu.close()
		end

	end, function(data, menu)
		if close then
			close(data, menu)
		end
	end)

end

function OpenManageJobMenu(society)
	if not InBossMenu then
		LastPosition = GetEntityCoords(PlayerPedId())
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_job' .. society, {
		title    = _U('manage_job'),
		 align    = 'center',
		elements = {
			{label = _U('salary_management'), value = 'manage_grades'},
			{label = _U('manage_grades_name'), value = 'manage_grades_name'},
			{label = _U('manage_grades_outfit'), value = 'manage_grades_outfit'},
			{label = _U('manage_weapons'), value = 'manage_weapons'},
			{label = _U('manage_vehicles'), value = 'manage_vehicles'},
			{label = _U('manage_inventory'), value = 'manage_inventory'},
		}
	}, function(data, menu)

		if data.current.value == 'manage_grades' then
			OpenManageGradesMenu(society)
		end
		
		if data.current.value == 'manage_grades_name' then
			OpenGradeNames(society)
		end

		if data.current.value == 'manage_grades_outfit' then
			OpenSetOutfitMenu(society)
		end

		-- if data.current.value == 'manage_division_addnew' then
		-- 	OpenDivision(society)
		-- end

		if data.current.value == 'manage_weapons' then
			if DoesHaveArmory(society) then
				OpenWeaponsManagment(society)
			else
				ESX.ShowNotification("Your job does not have armory")
			end
		end

		if data.current.value == 'manage_vehicles' then
			if DoesHaveGarage(society) then
				OpenVehiclesManagment(society)
			else
				ESX.ShowNotification("Your job does not have garage")
			end
		end

		if data.current.value == 'manage_inventory' then
			if DoesHaveInventory(society) then
				OpenInventoryManagment(society)
			else
				ESX.ShowNotification("Your job does not have inventory")
			end
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function OpenInventoryManagment(society)
	ESX.TriggerServerCallback('esx_society:getGrades', function(grades)
		local elements = {}
		  for k,v in pairs(grades) do
			  table.insert(elements, {label = v.label, grade = k})
		  end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. society .. '_new', {
            title = "Manage Grades",
            align    = 'center',
            elements = elements
        }, function(data, menu)
            local gradeNumber = tonumber(data.current.grade)
				ChangeInventoryPerm(society,gradeNumber)
		end, function(data1, menu1)
			menu1.close()
		end)
	end, society)
end

function ChangeInventoryPerm(society,rank)
	ESX.TriggerServerCallback('esx_society:getJobItems', function(authorizedItems)
		if authorizedItems then
			ESX.TriggerServerCallback('esx_society:getItems', function(items)
				local rows = {}
			
				for k, society_items in ipairs(authorizedItems) do
					local found = false
					
					if items then

						for k2, item_state in ipairs(items) do
							if string.lower(society_items.name) == string.lower(item_state.name) then
								if item_state.status == true then
									table.insert(rows, { label = society_items.label .. " | [<font color=Lime>Active</font>]", name = item_state.name, value = item_state.status })
								elseif item_state.status == false then
									table.insert(rows, { label = society_items.label .. " | [<font color=red>Deactivate</font>]", name = item_state.name, value = item_state.status })
								end

								found = true
								break
							end
						end
					end

					if not found then
						table.insert(rows, { label = society_items.label .. " | [<font color=red>Deactivate</font>]", name = society_items.name, value = false })
					end
				end
				ESX.UI.Menu.CloseAll()
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_Items_' .. society .. '', {
					title = "Manage Inventory",
					align    = 'center',
					elements = rows
				}, function(data, menu)
					local state = data.current.value
					local name = data.current.name
					if state then
						ESX.TriggerServerCallback('esx_society:setSocietyItemPerm', function(result)

							ChangeInventoryPerm(society,rank)

						end, society, rank, rows, false, name)
					else
						ESX.TriggerServerCallback('esx_society:setSocietyItemPerm', function(result)
							
							ChangeInventoryPerm(society,rank)

						end, society, rank, rows, true, name)
					end


				end, function(data, menu)
					menu.close()
				end)

			end, rank, society)
		else
			ESX.ShowNotification("Error loading Items !")
		end
	end, society)
end

function OpenVehiclesManagment(society)
	ESX.TriggerServerCallback('esx_society:getGrades', function(grades)
		local elements = {}
		  for k,v in pairs(grades) do
			  table.insert(elements, {label = v.label, grade = k})
		  end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. society .. '_new', {
            title = "Manage Grades",
            align    = 'center',
            elements = elements
        }, function(data, menu)
            local gradeNumber = tonumber(data.current.grade)
				ChangeVehiclePerm(society,gradeNumber)
		end, function(data1, menu1)
			menu1.close()
		end)
	end, society)
end

function ChangeVehiclePerm(society,rank)
	local authorizedVehicles = Config.Garage[society]
	if authorizedVehicles then
		ESX.TriggerServerCallback('esx_society:getVehicles', function(vehs)
			local rows = {}
		
			for k, society_vehicles in ipairs(authorizedVehicles) do
				local found = false
				
				if vehs then

					for k2, vehicle_state in ipairs(vehs) do
						if string.lower(society_vehicles) == string.lower(vehicle_state.model) then
							if GetDisplayNameFromVehicleModel(GetHashKey(vehicle_state.model)) then
								if vehicle_state.status == true then
									table.insert(rows, { label = GetDisplayNameFromVehicleModel(GetHashKey(vehicle_state.model)) .. " | [<font color=Lime>Active</font>]", model = vehicle_state.model, value = vehicle_state.status })
								elseif vehicle_state.status == false then
									table.insert(rows, { label = GetDisplayNameFromVehicleModel(GetHashKey(vehicle_state.model)) .. " | [<font color=red>Deactivate</font>]", model = vehicle_state.model, value = vehicle_state.status })
								end
							else
								table.insert(rows, { label = vehicle_state.model .. " | [<font color=yellow>Unknown</font>]", model = vehicle_state.model, value = vehicle_state.status })
							end

							found = true
							break
						end
					end
				end

				if not found then
					table.insert(rows, { label = GetDisplayNameFromVehicleModel(GetHashKey(society_vehicles)) .. " | [<font color=red>Deactivate</font>]", model = society_vehicles, value = false })
				end
			end
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_vehicles_' .. society .. '', {
				title = "Manage Vehicles",
				align    = 'center',
				elements = rows
			}, function(data, menu)
				local state = data.current.value
				local model = data.current.model
				if state then
					ESX.TriggerServerCallback('esx_society:setSocietyVehPerm', function(result)

						ChangeVehiclePerm(society,rank)

					end, society, rank, rows, false, model)
				else
					ESX.TriggerServerCallback('esx_society:setSocietyVehPerm', function(result)
						
						ChangeVehiclePerm(society,rank)

					end, society, rank, rows, true, model)
				end


			end, function(data, menu)
				menu.close()
			end)

		end, rank, society)
	else
		ESX.ShowNotification("Error loading Vehicles !")
	end
end

function OpenWeaponsManagment(society)
	ESX.TriggerServerCallback('esx_society:getGrades', function(grades)
		local elements = {}
		  for k,v in pairs(grades) do
			  table.insert(elements, {label = v.label, grade = k})
		  end
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. society .. '_new', {
            title = "Manage Grades",
            align    = 'center',
            elements = elements
        }, function(data, menu)
            local gradeNumber = tonumber(data.current.grade)
				ChangeWeaponPerm(society,gradeNumber)
		end, function(data1, menu1)
			menu1.close()
		end)
	end, society)
end

function ChangeWeaponPerm(society,rank)
	local authorizedWeapons = Config.Armory[society]
	if authorizedWeapons then
		ESX.TriggerServerCallback('esx_society:getWeapons', function(weapons)
			local rows = {}
		
			for k, society_weapons in ipairs(authorizedWeapons) do
				-- print(json.encode(society_weapons))
				local found = false

				if weapons then

					for k2, weapon_state in ipairs(weapons) do
						if string.lower(society_weapons) == string.lower(weapon_state.model) then
							if weapon_state.status == true then
								table.insert(rows, { label = GetModelLabel(weapon_state.model) .. " | [<font color=Lime>Active</font>]", model = weapon_state.model, value = weapon_state.status })
							elseif weapon_state.status == false then
								table.insert(rows, { label = GetModelLabel(weapon_state.model) .. " | [<font color=red>Deactivate</font>]", model = weapon_state.model, value = weapon_state.status })
							end

							found = true
							break
						end
					end
				end

				if not found then
					table.insert(rows, { label = GetModelLabel(society_weapons) .. " | [<font color=red>Deactivate</font>]", model = society_weapons, value = false })
				end
			end
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_weapons_' .. society .. '', {
				title = "Manage Weapons",
				align    = 'center',
				elements = rows
			}, function(data, menu)
				local state = data.current.value
				local model = data.current.model
				if state then
					ESX.TriggerServerCallback('esx_society:setSocietyWeapPerm', function(result)

						ChangeWeaponPerm(society,rank)

					end, society, rank, rows, false, model)
				else
					ESX.TriggerServerCallback('esx_society:setSocietyWeapPerm', function(result)
						
						ChangeWeaponPerm(society,rank)

					end, society, rank, rows, true, model)
				end


			end, function(data, menu)
				menu.close()
			end)

		end, rank, society)
	else
		ESX.ShowNotification("Error loading Weapons !")
	end
end

function OpenGradeNames(society)
	ESX.TriggerServerCallback('esx_society:getGrades', function(grades)
		  local elements = {}
		  
			for k,v in pairs(grades) do
				table.insert(elements, {label = v.label, grade = k})
			end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_name', {
			title    = _U('manage_grades_name'),
			 align    = 'center',
			elements = elements
		}, function(data, menu)

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'rename_grade', {
                title    = "Esm jadid rank ra vared konid",

			}, function(data2, menu2)
				
				if not data2.value then
					ESX.ShowNotification("Shoma dar ghesmat esm jadid chizi vared nakardid!")
					return
				end
	
				if data2.value:match("[^%w%s]") or data2.value:match("%d") then
					ESX.ShowNotification("~h~Shoma mojaz be vared kardan Special ~o~character ya adad nistid!")
					return
				end

				if string.len(ESX.Math.Trim(data2.value)) >= 3 and string.len(ESX.Math.Trim(data2.value)) <= 11 then
					menu2.close()
					menu.close()
					ESX.TriggerServerCallback('esx_society:renameGrade', function(refresh)
					end, tonumber(data.current.grade), data2.value)
					OpenGradeNames(society)
					ESX.ShowNotification("Changed to " .. data2.value)
				else
					ESX.ShowNotification("Tedad character esm grade bayad bishtar az 3 0 va kamtar az 11 ~o~character bashad!")
				end

            end, function (data2, menu2)
                menu2.close()
            end)
			
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenSetOutfitMenu(society)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_outfit' .. society, {
		title    = _U('manage_grades_outfit'),
		 align    = 'center',
		elements = {
			{label = 'Men', value = 'employee_man'},
			{label = 'Women', value = 'employee_woman'}
		}
	}, function(data, menu)

		if data.current.value == 'employee_man' then
			OpenOutfitM(society)
		end
		
		if data.current.value == 'employee_woman' then
			OpenOutfitF(society)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenOutfitM(society)
	ESX.TriggerServerCallback('esx_eden_clotheshop:job:checkPropertyDataStore', function(foundStore, foundJob)
		local elements = {}
		for i=1, #foundJob do
			table.insert(elements, {label = foundJob[i].label, value = foundJob[i].grade})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'job_ranks',
		{
			title = 'Baraye Kodom rank Set Shavad?',
			align = 'center',
			elements = elements
		}, function(data, menu)
			TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerServerEvent('esx_society:saveOutfit', data.current.value, skin)
			end)
			ESX.ShowNotification('Taghirat Baraye ' .. data.current.label .. ' Anjam Shod')
		end, function(data, menu)
			menu.close()
		end)
	end)

end

function OpenOutfitF(society)
	ESX.TriggerServerCallback('esx_society:getGrades', function(grades)
		local elements = {}
		
		  for k,v in pairs(grades) do
			  table.insert(elements, {label = '(' .. k .. ') | ' .. v.label, grade = k})
		  end
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_name', {
			title    = _U('manage_grades_outfit'),
			 align    = 'center',
			elements = elements
		}, function(data, menu)
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(myskin)
				ESX.TriggerServerCallback('esx_society:getEmployeclothes', function (skinjob)
					FastTravel(Config.TpCoords, Config.heading)
					if skinjob ~= nil then
						TriggerEvent('skinchanger:loadClothes', Config.FemaleDefault, skinjob)
					else
						TriggerEvent('skinchanger:loadSkin', Config.FemaleDefault)
					end
					Citizen.Wait(tonumber(100))
					TriggerEvent(tostring(Config.MenuSkintrigger), source)
					local WaitForSave = true
					while WaitForSave do
						if ESX.UI.Menu.IsOpen('default', 'esx_skin', 'skin') then
							Citizen.Wait(tonumber(1000))
						else
							TriggerEvent('skinchanger:getSkin', function(skin)
								ESX.TriggerServerCallback('esx_society:setUniform', function ()
								end, society, tonumber(data.current.grade),'female', skin)
							end)
							WaitForSave = false
							FastTravel(vector3(LastPosition.x, LastPosition.y, LastPosition.z))
							TriggerEvent('skinchanger:loadSkin', myskin)
							Citizen.Wait(tonumber(100))
							TriggerServerEvent('esx_skin:save', myskin)
						end
						Citizen.Wait(tonumber(1000))
					end
			end, tonumber(data.current.grade), 'female', society)
		end)

		  end, function(data, menu)
			menu.close()
		  end)
	end)

end

function OpenDepositMoney(society, close, options)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. society, {
		title = _U('deposit_amount')
	}, function(data, menu)

		local amount = tonumber(data.value)

		if amount == nil then
			ESX.ShowNotification(_U('invalid_amount'))
		else
			menu.close()
			TriggerServerEvent('esx_society:depositMoney', society, amount)
			OpenBossMenu(society, close, options)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenManageEmployeesMenu(society)
    if DoesHaveOffDuty(society) then 
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. society, {
			title    = _U('employee_management'),
			 align    = 'center',
			elements = {
				{label = 'List A\'aza', value = 'employee_list'},
				{label = 'List A\'aza(Off Duty)', value = 'employee_listoff'},
				{label = 'Estekhdam',       value = 'recruit'}
			}
		}, function(data, menu)

			if data.current.value == 'employee_list' then
				OpenEmployeeList(society)
			end
			
			if data.current.value == 'employee_listoff' then
				OpenEmployeeList('off' .. society)
			end

			if data.current.value == 'recruit' then
				OpenRecruitMenu(society)
			end

		end, function(data, menu)
			menu.close()
		end)
	else
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. society, {
			title    = _U('employee_management'),
			 align    = 'center',
			elements = {
				{label = 'List A\'aza', value = 'employee_list'},
				{label = 'Estekhdam',       value = 'recruit'}
			}
		}, function(data, menu)

			if data.current.value == 'employee_list' then
				OpenEmployeeList(society)
			end

			if data.current.value == 'recruit' then
				OpenRecruitMenu(society)
			end

		end, function(data, menu)
			menu.close()
		end)
	end
end

function OpenEmployeeList(society)

	ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)

		local elements = {
			head = {_U('employee'), _U('grade'), _U('actions')},
			rows = {}
		}

		for i=1, #employees, 1 do
			local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)

			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					gradeLabel,
					'({{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}'
				}
			})
		end

		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. society, elements, function(data, menu)
			local employee = data.data

			if data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(society, employee)
			elseif data.value == 'fire' then
				ESX.ShowNotification(_U('you_have_fired', employee.name))

				ESX.TriggerServerCallback('esx_society:setJob', function()
					OpenEmployeeList(society)
				end, employee.identifier, 'lumberjack', tonumber(0), 'fire')
			end
		end, function(data, menu)
			menu.close()
			OpenManageEmployeesMenu(society)
		end)

	end, society)

end

function OpenRecruitMenu(society)

	ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)

		local elements = {}

		for i=1, #players, 1 do
			if players[i].job.name ~= society then
				table.insert(elements, {
					label = players[i].name,
					value = players[i].source,
					name = players[i].name,
					identifier = players[i].identifier
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_' .. society, {
			title    = _U('recruiting'),
			 align    = 'center',
			elements = elements
		}, function(data, menu)

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. society, {
				title    = _U('do_you_want_to_recruit', data.current.name),
				 align    = 'center',
				elements = {
					{label = _U('no'),  value = 'no'},
					{label = _U('yes'), value = 'yes'}
				}
			}, function(data2, menu2)
				menu2.close()

				if data2.current.value == 'yes' then
					ESX.ShowNotification(_U('you_have_hired', data.current.name))

					ESX.TriggerServerCallback('esx_society:setJob', function()
						OpenRecruitMenu(society)
					end, data.current.identifier, society, tonumber(1), 'hire')
				end
			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end)

end

function OpenPromoteMenu(society, employee)

	ESX.TriggerServerCallback('esx_society:getJob', function(job)

		local elements = {}

		for i=tonumber(1), #job.grades, tonumber(1) do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			table.insert(elements, {
				label = gradeLabel,
				value = job.grades[i].grade,
				selected = (employee.job.grade == job.grades[i].grade)
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'promote_employee_' .. society, {
			title    = _U('promote_employee', employee.name),
			 align    = 'center',
			elements = elements
		}, function(data, menu)
			menu.close()
			ESX.ShowNotification(_U('you_have_promoted', employee.name, data.current.label))

			ESX.TriggerServerCallback('esx_society:setJob', function()
				OpenEmployeeList(society)
			end, employee.identifier, society, data.current.value, 'promote')
		end, function(data, menu)
			menu.close()
			OpenEmployeeList(society)
		end)

	end, society)

end

function OpenManageGradesMenu(society)

	ESX.TriggerServerCallback('esx_society:getJob', function(job)

		local elements = {}

		for i=tonumber(1), #job.grades, tonumber(1) do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(gradeLabel, _U('money_generic', ESX.Math.GroupDigits(job.grades[i].salary))),
				value = job.grades[i].grade
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. society, {
			title    = _U('salary_management'),
			 align    = 'center',
			elements = elements
		}, function(data, menu)

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. society, {
				title = _U('salary_amount')
			}, function(data2, menu2)

				local amount = tonumber(data2.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > Config.MaxSalary then
					ESX.ShowNotification(_U('invalid_amount_max'))
				else
					menu2.close()

					ESX.TriggerServerCallback('esx_society:setJobSalary', function()
						OpenManageGradesMenu(society)
					end, society, data.current.value, amount)
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end, society)

end

AddEventHandler(Config.OpenBossMenu, function(society, close, options)
	OpenBossMenu(society, close, options)
end)


--- checking job access
function DoesHaveArmory(job)
    local access = false
	if Config.Armory[job] then
		access = true
	end
    return access
end

function DoesHaveGarage(job)
	local access = false
		if Config.Garage[job] then
			access = true
		end
    return access
end

function DoesHaveInventory(job)
	local access = false
	for i,v in ipairs(Config.Inventory) do
		if v == job then
			access = true
			break
		end
	end
	return access
end

function DoesHaveOffDuty(job)
	local access = false
	for i,v in ipairs(Config.Offjobs) do
		if v == job then
			access = true
			break
		end
	end
	return access
end

--use teleport 
local invis = false
function FastTravel(coords, heading)

	local playerPed = PlayerPedId()
 


	DoScreenFadeOut(tonumber(800))



	while not IsScreenFadedOut() do

		Citizen.Wait(tonumber(500))

	end


	ESX.Game.Teleport(playerPed, coords, function()
		local otherPlayerPed = GetPlayerPed(GetPlayerFromServerId(serverId))
		DoScreenFadeIn(tonumber(800))

		if heading then

			SetEntityHeading(playerPed, tonumber(heading))

		end

			  if not invis then 
				FreezeEntityPosition(playerPed, true)
				NetworkSetEntityInvisibleToNetwork(playerPed, true)
				SetEntityNoCollisionEntity(otherPlayerPed, playerPed, true)
				invis = true
			  else
				FreezeEntityPosition(playerPed, false)
				NetworkSetEntityInvisibleToNetwork(playerPed, false)
				SetEntityNoCollisionEntity(otherPlayerPed, playerPed, false)
			  end

	end)

end
-- get weapon label
function GetModelLabel(name)
	local label = string.upper(string.gsub(name, 'WEAPON_', ''))
	label = string.gsub(label, '_', '')
	return label
end

RegisterNetEvent("At_job:joininjob")
AddEventHandler("At_job:joininjob", function(requestID)
	AskAbout(requestID)
end)

function AskAbout(requestID)
	ESX.UI.Menu.Open('question', GetCurrentResourceName(), 'jobss',
	{
		title 	 = 'Darkhast Ozviyat Dar Job',
		align    = 'center',
		question = "Aya Shoma Ba Tamom Ghavanin Marbot Be Organ Movafegh Hastid?",
		elements = {
			{label = 'Bale', value = 'yes'},
			{label = 'Kheyr', value = 'no'},
		}
	}, function(data, menu)
		if data.current.value == "yes" then
			TriggerServerEvent("........OO-_-00.......", requestID)
			menu.close()
		elseif data.current.value == "no" then 
			--TriggerServerEvent("", requestID)
			menu.close()
		end
	end)
end


function Openmenunew(society, amount)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_dalil_' .. society, {
		title = ('Dalil Vardashtan Money Ro Vared knid')
	}, function(data, menu)

		local dalil = data.value

		if dalil == nil then
			ESX.ShowNotification('Shoma Dar Baksh Dalil Chizi Vared Nakarde ed')
		else
			menu.close()
			TriggerServerEvent('esx_society:withdrawMoney', society, amount, dalil)
		end

	end, function(data, menu)
		menu.close()
	end)
end


function OpenDivisonmenu() 

	local elements = { 
		{label = 'Didan List Divison Ha',    value = 'L1'},
		{label = 'Delete Divison',   value = 'L2'},
		{label = 'Add Division',   value = 'L3'},
	  }
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'Division_System',
		{
		  title    = ('Division_System'),
		  align    = 'center',
		  elements = elements,
		},
	
		function(data, menu)
		    if data.current.value == 'L1' then
				Openshoedivison()
			  --TriggerServerEvent('esx_society:showactivediv', GetPlayerServerId(PlayerId()))
		    elseif data.current.value == 'L2' then
			 selectordiviison()
		    elseif data.current.value == 'L3' then
				Addednewdivision()
			  -- TriggerServerEvent('esx_society:Adddiv', GetPlayerServerId(PlayerId()))
		    end
		end)

end


function Openshoedivison()
	ESX.TriggerServerCallback('AliReza_show:Disvivon', function(division)



	end)
end




function selectordiviison()

	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'delete_Division', {
		title = 'Name Division Ro Vared Knid'
	}, function(data, menu)
		ESX.UI.Menu.CloseAll()
		local armorlevel = data.value
		print(armorlevel)
		TriggerServerEvent('AliReza_Delete:Disvivon', armorlevel)
		menu.close()
	end, function(data, menu)
		menu.close()
	end)

end



function Addednewdivision()

	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'add_Division', {
		title = 'Name Division Ro Vared Knid'
	}, function(data, menu)
		local jadidast = data.value
		ESX.UI.Menu.CloseAll()
		TriggerServerEvent('AliReza_add:Disvivon', jadidast)
		menu.close()
	end, function(data, menu)
		menu.close()
	end)


end
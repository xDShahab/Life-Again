ESX = nil



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

 	while ESX.GetPlayerData().gang == nil do
		Citizen.Wait(10)
	end

 	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
	ESX.PlayerData.gang = gang
end)



function OpenBossMenu(gang, close, options)
	local isBoss = nil
	local options  = options or {}
	local elements = {
		--{label = "Gang Tablet", value = 'tab'},
	}
	local gangMoney = nil



 	ESX.TriggerServerCallback('gangs:isBoss', function(result)
		isBoss = result
	end, gang)

 	while isBoss == nil do
		Citizen.Wait(100)
	end

 	if not isBoss then
		return
	end

	while gangMoney == nil do
		Citizen.Wait(1)
		ESX.TriggerServerCallback('gangs:getGangMoney', function(money)
			gangMoney = money
		end, ESX.PlayerData.gang.name)
		ESX.TriggerServerCallback('gangs:getGangArmory', function(armory)
			gangarmory = armory
		end, ESX.PlayerData.gang.name)
		ESX.TriggerServerCallback('gangs:getgangcolorid', function(color)
			gangcolorid = color
		end, ESX.PlayerData.gang.name)
	
	end
 	local defaultOptions = {
		withdraw  = true,
		deposit   = true,
		wash      = false,
		employees = true,
		grades    = true
	}

 	for k,v in pairs(defaultOptions) do
		if options[k] == nil then
			options[k] = v
		end
	end

	if options.withdraw then
		local formattedMoney = _U('locale_currency', ESX.Math.GroupDigits(gangMoney))
		table.insert(elements, {label = ('%s: <span style="color:green;">%s</span>'):format(_U('clean_money'), formattedMoney), value = 'withdraw_society_money'})
	end

 	if options.employees then
		table.insert(elements, {label = _U('employee_management'), value = 'manage_employees'})
	end

 	if options.grades then
		table.insert(elements, {label = _U('salary_management'), value = 'manage_grades'})
	end
	--table.insert(elements, {label = 'GAR', value = 'manage_gar'})
	table.insert(elements, {label = '============================	', value = 'kosnanat'})
	table.insert(elements, {label = '💱: Tanzime Webhook', value = 'manage_webhook'})
	table.insert(elements, {label = '📜: Taghire Name Rankha', value = 'rename_grades'})
	table.insert(elements, {label = '🔪: Armory Access  ', value = 'manage_armory'})
	table.insert(elements, {label = '🚗: Garag Access  ', value = 'garag_armory'})
	table.insert(elements, {label = '🧰: Armor Access  ', value = 'manage_armor'})
	table.insert(elements, {label = '👔: Posheshe Gang Access  ', value = 'manage_poshesh'})
	table.insert(elements, {label = '💊: Gang Menu(f5) Access  ', value = 'manage_gangmenu'})
	table.insert(elements, {label = '🔨: Crafting Access  ', value = 'manage_crafting'})
	table.insert(elements, {label = '💲: BoosAction Access  ', value = 'manage_boosaction'})

	

 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boss_actions_' .. gang, {
		title    = _U('boss_menu'),
		align    = 'center',
		elements = elements
	}, function(data, menu)

 		if data.current.value == 'withdraw_society_money' then
			OpenMoneyMenu(gang)
 		elseif data.current.value == 'manage_employees' then
			OpenManageEmployeesMenu(gang)
		elseif data.current.value == 'tab' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent('tab:spectate')		
		elseif data.current.value == 'manage_gar' then	
			Opnemgar(gang)
		elseif data.current.value == 'manage_grades' then
			OpenManageGradesMenu(gang)
			elseif data.current.value == 'manage_webhook' then
			OpenManageWebhook(gang)
			elseif data.current.value == 'manage_armory' then
			OpenManageArmoryAccess(gang)
			elseif data.current.value == 'rename_grades' then
			renamegrades()
		elseif data.current.value == 'forosh_mavad' then
			if ESX.PlayerData.gang.name == 'Cartell' then
			 ForshmavadEndless_cartel (gang)
			else
				ESX.ShowNotification('In Ghabeliyat Baray Cartell  Mibashad')
			end
			elseif data.current.value == 'manage_garage' then
			OpenManageGarageAccess(gang)
			elseif data.current.value == 'changegangcolor' then
			OpenMenuColor(ESX.PlayerData.gang.name)
		elseif data.current.value == 'manage_crafting' then
			OpenManagecraftingAccess(gang)
		elseif data.current.value == 'garag_armory' then
			Opengangveh(gang)
		elseif data.current.value == 'manage_armor' then
			Opengangarmor(gang)
		elseif data.current.value == 'manage_poshesh' then
			Setclotrank(gang)
		elseif data.current.value == 'manage_gangmenu' then
			Setgangmenuopeneed(gang)
		elseif data.current.value == 'manage_boosaction' then
			Openboosmenu(gang)
		elseif data.current.value == 'manage_capturejoin' then
			Openselectcapturerank(gang)
		end

 	end, function(data, menu)
		if close then
			close(data, menu)
		end
	end)

end



---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------


function Openselectcapturerank(gang)

	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_capture', {
		title = 'Ranke Access Be Vared Shodan Be Capture Ra Vared Konid'
	}, function(data, menu)
		local caplevel = tonumber(data.value)
		if caplevel > 0 and caplevel < 6 then
		ESX.UI.Menu.CloseAll()
			TriggerServerEvent('Gang_Select:Captureacc', caplevel)
			OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function Openboosmenu(gang)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_boss', {
		title = 'Ranke Access Be BossAction Ra Vared Konid'
	}, function(data, menu)
		local bosslevel = tonumber(data.value)
		if bosslevel > 0 and bosslevel < 6 then
		ESX.UI.Menu.CloseAll()
			TriggerServerEvent('Gang_Select:Bossaction', bosslevel)
			OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)

end

function Setgangmenuopeneed(gang)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_menugang', {
		title = 'Ranke Access Be Menu Gang Ra Vared Konid'
	}, function(data, menu)
		local menuperm = tonumber(data.value)
		if menuperm > 0 and menuperm < 6 then
		ESX.UI.Menu.CloseAll()
			TriggerServerEvent('Gang_Select:Menugang', menuperm)
			OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function Setclotrank(gang)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_lebas', {
		title = 'Ranke Access Be Lebas Poshidan Ra Vared Konid'
	}, function(data, menu)
		local lebasperm = tonumber(data.value)
		if lebasperm > 0 and lebasperm < 6 then
		ESX.UI.Menu.CloseAll()
			TriggerServerEvent('Gang_Select:Lebas', lebasperm)
			OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function Opengangveh(gang)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_garag', {
		title = 'Ranke Access Be Garag Ra Vared Konid'
	}, function(data, menu)
		local garagelevel = tonumber(data.value)
		if garagelevel > 0 and garagelevel < 6 then
		ESX.UI.Menu.CloseAll()
			TriggerServerEvent('Gang_Select:Garag', garagelevel)
			OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function Opengangarmor(gang)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_vest', {
		title = 'Ranke Access Be PoshidanVest Ra Vared Konid'
	}, function(data, menu)
		local armorlevel = tonumber(data.value)
		if armorlevel > 0 and armorlevel < 6 then
		ESX.UI.Menu.CloseAll()
			TriggerServerEvent('Gang_Select:Vest', armorlevel)
			OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end



---------------------------------------------------------------------------------------------------------------------------------------------

function OpenWeaponmenu() 
	local elements = { 
        {label = 'Pistol50     -Sang > 20',    value = 'Pistol50'},
        {label = 'Micro Smg    -Sang > 25',   value = 'micro'},
        {label = 'SMG          -Sang > 30',   value = 'smg'},
        {label = 'Carbinerifle -Sang > 40',   value = 'carbinerifle'},
      }
      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'By_Weapon',
        {
          title    = ('By_Weapon'),
           align    = 'center',
          elements = elements,
        },

        function(data, menu)
			if data.current.value == 'Pistol50' then
				TriggerServerEvent('Gang_Mafia:Pistol50', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'micro' then
				TriggerServerEvent('Gang_Mafia:micro', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'smg' then
				TriggerServerEvent('Gang_Mafia:smg', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'carbinerifle' then
				TriggerServerEvent('Gang_Mafia:carbinerifle', GetPlayerServerId(PlayerId()))
			end
        end)
end


function ForshmavadEndless_cartel ()
	local elements = { 
        {label = 'Marijuana     -$8K',    value = 'marijuana'},
        {label = 'Crack        -$6K',   value = 'meth'},
        {label = 'Kokayin         -$4K',   value = 'crack'},
		{label = '---------------------------',   value = 'carbinerifl13e'},
		{label = 'LSD   -->>> 5 Sang',   value = 'lsd'},
      }

    
      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'Forosh_Mavad',
        {
          title    = ('Cartel_Menu'),
           align    = 'center',
          elements = elements,
        },

        function(data, menu)
			if data.current.value == 'marijuana' then
				TriggerServerEvent('Gang_Endless_cartel:marijuana', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'meth' then
				TriggerServerEvent('Gang_Endless_cartel:Crack', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'crack' then
				TriggerServerEvent('Gang_Endless_cartel:cocaine', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'Cocaine' then
				TriggerServerEvent('Gang_Endless_cartel:Cocaine', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'heroine' then
				TriggerServerEvent('Gang_Endless_cartel:Heroine', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'lsd' then
				TriggerServerEvent('Gang_lsd:addkiralireza', GetPlayerServerId(PlayerId()))
			end
        end)

end



function renamegrades()
	ESX.TriggerServerCallback('gang:getGrades', function(grades)
		  local elements = {}
			for k,v in pairs(grades) do
				table.insert(elements, {label = '(' .. k .. ') | ' .. v.label, grade = k})
			end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'show_grade_list', {
			title    = 'Gang Grades',
			align    = 'center',
			elements = elements
		}, function(data, menu)
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'rename_grade', {
                title    = "Esm Jadid Rank Ra Vared Konin.",
			}, function(data2, menu2)
				if not data2.value then
					ESX.ShowNotification("In Bakhsh Nemitavanad Khali Bashad.")
					return
				end
				if data2.value:match("[^%w%s]") or data2.value:match("%d") then
					ESX.ShowNotification("Az Special Character Nemitavan Estefade Kard.")
					return
				end
				if string.len(ESX.Math.Trim(data2.value)) >= 3 and string.len(ESX.Math.Trim(data2.value)) <= 11 then
					ESX.TriggerServerCallback('gangs:renameGrade', function(result)
						menu2.close()
						if result then
							menu.close()
							renamegrades()
						end
					end, data.current.grade, data2.value)
				else
					ESX.ShowNotification("Tedad Character Ha Bayad Az 3 Bishtar Va Az 11 Kamtar Bashad.")
				end
            end, function (data2, menu2)
                menu2.close()
            end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end
function OpenManageEmployeesMenu(gang)

 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_employees_' .. gang, {
		title    = _U('employee_management'),
		align    = 'center',
		elements = {
			{label = _U('employee_list'), value = 'employee_list'},
			{label = _U('recruit'),       value = 'recruit'}
		}
	}, function(data, menu)

 		if data.current.value == 'employee_list' then
			OpenEmployeeList(gang)
		end

 		if data.current.value == 'recruit' then
			OpenRecruitMenu(gang)
		end

 	end, function(data, menu)
		menu.close()
	end)
end

function OpenMoneyMenu(gang)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'money_manage_' .. gang, {
	   title    = _U('money_management'),
	   align    = 'center',
	   elements = {
		   {label = _U('withdraw_money'), 	value = 'withdraw_money'},
		   {label = _U('deposit_money')	,  	value = 'deposit_money'}
	   }
   	}, function(data, menu)

		if data.current.value == 'withdraw_money' then
			
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. gang, {
				title = _U('withdraw_money')
			}, function(data, menu)

 				local amount = tonumber(data.value)

 				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('gangs:withdrawMoney', gang, amount)
					OpenBossMenu(gang, close, options)
				end

 			end, function(data, menu)
				menu.close()
			end)

		elseif data.current.value == 'deposit_money' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. gang, {
				title = _U('deposit_money')
			}, function(data, menu)
 
				 local amount = tonumber(data.value)
 
				 if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('gangs:depositMoney', gang, amount)
					OpenBossMenu(gang, close, options)
				end
 
			 end, function(data, menu)
				menu.close()
			end)

	   	end

	end, function(data, menu)
	   menu.close()
   end)
end



function OpenManagecraftingAccess(gang)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_armory', {
		title = 'Ranke Access Be Craftig Ra Vared Konid'
	}, function(data, menu)
		local armoryaclevel = tonumber(data.value)
		if armoryaclevel > 0 and armoryaclevel < 6 then
		ESX.UI.Menu.CloseAll()
			TriggerServerEvent('gangs:Setcraftingac', armoryaclevel)
			OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenEmployeeList(gang)

 	ESX.TriggerServerCallback('gangs:getEmployees', function(employees)

 		local elements = {
			head = {_U('employee'), _U('grade'), _U('actions')},
			rows = {}
		}

 		for i=1, #employees, 1 do
			local gradeLabel = (employees[i].gang.grade_label == '' and employees[i].gang.label or employees[i].gang.grade_label)

 			table.insert(elements.rows, {
				data = employees[i],
				cols = {
					employees[i].name,
					gradeLabel,
					'{{' .. _U('promote') .. '|promote}} {{' .. _U('fire') .. '|fire}}'
				}
			})
		end

 		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'employee_list_' .. gang, elements, function(data, menu)
			local employee = data.data

 			if data.value == 'promote' then
				menu.close()
				OpenPromoteMenu(gang, employee)
			elseif data.value == 'fire' then
				ESX.ShowNotification(_U('you_have_fired', employee.name))

 				ESX.TriggerServerCallback('gangs:setGang', function()
					OpenEmployeeList(gang)
				end, employee.identifier, 'nogang', 0, 'fire')
			end
		end, function(data, menu)
			menu.close()
			OpenManageEmployeesMenu(gang)
		end)

 	end, gang)

end


local hu = true
function Setplayer(source)
	if hu then
		hu = false
		return
	end
end



function OpenRecruitMenu(gang)
	ESX.TriggerServerCallback('Gang:SetSlot', function(flag)
		Wait(200)
		if flag ~= nil and not flag then
			ESX.ShowNotification('Slot gang shoma takmil shode ast.')
			return
		else
			ESX.TriggerServerCallback('gangs:getOnlinePlayers', function(players)

				local elements = {}

				for i=1, #players, 1 do
				if players[i].gang.name ~= gang then
					table.insert(elements, {
						label = players[i].name,
						value = players[i].source,
						name = players[i].name,
						identifier = players[i].identifier
					})
				end
			end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_' .. gang, {
				title    = _U('recruiting'),
				align    = 'center',
				elements = elements
			}, function(data, menu)

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'recruit_confirm_' .. gang, {
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

							ESX.TriggerServerCallback('gangs:setGang', function()
							OpenRecruitMenu(gang)
						end, data.current.identifier, gang, 1, 'hire')
					end
				end, function(data2, menu2)
					menu2.close()
				end)

				end, function(data, menu)
				menu.close()
			end)

			end)
		end
	end, ESX.PlayerData.gang.name)
end


function OpenPromoteMenu(gangname, employee)

 	ESX.TriggerServerCallback('gangs:getGang', function(gang)

 		local elements = {}

 		for i=1, #gang.grades, 1 do
			local gradeLabel = (gang.grades[i].label == '' and gang.label or gang.grades[i].label)

 			table.insert(elements, {
				label = gradeLabel,
				value = gang.grades[i].grade,
				selected = (employee.gang.grade == gang.grades[i].grade)
			})
		end

 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'promote_employee_' .. gangname, {
			title    = _U('promote_employee', employee.name),
			align    = 'center',
			elements = elements
		}, function(data, menu)
			menu.close()
			ESX.ShowNotification(_U('you_have_promoted', employee.name, data.current.label))

 			ESX.TriggerServerCallback('gangs:setGang', function()
				OpenEmployeeList(gangname)
			end, employee.identifier, gangname, data.current.value, 'promote')
		end, function(data, menu)
			menu.close()
			OpenEmployeeList(gangname)
		end)

 	end, gangname)

end


			function OpenManageGarageAccess(gang)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_armory', {
		title = 'Rank Access Be Garage'
	}, function(data, menu)
		local armoryaclevel = tonumber(data.value)
		if armoryaclevel > 0 and armoryaclevel < 6 then
		ESX.UI.Menu.CloseAll()
					TriggerServerEvent('gangs:SetgarageAccess', armoryaclevel)
					OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
			
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end



RegisterNetEvent('Aliat:createmenu')
AddEventHandler('Aliat:createmenu',function(gang)
OpenBossMenu(gang, close, options)
 ESX.UI.Menu.CloseAll()
OpenBossMenu(gang, close, options)
end)
function OpenManageArmoryAccess(gang)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_armory', {
		title = 'Ranke Access Be Armory'
	}, function(data, menu)
		local armoryaclevel = tonumber(data.value)
		if armoryaclevel > 0 and armoryaclevel < 6 then
		ESX.UI.Menu.CloseAll()
			TriggerServerEvent('gangs:SetArmoryAccess', armoryaclevel)
			OpenBossMenu(gang, close, options)
					ESX.UI.Menu.CloseAll()
					else
					ESX.ShowNotification('Rank Bayad Beyne 1-6 Bashad.')
					end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end
function OpenManageWebhook()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_webhook', {
		title = 'WebHook Discord Ro Vared Konid'
	}, function(data, menu)
		local webhook = data.value
		if string.find(webhook, "/api/webhooks/") then
			local id = string.gsub(webhook, "", "")
			TriggerServerEvent('gangs:SetWebHookLog', id)
		else
			ESX.ShowNotification('Webhook ro eshtebah Vared Kardid,')
		end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end
function OpenManageGradesMenu(gangname)

 	ESX.TriggerServerCallback('gangs:getGang', function(gang)

 		local elements = {}

 		for i=1, #gang.grades, 1 do
			local gradeLabel = (gang.grades[i].label == '' and gang.label or gang.grades[i].label)

 			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(gradeLabel, _U('money_generic', ESX.Math.GroupDigits(gang.grades[i].salary))),
				value = gang.grades[i].grade
			})
		end

 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_grades_' .. gang.name, {
			title    = _U('salary_management'),
			align    = 'center',
			elements = elements
		}, function(data, menu)

 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'manage_grades_amount_' .. gang.name, {
				title = _U('salary_amount')
			}, function(data2, menu2)

 				local amount = tonumber(data2.value)

 				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				elseif amount > Config.MaxSalary then
					ESX.ShowNotification(_U('invalid_amount_max'))
				else
					menu2.close()

 					ESX.TriggerServerCallback('gangs:setGangSalary', function()
						OpenManageGradesMenu(gangname)
					end, gang, data.current.value, amount)
				end

 			end, function(data2, menu2)
				menu2.close()
			end)

 		end, function(data, menu)
			menu.close()
		end)

 	end, gangname)

end

AddEventHandler('gangs:openBossMenu', function(gang, close, options)
	OpenBossMenu(gang, close, options)
end)



function Opnemgar()
	ESX.TriggerServerCallback('AliReza:GetGangPoweer', function(power)
        local elements = { 
            {label = '<b><span style="color:yellow;">Your GPower  : '..power..'</span></b>',    value = 'online'},
            {label = '<b><span style="color:yellow;">====================</span></b>',   value = '..'},
            {label = '<b><span style="color:yellow;">🛒Kharid GAR</span></b>',   value = 'by'},
        }
    
        
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'Selector_Menu',
            {
              title    = ('Selector_Menu'),
              align    = 'center',
              elements = elements,
            },
    
            function(data, menu)
                if data.current.value == 'by' then
					Selectzon()
                elseif data.current.value == 'online' or '..' then
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                end
            end)
    end)
end



function Selectzon()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'select_zone', {
		title = 'Zoni ke Mikkhayn Bekharid ro Vared Knid'
	}, function(data, menu)
		local zone = data.value
		if zone > 0 and zone< 6 then
			TriggerServerEvent('At_Creatingzon', GetPlayerServerId(PlayerId()),  zone)
			ESX.UI.Menu.CloseAll()
		else
			ESX.ShowNotification('Zoni Ba In id Vojod Nadarad .')
		end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end


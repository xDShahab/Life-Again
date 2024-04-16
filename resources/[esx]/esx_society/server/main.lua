ESX = nil
local Jobs = {}
local RegisteredSocieties = {}


TriggerEvent(Config.ESXtrigger, function(obj) ESX = obj end)

function GetSociety(name)
	for i=tonumber(1), #RegisteredSocieties, tonumber(1) do
		if RegisteredSocieties[i].name == name then
			return RegisteredSocieties[i]
		end
	end
end

MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

	for i=tonumber(1), #result, tonumber(1) do
		Jobs[result[i].name]        = result[i]
		Jobs[result[i].name].grades = {}
	end

	local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

	for i=tonumber(1), #result2, tonumber(1) do
		Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
	end
	
end)
 
AddEventHandler('esx_society:registerSociety', function(name, label, account, datastore, inventory, data)
	local found = false

	local society = {
		name      = name,
		label     = label,
		account   = account,
		datastore = datastore,
		inventory = inventory,
		data      = data,
	}

	for i=1, #RegisteredSocieties, 1 do
		if RegisteredSocieties[i].name == name then
			found = true
			RegisteredSocieties[i] = society
			break
		end
	end

	if not found then
		table.insert(RegisteredSocieties, society)
	end
end)

AddEventHandler('esx_society:getSocieties', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('esx_society:getSociety', function(name, cb)
	cb(GetSociety(name))
end)

--withdraw get money
RegisterServerEvent('esx_society:withdrawMoney')
AddEventHandler('esx_society:withdrawMoney', function(society, amount, dalil)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))

	if xPlayer.job.name ~= society.name then
		print(('esx_society: %s Talash Baray Cheat Zadan --->   '):format(xPlayer.identifier))
		return
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
		if tonumber(amount) > tonumber(0) and tonumber(account.money) >= tonumber(amount) then
			account.removeMoney(tonumber(amount))
			xPlayer.addMoney(tonumber(amount))
			SendLog(amount, dalil)
			TriggerClientEvent('esx:ShowNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		else
			TriggerClientEvent('esx:ShowNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)


RegisterServerEvent('esx_society:saveOutfit')
AddEventHandler('esx_society:saveOutfit', function(grade, skin)
	local xPlayer = ESX.GetPlayerFromId(source)
	if skin.sex == 0 then
		TriggerEvent('ChangeJobSkin', xPlayer.job.name, grade, true, skin)
		exports.ghmattimysql:execute('UPDATE job_grades SET skin_male = @skin WHERE (job_name = @gang AND grade = @grade)',{
			['skin']  = json.encode(skin),
			['gang']  = xPlayer.job.name,
			['grade'] = grade
		})
	else
		TriggerEvent('ChangeJobSkin', xPlayer.job.name, grade, false, skin)
		exports.ghmattimysql:execute('UPDATE job_grades SET skin_female = @skin WHERE (job_name = @gang AND grade = @grade)',{
			['skin']  = json.encode(skin),
			['gang']  = xPlayer.job.name,
			['grade'] = grade
		})
	end

end)

--deposit get money
RegisterServerEvent('esx_society:depositMoney')
AddEventHandler('esx_society:depositMoney', function(society, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = GetSociety(society)
	amount = ESX.Math.Round(tonumber(amount))
	--------------------------------------------------------------------------------------------
	--if xPlayer.job.name ~= society.name then
	--	print(('esx_society: %s attempted to call depositMoney!'):format(xPlayer.identifier))
	--	return
	--end
	--------------------------------------------------------------------------------------------
	if amount > 0 and xPlayer.money >= amount then
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
			xPlayer.removeMoney(tonumber(amount))
			account.addMoney(tonumber(amount))
		end)

		TriggerClientEvent('esx:ShowNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))
	else
		TriggerClientEvent('esx:ShowNotification', xPlayer.source, _U('invalid_amount'))
	end
end)

-- RegisterServerEvent('esx_society:putVehicleInGarage')
-- AddEventHandler('esx_society:putVehicleInGarage', function(societyName, vehicle)
-- 	local society = GetSociety(societyName)

-- 	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
-- 		local garage = store.get('garage') or {}

-- 		table.insert(garage, vehicle)
-- 		store.set('garage', garage)
-- 	end)
-- end)

-- RegisterServerEvent('esx_society:removeVehicleFromGarage')
-- AddEventHandler('esx_society:removeVehicleFromGarage', function(societyName, vehicle)
-- 	local society = GetSociety(societyName)

-- 	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
-- 		local garage = store.get('garage') or {}

-- 		for i=1, #garage, 1 do
-- 			if garage[i].plate == vehicle.plate then
-- 				table.remove(garage, i)
-- 				break
-- 			end
-- 		end

-- 		store.set('garage', garage)
-- 	end)
-- end)

-- get money count
ESX.RegisterServerCallback('esx_society:getSocietyMoney', function(source, cb, societyName)
	local society = GetSociety(societyName)

	if society then
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
			cb(account.money)
		end)
	else
		cb(tonumber(0))
	end
end)

-- get employees of job
ESX.RegisterServerCallback('esx_society:getEmployees', function(source, cb, society)
	if Config.EnableESXIdentity then

		MySQL.Async.fetchAll('SELECT playerName, identifier, job, job_grade FROM users WHERE job = @job ORDER BY job_grade DESC', {
			['@job'] = society
		}, function (results)
			local employees = {}

			for i=1, #results, 1 do
				if results[i].job_grade < tonumber(0) then
					results[i].job_grade = results[i].job_grade * tonumber(-1)
				end
				table.insert(employees, {
					name       = string.gsub(results[i].playerName, "_", " " ),
					identifier = results[i].identifier,
					job = {
						name        = results[i].job,
						label       = Jobs[results[i].job].label,
						grade       = results[i].job_grade,
						grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
						grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label
					}
				})
			end

			cb(employees)
		end)
	else
		MySQL.Async.fetchAll('SELECT name, identifier, job, job_grade FROM users WHERE job = @job ORDER BY job_grade DESC', {
			['@job'] = society
		}, function (result)
			local employees = {}

			for i=tonumber(1), #result, tonumber(1) do
				table.insert(employees, {
					name       = result[i].name,
					identifier = result[i].identifier,
					job = {
						name        = result[i].job,
						label       = Jobs[result[i].job].label,
						grade       = result[i].job_grade,
						grade_name  = Jobs[result[i].job].grades[tostring(result[i].job_grade)].name,
						grade_label = Jobs[result[i].job].grades[tostring(result[i].job_grade)].label
					}
				})
			end

			cb(employees)
		end)
	end
end)

-- get player job
ESX.RegisterServerCallback('esx_society:getJob', function(source, cb, society)
	local job    = json.decode(json.encode(Jobs[society]))
	local grades = {}

	for k,v in pairs(job.grades) do
		table.insert(grades, v)
	end

	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	job.grades = grades

	cb(job)
end)

-- set player job
ESX.RegisterServerCallback('esx_society:setJob', function(source, cb, identifier, job, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'boss'

	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)
		Citizen.CreateThread(function() 
			MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
			{
				['@identifier'] = identifier
	
			}, function(data)
				local qlevel = data[1].level 	
				--if qlevel >= 2 then
					if xTarget then
						xTarget.setJob(job, grade)
						TriggerClientEvent('chatMessage', source, "^1[SYSTEM] : ^2Shoma^4"..GetPlayerName(xTarget.source).. "^2Ra Be Rank^4" ..grade.. "^2Invite Kardid")
						TriggerClientEvent('chatMessage', xTarget.source, "[SYSTEM]", {255, 0, 0}, "^0Shoma Tavasot ^2 " .. GetPlayerName(source) .. "^3Be Rank (" .. grade .. ") ^0Job ("..job.. ") Peyvastid.")
						if type == 'hire' then
							TriggerClientEvent('esx:ShowNotification', xTarget.source, _U('you_have_been_hired', job))
						elseif type == 'promote' then
							TriggerClientEvent('esx:ShowNotification', xTarget.source, _U('you_have_been_promoted'))
						elseif type == 'fire' then
							TriggerClientEvent('esx:ShowNotification', xTarget.source, _U('you_have_been_fired', xTarget.job.label))
						end

						cb()
					else
						MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
							['@job']        = job,
							['@job_grade']  = grade,
							['@identifier'] = identifier
						}, function(rowsChanged)
							cb()
						end)
					end
				--else 
					--TriggerClientEvent('esx:showNotification', xTarget.source, 'Baray Ozv Shodan Dar Job Bayad Level Shoma Bishatar Az 3  Bashad')
				--	TriggerClientEvent('esx:showNotification', source, 'Baray Ozv Shodan Dar Job Bayad Level Target Shoma Bishatar Az 3  Bashad')
				--end
			end)
		end)
	else
		print(('esx_society: %s attempted to setJob'):format(xPlayer.identifier))
		cb()
	end
end)






ESX.RegisterServerCallback('esx_society:setJobSalary', function(source, cb, job, grade, salary)
	local isBoss = isPlayerBoss(source, job)
	local identifier = GetPlayerIdentifier(source, tonumber(0))

	if isBoss then
		if salary <= Config.MaxSalary then
			MySQL.Async.execute('UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade', {
				['@salary']   = salary,
				['@job_name'] = job,
				['@grade']    = grade
			}, function(rowsChanged)
				Jobs[job].grades[tostring(grade)].salary = salary
				local xPlayers = ESX.GetPlayers()

				for i=tonumber(1), #xPlayers, tonumber(1) do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

					if xPlayer.job.name == job and xPlayer.job.grade == grade then
						xPlayer.setJob(job, grade)
					end
				end

				cb()
			end)
		else
			print(('esx_society: %s attempted to setJobSalary over config limit!'):format(identifier))
			cb()
		end
	else
		print(('esx_society: %s attempted to setJobSalary'):format(identifier))
		cb()
	end
end)


--- Geting online players and information
ESX.RegisterServerCallback('esx_society:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

	for i=tonumber(1), #xPlayers, tonumber(1) do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name,
			job        = xPlayer.job
		})
	end

	cb(players)
end)

-- ESX.RegisterServerCallback('esx_society:getVehiclesInGarage', function(source, cb, societyName)
-- 	local society = GetSociety(societyName)

-- 	TriggerEvent('esx_datastore:getSharedDataStore', society.datastore, function(store)
-- 		local garage = store.get('garage') or {}
-- 		cb(garage)
-- 	end)
-- end)

--Get boolean for isboss
ESX.RegisterServerCallback('esx_society:isBoss', function(source, cb, job)
	cb(isPlayerBoss(source, job))
end)
--checking player
function isPlayerBoss(playerId, job)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer.job.name == job and xPlayer.job.grade_name == 'boss' then
		return true
	else
		print(('esx_society: %s attempted open a society boss menu!'):format(xPlayer.identifier))
		return false
	end
end
-- get job garades
ESX.RegisterServerCallback('esx_society:getGrades', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(ESX.GetJob(xPlayer.job.name).grades)

end)
-- updating Grade names in DB and table
ESX.RegisterServerCallback('esx_society:renameGrade', function(source, cb, grade, name)
	local _source, grade, name = source, grade, name
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == "unemployed" then
		cb(false)
		print(('esx_society: %s "Tried to rename job label"!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.job.grade_name == 'boss' then
		if ESX.SetJobGrade(xPlayer.job.name, grade, name) then

			local xPlayers = ESX.GetPlayers()

			for i=tonumber(1), #xPlayers, tonumber(1) do
				local Member = ESX.GetPlayerFromId(xPlayers[i])

				if Member.job.name == xPlayer.job.name and Member.job.grade == grade then


					Member.setJob(xPlayer.job.name, grade)
				end

			end

			cb(true)
		else
			cb(false)
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {tonumber(255), tonumber(0), tonumber(0)}, " ^0Khatayi dar avaz kardan esm job grade shoma pish amad be developer etelaa dahid!")
		end
	else
		cb(false)	
		print(("Tried to rename " .. xPlayer.job.name .. " grade without boss level"):format(xPlayer.identifier))
	end

end)

-- geting permissions from tables
ESX.RegisterServerCallback('esx_society:getUniforms', function(source, cb, rank, job)
	local fskin = {}
	local mskin = {}
	fskin       = json.decode(Jobs[job].grades[tostring(rank)].skin_female)
	mskin       = json.decode(Jobs[job].grades[tostring(rank)].skin_male)
	if mskin == nil or mskin == '' or fskin == nil or fskin == '' then
		TriggerClientEvent('esx:ShowNotification', source, 'Please set garades options in boss action')
	end

		cb(mskin, fskin)

end)

ESX.RegisterServerCallback('esx_society:getWeapons', function(source, cb, rank, job)
	local weapon       = (Jobs[job].grades[tostring(rank)].weapons)
	if weapon == nil or weapon == '' then
		TriggerClientEvent('esx:ShowNotification', source, 'Please set garades options in boss action')
	end
	cb(json.decode(weapon))
end)

ESX.RegisterServerCallback('esx_society:getVehicles', function(source, cb, rank, job)
	local veh       = (Jobs[job].grades[tostring(rank)].vehicles) --bug Dareh 
	if veh == nil or veh == '' then
		TriggerClientEvent('esx:ShowNotification', source, 'Please set garades options in boss action')
	end
	cb(json.decode(veh))
end)

ESX.RegisterServerCallback('esx_society:getItems', function(source, cb, rank, job)
	local item       = (Jobs[job].grades[tostring(rank)].items)
	if item == nil or item == '' then
		TriggerClientEvent('esx:ShowNotification', source, 'Please set garades options in boss action')
	end
	cb(json.decode(item))
end)

ESX.RegisterServerCallback('esx_society:getJobItems', function(source, cb, job)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_society:getEmployeclothes', function(source, cb, rank, gender, job)
	local fskin = {}
	local mskin = {}
	fskin       = json.decode(Jobs[job].grades[tostring(rank)].skin_female)
	mskin       = json.decode(Jobs[job	].grades[tostring(rank)].skin_male)
		local xPlayers = ESX.GetPlayers()

		for i=tonumber(1), #xPlayers, tonumber(1) do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer.job.name == job and xPlayer.job.grade == rank then
				xPlayer.setJob(job, rank)
			end
		end

	if gender == 'male' then
		cb(mskin)
	elseif  gender == 'female' then 
		cb(fskin)
	end

end)
-- updating DB and tables
ESX.RegisterServerCallback('esx_society:setSocietyItemPerm', function(source, cb, job, rank, items, status, choice)
	local identifier = GetPlayerIdentifier(source, tonumber(0))
	local isBoss = isPlayerBoss(source, job)
	local itemtable = {}
	if isBoss then
		for _, item in ipairs(items) do
			if item.name ~= choice then
				table.insert(itemtable,{
					name = item.name,
					status = item.value
				})
			else
				table.insert(itemtable,{
					name = item.name,
					status = status
				})
			end
		end
		Jobs[job].grades[tostring(rank)].items = json.encode(itemtable)
		MySQL.Async.execute('UPDATE job_grades SET items = @items WHERE job_name = @job_name AND grade = @grade', {
			['@items']   = json.encode(itemtable),
			['@job_name'] = job,
			['@grade']    = rank
		}, function(rowsChanged)
			cb(true)
		end)
	else
		print(('esx_society: %s attempted to setSocietyVehPerm'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('esx_society:setSocietyWeapPerm', function(source, cb, job, rank, weapons, status, choice)
	local isBoss = isPlayerBoss(source, job)
	local identifier = GetPlayerIdentifier(source, tonumber(0))
	local weapontable = {}
	if isBoss then
		for _, weapon in ipairs(weapons) do
			if weapon.model ~= choice then
				table.insert(weapontable,{
					model = weapon.model,
					status = weapon.value
				})
			else
				if status then
					table.insert(weapontable,{
						model = weapon.model,
						status = true
					})
				else
					table.insert(weapontable,{
						model = weapon.model,
						status = false
					})
				end
			end
		end
		Jobs[job].grades[tostring(rank)].weapons = json.encode(weapontable)
		MySQL.Async.execute('UPDATE job_grades SET weapons = @weapons WHERE job_name = @job_name AND grade = @grade', {
			['@weapons']   = json.encode(weapontable),
			['@job_name'] = job,
			['@grade']    = rank
		}, function(rowsChanged)
			cb(true)
		end)
	else
		print(('esx_society: %s attempted to setSocietyVehPerm'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('esx_society:setSocietyVehPerm', function(source, cb, job, rank, vehs, status, choice)
	local isBoss = isPlayerBoss(source, job)
	local identifier = GetPlayerIdentifier(source, tonumber(0))
	local vehtable = {}
	if isBoss then
		for _, veh in ipairs(vehs) do
			if veh.model ~= choice then
				table.insert(vehtable,{
					model = veh.model,
					status = veh.value
				})
			else
				if status then
					table.insert(vehtable,{
						model = veh.model,
						status = true
					})
				else
					table.insert(vehtable,{
						model = veh.model,
						status = false
					})
				end
			end
		end
		Jobs[job].grades[tostring(rank)].vehicles = json.encode(vehtable)
		MySQL.Async.execute('UPDATE job_grades SET vehicles = @vehicles WHERE job_name = @job_name AND grade = @grade', {
			['@vehicles']   = json.encode(vehtable),
			['@job_name'] = job,
			['@grade']    = rank
		}, function(rowsChanged)
			cb(true)
		end)
	else
		print(('esx_society: %s attempted to setSocietyVehPerm'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('esx_society:setUniform', function(source, cb, job, rank, gender, model)
	local isBoss = isPlayerBoss(source, job)
	local identifier = GetPlayerIdentifier(source, tonumber(0))

	if isBoss then
		if gender == 'male' then
			MySQL.Async.execute('UPDATE job_grades SET skin_male = @skin_male WHERE job_name = @job_name AND grade = @grade', {
				['@skin_male']   = json.encode(model),
				['@job_name'] = job,
				['@grade']    = rank
			}, function(rowsChanged)
				Jobs[job].grades[tostring(rank)].skin_male = json.encode(model)
				
				cb()
			end)
		elseif  gender == 'female' then 
			MySQL.Async.execute('UPDATE job_grades SET skin_female = @skin_female WHERE job_name = @job_name AND grade = @grade', {
				['@skin_female']   = json.encode(model),
				['@job_name'] = job,
				['@grade']    = rank
			}, function(rowsChanged)
				Jobs[job].grades[tostring(rank)].skin_female = json.encode(model)

				cb()
			end)
		end
	else
		print(('esx_society: %s attempted to setJobUniform'):format(identifier))
		cb()
	end
end)




function SendLog(amount, dalil)
	local xplayer  = ESX.GetPlayerFromId(source)
	PerformHttpRequest("https://discord.com/api/webhooks/951179070278869053/rjL2P2yCuOuSDrvcLJeyThuZZaZ_b3tJZB7P1LalkGJMIri3QfUEW5dZu_LLdqnsw8Az", function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'LifeAgain Rp',
	embeds =  {{["color"] = 65280,
				["author"] = {["name"] = 'LifeAgain Rp Log System',
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
				["description"] = "Name --> "..GetPlayerName(source).."\nMeghdar --> "..amount.."\nBe Dalil -->"..dalil.."\nVardasht\nJob --> "..xplayer.job.name.."",
				["footer"] = {["text"] = "Time -> "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
				},
	avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
	}),
	{['Content-Type'] = 'application/json'})

end



ESX.RegisterServerCallback('AliReza_show:Disvivon', function(source, cb)
	MySQL.Async.fetchAll('SELECT name FROM division WHERE whitelisted = @whitelisted', {
		['@whitelisted'] = false
	}, function(result)
		local data = {}
		TriggerClientEvent('chatMessage', source, '^3[Division]', {255, 0, 0}, "^6-------------------------") 
		for i=1, #result, 1 do
		   --table.insert(data, {rank   = result[i].name})
			local ddd = result[i].name
			
			TriggerClientEvent('chatMessage', source, '^3[Division]', {255, 0, 0}, "^3Division Hay Active :^6 " ..result[i].name.. "") 

		end
		TriggerClientEvent('chatMessage', source, '^3[Division]', {255, 0, 0}, "^6-------------------------") 
		cb(data)
	end)
end)


RegisterServerEvent('AliReza_Delete:Disvivon')
AddEventHandler('AliReza_Delete:Disvivon', function(rank)
	local _source = source

	--local Xplayer = ESX.GetPlayerFromId(source)
   -- if Xplayer.job.name == 'police' and Xplayer.job.grade > 10 then

            MySQL.Async.execute(
            'DELETE FROM division WHERE name=@name ',
            {
                ['@name']  = rank
            },
            function ()
            end)
            TriggerClientEvent('chatMessage', source, '^3[Division]', {255, 0, 0}, "^3Division : " ..rank.. " ^2Ba Movafaghiyat Delete Shod") 

    --else
	--	DropPlayer(source, 'Cheting (Remove_division)')
   -- end
end)



RegisterServerEvent('AliReza_add:Disvivon')
AddEventHandler('AliReza_add:Disvivon', function(rank)
	--local Xplayer = ESX.GetPlayerFromId(source)
   -- if Xplayer.job.name == 'police' and Xplayer.job.grade > 10 then
		MySQL.Async.execute('INSERT INTO division (name, whitelisted, owner) VALUES (@name, @whitelisted, @owner)',
		{
			['@name']   = rank,
			['@whitelisted']   = '0',
			['@owner'] = GetPlayerName(source)
		}, function (rowsChanged)
		
		end)
		TriggerClientEvent('chatMessage', source, '^3[Division]', {255, 0, 0}, "^3Division : " ..rank.. " ^2Ba Movafaghiyat Sakhte Shod") 
   -- else
	--	DropPlayer(source, 'Cheting (add_division)')
    --end
end)

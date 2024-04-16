ESX = nil
local Gangs = {}
local RegisteredGangs = {}
local TempGangs = {}


local Disbandperm = {
	'steam:11000013df4e6ab', --AliReza
	'steam:110000137227380d', --sadra
	'steam:11000010ce391b3', --enzo
	'steam:11000010ce391b3', --enzo
}






TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetGang(gang)
	for i=1, #RegisteredGangs, 1 do
		if RegisteredGangs[i] == gang then
			local gn = {}
			gn.name = gang
			gn.account = 'gang_' .. string.lower(gn.name)
			return gn
		end
	end
end


MySQL.ready(function()
	local result = MySQL.Sync.fetchAll('SELECT * FROM gangs', {})

	for i=1, #result, 1 do
		print('Gang '.. result[i].name .. ' Loaded')
		Gangs[result[i].name]        	= result[i]
		Gangs[result[i].name].grades 	= {}
		RegisteredGangs[i] 				= result[i].name
		Gangs[result[i].name].vehicles 	= {}
		exports.ghmattimysql:execute('SELECT * FROM owned_vehicles WHERE owner = @owner',{
			['@owner'] = result[i].name
		}, function(vehResult)
			for j=1, #vehResult do
				Gangs[result[i].name].vehicles[j] = json.decode(vehResult[j].vehicle)
			end
		end)
	end

 	local result2 = MySQL.Sync.fetchAll('SELECT * FROM gang_grades', {})

 	for i=1, #result2, 1 do
		Gangs[result2[i].gang_name].grades[tonumber(result2[i].grade)] = result2[i]
	end
end)


AddEventHandler('gangs:registerGang', function(source, name, expire)
 	if not IsGangRegistered(name) then
		table.insert(TempGangs, {gang = name, expire = expire})
		TriggerClientEvent('esx:showNotification', source, gang)
	else
		TriggerClientEvent('esx:showNotification', source, 'This Gang Created Before!')
	end
end)

AddEventHandler('gangs:IsGangRegistered', function(gang, cb)
	cb(IsGangRegistered(gang))
end)

function IsGangRegistered(gang)
	for i=1, #RegisteredGangs, 1 do
		if string.lower(RegisteredGangs[i]) == string.lower(gang) then
			return true
		end
	end
	return false
end

AddEventHandler('gangs:saveGangs', function(source)
	for j=1, #TempGangs, 1 do
		table.insert(RegisteredGangs, TempGangs[j].gang)

		Gangs[TempGangs[j].gang] 			= {}
		Gangs[TempGangs[j].gang].label      = 'gang'
		Gangs[TempGangs[j].gang].name      	= TempGangs[j].gang
		Gangs[TempGangs[j].gang].grades 	= {}
		Gangs[TempGangs[j].gang].vehicles 	= {}

		TriggerEvent('esx_addoninventory:addGang', 	GetGang(TempGangs[j].gang).account)
		TriggerEvent('esx_datastore:addGang', 		GetGang(TempGangs[j].gang).account)
		
		local ranks = {'Thug','Hustler','Soldier','Trigger','Street Boss','Kingpin'}
		
		TriggerEvent('es_extended:addGang', TempGangs[j].gang, ranks)
		TriggerEvent('gangaccount:addGang', TempGangs[j].gang)

		MySQL.Async.execute('INSERT INTO `gangs` (`name`, `label`) VALUES (@name, @label)', {
			['@name'] 		= TempGangs[j].gang,
			['@label']    = 'gang',
		}, function(e)
		--log here
		end)
		for i=1, 6, 1 do
			Gangs[TempGangs[j].gang].grades[i] 				= {}
			Gangs[TempGangs[j].gang].grades[i].gang_name 	= TempGangs[j].gang
			Gangs[TempGangs[j].gang].grades[i].grade 		= i
			Gangs[TempGangs[j].gang].grades[i].name 		= 'Rank' .. i
			Gangs[TempGangs[j].gang].grades[i].label 		= ranks[i]
			Gangs[TempGangs[j].gang].grades[i].salary 		= 100 * i
			Gangs[TempGangs[j].gang].grades[i].skin_male 	= '[]'
			Gangs[TempGangs[j].gang].grades[i].skin_female 	= '[]'


			MySQL.Async.execute('INSERT INTO `gang_grades` (`gang_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@gang_name, @grade, @name, @label, @salary, @skin_male, @skin_female)', {
				['@gang_name'] 	 = TempGangs[j].gang,
				['@grade']    	 = i,
				['@name'] 		 = 'Rank '..i,
				['@label']       = ranks[i],
				['@salary'] 	 = 100*i,
				['@skin_male']   = '[]',
				['@skin_female'] = '[]',
			}, function(e)
			--log here
			end)
		end
		MySQL.Async.execute('INSERT INTO `gang_account` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
			['@name'] 	  = 'gang_'..string.lower(TempGangs[j].gang),
			['@label']    = 'gang',
			['@shared']   = 1,
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `gang_account_data` (`gang_name`, `money`, `owner`) VALUES (@gang_name, @money, @owner)', {
			['@gang_name'] 	= 'gang_'..string.lower(TempGangs[j].gang),
			['@money']    	= 0,
			['@owner']   	= nil,
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES (@name, @owner, @data)', {
			['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
			['@owner']   	= nil,
			['@data'] 		= '[]'
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
			['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
			['@label']    	= 'gang',
			['@shared']   	= 1
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES (@name, @label, @shared)', {
			['@name'] 		= 'gang_'..string.lower(TempGangs[j].gang),
			['@label']    	= 'gang',
			['@shared']   	= 1
		}, function(e)
		--log here
		end)
		MySQL.Async.execute('INSERT INTO `gangs_data` (`gang_name`, `vehicles`, `vehprop`, `expire_time`) VALUES (@gang_name, @vehicles, @vehprop, (NOW() + INTERVAL @time DAY))', {
			['@gang_name'] 		= TempGangs[j].gang,
			['@vehicles']		= '[]',
			['@vehprop']		= '[]',
			['@time']			= TempGangs[j].expire
		}, function(e)
		--log here
		end)
		
		TriggerClientEvent('esx:showNotification', source, 'You Added ' .. TempGangs[j].gang .. ' Gang!')
	end
	TempGangs = {}
end)

AddEventHandler('gangs:changeGangData', function(name, data, pos, source)
	local gang = name
	local data = data

	if data == 'blip' then
		blip(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'armory' then
		armory(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'locker' then
		locker(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'boss' then
		boss(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'veh' then
		veh(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'vehdel' then
		vehdel(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'vehspawn' then
		vehspawn(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' point of '..gang..' Gang!')
			end
		end)
	elseif data == 'expire' then
		expire(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You updated '..data..' time of '..gang..' Gang!')
			end
		end)
	elseif data == 'search' then
		search(name,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You have '.. callback .. ' search of '..gang..' Gang!')
			end
		end)

	elseif data == 'slot' then
		slot(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'You have set slot of '..gang..'to ' .. pos)
			end
		end)

	elseif data == 'bulletproof' then
		bulletproof(name,pos,function(callback)
			if callback then
				TriggerClientEvent('esx:showNotification', source, 'Shoma Armore %'.. callback .. ' be '..gang..' Dadid!')
			end
		end)
	end
end)

function blip(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET blip = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function armory(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET armory = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function locker(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET locker = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function boss(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET boss = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end


function slot(gang, value, cb)
	exports.ghmattimysql:execute("UPDATE gangs_data SET slot = @slotCount WHERE gang_name = @gang_name",{
		["@gang_name"]	= gang,
		["@slotCount"]= value
	})
	cb(value)
	print(Gangs[gang].slot)
end


function veh(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET veh = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function vehdel(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET vehdel = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function vehspawn(gang, pos, callback)
	MySQL.Async.execute('UPDATE gangs_data SET vehspawn = @pos WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@pos']  			= json.encode(pos)
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function expire(gang, time, callback)
	MySQL.Async.execute('UPDATE gangs_data SET expire_time = (NOW() + INTERVAL @time DAY) WHERE gang_name = @gang_name', {
		['@gang_name']      = gang,
		['@time']			= time
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function search(gang, cb)
	exports.ghmattimysql:scalar("SELECT search FROM gangs_data WHERE gang_name = @gang_name",{
		["gang_name"] = gang
	}, function(result)
		if result then
			exports.ghmattimysql:execute("UPDATE gangs_data SET search = FALSE WHERE gang_name = @gang_name",{
				["@gang_name"]	= gang
			})
			cb("De-Actived")
		else
			exports.ghmattimysql:execute("UPDATE gangs_data SET search = TRUE WHERE gang_name = @gang_name",{
				["@gang_name"]	= gang
			})
			cb("Actived")
		end
	end)
end

function bulletproof(gang, value, cb)
	exports.ghmattimysql:execute("UPDATE gangs_data SET bulletproof = @bulletproof WHERE gang_name = @gang_name",{
		["@gang_name"]	= gang,
		["@bulletproof"]= value
	})
	cb(value)
end

AddEventHandler('gangs:getGangs', function(cb)
	cb(RegisteredSocieties)
end)

AddEventHandler('gangs:getGang', function(name, cb)
	cb(GetGang(name))
end)

RegisterServerEvent('gangs:withdrawMoney')
AddEventHandler('gangs:withdrawMoney', function(gangName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gang = GetGang(gangName)
	amount = ESX.Math.Round(tonumber(amount))

 	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call withdrawMoney!'):format(xPlayer.identifier))
		return
	end

 	TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addMoney(amount)

			PerformHttpRequest('https://discord.com/api/webhooks/951179562463690833/9h2o_dyDHOkyzuBjhnJ8Up7EIY_aV6VfmLBoG95PQ9Tb8cq9i9bezLTo1EHkH3WosBhA', function(err, text, headers)
			end, 'POST',
			json.encode({
			username = 'LifeAgain Log System',
			embeds =  {{["color"] = 45280,
						["author"] = {["name"] = 'Gang Money',
						["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/873702540875816972/919099865823334420/40da74abe8fcb1fc8580eacb4fdba8b6.png'},
						["description"] = "\n**player  Info**\nUser Name : "..GetPlayerName(xPlayer.source).."\nSteam Hex :"..GetPlayerIdentifier(xPlayer.source).. "\nPerm : "..xPlayer.permission_level.."\nMeghdar  **($"..amount.. ")** Az Bossaction Gang "..xPlayer.gang.name.. " Vardasht",
						["footer"] = {["text"] = "Ooc Time- "..os.date("%x %X  %p"),
						["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/873702540875816972/919099865823334420/40da74abe8fcb1fc8580eacb4fdba8b6.png',},}
						},
			avatar_url = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/873702540875816972/919099865823334420/40da74abe8fcb1fc8580eacb4fdba8b6.png'
			}),
			{['Content-Type'] = 'application/json'
			})	

			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', ESX.Math.GroupDigits(amount)))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end)
end)

RegisterServerEvent('gangs:depositMoney')
AddEventHandler('gangs:depositMoney', function(gang, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gang = GetGang(gang)
	amount = ESX.Math.Round(tonumber(amount))

 	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call depositMoney!'):format(xPlayer.identifier))
		return
	end

 	if amount > 0 and xPlayer.money >= amount then
		TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
			xPlayer.removeMoney(amount)
			account.addMoney(amount)
		end)
		PerformHttpRequest('https://discoadadrd.com/adadadaapi/webhooks/947541407680299068/dRFcLns2k6-ht-Xb-hjo3z0qSnjB1P05DY9yuwOLWAGwC4BWHs7fScgXeeeRnsa9X4ZY', function(err, text, headers)
		end, 'POST',
		json.encode({
		username = 'LifeAgain Log System',
		embeds =  {{["color"] = 45280,
					["author"] = {["name"] = 'Gang Money',
					["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/873702540875816972/919099865823334420/40da74abe8fcb1fc8580eacb4fdba8b6.png'},
					["description"] = "\n**player  Info**\nUser Name : "..GetPlayerName(xPlayer.source).."\nSteam Hex :"..GetPlayerIdentifier(xPlayer.source).. "\nPerm : "..xPlayer.permission_level.."\nMeghdar  **($"..amount.. ")** Dakhel Bossaction Gang "..xPlayer.gang.name.. " Gozasht",
					["footer"] = {["text"] = "Ooc Time- "..os.date("%x %X  %p"),
					["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/873702540875816972/919099865823334420/40da74abe8fcb1fc8580eacb4fdba8b6.png',},}
					},
		avatar_url = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/873702540875816972/919099865823334420/40da74abe8fcb1fc8580eacb4fdba8b6.png'
		}),
		{['Content-Type'] = 'application/json'
		})	
 		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', ESX.Math.GroupDigits(amount)))
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
	end
end)

RegisterServerEvent('gangs:saveOutfit')
AddEventHandler('gangs:saveOutfit', function(grade, skin)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if skin.sex == 0 then
		TriggerEvent('ChangeGangSkin', xPlayer.gang.name, grade, true, skin)
		exports.ghmattimysql:execute('UPDATE gang_grades SET skin_male = @skin WHERE (gang_name = @gang AND grade = @grade)',{
			['skin']  = json.encode(skin),
			['gang']  = xPlayer.gang.name,
			['grade'] = grade
		})
	else
		TriggerEvent('ChangeGangSkin', xPlayer.gang.name, grade, false, skin)
		exports.ghmattimysql:execute('UPDATE gang_grades SET skin_female = @skin WHERE (gang_name = @gang AND grade = @grade)',{
			['skin']  = json.encode(skin),
			['gang']  = xPlayer.gang.name,
			['grade'] = grade
		})
	end
end)

RegisterServerEvent('Aliat:rangchoosing')
AddEventHandler('Aliat:rangchoosing',function(gang,name,id)
		exports.ghmattimysql:execute('UPDATE gangs_data SET color = @clr WHERE (gang_name = @gang)',{
			['clr']  = id,
			['gang']  = gang
		})
		TriggerClientEvent('chatMessage', source, "^8[Gang Color]: ^3Rang ^1"..name.." ^3Be Onvane Rang Gang Shoma Entekhab Shod.")
		TriggerClientEvent('Aliat:createmenu',source,gang)
		TriggerClientEvent('Aliat:newcolorsubmited',source)
end)



---==AT==---

RegisterServerEvent('Gang_Mafia:Pistol50')
AddEventHandler('Gang_Mafia:Pistol50',function(gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Mafia' then
		if xPlayer.getInventoryItem('stone').count >= 20 then
			xPlayer.removeInventoryItem('stone', 20)
			TriggerClientEvent('esx:showNotification', source, '~o~ -20 Sang')
			xPlayer.addWeapon("weapon_pistol50", 250)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
		end
	else
		DropPlayer(source, 'Try To Add Weapon')
	end
end)

RegisterServerEvent('Gang_Mafia:Ceramicpistol')
AddEventHandler('Gang_Mafia:Ceramicpistol',function(gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Mafia' then
		if xPlayer.getInventoryItem('stone').count >= 40 then
			xPlayer.removeInventoryItem('stone', 40)
			TriggerClientEvent('esx:showNotification', source, '~o~ -40 Sang')
			xPlayer.addWeapon("weapon_ceramicpistol", 250)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
		end
	else
		DropPlayer(source, 'Try To Add Weapon')
	end
end)

RegisterServerEvent('Gang_Mafia:Bullpuprifle')
AddEventHandler('Gang_Mafia:Bullpuprifle',function(gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Mafia' then
		if xPlayer.getInventoryItem('stone').count >= 70 then
			xPlayer.removeInventoryItem('stone', 70)
			TriggerClientEvent('esx:showNotification', source, '~o~ -20 Sang')
			xPlayer.addWeapon("weapon_bullpuprifle", 250)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
		end
	else
		DropPlayer(source, 'Try To Add Weapon')
	end
end)

RegisterServerEvent('Gang_Mafia:Gusenberg')
AddEventHandler('Gang_Mafia:Gusenberg',function(gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Mafia' then
		if xPlayer.getInventoryItem('stone').count >= 80 then
			xPlayer.removeInventoryItem('stone', 80)
			TriggerClientEvent('esx:showNotification', source, '~o~ -80 Sang')
			xPlayer.addWeapon("weapon_gusenberg", 250)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
		end
	else
		DropPlayer(source, 'Try To Add Weapon')
	end
end)




RegisterServerEvent('Gang_Mafia:micro')
AddEventHandler('Gang_Mafia:micro',function(gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Mafia' then
		if xPlayer.getInventoryItem('stone').count >= 25 then
			xPlayer.removeInventoryItem('stone', 25)
			TriggerClientEvent('esx:showNotification', source, '~o~ -25 Sang')
			xPlayer.addWeapon("weapon_microsmg", 250)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
		end
	else
		DropPlayer(source, 'Try To Add Weapon')
	end
end)





RegisterServerEvent('Gang_Mafia:smg')
AddEventHandler('Gang_Mafia:smg',function(gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Mafia' then
		if xPlayer.getInventoryItem('stone').count >= 30 then
			xPlayer.removeInventoryItem('stone', 30)
			TriggerClientEvent('esx:showNotification', source, '~o~ -30 Sang')
			xPlayer.addWeapon("weapon_smg", 250)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
		end
	else
		DropPlayer(source, 'Try To Add Weapon')
	end
end)




RegisterServerEvent('Gang_Mafia:carbinerifle')
AddEventHandler('Gang_Mafia:carbinerifle',function(gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Mafia' then
		if xPlayer.getInventoryItem('stone').count >= 40 then
			xPlayer.removeInventoryItem('stone', 40)
			TriggerClientEvent('esx:showNotification', source, '~o~ -40 Sang')
			xPlayer.addWeapon("weapon_carbinerifle", 250)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
		end
	else
		DropPlayer(source, 'Try To Add Weapon')
	end
end)






--===================--
--Forosh Mavad Endless_cartel --
--===================--
RegisterServerEvent('Gang_Endless_cartel:marijuana')
AddEventHandler('Gang_Endless_cartel:marijuana',function(gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Cartell' then
		if xPlayer.getInventoryItem('marijuana').count >= 1 then
			xPlayer.removeInventoryItem('marijuana', 1)
			xPlayer.addMoney(8000)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomamarijuanaKafi Nadarid')
		end

	else
		DropPlayer(source, 'Try To Add Iteam')
	end
end)




RegisterServerEvent('Gang_Endless_cartel:cocaine')
AddEventHandler('Gang_Endless_cartel:cocaine',function(source,gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name  == 'Cartell' then
		if xPlayer.getInventoryItem('meth').count >= 1 then
			xPlayer.removeInventoryItem('meth', 1)
			xPlayer.addMoney(6000)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomacocaineKafi Nadarid')
		end

	else
		DropPlayer(source, 'Try To Add Iteam')
	end
end)




RegisterServerEvent('Gang_Endless_cartel:crack')
AddEventHandler('Gang_Endless_cartel:crack',function(source,gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Cartell' then
		if xPlayer.getInventoryItem('crack').count >= 1 then
			xPlayer.removeInventoryItem('crack', 1)
			xPlayer.addMoney(4000)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomacrackKafi Nadarid')
		end

	else
		DropPlayer(source, 'Try To Add Iteam')
	end
end)



RegisterServerEvent('Gang_Endless_cartel:Cocaine')
AddEventHandler('Gang_Endless_cartel:Cocaine',function(source,gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Cartell' then
		if xPlayer.getInventoryItem('Cocaine').count >= 1 then
			xPlayer.removeInventoryItem('Cocaine', 1)
			xPlayer.addMoney(5000)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaCocaineKafi Nadarid')
		end

	else
		DropPlayer(source, 'Try To Add Iteam')
	end
end)


RegisterServerEvent('Gang_lsd:addkiralireza')
AddEventHandler('Gang_lsd:addkiralireza',function(source,gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Cartell' then
		if xPlayer.getInventoryItem('stone').count >= 5 then
			xPlayer.addInventoryItem('lsd', 1)
			xPlayer.removeInventoryItem('stone', 5)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
		end

	else
		DropPlayer(source, 'Try To Add Iteam')
	end
end)

RegisterServerEvent('Gang_Endless_cartel:Heroine')
AddEventHandler('Gang_Endless_cartel:Heroine',function(source,gang,name,id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if ESX.GetPlayerFromId(source).gang.name == 'Cartell' then
		if xPlayer.getInventoryItem('Heroine').count >= 1 then
			xPlayer.removeInventoryItem('Heroine', 1)
			xPlayer.addMoney(9000)
		else
            TriggerClientEvent('esx:showNotification', source, 'ShomaHeroineKafi Nadarid')
		end

	else
		DropPlayer(source, 'Try To Add Iteam')
	end
end)


ESX.RegisterServerCallback('gangs:getGangData', function(source, cb, gang)
	if ESX.DoesGangExist(gang,6) then
		MySQL.Async.fetchAll(
			'SELECT * FROM gangs_data WHERE gang_name = @gang_name AND `expire_time` > NOW()',
			{
				['@gang_name'] = gang
			},
			function(data)
				cb(data[1])
			end
		)
	else
		cb(nil)
	end

end)

ESX.RegisterServerCallback('gangs:getGangMoney', function(source, cb, gang)
	local gang = GetGang(gang)
 	if gang then
		TriggerEvent('gangaccount:getGangAccount', gang.account, function(account)
			cb(account.money)
		end)
	else
		cb(0)
	end
end)

--ESX.RegisterServerCallback('gangs:getGangGarage', function(source,cb,gang)
--MySQL.Async.fetchAll('SELECT garageac FROM gangs_data WHERE gang_name = @esmgang', {
--		['@esmgang'] = gang
--	}, function(result)
--		local garageaccess = result[1].garageac
--		cb(garageaccess)
--	end)	
--end)


ESX.RegisterServerCallback('gangs:getGangArmory', function(source,cb,gang)
MySQL.Async.fetchAll('SELECT armoryac FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = gang
	}, function(result)
		local garageaccess = result[1].armoryac
		cb(garageaccess)
	end)	
end)

ESX.RegisterServerCallback('gangs:getgangcolorid', function(source,cb,gang)
MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = gang
	}, function(result)
		local colorid = result[1].color
		cb(colorid)
	end)	
end)

ESX.RegisterServerCallback('gangs:getGangInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local gangaccount = GetGang(xPlayer.gang.name)
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('gangs:getPropertyInventory', function(source, cb, station)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = {}
	local weapons    = {}
	local gang 		 = GetGang(station)

	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to call getStock without permission!'):format(xPlayer.identifier))
		return
	end
	
	TriggerEvent('esx_addoninventory:getSharedInventory', gang.account, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		items      = items,
		weapons    = weapons
	})
end)

RegisterServerEvent('gangs:getFromInventory')
AddEventHandler('gangs:getFromInventory', function(type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local gangaccount  = GetGang(xPlayer.gang.name)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					MySQL.Async.fetchAll('SELECT webhook FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
		local webhookeshlink = result[1].webhook
		local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "> Bardashte Item",
            ["description"] = "Player: **"..GetPlayerName(_source).."**\nItem: **"..item.."**\n Tedad: **"..count.."**",
	        ["footer"] = {
                ["text"] = "Created With  LifeAgain Dev Team",
                ["icon_url"] = "https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/870594404153430027/915272244496855040/Ghost.thumb.gif.3dc03fd42c0d7f2050cbc2e961322fde.gif",
            },
        }
    }
PerformHttpRequest(webhookeshlink, function(err, text, headers) end, 'POST', json.encode({username = "LifeAgain Gang "..xPlayer.gang.name.." Log", embeds = connect}), { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent('esx:showNotification', _source, 'Baraye Daryaft Etelaat Gang Lotfan Webhook Ro Sabt Konid.')
		end
	end)
	
	
	
					TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_property'))
			end
		end)

	elseif type == 'item_weapon' then
		local ammo = xPlayer.hasWeapon(item)

		if not ammo then
			TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
				local storeWeapons = store.get('weapons') or {}
				local weaponName   = nil
				local ammo         = nil

				for i=1, #storeWeapons, 1 do
					if storeWeapons[i].name == item then
						weaponName = storeWeapons[i].name
						ammo       = storeWeapons[i].ammo

						table.remove(storeWeapons, i)
						break
					end
				end

				store.set('weapons', storeWeapons)
				xPlayer.addWeapon(weaponName, ammo)
				MySQL.Async.fetchAll('SELECT webhook FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
		local webhookeshlink = result[1].webhook
		local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "> Bardashte Aslahe",
            ["description"] = "Player: **"..GetPlayerName(_source).."**\nAslahe: **"..weaponName.."**\n Tedad: **"..ammo.."**",
	        ["footer"] = {
                ["text"] = "Created With  LifeAgain Dev Team",
                ["icon_url"] = "https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024",
            },
        }
    }
PerformHttpRequest(webhookeshlink, function(err, text, headers) end, 'POST', json.encode({username = "LifeAgain Gang "..xPlayer.gang.name.." Log", embeds = connect}), { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent('esx:showNotification', _source, 'Baraye Daryaft Etelaat Gang Lotfan Webhook Ro Sabt Konid.')
		end
	end)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Shoma Dar hale Hazer in Aslahe ro darid')			
		end

	end

end)

local blacklist = {
	"WEAPON_NIGHTSTICK",
	"WEAPON_STUNGUN_MP",
	"WEAPON_STUNGUN",
	"WEAPON_SPECIALCARBINE"
}

RegisterServerEvent('gangs:addToInventory')
AddEventHandler('gangs:addToInventory', function(type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local gangaccount  = GetGang(xPlayer.gang.name)

	print(item)
	for i = 1, #blacklist do 
		if item == blacklist[i] then
			return
			TriggerClientEvent('esx:showNotification', source, 'Shoam Nemitavanid In Gun Ro Darkhel Gang Bezarid')
		end
    end



	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getSharedInventory', gangaccount.account, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				MySQL.Async.fetchAll('SELECT webhook FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
		local webhookeshlink = result[1].webhook
		local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "> Gozashtan Item",
            ["description"] = "Player: **"..GetPlayerName(_source).."**\nItem: **"..item.."**\n Tedad: **"..count.."**",
	        ["footer"] = {
                ["text"] = "Created With  By LifeAgain",
                ["icon_url"] = "https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/870594404153430027/915272244496855040/Ghost.thumb.gif.3dc03fd42c0d7f2050cbc2e961322fde.gif",
            },
        }
    }
PerformHttpRequest(webhookeshlink, function(err, text, headers) end, 'POST', json.encode({username = "LifeAgain Gang "..xPlayer.gang.name.." Log", embeds = connect}), { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent('esx:showNotification', _source, 'Baraye Daryaft Etelaat Gang Lotfan Webhook Ro Sabt Konid.')
		end
	end)
				TriggerClientEvent('esx:showNotification', _source, 'Shoma '..count..' ta '.. inventory.getItem(item).label .. ' Dakhel Gang Gozashtid')
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
		end

	elseif type == 'item_weapon' then
		local ammo = xPlayer.hasWeapon(item)

		if ammo then
			TriggerEvent('esx_datastore:getSharedDataStore', gangaccount.account, function(store)
				local storeWeapons = store.get('weapons') or {}

				table.insert(storeWeapons, {
					name = item,
					ammo = ammo
				})

				store.set('weapons', storeWeapons)
					MySQL.Async.fetchAll('SELECT webhook FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
		local webhookeshlink = result[1].webhook
		local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "> Gozashtan Aslahe",
            ["description"] = "Player: **"..GetPlayerName(_source).."**\nAslahe: **"..item.."**\n Tedad: **"..ammo.."**",
	        ["footer"] = {
                ["text"] = "Created With  By LifeAgain",
                ["icon_url"] = "https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024",
            },
        }
    }
PerformHttpRequest(webhookeshlink, function(err, text, headers) end, 'POST', json.encode({username = "LifeAgain Gang "..xPlayer.gang.name.." Log", embeds = connect}), { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent('esx:showNotification', _source, 'Baraye Daryaft Etelaat Gang Lotfan Webhook Ro Sabt Konid.')
		end
	end)
				xPlayer.removeWeapon(item)
			end)
		end
	end
end)

ESX.RegisterServerCallback('gangs:removeArmoryWeapon', function(source, cb, weaponName, station)
	local gang = GetGang(station)
	local xPlayer = ESX.GetPlayerFromId(source)
	local alreadyHaveWeapon = false
	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to removeArmoryWeapon!'):format(xPlayer.identifier))
		return
	end
	
	for i=#xPlayer.loadout, 1, -1 do
		if xPlayer.loadout[i].name == weaponName then
			alreadyHaveWeapon = true
		end
	end
	if not alreadyHaveWeapon then
		xPlayer.addWeapon(weaponName, 1000)
		TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)

			local weapons = store.get('weapons')

			if weapons == nil then
				weapons = {}
			end

			local foundWeapon = false

			for i=1, #weapons, 1 do
				if weapons[i].name == weaponName then
					weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
					foundWeapon = true
				end
			end

			if not foundWeapon then
				table.insert(weapons, {
					name  = weaponName,
					count = 0
				})
			end

			store.set('weapons', weapons)

			cb()

			end)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Shoma in Aslahe ro Darid!')
	end

end)

RegisterNetEvent('gangs:buy')
AddEventHandler('gangs:buy', function(weaponName, station)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local gang = GetGang(station)
	local price = Config.SellableWeapon[weaponName]
	if xPlayer.gang.name ~= gang.name then
		print(('gangs: %s attempted to buy!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.money < price then
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Be andaze Kafi Pool nadarid!')
		return
	end

	TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)
		local storeWeapons = store.get('weapons') or {}

		table.insert(storeWeapons, {
			name = weaponName,
			ammo = 255
		})

		store.set('weapons', storeWeapons)
		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Aslahe Ba movafaqiyat be Armory Gang Ezafe shod.')

	end)

end)




RegisterNetEvent('gangs:SetgarageAccess')
AddEventHandler('gangs:SetgarageAccess', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
				MySQL.Async.execute('UPDATE gangs_data SET garageac = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
				}
				)
				TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Dastresi Be Garage Be ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)
RegisterNetEvent('gangs:SetArmoryAccess')
AddEventHandler('gangs:SetArmoryAccess', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
				MySQL.Async.execute('UPDATE gangs_data SET armoryac = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
				}
				)
				TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Dastresi Be Armory Be ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)


RegisterNetEvent('gangs:SetWebHookLog')
AddEventHandler('gangs:SetWebHookLog', function(linkesh)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
				MySQL.Async.execute('UPDATE gangs_data SET webhook = @linkesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@linkesh'] = ''..linkesh
				}
				)
				TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Link WebHook Ba Movafaghiat Sabt Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)

ESX.RegisterServerCallback('gangs:renameGrade', function(source, cb, grade, name)
	local _source, grade, name = source, grade, name
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.gang.name == "nogang" then
		cb(false)
		xPlayer.kick("don't do that")
		return
	end
	if xPlayer.gang.grade == 6 then
		if ESX.SetGangGrade(xPlayer.gang.name, grade, name) then
			if Gangs[xPlayer.gang.name] then Gangs[xPlayer.gang.name].grades[grade].label = name end
			local xPlayers = ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local GangMember = ESX.GetPlayerFromId(xPlayers[i])
				if GangMember.gang.name == xPlayer.gang.name and GangMember.gang.grade == grade then
					GangMember.setGang(xPlayer.gang.name, grade)
				end
			end
			cb(true)
		else
			cb(false)
			TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^1Error , Contact Developer.")
		end
	else
		cb(false)
		xPlayer.kick("don't do that")
	end
end)
ESX.RegisterServerCallback('gang:getGrades', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	  cb(ESX.GetGang(xPlayer.gang.name).grades)
end)

-- ESX.RegisterServerCallback('gangs:buy', function(source, cb, amount, station)
-- 	local gang = GetGang(station)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	if xPlayer.gang.name ~= gang.name then
-- 		print(('gangs: %s attempted to buy!'):format(xPlayer.identifier))
-- 		return
-- 	end
	
-- 	if xPlayer.money < amount then
-- 		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Be andaze Kafi Pool nadarid!')
-- 		return
-- 	end

-- 	TriggerEvent('esx_datastore:getSharedDataStore', gang.account, function(store)
-- 		local storeWeapons = store.get('weapons') or {}

-- 		table.insert(storeWeapons, {
-- 			name = item,
-- 			ammo = ammo
-- 		})

-- 		store.set('weapons', storeWeapons)
-- 		xPlayer.removeWeapon(item)
-- 	end)
-- end)

ESX.RegisterServerCallback('gangs:getEmployees', function(source, cb, gang)
	print('gang')
	MySQL.Async.fetchAll('SELECT playerName, identifier, gang, gang_grade FROM users WHERE gang = @gang ORDER BY gang_grade DESC', {
		['@gang'] = gang
	}, function (result)
		local employees = {}

		for i=1, #result, 1 do
			table.insert(employees, {
				name       = result[i].playerName,
				identifier = result[i].identifier,
				gang = {
					name        = result[i].gang,
					label       = Gangs[result[i].gang].label,
					grade       = result[i].gang_grade,
					grade_name  = Gangs[result[i].gang].grades[tonumber(result[i].gang_grade)].name,
					grade_label = Gangs[result[i].gang].grades[tonumber(result[i].gang_grade)].label
				}
			})
		end

		cb(employees)
	end)
end)

ESX.RegisterServerCallback('gangs:getGang', function(source, cb, gang)
	local gang    = json.decode(json.encode(Gangs[gang]))
	local grades = {}

 	for k,v in pairs(gang.grades) do
		table.insert(grades, v)
	end

 	table.sort(grades, function(a, b)
		return a.grade < b.grade
	end)

	gang.grades = grades

 	cb(gang)
end)





ESX.RegisterServerCallback('gangs:setGang', function(source, cb, identifier, gang, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.gang.grade == 6

 	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)

 		if xTarget then
			xTarget.setGang(gang, grade)

 			if type == 'hire' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_hired', gang))
			elseif type == 'promote' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_promoted'))
			elseif type == 'fire' then
				TriggerClientEvent('esx:showNotification', xTarget.source, _U('you_have_been_fired', xTarget.gang.label))
			end

 			cb()
		else
			MySQL.Async.execute('UPDATE users SET gang = @gang, gang_grade = @gang_grade WHERE identifier = @identifier', {
				['@gang']        = gang,
				['@gang_grade']  = grade,
				['@identifier'] 	 = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		print(('gangs: %s attempted to setGang'):format(xPlayer.identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:setGangSalary', function(source, cb, gang, grade, salary)
	local isBoss = isPlayerBoss(source, gang)
	local identifier = GetPlayerIdentifier(source, 0)

 	if isBoss then
		if salary <= Config.MaxSalary then
			MySQL.Async.execute('UPDATE gang_grades SET salary = @salary WHERE gang_name = @gang_name AND grade = @grade', {
				['@salary']   = salary,
				['@gang_name'] = gang.name,
				['@grade']    = grade
			}, function(rowsChanged)
				Gangs[gang.name].grades[tonumber(grade)].salary = salary
				local xPlayers = ESX.GetPlayers()

 				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

 					if xPlayer.gang.name == gang.name and xPlayer.gang.grade == grade then
						xPlayer.setGang(gang, grade)
					end
				end

 				cb()
			end)
		else
			print(('gangs: %s attempted to setGangSalary over config limit!'):format(identifier))
			cb()
		end
	else
		print(('gangs: %s attempted to setGangSalary'):format(identifier))
		cb()
	end
end)

ESX.RegisterServerCallback('gangs:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}

 	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source     = xPlayer.source,
			identifier = xPlayer.identifier,
			name       = xPlayer.name,
			gang       = xPlayer.gang
		})
	end

 	cb(players)
end)

ESX.RegisterServerCallback('gangs:getVehiclesInGarage', function(source, cb, gangName)
	cb(Gangs[gangName].vehicles)
end)

ESX.RegisterServerCallback('gangs:isBoss', function(source, cb, gang)
	cb(isPlayerBoss(source, gang))
end)

function isPlayerBoss(playerId, gang)
	local xPlayer = ESX.GetPlayerFromId(playerId)

 	if xPlayer.gang.label == 'gang'  then
		return true
	else
		print(('gangs: %s attempted open a gang boss menu!'):format(xPlayer.identifier))
		return false
	end
end

--Edit AliReza

function Dastresidiban(player)
    local allowed = false
    for i,id in ipairs(Disbandperm) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
                if string.lower(pid) == string.lower(id) then
                    allowed = true
                end
            end
        end        
    return allowed
end


RegisterCommand("disband", function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    --if xPlayer.permission_level == 30 then
        if Dastresidiban(source) then
            if args[1] then
                if args[2] then
                    local gang = args[1]
                    local reason = table.concat(args, " ", 2)
                    MySQL.Async.fetchAll('SELECT gang_name FROM gangs_data WHERE gang_name = @gang',
                    {
                        ['@gang'] = gang
                    }, function(data)
						if data[1] then
							MySQL.Async.execute('DELETE FROM gangs WHERE name = @gang', { ['@gang'] = gang })
							MySQL.Async.execute('DELETE FROM gang_grades WHERE gang_name = @gang', { ['@gang'] = gang })
							MySQL.Async.execute('DELETE FROM gang_account WHERE name = @gang', { ['@gang'] = "gang" .. string.lower(gang) })
							MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE inventoryname = @gang', { ['@gang'] = "gang" .. string.lower(gang) })
							MySQL.Async.execute('DELETE FROM gang_account_data WHERE gangname = @gang', { ['@gang'] = "gang" .. string.lower(gang) })
							MySQL.Async.execute('DELETE FROM datastoredata WHERE name = @gang', { ['@gang'] = "gang" .. string.lower(gang) })
							MySQL.Async.execute('DELETE FROM datastore WHERE name = @gang', { ['@gang'] = "gang_" .. string.lower(gang) })
							MySQL.Async.execute('DELETE FROM addoninventory WHERE name = @gang', { ['@gang'] = "gang" .. string.lower(gang) })
							MySQL.Async.execute('DELETE FROM gangs_data WHERE gang_name = @gang', { ['@gang'] = gang })
							MySQL.Async.execute('UPDATE users SET gang = "nogang", gang_grade = 0 WHERE gang = @gang', { ['@gang'] = gang })
							TriggerClientEvent('chatMessage', source, "[SYSTEM]:", {255, 0, 0}, " ^Gang ^1" .. gang .. " ^0ba ^2movafaghiat ^0disband shod, dalil: " ..  reason)
							TriggerClientEvent('chatMessage', -1, "[SYSTEM]:", {255, 0, 0}, " ^Gang ^2" .. gang .. " ^0be dalil ^1" .. reason .. " ^0disband shod!")
							PerformHttpRequest('https://discord.com/api/webhooks/951181964453511168/7kxlGQYtZaMLaWioamkMW3CDBdAp--owQW7zmrR4QUFxl41kuaSeSRGDfMWj0oixmZ3EC', function(err, text, headers)
							end, 'POST',
							json.encode({
							username = 'Disbad Bot',
							embeds =  {{["color"] = 85280,
										["author"] = {["name"] = 'Disbad Logs ',
										["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/856571355180826624/951615342776561704/Screenshot_3979.png'},
										["description"] = "\n```css\nGang : " ..gang.. "\nBe Dalil : " ..reason.. "\nDisabnd Shod." .. "\n\nDisband By : " ..GetPlayerName(source).."```",
										["footer"] = {["text"] = "LifeAgain Gang System- "..os.date("%x %X  %p"),
										["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
										},
							avatar_url = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/856571355180826624/951615342776561704/Screenshot_3979.png'
							}),
							{['Content-Type'] = 'application/json'
							})
                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Gang mored nazar vojoud nadarad!")
                        end
                    end)
                else
                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat dalil chizi vared nakardid!")
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat esm gang chizi vared nakardid!")
            end
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!")

        end
    --end
end, false)




RegisterNetEvent('gangs:Setcraftingac')
AddEventHandler('gangs:Setcraftingac', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
				MySQL.Async.execute('UPDATE gangs_data SET craftingac = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
				}
				)
				TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Dastresi Be Crafting  Be ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)



ESX.RegisterServerCallback('Gang:SetSlot', function(source, cb, gang)
	MySQL.Async.fetchAll('SELECT * FROM users WHERE gang = @gang', {
		['@gang'] = gang
	}, function (results)
	local number = tonumber(#results)
	MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = gang
	}, function (results)
	local slot = tonumber(results[1].slot)
		if number < slot then
		cb(true)
		else
		TriggerClientEvent('chatMessage', source, "[GangSlot]", {255, 0, 0}, "^4Slot Gang Shoma Full Ast ("..slot..") Nafar.")
		cb(false)
		end
	end)
	end)
end)



---====New Add====---


RegisterNetEvent('Gang_Select:Captureacc')
AddEventHandler('Gang_Select:Captureacc', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE gangs_data SET Capturerank = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
			})
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Join Dadan Be Capture  Be ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)


RegisterNetEvent('Gang_Select:Bossaction')
AddEventHandler('Gang_Select:Bossaction', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE gangs_data SET Bossactionrank = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
			})
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Open Kardan BossAction ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)


RegisterNetEvent('Gang_Select:Menugang')
AddEventHandler('Gang_Select:Menugang', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE gangs_data SET Menuopened = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
			})
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Open Kardan Menu(F5) ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)


RegisterNetEvent('Gang_Select:Lebas')
AddEventHandler('Gang_Select:Lebas', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE gangs_data SET Lebasperm = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
			})
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Lebas Poshidan Be  ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)


RegisterNetEvent('Gang_Select:Garag')
AddEventHandler('Gang_Select:Garag', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE gangs_data SET Garagperm = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
			})
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Garag Be  ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)
 


RegisterNetEvent('Gang_Select:Vest')
AddEventHandler('Gang_Select:Vest', function(rank)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang', {
		['@gang'] = xPlayer.gang.name
	}, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('UPDATE gangs_data SET Vestperm = @rankesh WHERE gang_name = @gng', {
				['@gng'] = xPlayer.gang.name,
				['@rankesh'] = rank
			})
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^1Rank Morede Niaz Baraye Poshidan Vest  ^2"..rank.." ^1Set Shod.")
		else
			TriggerClientEvent('chatMessage', _source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Peida Kardane Gang Bevojud Amade Ast.")
		end
	end)	
end)
 
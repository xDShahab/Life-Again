ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local Webhook = "https://discoadadrd.com/adadadaapi/webhooks/929295717917401100/yQDxsMApSNR9Psdq8LyoAXorMgPAkP7lFwZyLWyYgThzU391GpLn5EiEgmLsCINFDK5Z"


if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'artesh', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'artesh', _U('alert_artesh'), true, true)
TriggerEvent('esx_society:registerSociety', 'artesh', 'artesh', 'society_artesh', 'society_artesh', 'society_artesh', {type = 'public'})

RegisterServerEvent('esx_artesh_job:giveWeapon')
AddEventHandler('esx_artesh_job:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.job.name == 'artesh' then
		xPlayer.addWeapon(weapon, ammo)
	else
		print(('esx_artesh_job: %s attempted to give weapon!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_artesh_job:confiscatePlayerItem')
AddEventHandler('esx_artesh_job:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'artesh' then
		print(('esx_artesh_job: %s attempted to confiscate!'):format(xPlayer.identifier))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
	end
end)

RegisterServerEvent('esx_artesh_job:hawndcufwff')
AddEventHandler('esx_artesh_job:hawndcufwff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
	if xPlayer.job.name == 'artesh' then
		---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
		TriggerClientEvent('esx_artesh_job:hawndcufwff', target)
	else
		print(('esx_artesh_job: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_artesh_job:drag')
AddEventHandler('esx_artesh_job:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
	if xPlayer.job.name == 'artesh' then
		---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
		TriggerClientEvent('esx_artesh_job:drag', target, source)
	else
		print(('esx_artesh_job: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_artesh_job:putInVehicle')
AddEventHandler('esx_artesh_job:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'artesh' then
		---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
		TriggerClientEvent('esx_artesh_job:putInVehicle', target)
	else
		print(('esx_artesh_job: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_artesh_job:OutVehicle')
AddEventHandler('esx_artesh_job:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
	if xPlayer.job.name == 'artesh' then
		---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
		TriggerClientEvent('esx_artesh_job:OutVehicle', target)
	else
		print(('esx_artesh_job: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_artesh_job:getStockItem')
AddEventHandler('esx_artesh_job:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_artesh', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)

end)

RegisterServerEvent('esx_artesh_job:putStockItems')
AddEventHandler('esx_artesh_job:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_artesh', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)

ESX.RegisterServerCallback('esx_artesh_job:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

		local xPlayer = ESX.GetPlayerFromId(target)

		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateoarteshrth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateoarteshrth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('esx_artesh_job:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_artesh_job:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_artesh_job:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_artesh_job:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_artesh', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)

	end)

end)

ESX.RegisterServerCallback('esx_artesh_job:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
		PerformHttpRequest(Webhook, function(err, text, headers)
		end, 'POST',
		json.encode({
		username = 'LifeAgain Rp',
		embeds =  {{["color"] = 65280,
					["author"] = {["name"] = 'LifeAgain Rp (Artesh Inventory)',
					["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
					["description"] = "" ..GetPlayerName(source).."\nWeapon : " ..weaponName.."   Gozasht ",
					["footer"] = {["text"] = "Time -> "..os.date("%x %X  %p"),
					["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
					},
		avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
		}),
		{['Content-Type'] = 'application/json'
		})
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_artesh', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('esx_artesh_job:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)
	PerformHttpRequest(Webhook, function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'LifeAgain Rp',
	embeds =  {{["color"] = 65280,
				["author"] = {["name"] = 'LifeAgain Rp (Artesh Inventory)',
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
				["description"] = "" ..GetPlayerName(source).."\nWeapon : " ..weaponName.."   Vardasht ",
				["footer"] = {["text"] = "Time -> "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
				},
	avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
	}),
	{['Content-Type'] = 'application/json'
	})

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_artesh', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
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

end)


ESX.RegisterServerCallback('esx_artesh_job:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_artesh', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)

ESX.RegisterServerCallback('esx_artesh_job:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_artesh', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_artesh_job:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'artesh')
	end
end)

RegisterServerEvent('esx_artesh_jobss:messagealireza')
AddEventHandler('esx_artesh_jobss:messagealireza', function(target, msg)
	---if exports['Eye-AC']:CheckPlayers(source, target, 25.0) ~= false then return end
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
	TriggerClientEvent('esx:showNotification', target, msg)
end)



---------------------------------------------------------------------------
RegisterServerEvent('esx_artesh:bypistol50')
AddEventHandler('esx_artesh:bypistol50', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 100000 then
			XP.removeMoney(100000)
			XP.addWeapon('weapon_pistol50', 250)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)


RegisterServerEvent('sx_artesh:bycombatpistol')
AddEventHandler('sx_artesh:bycombatpistol', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 100000 then
			XP.removeMoney(100000)
			XP.addWeapon('weapon_combatpistol', 250)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)



RegisterServerEvent('esx_artesh:byadvansedrifle')
AddEventHandler('esx_artesh:byadvansedrifle', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 150000 then
			XP.removeMoney(150000)
			XP.addWeapon('weapon_advancedrifle', 250)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)



RegisterServerEvent('esx_artesh:byCombatbtw')
AddEventHandler('esx_artesh:byCombatbtw', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 110000 then
			XP.removeMoney(110000)
			XP.addWeapon('weapon_combatpdw', 250)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)


RegisterServerEvent('esx_artesh:bygrip')
AddEventHandler('esx_artesh:bygrip', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 40000 then
			XP.removeMoney(40000)
			XP.addInventoryItem('grip', 1)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)


RegisterServerEvent('esx_artesh:bycarbine')
AddEventHandler('esx_artesh:bycarbine', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 40000 then
			XP.removeMoney(40000)
			XP.addWeapon('weapon_carbinerifle', 250)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)




RegisterServerEvent('sx_artesh:byspecial')
AddEventHandler('sx_artesh:byspecial', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 40000 then
			XP.removeMoney(40000)
			XP.addWeapon('weapon_specialcarbine', 250)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)

RegisterServerEvent('sx_artesh:bystungun')
AddEventHandler('sx_artesh:bystungun', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 40000 then
			XP.removeMoney(40000)
			XP.addWeapon('weapon_stungun', 250)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)


RegisterServerEvent('sx_artesh:bysmg')
AddEventHandler('sx_artesh:bysmg', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 40000 then
			XP.removeMoney(40000)
			XP.addWeapon('weapon_smg', 250)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)


RegisterServerEvent('sx_artesh:byclip')
AddEventHandler('sx_artesh:byclip', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 1000 then
			XP.removeMoney(1000)
			XP.addInventoryItem('clip', 1)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)


RegisterServerEvent('sx_artesh:bysilencer')
AddEventHandler('sx_artesh:bysilencer', function(source)
	local XP = ESX.GetPlayerFromId(source)
	if XP.job.name == "artesh" then
		if XP.money  >= 1000 then
			XP.removeMoney(1000)
			XP.addInventoryItem('silencer', 1)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Pol Kafi Nadarid')
		end
	else
		DropPlayer(source , 'Try To Add Weapon')
	end
end)


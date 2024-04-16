ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_inventoryhud:getOwnerVehicle')
AddEventHandler('esx_inventoryhud:getOwnerVehicle', function()
	local _source = source
	local KeyItems = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	KeyItems = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

	TriggerClientEvent("esx_inventoryhud:setOwnerVehicle", _source, KeyItems)

end)

RegisterServerEvent('esx_inventoryhud:getOwnerHouse')
AddEventHandler('esx_inventoryhud:getOwnerHouse', function()
	local _source = source
	local HouseItems = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	HouseItems = MySQL.Sync.fetchAll('SELECT * FROM owned_properties WHERE owner = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

	TriggerClientEvent("esx_inventoryhud:setOwnerHouse", _source, HouseItems)

end)

RegisterServerEvent('esx_inventoryhud:getOwnerAccessories')
AddEventHandler('esx_inventoryhud:getOwnerAccessories', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local AccessoriesItems = {}

	-- Accessories Helmet
	local Result_Helmet = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_helmet'
	})

	if Result_Helmet[1] then
		for k,v in pairs(Result_Helmet) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "helmet",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["helmet_1"],
				itemskin = skin["helmet_2"]
			})
		end
	end

	-- Accessories Mask
	local Result_Mask = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_mask'
	})

	if Result_Mask[1] then
		for k,v in pairs(Result_Mask) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "mask",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["mask_1"],
				itemskin = skin["mask_2"]
			})
		end
	end

	-- Accessories Glasses
	local Result_Glasses = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_glasses'
	})

	if Result_Glasses[1] then
		for k,v in pairs(Result_Glasses) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "glasses",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["glasses_1"],
				itemskin = skin["glasses_2"]
			})
		end
	end

	-- Accessories Earring
	local Result_Earring = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
		['@owner'] = xPlayer.identifier,
		['@type'] = 'player_ears'
	})

	if Result_Earring[1] then
		for k,v in pairs(Result_Earring) do
			local skin = json.decode(v.skin)
			table.insert(AccessoriesItems, {
				label = v.label,
				count = 1,
				limit = -1,
				type = "item_accessories",
				name = "earring",
				usable = true,
				rare = false,
				canRemove = false,
				itemnum = skin["ears_1"],
				itemskin = skin["ears_2"]
			})
		end
	end

	TriggerClientEvent("esx_inventoryhud:setOwnerAccessories", _source, AccessoriesItems)

end)

RegisterServerEvent('esx_inventoryhud:updateKey')
AddEventHandler('esx_inventoryhud:updateKey', function(target, type, itemName)

	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	local identifier = GetPlayerIdentifiers(source)[1]
	local identifier_target = GetPlayerIdentifiers(target)[1]
	if type == "item_key" then -- MEETA GiveKey

		MySQL.Async.execute("UPDATE owned_vehicles SET owner = @newplayer, buyer = @newplayer WHERE owner = @identifier AND plate = @plate",
		{
			['@identifier']		= identifier,
			['@newplayer']		= identifier_target,
			['@plate']		= itemName
		})
		
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = 'ส่ง <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = 'ได้รับ <strong class="amber-text">กุญแจรถ</strong> ทะเบียน <strong class="yellow-text">'..itemName..'</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		
		TriggerClientEvent("esx_inventoryhud:getOwnerVehicle", source)
		TriggerClientEvent("esx_inventoryhud:getOwnerVehicle", target)
		
		-- TriggerClientEvent("esx_trunk_inventory:getOwnedVehicule", source)
		-- TriggerClientEvent("esx_trunk_inventory:getOwnedVehicule", target)
		
	elseif type == "item_keyhouse" then -- MEETA GiveKeyHouse

		MySQL.Async.execute("UPDATE owned_properties SET owner = @newplayer WHERE owner = @identifier AND id = @id",
		{
			['@identifier']		= identifier,
			['@newplayer']		= identifier_target,
			['@id']		= itemName
		})

		TriggerClientEvent("pNotify:SendNotification", source, {
			text = 'ส่ง <strong class="amber-text">กุญแจบ้าน</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
		TriggerClientEvent("pNotify:SendNotification", target, {
			text = 'ได้รับ <strong class="amber-text">กุญแจบ้าน</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})

		TriggerClientEvent("esx_inventoryhud:getOwnerHouse", source)
		TriggerClientEvent("esx_inventoryhud:getOwnerHouse", target)

	end
end)

ESX.RegisterServerCallback("esx_inventoryhud:getPlayerInventory", function(source, cb, target)

	local xPlayer = ESX.GetPlayerFromId(target)
--	local Inventory = targetXPlayer.inventory

	if xPlayer ~= nil then
		cb({inventory = xPlayer.inventory, money = xPlayer.money, accounts = xPlayer.accounts, weapons = xPlayer.loadout})
	else
		cb(nil)
	end

end)

ESX.RegisterServerCallback("esx_inventoryhud:getPlayerInventory1", function(source, cb, target, data)

	local xPlayer = ESX.GetPlayerFromId(target)
	local Inventory = xPlayer.inventory

	if data == nil then
		if xPlayer ~= nil then
			cb({inventory = Inventory, money = xPlayer.money, accounts = xPlayer.accounts, weapons = xPlayer.loadout})
		else
			cb(nil)
		end
	else

		if data.vehicle == true then

			local Vehicle_Key = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', {
				['@identifier'] = xPlayer.identifier
			})

			for i=1, #Vehicle_Key, 1 do
				table.insert(Inventory, {
					label = Vehicle_Key[i].plate,
					count = 1,
					limit = -1,
					type = "item_key",
					name = "key",
					usable = true,
					rare = false,
					canRemove = false
				})
			end
			
		end

		if data.house == true then

			local Properties_Key = MySQL.Sync.fetchAll('SELECT * FROM owned_properties WHERE owner = @identifier', {
				['@identifier'] = xPlayer.identifier
			})

			for i=1, #Properties_Key, 1 do
				table.insert(Inventory, {
					label = Properties_Key[i].name,
					count = 1,
					limit = -1,
					type = "item_keyhouse",
					name = "keyhouse",
					usable = false,
					rare = false,
					canRemove = false,
					house_id = Properties_Key[i].id
				})
			end
		end

		-- Accessories Helmet
		local Result_Helmet = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_helmet'
		})

		if Result_Helmet[1] then
			for k,v in pairs(Result_Helmet) do
				local skin = json.decode(v.skin)
				table.insert(Inventory, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "helmet",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["helmet_1"],
					itemskin = skin["helmet_2"]
				})
			end
		end

		-- Accessories Mask
		local Result_Mask = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_mask'
		})

		if Result_Mask[1] then
			for k,v in pairs(Result_Mask) do
				local skin = json.decode(v.skin)
				table.insert(Inventory, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "mask",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["mask_1"],
					itemskin = skin["mask_2"]
				})
			end
		end

		-- Accessories Glasses
		local Result_Glasses = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_glasses'
		})

		if Result_Glasses[1] then
			for k,v in pairs(Result_Glasses) do
				local skin = json.decode(v.skin)
				table.insert(Inventory, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "glasses",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["glasses_1"],
					itemskin = skin["glasses_2"]
				})
			end
		end

		-- Accessories Earring
		local Result_Earring = MySQL.Sync.fetchAll('SELECT * FROM meeta_accessory_inventory WHERE owner = @owner AND type = @type', {
			['@owner'] = xPlayer.identifier,
			['@type'] = 'player_ears'
		})

		if Result_Earring[1] then
			for k,v in pairs(Result_Earring) do
				local skin = json.decode(v.skin)
				table.insert(Inventory, {
					label = v.label,
					count = 1,
					limit = -1,
					type = "item_accessories",
					name = "earring",
					usable = true,
					rare = false,
					canRemove = false,
					itemnum = skin["ears_1"],
					itemskin = skin["ears_2"]
				})
			end
		end

		if xPlayer ~= nil then
			cb({inventory = Inventory, money = xPlayer.getMoney(), accounts = xPlayer.accounts, weapons = xPlayer.loadout})
		else
			cb(nil)
		end
	end

end)--]]
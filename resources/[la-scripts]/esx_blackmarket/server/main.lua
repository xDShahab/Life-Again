ESX             = nil
local ShopItems = {}
local BlackMarketHandeler

exports.ghmattimysql:execute('SELECT * FROM capture WHERE name = "black_market"', {}
, function(blackmarket)
	BlackMarketHandeler = 'gang_' .. string.lower(blackmarket[1].handeler)
end)

RegisterServerEvent('blackmarket:ChangeHandeler')
AddEventHandler('blackmarket:ChangeHandeler', function(newHandler)
	BlackMarketHandeler = 'gang_' .. string.lower(newHandler)
	exports.ghmattimysql:execute('UPDATE capture SET handeler = @handeler WHERE name = "black_market"', {
		['@handeler']	= newHandler
	})
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM blackmarket LEFT JOIN items ON items.name = blackmarket.item', {}, function(shopResult)
		for i=1, #shopResult, 1 do
			if shopResult[i].name then
				if ShopItems[shopResult[i].store] == nil then
					ShopItems[shopResult[i].store] = {}
				end

				if shopResult[i].limit == -1 then
					shopResult[i].limit = 30
				end

				table.insert(ShopItems[shopResult[i].store], {
					label = shopResult[i].label,
					item  = shopResult[i].item,
					price = shopResult[i].price,
					limit = shopResult[i].limit
				})
			else
				print(('esx_blackmarket: invalid item "%s" found!'):format(shopResult[i].item))
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_blackmarket:requestDBItems', function(source, cb)
	cb(ShopItems)
end)

RegisterServerEvent('esx_blackmarket:buyItem')
AddEventHandler('esx_blackmarket:buyItem', function(itemName, amount, zone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	amount = ESX.Math.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		print('esx_blackmarket: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		return
	end

	-- get price
	local price = 0
	local itemLabel = ''

	for i=1, #ShopItems[zone], 1 do
		if ShopItems[zone][i].item == itemName then
			price = ShopItems[zone][i].price
			itemLabel = ShopItems[zone][i].label
			break
		end
	end

	price = price * amount

	-- can the player afford this item?
	if xPlayer.money >= price then
		-- can the player carry the said amount of x item?
		if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
			TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
		else
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(itemName, amount)
			-- TriggerEvent('gangaccount:getGangAccount', BlackMarketHandeler, function(account)
			-- 	account.addMoney(price*0.9)
			-- end)
			TriggerClientEvent('esx:showNotification', _source, _U('bought', amount, itemLabel, ESX.Math.GroupDigits(price)))
		end
	else
		local missingMoney = price - xPlayer.money
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough', ESX.Math.GroupDigits(missingMoney)))
	end
end)

RegisterServerEvent('esx_blackmarket:additem')
AddEventHandler('esx_blackmarket:additem', function(itemName)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(itemName) == "string" then
		
		if itemName == "drill" or itemName == "blowtorch" then

			xPlayer.addInventoryItem(itemName, 1)

			if itemName == "drill" then

				TriggerClientEvent('esx:showNotification', source, 'Shoma ba movafaghiat 1x Drill  sakhtid')

			elseif itemName == "blowtorch" then
			
				TriggerClientEvent('esx:showNotification', source, 'Shoma ba movafaghiat 1x BlowTorch  sakhtid')
				
			end

		else

			print(tostring(GetPlayerName(source)) .. ' Sai kard az lua injector estefade konad')

		end

	else

		print(tostring(GetPlayerName(source)) .. ' Sai kard az lua injector estefade konad')

	end

end)
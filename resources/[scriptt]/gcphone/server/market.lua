ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function MarketGetItem (accountId, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll([===[
      SELECT *
      FROM phone_shops
      ]===], {}, cb)
  end 


RegisterServerEvent('gcPhone:market_getItem')
AddEventHandler('gcPhone:market_getItem', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
    MarketGetItem(nil, function (markets)
      TriggerClientEvent('gcPhone:market_getItem', sourcePlayer, markets)
    end)
end)

RegisterServerEvent('gcPhone:buyMarket')
AddEventHandler('gcPhone:buyMarket', function(itemName, amount, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	amount = ESX.Math.Round(amount)

	-- is the player trying to exploit?
	if amount < 0 then
		-- print('gcPhone: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		return
	end

	-- get price
	local itemLabel = ''

	price = price * amount

	-- can the player afford this item?
	if xPlayer.bank >= price then
		-- can the player carry the said amount of x item?
		if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
			TriggerClientEvent('esx:ShowNotification', _source, "you do ~r~not~s~ have enough ~y~free space~s~ in your inventory!")
		else
			xPlayer.removeBank(price)
            local time = 10 -- 10 seconds
            while (time ~= 0) do -- Whist we have time to wait
               Wait( 1000 ) -- Wait a second
               time = time - 1
		       TriggerClientEvent('esx:ShowNotification', _source, "Time Remaining " .. time)
               -- 1 Second should have past by now
            end
			xPlayer.addInventoryItem(itemName, amount)
			TriggerClientEvent('esx:ShowNotification', _source, "" .. price .. " receipt " .. itemName .. ".")
		end
	else
		local missingMoney = price - xPlayer.bank
		TriggerClientEvent('esx:ShowNotification', _source, "you do not have ~r~enough~s~ money, you\'re ~y~missing~s~ ~r~" .. missingMoney .. "$~s~!")
	end
end)


--====================================================================================

--====================================================================================

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_tattooshop:requestPlayerTattoos', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.Async.fetchAll('SELECT tattoos FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		cb()
	end
end)

ESX.RegisterServerCallback('esx_tattooshop:purchaseTattoo', function(source, cb, tattooList, price, tattoo)
	local xPlayer = ESX.GetPlayerFromId(source)

		xPlayer.removeMoney(price)
		table.insert(tattooList, tattoo)

		MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', {
			['@tattoos'] = json.encode(tattooList),
			['@identifier'] = xPlayer.identifier
		})

		TriggerClientEvent('esx:showNotification', source, _U('bought_tattoo', ESX.Math.GroupDigits(price)))
		cb(true)
	
end)

----Delete Tato
RegisterServerEvent('esx_tattoshop:delete')
AddEventHandler('esx_tattoshop:delete', function(source)
    local SteamHex =  GetPlayerIdentifier(source)
    local pppp = '[]'
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            if data[1] then
                MySQL.Async.execute('UPDATE users SET tattoos = @tattoos WHERE identifier = @identifier', 
                {
                    ['@tattoos']    = pppp,
                    ['@identifier'] = SteamHex
                })				
            end
        end)
    end)
	TriggerClientEvent('aduty:sync', source)
end)

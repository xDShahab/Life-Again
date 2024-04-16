ESX = nil
local shopItems = {}
local WeaponHandeler

exports.ghmattimysql:execute('SELECT * FROM capture WHERE name = "black_market"', {}
, function(black_market)
	WeaponHandeler = 'gang_' .. string.lower(black_market[1].handeler)
end)

RegisterServerEvent('blackmarket:ChangeHandeler')
AddEventHandler('blackmarket:ChangeHandeler', function(newHandler)
	WeaponHandeler = 'gang_' .. string.lower(newHandler)
	exports.ghmattimysql:execute('UPDATE capture SET handeler = @handeler WHERE name = "black_market"', {
		['@handeler']	= newHandler
	})
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()

	MySQL.Async.fetchAll('SELECT * FROM weashops', {}, function(result)
		for i=1, #result, 1 do
			if shopItems[result[i].zone] == nil then
				shopItems[result[i].zone] = {}
			end

			table.insert(shopItems[result[i].zone], {
				item  = result[i].item,
				price = result[i].price,
				label = ESX.GetWeaponLabel(result[i].item)
			})
		end

		TriggerClientEvent('esx_weaponshop:sendShop', -1, shopItems)
	end)

end)

ESX.RegisterServerCallback('esx_weaponshop:getShop', function(source, cb)
	cb(shopItems)
end)

ESX.RegisterServerCallback('esx_weaponshop:buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.money >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
		TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
		cb(false)
	end
end)

function warn(source,  message)
	local name = GetPlayerName(source)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
	  local xP = ESX.GetPlayerFromId(xPlayers[i])
	  if xP.permission_level > 0 then
		TriggerClientEvent('chatMessage', xPlayers[i], "", {955, 0, 0}, "[Justice-AC] ^2" .. name .. "^7(^3" ..source.."^7) :  " .. message .. "^4")
	  end
	end
end


ESX.RegisterServerCallback('esx_weaponshop:buyWeapon', function(source, cb, weaponName, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPrice(weaponName, zone)

	if price == 0 then
		warn(source, 'Try To Add Weapon **GunShop Script**')
		cb(false)
	end

	if xPlayer.hasWeapon(weaponName) then
		TriggerClientEvent('esx:showNotification', source, _U('already_owned'))
		cb(false)
	else
		if weaponName == 'WEAPON_SNSPISTOL' or weaponName == 'WEAPON_FLASHLIGHT' or weaponName == 'WEAPON_BAT' or weaponName == 'WEAPON_SWITCHBLADE' or weaponName == 'WEAPON_PISTOL' then

		else
			warn(source, 'Try To Add Weapon **GunShop Script**')
		end

		if zone == 'BlackWeashop' then

			if xPlayer.money >= price then
				xPlayer.removeMoney(price)
				xPlayer.addWeapon(weaponName, 42)

				TriggerEvent('gangaccount:getGangAccount', WeaponHandeler, function(account)
					account.addMoney(price*0.9)
				end)

				cb(true)
			else
				TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
				cb(false)
			end

		else

			if xPlayer.money >= price then
				xPlayer.removeMoney(price)
				xPlayer.addWeapon(weaponName, 42)

				cb(true)
			else
				TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
				cb(false)
			end
	
		end
	end
end)

function GetPrice(weaponName, zone)
	local price = MySQL.Sync.fetchScalar('SELECT price FROM weashops WHERE zone = @zone AND item = @item', {
		['@zone'] = zone,
		['@item'] = weaponName
	})

	if price then
		return price
	else
		return 0
	end
end

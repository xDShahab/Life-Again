local firstSpawn = nil
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('getSkin', function(source, cb)
	getSkin(source, function(skin)
		cb(skin)
	end)
end)

RegisterServerEvent("updateSkin")
AddEventHandler("updateSkin", function(skin)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.identifier

		exports.ghmattimysql:execute('UPDATE users SET `skin` = @skin, `gender` = @sex WHERE identifier = @identifier',
			{
				['@skin']       = json.encode(skin),
				['@sex']		= skin.sex,
				['@identifier'] = player
			})

	end)
end)

function getSkin(source, cb)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		exports.ghmattimysql:scalar('SELECT skin FROM users WHERE identifier = @identifier', {
			['@identifier'] = user.identifier
		}, function(skin)

			if skin ~= nil and #skin > 2 then
				cb(true)
			else
				cb(false)
			end
		end)
	end)
end

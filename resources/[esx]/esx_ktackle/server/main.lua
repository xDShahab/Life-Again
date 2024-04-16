ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local AS, ASWarn = {}, {}

RegisterServerEvent('esx_kekke_tackle:tryTackle')
AddEventHandler('esx_kekke_tackle:tryTackle', function(target)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local targetPlayer = ESX.GetPlayerFromId(target)
	for k, v in pairs(Config.WhiteListedJobs) do
		if xPlayer.job.name == v then
			if not AS[_source] then
				---if exports['Eye-AC']:CheckPlayers(_source, target, 8.0) ~= false then return end
				AS[_source] = true
				TriggerClientEvent('esx_kekke_tackle:getTackled', targetPlayer.source, _source)
				TriggerClientEvent('esx_kekke_tackle:playTackle', _source)
				SetTimeout(9000, function() AS[_source] = nil end)
			else
				if not ASWarn[_source] then
					TriggerEvent('esx_best:adminWarn', _source, "Mashkuk be Bring All ast (Shift + G Method)")
					ASWarn[_source] = true
					SetTimeout(2000, function() ASWarn[_source] = nil end)
				end
			end
			return
		end
	end
	
	print(xPlayer.identifier .. " sa'y kard " .. targetPlayer.identifier .. " ro Shift + G kone!")
end)
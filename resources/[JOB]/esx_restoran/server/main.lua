ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'restoran', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumberjlland', 'restoran', _U('alert_restoran'), true, true)
TriggerEvent('esx_society:registerSociety', 'restoran', 'restoran', 'society_restoran', 'society_restoran', 'society_restoran', {type = 'public'})


AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_restoran_job:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'restoran')
	end
end)

RegisterServerEvent('SL_Restoran:GiveItem')
AddEventHandler('SL_Restoran:GiveItem', function(id, name)
	local _source = source
	if _source ~= id then
		return
	else
		local Xplayer = ESX.GetPlayerFromId(id)
		Xplayer.addInventoryItem(name, 1)
		TriggerClientEvent('esx:showNotification', _source, '+1 '..name)
	end
end)
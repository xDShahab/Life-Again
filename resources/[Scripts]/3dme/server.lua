
RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, chat)    
	local ped = GetPlayerPed(source)
    -- local playerCoords = GetEntityCoords(ped)
    local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source, chat, ped_NETWORK)
end)
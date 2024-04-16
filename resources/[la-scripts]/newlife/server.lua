
RegisterServerEvent('ambulacne:startext')
AddEventHandler('ambulacne:startext', function(text, chat)    
	local ped = GetPlayerPed(source)
    local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
	TriggerClientEvent('ambulance:showtex', -1, text, source, chat, ped_NETWORK)
end)
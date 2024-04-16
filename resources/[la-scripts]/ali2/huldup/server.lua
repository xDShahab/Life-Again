RegisterServerEvent('la_handsup:getSurrenderStatus')
AddEventHandler('la_handsup:getSurrenderStatus', function(event,targetID)
	TriggerClientEvent("la_handsup:getSurrenderStatusPlayer",targetID,event,source)
end)

RegisterServerEvent('la_handsup:sendSurrenderStatus')
AddEventHandler('la_handsup:sendSurrenderStatus', function(event,targetID,handsup)
	TriggerClientEvent(event,targetID,handsup)
end)

RegisterServerEvent('la_handsup:reSendSurrenderStatus')
AddEventHandler('la_handsup:reSendSurrenderStatus', function(event,targetID,handsup)
	TriggerClientEvent(event,targetID,handsup)
end)
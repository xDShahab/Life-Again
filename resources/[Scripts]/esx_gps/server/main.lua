ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

AddEventHandler('esx:onAddInventoryItem', function(source, item, count)
	if item.name == 'phone' then
		TriggerClientEvent('esx_gps:addGPS', source)
	end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
	if item.name == 'phone' and item.count < 1 then
		TriggerClientEvent('esx_gps:removeGPS', source)
	end
end)
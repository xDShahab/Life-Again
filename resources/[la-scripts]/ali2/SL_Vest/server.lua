ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)





ESX.RegisterUsableItem('vest10', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('EmZ-Vest:startVestAnim', source)
    TriggerClientEvent('esx:showNotification', source, '+10% Vest')
    xPlayer.removeInventoryItem('vest10', 1)
    TriggerClientEvent('Vestsystem:vest10', source)


end)



ESX.RegisterUsableItem('vest20', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('EmZ-Vest:startVestAnim', source)
    xPlayer.removeInventoryItem('vest20', 1)
    TriggerClientEvent('esx:showNotification', source, '+20% Vest')
    TriggerClientEvent('Vestsystem:vest20', source)
end)




ESX.RegisterUsableItem('vest30', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('EmZ-Vest:startVestAnim', source)
    xPlayer.removeInventoryItem('vest30', 1)
    TriggerClientEvent('esx:showNotification', source, '+30% Vest')
    TriggerClientEvent('Vestsystem:vest30', source)
end)




ESX.RegisterUsableItem('vest40', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('EmZ-Vest:startVestAnim', source)
    xPlayer.removeInventoryItem('vest40', 1)
    TriggerClientEvent('esx:showNotification', source, '+40% Vest')
    TriggerClientEvent('Vestsystem:vest40', source)
end)





ESX.RegisterUsableItem('vest50', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('EmZ-Vest:startVestAnim', source)

    xPlayer.removeInventoryItem('vest50', 1)
    TriggerClientEvent('esx:showNotification', source, '+50% Vest')
    TriggerClientEvent('Vestsystem:vest50', source)
end)
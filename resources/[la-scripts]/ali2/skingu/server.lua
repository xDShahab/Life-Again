ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('skingun', function(source)
    TriggerClientEvent('hujo_tint:aloita', source)
end)






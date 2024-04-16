ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterUsableItem("radio", function(source) 
    TriggerClientEvent("radio", source)
end)

ESX.RegisterServerCallback("CheckRadio", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem("radio").count > 0 then
        cb(true)
    else
        cb(false)
    end
end)
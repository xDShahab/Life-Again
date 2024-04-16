ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > xPlayer.money then
            amount = xPlayer.money
        end
        xPlayer.removeMoney(amount)
        xPlayer.addBank(tonumber(amount))
    end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.bank
    if amount == nil or amount <= 0 then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        if amount > base then
            amount = base
        end
        xPlayer.removeBank(amount)
        xPlayer.addMoney(amount)
    end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.bank
    TriggerClientEvent('currentbalance1', _source, balance)

end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil and GetPlayerEndpoint(to) ~= nil then
        balance = xPlayer.bank
        zbalance = zPlayer.bank
        if tonumber(_source) == tonumber(to) then
            TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank',
                               'Transfer Money',
                               'You cannot transfer to your self!',
                               'CHAR_BANK_MAZE', 9)
        else
            if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <=
                0 then
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Bank', 'Transfer Money',
                                   'Not enough money to transfer!',
                                   'CHAR_BANK_MAZE', 9)
            else
                xPlayer.removeBank(tonumber(amountt))
                zPlayer.addBank(tonumber(amountt))
                TriggerClientEvent('esx:showAdvancedNotification', _source,
                                   'Bank', 'Transfer Money',
                                   'You transfered $' .. amountt ..
                                       ' to ' .. to .. ' .',
                                   'CHAR_BANK_MAZE', 9)
                TriggerClientEvent('esx:showAdvancedNotification', to, 'Bank',
                                   'Transfer Money', 'You received $' ..
                                       amountt .. ' from ' .. _source ..
                                       ' .', 'CHAR_BANK_MAZE', 9)
            end

        end
    end

end)


local Players = {}

function AliRezacodsecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
    
end

RegisterNetEvent(
    "AliReza:KIRETKARDkoooni",
    function()
        if not Players[source] then
            Players[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "client/client.lua",Citizen.ResultAsString())
            AliRezacodsecret("AliReza:KIRETKARDkoooni", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsecret("AliReza:KIRETKARDkoooni", source, Code_)
            Citizen.Wait(4000)
            DropPlayer(source, "mayel be lavat ?")
        end
    end
)

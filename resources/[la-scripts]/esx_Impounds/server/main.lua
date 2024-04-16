ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('AT_Impound:FindPlateOwnerName', function(source, cb, plate)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', 
    {
        ['@plate'] = ESX.Math.Trim(plate)

    }, function(data)
        SetTimeout(10000, function()
            if data[1] ~= nil then          
                MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @ident', 
                {
                    ['@ident'] = data[1].owner
                
                }, function(result)
                    local name = string.gsub(result[1].playerName, "_", " ")
                    cb(name, result[1].identifier)
                end)
            else
                cb("یافت نشد", "none")
            end
        end)
    end)
end)

RegisterServerEvent('AT_Impound:InsertFine')
AddEventHandler('AT_Impound:InsertFine', function(Tsteam, amount, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' then
        MySQL.Async.fetchAll('SELECT * FROM billing WHERE label = @label',
        {
            ['@label'] = ESX.Math.Trim(plate)
    
        }, function(data)
            if not data[1] then
                MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
                {
                    ['@identifier'] = Tsteam,
                    ['@sender'] = xPlayer.identifier,
                    ['@target_type'] = 'society',
                    ['@target'] = 'society_police',
                    ['@label'] = ESX.Math.Trim(plate),
                    ['@amount'] = amount,
                })
            else
                TriggerClientEvent('chatMessage', xPlayer.source, "[Impound]", {255, 0, 0}, " In Mashin Az Ghabl Jarime Shode Ast")
            end
        end)
    else
        print(source .. " Tried To Check Plate Witch Cheat")
    end
end)

ESX.RegisterServerCallback('AT_Impound:FindPlatesFromFine', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
    local Hex = xPlayer.identifier
    MySQL.Async.fetchAll('SELECT * FROM billing WHERE label = @label', 
    {
        ['@label'] = ESX.Math.Trim(plate)

    }, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)
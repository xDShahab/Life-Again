ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('gcPhone:getCars', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return; end
    MySQL.Async.fetchAll("SELECT plate, vehicle, state, garage FROM owned_vehicles WHERE owner = @cid and type = @type", {
        ["@cid"] = xPlayer.identifier,
        ["@type"] = "car"
    }, function(responses)
        local playerVehicles = {}

        for key, vehicleData in ipairs(responses) do
            if vehicleData["state"] ~= 0 and vehicleData["garage"] ~= 'OUT' then
                table.insert(playerVehicles, {
                    ["garage"] = vehicleData["garage"],
                    ["state"] = vehicleData["state"],
                    ["plate"] = vehicleData["plate"],
                    ["props"] = json.decode(vehicleData["vehicle"])
                })
            end
        end
        cb(playerVehicles)
    end)
end)

RegisterServerEvent('gcPhone:finish')
AddEventHandler('gcPhone:finish', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx:ShowNotification', _source, _U('vale_get'))
	xPlayer.removeBank(Config.ValePrice)
end)

RegisterServerEvent('gcPhone:valet-car-set-outside')
AddEventHandler('gcPhone:valet-car-set-outside', function(plate)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        MySQL.Sync.execute("UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = "OUT" , ['@plate'] = plate})
		MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state WHERE plate=@plate",{['@state'] = 0 , ['@plate'] = plate})
    end
end)

--====================================================================================

--====================================================================================
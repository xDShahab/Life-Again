ESX              = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vehicleshop.requestInfo')
AddEventHandler('vehicleshop.requestInfo', function()
    local src = source
    local rows    

    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = GetPlayerIdentifiers(src)[1]

    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })

    local firstname = result[1].firstname 

    local resultVehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles')

    TriggerClientEvent('vehicleshop.receiveInfo', src, xPlayer.bank, firstname)    

    TriggerClientEvent("vehicleshop.vehiclesInfos", src , resultVehicles)

    TriggerClientEvent("vehicleshop.notify", src, 'error', _U('rotate_keys'))
end)

RegisterServerEvent('vehicleshop.test')
AddEventHandler('vehicleshop.test', function(state)
    if state == 'start' then
        SetPlayerRoutingBucket(source, 86)
    elseif state == 'finish' then
        SetPlayerRoutingBucket(source, 0)
    end
end)
--type in chat /transfervehicle <player-id number> "car plate"
--Example /transfervehicle 1 "ABC 123" will transfer the car with plate "ABC 123" to the player
-- who has the id 1 (the player of course needs to be online)


RegisterCommand('transfervehicle', function(source, args)

    
    myself = source
    other = args[1]
    
    if(GetPlayerName(tonumber(args[1])))then
            
    else
            
            TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
            return
    end
    
    
    local plate = args[2]
    
    mySteamID = GetPlayerIdentifiers(source)
    mySteam = mySteamID[1]
    myID = ESX.GetPlayerFromId(source).identifier
    myName = ESX.GetPlayerFromId(source).name

    targetSteamID = GetPlayerIdentifiers(args[1])
    targetSteamName = ESX.GetPlayerFromId(args[1]).name
    targetSteam = targetSteamID[1]
    
    MySQL.Async.fetchAll(
        'SELECT * FROM owned_vehicles WHERE plate = @plate',
        {
            ['@plate'] = plate
        },
        function(result)
            if result[1] ~= nil then
                local playerName = ESX.GetPlayerFromIdentifier(result[1].owner).identifier
                local pName = ESX.GetPlayerFromIdentifier(result[1].owner).name
                CarOwner = playerName
                print("Car Transfer ", myID, CarOwner)
                if myID == CarOwner then
                    print("Transfered")
                    
                    data = {}
                        TriggerClientEvent('chatMessage', other, "^4Vehicle with the plate ^*^1" .. plate .. "^r^4was transfered to you by: ^*^2" .. myName)
            
                        MySQL.Sync.execute("UPDATE owned_vehicles SET owner=@owner WHERE plate=@plate", {['@owner'] = targetSteam, ['@plate'] = plate})
                        TriggerClientEvent('chatMessage', source, "^4You have ^*^3transfered^0^4 your vehicle with the plate ^*^1" .. plate .. "\" ^r^4to ^*^2".. targetSteamName)
                else
                    print("Did not transfer")
                    TriggerClientEvent('chatMessage', source, "^*^1You do not own the vehicle")
                end
            else
                TriggerClientEvent('chatMessage', source, "^1^*ERROR: ^r^0This vehicle plate does not exist or the plate was incorrectly written.")
            end
        
        end
    )
    
end)

-- RegisterCommand('carc',function(source,args)
--     if args[1] and args[2] then
--         MySQL.Async.fetchAll(
--             'SELECT * FROM vehicles WHERE model = @model',
--             {
--                 ['@model'] = args[1]
--             },
--             function(result)
--                 if result[1] ~= nil then
--                     MySQL.Sync.execute("UPDATE vehicles SET price=@price WHERE model=@model", {['@model'] = args[1], ['@price'] = args[2]})
--                     TriggerClientEvent('chatMessage', source, "^4You have ^*^3changed^0^4 the vehicle price to "..args[2])
--                 else
--                     TriggerClientEvent('chatMessage', source, "^1^*ERROR: ^r^0This vehicle name does not exist.")
--                 end
--         end)
--     end 
-- end)

ESX.RegisterServerCallback('vehicleshop.isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('vehicleshop.CheckMoneyForVeh')
AddEventHandler('vehicleshop.CheckMoneyForVeh', function(veh, price, name, vehicleProps)
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer == nil then
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM vehicles WHERE model = @model LIMIT 1', {
		['@model'] = veh
    }, function (result)
        if #result > 0 then
            local veiculo = result[1]
            local vehicleModel = veh
            local vehiclePrice = price
            local carname = result[1].model   
            if GetHashKey(vehicleModel) then           
                if xPlayer.money >= tonumber(vehiclePrice) then
                    xPlayer.removeMoney(tonumber(vehiclePrice))                   
                    local vehiclePropsjson = json.encode(vehicleProps)
                    
                    local stateVehicle = 0 

                    if Config.SpawnVehicle then
                        stateVehicle = 0
                    else
                        stateVehicle = 1
                    end 
                    
                    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)',
                    {
                        ['@owner']   = xPlayer.identifier,
                        ['@plate']   = vehicleProps.plate,
                        ['@vehicle'] = vehiclePropsjson,
                        ['@stored'] = stateVehicle,
                    },
                    
                    function (rowsChanged)  
          
                        -- MySQL.Sync.execute('UPDATE vehicles SET stock = @stock WHERE model = @model',
                        -- {
                        --     ['@stock'] = stockQtd,
                        --     ['@model'] = vehicleModel
                        -- })
                        TriggerClientEvent("vehicleshop.sussessbuy", source, name, vehicleProps.plate, vehiclePrice)
                        TriggerClientEvent('vehicleshop.receiveInfo', source, xPlayer.bank)    
                        TriggerClientEvent('vehicleshop.spawnVehicle', source, vehicleModel, vehicleProps.plate)                       
                    end)
                elseif xPlayer.bank >= tonumber(vehiclePrice) then
                    TriggerClientEvent("vehicleshop.notify", source, 'error', 'Baray kharid Mashin AZ Pol Naghd Estefade Knid In Carshop Ba Bank ha Moamele Nemikone')
                else
                    TriggerClientEvent("vehicleshop.notify", source, 'error', _U('enough_money'))
                end
            else
                TriggerClientEvent("vehicleshop.notify", source, 'error', _U('we_dont_vehicle'))
            end  
        end
	end)
end)








RegisterServerEvent('vehicleshop.CheckbtcForVeh')
AddEventHandler('vehicleshop.CheckbtcForVeh', function(veh, price, name, vehicleProps)
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer == nil then
        return
    end

    MySQL.Async.fetchAll('SELECT * FROM vehicles WHERE model = @model LIMIT 1', {
		['@model'] = veh
    }, function (result)
        if #result > 0 then
            local veiculo = result[1]
            local vehicleModel = veh
            local vehiclePrice = math.floor(price/20000)
            local carname = result[1].model   
            if GetHashKey(vehicleModel) then           
                if xPlayer.lc >= tonumber(vehiclePrice) then
                    xPlayer.removelc(tonumber(vehiclePrice))                  
                    local vehiclePropsjson = json.encode(vehicleProps)
                    
                    local stateVehicle = 0 

                    if Config.SpawnVehicle then
                        stateVehicle = 0
                    else
                        stateVehicle = 1
                    end 
                    
                    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored) VALUES (@owner, @plate, @vehicle, @stored)',
                    {
                        ['@owner']   = xPlayer.identifier,
                        ['@plate']   = vehicleProps.plate,
                        ['@vehicle'] = vehiclePropsjson,
                        ['@stored'] = stateVehicle,
                    },
                    
                    function (rowsChanged)                     
                        -- MySQL.Sync.execute('UPDATE vehicles SET stock = @stock WHERE model = @model',
                        -- {
                        --     ['@stock'] = stockQtd,
                        --     ['@model'] = vehicleModel
                        -- })
                        TriggerClientEvent("vehicleshop.sussessbuy", source, name, vehicleProps.plate, vehiclePrice)
                        TriggerClientEvent('vehicleshop.receiveInfo', source, xPlayer.bank)    
                        TriggerClientEvent('vehicleshop.spawnVehicle', source, vehicleModel, vehicleProps.plate)                       
                    end)
                else
                    TriggerClientEvent("vehicleshop.notify", source, 'error', _U('enough_money'))
                end
            else
                TriggerClientEvent("vehicleshop.notify", source, 'error', _U('we_dont_vehicle'))
            end  
        end
	end)
end)

RegisterServerEvent('vehicleshop.upcolor')
AddEventHandler('vehicleshop.upcolor', function(plate, vehicleProps)
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer == nil then
        return
    end

    MySQL.Async.fetchAll(
        'SELECT * FROM owned_vehicles WHERE plate = @plate',
        {
            ['@plate'] = plate
        },
        function(result)
            if result[1] ~= nil then
                local vehiclePropsjson = json.encode(vehicleProps)
                MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@vehicle WHERE plate=@plate", {['@vehicle'] = vehiclePropsjson, ['@plate'] = plate})
            end
        end
    )
end)

RegisterServerEvent('esx_vehicleshop:AdminsetVehicleOwnedPlayerId')
AddEventHandler('esx_vehicleshop:AdminsetVehicleOwnedPlayerId', function (playerId, vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	local xPlayerSource = ESX.GetPlayerFromId(source)
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
		{
			['@owner']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps)
		}, function (rowsChanged)
			TriggerClientEvent('esx:ShowNotification', playerId, 'an vehicle with plate '..vehicleProps.plate..' now belongs to you')
            TriggerClientEvent('esx:ShowNotification', _source, 'Added')
		end)

end)

RegisterServerEvent('esx_vehicleshop:setVehicleGang')
AddEventHandler('esx_vehicleshop:setVehicleGang', function (vehicleProps, society)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.permission_level >= 10 then
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job) VALUES (@owner, @plate, @vehicle, @job)',
		{
			['@owner']   = society,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps),
			['@job']	 = 'gang'
		}, function (rowsChanged)
			TriggerClientEvent('esx:ShowNotification', _source, 'an vehicle with plate '..vehicleProps.plate..' added for '..society..'')
		end)
	else
		TriggerClientEvent('esx:deleteVehicle', _source)
		print(('esx_vehicleshop: %s attempted to inject vehicle!'):format(xPlayer.identifier))
	end

end)

RegisterServerEvent('esx_vehicleshop:setaaaaaaaaaa')
AddEventHandler('esx_vehicleshop:setaaaaaaaaaa', function (playerId, vehicleProps)
	local _source = source
    local xPlayers = ESX.GetPlayerFromId(playerId)
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.permission_level >= 10 then
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job) VALUES (@owner, @plate, @vehicle, @job)',
		{
			['@owner']   = xPlayers.identifier,
			['@plate']   = vehicleProps.plate,
			['@vehicle'] = json.encode(vehicleProps),
			['@job']	 = 'nil'
		}, function (rowsChanged)
			TriggerClientEvent('esx:ShowNotification', _source, 'an vehicle with plate '..vehicleProps.plate..' added ')
		end)
	else
		TriggerClientEvent('esx:deleteVehicle', _source)
		print(('esx_vehicleshop: %s attempted to inject vehicle!'):format(xPlayer.identifier))
	end

end)




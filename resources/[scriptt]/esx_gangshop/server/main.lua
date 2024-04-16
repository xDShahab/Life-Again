ESX = nil
local Categories     = {}
local Vehicles       = {}
local carinsearch    = {}
local ped

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	Categories     = MySQL.Sync.fetchAll('SELECT * FROM vehicle_categories')
	local vehicles = MySQL.Sync.fetchAll('SELECT * FROM vehicles')

	for i=1, #vehicles, 1 do
		local vehicle = vehicles[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == vehicle.category then
				vehicle.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Vehicles, vehicle)
	end
end)

-- Citizen.CreateThread(function ()
--     ped = creatped(4, GetHashKey("s_m_y_xmech_02"),3802.47,4475.57,6.0, 3374176, true, true)
--     while not DoesEntityExist(ped) do
--         Wait(0)
--     end
--     SetEntityHeading(ped, 161.81)
--     FreezeEntityPosition(ped, true)
--     TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
--     Citizen.CreateThread(function()
--         while true do
--                 TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
--                 Citizen.Wait(0)
--         end
--     end)
-- end)

-- ESX.RegisterServerCallback('esx_chopshop:getped', function(source,cb)
--     while not DoesEntityExist(ped) do
--         Wait(100)
--     end
--     cb(NetworkGetNetworkIdFromEntity(ped))
-- end)

-- AddEventHandler('onResourceStop', function(resourceName)
--     if (GetCurrentResourceName() ~= resourceName) then
--       return
--     end
--     DeleteEntity(ped)
-- end)

RegisterServerEvent('esx_chopshop:buy')
AddEventHandler('esx_chopshop:buy', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local found = false

	for i = 1, #Vehicles, 1 do
        if GetHashKey(Vehicles[i].model) == vehicleProps.model then
            vehicleData = Vehicles[i]
			found = true
            break
        end
	end
	if xPlayer.money >= math.floor((vehicleData.price*1.2)) then
	    if found then
		    xPlayer.removeMoney(math.floor((vehicleData.price*1.2)))
		    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, job, stored) VALUES (@owner, @plate, @vehicle, @job, @stored)',
		    {
			    ['@owner']   = xPlayer.gang.name,
			    ['@plate']   = vehicleProps.plate,
			    ['@vehicle'] = json.encode(vehicleProps),
			    ['@job']	 = xPlayer.gang.name,
                ['@stored']  = 0
		    }, function (rowsChanged)
                local buyArray = {
                    {
                        ["color"] = "15844367",
                        ["title"] = "Buy a Vehicle from ghazanfar",
                        ["description"] = "ID: **("..xPlayer.source..")**\nPlayer Name: **"..GetPlayerName(xPlayer.source).."**",
                        ["fields"] = {
                            {
                                ["name"] = "Plate:",
                                ["value"] = "**"..vehicleProps.plate.."**"
                            },
                            {
                                ["name"] = "Model:",
                                ["value"] = "**"..vehicleProps.model.."**"
                            },
                            {
                                ["name"] = "Hex:",
                                ["value"] = "**"..xPlayer.identifier.."**"
                            },
                            {
                                ["name"] = "Gang:",
                                ["value"] = "**"..xPlayer.gang.name.."**"
                            },
                            {
                                ["name"] = "Time:",
                                ["value"] = "**"..os.date('%Y-%m-%d %H:%M:%S').."**"
                            }
                        },
                        ["footer"] = {
                        ["text"] = "LifeAgain Log System",
                        ["icon_url"] = "https://images-ext-2.discordapp.net/external/0vGMcpkNpWqFIHDncU2lllVKrJ3r85yg2U5QIpFme4A/%3Fsize%3D1024/https/https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/avatars/529317233848090627/cbb9b29cb8af915ac19fb82073965113.png",
                        }
                    }
                }     
                TriggerEvent('DiscordBot:ToDiscord2', 'https://discoadadrd.com/adadadaapi/webhooks/910457708916924426/OS0UC6JXd5-4QcldKAljXfT1E2xfuJzOp3WFVHBCD1TtTsKZlNp-8ULBwbSCTnZjbqzT','Ghazanfar', buyArray) 
		    end)
		end
	end
end)

ESX.RegisterServerCallback('esx_chopshop:getprice', function(source,cb, name)
    local vehicleData
	for i = 1, #Vehicles, 1 do
        if GetHashKey(Vehicles[i].model) == GetHashKey(name) then
            vehicleData = Vehicles[i]
            break
        end
	end
    if vehicleData ~= nil then
        cb(math.floor(vehicleData.price*1.2))
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('esx_chopshop:canpay', function (source, cb, price)
	local xPlayer     = ESX.GetPlayerFromId(source)
	if xPlayer.money >= price then
		cb(true)
	else
		cb(false)
	end
end)


-- RegisterServerEvent('esx_chopshop:search')
-- AddEventHandler('esx_chopshop:search', function (plate)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)

--             -- TriggerClientEvent('esx:ShowNotification', xPlayer.source, 'Bach haro ferestadam donbalehs')
--             table.insert(carinsearch, plate)
--             if xPlayer.money >= 10000 then
--                     xPlayer.removeMoney(10000)
--                     local time = math.random(60, 300)
--                     Citizen.SetTimeout(time*1000,function ()
--                         for _, value in ipairs(carinsearch) do
--                             if value == plate then
--                                 table.remove(carinsearch, _)
--                                 break
--                             end
--                         end
--                         MySQL.Sync.execute("UPDATE owned_vehicles SET garage=@garage WHERE plate=@plate",{['@garage'] = 'gang' , ['@plate'] = plate})
--                         MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state WHERE plate=@plate",{['@state'] = 1 , ['@plate'] = plate})
--                         TriggerClientEvent('esx_chopshop:founded', xPlayer.source)
--                     end)
--             end
-- end)
-- ESX.RegisterServerCallback('esx_chopshop:issearched', function(source, cb, plate)
--     local can = true
--     for _, value in ipairs(carinsearch) do
--         if value == plate then
--             can = false
--         end
--     end
--     cb(can)
-- end)
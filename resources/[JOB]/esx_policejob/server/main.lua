ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local AS, ASWarn = {}, {}
local Webhook = "https://discord.com/api/webhooks/951179161349783592/HD64vERzESF74jbV-YTEDCSFvcubKbNi2vHCSfz3iIAx-69xPKSmSJj6J2O0enQAy8DF"

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumberjlland', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', 'society_police', 'society_police', {type = 'public'})

RegisterServerEvent('esx_policejob:giveWeapon')
AddEventHandler('esx_policejob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weapon, ammo)
end)



RegisterServerEvent('Aliat:warns1')
AddEventHandler('Aliat:warns1', function(dick)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ped = GetPlayerPed(source)
    -- local playerCoords = GetEntityCoords(ped)
    local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerName = GetPlayerName(_source)
    local dick2 = tostring(dick)
    local targetpm = string.sub(dick2,1)
    local name = GetPlayerName(_source)
    TriggerClientEvent("sendProximityMessagePolice", -1, _source, name, targetpm, ped_NETWORK)
end)

RegisterServerEvent('Aliat2:warns1')
AddEventHandler('Aliat2:warns1', function(dick)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ped = GetPlayerPed(source)
    -- local playerCoords = GetEntityCoords(ped)
    local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerName = GetPlayerName(_source)
    local dick2 = tostring(dick)
    local targetpm = string.sub(dick2,1)
	local name = GetPlayerName(_source)
	TriggerClientEvent("sendProximityMessageSheriff", -1, _source, name, targetpm, ped_NETWORK)
	
end)

RegisterServerEvent('esx_policejob:handcuffsirprog')
AddEventHandler('esx_policejob:handcuffsirprog', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('AntiCHEAT:bancheter',source , '🔞Try To Using TriggerServerEvent Bitch(esx_policejob:handcuffsirprog)🔞') end
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff'  then
		---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
		-- if exports.ImAlireza:GetCoords(source, target, 25.0) ~= false then return end
		TriggerClientEvent('esx_policejob:handcuffsirprog', target)
	else
		print(('esx_policejob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_policejob:aaadrag')
AddEventHandler('esx_policejob:aaadrag', function(target)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('AntiCHEAT:bancheter',source , '🔞Try To Using TriggerServerEvent Bitch(esx_policejob:aaadrag)🔞') end
	---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
	TriggerClientEvent('esx_policejob:aaadrag', target, source)
end)

RegisterServerEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function(target)
	---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 25 then return TriggerEvent('AntiCHEAT:bancheter',source , '🔞Try To Using TriggerServerEvent Bitch(esx_policejob:putInVehicle)🔞') end
	TriggerClientEvent('esx_policejob:putInVehicle', target)
end)

RegisterServerEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function(target)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 25 then return TriggerEvent('AntiCHEAT:bancheter',source , '🔞Try To Using TriggerServerEvent Bitch(esx_policejob:OutVehicle)🔞') end
	local xPlayer = ESX.GetPlayerFromId(source)
	---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
	TriggerClientEvent('esx_policejob:OutVehicle', target)
end)

RegisterServerEvent('esx_policejob:getStockItem')
AddEventHandler('esx_policejob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
				--TriggerEvent('DiscordBot:ToDiscord', 'pwi', xPlayer.name, 'Withdrawn x' ..count ..' '..inventoryItem.label ,'user', source, true, false)
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end
	end)

end)

RegisterServerEvent('esx_policejob:putStockItems')
AddEventHandler('esx_policejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

	end)

end)

RegisterCommand('findnumber', function(source, args, users)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "police" and xPlayer.job.grade > 0 then
        if args[1] then
            if string.len(args[1]) == 10 then
            local number = tonumber(args[1])
                if number then
                    MySQL.Async.fetchAll('SELECT playerName FROM users WHERE phone_number=@number', 
                    {
                        ['@number'] =  number
                    }, function(data)
                        if data[1] then
							TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0 In Shomare be naame ^3" .. string.gsub(data[1].playerName, "_", " ") .. " ^0Ast!"} })
                        else
							TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', "^0 In shomare vojoud nadarad"} })
                        end
                    end)
                else
					TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma dar ghesmat Shomare vaghat mitavanid adad vared konid!"} })
                end
            else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shomare bayad 11 raghami bashad!"} })
            end
        else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma dar ghesmat Shomare chizi vared nakardid!"} })
        end
    else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma police nistid!"} })
    end
end)

RegisterServerEvent("Aliat:newfinesystem")
AddEventHandler("Aliat:newfinesystem", function(targetSrc, jailTime, jailReason)
	local src 				= source
	local targetSrc 		= tonumber(targetSrc)
	local xPlayer 			= ESX.GetPlayerFromId(src)
	local jailPlayerData 	= ESX.GetPlayerFromId(targetSrc)

	if xPlayer.job.name == "police" or xPlayer.job.name == "sheriff" or xPlayer.job.name == "fbi" then
		JailPlayer(targetSrc, jailTime, 2, nil)

		TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ", "^3" .. jailPlayerData.name .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })

		TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " Zendani shod baraye ~h~" .. jailTime .. " Daghighe!")
	else
		TriggerEvent('Anticheat:AutoBan', src, {period = -1, reason = 'Talash Baraye Jarime kardane Player ha'})
	end
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrivedInfo.owner = result2[1].playerName
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(string.gsub(result2[1].playerName, "_", " "), true)
				else
					cb(string.gsub(result2[1].playerName, "_", " "), true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)

	end)

end)

ESX.RegisterServerCallback('esx_policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
		PerformHttpRequest(Webhook, function(err, text, headers)
		end, 'POST',
		json.encode({
		username = 'LifeAgain Rp',
		embeds =  {{["color"] = 65280,
					["author"] = {["name"] = 'LifeAgain Rp (Police Inventory)',
					["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
					["description"] = "" ..GetPlayerName(source).."\nWeapon : " ..weaponName.."   Gozasht ",
					["footer"] = {["text"] = "Time -> "..os.date("%x %X  %p"),
					["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
					},
		avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
		}),
		{['Content-Type'] = 'application/json'
		})
		--TriggerEvent('DiscordBot:ToDiscord', 'pwi', xPlayer.name, 'Deposited ' .. weaponName ,'user', source, true, false)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 10
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('esx_policejob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	PerformHttpRequest(Webhook, function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'LifeAgain Rp',
	embeds =  {{["color"] = 65280,
				["author"] = {["name"] = 'LifeAgain Rp (Police Inventory)',
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
				["description"] = "" ..GetPlayerName(source).."\nWeapon : " ..weaponName.."   Vardasht ",
				["footer"] = {["text"] = "Time -> "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
				},
	avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
	}),
	{['Content-Type'] = 'application/json'
	})

	--TriggerEvent('DiscordBot:ToDiscord', 'pwi', xPlayer.name, 'Withdrawn ' .. weaponName ,'user', source, true, false)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 0 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)


ESX.RegisterServerCallback('esx_policejob:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(true)
		end
	end)

end)

ESX.RegisterServerCallback('esx_policejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)



AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'police')
	end
end)






RegisterServerEvent('esx_policejob:message')
AddEventHandler('esx_policejob:message', function(target, msg)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 8.0 then return TriggerEvent('AntiCHEAT:bancheter',source , 'Try To Using TriggerServerEvent (esx_policejob:message)') end
	---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
	TriggerClientEvent('esx:showNotification', target, msg)
end)






local panic = 0
local panicreqx = {}
local panicreqy = {}
local panicreqname = {}
local sentreq = {}

RegisterServerEvent('esx_policejob:saundplay')
AddEventHandler('esx_policejob:saundplay', function(soundFile, soundVolume, x, y, plate, IsDistress)
local source = source
local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xP = ESX.GetPlayerFromId(xPlayers[i])
		if xP.job.name  ==  'police' then
			TriggerClientEvent('chatMessage', xPlayers[i],"^1 Az ^4Alpha 22 ^1Be Tamam Niro Hay^4 LSPD^1 Dar Khast Niro Poshtibani Darim ")
		end
	end
end)

RegisterServerEvent('alarm:on') 
AddEventHandler('alarm:on', function(coords)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('alarm:on', xPlayers[i], coords)
			TriggerClientEvent('chatMessage', xPlayers[i],"^1 Az ^4 "..GetPlayerName(_source).." ^1Be Tamam Niro Hay^4 LSPD^1 Dar Khast Niro Poshtibani Darim ")
        end
    end
end)












RegisterCommand('resp',function(source,args)
	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff'  then
			if args[1] then
				if xPlayer.get('inunit') ~= nil then
				local idbackup = tonumber(args[1])
					if panicreqx[idbackup] ~= nil then
						local x = panicreqx[idbackup] 
						local y = panicreqy[idbackup]
						local nameunit = panicreqname[idbackup]
						TriggerClientEvent('esx_policejob:setwaypoint', source, x, y)
						local xPlayers = ESX.GetPlayers()
							for i=1, #xPlayers, 1 do
		local xPlayer2 = ESX.GetPlayerFromId(xPlayers[i])	
		if xPlayer2.job.name == "police" then
			TriggerClientEvent('chatMessage', xPlayer2.source, "[DISPATCH]", {31, 0, 173}, "^4Darkhast Poshtibani ^1"..nameunit.."("..idbackup..") ^4Tavasote Vahede ^1"..xPlayer.get('inunit').." ^4Accept Shod.")
		end
							end
					else
					TriggerClientEvent('chatMessage', source, "[DISPATCH]", {31, 0, 173}, "^8In Darkhast Sabt Nashode Ast.")
					end
				else
				TriggerClientEvent('chatMessage', source, "[DISPATCH]", {31, 0, 173}, "^8Shoma Dar Uniti Faaliat Nemikonid, Lotfan Ebteda Ozv Yek Unit Shavid.")
				end
			else
			TriggerClientEvent('chatMessage', source, "[DISPATCH]", {31, 0, 173}, "^8Raveshe Estefade : /resp IDBACKUP")
			end
		else
		TriggerClientEvent('chatMessage', source, "[DISPATCH]", {31, 0, 173}, "^8Shoma Police Nistid.")
		end
end)


RegisterServerEvent('esx_policejob:playSoundRadio')
AddEventHandler('esx_policejob:playSoundRadio', function(soundFile, soundVolume)
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do

		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])	

		if xPlayer.job.name == "police" and xPlayer.job.grade > 0 then

			if xPlayer.source ~= source then
				TriggerEvent('InteractSound_SV:PlayOnOne', xPlayer.source, soundFile, soundVolume)
			end

		end

	end
end)

ESX.RegisterServerCallback('esx_policejob:getitem', function(source, cb, item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_policejob:getIcName', function(source, cb)
	local _source = source
	characterName = string.gsub(exports.essentialmode:GetPlayerICName(_source), "_", " ")

	cb(characterName)
end)

-- RegisterServerEvent('kobsjob:art')
-- AddEventHandler('kobsjob:art', function(targetid, playerheading, playerCoords, playerlocation)
-- 	_source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
-- 	local faction = "police" 

-- 	if xPlayer.job.name == 'police' or xPlayer.job.name == 'Blackguard' or  xPlayer.gang.name ~= 'nogang' then 
-- 		if not AS[_source] then
-- 			AS[_source] = true
-- 			--if exports.ImAlireza:GetCoords(source, target, 25.0) ~= false then return end
-- 			TriggerClientEvent('esx_policejob:getarrested', targetid, playerheading, playerCoords, playerlocation, faction, _source)
-- 			TriggerClientEvent('esx_policejob:doarrested', _source)
-- 			SetTimeout(450, function() AS[_source] = nil end)
-- 		end
-- 	end

-- end)


local AS, ASWarn = {}, {}
RegisterServerEvent('kobsjob:art')
AddEventHandler('kobsjob:art', function(targetid, playerheading, playerCoords, playerlocation)
    _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local faction = "police" 
    if xPlayer.job.name == 'police' or xPlayer.job.name == 'Blackguard' or xPlayer.job.name == 'sheriff' or  xPlayer.gang.name ~= 'nogang' then
        if not AS[_source] then
			---if exports['Eye-AC']:CheckPlayers(_source, targetid, 8.0) ~= false then return end
            AS[_source] = true
            TriggerClientEvent('esx_policejob:getarrested', targetid, playerheading, playerCoords, playerlocation, faction, _source)
            TriggerClientEvent('esx_policejob:doarrested', _source)
            SetTimeout(450, function() AS[_source] = nil end)
        else
            if not ASWarn[_source] then
                TriggerEvent('laac:adminalarm', _source, "Mashkuk be Bring All ast (Cuff Method)")
                ASWarn[_source] = true
                SetTimeout(2000, function() ASWarn[_source] = nil end)
            end
        end
    end
end)



RegisterServerEvent('esx_policejob:requestreleases')
AddEventHandler('esx_policejob:requestreleases', function(targetid, playerheading, playerCoords,  playerlocation)
	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.gang.name ~= 'nogang' then
		if not AS[_source] then
			if #(GetEntityCoords(GetPlayerPed(_source)) - GetEntityCoords(GetPlayerPed(targetid))) >= 15 then return TriggerEvent('AntiCHEAT:bancheter',source , '🔞Try To Using TriggerServerEvent Bitch(Police_job)🔞') end
	        Citizen.Wait(1300)
			AS[_source] = true
			TriggerClientEvent('esx_policejob:getuncuffed', targetid, playerheading, playerCoords, playerlocation, _source)
			TriggerClientEvent('esx_policejob:douncuffing', _source)
			SetTimeout(450, function() AS[_source] = nil end)
		else
			if not ASWarn[_source] then
				ASWarn[_source] = true
				SetTimeout(2000, function() ASWarn[_source] = nil end)
			end
		end	
	end
end)

RegisterServerEvent('esx_policejob:SetCuffStatus')
AddEventHandler('esx_policejob:SetCuffStatus', function(status)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.set('Cuff', status)
end)

ESX.RegisterServerCallback('esx_policejob:IsHandCuffed', function(source, cb, target)
	local xTarget = ESX.GetPlayerFromId(target)

	if xTarget then
		cb(xTarget.get('Cuff'))
	end
end)





--[[
local Divisions = {
	'swat',
	'police',
	'sheriff',
	'xray',
	'gtf',
	'dea',
	'ft',
	'air',
	'hr',
}


RegisterCommand('division', function(source, args, raws)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' and xPlayer.job.grade > 6 then
		local target = tonumber(args[1])
		if not target then
			TriggerClientEvent('esx:showNotification', source, 'Lotfan Id Player morde nazar ro vared konid')
			return
		end

		local division = args[2]
		if not division then
			TriggerClientEvent('esx:showNotification', source, 'Lotfan ye Division vared konid')
			return
		end

		local found = false
		division = string.lower(division)
		for i, divisionname in ipairs(Divisions) do
			if division == divisionname then
				found = true
			end
		end

		if not found then
			TriggerClientEvent('esx:showNotification', source, 'Shoma Hich kodom az division haye Tarif shode ro vared nakardid')
			return
		end

		target = ESX.GetPlayerFromId(target)
		if target and target.job.name == 'police' or target.job.name == 'sheriff' then

			if target.job.ext then
				if division == 'police' then
					exports.ghmattimysql:execute('DELETE FROM police_ext WHERE identifier = @identifier', {
						['identifier'] = target.identifier
					})
					target.setExt(nil)
				end

				if target.job.ext == division then
					TriggerClientEvent('esx:showNotification', source, 'Player morede nazare shoma az qabl dar in division bode ast')
				else
					exports.ghmattimysql:execute('UPDATE police_ext SET division = @division WHERE identifier = @identifier', {
						['division'] = division,
						['identifier'] = target.identifier
					})
					target.setExt(division)
				end
			else
				exports.ghmattimysql:execute('INSERT INTO police_ext (identifier, division) VALUES (@identifier, @division)', {
					['division'] = division,
					['identifier'] = target.identifier
				})
				target.setExt(division)
			end
		else
			TriggerClientEvent('esx:showNotification', source, 'Player morde nazare shoma police ya online nist')
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'Shoma Dastresi Estefade az in Command ro nadarid')
	end
end, false)
]]




RegisterCommand('division', function(source, args, raws)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' and xPlayer.job.grade > 6 then
		local target = tonumber(args[1])
		if not target then
			TriggerClientEvent('esx:showNotification', source, 'Lotfan Id Player morde nazar ro vared konid')
			return
		end

		local division = args[2]
		if not division then
			TriggerClientEvent('esx:showNotification', source, 'Lotfan ye Division vared konid')
			return
		end

		local found = false
		Citizen.CreateThread(function() 
			MySQL.Async.fetchAll('SELECT name FROM division WHERE whitelisted = @whitelisted', {
				['@whitelisted'] = false
			}, function(result)
				local data = {} 
				for i=1, #result, 1 do

					local ddd = result[i].name
					if division ~= ddd then
						found = false
					else
						found = true
						target = ESX.GetPlayerFromId(target)
						if target and target.job.name == 'police' or target.job.name == 'sheriff' then
				
							if target.job.ext then
								if division == 'police' then
									exports.ghmattimysql:execute('DELETE FROM police_ext WHERE identifier = @identifier', {
										['identifier'] = target.identifier
									})
									target.setExt(nil)
								end
				
								if target.job.ext == division then
									TriggerClientEvent('esx:showNotification', source, 'Player morede nazare shoma az qabl dar in division bode ast')
								else
									exports.ghmattimysql:execute('UPDATE police_ext SET division = @division WHERE identifier = @identifier', {
										['division'] = division,
										['identifier'] = target.identifier
									})
									target.setExt(division)
								end
							else
								exports.ghmattimysql:execute('INSERT INTO police_ext (identifier, division) VALUES (@identifier, @division)', {
									['division'] = division,
									['identifier'] = target.identifier
								})
								target.setExt(division)
							end
						else
							TriggerClientEvent('esx:showNotification', source, 'Player morde nazare shoma police ya online nist')
						end
					end
					

				end

			end)
		end)


	else
		TriggerClientEvent('esx:showNotification', source, 'Shoma Dastresi Estefade az in Command ro nadarid')
	end
end, false)

local Players = {}

function AliRezacodsecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
    
end

RegisterNetEvent(
    "AliReza:KIRETKARDkooooni",
    function()
        if not Players[source] then
            Players[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "main.lua",Citizen.ResultAsString())
            AliRezacodsecret("AliReza:KIRETKARDkooooni", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsecret("AliReza:KIRETKARDkooooni", source, Code_)
            Citizen.Wait(4000)
            DropPlayer(source, "Mayel Be Lavat ?")
        end
    end
)
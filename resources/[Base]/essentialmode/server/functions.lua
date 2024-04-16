ESX.Trace = function(str)
	if Config.EnableDebug then
		print('ESX> ' .. str)
	end
end

ESX.SetTimeout = function(msec, cb)
	local id = ESX.TimeoutCount + 1
	SetTimeout(msec, function()
		if ESX.CancelledTimeouts[id] then
			ESX.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	ESX.TimeoutCount = id
	return id
end

ESX.ClearTimeout = function(id)
	ESX.CancelledTimeouts[id] = true
end

ESX.RegisterServerCallback = function(name, cb)
	ESX.ServerCallbacks[name] = cb
end

ESX.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if ESX.ServerCallbacks[name] ~= nil then
		ESX.ServerCallbacks[name](source, cb, ...)
	else
		print('es_extended: TriggerServerCallback => [' .. name .. '] does not exist')
	end
end

ESX.SavePlayer = function(Source, cb)
	local asyncTasks     = {}
	--inventory
	local invent = {}
	if not Users[Source] then
		return
	end
	if #Users[Source].inventory > 0 then
		for _,v in  ipairs(Users[Source].inventory) do
			table.insert(invent, {item	= v.name, count = v.count})
		end
	end
	
	table.insert(asyncTasks, function(cb)
		MySQL.Async.execute('UPDATE users SET `money` = @money, `bank` = @bank, `position` = @position, `inventory` = @inventory, `loadout` = @loadout WHERE identifier = @identifier',
		{
			['@money']      = Users[Source].money,
			['@bank']  		= Users[Source].bank,
			['@position']   = json.encode(Users[Source].coords),
			['@inventory']  = json.encode(invent),
			['@loadout'] 	= json.encode(Users[Source].loadout),
			['@identifier']	= Users[Source].identifier
		}, function(rowsChanged)
			cb()
		end)
	end)
	Async.parallel(asyncTasks, function(results)
		-- RconPrint('[SAVED] ' .. Users[Source].name .. "\n")

		if cb ~= nil then
			cb()
		end
	end)

end

ESX.SavePlayers = function(cb)
	local asyncTasks = {}
	local xPlayers   = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		table.insert(asyncTasks, function(cb)
			ESX.SavePlayer(xPlayers[i], cb)
		end)
	end

	Async.parallelLimit(asyncTasks, 1, function(results)
		RconPrint('[SAVED] All players' .. "\n")

		if cb ~= nil then
			cb()
		end
	end)
end

ESX.StartDBSync = function()
	function saveData()
		ESX.SavePlayers()
		SetTimeout(10 * 60 * 1000, saveData)
	end

	SetTimeout(10 * 60 * 1000, saveData)
end
ESX.StartDBSync()

ESX.GetPlayers = function()
	local sources = {}

	for k,v in pairs(Users) do
		table.insert(sources, k)
	end

	return sources
end

ESX.GetSteamID = function (src)
	local sid = GetPlayerIdentifiers(src)[1] or false

	if (sid == false or sid:sub(1,5) ~= "steam") then
		return false
	end

	return sid
end

ESX.GetDiscordID = function (src)
	for k,v in ipairs(GetPlayerIdentifiers(src))do
		if string.sub(v, 1, string.len("discord:")) == "discord:" then
			return v
		end
	end
	return false
end

ESX.GetPlayerFromId = function(source)
	return Users[tonumber(source)]
end

ESX.GetPlayerFromIdentifier = function(identifier)
	for k,v in pairs(Users) do
		if v.identifier == identifier then
			return v
		end
	end
end

ESX.GetPlayerFromPlate = function(Plate)
	local result = MySQL.Sync.fetchAll('SELECT * FROM `owned_vehicles` WHERE `plate` = "'.. Plate ..'"', {})
	local owner
	if result[1] then
		owner = result[1].owner
	else
		return nil, nil
	end
	if string.find(owner, "steam") then
		local xPlayers = ESX.GetPlayers()
		local player = nil
		if xPlayers then
			for i=1, #xPlayers, 1 do
				local compare = owner == GetPlayerIdentifiers(xPlayers[i])[1]
				if compare then
					return player, nil
				end
			end
		end
	else
		return nil, owner
	end
end

ESX.RegisterUsableItem = function(item, cb)
	ESX.UsableItemsCallbacks[item] = cb
end

ESX.UseItem = function(source, item)
	ESX.UsableItemsCallbacks[item](source)
end

ESX.GetItemLabel = function(item)
	if ESX.Items[item] ~= nil then
		return ESX.Items[item].label
	end
end

ESX.CreatePickup = function(type, name, count, label, player)
	local pickupId = (ESX.PickupId == 65635 and 0 or ESX.PickupId + 1)
	
	local object = ESX.GetWeaponObject(name) or 'prop_big_bag_01'
	local player = player  
	local ped = GetPlayerPed(player)
    local playerCoords = GetEntityCoords(ped)
    local playerHeading = GetEntityHeading(ped)
	
	ESX.Pickups[pickupId] = {
		type  = type,
		name  = name,
		object  = object,
		playerCoords  = playerCoords,
		playerHeading  = playerHeading,
		count = count
	}
	
	TriggerClientEvent('esx:pickup', -1, pickupId, label, object, player, playerCoords, playerHeading)
	ESX.PickupId = pickupId
end

ESX.UpdatePickup = function(id, remaining, label)
	ESX.Pickups[id].count = remaining
	TriggerClientEvent('esx:pickupUpdate', -1, id, label)
end

ESX.UpdatePickup = function(id, remaining, label)
	ESX.Pickups[id].count = remaining
	TriggerClientEvent('esx:pickupUpdate', -1, id, label)
end

local weaponsObj = {
	{name = 'WEAPON_ASSAULTRIFLE', 	obj = 'w_ar_assaultrifle'},
	{name = 'WEAPON_SNSPISTOL', 	obj = 'w_pi_sns_pistol'},
	{name = 'WEAPON_PISTOL50', 		obj = 'w_pi_pistol50'},
	{name = 'WEAPON_PISTOL', 		obj = 'w_pi_pistol'},
	{name = 'WEAPON_HEAVYPISTOL', 	obj = 'w_pi_heavypistol'},
	{name = 'WEAPON_SMG', 			obj = 'w_sb_smg'},
	{name = 'WEAPON_BAT', 			obj = 'w_me_bat'},
	{name = 'WEAPON_CROWBAR', 		obj = 'w_me_crowbar'},
	{name = 'WEAPON_GCLUB', 		obj = 'w_me_gclub'},
	{name = 'WEAPON_HAMMER', 		obj = 'w_me_hammer'},
	{name = 'WEAPON_NIGHTSTICK', 	obj = 'w_me_nightstick'},
	{name = 'WEAPON_CARBINERIFLE',  obj = 'w_ar_carbinerifle'},
	{name = 'WEAPON_KNIFE', 		obj = 'w_me_knife_01'}
}

ESX.GetWeaponObject = function(name)
	for i=1, #weaponsObj do
		if weaponsObj[i].name == name then
			return weaponsObj[i].obj
		end
	end
	return nil
end

ESX.DoesJobExist = function(job, grade)
	if job and grade then
		if ESX.Jobs[job] and ESX.Jobs[job].grades[grade] then
			return true
		end
	end

	return false
end

function GetPlayerICName(source)
	if Users[source] and Users[source].name then
		return Users[source].name
	end
end

ESX.DoesGangExist = function(gang, grade)
	grade = tonumber(grade)

	if gang and grade then
		if ESX.Gangs[gang] and ESX.Gangs[gang].grades[grade] then
			return true
		end
	end

	return false
end
ESX.GetGang = function(gang)
	if ESX.DoesGangExist(gang, 1) then
		return ESX.Gangs[gang]
	else
		return nil
	end
end

ESX.SetGangGrade = function(gang, grade, name)
	if ESX.DoesGangExist(gang, grade) then
		ESX.Gangs[gang].grades[grade].label = name
		exports.ghmattimysql:execute('UPDATE gang_grades SET label = @name WHERE grade = @grade AND gang_name = @gang', {
			['@name'] = name,
			['@grade'] = grade,
			['@gang'] = gang
		})
		return true
	else
		return nil
	end
end

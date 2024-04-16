local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'sheriff'  then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('esx_vangelico2_robbery:toofar')
AddEventHandler('esx_vangelico2_robbery:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'sheriff' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
			TriggerClientEvent('esx_vangelico2_robbery:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_vangelico2_robbery:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_vangelico2_robbery:endrob')
AddEventHandler('esx_vangelico2_robbery:endrob', function(robb)
	local source = source
	local xPlayersss = ESX.GetPlayerFromId(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.robj = false
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'sheriff' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
			TriggerClientEvent('esx_vangelico2_robbery:killblip', xPlayers[i])
			xPlayersss.addInventoryItem('Unknownbag', 1)
			TriggerClientEvent('esx:showNotification', source, 'Shoma YekUnknown BagDaryaft Kardid')
		end
	end
	if(robbers[source])then
		TriggerClientEvent('kobs2_robbery:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('kobs2_robbery:rob')
AddEventHandler('kobs2_robbery:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then

            TriggerClientEvent('esx_vangelico2_robbery:togliblip', source)
			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds'))
			return
		end

		if rob == false then
		xPlayer.set("robj",true)

			rob = true
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'sheriff' then
					TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nameofstore)
					TriggerClientEvent('esx_vangelico2_robbery:setblip', xPlayers[i], Stores[robb].position)
				end
			end

			TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
			TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
			TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			TriggerClientEvent('esx_vangelico2_robbery:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('kobs2:gioielli')
AddEventHandler('kobs2:gioielli', function()

	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.robj ~= nil and xPlayer.robj == true then
		xPlayer.addInventoryItem('jewels', math.random(Config.MinJewels, Config.MaxJewels))
	else
		exports.bansystem.bancheater(source,"Try To Get Jewerly")
	end
end)

ESX.RegisterServerCallback('esx_vangelico2_robbery:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)


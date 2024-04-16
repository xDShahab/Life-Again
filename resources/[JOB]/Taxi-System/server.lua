-----------------------------------------------------------------------------------------------------------------------------------

-- Players
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

-----------------------------------------------------------------------------------------------------------------------------------

-- Job General Chat

RegisterServerEvent('esx_jobChat:chat')
AddEventHandler('esx_jobChat:chat', function(job, msg)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = GetPlayerName(source)
	jobName = string.upper(job)
	local messageFull = {
        template = '<div style="padding: 8px; margin: 8px; background-color: rgba(77, 0, 153); border-radius: 25px;"><i class="far fa-building"style="font-size:15px"></i> [{0}] {1} : {2}</font></i></b></div>',
        args = {jobName, fal , msg,}
    }
    TriggerClientEvent('esx_jobChat:Send', -1, messageFull, job)
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- 311 Chat

RegisterServerEvent('esx_jobChat:311')
AddEventHandler('esx_jobChat:311', function(targetCoords, msg, streetName, emergency)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = GetPlayerName(source)
	local messageFull
	if emergency == '311' then
		messageFull = {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(255, 51, 51); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i> [ICU]: {0} | Location : {1} | {2}</font></i></b></div>',
        	args = {fal, streetName, msg, ped}
		}
	end
	TriggerClientEvent('esx_jobChat:311Marker', -1, targetCoords, emergency)
	TriggerClientEvent('esx_jobChat:311EmergencySend', -1, messageFull)
end)
-----------------------------------------------------------------------------------------------------------------------------------

-- 911 Chat

RegisterServerEvent('esx_jobChat:911')
AddEventHandler('esx_jobChat:911', function(targetCoords, msg, streetName, emergency)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = GetPlayerName(source)
	local messageFull
	if emergency == '911' then
		messageFull = {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(0, 38, 153); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i> [911] : {0} | Location : {1} | {2}</font></i></b></div>',
        	args = {fal, streetName, msg}
		}
	end
	TriggerClientEvent('esx_jobChat:911Marker', -1, targetCoords, emergency)
	TriggerClientEvent('esx_jobChat:911EmergencySend', -1, messageFull)
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Mechanic chat

RegisterServerEvent('esx_jobChat:mech')
AddEventHandler('esx_jobChat:mech', function(targetCoords, msg, streetName, emergency)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = GetPlayerName(source)
	local messageFull
	if emergency == 'mech' then
		messageFull = {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(128, 64, 0); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i> [MECH] : {0} | Location : {1} | {2}</font></i></b></div>',
        	args = {fal, streetName, msg}
		}
	end
	TriggerClientEvent('esx_jobChat:mechMarker', -1, targetCoords, emergency)
	TriggerClientEvent('esx_jobChat:mechEmergencySend', -1, messageFull)
end)
-----------------------------------------------------------------------------------------------------------------------------------
-- Taxi chat

RegisterServerEvent('esx_jobChat:taxi')
AddEventHandler('esx_jobChat:taxi', function(targetCoords, msg, streetName, emergency)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = GetPlayerName(source)
	local messageFull
	if emergency == 'taxi' then
		messageFull = {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(128, 64, 0); border-radius: 25px;"><i class="fas fa-bell"style="font-size:15px"></i> [Taxi] : {0} | Location : {1} | {2}</font></i></b></div>',
        	args = {fal, streetName, msg}
		}
	end
	TriggerClientEvent('esx_jobChat:taxiMarker', -1, targetCoords, emergency)
	TriggerClientEvent('esx_jobChat:taxiEmergencySend', -1, messageFull)
end)
-----------------------------------------------------------------------------------------------------------------------------------
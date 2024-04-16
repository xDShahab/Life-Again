-----------------------------------------------------------------------------------------------------------------------------------

-- Players

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

-----------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------

-- Job General Command

RegisterCommand('work', function(source, args, rawCommand)
	local msg = rawCommand:sub(5)
	local job = PlayerData.job.name
    TriggerServerEvent('esx_jobChat:chat', job, msg)
end, false)

-----------------------------------------------------------------------------------------------------------------------------------

-- 911 Command

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/911', 'Sending a notice to the authorities with 911!', {
    { name="Complaint", help="Write your complaint here!" }
})
end)

msg = nil
RegisterCommand('911', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [Police] " , {26, 83, 255},   "A notice has been sent to the Authorities" )
		
	msg = table.concat(args, " ")
	
	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
        streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(4)
	local emergency = '911'
    TriggerServerEvent('esx_jobChat:911',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
    }, msg, streetName, emergency)
end, false)

-----------------------------------------------------------------------------------------------------------------------------------

-- 311 Command

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/hospital', 'Sending a notice to the Hosptial!', {
    { name="Complaint", help="Write your complaint here!" }
})
end)

msg = nil
RegisterCommand('hospital', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [Hospital] ", {255,0,0},   "A notice has been sent to the Hospital" )

	msg = table.concat(args, " ")

	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(4)
	local emergency = '311'
    TriggerServerEvent('esx_jobChat:311',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
	}, msg, streetName, emergency)
end, false)
-----------------------------------------------------------------------------------------------------------------------------------

-- Mechanic Command

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/mechanic', 'Send an alert to the mechanics with mech!', {
    { name="Complaint", help="Write your complaint here!" }
})
end)

msg = nil
RegisterCommand('mechanic', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [Mechanic] ", {230, 115, 0},   "A notice has been sent to the Mechanic" )

	msg = table.concat(args, " ")

	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(5)
	local emergency = 'mech'
    TriggerServerEvent('esx_jobChat:mech',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
	}, msg, streetName, emergency)
end, false)
-----------------------------------------------------------------------------------------------------------------------------------

-- Taxi Command

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/taxi', 'Send an alert to the Taxis!', {
    { name="Complaint", help="Write your complaint here!" }
})
end)

msg = nil
RegisterCommand('taxi', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [Taxi] ", {230, 115, 0},   "A notice has been sent to the Taxi" )

	msg = table.concat(args, " ")

	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(5)
	local emergency = 'taxi'
    TriggerServerEvent('esx_jobChat:taxi',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
	}, msg, streetName, emergency)
end, false)

-----------------------------------------------------------------------------------------------------------------------------------

-- Job General Chat

RegisterNetEvent('esx_jobChat:Send')
AddEventHandler('esx_jobChat:Send', function(messageFull, job)
    if PlayerData.job.name == job then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Mechanic Emergency

RegisterNetEvent('esx_jobChat:mechEmergencySend')
AddEventHandler('esx_jobChat:mechEmergencySend', function(messageFull)
	if PlayerData.job.name == 'mechanic' then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Mechanic Emergency Alert

RegisterNetEvent('esx_jobChat:mechEmergencySend')
AddEventHandler('esx_jobChat:mechEmergencySend', function(messageFull)
	if PlayerData.job.name == 'mechanic' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CARSITE3", "CHAR_CARSITE3", true, 8, "Notice Mechanic", "GPS location sent");
		DrawNotification(false, true);
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------

-- Taxi Emergency

RegisterNetEvent('esx_jobChat:taxiEmergencySend')
AddEventHandler('esx_jobChat:taxiEmergencySend', function(messageFull)
	if PlayerData.job.name == 'taxi' then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Taxi Emergency Alert

RegisterNetEvent('esx_jobChat:taxiEmergencySend')
AddEventHandler('esx_jobChat:taxiEmergencySend', function(messageFull)
	if PlayerData.job.name == 'taxi' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CARSITE3", "CHAR_CARSITE3", true, 8, "Notice Taxi", "GPS location sent");
		DrawNotification(false, true);
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Emergency 911 

RegisterNetEvent('esx_jobChat:911EmergencySend')
AddEventHandler('esx_jobChat:911EmergencySend', function(messageFull)
	if PlayerData.job.name == 'police' then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Emergency 911 Alert Message

RegisterNetEvent('esx_jobChat:911EmergencySend')
AddEventHandler('esx_jobChat:911EmergencySend', function(messageFull)
	if PlayerData.job.name == 'police' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CALL911", "CHAR_CALL911", true, 8, "Notice 911", "GPS location sent");
		DrawNotification(false, true);
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- NonEmergency 311

RegisterNetEvent('esx_jobChat:311EmergencySend')
AddEventHandler('esx_jobChat:311EmergencySend', function(messageFull)
	if PlayerData.job.name == 'ambulance' then
		TriggerEvent('chat:addMessage', messageFull)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- NonEmergency 311 Alert Message

RegisterNetEvent('esx_jobChat:311EmergencySend')
AddEventHandler('esx_jobChat:311EmergencySend', function(messageFull)
	if PlayerData.job.name == 'ambulance' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CHAT_CALL", "CHAR_CHAT_CALL", true, 8, "ICU Notice", "GPS location sent");
		DrawNotification(false, true);
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Marker 911

RegisterNetEvent('esx_jobChat:911Marker')
AddEventHandler('esx_jobChat:911Marker', function(targetCoords, type)
	if PlayerData.job.name == 'police' then
        local alpha = 250
        local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == '911' then
			SetBlipColour (call, 38)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('911')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Marker 311

RegisterNetEvent('esx_jobChat:311Marker')
AddEventHandler('esx_jobChat:311Marker', function(targetCoords, type)
    if PlayerData.job.name == 'ambulance' then
		local alpha = 250
		local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		
		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == '311' then
			SetBlipColour (call, 1)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Help')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Marker Mechanic

RegisterNetEvent('esx_jobChat:mechMarker')
AddEventHandler('esx_jobChat:mechMarker', function(targetCoords, type)
    if PlayerData.job.name == 'mechanic' then
		local alpha = 250
		local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		
		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == 'mech' then
			SetBlipColour (call, 64)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Help Mechanic')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Marker taxi

RegisterNetEvent('esx_jobChat:taxiMarker')
AddEventHandler('esx_jobChat:taxiMarker', function(targetCoords, type)
    if PlayerData.job.name == 'taxi' then
		local alpha = 250
		local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		
		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == 'taxi' then
			SetBlipColour (call, 64)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Help Taxi')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

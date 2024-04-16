

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- RegisterServerEvent('InteractSound_SV:PlayOnOne')
AddEventHandler('InteractSound_SV:PlayOnOne', function(clientNetId, soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', clientNetId, soundFile, soundVolume)
	-- SendLog(source, "Net ID", "null")
end)

RegisterServerEvent('InteractSound_SV:PlayOnSource')
AddEventHandler('InteractSound_SV:PlayOnSource', function(soundFile, soundVolume)
    TriggerClientEvent('InteractSound_CL:PlayOnOne', source, soundFile, soundVolume)
end)


RegisterServerEvent('InteractSound_SV:PlayOnAll')
AddEventHandler('InteractSound_SV:PlayOnAll', function(soundFile, soundVolume)
    -- TriggerClientEvent('InteractSound_CL:PlayOnAll', -1, soundFile, soundVolume)
   -- SendLog(source, "All Server", "-1")
   ACBan(source, "Tried to Play Sound for All Players", "Cheats (Lua Executor)")
end)


RegisterServerEvent('InteractSound_SV:PlayWithinDistance')
AddEventHandler('InteractSound_SV:PlayWithinDistance', function(maxDistance, soundFile, soundVolume)  
	local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
    if maxDistance < 11 and maxDistance > 0 then
        TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume, ped_NETWORK , playerCoords)
        elseif maxDistance < 11.0 and maxDistance > 0.0 then
        TriggerClientEvent('InteractSound_CL:PlayWithinDistance', -1, source, maxDistance, soundFile, soundVolume, ped_NETWORK , playerCoords)
    else
       return
    end
end)



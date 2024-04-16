ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
    AdminJ(tonumber(source))
end)

ESX.RegisterServerCallback('AT_Admin:GetActivePlayers', function(source, cb)
    local cX = ESX.GetPlayers()
    local cJ = {}
    for i=1, #cX, 1 do
      local cSource = cX[i]
      local name = GetPlayerName(cSource)
      if name ~= '**Invalid**' then
        cJ[cSource] = name
      end
    end
    cb(cJ)
end)

ESX.RegisterServerCallback('esx_spectate:xPlayerServerSide', function(source, cb, ID)
  local xPlayer = ESX.GetPlayerFromId(tonumber(ID))
  if xPlayer then
      cb(xPlayer)
  else
      cb(nil)
  end
end)

ESX.RegisterServerCallback('AT_Admin:GetTargetPosition', function(source, cb, id)
  local sPlayer = ESX.GetPlayerFromId(tonumber(id))
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer and sPlayer then
    cb(GetEntityCoords(GetPlayerPed(tonumber(id))))
  else
    cb(GetEntityCoords(GetPlayerPed(tonumber(source))))
  end
end)

ESX.RegisterServerCallback('esx_spectate:RequestPermission', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  cb(tonumber(xPlayer.permission_level))
end)

ESX.RegisterServerCallback('esx_spectate:RequestDutyStatus', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.get('aduty') then
      cb(true)
  else
      cb(false)
  end
end)

function AdminJ(id)
  local xP = ESX.GetPlayers()
  for k, v in ipairs(xP) do
    local xPs = ESX.GetPlayerFromId(v)
    if xPs.permission_level > 0 then 
        TriggerClientEvent("AT_Admin:PlayerJoined", v, id, GetPlayerName(id))
    end
  end
end


RegisterCommand('sync', function(source, args)
  local xP = ESX.GetPlayerFromId(source)
  if xP.permission_level >= 3 then

      if args[1] then
        TriggerClientEvent('aduty:sync', args[1])
        TriggerClientEvent('esx:showNotification', source, "Shoma Carcter Id " ..args[1].." Ra Restart Dadid.")
        --TriggerClientEvent('esx:showNotification', args[1], "Character Shoma Load Shod")
      else
        TriggerClientEvent('esx:showNotification', source, "Shoma Id Target Khod ra vared nakardid")
      end

  end
end)





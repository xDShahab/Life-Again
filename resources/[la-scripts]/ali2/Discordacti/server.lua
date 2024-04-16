ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


MaxPlayers = "128"
ESX.RegisterServerCallback('Discord:Getdata', function(source, cb)
  local total = #GetPlayers()
  cb(total,MaxPlayers)
end)

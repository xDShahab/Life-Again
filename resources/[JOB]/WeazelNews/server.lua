ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("cam", function(source, args, raw)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "weazel" and xPlayer.job.grade >= 1 then
    TriggerClientEvent("Cam:ToggleCam", source)
  else
    SendMessage(source, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
  end
end)

RegisterCommand("bmic", function(source, args, raw)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "weazel" and xPlayer.job.grade >= 1 then
    TriggerClientEvent("Mic:ToggleBMic", source)
  else
    SendMessage(source, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
  end
end)

RegisterCommand("mic", function(source, args, raw)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "weazel" and xPlayer.job.grade >= 1 then
    TriggerClientEvent("Mic:ToggleMic", source)
  else
    SendMessage(source, "Shoma dastresi kafi baraye estefade az in dastor ra nadarid!")
  end
end)

function SendMessage(target, message)
    TriggerClientEvent('chatMessage', target, "[Weazel News]", {255, 0, 0}, message)
end
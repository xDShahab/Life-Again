ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
AddEventHandler('chatMessage', function(s, n, m)
  local message = string.lower(m)
  if message == "/engine off" then
    CancelEvent()
    TriggerClientEvent('engineoff', s)
  elseif message == "/engine on" then
    CancelEvent()
    TriggerClientEvent('engineon', s)
  elseif message == "/engine" then
    CancelEvent()
    TriggerClientEvent('engine', s)
  elseif message == "/trunk" then
    CancelEvent()
    TriggerClientEvent('trunk', s)
  elseif message == "/lfdoor" then
    CancelEvent()
    TriggerClientEvent('lfdoor', s)
  elseif message == "/rfdoor" then
    CancelEvent()
    TriggerClientEvent('rfdoor', s)
  elseif message == "/lrdoor" then
    CancelEvent()
    TriggerClientEvent('lrdoor', s)
  elseif message == "/rrdoor" then
    CancelEvent()
    TriggerClientEvent('rrdoor', s)
  elseif message == "/alldoors" then
    CancelEvent()
    TriggerClientEvent('alldoors', s)
  elseif message == "/allwindowsdown" then
    CancelEvent()
    TriggerClientEvent('allwindowsdown', s)
  elseif message == "/allwindowsup" then
    CancelEvent()
    TriggerClientEvent('allwindowsup', s)
  elseif message == "/hood" then
    CancelEvent()
    TriggerClientEvent('hood', s)
  elseif message == "/lock" then
    CancelEvent()
    TriggerClientEvent('lock', s)
  elseif message == "/sveh" then
    CancelEvent()
    TriggerClientEvent('controlsave', s)
  end
end)
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
RegisterCommand("save", function(source, args)
    if args[1] then
        local licenseplate = string.upper(args[1])
        TriggerClientEvent('save', source, licenseplate)
    else
      TriggerClientEvent('save', source)
  end
end)


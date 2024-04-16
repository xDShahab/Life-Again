local playerCount = 0
local list = {}

RegisterServerEvent('hardcap:playerActivated')

AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 5
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 2
    list[source] = nil
  end
end)

AddEventHandler('playerConnecting', function(name, setReason)
  local cv = GetConvarInt('sv_maxclients', 100)

  print('Connecting: ' .. name .. '^7')

  if playerCount >= cv then
    print('Full. :(')

    setReason('This server is full (past ' .. tostring(cv) .. ' players).')
    CancelEvent()
  end
end)

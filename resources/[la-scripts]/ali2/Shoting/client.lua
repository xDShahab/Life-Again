ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
    while true do
      Citizen.Wait(500)
      NetworkSetFriendlyFireOption(true)
    end
end)




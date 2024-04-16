RegisterNetEvent('ST_addons_gcphoneJL:call')
AddEventHandler('ST_addons_gcphoneJL:call', function(data)
  local playerPed   = PlayerPedId()
  local coords      = GetEntityCoords(playerPed)
  local message     = data.message
  local number      = data.number
  if message == nil then
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
      message =  GetOnscreenKeyboardResult()
    end
  end
  if message ~= nil and message ~= "" then
    TriggerServerEvent('ST_addons_gcphoneJL:startCall', number, message, {
      x = coords.x,
      y = coords.y,
      z = coords.z
    })
  end
end) 
 
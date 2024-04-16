ESX = nil


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


local speed = 0.0
local autopilotActive = false
local blipX = 0.0
local blipY = 0.0
local blipZ = 0.0





TriggerEvent('chat:addSuggestion', '/autopilot', 'Ranandegi Khodkar', {})



local table = {
	-304857564,
	831758577
}




RegisterCommand("autopilot", function(source, args)
  
  ESX.TriggerServerCallback('AT_KOBS:IsHandCuffed', function(IsCuffed)
    
    local MeCuffed = IsCuffed[1]

    if MeCuffed then 
      notify(" Shoma Zamani Ke Dastband Darid nemitavanid Az Autopilot Estefade Konid")
    
    else
      local player = GetPlayerPed(-1)
      
      if IsPedSittingInAnyVehicle(player) then

        local ped = GetPlayerPed(-1)
        local vehicles = GetVehiclePedIsIn(ped)
        local model = GetEntityModel(vehicles)
        for i = 1, #table do
          if table[i] == GetEntityModel(vehicles) then
            Openautopilotmenu()

          else
            notify("In Mashin Ghabeliyat Autopiliot Nadarad !!")
          end
        end


      else
        notify(" Shoma Savar Mashini nisty")
      end
    end
  end)

end)



function autopilot_start(source)
  local player = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(player) then
    local vehicle = GetVehiclePedIsIn(player,false) 
    local model = GetEntityModel(vehicle)
    local displaytext = GetDisplayNameFromVehicleModel(model)
    local blip = GetFirstBlipInfoId(8)
    if (blip ~= nil and blip ~= 0) then
        local coord = GetBlipCoords(blip)
        blipX = coord.x
        blipY = coord.y
        blipZ = coord.z
        speed = speed + 0.0
        TaskVehicleDriveToCoordLongrange(player, vehicle, blipX, blipY, blipZ, speed, 447, 2.0)
        autopilotActive = true
    else
        notify(" Makani dar naghshe shoma Mark nashode")
    end
  else
    notify(" Shoma Savar Mashini nisty")
  end
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if autopilotActive then
           local coords = GetEntityCoords(GetPlayerPed(-1))
           local blip = GetFirstBlipInfoId(8)
           local dist = Vdist(coords.x, coords.y, coords.z, blipX, blipY, coords.z)
           helpnotify("Baray Cancel Shodan Az dokme ~INPUT_VEH_DUCK~ Estefade Koniid")
           if dist <= 10 then
              local player = GetPlayerPed(-1)
              local vehicle = GetVehiclePedIsIn(player,false)
              ClearPedTasks(player)
              SetVehicleForwardSpeed(vehicle,11.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,6.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,2.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,0.0)
              Citizen.Wait(100)
              notify(" Shoma be Maghsad residid")
              autopilotActive = false
          end
      end
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if IsControlJustReleased(0, 73) and GetLastInputMethod(2) and not isDead then
      ClearPedTasks(PlayerPedId())
      autopilotActive = false
    end
  end
end)
-- function
function helpnotify(msg) 
  SetTextComponentFormat("STRING")
   AddTextComponentString(msg)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
-------------------------------------------------
function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end
function Openautopilotmenu()
  ESX.UI.Menu.CloseAll()
  ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'autopilot_actions',
	{
		title    = 'AutoPilotMenu',
		align    = 'top-left',
		elements = {
			{label = 'Slow',	  value = 'Slow'},
			{label = 'Normal',	value = 'Normal'},
			{label = 'Fast',		value = 'Fast'},
			{label = 	"Custom", value = 'Custom'}
		}
	}, function(data, menu)
    
    if data.current.value == 'Slow' then
      speed = 40 / 3.59
      autopilot_start(source)
      menu.close()
    end
    
    if data.current.value == 'Normal' then
      speed = 90 / 3.59
      autopilot_start(source)
      menu.close()
    end
    
    if data.current.value == 'Fast' then
      speed = 120 / 3.59
      autopilot_start(source)
      menu.close()
    end
    
    if data.current.value == 'Custom' then
      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
    	{
    		title = 'Custom Speed (Max 150)',
    	}, function(data, menu)
        if data.value == nil then
          notify(" Shoma Dar Ghesmat Speed chizi Naneveshtid")
          menu.close()
        else
          if data.value > 150 then
            notify(" Max Speed 150")
            menu.close()
          else
          
          speed = data.value / 3.59
          autopilot_start(source)
          menu.close()
          end
          
        end

      end)
       -------------------------
    end
     
end,function (data,menu)
  menu.close()
end)
end
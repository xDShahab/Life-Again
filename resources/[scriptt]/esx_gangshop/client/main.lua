ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
  
  while ESX.GetPlayerData().gang == nil do
		Citizen.Wait(10)
	end

 	ESX.PlayerData = ESX.GetPlayerData()
end)
RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
	ESX.PlayerData.gang = gang
end)
Config = {}
Config.ShopMarkerType    = 29
Config.ShopMarkerSize    = { x = 1.2, y = 1.2, z = 1.0 }
Config.ShopMarkerColor   = { r = 255, g = 100, b = 0 }
local neartheman = false
local ped = nil
local ceeman = false
local selectedcar
local type = 0
local inmenu = false
local maincoords = {x = 3802.47,y = 4475.57, z = 6.0}
local mugshot, mugshotStr
local synced = false
local lasttype = 0
local blip = nil

Citizen.CreateThread(function()
  setupBlip(maincoords)
end)


Citizen.CreateThread(function()
  while true do
      local PlayerPed = PlayerPedId()
      local pos = GetEntityCoords(PlayerPed, true)
      if not inmenu then
            if not synced and type ~= 4 then
              synced = true
            elseif(Vdist(pos.x, pos.y, pos.z, maincoords.x, maincoords.y, maincoords.z) < 2.5)then
                neartheman = true
                ceeman = true
                type = 1
            elseif(Vdist(pos.x, pos.y, pos.z, maincoords.x, maincoords.y, maincoords.z) < 10)then
                neartheman = false
                ceeman = true
                type = 2
            elseif(Vdist(pos.x, pos.y, pos.z, maincoords.x, maincoords.y, maincoords.z) > 9) and (Vdist(pos.x, pos.y, pos.z, maincoords.x, maincoords.y, maincoords.z) < 150) then
              ceeman = false
              ceeman = false
              type = 3
              Citizen.Wait(3000)
            else
              ceeman = false
              ceeman = false
              Citizen.Wait(10000)
              synced = false
              type = 4
            end
            -- if lasttype ~= type and type == 1 or type == 2 then
            --   lasttype = type
            --   ShowOtherThings()
            --   ShowOtherThings2()
              Citizen.Wait(1000)
            -- else
            --   Citizen.Wait(3000)
            -- end
      else
        Citizen.Wait(3000)
      end
  end
end)



Citizen.CreateThread(function()
    while true do
      if neartheman and not inmenu then
        Citizen.Wait(50)
        --DrawMarker(Config.ShopMarkerType, maincoords.x, maincoords.y, maincoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, Config.ShopMarkerColor.r, Config.ShopMarkerColor.g, Config.ShopMarkerColor.b, 50, false, true, 2, nil, nil, false)
        DrawHelp('Press E  to chat with Gang Vehicle Dealer')
      else
        Citizen.Wait(1)
      end
    end
end)

Citizen.CreateThread(function()
  while true do
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local place = vector3(maincoords.x, maincoords.y, maincoords.z)
    local distance  = #(coords - place)
    if distance < 6  then
      DrawMarker(Config.ShopMarkerType, maincoords.x, maincoords.y, maincoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, Config.ShopMarkerColor.r, Config.ShopMarkerColor.g, Config.ShopMarkerColor.b, 50, false, true, 2, nil, nil, false)

    end
    Wait(1)
  end
end)

Citizen.CreateThread(function()
  while true do
    if neartheman and not inmenu then
      if IsControlJustReleased(0, 38) then
					OpenMainMenu()
          neartheman = false
			end
    end
    Wait(0)
  end
end)

function OpenMainMenu()
  if ESX.PlayerData.gang.name == 'nogang' then
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz12', 1.0)
    ESX.ShowNotification('Shoma Ozv Gang Nistid')
    return
  end
  local PlayerPed =PlayerPedId()
  inmenu = true
  local elements = {
    {label = 'Mikham chand ta mashin begiram', value = 'Buy'},
    --{label = 'Donbal mashinam hastam', value = 'Impound'},
  }
  ESX.UI.Menu.CloseAll()
  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz5', 1.0)
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Ghazanfar_actions', {
		title    = 'Ye mord ro bezan',
		elements = elements,
		align    = 'center'
	}, function(data, menu)
		if data.current.value == 'Buy' then
      menu.close()
      TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz4', 1.0)
      ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'choose_car', {
        title    = 'Esme mashin ro benevis',
      }, function(data, menu)
        
        if not data.value then
          ESX.ShowNotification("Shoma chizi Vared Nakardid!")
          return
        elseif IsModelValid(GetHashKey(data.value)) == false then
          ESX.ShowNotification("Az in mashin ha nadaram!")
          TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz3', 1.0)
          return
        else
          selectedcar = data.value
        end
        ESX.TriggerServerCallback('esx_chopshop:getprice', function(price) 
          if price == false then
            ESX.ShowNotification("Az in mashin ha nadaram!")
            TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz3', 1.0)
            return
          else
            ESX.UI.Menu.CloseAll()
              local elements = {
            {label = 'ok mikharam', value = 'n'},
            {label = 'kheyli groon midi', value = 'y'},
          }
          TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz8', 1.0)
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Ghazanfar_actions', {
            title    = 'Gheymat: '..price,
            elements = elements,
            align    = 'center'
          }, function(data, menu)
            if data.current.value == 'n' then
              ESX.TriggerServerCallback('esx_chopshop:canpay', function(can) 
                if can then
                  ESX.UI.Menu.CloseAll()
                  inmenu = false
                  Wait(100)
                  ESX.Game.SpawnVehicle(selectedcar, { x = 3812.04, y = 4473.19, z = 3.83 }, 99.0, function (vehicle)
                    -- TaskWarpPedIntoVehicle(PlayerPed, vehicle, -1)
                    local newPlate     = exports.esx_vehicleshop:GeneratePlate()
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    vehicleProps.plate = newPlate
                    SetVehicleNumberPlateText(vehicle, newPlate)
                    TaskEnterVehicle(PlayerPed, vehicle, 60000, -1, 1.0, 1, 0)
                    TriggerServerEvent('esx_chopshop:buy', vehicleProps)
                    ESX.ShowNotification('Mobarak bashe')
                    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz2', 1.0)
                  end)
                else
                  ESX.ShowNotification("Poolet kheyli kame mashti!")
                  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz9', 1.0)
                  ESX.UI.Menu.CloseAll()
                  inmenu = false
                end
              end, price)
            elseif data.current.value == 'y' then
              menu.close()
              inmenu = false
            end
        end, function(data, menu)
          menu.close()
          inmenu = false
        end)
          end
      end, data.value)
      end, function (data, menu)
        inmenu = false
        menu.close()
      end)
		elseif data.current.value == 'Impound' then
			ESX.TriggerServerCallback('gangprop:getCars', function(ownedCars)
        local elements = {}
        if #ownedCars == 0 then
          -- ESX.ShowNotification('To ke mashini nadari oomadi isga koni?')
          TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz1', 1.0)
          ESX.UI.Menu.CloseAll()
          inmenu = false
        else
          for _,v in pairs(ownedCars) do
            if v.state == false then
              local hashVehicule = v.vehicle.model
              local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
                local vehicleName  = aheadVehName
                local plate        = v.plate
                local labelvehicle = '| '..plate..' | '..vehicleName..' |'
                table.insert(elements, {label = labelvehicle, value = v})     
            end 
          end
        end
        if #elements == 0 then
          TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz1', 1.0)
          ESX.UI.Menu.CloseAll()
          ESX.ShowNotification('Mahini baraye Impound nadarid')
          inmenu = false
          return
        end
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz7', 1.0)
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'search_car', {
          title    = 'Mashin ro entekhab kon',
          align    = 'top-left',
          elements = elements
        }, function(data, menu)
          local selectedcar = data.current.value.vehicle.plate
          ESX.UI.Menu.CloseAll()
          TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz6', 1.0)
          local elements = {
            {label = 'ok', value = 'n'},
            {label = 'Monsaref shodam', value = 'y'},
          }
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pay_search', {
            title    = 'Ye gozine ro bezan',
            align    = 'center',
            elements = elements
          }, function(data, menu)
            if data.current.value == 'n' then
              ESX.TriggerServerCallback('esx_chopshop:canpay', function(can) 
                if can then
                  ESX.UI.Menu.CloseAll()
                  inmenu = false
                  ESX.TriggerServerCallback('esx_chopshop:issearched', function(valid) 
                    if valid then
                      TriggerServerEvent('esx_chopshop:search', selectedcar)
                      -- ESX.ShowNotification('Bach haro ferestadam donbalehs')
                      TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz10', 1.0)
                      mugshot, mugshotStr = ESX.Game.GetPedMugshot(ped)
                    else
                      -- ESX.ShowNotification('Ghablan esme in mashin ro behem dadi')
                      TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz11', 1.0)
                    end
                  end, selectedcar)
                else
                  -- ESX.ShowNotification("Poolet kheyli kame mashti!")
                  TriggerServerEvent('InteractSound_SV:PlayOnSource', 'qz9', 1.0)
                  ESX.UI.Menu.CloseAll()
                  inmenu = false
                end
              end, 10000)
            elseif data.current.value == 'y' then
              menu.close()
              inmenu = false
            end
          end, function(data, menu)
            menu.close()
            inmenu = false
          end)
        end, function(data, menu)
          menu.close()
          inmenu = false
        end)
      end)
		end
	end, function(data, menu)
		menu.close()
    inmenu = false
	end)
end


function DrawText3D(x,y,z, text, scl, font) 

  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = #(vector3(px,py,pz) - vector3(x,y,z))

  local scale = (1/dist)*scl
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov
 
  if onScreen then
      SetTextScale(0.0*scale, 1.1*scale)
      SetTextFont(font)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 255)
      SetTextDropshadow(0, 0, 0, 0, 255)
      SetTextEdge(2, 0, 0, 0, 150)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
  end
end

function DrawHelp(msg)
	if not IsHelpMessageOnScreen() then
		BeginTextCommandDisplayHelp('STRING')
		AddTextComponentSubstringWebsite(msg)
		EndTextCommandDisplayHelp(0, false, true, -1)
	end
end

function setupBlip(coords)
  blip = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetBlipSprite(blip, 310)
  SetBlipDisplay(blip, 4)
  SetBlipScale(blip, 1.0)
  SetBlipColour(blip, 40)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('chop shop')
  EndTextCommandSetBlipName(blip)
end
AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  -- RemoveBlip(blip)
  UnregisterPedheadshot(mugshot)
end)


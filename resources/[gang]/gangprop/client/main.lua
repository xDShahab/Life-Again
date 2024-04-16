  local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local set                       = false
local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastEntity                = nil
local Draging = false
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0
local allBlip                   = {}
local Data                      = {}
local ASTimer = 0

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
while ESX == nil do
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  Citizen.Wait(0)
end
end)


function OpenCloakroomMenu()

  local elements = {
    {label = ('👕 : Lebas Shakhsi'), value = 'citizen_wear'},
    {label = '👔 : Posheshe Gang', value = 'gang_wear'}
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = _U('cloakroom'),
      align    = 'center',
      elements = elements,
    },
    function(data, menu)
      menu.close()

      ESX.TriggerServerCallback('esx_skin:getGangSkin', function(skin, gangSkin)
        if data.current.value == 'citizen_wear' then
          if GetPedArmour(GetPlayerPed(-1)) > 0 then
            SetPedArmour(GetPlayerPed(-1),0)
          end
          TriggerEvent('skinchanger:loadSkin', skin)
          TriggerEvent('esx:restoreLoadout')
        elseif data.current.value == 'gang_wear' then
          if GetPedArmour(GetPlayerPed(-1)) > 0 then
            SetPedArmour(GetPlayerPed(-1),0)
          end
          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, gangSkin.skin_male)
          else
            TriggerEvent('skinchanger:loadClothes', skin, gangSkin.skin_female)
          end
        end
      end)
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end
)end



--===New Add===--


RegisterNetEvent('script:verifyarmoryac')
AddEventHandler('script:verifyarmoryac', function(station,status)
  if status then
    ESX.UI.Menu.CloseAll()
    OpenGangInventoryMenu(station)
  else
   ESX.ShowNotification("Rank Shoma Kafi Nist.")
  end
end)



RegisterNetEvent('script:verifycraftingac')
AddEventHandler('script:verifycraftingac', function(station,status)
  if status then
    ESX.UI.Menu.CloseAll()
    print('open')
    TriggerEvent('Openmen:crafting_level')
  else
    ESX.ShowNotification("Rank Shoma Kafi Nist.")
  end
end)

RegisterNetEvent('Gangprop_At2:Chekgaragrank')
AddEventHandler('Gangprop_At2:Chekgaragrank', function(station)
  ESX.UI.Menu.CloseAll()
  ListOwnedalirezaCarsMenu()
end)

RegisterNetEvent('Gangprop_At2:ChekCaptureacc')
AddEventHandler('Gangprop_At2:ChekCaptureacc', function(station,status)
  if status then
    ESX.UI.Menu.CloseAll()
    --Garag
  else
    ESX.ShowNotification("Rank Shoma Kafi Nist.")
  end
end)

RegisterNetEvent('Gangprop_At2:bossactionrank')
AddEventHandler('Gangprop_At2:bossactionrank', function(station)
  TriggerEvent('gangs:openBossMenu', CurrentActionData.station, function(data, menu)
    menu.close()
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end)
end)

RegisterNetEvent('Gangprop_At2:Menuopened')
AddEventHandler('Gangprop_At2:Menuopened', function(station,status)
  OpenGangActionsMenu()
end)

RegisterNetEvent('Gangprop_At2:Lebasperm')
AddEventHandler('Gangprop_At2:Lebasperm', function(station)
  ESX.UI.Menu.CloseAll()
  OpenCloakroomMenu()
end)

RegisterNetEvent('Gangprop_At2:Chekvestperm')
AddEventHandler('Gangprop_At2:Chekvestperm', function(station,status)
  ESX.UI.Menu.CloseAll()
  local ped = GetPlayerPed(-1)
  local armor = GetPedArmour(ped)

  if armor == 100 then
    ESX.ShowNotification("Armor shoma por ast nemitavanid dobare armor kharidari konid!")
  else
    TriggerServerEvent('gangprop:setArmor', GetPlayerServerId(PlayerId()))
  end
end)


--------------------------------------


function Opnemenucrafting()
  local elements = { 
    {label = '🛒:Shop Top Gangs',    value = 'g6'},
    {label = '✅ :Mafia Menu',   value = 'g2'},
    {label = '✅ :Cartel Menu',   value = 'g3'},
    {label = '✅ :Black Market Menu',   value = 'g4'},
    {label = '✅ :Dark Web  Menu',   value = 'g5'},
  }


  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Gang_Crafting',
    {
      title    = ('Gang_Crafting'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
      if data.current.value == 'g1' then
        Opengangmenucrafting()
      elseif data.current.value == 'g2' then
        if Data.gang_name == 'Mafia' then
          OpenWeaponmenu()
        else
          ESX.ShowNotification('Shoma Mafia Nistid')
        end
      elseif data.current.value == 'g3' then
        if Data.gang_name == 'Cartell' then
          ForshmavadEndless_cartel()
        else
          ESX.ShowNotification('Shoma Cartel Nistid')
        end

      elseif data.current.value == 'g6' then
        if Data.gang_name == 'ACDC' or Data.gang_name == 'Mafia'  then
          Topgangwiner()
        else
          ESX.ShowNotification('Shoma  Dastresi Kafi Nadarid')
        end
      elseif data.current.value == 'g4' then
        if Data.gang_name == 'ACDC' or Data.gang_name == 'WyverN' then
          OpenBlackmaretmenu()
        else
          ESX.ShowNotification('Shoma Black Market Nistid')
        end
      elseif data.current.value == 'g5' then
        if Data.gang_name == 'Dark_web' then
          DarkWebmenu()
        else
          ESX.ShowNotification('Shoma Darkweb Nistid')
        end
      end
    end)

end


--[[
RegisterNetEvent('script:verifygarageac')
AddEventHandler('script:verifygarageac', function(status)
  if status then
 ESX.UI.Menu.CloseAll()
  ListOwnedCarsMenu()
  else
  ESX.ShowNotification("Rank Shoma Kafi Nist.")
  end
end)]]


function OpenArmoryMenu(station)
  local station = station
  if Config.EnableArmoryManagement then
  
     local elements = {
      {label = '🔨: Crafting', value = 'gang_crafting'},
      {label = '🧰: Gang Inventory', value = 'property_inventory'},
      {label = ('💊: Armor'),  value = 'get_armor'}
    }
  
     ESX.UI.Menu.CloseAll()
  
     ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'center',
        elements = elements,
      },
      function(data, menu)
  
      if data.current.value == "property_inventory" then
        TriggerServerEvent('script:checkarmoryacrank',station)
      elseif data.current.value == 'get_armor' then
        TriggerServerEvent('Gangprop_At:Chekvestperm',station)

      elseif data.current.value == 'gang_crafting' then
        TriggerServerEvent('AliReza:ChekCraftingac',station)
      end
  
      end,
      function(data, menu)
  
        menu.close()
  
        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
      end
    )
  
   else
  
     local elements = {}
  
     ESX.UI.Menu.CloseAll()
  
     ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'center',
        elements = elements,
      },
      function(data, menu)
        local weapon = data.current.value
        TriggerServerEvent('gangprop:giveWeapon', weapon,  1000)
      end,
      function(data, menu)
  
         menu.close()
  
         CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
  
       end
    )
  
   end
  
  end

function OpenGangInventoryMenu(station)
	ESX.TriggerServerCallback(
		"gangs:getPropertyInventory",
    function(inventory)
			TriggerEvent("esx_inventoryhud:openGangInventory", inventory)
		end,
		station
	)
end

-- Spawn Cars
function SpawnVehicle(vehicle, plate)   
  local shokol = GetClosestVehicle(Data.vehspawn.x,  Data.vehspawn.y,  Data.vehspawn.z,  3.0,  0,  71)
  if not DoesEntityExist(shokol) then
    ESX.Game.SpawnVehicle(vehicle.model, {
      x = Data.vehspawn.x,
      y = Data.vehspawn.y,
      z = Data.vehspawn.z + 1
    }, Data.vehspawn.a, function(callback_vehicle)
      ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
      SetVehRadioStation(callback_vehicle, "OFF")
      TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)
    TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
  else
    ESX.ShowNotification('Mahale Spawn mashin Khali Nist')
  end
end



function checkvehicle(vehicle)
	Citizen.CreateThread(function()
		while CheckVehicle do
		  Citizen.Wait(2000)
		  local coords = GetEntityCoords(GetPlayerPed(-1))
		  local NearVehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  4.0,  0,  71)
			if vehicle ~= NearVehicle then
				ESX.ShowNotification("Mashin mored nazar az shoma door shod!")
				TriggerEvent("mythic_progbar:client:cancel")
				CheckVehicle = false
			end
		end
	  end)
end


function OpenGangActionsMenu()
  ESX.UI.Menu.CloseAll()    
  
  local elements = {
    {label = _U('search'), value = 'search'},
    {label = _U('handcuff'),        value = 'handcuff'},
    {label = "UnCuff",              value = 'uncuff'},
    {label = _U('drag'),            value = 'drag'},
    {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
    {label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
    {label = ('Vehicle Lockpic'), value = 'vehicle_lockpic'},
    --{label = ('Invite'), value = 'Open_invitemenu'},
  }

  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'citizen_interaction',
  {
    title    = _U('citizen_interaction'),
    align    = 'center',
    elements = elements
  },
  function(data2, menu2)

    local player, distance = ESX.Game.GetClosestPlayer()
    
    if data2.current.value == 'vehicle_lockpic' then
      ESX.TriggerServerCallback('At_Craftiing:Getganglevel', function(Level)
        if Level > 10 then
          local vehicle = ESX.Game.GetVehicleInDirection(4)
          if DoesEntityExist(vehicle) then
              local playerPed = GetPlayerPed(-1)
              CheckVehicle = true
              checkvehicle(vehicle)
                TriggerServerEvent('esx_customItems:remove', "blowtorch")
                TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
                SetVehicleAlarm(vehicle, true)
                StartVehicleAlarm(vehicle)
                SetVehicleAlarmTimeLeft(vehicle, 40000)
                TriggerEvent("mythic_progbar:client:progress", {
                name = "hijack_vehicle",
                duration = 60000,
                label = "LockPick kardan mashin",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                  disableMovement = true,
                  disableCarMovement = true,
                  disableMouse = false,
                  disableCombat = true,
                }
              }, function(status)
                if not status then
                  SetVehicleDoorsLocked(vehicle, 1)
                  SetVehiceleDoorsLockedForAllPlayers(vehicle, false)
                  ClearPedTasksImmediately(playerPed)
                  ESX.ShowNotification("Mashin baz shod")
                  CheckVehicle = false
                elseif status then
                  ClearPedTasksImmediately(playerPed)
                  CheckVehicle = false
                end
              end)
            else
             ESX.ShowNotification("Hich mashini nazdik shoma nist")
            end
        else
          ESX.ShowNotification('Baray Estefadeh Az In Ghabeliyat Gang Shoma Bayad Level Bishtar Az 10 Dashte Bashad')
        end
      end)
    end

    if distance ~= -1 and distance <= 3.0 then

      if data2.current.value == 'handcuff' then
        local target, distance = ESX.Game.GetClosestPlayer()
        playerheading = GetEntityHeading(GetPlayerPed(-1))
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerCoords = GetEntityCoords(GetPlayerPed(-1))
        local target_id = GetPlayerServerId(target)
        if distance <= 2.0 then
          ESX.TriggerServerCallback('esx_policejob:IsHandCuffed', function(status)
            if not status then
              ExecuteCommand("me **Dast Hay Fard Ro Be Arami Dast Band Mizanad**")
              TriggerServerEvent('kobsjob:art', target_id, playerheading, playerCoords, playerlocation)
            end
          end, target_id)
        else
          ESX.ShowNotification('Not Close Enough To Cuff.')
        end
      elseif data2.current.value == 'uncuff' then
			  local target, distance = ESX.Game.GetClosestPlayer()
			  playerheading = GetEntityHeading(GetPlayerPed(-1))
			  playerlocation = GetEntityForwardVector(PlayerPedId())
			  playerCoords = GetEntityCoords(GetPlayerPed(-1))
			  local target_id = GetPlayerServerId(target)
			  if distance <= 2.0 then
          ExecuteCommand("me **Dast Hay Fard Ro Baz Miknd**")
				  TriggerServerEvent('esx_policejob:requestreleases', target_id, playerheading, playerCoords, playerlocation)
			  else
				  ESX.ShowNotification('Not Close Enough To UnCuff.')
			  end
      elseif data2.current.value == 'drag' then
        ExecuteCommand("me **Bazo Fard Ro Migirad**")
        Draging = not Draging
        if Draging then
          loadanimdict('switch@trevor@escorted_out')
          TaskPlayAnim(PlayerPedId(), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        else
          StopAnimTask(PlayerPedId(), 'switch@trevor@escorted_out', '001215_02_trvs_12_escorted_out_idle_guard2', 1.0)
          ClearPedSecondaryTask(PlayerPedId())
        end
        TriggerServerEvent('esx_policejob:aaadrag', GetPlayerServerId(player))
      elseif data2.current.value == 'put_in_vehicle' then
        TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(player))
      elseif data2.current.value == 'out_the_vehicle' then
        TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(player))
      elseif data2.current.value == 'Open_invitemenu' then
        TriggerServerEvent('Gangprop_At:Chekbossactionrank',station)
      elseif data2.current.value == "search" then
        if IsEntityPlayingAnim(GetPlayerPed(player), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer", 3)  then ---Salam
          ESX.ShowNotification("Shoma Nemitavanid Fard Ra Dar Halat Open Bodan Inventory Search Knid")
        else
          OpenBodySearchMenu(player)
          local text = '* Shoro be gashtane fard mikone *'
          TriggerServerEvent('3dme:shareDisplay', text, true)
          TriggerServerEvent('esx_Gangbalasthaji', GetPlayerServerId(player), GetPlayerServerId(PlayerId()))
        end
      end

    else
      ESX.ShowNotification('no_players_nearby')

    end


  end,
  function(data2, menu2)
    menu2.close()
  end)
end


RegisterNetEvent('esx_gangjob:aaadrag')
AddEventHandler('esx_gangjob:aaadrag', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

RegisterNetEvent('mamadreza:hhhhhh')
AddEventHandler('mamadreza:hhhhhh', function()

 IsHandcuffed    = not IsHandcuffed;
local playerPed = GetPlayerPed(-1)

 Citizen.CreateThread(function()

   if IsHandcuffed then

    RequestAnimDict('mp_arresting')

    while not HasAnimDictLoaded('mp_arresting') do
      Wait(100)
    end

     TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
    SetEnableHandcuffs(playerPed, true)
    SetPedCanPlayGestureAnims(playerPed, false)
    FreezeEntityPosition(playerPed,  true)

   else

    ClearPedSecondaryTask(playerPed)
    SetEnableHandcuffs(playerPed, false)
    SetPedCanPlayGestureAnims(playerPed,  true)
    FreezeEntityPosition(playerPed, false)

   end

 end)
end)

function OpenBodySearchMenu(player)

  ESX.TriggerServerCallback('esx:getOtherPlayerDataCard', function(data)

    local elements = {}

    table.insert(elements, {label = '--- Money ---', value = nil})

    table.insert(elements, {label = ESX.Math.GroupDigits(data.money), value = nil})

    table.insert(elements, {label = '--- Armes ---', value = nil})

    for i=1, #data.weapons, 1 do
      table.insert(elements, {
        label          = _U('confiscate') .. ESX.GetWeaponLabel(data.weapons[i].name),
        value          = data.weapons[i].name,
        itemType       = 'item_weapon',
        amount         = data.ammo,
      })
    end

    table.insert(elements, {label = _U('inventory_label'), value = nil})

    for i=1, #data.inventory, 1 do
      if data.inventory[i].count > 0 then
        table.insert(elements, {
          label          = _U('confiscate_inv') .. data.inventory[i].count .. ' ' .. data.inventory[i].label,
          value          = data.inventory[i].name,
          itemType       = 'item_standard',
          amount         = data.inventory[i].count,
        })
      end
    end


    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'body_search',
      {
        title    = _U('search'),
        align    = 'center',
        elements = elements,
      },
      function(data, menu)

        local itemType = data.current.itemType
        local itemName = data.current.value
        local amount   = data.current.amount

        if data.current.value ~= nil then
          local coords = GetEntityCoords(PlayerPedId())
          if IsEntityPlayingAnim(GetPlayerPed(player), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer", 3)  then ---Salam
            ESX.ShowNotification("Shoma Nemitavanid Fard Ra Dar Halat Open Bodan Inventory Search Knid")
            menu.close()
          else
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), coords.x, coords.y, coords.z, true) <= 3.0 then
              Wait(math.random(0, 500))
              TriggerServerEvent('esx:confiscatePlayerItem', GetPlayerServerId(player), itemType, itemName, amount)
              OpenBodySearchMenu(player)
            else
              menu.close()
            end
          end
        end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, GetPlayerServerId(player))

end


function OpenGetStocksMenu(gang)
local gang = gang

 ESX.TriggerServerCallback('gangs:getStockItems', function(items)

   -- print(json.encode(items))

  local elements = {}

  for i=1, #items, 1 do
    table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
  end

   ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'stocks_menu',
    {
      title    = _U('gang_stock'),
      elements = elements
    },
    function(data, menu)

       local itemName = data.current.value

       ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
        {
          title = _U('quantity')
        },
        function(data2, menu2)

          local count = tonumber(data2.value)

          if count == nil then
            ESX.ShowNotification(_U('quantity_invalid'))
          else
            menu2.close()
            menu.close()
            TriggerServerEvent('gangs:getStockItem', gang, itemName, count)
            OpenGetStocksMenu(gang)
          end

         end,
        function(data2, menu2)
          menu2.close()
        end
      )

     end,
    function(data, menu)
      menu.close()
    end
  )

 end, gang)

end

function OpenPutStocksMenu(station)
local gang = station

 ESX.TriggerServerCallback('gangprop:getPlayerInventory', function(inventory)

   local elements = {}

   for i=1, #inventory.items, 1 do

     local item = inventory.items[i]

     if item.count > 0 then
      table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
    end

   end

   ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'stocks_menu',
    {
      title    = _U('inventory'),
      elements = elements
    },
    function(data, menu)

       local itemName = data.current.value

       ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
        {
          title = _U('quantity')
        },
        function(data2, menu2)

          local count = tonumber(data2.value)

          if count == nil then
            ESX.ShowNotification(_U('quantity_invalid'))
          else
            menu2.close()
            menu.close()

            TriggerServerEvent('gangs:putStockItems', gang, itemName, count)
            OpenPutStocksMenu(station)
          end

         end,
        function(data2, menu2)
          menu2.close()
        end
      )

     end,
    function(data, menu)
      menu.close()
    end
  )

 end)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  local WWaiTT = true
  if PlayerData.gang.name ~= 'nogang' then
    ESX.TriggerServerCallback('gangs:getGangData', function(data)
      if data ~= nil then
        Data.gang_name    = data.gang_name
        Data.blip         = json.decode(data.blip)
        blipManager(Data.blip)
        Gangradara(Data.blip)
        Data.armory       = json.decode(data.armory)
        Data.locker       = json.decode(data.locker)
        Data.boss         = json.decode(data.boss)
        Data.vehicles     = json.decode(data.vehicles)
        Data.veh          = json.decode(data.veh)
        Data.vehdel       = json.decode(data.vehdel)
        Data.vehspawn     = json.decode(data.vehspawn)
        Data.vehprop      = json.decode(data.vehprop)
        Data.search       = data.search
        Data.bulletproof  = data.bulletproof
      else
        ESX.ShowNotification('You Gang has been expired, Contact admins for recharge!')
      end
      WWaiTT = false
    end, PlayerData.gang.name)
  end
  Citizen.CreateThread(function()
    while WWaiTT do
      Citizen.Wait(0)
    end
    while PlayerData.gang.name ~= 'nogang' and Data.gang_name do
      Citizen.Wait(0)
      if IsControlJustReleased(0, Keys['F5']) then
        ESX.TriggerServerCallback('AT_Comserv:IsInComServ', function(IsJailed)
          if IsJailed == false then
            Wait(100)

            TriggerServerEvent('Gangprop_At:ChekMenuopened',station)
          else
            ESX.ShowNotification("Bug Abus Nakn Dadash Ghol Man. Xd Age bazam bug didi be man bego . [AliReza_At]")
            CancelEvent()
          end
        end)
      end
    end
  end)
  if PlayerData.gang.name == 'Mafia' then
    HeliSpawnPoint(vector3(-106.71, 1007.42, 234.76), vector3(-113.63, 1018.54, 236.74), 0)
  end
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
  PlayerData.gang = gang
  Data = {}
  local WWaiTT = true
  if PlayerData.gang.name ~= 'nogang' then
    ESX.TriggerServerCallback('gangs:getGangData', function(data)
      if data ~= nil then
        Data.blip         = json.decode(data.blip)
        blipManager(Data.blip)
        Gangradara(Data.blip)

        Data.gang_name    = data.gang_name
        Data.armory       = json.decode(data.armory)
        Data.locker       = json.decode(data.locker)
        Data.boss         = json.decode(data.boss)
        Data.vehicles     = json.decode(data.vehicles)
        Data.veh          = json.decode(data.veh)
        Data.vehdel       = json.decode(data.vehdel)
        Data.vehspawn     = json.decode(data.vehspawn)
        Data.vehprop      = json.decode(data.vehprop)
        Data.search       = data.search
        Data.bulletproof  = data.bulletproof
      else
        ESX.ShowNotification('Gang Shoam expire Shodeh Ast')
      end
      WWaiTT = false
    end, PlayerData.gang.name)
  else
    for _, blip in pairs(allBlip) do
      RemoveBlip(blip)
    end
    allBlip = {}
  end
  Citizen.CreateThread(function()
    while WWaiTT do
      Citizen.Wait(0)
    end
    while PlayerData.gang.name ~= 'nogang' and Data.gang_name do
      Citizen.Wait(0)
      if IsControlJustReleased(0, Keys['F5']) then
        ESX.TriggerServerCallback('AT_Comserv:IsInComServ', function(IsJailed)
          if IsJailed == false then
            Wait(100)
           -- OpenGangActionsMenu()
           TriggerServerEvent('Gangprop_At:ChekMenuopened',station)
          else
            ESX.ShowNotification("Shoma Nemitavanid Dar Comserc Az Menu F5 Estefadeh Knid")
            CancelEvent()
          end
        end)
      end
    end
  end)
end)  

--  blips
function blipManager(blip, name, icon)
  local Name = name or 'Gang'
  local Icon = icon or 671
  for _, blip in pairs(allBlip) do
    RemoveBlip(blip)
  end
  allBlip = {}
  local blipCoord = AddBlipForCoord(blip.x, blip.y)
  table.insert(allBlip, blipCoord)
  SetBlipSprite (blipCoord, Icon)
  SetBlipDisplay(blipCoord, 4)
  SetBlipScale  (blipCoord, 1.2)
  SetBlipColour (blipCoord, 76)
  SetBlipAsShortRange(blipCoord, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString(Name)
  EndTextCommandSetBlipName(blipCoord)
end


function Gangradara(blip, name , icon)
  ESX.ShowNotification('Shoma Ozv Gang Hastid')
end


Citizen.CreateThread(function()
  while ESX == nil do Citizen.Wait(2500) end
  LoadBlips()
end)

function LoadBlips()
    ESX.TriggerServerCallback('esx_best:getBlips', function(data)
        for k, v in pairs(data) do
          local tempData = json.decode(v.blip)
          local blipCoord = AddBlipForRadius(tempData.x, tempData.y, tempData.z, 50.0)
          SetBlipHighDetail(blipCoord, true)
          SetBlipColour(blipCoord, 44)
          SetBlipAlpha(blipCoord, 100)
          SetBlipAsShortRange(blipCoord, true)  
          BeginTextCommandSetBlipName("STRING")
          AddTextComponentString('Gang')
          EndTextCommandSetBlipName(blipCoord)
        end
    end)
end





function ListOwnedalirezaCarsMenu()

	local elements = {}
	
	table.insert(elements, {label = '| Pelak | Esm Mashin |'})

	ESX.TriggerServerCallback('gangprop:getCars', function(ownedCars)
		if #ownedCars == 0 then
			ESX.ShowNotificatio('Gang Shoam Masshin Nadarad')
		else
      for _,v in pairs(ownedCars) do
        if v.stored then
          local hashVehicule = v.vehicle.model
          local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
          local vehicleName  = GetLabelText(aheadVehName)
          local plate        = v.plate
          local labelvehicle
          labelvehicle = '| '..plate..' | '..vehicleName..' |'
				  table.insert(elements, {label = labelvehicle, value = v})          
				end
			end
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
			title    = 'Gang Parking',
			 align    = 'center',
			elements = elements
		}, function(data, menu)
			if data.current.value.stored then
        menu.close()
        Wait(math.random(0,500))
        ESX.TriggerServerCallback('gangprop:carAvalible', function(avalibele)
          if avalibele then        
            SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
          else
            ESX.ShowNotification('In Mashin Qablan az Parking Dar amade ast')
          end
        end, data.current.value.plate)
			else
				ESX.ShowNotification(_U('car_is_impounded'))
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end


AddEventHandler('gangprop:hasEnteredMarker', function(station, part)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {station = station}
  elseif part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  elseif part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = '~INPUT_PICKUP~ Vehicle Menu'
    CurrentActionData = {station = station}

  elseif part == 'VehicleDeleter' then

    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)
      local suc     = GetPedInVehicleSeat(vehicle, -1) == playerPed
      if DoesEntityExist(vehicle) and suc then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle, station = station}
      end

    end

  elseif part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {station = station}
  end
end)

AddEventHandler('gangprop:hasExitedMarker', function(station, part)
ESX.UI.Menu.CloseAll()
CurrentAction = nil
end)

-- AddEventHandler('gangprop:hasEnteredEntityZone', function(entity)

--   local playerPed = GetPlayerPed(-1)

--   if PlayerData.job ~= nil and PlayerData.job.name == 'gang' and not IsPedInAnyVehicle(playerPed, false) then
--     CurrentAction     = 'remove_entity'
--     CurrentActionMsg  = _U('remove_object')
--     CurrentActionData = {entity = entity}
--   end

--   if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

--     local playerPed = GetPlayerPed(-1)
--     local coords    = GetEntityCoords(playerPed)

--     if IsPedInAnyVehicle(playerPed,  false) then

--       local vehicle = GetVehiclePedIsIn(playerPed)

--       for i=0, 7, 1 do
--         SetVehicleTyreBurst(vehicle,  i,  true,  1000)
--       end

--     end

--   end

-- end)

-- AddEventHandler('gangprop:hasExitedEntityZone', function(entity)

--   if CurrentAction == 'remove_entity' then
--     CurrentAction = nil
--   end

-- end)

RegisterNetEvent('gangprop:handcuffalirezalesvibboro')
AddEventHandler('gangprop:handcuffalirezalesvibboro', function()
IsHandcuffed    = not IsHandcuffed
local playerPed = GetPlayerPed(-1)
  Citizen.CreateThread(function()
    if IsHandcuffed then
      RequestAnimDict('mp_arresting')
      while not HasAnimDictLoaded('mp_arresting') do
        Wait(100)
      end
      TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
      SetEnableHandcuffs(playerPed, true)
      SetPedCanPlayGestureAnims(playerPed, false)
      FreezeEntityPosition(playerPed,  true)
    else
      ClearPedSecondaryTask(playerPed)
      SetEnableHandcuffs(playerPed, false)
      SetPedCanPlayGestureAnims(playerPed,  true)
      FreezeEntityPosition(playerPed, false)
    end
  end)
end)

RegisterNetEvent('gangprop:drag')
AddEventHandler('gangprop:drag', function(cop)
  TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

RegisterNetEvent('gangprop:putInVehicle')
AddEventHandler('gangprop:putInVehicle', function()

local playerPed = GetPlayerPed(-1)
local coords    = GetEntityCoords(playerPed)

 if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

   local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

   if DoesEntityExist(vehicle) then

    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    local freeSeat = nil

     for i=maxSeats - 1, 0, -1 do
      if IsVehicleSeatFree(vehicle,  i) then
        freeSeat = i
        break
      end
    end

     if freeSeat ~= nil then
      TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
    end

   end

 end

end)

RegisterNetEvent('gangprop:OutVehicle')
AddEventHandler('gangprop:OutVehicle', function(t)
  local ped = GetPlayerPed(t)
  ClearPedTasksImmediately(ped)
  plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
  local xnew = plyPos.x+2
  local ynew = plyPos.y+2
  SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 30,  true) -- MoveLeftRight
      DisableControlAction(0, 31,  true) -- MoveUpDown
    end
  end
end)



Citizen.CreateThread(function()
  while true do
  
    Wait(1)
  
    local playerPed = GetPlayerPed(-1)
    local coords    = GetEntityCoords(playerPed)
    
    ---====Marker Typ====---
    local Mveh = 36
    local Mlocker = 31
    local Marmory = 42
    local Mvehdelete = 24
    local Mboss = 29



    if Data.locker ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.locker.x,  Data.locker.y,  Data.locker.z,  true) < Config.DrawDistance then
        DrawMarker(Mlocker, Data.locker.x,  Data.locker.y,  Data.locker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6,0.6,0.6, 241, 254, 82, 200, true, true, 2, true, false, false, false)
      end
    end
  
  
    if Data.armory ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.armory.x,  Data.armory.y,  Data.armory.z,  true) < Config.DrawDistance then
        DrawMarker(Marmory, Data.armory.x,  Data.armory.y,  Data.armory.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6,0.6,0.6, 49, 251, 64, 200, true, true, 2, true, false, false, false)
      end
    end
  
    if Data.veh ~= nil then
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  Data.veh.x,  Data.veh.y,  Data.veh.z,  true) < 5 then
          DrawMarker(Mveh, Data.veh.x,  Data.veh.y,  Data.veh.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 247, 111, 0, 100, true, true, 2, false, false, false, false)
      end
    end
  
    if Data.vehdel ~= nil then
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),   Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z,  true) < 5 then
      DrawMarker(Mvehdelete, Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, 255, 0, 0, 100, true, true, 2, false, false, false, false)
      end
    end
  
    if Data.boss ~= nil then
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),  Data.boss.x,  Data.boss.y,  Data.boss.z,  true) < 5 then
        DrawMarker(Mboss, Data.boss.x,  Data.boss.y,  Data.boss.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6,0.6,0.6, 255, 255, 255, 200, true, true, 2, true, false, false, false)
      end
    end
      
  end
  end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

 while true do

  Wait(1000)

  if PlayerData.gang ~= nil then
    local playerPed      = GetPlayerPed(-1)
    local coords         = GetEntityCoords(playerPed)
    local isInMarker     = false
    local currentStation = nil
    local currentPart    = nil
    
    if Data.locker ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.locker.x,  Data.locker.y,  Data.locker.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'Cloakroom'
      end
    end

    if Data.armory ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.armory.x,  Data.armory.y,  Data.armory.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'Armory'
      end
    end

    if Data.veh ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.veh.x,  Data.veh.y,  Data.veh.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'VehicleSpawner'
      end
    end

    if Data.vehspawn ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.vehspawn.x,  Data.vehspawn.y,  Data.vehspawn.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'VehicleSpawnPoint'
      end
    end

    if Data.vehdel ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'VehicleDeleter'
      end
    end

    if Data.boss ~= nil and PlayerData.gang ~= nil  then
      if GetDistanceBetweenCoords(coords,   Data.boss.x,  Data.boss.y,  Data.boss.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'BossActions' 
      end
    end

    local hasExited = false
    
    if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart)) then
      if
        (LastStation ~= nil and LastPart ~= nil) and
        (LastStation ~= currentStation or LastPart ~= currentPart)
      then
        TriggerEvent('gangprop:hasExitedMarker', LastStation, LastPart)
        hasExited = true
      end
      HasAlreadyEnteredMarker = true
      LastStation             = currentStation
      LastPart                = currentPart

      TriggerEvent('gangprop:hasEnteredMarker', currentStation, currentPart)
    end

    if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

      HasAlreadyEnteredMarker = false

      TriggerEvent('gangprop:hasExitedMarker', LastStation, LastPart)
    end
  end
 end
end)


-- Key Controls
Citizen.CreateThread(function()
while true do

   Citizen.Wait(10)

   if CurrentAction ~= nil then

    SetTextComponentFormat('STRING')
    AddTextComponentString(CurrentActionMsg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and PlayerData.gang ~= nil and PlayerData.gang.name == CurrentActionData.station and (GetGameTimer() - GUI.Time) > 150 then
        if CurrentAction == 'menu_cloakroom' then
          TriggerServerEvent('Gangprop_At:ChekLebasperm',station)
        elseif CurrentAction == 'menu_armory' then
          OpenArmoryMenu(CurrentActionData.station)
        elseif CurrentAction == 'menu_vehicle_spawner' then
        ESX.UI.Menu.CloseAll()
        TriggerServerEvent('Gangprop_At:Chekgaragrank',station)
        elseif CurrentAction == 'delete_vehicle' then
          StoreOwnedCarsMenu()
        elseif CurrentAction == 'menu_boss_actions' then
          ESX.UI.Menu.CloseAll()
         -- TriggerEvent('gangs:openBossMenu', CurrentActionData.station, function(data, menu)
          --  menu.close()
         --   CurrentAction     = 'menu_boss_actions'
          --  CurrentActionMsg  = _U('open_bossmenu')
          --  CurrentActionData = {}
          --end)
          TriggerServerEvent('Gangprop_At:Chekbossactionrank',station)
        end
        CurrentAction = nil
        GUI.Time      = GetGameTimer()
      end
    end
  end
end)

function StoreOwnedCarsMenu()
	local playerPed    = GetPlayerPed(-1)
  local coords       = GetEntityCoords(playerPed)
  local vehicle      = CurrentActionData.vehicle
  local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
  local engineHealth = GetVehicleEngineHealth(vehicle)
  local plate        = vehicleProps.plate
  
  ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
    if valid then
      if engineHealth < 990 then
        local apprasial = math.floor((1000 - engineHealth)/1000*1000*5)
        reparation(apprasial, vehicle, vehicleProps)
      else
        putaway(vehicle, vehicleProps)
      end	
    else
      ESX.ShowNotification('Shoma nemitavanid in mashin ro dar Parking Park konid')
    end
  end, vehicleProps)
end

-- Repair Vehicles
function reparation(apprasial, vehicle, vehicleProps)
	ESX.UI.Menu.CloseAll()
	
	local elements = {
		{label = 'Park kardane mashin va Pardakhte: ' .. ' ($'.. tonumber(apprasial)/2 .. ')', value = 'yes'},
		{label = 'Tamas Ba mechanic', value = 'no'}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
		title    = 'Mashine shoma Zarbe Khorde',
		 align    = 'center',
		elements = elements
	}, function(data, menu)
		menu.close()
		
		if data.current.value == 'yes' then

			ESX.TriggerServerCallback('esx_advancedgarage:checkRepairCost', function(hasEnoughMoney)
				if hasEnoughMoney then
					TriggerServerEvent('esx_advancedgarage:payhealth', tonumber(apprasial)/2)
					putaway(vehicle, vehicleProps)
				else
					ESX.ShowNotification('Shoma Poole Kafi nadarid')
				end
			end, tonumber(apprasial))

		elseif data.current.value == 'no' then
			ESX.ShowNotification('Darkhaste Mechanic')
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Put Away Vehicles
function putaway(vehicle, vehicleProps)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true)
	ESX.ShowNotification('Mashin dar Garage Park shod')
end





RegisterNetEvent('NB:openMenuGang')
AddEventHandler('NB:openMenuGang', function()
  OpenGangActionsMenu()
end)

RegisterNetEvent("setArmorHandler")
AddEventHandler("setArmorHandler",function(mghdr)
  local ped = GetPlayerPed(-1)
  SetPedArmour(ped, mghdr) 
  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
      local clothesSkin = {
        ['bproof_1'] = 43,  ['bproof_2'] = 0,
      }
      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    elseif skin.sex == 1 then
      local clothesSkin = {
        ['bproof_1'] = 6,  ['bproof_2'] = 3,
      }
      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end
  end)
end)



RegisterCommand('glist',function(source)
  ESX.TriggerServerCallback('script:getganglistusers', function(a,info,cc,ngang)
    if a then
      local elements = {}
      for i=1, #info, 1 do
        table.insert(elements, {label = info[i].name.."("..info[i].Id..")"})
      end
      ESX.UI.Menu.CloseAll()
      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ganlist',{title    = 'Afrade Online Gang '..ngang..' : ('..cc..') Nafar',align    = 'center',elements = elements},
      function(data2, menu2)  
      end,
      function(data2, menu2)
        menu2.close() 
      end) 
    else
      ESX.ShowNotification("Shoma Dar Gangi Hozur Nadarid.")
    end
  end)
end)















function OpenBlackmaretmenu()
  ESX.UI.Menu.CloseAll()
  HasAlreadyEnteredMarker = true
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Gang_menu', {
      title    = "Black Market",
      align    = 'center',
      elements = {
          {label = "Vest 10%        --> +5 Tala ", value = "b1"},
          {label = "Vest 20%        --> +10 Tala ", value = "b2"},
          {label = "Vest 30%        --> +15 Tala ", value = "b3"},
          {label = "Vest 40%        --> +20 Tala ", value = "b4"},


      }

  }, function(data, menu)

      if data.current.value == "b1" then
       TriggerServerEvent('Gangprop:vest10', GetPlayerServerId(PlayerId()))
      elseif data.current.value == "b2" then
        TriggerServerEvent('Gangprop:vest20', GetPlayerServerId(PlayerId()))
      elseif data.current.value == "b3" then
        TriggerServerEvent('Gangprop:vest30', GetPlayerServerId(PlayerId()))
      elseif data.current.value == "b4" then
        TriggerServerEvent('Gangprop:vest40', GetPlayerServerId(PlayerId()))
      elseif data.current.value == "b5" then
        TriggerServerEvent('Gangprop:bandage20', GetPlayerServerId(PlayerId()))
      end

  end, function (data, menu)
      menu.close()
      HasAlreadyEnteredMarker = false
  end)
end




function ForshmavadEndless_cartel()
	local elements = { 
        {label = 'Marijuana     -$8K',    value = 'marijuana'},
        {label = 'Crack        -$6K',   value = 'meth'},
        {label = 'Kokayin         -$4K',   value = 'crack'},
        {label = '---------------------------',   value = 'carbinerifl13e'},
        {label = 'LSD   -->>> 5 Sang',   value = 'lsd'},
      }

    
      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'Forosh_Mavad',
        {
          title    = ('Cartel_Menu'),
          align    = 'center',
          elements = elements,
        },

        function(data, menu)
			if data.current.value == 'marijuana' then
				TriggerServerEvent('Gang_Endless_cartel:marijuana', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'meth' then
				TriggerServerEvent('Gang_Endless_cartel:Crack', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'crack' then
				TriggerServerEvent('Gang_Endless_cartel:cocaine', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'Cocaine' then
				TriggerServerEvent('Gang_Endless_cartel:Cocaine', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'heroine' then
				TriggerServerEvent('Gang_Endless_cartel:Heroine', GetPlayerServerId(PlayerId()))
			elseif data.current.value == 'lsd' then
				TriggerServerEvent('Gang_lsd:addkiralireza', GetPlayerServerId(PlayerId()))
			end
        end)

end



function OpenWeaponmenu() 
	local elements = { 
    {label = 'Pistol50      -Sang > 20',    value = 'Pistol50'},
    {label = 'Micro Smg     -Sang > 25',   value = 'micro'},
    {label = 'SMG           -Sang > 30',   value = 'smg'},
    {label = 'Carbinerifle  -Sang > 40',   value = 'carbinerifle'},
{label = 'Ceramicpistol -Sang > 40',   value = 'Ceramicpistol'},
{label = 'Bullpuprifle  -Sang > 70',   value = 'Bullpuprifle'},
{label = 'Gusenberg     -Sang > 80',   value = 'Gusenberg'},
  }
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'By_Weapon',
    {
      title    = ('By_Weapon'),
       align    = 'center',
      elements = elements,
    },

    function(data, menu)
  if data.current.value == 'Pistol50' then
    TriggerServerEvent('Gang_Mafia:Pistol50', GetPlayerServerId(PlayerId()))
  elseif data.current.value == 'micro' then
    TriggerServerEvent('Gang_Mafia:micro', GetPlayerServerId(PlayerId()))
  elseif data.current.value == 'smg' then
    TriggerServerEvent('Gang_Mafia:smg', GetPlayerServerId(PlayerId()))
  elseif data.current.value == 'carbinerifle' then
    TriggerServerEvent('Gang_Mafia:carbinerifle', GetPlayerServerId(PlayerId()))
  elseif data.current.value == 'Ceramicpistol' then
    TriggerServerEvent('Gang_Mafia:Ceramicpistol', GetPlayerServerId(PlayerId()))
  elseif data.current.value == 'Bullpuprifle' then
    TriggerServerEvent('Gang_Mafia:Bullpuprifle', GetPlayerServerId(PlayerId()))
  elseif data.current.value == 'Gusenberg' then
    TriggerServerEvent('Gang_Mafia:Gusenberg', GetPlayerServerId(PlayerId()))
  end
    end)
end



function DarkWebmenu()
	local elements = { 
    {label = 'Ertebat Ba Mafia',    value = 'L1'},
    {label = 'Ertebat Ba Cartel',   value = 'L2'},
    {label = 'Ertebat Ba Black_Market',   value = 'L3'},
  }
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Dark_Web',
    {
      title    = ('Dark_Web'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
      if data.current.value == 'L1' then
        TriggerServerEvent('AliReza_Mafia:Darkweb', GetPlayerServerId(PlayerId()))
      elseif data.current.value == 'L2' then
        TriggerServerEvent('AliReza_cartel:Darkweb', GetPlayerServerId(PlayerId()))
      elseif data.current.value == 'L3' then
        TriggerServerEvent('AliReza_blackmark:Darkweb', GetPlayerServerId(PlayerId()))
      end
    end)
end



function Topgangwiner() 
	local elements = { 
    {label = '🛠 :Carft Silencer --> 5Gold',    value = 'L1'},
    {label = '🛠 :Craft Keshab   --> 10Gold',   value = 'L2'},
    {label = '🛠 :Craft Skin Gun   --> 30Gold',   value = 'L3'},
    {label = '🛠 :Craft Sns Pistol   --> 40Gold',   value = 'L4'},
  }
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'Topgang_Crafting',
    {
      title    = ('Topgang_Crafting'),
      align    = 'center',
      elements = elements,
    },

    function(data, menu)
      if data.current.value == 'L1' then
        TriggerServerEvent('AliReza_top:silencer', GetPlayerServerId(PlayerId()))
      elseif data.current.value == 'L2' then
        TriggerServerEvent('AliReza_top:clip', GetPlayerServerId(PlayerId()))
      elseif data.current.value == 'L3' then
        TriggerServerEvent('AliReza_top:skingun', GetPlayerServerId(PlayerId()))
      elseif data.current.value == 'L4' then
        TriggerServerEvent('AliReza_top:snspisstol', GetPlayerServerId(PlayerId()))
      end
    end)
end






--- cuff anim --
function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end
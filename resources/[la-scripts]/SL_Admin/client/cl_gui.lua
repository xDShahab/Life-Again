local aduty = false
local OffDuty = nil
local godmode = false
local infinite_stamina = false
local invisibility = false
local noRagDoll = false
local noclip = false
local timer = 0

PlayersCache = {}
lastspec = 0

RegisterNetEvent('AT_Admin:ChangeMenuStatus')
AddEventHandler('AT_Admin:ChangeMenuStatus', function(boolean)
  WarMenu.CloseMenu()
  aduty = boolean
  if aduty and OffDuty == nil then 
    AdminM()
  else
    OffDuty = true
  end
  if aduty then
    Infinity()
  end
end)

AddEventHandler("onKeyDown", function(key)
  if key == "f4" and aduty and not WarMenu.IsAnyMenuOpened() then
  WarMenu.OpenMenu('main')
      AdminMenu()
      end
end)
function AdminM()
ESX.TriggerServerCallback('AT_Admin:GetActivePlayers', function(players)
  PlayersCache = {}
  PlayersCache = players

end)
end

RegisterNetEvent('AT_Admin:PlayerJoined')
AddEventHandler('AT_Admin:PlayerJoined', function(source, name)
  PlayersCache[source] = name
end)

function GetLast(table)
  local last = 0
  for c in pairs(table) do
    if c > last then
      last = c
    end
  end
  return last
end

function Infinity()
  Citizen.CreateThread(function()
    while aduty do
      Citizen.Wait(10000)
      PlayersCache = {}
      ESX.TriggerServerCallback('AT_Admin:GetActivePlayers', function(players)
        PlayersCache = players
      end)
    end
  end)
end

Citizen.CreateThread(function ()
  WarMenu.CreateMenu('main', 'LifeAgain Admin')
  WarMenu.CreateSubMenu('spectate', 'main', 'Spectate Players')
  WarMenu.CreateSubMenu('Admin_power', 'main', 'Admin Access')
  WarMenu.CreateSubMenu('player_menu', 'main', 'Admin Menu')

end)

function AdminMenu()
  local mOpen = false
  -- ---------------------------------------------------------------------
  -- MAIN MENU
  -- ---------------------------------------------------------------------
  if WarMenu.IsMenuOpened('main') then
    mOpen = true
    WarMenu.MenuButton('Spectate Menu', 'spectate')
    WarMenu.MenuButton('Admin Access', 'Admin_power')
    WarMenu.MenuButton('Teleport Menu', 'player_menu')

    WarMenu.Display()
  -- ---------------------------------------------------------------------
  -- PLAYER MENU
  -- ---------------------------------------------------------------------
  elseif WarMenu.IsMenuOpened('player_menu') then
    mOpen = true
    if WarMenu.Button('Teleport To Az') then
      TriggerEvent('Alireza_WhiteList', source)
      SetEntityCoords(PlayerPedId(), -419.1,  1147.09, 325.86)	
      TriggerEvent('es_admin:freezePlayer', true)
      ESX.ShowNotification("~h~Shoma Be AdminZone Teleport Shodid")
      Citizen.Wait(2000)
      TriggerEvent('es_admin:freezePlayer', false)
    elseif WarMenu.Button('Teleport To LSPD') then
      TriggerEvent('Alireza_WhiteList', source)
      SetEntityCoords(PlayerPedId(), 377.6,  -999.09, 29.44)	
      TriggerEvent('es_admin:freezePlayer', true)
      ESX.ShowNotification("~h~Shoma Be LSPD Teleport Shodid")
      Citizen.Wait(2000)
      TriggerEvent('es_admin:freezePlayer', false)
    end
    WarMenu.Display()
  -- ---------------------------------------------------------------------
  -- SPECTATE PLAYER
  -- ---------------------------------------------------------------------
  elseif WarMenu.IsMenuOpened('spectate') then
    mOpen = true
    for i=1, GetLast(PlayersCache) do
      if PlayersCache[i] then
        if WarMenu.CheckBox("["..i.."] "..PlayersCache[i], spec[i], function(checked) spec[i] = checked end) then
          if spec[i] then
            spec[lastspec] = false
            lastspec = i
            spectate(lastspec)
            --TriggerServerEvent('Alirezz:staffm', GetPlayerServerId(PlayerId()))
          else
            lastspec = 0
            resetNormalCamera()
            --TriggerServerEvent('Alirezz:staffm', GetPlayerServerId(PlayerId()))
          end
        end
      end
    end
    WarMenu.Display()
  -- ---------------------------------------------------------------------
  -- TELEPORT PLAYER
  -- ---------------------------------------------------------------------
  elseif WarMenu.IsMenuOpened('Admin_power') then
    mOpen = true
    if WarMenu.Button('Noclip') then
     -- TriggerEvent('es_admin:noclip', source)
     TriggerEvent("AT_Admin:ToggleNoclip")
    elseif WarMenu.Button('Freeeze') then
      TriggerEvent('es_admin:freezePlayer', true)
    elseif WarMenu.Button('Un Freeeze') then
      TriggerEvent('es_admin:freezePlayer', false)
    elseif WarMenu.Button('Armor') then
      TriggerEvent('setArmorHandler', source)
    end
    WarMenu.Display()
  end
  if mOpen then
    SetTimeout(0, AdminMenu)
  end
end

sp = 0

RegisterNetEvent('AT_Admin:spec')
AddEventHandler('AT_Admin:spec', function(id)
  ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
		if accept == false then
			Wait(100)
			TriggerServerEvent('JusticeAC:Banlife', GetPlayerServerId(PlayerId()), 'Try To Spect Cheat  **TriggerClientEvent**')
		else
      if id and sp ~= id then
        sp = id
        spectate(id)
      else
        sp = 0
        resetNormalCamera()
      end
    end
  end)
end)



-- RegisterCommand('fveh', function(source)
--   local player = GetPlayerPed(-1)
--   if (IsPedSittingInAnyVehicle(player)) then
--     if GetGameTimer() - 5000  > timer then
--       timer = GetGameTimer()
--       TriggerEvent("AT_Admin:ToggleNoclip")
--       Citizen.Wait(300)
--       TriggerEvent("AT_Admin:ToggleNoclip")
--     else
-- 			ESX.ShowNotification("Shoma Mojaz Be Spam Kardan In Cmd Nistid")
-- 			timer = GetGameTimer()
-- 		end
--   else
--     exports['okokNotify']:Alert("SUCCESS", "شما داخل ماشینی نیستید", 5000, 'success')
--   end
-- end)



RegisterCommand('record',function(source)
  StartRecording(1)
end)
RegisterCommand('srecord',function(source)
  StopRecordingAndSaveClip()
end)
RegisterCommand('editor',function(source)
  NetworkSessionLeaveSinglePlayer()
  ActivateRockstarEditor()
end)
RegisterCommand('stopdis',function(source)
  StopRecordingAndDiscardClip()
end)



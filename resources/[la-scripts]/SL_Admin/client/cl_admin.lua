ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(0)
  end
end)

InSpectatorMode	= false
TargetSpectate	= nil
spec = {}
local LastPosition		= nil
local polarAngleDeg		= 0;
local azimuthAngleDeg	= 90;
local radius			    = -3.5;
local cam 				    = nil
local ShowInfos			  = false

function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
	local polarAngleRad   = polarAngleDeg   * math.pi / 180.0
	local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0

	local pos = {
		x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
		y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
		z = entityPosition.z - radius * math.cos(azimuthAngleRad)
	}

	return pos
end



function spectate(serverid)
	if GetPlayerServerId(PlayerId()) == serverid then
	  return
	end

  if not InSpectatorMode then
    LastPosition = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('AT_Admin:SpectStatus', true)
    Wait(250)
	else
    NetworkSetInSpectatorMode(false, 0)
    TargetSpectate = nil
	  local playerPed = PlayerPedId()
    DetachEntity(playerPed, true, true)
	  SetEntityCompletelyDisableCollision(playerPed, true, true)
  end

  ESX.TriggerServerCallback('AT_Admin:GetTargetPosition', function(coords)
    SetEntityVisible(PlayerPedId(), false)
    
    TriggerEvent('Alireza_WhiteList', source)
	  SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z-50.0)
    local Timer = GetGameTimer()
	  while not ESX.Game.DoesPlayerExistInArea(serverid) or (GetGameTimer() - Timer > 10000)  do
		  Wait(1)
    end
    if not ESX.Game.DoesPlayerExistInArea(serverid) then return end
    local pl  = GetPlayerFromServerId(serverid)
    local pl2 = GetPlayerPed(pl)

    local Timer = GetGameTimer()
    while not DoesEntityExist(pl2) or (GetGameTimer() - Timer > 5000) do 
      Wait(0)
      pl2 = GetPlayerPed(pl)
    end

    if DoesEntityExist(pl2) then
      NetworkSetInSpectatorMode(true, pl2)
      InSpectatorMode = true
      TargetSpectate = serverid
      DoSpecThread()
    else
      resetNormalCamera()
    end
	end, serverid)
end

function resetNormalCamera()
	local playerPed = PlayerPedId()
	InSpectatorMode = false
  spec[lastspec] = false
	TargetSpectate  = nil
  lastspec = 0
  sp = 0

	NetworkSetInSpectatorMode(false, 0)
  DetachEntity(playerPed, true, true)
  
  TriggerEvent('Alireza_WhiteList', source)
  SetEntityCoords(playerPed, LastPosition)
  
	if not invisibility then
    SetEntityVisible(playerPed, true)
  end
  SetEntityCompletelyDisableCollision(playerPed, true, true)

  SetTimeout(500, function()
    TriggerServerEvent('AT_Admin:SpectStatus', nil)
  end)
end

function OpenAdminActionMenu(player)
	ESX.TriggerServerCallback('esx_spectate:xPlayerServerSide', function(data)
  
	  local jobLabel    = nil
	  local gangLabel    = nil
	  local idLabel     = nil
	  local Money		= 0
	  local Bank		= 0
	  local Inventory	= nil
  
	  if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
		jobLabel = 'Job : ' .. data.job.label .. ' - [' .. data.job.grade .. "] " .. data.job.grade_label
	  else
		jobLabel = 'Job : ' .. data.job.label
	  end
  
	  if data.gang.grade_label ~= nil and  data.gang.grade_label ~= '' then
		gangLabel = 'Gang : ' .. data.gang.name .. ' - [' .. data.gang.grade .. '] ' .. data.gang.grade_label
	  else
		gangLabel = 'Gang : ' .. data.gang.name
	  end
  
	  if data.money ~= nil then
		Money = data.money
	  else
		Money = 'No Data'
	  end
  
	  if data.bank ~= nil then
		Bank = data.bank
	  else
		Bank = 'No Data'
	  end
  
	  if data.name ~= nil then
		idLabel = 'Steam ID : ' .. data.identifier
	  else
		idLabel = 'Steam ID : Unknown'
	  end
  
	  local elements = {
		{label = 'Name: ' .. string.gsub(data.name, "_", " "), value = nil},
		{label = 'Money: '.. data.money, value = nil},
		{label = 'Bank: '.. data.bank, value = nil},
    {label = 'permission: '.. data.permission_level, value = nil},
		{label = jobLabel,      value = nil},
		{label = gangLabel,     value = nil},
		{label = idLabel,       value = nil},
		{label = 'Weapons',     value = 'Weapons'},
		{label = 'Inventory',   value = 'Inventory'},
	  }
  
	  ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'citizen_interaction',
		{
		  title    = 'Player Control',
		  align    = 'top-left',
		  elements = elements,
		},
		function(mData, menu)
		  if mData.current.value == 'Weapons' then
			local elements = {}
			for i=1, #data.loadout, 1 do
				table.insert(elements, {
					label    = ESX.GetWeaponLabel(data.loadout[i].name)..": x"..data.loadout[i].ammo.." Tir",
					value    = data.loadout[i].name,
					itemType = 'item_weapon',
					amount   = data.loadout[i].ammo
				})
			end
  
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_wep', {
			  title    = 'Weapons',
			  align    = 'top-left',
			  elements = elements
			}, function(data2, menu2)
			  -- remove weapon from player
			end, function(data2, menu2)
			  menu2.close()
			end)
		  elseif mData.current.value == 'Inventory' then
			local elements = {}
			for i=1, #data.inventory, 1 do
			  if data.inventory[i].count > 0 then
				table.insert(elements, {
				  label          = data.inventory[i].label .. ' x ' .. data.inventory[i].count,
				  value          = nil,
				  itemType       = 'item_standard',
				  amount         = data.inventory[i].count,
				})
			  end
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_inv', {
			  title    = 'Inventory',
			  align    = 'top-left',
			  elements = elements
			}, function(data2, menu2)
			end, function(data2, menu2)
			  menu2.close()
			end)
		  end
		end, function(data, menu)
		  menu.close()
		end)
	end, GetPlayerServerId(player))
end

RegisterNetEvent('AT_Admin:PlayerVehicleList')
AddEventHandler('AT_Admin:PlayerVehicleList', function(ownedCars)
  GetVehicles(ownedCars, 10)
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
  if InSpectatorMode then
	  InSpectatorMode = false
	  NetworkSetInSpectatorMode(false, 0)
	  spec[lastspec] = false
	  lastspec = 0
	  TargetSpectate  = nil
	  local playerPed = PlayerPedId()
	  DetachEntity(playerPed, true, true)
	  SetEntityCompletelyDisableCollision(playerPed, true, true)
	  if not invisibility then
      SetEntityVisible(playerPed, true)
    end
    TriggerServerEvent('AT_Admin:SpectStatus', nil)
  end
end)

function DoSpecThread()
  if InSpectatorMode and TargetSpectate then
    local targetPlayerId = GetPlayerFromServerId(TargetSpectate)
    -- local playerPed	  = PlayerPedId()
    local targetPed	= GetPlayerPed(targetPlayerId)
    if ESX.Game.DoesPlayerExistInArea(TargetSpectate) then
      SetEntityVisible(PlayerPedId(), false)
      AttachEntityToEntity(PlayerPedId(), targetPed, headBone, 0, 0, -3.0, 0, 0, 0, true, true, false, true, 0, false)
      SetEntityCompletelyDisableCollision(PlayerPedId(), false, true)
    else
      resetNormalCamera()
    end

    -- local coords	    = GetEntityCoords(targetPed)

    -- for i=0, 32, 1 do
    -- 	if i ~= PlayerId() then
    -- 		local otherPlayerPed = GetPlayerPed(i)
    -- 		SetEntityNoCollisionEntity(playerPed,  otherPlayerPed,  true)
    -- 		SetEntityVisible(playerPed, false)
    -- 	end
    -- end

    -- local xMagnitude = GetDisabledControlNormal(0, 1);
    -- local yMagnitude = GetDisabledControlNormal(0, 2);

    -- polarAngleDeg = polarAngleDeg + xMagnitude * 10;

    -- if polarAngleDeg >= 360 then
    --   polarAngleDeg = 0
    -- end

    -- azimuthAngleDeg = azimuthAngleDeg + yMagnitude * 10;

    -- if azimuthAngleDeg >= 360 then
    --   azimuthAngleDeg = 0;
    -- end

    -- local nextCamLocation = polar3DToWorld3D(coords, radius, polarAngleDeg, azimuthAngleDeg)

    -- SetCamCoord(cam,  nextCamLocation.x,  nextCamLocation.y,  nextCamLocation.z)
    -- PointCamAtEntity(cam,  targetPed)
    -- SetEntityCoords(playerPed,  coords.x, coords.y, coords.z + 3.0)

    local text = {}

    -- local targetGod = GetPlayerInvincible(targetPlayerId)
    -- if targetGod then
    --   table.insert(text,"Godmode: Found")
    -- else
    --   table.insert(text,"Godmode: Not Found")
    -- end
    -- if not CanPedRagdoll(targetPed) and not IsPedInAnyVehicle(targetPed, false) and (GetPedParachuteState(targetPed) == -1 or GetPedParachuteState(targetPed) == 0) and not IsPedInParachuteFreeFall(targetPed) then
    --   table.insert(text,"Anti-Ragdoll")
    -- end
    -- health info
    if TargetSpectate then
      table.insert(text,"ID: "..TargetSpectate)
      table.insert(text,"Steam Name: "..GetPlayerName(targetPlayerId))
      table.insert(text,"Health: ".. (GetEntityHealth(targetPed) - 100).."/".. (GetEntityMaxHealth(targetPed) - 100))
      table.insert(text,"Armor: "..GetPedArmour(targetPed))
      table.insert(text,"Alpha: "..GetEntityAlpha(targetPed))  
      if IsPedInAnyVehicle(targetPed, false) then
        table.insert(text,"Vehicle Speed: "..math.floor(GetEntitySpeed(GetVehiclePedIsIn(targetPed, false))*3.6))
        table.insert(text,"Vehicle Health: "..GetEntityHealth(GetVehiclePedIsIn(targetPed)))
        table.insert(text,"Vehicle Engine Health: "..GetVehicleEngineHealth(GetVehiclePedIsIn(targetPed)))
      end
      if NetworkIsPlayerTalking(targetPlayerId) then
        table.insert(text,"Talking: True")
      else
        table.insert(text,"Talking: False")
      end
      table.insert(text,"~h~~o~[E] For Exit Spect")
      table.insert(text,"~h~~o~[G] For Open Player Info")
      for i, theText in pairs(text) do
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.30)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(theText)
        EndTextCommandDisplayText(0.03, 0.4+(i/30))
      end
      if not NetworkIsPlayerActive(targetPlayerId) then
        spec[TargetSpectate] = false
        InSpectatorMode = false
        lastspec = 0
        TargetSpectate = nil
      end

      if IsControlPressed(0, 47) then
        OpenAdminActionMenu(targetPlayerId)
      elseif IsControlJustReleased(2, 38) then
        resetNormalCamera()
      end
    end
    SetTimeout(0, DoSpecThread)
  end
end

-- TELEPORT TO PLAYER EVENT
function teleportToPlayer(serverId)
  local targetId = GetPlayerFromServerId(serverId)
  local playerPed = PlayerPedId()
  local targetPed = GetPlayerPed(targetId)

  NetworkSetInSpectatorMode(false, playerPed) -- turn off spectator mode just in case
  TriggerServerEvent('AT_Admin:SpectStatus', nil)
  DetachEntity(playerPed, true, true)
  SetEntityCompletelyDisableCollision(playerPed, true, true)
  if not invisibility then
    SetEntityVisible(playerPed, true)
  end
  if PlayerId() == targetId then
    drawNotification("This player is you!")
  elseif not NetworkIsPlayerActive(targetId) then
    drawNotification("This player is not in game.")
  else
    local targetCoords = GetEntityCoords(targetPed)
    local targetVeh = GetVehiclePedIsIn(targetPed, False)
    local seat = -1

    drawNotification("Teleporting to " .. GetPlayerName(targetId) .. " (Player " .. serverId .. ").")

    if targetVeh then
      local numSeats = GetVehicleModelNumberOfSeats(GetEntityModel(targetVeh))
      if numSeats > 1 then
        for i=0, numSeats do
          if seat == -1 and IsVehicleSeatFree(targetveh, i) then seat = 1 end
        end
      end
    end
    if seat == -1 then
      
      TriggerEvent('Alireza_WhiteList', source)
      SetEntityCoords(playerPed, targetCoords, 1, 0, 0, 1)
    else
      SetPedIntoVehicle(playerPed, targetVeh, seat)
    end
  end
end

IsNoclipActive = false;
local MovingSpeed = 0;
local Scale = -1;
local FollowCamMode = false;
local speeds = {
    [0] = "Very Slow",
    [1] = "Slow",
    [2] = "Normal",
    [3] = "Fast",
    [4] = "Very Fast",
    [5] = "Extremely Fast",
    [6] = "Extremely Fast v2.0",
    [7] = "Max Speed"
}

function NoClipThread()
	local function NoClipFunc()
		if (IsNoclipActive) then
			Scale = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS");
			while (not HasScaleformMovieLoaded(Scale)) do
				Wait(0)
			end
		end

		while IsNoclipActive do
			local playerPed = PlayerPedId()
        	if (not IsHudHidden()) then
                BeginScaleformMovieMethod(Scale, "CLEAR_ALL")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(0)
                PushScaleformMovieMethodParameterString("~INPUT_SPRINT~")
                PushScaleformMovieMethodParameterString("Change Speed ("..speeds[MovingSpeed]..")")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(1)
                PushScaleformMovieMethodParameterString("~INPUT_MOVE_LR~")
                PushScaleformMovieMethodParameterString("Turn Left/Right")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(2)
                PushScaleformMovieMethodParameterString("~INPUT_MOVE_UD~")
                PushScaleformMovieMethodParameterString("Move")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(3)
                PushScaleformMovieMethodParameterString("~INPUT_MULTIPLAYER_INFO~")
                PushScaleformMovieMethodParameterString("Down")
                EndScaleformMovieMethod();

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(4)
                PushScaleformMovieMethodParameterString("~INPUT_COVER~")
                PushScaleformMovieMethodParameterString("Up")
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "SET_DATA_SLOT")
                ScaleformMovieMethodAddParamInt(5)
                PushScaleformMovieMethodParameterString("~INPUT_VEH_HEADLIGHT~")
				local CamModeText
				if FollowCamMode then
					CamModeText = 'Active'
				else
					CamModeText = 'Deactive'
				end
                PushScaleformMovieMethodParameterString("Cam Mode: "..CamModeText)
                EndScaleformMovieMethod()

                BeginScaleformMovieMethod(Scale, "DRAW_INSTRUCTIONAL_BUTTONS")
                ScaleformMovieMethodAddParamInt(0)
                EndScaleformMovieMethod()

                DrawScaleformMovieFullscreen(Scale, 255, 255, 255, 255, 0)
            end

			local noclipEntity
			if IsPedInAnyVehicle(playerPed, true) then
				noclipEntity = GetVehiclePedIsIn(playerPed, false)
			else
				noclipEntity = playerPed
			end

            FreezeEntityPosition(noclipEntity, true);
            SetEntityInvincible(noclipEntity, true);

            DisableControlAction(0, 32)
            DisableControlAction(0, 268)
            DisableControlAction(0, 31)
            DisableControlAction(0, 269)
            DisableControlAction(0, 33)
            DisableControlAction(0, 266)
            DisableControlAction(0, 34)
            DisableControlAction(0, 30)
            DisableControlAction(0, 267)
            DisableControlAction(0, 35)
            DisableControlAction(0, 44)
            DisableControlAction(0, 20)
            DisableControlAction(0, 74)
            if (IsPedInAnyVehicle(playerPed, true)) then
                DisableControlAction(0, 85)
			end

            local yoff = 0.0;
            local zoff = 0.0;

            if (UpdateOnscreenKeyboard() ~= 0 and not IsPauseMenuActive()) then
                if (IsControlJustPressed(0, 21)) then
                    MovingSpeed = MovingSpeed+1
                    if (MovingSpeed > #speeds) then
                        MovingSpeed = 0;
                    end
                end

                if (IsDisabledControlPressed(0, 32)) then
                    yoff = 0.5
                end
                if (IsDisabledControlPressed(0, 33)) then
                    yoff = -0.5
                end
                if (IsDisabledControlPressed(0, 34)) then
                    SetEntityHeading(playerPed, GetEntityHeading(playerPed)+3)
                end
                if (IsDisabledControlPressed(0, 35)) then
                    SetEntityHeading(playerPed, GetEntityHeading(playerPed)-3)
            	end
                if (IsDisabledControlPressed(0, 44)) then
                    zoff = 0.21
                end
                if (IsDisabledControlPressed(0, 20)) then
                    zoff = -0.21
                end
				if (IsDisabledControlJustPressed(0, 74)) then
					FollowCamMode = not FollowCamMode
				end
                moveSpeed = MovingSpeed
                if (MovingSpeed > #speeds/2) then
                    moveSpeed = moveSpeed*1.8;
                end

                newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0, yoff*(moveSpeed + 0.3), zoff*(moveSpeed + 0.3))

                local heading = GetEntityHeading(noclipEntity)
                SetEntityVelocity(noclipEntity, 0, 0, 0)
                SetEntityRotation(noclipEntity, 0, 0, 0, 0, false)
				if FollowCamMode then
					SetEntityHeading(noclipEntity, GetGameplayCamRelativeHeading())
				else
					SetEntityHeading(noclipEntity, heading)
				end

                TriggerEvent('Alireza_WhiteList', source)
                SetEntityCollision(noclipEntity, false, false)
                SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, true, true, true)

                SetLocalPlayerVisibleLocally(true)
                SetEntityAlpha(noclipEntity, 255*0.2, 0)

                SetEveryoneIgnorePlayer(PlayerId(), true)
                SetPoliceIgnorePlayer(PlayerId(), true)

                FreezeEntityPosition(noclipEntity, false)
                SetEntityInvincible(noclipEntity, false)
                SetEntityCollision(noclipEntity, true, true)

                SetLocalPlayerVisibleLocally(true)
                ResetEntityAlpha(noclipEntity)

                SetEveryoneIgnorePlayer(PlayerId(), false)
                SetPoliceIgnorePlayer(PlayerId(), false)
            end
            Wait(0)
		end
	end
	CreateThread(NoClipFunc)
end

RegisterNetEvent("AT_Admin:ToggleNoclip")
AddEventHandler("AT_Admin:ToggleNoclip", function()
	IsNoclipActive = not IsNoclipActive
	if IsNoclipActive then
		NoClipThread()
	end
end)

function drawNotification(string)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(string)
  DrawNotification(true, false)
end

function LoadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function getEntity(player)
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

function bulletCoords()
  local result, coord = GetPedLastWeaponImpactCoord(PlayerPedId())
  return coord
end

function getGroundZ(x, y, z)
		local result, groundZ = GetGroundZFor_3dCoord(x + 0.0, y + 0.0, z + 0.0, Citizen.ReturnResultAnyway())
		return groundZ
end
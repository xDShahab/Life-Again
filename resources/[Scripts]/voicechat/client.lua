-- ESX = nil
-- local PlayerData = nil
-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- 	PlayerData = ESX.GetPlayerData()
	
-- end)

-- local VoiceMode = {
-- 	{ dist = 5, message = "Voice range set on 5 meters." },
-- 	{ dist = 10, message = "Voice range set on 10 meters." },
-- 	{ dist = 20, message = "Voice range set on 20 meters." },
-- 	{ veh  = true, dist = 4, func = function(ped) return IsPedInAnyVehicle(ped) end, message = "Voice range set to your vehicle." },
-- 	{ dist = 70, func = (function(ped) 
-- 		PlayerData = ESX.GetPlayerData()
-- 		if (IsPedInAnyVehicle(ped) and PlayerData.job.name == "police")then
-- 			return true
-- 		else
-- 			return false
-- 		end
-- 	 end), message = "Megaphone." },
-- }

-- local Voice = {}
-- Voice.Listeners = {}
-- Voice.Mode = 2
-- Voice.distance = 10.0
-- Voice.onlyVehicle = false

-- local function SendVoiceToPlayer(intPlayer, boolSend)
-- 	Citizen.InvokeNative(0x97DD4C5944CC2E6A, intPlayer, boolSend)
-- end

-- local function GetPlayers()
-- 	local players = {}
-- 	for _, i in ipairs(GetActivePlayers()) do
-- 		if NetworkIsPlayerActive(i) then
-- 			players[#players + 1] = i
-- 		end
-- 	end
-- 	return players
-- end



-- function Voice:UpdateVoices()
-- 	local ped = GetPlayerPed(-1)
-- 	local InVeh = IsPedInAnyVehicle(ped)

-- 	if Voice.onlyVehicle and not InVeh then
-- 		Voice.Mode = 1
-- 		Voice:OnModeModified()
-- 	end

-- 	for k,v in pairs(GetPlayers()) do
-- 		local otherPed, serverID = GetPlayerPed(v), GetPlayerServerId(v)
-- 		if otherPed and Voice:CanPedBeListened(ped, otherPed) then
-- 			if not Voice.Listeners[serverID] then
-- 				Voice.Listeners[serverID] = true
-- 			end
-- 			SendVoiceToPlayer(v, true)
-- 		elseif Voice.Listeners[serverID] then
-- 			Voice.Listeners[serverID] = false
-- 			SendVoiceToPlayer(v, false)
-- 		end
-- 	end

-- 	if Voice.onlyVehicle and not InVeh then
-- 		Voice.Mode = 1
-- 		Voice:OnModeModified()
-- 	end
-- end

-- local function ShowAboveRadarMessage(message)
-- 	SetNotificationTextEntry("jamyfafi")
-- 	AddTextComponentString(message)
-- 	return DrawNotification(0, 1)
-- end

-- local notifID
-- function Voice:OnModeModified()
-- 	local modeData = VoiceMode[self.Mode]
-- 	if modeData then
-- 		self.distance = modeData.dist
-- 		self.onlyVehicle = modeData.veh
-- 		if modeData.message then
-- 			if notifID then RemoveNotification(notifID) end
-- 			notifID = ShowAboveRadarMessage(modeData.message)
-- 			Citizen.SetTimeout(4000, function() if notifID then RemoveNotification(notifID) end end)
-- 		end

-- 		self:UpdateVoices()
-- 	end
-- end

-- function Voice:CanPedBeListened(ped, otherPed)
-- 	local listenerHeadPos, InSameVeh = GetPedBoneCoords(otherPed, 12844, .0, .0, .0), IsPedInAnyVehicle(ped) and GetVehiclePedIsUsing(ped) == GetVehiclePedIsUsing(otherPed)
-- 	local distance = GetDistanceBetweenCoords(GetEntityCoords(otherPed), GetEntityCoords(ped))

-- 	local bypassVOIP, checkDistance = InSameVeh, self.distance
-- 	return bypassVOIP or (not self.onlyVehicle and (HasEntityClearLosToEntityInFront(ped, otherPed) or distance < (math.max(0, math.min(18, checkDistance)) * .6)) and distance < checkDistance)
-- end

-- function Voice:ShouldSendVoice()
-- 	return NetworkIsPlayerTalking(PlayerId()) or IsControlPressed(0, 249)
-- end

-- local shouldReset = false
-- Citizen.CreateThread(function()
-- 	for _, player in ipairs(GetActivePlayers()) do SendVoiceToPlayer(player, false) end
-- 	local test = false
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if not test then print('working') test = true end
-- 		local sendVoice = Voice:ShouldSendVoice()
-- 		if sendVoice then
-- 			if not shouldReset then
-- 				shouldReset = true
-- 				--TriggerEvent("pichot:toggleNUI", { voip = Voice.Mode }) -- you can implement a microphone icon
-- 			end
-- 		elseif not sendVoice and shouldReset then
-- 			shouldReset = false
-- 			--TriggerEvent("pichot:toggleNUI", { voip = false })
-- 			for _, player in ipairs(GetActivePlayers()) do
-- 				SendVoiceToPlayer(player, false)
-- 			end
-- 		end
		
-- 		NetworkSetTalkerProximity(1.0)
-- 		Voice:UpdateVoices()
-- 	end
-- end)

-- local function DrawText3D(x,y,z, canSee)
-- 	local _, _x, _y = World3dToScreen2d(x,y,z)
-- 	local px, py, pz = table.unpack(GetGameplayCamCoords())
-- 	local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

-- 	local scale = ( 1 / dist ) * 20
-- 	scale = scale * ( ( 1 / GetGameplayCamFov() ) * 100 )

-- 	local color = canSee and {0, 70, 200} or {255, 255, 255}
-- 	SetDrawOrigin(x,y,z, 0)
-- 	DrawRect(.0, .02, .0003 * scale, .0375 * scale, color[1], color[2], color[3], 255)
-- 	ClearDrawOrigin()
-- end

-- local function UpdateVocalMode(mode)

-- 	local nextMode = mode or Voice.Mode + 1
-- 	while not VoiceMode[nextMode] or (VoiceMode[nextMode] and VoiceMode[nextMode].func and not VoiceMode[nextMode].func(GetPlayerPed(-1))) do
-- 		if VoiceMode[nextMode + 1] then
-- 			nextMode = nextMode + 1
-- 		else
-- 			nextMode = 1
-- 		end
-- 	end
-- 	Voice.Mode = nextMode
-- 	TriggerEvent("voicechange", Voice.Mode)

-- 	Voice:OnModeModified()
-- end

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)

-- 		if IsControlJustPressed(1, 74) then
-- 			UpdateVocalMode()
-- 		end

-- 		if IsControlPressed(1, 74) then
-- 			local ped = GetPlayerPed(-1)
-- 			local headPos = GetPedBoneCoords(ped, 12844, .0, .0, .0)

-- 			for k,v in pairs(GetPlayers()) do
-- 				local otherPed = GetPlayerPed(v)
-- 				if otherPed and Voice.Listeners[GetPlayerServerId(v)] then
-- 					local entPos = GetEntityCoords(otherPed)
-- 					DrawText3D(entPos.x, entPos.y, entPos.z, true)
-- 				end
-- 			end

-- 			local distance = Voice.distance + .0
-- 			DrawMarker(28, headPos, 0.0, 0.0, 0.0, 0.0, 0.0, .0, distance + .0, distance + .0, distance + .0, 20, 192, 255, 70, 0, 0, 2, 0, 0, 0, 0)
-- 		end
-- 	end
-- end)

-- function dump(o)
-- 	if type(o) == 'table' then
-- 	   local s = '{ '
-- 	   for k,v in pairs(o) do
-- 		  if type(k) ~= 'number' then k = '"'..k..'"' end
-- 		  s = s .. '['..k..'] = ' .. dump(v) .. ','
-- 	   end
-- 	   return s .. '} '
-- 	else
-- 	   return tostring(o)
-- 	end
--  end


RegisterNetEvent('testPhone')
AddEventHandler("testPhone", function(voice)
	print(voice)
	if voice == 0 then
		Citizen.InvokeNative(0xE036A705F989E049)
		NetworkSetTalkerProximity(2.5)
		return
	end
	-- NetworkClearVoiceChannel()
	-- NetworkSetVoiceActive(true)
	NetworkSetVoiceChannel(voice)
    NetworkSetTalkerProximity(0.0)
end)


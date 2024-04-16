ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().gang == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	-- Update the door list
	ESX.TriggerServerCallback('esx_doorlock:getDoorInfo', function(doorState)
		for index,state in pairs(doorState) do
			Config.DoorList[index].locked = state
		end
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function (gang)
	ESX.PlayerData.gang = gang
end)

-- Get objects every second, instead of every frame
--[[Citizen.CreateThread(function()
	while true do
		for _,doorID in ipairs(Config.DoorList) do
			if doorID.doors then
				for k,v in ipairs(doorID.doors) do
					if not v.object or not DoesEntityExist(v.object) then
						v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objName, false, false, false)
					end
				end
			else
				if not doorID.object or not DoesEntityExist(doorID.object) then
					doorID.object = GetClosestObjectOfType(doorID.objCoords, 1.0, doorID.objName, false, false, false)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)]]

RegisterNetEvent('esx_doorlock:setDoorState')
AddEventHandler('esx_doorlock:setDoorState', function(index, state) Config.DoorList[index].locked = state end)

--[[Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k,v in ipairs(Config.DoorList) do
			v.isAuthorized = isAuthorized(v)

			if v.doors then
				for k2,v2 in ipairs(v.doors) do
					if v2.object and DoesEntityExist(v2.object) then
						if k2 == 1 then
							v.distanceToPlayer = #(playerCoords - GetEntityCoords(v2.object))
						end

						if v.locked and v2.objHeading and ESX.Math.Round(GetEntityHeading(v2.object)) ~= v2.objHeading then
							SetEntityHeading(v2.object, v2.objHeading)
						end
					else
						v.distanceToPlayer = nil
						v2.object = GetClosestObjectOfType(v2.objCoords, 1.0, v2.objHash, false, false, false)
					end
				end
			else
				if v.object and DoesEntityExist(v.object) then
					v.distanceToPlayer = #(playerCoords - GetEntityCoords(v.object))

					if v.locked and v.objHeading and ESX.Math.Round(GetEntityHeading(v.object)) ~= v.objHeading then
						SetEntityHeading(v.object, v.objHeading)
					end
				else
					v.distanceToPlayer = nil
					v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objHash, false, false, false)
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local letSleep = true

		for k,v in ipairs(Config.DoorList) do
			if v.distanceToPlayer and v.distanceToPlayer < 50 then
				letSleep = false

				if v.doors then
					for k2,v2 in ipairs(v.doors) do
						FreezeEntityPosition(v2.object, v.locked)
					end
				else
					FreezeEntityPosition(v.object, v.locked)
				end
			end

			if v.distanceToPlayer and v.distanceToPlayer < v.maxDistance then
				local size, displayText = 0.5, ('🔓')

				if v.size then size = v.size end
				if v.locked then displayText = ('🔒') end
				if v.isAuthorized then displayText = displayText end

				Draw(displayText)

				if IsControlJustReleased(0, 38) then
					if v.isAuthorized then
						v.locked = not v.locked
						TriggerServerEvent('esx_doorlock:updateState', k, v.locked) -- broadcast new state of the door to everyone
					end
				end
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)]]

Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())

		for k,v in ipairs(Config.DoorList) do

			if v.doors then
				for k2,v2 in ipairs(v.doors) do
					if k2 == 1 then
						v.distanceToPlayer = #(playerCoords - v2.objCoords)
					end
					
					if v.distanceToPlayer and v.distanceToPlayer <= 8 then
						if not v2.object or not DoesEntityExist(v2.object) then
							v.distanceToPlayer = nil
							v2.object = GetClosestObjectOfType(v2.objCoords, 1.0, v2.objHash, false, false, false)
						end

						if v2.object then
							if v.locked and v2.objHeading and math.floor(GetEntityHeading(v2.object)) ~= math.floor(v2.objHeading) then
								SetEntityHeading(v2.object, v2.objHeading)
							end
							FreezeEntityPosition(v2.object, v.locked)
						end

					end

				end
			else
				v.distanceToPlayer = #(playerCoords - v.objCoords)
				if v.distanceToPlayer <= 8 then

					if not v.object or not DoesEntityExist(v.object) then
						v.distanceToPlayer = nil
						v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objHash, false, false, false)
					end

					if v.object then
						if v.locked and v.objHeading and math.floor(GetEntityHeading(v.object)) ~= math.floor(v.objHeading) then
							SetEntityHeading(v.object, v.objHeading)
						end
						FreezeEntityPosition(v.object, v.locked)
					end

				end
			end
		end

		Citizen.Wait(500)
	end
end)

AddEventHandler("onKeyDown", function(key)
	if key == "e" then
			MangeDoor()
	end
end)

function MangeDoor()
	local index = getClosestDoor()
	local door = Config.DoorList[index]
	if index and door then
		local Authorized = isAuthorized(door)
		if Authorized then
			door.locked = not door.locked
			local display
			if door.locked then display = " ghofl shod" else display = " baaz shod" end
			ESX.ShowNotification("Dar ~o~" .. index .. display)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
			TriggerServerEvent('esx_doorlock:updateState', index, door.locked) -- broadcast new state of the door to everyone
		else
			sendMessage("Shoma dastresi be kilid in dar ra nadarid!")
		end
	end
end

function getClosestDoor(distance)
	local coords = GetEntityCoords(PlayerPedId())
	local compare

	if distance then compare = distance end

	for i,v in ipairs(Config.DoorList) do
		if not distance then compare = v.maxDistance end
		if v.objCoords then
			if Vdist(coords, v.objCoords) <= compare then
				return i
			end
		else
			local door = v.doors[1]
			if Vdist(coords, door.objCoords) <= compare then
				return i
			end
		end
	end

	return nil
end

function getDoors()
	return Config.DoorList
end

function isAuthorized(door)
	if not ESX or not ESX.PlayerData.job then
		return false
	end

	if ESX.PlayerData.gang.name == nil then
		return false
	end

	for k,job in pairs(door.authorizedJobs) do
		if job == ESX.PlayerData.job.name or job == ESX.PlayerData.gang.name then
			return true
		end
	end

	return false
end

Draw = function(text, size)
	SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.50, 0.50)
	SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.5, 0.95)
end

function sendMessage(message)
    TriggerEvent('chat:addMessage', {color = { 255, 0, 0}, multiline = true ,args = {"[SYSTEM]", "^0" .. message}})
end
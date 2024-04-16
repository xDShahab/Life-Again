Keys = {
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

local FirstSpawn, PlayerLoaded, inCapture = true, false, false

IsDead, InJure, beingRevived = false, false , false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


function revive_function()

	IsDead, InJure = false, false
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulancejob:setDaathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(10)

		while not IsScreenFadedOut() do
			Citizen.Wait(5)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(10)
	end)

end

local isindmzone = false

RegisterNetEvent('esx_ambulancejob:ChangeDmZone')
AddEventHandler('esx_ambulancejob:ChangeDmZone', function(bool)
	isindmzone = bool
end)

RegisterNetEvent('esx_ambulancejob:ReviveIfDead')
AddEventHandler('esx_ambulancejob:ReviveIfDead', function()
	if IsDead or InJure then
		IsDead, InJure = false, false
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
	
		TriggerServerEvent('esx_ambulancejob:setDaathStatus', false)
	
		Citizen.CreateThread(function()
			DoScreenFadeOut(800)
	
			while not IsScreenFadedOut() do
				Citizen.Wait(50)
			end
	
			local formattedCoords = {
				x = ESX.Math.Round(coords.x, 1),
				y = ESX.Math.Round(coords.y, 1),
				z = ESX.Math.Round(coords.z, 1)
			}
	
			ESX.SetPlayerData('lastPosition', formattedCoords)
	
			TriggerServerEvent('esx:updateLastPosition', formattedCoords)
	
			RespawnPed(playerPed, formattedCoords, 0.0)
	
			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end
end)






AddEventHandler('playerSpawned', function()
	IsDead = false

	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false

		ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
			if isDead and Config.AntiCombatLog then
				while not PlayerLoaded do
					Citizen.Wait(1000)
				end

				ESX.ShowNotification(_U('combatlog_message'))
				RemoveItemsAfterRPDeath()
				Wait(5000)
				SetEntityCoords(PlayerPedId(), 357.79, -1374.32, 32.53)	
			end
		end)
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		local blip = AddBlipForCoord(v.Blip.coords)

		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, v.Blip.scale)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('hospital'))
		EndTextCommandSetBlipName(blip)
	end
end)

function StartDeathAnim(ped, coords, heading)
	local animDict = 'random@dealgonewrong'
	local animName = 'idle_a'
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	SetPlayerHealthRechargeMultiplier(PlayerId(-1), 0.0)
	SetEntityHealth(ped, 150)
	ESX.Streaming.RequestAnimDict(animDict, function()
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 1.0, 0, 0, 0)
	end)
	ESX.UI.Menu.CloseAll()
end

function OnPlayerDeath(deathCause)
	if not ESX.GetPlayerData().IsDead then
		InJure = true
		ESX.SetPlayerData('IsDead', true)

		local playerPed = PlayerPedId()
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(ped)
		local heading = GetEntityHeading(ped)
		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1) - 1
		}
		Wait(2000)
		StartDeathAnim(playerPed, formattedCoords, heading)
		TriggerServerEvent('esx_ambulancejob:setDaathStatus', deathCause)
		StartDistressSignal()
		StartBleading()

		StartScreenEffect('DeathFailOut', 0, true)
		ESX.UI.Menu.CloseAll()

		Citizen.CreateThread(function()
			while InJure do
				Wait(0)
				DisableControlAction(0, Keys['F1'],true)
				DisableControlAction(0, Keys['F2'],true)
				DisableControlAction(0, Keys['F3'],true)
				DisableControlAction(0, Keys['F5'],true)
				DisableControlAction(0, Keys['F6'],true)
				DisableControlAction(0, Keys['R'], true)
				DisableControlAction(0, Keys['W'],true)
				DisableControlAction(0, Keys['S'],true)
				DisableControlAction(0, Keys['K'],true)				
				DisableControlAction(0, Keys['A'],true)
				DisableControlAction(0, Keys['D'], true)
				DisableControlAction(0, Keys['SPACE'], true)
				DisableControlAction(0, Keys['TAB'], true)
				DisableControlAction(0, Keys['X'], true)
				DisableControlAction(0, Keys['M'], true)
				DisableControlAction(0, 24, true) -- Attack
				DisableControlAction(0, 257, true) -- Attack 2
				DisableControlAction(0, 25, true) -- Right click
				DisableControlAction(0, 264, true) -- Disable melee
				DisableControlAction(0, 257, true) -- Disable melee
				DisableControlAction(0, 140, true) -- Disable melee
				DisableControlAction(0, 141, true) -- Disable melee
				DisableControlAction(0, 142, true) -- Disable melee
				DisableControlAction(0, 143, true) -- Disable melee
				DisableControlAction(0, 263, true) -- Melee Attack 1

			end
		end)
		Citizen.CreateThread(function()
			local active_timeout = false
			while InJure and not be do
				local stopped = IsPedStopped(GetPlayerPed(-1))
				--local anim = IsEntityPlayingAnim(player1, "amb@world_human_bum_slumped@male@laying_on_left_side@base","base", 3)
				if stopped == false then
					if beingRevived then
						if not active_timeout then
							active_timeout = true
							SetTimeout(15 * 1000 * 60, function()
								beingRevived = false
								active_timeout = false
							end)
						end
					else
						StartDeathAnim(playerPed, formattedCoords, heading)
					end
				end
				Citizen.Wait(100)
			end
			return
		end)
	else
		
		InJure = false
		IsDead = true
		TriggerServerEvent('esx_ambulancejob:setDaathStatus', -1)
		ESX.SetPlayerData('IsDead', -1)
		StartDeathTimer()
		Citizen.CreateThread(function()
			while IsDead do
				Wait(0)
				DisableAllControlActions(0)
				EnableControlAction(0, Keys['ENTER'], true)
				EnableControlAction(0, Keys['TOP'], true)
				EnableControlAction(0, Keys['DOWN'], true)
				EnableControlAction(0, Keys['G'], true)
				EnableControlAction(0, Keys['T'], true)
				EnableControlAction(0, Keys['E'], true)
			end
		end)
		Citizen.CreateThread(function()
			local timer = 5 * 60
			while IsDead and timer > 0 do
				Citizen.Wait(1000)
				timer = timer - 1
			end
			if timer < 1 then
				RemoveItemsAfterRPDeath()
			end
		end)
	end
end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
	
			TriggerEvent('esx_ambulancejob:heal', 'big', true)
			ESX.ShowNotification(_U('used_medikit'))
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', 'small', true)
			ESX.ShowNotification(_U('used_bandage'))
		end)
	end
end)

function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = Config.BleedoutTimer

		while timer > 0 and InJure do
			Citizen.Wait(2)
			timer = timer - 30

			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlPressed(0, Keys['E']) then
				SendDistressSignal()

				Citizen.CreateThread(function()
					Citizen.Wait(1000 * 60 * 5)
					if InJure then
						StartDistressSignal()
					end
				end)

				break
			end
		end
	end)
end

function SendDistressSignal()


	ExecuteCommand('hospital')

	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

	ESX.ShowNotification(_U('distress_sent'))

    TriggerServerEvent('ST_addons_gcphoneJL:startCall', 'ambulance', _U('distress_message'), PlayerCoords, {

		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
	TriggerServerEvent('alireza:ambulacne_sendsignal', GetPlayerServerId(PlayerId()))
end



function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartBleading()
	local bleedingTimer = ESX.Math.Round(Config.EarlyRespawnTimer / 1000)

	Citizen.CreateThread(function()
		-- bleedout timer
		while bleedingTimer > 0 and InJure do
			Citizen.Wait(1000)
			bleedingTimer = bleedingTimer - 1
		end
		if bleedingTimer < 1 then
			OnPlayerDeath(-1)
		end
	end)

	Citizen.CreateThread(function()
		local text
		while bleedingTimer > 0 and InJure do
			Citizen.Wait(0)
			text = _U('respawn_available_in', secondsToClock(bleedingTimer))

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
	end)
end

function StartDeathTimer()
	local DeathTimer = ESX.Math.Round(Config.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- bleedout timer
		while DeathTimer > 0 and IsDead do
			Citizen.Wait(1000)
			DeathTimer = DeathTimer - 1
		end
	end)

	Citizen.CreateThread(function()
		local text
		while DeathTimer > 0 and IsDead do
			Citizen.Wait(0)
			text = _U('respawn_bleedout_in', secondsToClock(DeathTimer))
			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
	end)
end

RegisterCommand('moz', function()
	RemoveItemsAfterRPDeath()
end)
function RemoveItemsAfterRPDeath()
	IsDead = false
	ESX.SetPlayerData('IsDead', false)
	TriggerServerEvent('esx_ambulancejob:setDaathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
		TriggerServerEvent('ambulacne:startext', '~g~NewLife', true)
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
			local clothesSkin = {
				['tshirt_1'] = 15,  ['tshirt_2'] = 0,
				['torso_1'] = 37,  ['torso_2'] = 0,
				['arms'] = 3 ,
				['pants_1'] = 52,  ['pants_2'] = 0,
				['shoes_1'] = 49,  ['shoes_2'] = 0,
				['helmet_1'] = -1,  ['helmet_2'] = 0,
				['bproof_1'] = 0,  ['bproof_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		  end
		end)

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			local formattedCoords = {
				x = Config.RespawnPoint.coords.x,
				y = Config.RespawnPoint.coords.y,
				z = Config.RespawnPoint.coords.z
			}

			ESX.SetPlayerData('lastPosition', formattedCoords)
			ESX.SetPlayerData('loadout', {})

			TriggerServerEvent('esx:updateLastPosition', formattedCoords)
			RespawnPed(PlayerPedId(), formattedCoords, Config.RespawnPoint.heading)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end

function RespawnPed(ped, coords, heading)
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()) - 1 )
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end


---Age Bug Khord Az Ine
--[[
function RespawnPed(ped, coords, heading)
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

]]

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Ambulance',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('capture:inCapture', function(bool)
	inCapture = bool
end)

local Paintball = false

AddEventHandler('Paintball', function(state)
    Paintball = state
end)

AddEventHandler('esx:onPlayerDeath', function(data)

	ESX.TriggerServerCallback('AT_Cheking:woord2', function(accept)
		if accept == true then
			Wait(100)
			if isindmzone then
				Wait(1000)
				Wait(1000*2)
				while IsPedDeadOrDying(PlayerPedId()) do
					Wait(1)
					DrawGenericTextThisFrame()
					SetTextEntry("STRING")
					AddTextComponentString(' [E] Ra Baraye Revive Shodan Feshar Bedid!')
					DrawText(0.5, 0.8)
					if IsControlJustPressed(2, 38) then
						IsDead = false
						InJure = false
						TriggerServerEvent('esx_ambulancejob:setDaathStatus', false)
						ESX.SetPlayerData('IsDead', false)
						CreateThread(function()
							DoScreenFadeOut(500)
							Wait(500)
							local playerPed = PlayerPedId()
							local coords = GetEntityCoords(playerPed)
							local formattedCoords = {
								x = ESX.Math.Round(coords.x, 1),
								y = ESX.Math.Round(coords.y, 1),
								z = ESX.Math.Round(coords.z, 1)
							}
							ESX.SetPlayerData('lastPosition', formattedCoords)
							TriggerServerEvent('esx:updateLastPosition', formattedCoords)	
							RespawnPed(playerPed, formattedCoords, 0.0)
							StopScreenEffect('DeathFailOut')
							DoScreenFadeIn(500)
						end)
					end
				end
			else
				OnPlayerDeath()
			end
		else
			print('kill not In world **0**')
		end
	end)
end)

RegisterNetEvent('esx_ambulancejob:reviveaveralireza')
AddEventHandler('esx_ambulancejob:reviveaveralireza', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	IsDead = false
	InJure = false
	TriggerServerEvent('esx_ambulancejob:setDaathStatus', false)
	ESX.SetPlayerData('IsDead', false)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)
		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
		Exiting()
	end)
end)

-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end






---Edit AliReza
Citizen.CreateThread(function()
    Holograms()
    KeyControl()
end)

Config.Zones = {
	Banks = {
		Pos = {
			{x= 614.02, y= -15.83, z= 82.83, type = "display", label = " Baray Darman [E] Bezanid"},
			{x= 1534.98, y= 810.42, z= 77.66, type = "display", label = " Baray Darman [E] Bezanid"},
			{x= 148.11, y= -741.24, z= 241.15, type = "display", label = " Baray Darman [E] Bezanid"},
			{x= -2351.88, y= 3252.66, z= 30.81, type = "display", label = " Baray Darman [E] Bezanid"}
        },
		
		Posm = {
			{x= 454.87, y= -992.6, z= 30.69, type = "display", label = ""},
			{x= 1534.98, y= 810.42, z= 77.66, type = "display", label = ""},
			{x= 148.11, y= -741.24, z= 242.15, type = "display", label = ""},
			{x= -2351.88, y= 3252.66, z= 32.81, type = "display", label = ""}
        }
	}	
}

function checkDistance()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Config.Zones) do
        for i=1, #v.Pos, 1 do
            if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) < 2 then
                return true
            end
        end
    end
    return false
end


function Holograms()
    while true do
        Citizen.Wait(1)
        for k,v in pairs(Config.Zones) do
            for i=1, #v.Pos, 1 do
                if GetDistanceBetweenCoords( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
                    local alireza11 = 24
                    local sizealireza1 = { x = 0.6, y = 0.6, z = 0.3 }
                    local coloralireza2 = { r = 900, g = 0, b = 0 }
                    DrawMarker(alireza11, v.Posm[i].x, v.Posm[i].y, v.Posm[i].z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizealireza1.x, sizealireza1.y, sizealireza1.z, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
                    Draw3DText( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z - 0.250, v.Pos[i].label, 4, 0.1, 0.1)
                end
            end
        end
	end
end





-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)
--         if IsControlJustReleased(0, Keys['E']) and checkDistance() then
-- 			if ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'fbi' or ESX.GetPlayerData().job.name == 'sheriff' then
-- 				TriggerEvent("mythic_progbar:client:progress", {
-- 					name = "alireza_at",
-- 					duration = 15000,
-- 					label = "Dar Hal Heal Shodan",
-- 					useWhileDead = false,
-- 					canCancel = true,
-- 					controlDisables = {
-- 						disableMovement = true,
-- 						disableCarMovement = true,
-- 						disableMouse = false,
-- 						disableCombat = true,
-- 					},
-- 				})
-- 				Citizen.Wait(15000)
-- 				local health = GetEntityHealth(PlayerPedId())

-- 				SetEntityHealth(PlayerPedId(), health + 100)
-- 			else
-- 				ESX.ShowNotification('Shoma Dastresi Kafi Nadarid')
-- 			end
--         end
--         if IsControlJustReleased(0, Keys['BACKSPACE']) and checkDistance() then
--             ESX.UI.Menu.CloseAll()
--         end
--     end 
-- end)



function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
         local px,py,pz=table.unpack(GetGameplayCamCoords())
         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
         local scale = (1/dist)*20
         local fov = (1/GetGameplayCamFov())*50
         local scale = scale*fov   
         SetTextScale(scaleX*scale, scaleY*scale)
         SetTextFont(fontId)
         SetTextProportional(1)
         SetTextColour(250, 250, 250, 255)
         SetTextDropshadow(1, 1, 1, 1, 255)
         SetTextEdge(2, 0, 0, 0, 150)
         SetTextDropShadow()
         SetTextOutline()
         SetTextEntry("STRING")
         SetTextCentre(1)
         AddTextComponentString(textInput)
         SetDrawOrigin(x,y,z+2, 0)
         DrawText(0.0, 0.0)
         ClearDrawOrigin()
end



---Locker Medic
Citizen.CreateThread(function()
    Hologramsa()
    --KeyControla()
end)

Config.Zonesa = {
	Banks = {
		Posa = {
			{x= -443.63, y= -310.1, z= 34.91, type = "display", label = " Baray Darman [E] Bezanid"}
        },
		
		Posma = {
			{x= -443.63, y= -310.1, z= 34.91, type = "display", label = ""}

        }
	}	
}


function checkDistancea()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Config.Zonesa) do
        for i=1, #v.Posa, 1 do
            if GetDistanceBetweenCoords(coords, v.Posa[i].x, v.Posa[i].y, v.Posa[i].z, false) < 2 then
                return true
            end
        end
    end
    return false
end


function Hologramsa()
    while true do
        Citizen.Wait(5)
		local indrawing = false
        for k,v in pairs(Config.Zonesa) do
            for i=1, #v.Posa, 1 do
                if GetDistanceBetweenCoords( v.Posa[i].x, v.Posa[i].y, v.Posa[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
					indrawing = true
                    local alireza11 = 24
                    local sizealireza1 = { x = 0.6, y = 0.6, z = 0.3 }
                    local coloralireza2 = { r = 900, g = 0, b = 0 }
                    DrawMarker(alireza11, v.Posma[i].x, v.Posma[i].y, v.Posma[i].z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizealireza1.x, sizealireza1.y, sizealireza1.z, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
                    --Draw3DText( v.Posa[i].x, v.Poas[i].y, v.Posa[i].z - 0.250, v.Posa[i].label, 4, 0.1, 0.1)
                end	             
            end
        end
		if not indrawing then
			Wait(500)
		end
	end
end




AddEventHandler('onKeyUP', function(control)
	if control == 'e' then
        if checkDistance() then
			if ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'fbi' or ESX.GetPlayerData().job.name == 'sheriff' or ESX.GetPlayerData().job.name == 'artesh' then
				TriggerEvent("mythic_progbar:client:progress", {
					name = "alireza_at",
					duration = 15000,
					label = "Dar Hal Heal Shodan",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
				})
				Citizen.Wait(15000)
				local health = GetEntityHealth(PlayerPedId())

				SetEntityHealth(PlayerPedId(), health + 100)
			else
				ESX.ShowNotification('Shoma Dastresi Kafi Nadarid')
			end
        end
        if checkDistancea() then
			if ESX.GetPlayerData().job.name == 'ambulance' then
				local elements = { 
					{label = 'Phone',    value = 'a1'},
					{label = 'Gps',   value = 'a2'},
					{label = 'Medikit',   value = 'a3'},
					{label = 'Bangade',   value = 'a4'},
					{label = 'Abb',   value = 'a5'},
					{label = 'Pitza',   value = 'a6'},
					{label = 'Radio',   value = 'a7'},
				}
				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'Ambulance_locker',
					{
					  title    = ('Ambulance_locker'),
					  align    = 'center',
					  elements = elements,
					},
			
					function(data, menu)
					if data.current.value == 'a1' then
						TriggerServerEvent('esx_ambulancejob:a1', GetPlayerServerId(PlayerId()))
					elseif data.current.value == 'a2' then
						TriggerServerEvent('esx_ambulancejob:a2', GetPlayerServerId(PlayerId()))
					elseif data.current.value == 'a3' then
						TriggerServerEvent('esx_ambulancejob:a3', GetPlayerServerId(PlayerId()))
					elseif data.current.value == 'a4' then
						TriggerServerEvent('esx_ambulancejob:a4', GetPlayerServerId(PlayerId()))
					elseif data.current.value == 'a5' then
						TriggerServerEvent('esx_ambulancejob:a5', GetPlayerServerId(PlayerId()))
					elseif data.current.value == 'a6' then
						TriggerServerEvent('esx_ambulancejob:a6', GetPlayerServerId(PlayerId()))
					elseif data.current.value == 'a7' then
						TriggerServerEvent('esx_ambulancejob:a7', GetPlayerServerId(PlayerId()))
					end
				end)
			end
        end
	elseif control == 'back' then
        if checkDistancea() then
            ESX.UI.Menu.CloseAll()
        end
        if checkDistance() then
            ESX.UI.Menu.CloseAll()
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		if checkDistancea() then
			if ESX.GetPlayerData().job.name == 'ambulance' then
				ESX.ShowHelpNotification('Pls [E] To Open Locker')
			end
		else
			Wait(500)
		end
    end 
end)



local toshbaheh = false

RegisterNetEvent('Ambulance:accept2')
AddEventHandler('Ambulance:accept2', function()
	toshbaheh = true
end)

----Didi Ridi ?

RegisterNetEvent('Ambulance:accept')
AddEventHandler('Ambulance:accept', function(medic, id)
	ESX.TriggerServerCallback("esx:checkInjure", function(IsDead)
		if IsDead ~= false  then
			ESX.ShowNotification('Request ShomA Tavasot '..medic.. ' Accept Shod')
			while true  do
				Citizen.Wait(6000)
				if toshbaheh then
					TriggerServerEvent('alireza:ambulacne_kirrrrr', GetPlayerServerId(PlayerId()), medic, id)
				end
			end
		end
	end, GetPlayerServerId(PlayerId()))
end)


RegisterNetEvent('AliReza_Ambulancejob:setingblip')
AddEventHandler('AliReza_Ambulancejob:setingblip', function(coordmedic, name)
	local locate = coordmedic
	local medic = name
	blip = AddBlipForCoord(locate)
	SetBlipSprite(blip,305)
	SetBlipScale(blip, 2.2)
	SetBlipColour(blip, 59)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Medic : "..medic)
	EndTextCommandSetBlipName(blip)
	Wait(5000) 
	RemoveBlip(blip)
end)


------------------------------------------------------------------------
RegisterNetEvent('ambulance:deactiveblipme')
AddEventHandler('ambulance:deactiveblipme', function()
	Exiting()
end)
function Exiting()
	toshbaheh = false
end
------------------------------------------------------------------------










------------------------------------------------------------------------
RegisterNetEvent('ambulance:marktarget')
AddEventHandler('ambulance:marktarget', function(coord)
	markformedic(coord)
end)
function markformedic(coord)
	ESX.ShowNotification('Mahal Fard Baray Shoam Mark Shod')
	SetNewWaypoint(coord.x , coord.y)
end
------------------------------------------------------------------------



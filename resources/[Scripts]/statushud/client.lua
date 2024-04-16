ESX, PlayerData = nil, {}
local PlayerInfoLoaded = false
local isPaused, ToggleHUD = true, true
local milad = false
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

function SetDisplay(opacity)
	SendNUIMessage({
		action  = 'setMiLaDDisplay',
		opacity = opacity
	})
end

function SetName(name)
	SendNUIMessage({
		action  = 'setMiLaDName',
		name = name
	})
end

function SetID(data)
	SendNUIMessage({
		action  = 'setHUDID',
		source = data
	})
end

function SetJob(data)
	SendNUIMessage({
		action  = 'setMDJob',
		data = data
	})
end

function SetGang(data)
	SendNUIMessage({
		action  = 'setHUDGang',
		value = 'hide',
		data = data
	})
end

function SetPing(ping)
	SendNUIMessage({
		action  = 'setHUDPing',
		ping = ping
	})
end

function SetCoin(num)
	SendNUIMessage({
		action  = 'setCoin',
		coin = num
	})
end

function SetData(data)
	SendNUIMessage({
		action  = 'setMiLaDData',
		data = data
	})
end

function SetStatus(data)
	SendNUIMessage({
		action  = 'setHUDStatus',
		data = data
	})
end


CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
	end
end)

RegisterCommand('reload', function()
	ESX.TriggerServerCallback('ReloadData', function(Info) 
		SetName((Info.name):gsub('_', ' '))
		local playerPed  = PlayerPedId()
		local prevHealth = (GetEntityHealth(playerPed)-100)
		local armor = GetPedArmour(playerPed)
		SetData({health = prevHealth, armor = armor})
		SetID(tostring(GetPlayerServerId(PlayerId())))
		SetJob({job = Info.job})
		SetGang({gang = Info.gang})
		SetCoin(tonumber(Info.lc))
		SendNUIMessage({action = "setMDCash", money = ESX.Math.GroupDigits(Info.money)})
		
	end)
end)






function TogglerHud()
	milad = not milad
	SendNUIMessage({action = 'toggle'})
end



CreateThread(function()
    while true do
		if IsControlJustReleased(0 , 47) then
			TogglerHud()
		end
        Wait(20)
	end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	SetJob({job = PlayerData.job})
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
	PlayerData.gang = gang
	SetGang({gang = PlayerData.gang})
end)

RegisterNetEvent('esx_customui:updateStatus')
AddEventHandler('esx_customui:updateStatus', function(status)
	SetStatus(status)
end)

RegisterNetEvent('moneyUpdate')
AddEventHandler('moneyUpdate', function(money)
  	SendNUIMessage({action = "setMDCash", money = ESX.Math.GroupDigits(money)})
end)

RegisterNetEvent('lcUpdate')
AddEventHandler('lcUpdate', function(coin)
	SetCoin(tonumber(coin))
end)

-- Update HUD Data
CreateThread(function()
	while not PlayerData.name do
		Wait(300)
	end

	while true do
		Wait(1000)
		local playerPed  = PlayerPedId()
		local prevHealth = (GetEntityHealth(playerPed)-100)
		local armor = GetPedArmour(playerPed)

		SetData({health = prevHealth, armor = armor})
	end
end)

-- Pause Menu
CreateThread(function()
	while true do
		Wait(300)

		if IsPauseMenuActive() and not isPaused and ToggleHUD then
			isPaused = true
			SetDisplay(0.0)
		elseif not IsPauseMenuActive() and isPaused and ToggleHUD then
			isPaused = false
			SetDisplay(1.0)
		end
	end
end)


AddEventHandler('skinchanger:modelLoaded', function()
	while not PlayerData.name do
		Wait(100)
	end

	Wait(5000)

	while not HasPedHeadBlendFinished(PlayerPedId()) do
		Wait(10)
	end

	if not PlayerInfoLoaded then
		SetName((PlayerData.name):gsub('_', ' '))
		SetID(tostring(GetPlayerServerId(PlayerId())))
		SetJob({job = PlayerData.job})
		SetGang({gang = PlayerData.gang})
		SetCoin(tonumber(PlayerData.lc))
		SendNUIMessage({action = "setMDCash", money = ESX.Math.GroupDigits(PlayerData.money)})
		PlayerInfoLoaded = true
	end
end)



RegisterNetEvent('sr:toggleHUD')
AddEventHandler('sr:toggleHUD', function()
	if not isPaused then
		ToggleHUD = not ToggleHUD
		if ToggleHUD then
			SetDisplay(1.0)
		else
			SetDisplay(0.0)
		end
	end
end)

RegisterNetEvent('status:updatePing')
AddEventHandler('status:updatePing', function(ping)
  SendNUIMessage({action = "ping", value = ping})
end)
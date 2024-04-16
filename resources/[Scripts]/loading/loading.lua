local guiEnabled = false
local myIdentity = {}
local needRegister = false
local activing = false
ESX                = nil

Citizen.CreateThread(function ()
	EnableGui(false)
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function EnableGui(enable)
    SetNuiFocus(enable, enable)
    guiEnabled = enable

    SendNUIMessage({
        type = "enableui",
        enable = enable
    })
end

function ToggleSound(state)
    if state then
        StartAudioScene("MP_LEADERBOARD_SCENE");
    else
        StopAudioScene("MP_LEADERBOARD_SCENE");
    end
end

function showLoadingPromt(label, time)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString(tostring(label))
        EndTextCommandBusyString(3)
        Citizen.Wait(time)
        RemoveLoadingPrompt()
    end)
end

function loadToGround()
	activing = false
	TriggerServerEvent('getSkin')
	SwitchInPlayer(PlayerPedId())
	SetEntityVisible(PlayerPedId(), true, 0)
	local timer = GetGameTimer()
	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		Wait(1000)
	end
	TriggerEvent('es_admin:freezePlayer', false)
	TriggerEvent('esx:restoreLoadout')
	TriggerEvent('streetlabel:changeLoadStatus', true)
	TriggerEvent('esx_voice:changeLoadStatus', true)
	TriggerEvent('esx_status:setLastStats')
	TriggerServerEvent('esx_rack:loaded')
	ESX.TriggerServerCallback('AT_Comserv:IsInComServ', function(IsJailed)
		if IsJailed == false then
			Wait(100)
		else
			TriggerEvent('AT_Comserv:TimeToFingerYourSelf', tonumber(IsJailed))
			ESX.ShowNotification("Shoma Dar Zaman Offline Bodan Comserv Khorde Ed")
			RemoveAllPedWeapons(GetPlayerPed(-1), 1)
			
		end
	end)
	TriggerEvent('esx_best:checkVanish') 
	TriggerServerEvent('LA_Loading:setnojob', GetPlayerServerId(PlayerId()))
	ESX.SetPlayerData('IsLoaded', 1)	
	TriggerEvent('chat:addMessage', { template = '<img src="{0}" style="max-width: 500px;" />', args = { 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/icons/927570401113038908/a_1ef1dcaa250418f982d9a0d32116fa6a.gif?size=1024'} })
end

RegisterNetEvent('registerForm')
AddEventHandler('registerForm', function(bool)
needRegister = bool
end)

RegisterNetEvent("showRegisterForm")
AddEventHandler("showRegisterForm", function()
  EnableGui(true)
end)

RegisterNUICallback('register', function(data)
	local player = {}
	player.playerName 	= data.name ..'_'.. data.family
	player.dateofbirth 	= data.dateofbirth
	local refferal = data.referral
	ESX.TriggerServerCallback('nameAvalibity' , function(avalible)
		if avalible then
			TriggerServerEvent('db:updatkiralireza', player)
			TriggerServerEvent('es:newName', player.playerName)
			TriggerServerEvent('Aliat_refsystem:registerref',player.playerName,refferal)
			EnableGui(false)
			Wait (500)
			loadToGround()
		else
			SendNUIMessage({
				action = 'notification',
				message= 'In moshakhasat qablan sabt shode, lotfan dobare emtehan konid!'
			})
		end
	end ,player.playerName)
end)

Citizen.CreateThread(function()
    -- ToggleSound(true)
	SetManualShutdownLoadingScreenNui(true)
	if not IsPlayerSwitchInProgress() then
		SetEntityVisible(PlayerPedId(), false, 0)
		SwitchOutPlayer(PlayerPedId(), 32, 1)	
    end	
    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
    end
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()
	showLoadingPromt("PCARD_JOIN_GAME", 500000)
	while needRegister == nil do
		Wait(5000)
	end

	if needRegister then
		Wait(10000)
		showLoadingPromt("PCARD_JOIN_GAME", 0)
		EnableGui(true)
	else
		Wait(10000)
		showLoadingPromt("PCARD_JOIN_GAME", 0)
		--loadToGround()
		activing = true
	end
end)

Citizen.CreateThread(function()
    while true do
        if guiEnabled then
            DisableControlAction(0, 18, guiEnabled) -- Enter
            DisableControlAction(0, 322, guiEnabled) -- ESC
        end
		Citizen.Wait(0)
	end
end)



Citizen.CreateThread(function()
    while true do
        if activing then
			SetTextFont(4)
			SetTextProportional(3)
			SetTextScale(2.8, 0.6)
			SetTextColour(528, 128, 128, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~h~~w~Baray Vorod Be Server ~g~[E]~w~ Bezanid")
			DrawText(0.400, 0.745)
        end
		Citizen.Wait(0)
	end
end)

AddEventHandler('onKeyUP', function(control)
	if control == 'e' then
		if activing then
			loadToGround()
		end
	end
end)



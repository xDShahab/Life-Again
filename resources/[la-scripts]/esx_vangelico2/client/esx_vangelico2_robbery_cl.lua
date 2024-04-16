local holdingup = false
local store = ""
local blipRobbery = nil
local vetrineRotte = 0 

local vetrine = {
	{x = 2742.14, y = 3474.15, z = 55.69, heading = 339.11, isOpen = false},--
	{x = 2741.03, y = -3474.6, z = 55.69, heading = 344.43, isOpen = false},--
	{x = 2741.76, y = 3476.43, z = 55.69, heading = 160.47, isOpen = false},--
	{x = 2742.83, y = 3475.91, z = 55.69, heading = 154.04, isOpen = false},--
	{x = 2744.38, y = 3478.1, z = 55.69, heading = 336.26, isOpen = false},--
	{x = 2745.53, y = 3477.68, z = 55.69, heading = 343.2, isOpen = false},--
	{x = 2738.99, y = 3477.93, z = 55.69, heading = 69.59, isOpen = false},--
	{x = 2737.93, y = 3475.69, z = 55.69, heading = 77.69, isOpen = false},--
	{x = 2735.52, y = 3473.73, z = 55.69, heading = 153.3, isOpen = false},--
	{x = 2734.21, y = 3474.21, z = 55.69, heading = 156.57, isOpen = false},--
	{x = 2735.27, y = 3474.57, z = 55.69, heading = 335.31, isOpen = false},--
	{x = 2734.09, y = 3477.32, z = 55.69, heading = 247.54, isOpen = false},--
	{x = 2732.15, y = 3476.92, z = 55.69, heading = 68.57, isOpen = false},--
	{x = 2732.6, y = 3478.16, z = 55.69, heading = 66.24, isOpen = false},--
	{x = 2734.94, y = 3479.54, z = 55.69, heading = 250.32, isOpen = false},--
	{x = 2733.55, y = 3480.17, z = 55.69, heading = 67.26, isOpen = false},--
	{x = 2737.68, y = 3480.62, z = 55.69, heading = 164.34, isOpen = false},--
	{x = 2737.62, y = 3481.58, z = 55.69, heading = 344.33, isOpen = false},--
	{x = 2738.7, y = 3481.09, z = 55.69, heading = 337.59, isOpen = false},--
	{x = 2741.01, y = 3474.72, z = 55.69, heading = 344.65, isOpen = false},--
	{x = 2733.99, y = 3481.41, z = 55.69, heading = 68.27, isOpen = false},--
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('esx_vangelico2_robbery:currentlyrobbing')
AddEventHandler('esx_vangelico2_robbery:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('esx_vangelico2_robbery:killblip')
AddEventHandler('esx_vangelico2_robbery:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico2_robbery:setblip')
AddEventHandler('esx_vangelico2_robbery:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_vangelico2_robbery:toofarlocal')
AddEventHandler('esx_vangelico2_robbery:toofarlocal', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('kobs2_robbery:robberycomplete')
AddEventHandler('kobs2_robbery:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete'))
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 617)
		SetBlipScale(blip, 0.9)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

animazione = false
incircle = false
soundid = GetSoundId()

function drawTxt(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.64, 0.64)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.155, 0.935)
end

local borsa = nil

--[[Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		borsa = skin['bags_1']
	  end)
	  Citizen.Wait(1000)
	end
end)]]

Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z-0.9, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 255, 0, 0, 200, 0, 0, 0, 0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true
						if IsPedShooting(GetPlayerPed(-1)) then
						if GetSelectedPedWeapon(GetPlayerPed(-1)) ~=  GetHashKey("weapon_petrolcan") then
							if Config.NeedBag then
							    if borsa == 40 or borsa == 41 or borsa == 44 or borsa == 45 then
							        ESX.TriggerServerCallback('esx_vangelico2_robbery:conteggio', function(CopsConnected)
								        if CopsConnected >= Config.RequiredCopsRob then
							                TriggerServerEvent('kobs2_robbery:rob', k)
									        PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", pos2.x, pos2.y, pos2.z)
								        else
									        TriggerEvent('esx:showNotification', _U('min_two_police') .. Config.RequiredCopsRob .. _U('min_two_police2'))
								        end
							        end)		
						        else
							        TriggerEvent('esx:showNotification', _U('need_bag'))
								end
							else
								ESX.TriggerServerCallback('esx_vangelico2_robbery:conteggio', function(CopsConnected)
									if CopsConnected >= Config.RequiredCopsRob then
										TriggerServerEvent('kobs2_robbery:rob', k)
										PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", pos2.x, pos2.y, pos2.z)
									else
										TriggerEvent('esx:showNotification', _U('min_two_police') .. Config.RequiredCopsRob .. _U('min_two_police2'))
									end
								end)	
							end	
							
							else
							TriggerEvent('esx:showNotification','Dadash Kasi Be JerryCan Rob Mizane?')
							end
                        end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end		
				end
			end
		end

		if holdingup then
			drawTxt(0.3, 1.4, 0.45, _U('smash_case') .. ' : ' .. vetrineRotte .. '/' .. Config.MaxWindows, 185, 185, 185, 255)

			for i,v in pairs(vetrine) do 
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 10.0) and not v.isOpen and Config.EnableMarker then 
					DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 0, 255, 0, 200, 1, 1, 0, 0)
				end
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 0.75) and not v.isOpen then 
					DrawText3D(v.x, v.y, v.z, '[E] ' .. _U('press_to_collect'), 0.6)
					if IsControlJustPressed(0, 38) then
						
						ESX.TriggerServerCallback('AT_Cheking:woord2', function(accept)
							if accept == true then
								Wait(100)


								TriggerEvent('Alireza_WhiteList', source)
								animazione = true
								SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z-0.95)
								SetEntityHeading(GetPlayerPed(-1), v.heading)
								v.isOpen = true 
								PlaySoundFromCoord(-1, "Glass_Smash", v.x, v.y, v.z, "", 0, 0, 0)
								if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
								RequestNamedPtfxAsset("scr_jewelheist")
								end
								while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
								Citizen.Wait(0)
								end
								SetPtfxAssetNextCall("scr_jewelheist")
								StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
								loadAnimDict( "missheist_jewel" ) 
								TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
								TriggerEvent("mt:missiontext", _U('collectinprogress'), 3000)
								--DisplayHelpText(_U('collectinprogress'))
								DrawSubtitleTimed(5000, 1)
								Citizen.Wait(5000)
								ClearPedTasksImmediately(GetPlayerPed(-1))
								TriggerServerEvent('kobs2:gioielli')
								PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
								vetrineRotte = vetrineRotte+1
								animazione = false
		
								if vetrineRotte == Config.MaxWindows then 
									for i,v in pairs(vetrine) do 
										v.isOpen = false
										vetrineRotte = 0
									end
									TriggerServerEvent('esx_vangelico2_robbery:endrob', store)
									ESX.ShowNotification(_U('mahalforosh'))
									holdingup = false
									StopSound(soundid)
								end
							else
								ESX.ShowNotification("Baray Start Robery Shoma Byad Dar woord Defult Bashid.")
								CancelEvent()
							end
						end)

					end
				end	
			end

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 2736.77, 3477.41, 55.69, true) > 11.5 ) then
				TriggerServerEvent('esx_vangelico2_robbery:toofar', store)
				holdingup = false
				for i,v in pairs(vetrine) do 
					v.isOpen = false
					vetrineRotte = 0
				end
				StopSound(soundid)
				
			end

		end

		Citizen.Wait(5)
	end
end)

Citizen.CreateThread(function()
      
	while true do
		Wait(1)
		if animazione == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
				TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		end
	end
end)


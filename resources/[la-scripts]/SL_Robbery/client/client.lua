local holdingup = false
local bank = ""
local savedbank = {}
local secondsRemaining = 0
local blipRobbery = nil

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

----Functions

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

-----Events

RegisterNetEvent('kiri:currentlyrobbing')
AddEventHandler('kiri:currentlyrobbing', function(robb)
	holdingup = true
	bank = robb
	secondsRemaining = 300
end)


RegisterNetEvent('kiri:killblip')
AddEventHandler('kiri:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('kiri:setblip')
AddEventHandler('kiri:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('kiri:toofarlocal')
AddEventHandler('kiri:toofarlocal', function(robb)
	holdingup = false
	bombholdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('kiri:robberycomplete')
AddEventHandler('kiri:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete') .. Banks[bank].reward)
	bank = ""
	TriggerEvent('esx_blowtorch:finishclear')
	TriggerEvent('esx_blowtorch:stopblowtorching')
	secondsRemaining = 0
	incircle = false
end)



-------Citizen.CreateThread

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
		if hackholdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
		if bombholdingup then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(Banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 255)--156
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 75)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('bank_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 10.0)then
				if not holdingup then
					DrawMarker(27, v.position.x, v.position.y, v.position.z - 0.95, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 0.5)then
						if (incircle == false) then
							ESX.ShowHelpNotification(_U('press_to_rob'))
						end
						incircle = true
						if IsControlJustReleased(1, 51) then

							ESX.TriggerServerCallback('AT_Cheking:woord2', function(accept)
								if accept == false then
									Wait(100)

									ESX.ShowNotification("Baray Start Robery Shoma Byad Dar woorld Defult Bashid.")
									CancelEvent()
								else
									Wait(100)
									TriggerServerEvent('kiri:rob', k)
									TriggerServerEvent('new_banking:disableforhour', v.position)
								end
							end)

						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		if holdingup then

			drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('robbery_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)
			DisplayHelpText(_U('press_to_cancel'))

			local pos2 = Banks[bank].position


			if IsControlJustReleased(1, 120) then
				TriggerServerEvent('kiri:toofar', bank)
				TriggerEvent('esx_blowtorch:stopblowtorching')
			end

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('kiri:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)




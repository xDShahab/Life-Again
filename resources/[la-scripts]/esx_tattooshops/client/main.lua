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



local currentTattoos, cam, CurrentActionData = {}, -1, {}
local HasAlreadyEnteredMarker, CurrentAction, CurrentActionMsg
ESX = nil




Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('skinchanger:modelLoaded', function()
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		if tattooList then
			for k,v in pairs(tattooList) do
				ApplyPedOverlay(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
end)

function OpenShopMenu()
	local elements = {}

	for k,v in pairs(Config.TattooCategories) do
		table.insert(elements, {label= v.name, value = v.value})
	end

	if DoesCamExist(cam) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop', {
		title    = _U('tattoos'),
		 align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local currentLabel, currentValue = data.current.label, data.current.value

		if data.current.value then
			elements = {{label = _U('go_back_to_menu'), value = nil}}

			for k,v in pairs(Config.TattooList[data.current.value]) do
				table.insert(elements, {
					label = _U('tattoo_item', k, _U('money_amount', ESX.Math.GroupDigits(v.price))),
					value = k,
					price = v.price
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop_categories', {
				title    = _U('tattoos') .. ' | '..currentLabel,
				 align    = 'top-left',
				elements = elements
			}, function(data2, menu2)
				local price = data2.current.price
				if data2.current.value ~= nil then

					ESX.TriggerServerCallback('esx_tattooshop:purchaseTattoo', function(success)
						if success then
							table.insert(currentTattoos, {collection = currentValue, texture = data2.current.value})
						end
					end, currentTattoos, price, {collection = currentValue, texture = data2.current.value})

				else
					OpenShopMenu()
					RenderScriptCams(false, false, 0, 1, 0)
					DestroyCam(cam, false)
					cleanPlayer()
				end

			end, function(data2, menu2)
				menu2.close()
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				setPedSkin()
			end, function(data2, menu2) -- when highlighted
				if data2.current.value ~= nil then
					drawTattoo(data2.current.value, currentValue)
				end
			end)
		end
	end, function(data, menu)
		menu.close()
		setPedSkin()
	end)
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		local blip = AddBlipForCoord(v)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(_U('tattoo_shop'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords, letSleep = GetEntityCoords(PlayerPedId()), true

		for k,v in pairs(Config.Zones) do
			if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v, true) < Config.DrawDistance) then
				DrawMarker(Config.Type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				letSleep = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone, LastZone

		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v, true) < Config.Size.x then
				isInMarker  = true
				currentZone = 'TattooShop'
				LastZone    = 'TattooShop'
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_tattooshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_tattooshop:hasExitedMarker', LastZone)
		end
	end
end)

AddEventHandler('esx_tattooshop:hasEnteredMarker', function(zone)
	if zone == 'TattooShop' then
		CurrentAction     = 'tattoo_shop'
		CurrentActionMsg  = _U('tattoo_shop_prompt')
		CurrentActionData = {zone = zone}
	end
end)

AddEventHandler('esx_tattooshop:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'tattoo_shop' then
					OpenShopMenu()
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function setPedSkin()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	Citizen.Wait(1000)

	for k,v in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	end
end

function drawTattoo(current, collection)
	SetEntityHeading(PlayerPedId(), 297.7296)
	ClearPedDecorations(PlayerPedId())

	for k,v in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	end

	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 0,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 15,
				torso_2  = 0,
				pants_1  = 14,
				pants_2  = 0
			})
		else
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 1,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 15,
				torso_2  = 1,
				pants_1  = 15,
				pants_2  = 0
			})
		end
	end)

	ApplyPedOverlay(PlayerPedId(), GetHashKey(collection), GetHashKey(Config.TattooList[collection][current].nameHash))

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
	end

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

	SetCamCoord(cam, x + Config.TattooList[collection][current].addedX, y + Config.TattooList[collection][current].addedY, z + Config.TattooList[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, Config.TattooList[collection][current].rotZ)
end

function cleanPlayer()
	ClearPedDecorations(PlayerPedId())

	for k,v in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	end
end






-----Delete Tato 


Citizen.CreateThread(function()
  Hologramsa()
  KeyControla()
end)

Config.Zonesa = {
	Banks = {
		Posa = {
			{x= -441.62, y= -302.58, z= 14.91, type = "display", label = " Baray Darman [E] Bezanid"}
    },
		
		Posma = {
			{x= -441.62, y= -302.58, z= 33.91, type = "display", label = ""}
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
      for k,v in pairs(Config.Zonesa) do
          for i=1, #v.Posa, 1 do
              if GetDistanceBetweenCoords( v.Posa[i].x, v.Posa[i].y, v.Posa[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
                  local alireza11 = 1
                  local sizealireza1 = { x = 3.6, y = 3.6, z = 0.3 }
                  local coloralireza2 = { r = 900, g = 0, b = 0 }
				  ESX.ShowHelpNotification('Pls [E] To Delete Tattoo')
                  DrawMarker(alireza11, v.Posma[i].x, v.Posma[i].y, v.Posma[i].z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizealireza1.x, sizealireza1.y, sizealireza1.z, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
                  --Draw3DText( v.Posa[i].x, v.Poas[i].y, v.Posa[i].z - 0.250, v.Posa[i].label, 4, 0.1, 0.1)
              end	             
          end
      end
end
end



--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if checkDistancea() then
			  ESX.ShowHelpNotification('Pls [E] To Delete Tattoo')
		end
        if IsControlJustReleased(0, Keys['E']) and checkDistancea() then

				local elements = { 
					{label = 'Lezar Kardan Tato Ha',    value = 'a1'},
				  }
			
				
				  ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'Tato',
					{
					  title    = ('Tato'),
					  align    = 'center',
					  elements = elements,
					},
			
					function(data, menu)
						if data.current.value == 'a1' then
							TriggerEvent("mythic_progbar:client:progress", {
								name = "alireza_at",
								duration = 20500,
								label = "Dar Hal Lazer Kardan Tatto",
								useWhileDead = false,
								canCancel = true,
								controlDisables = {
									disableMovement = true,
									disableCarMovement = true,
									disableMouse = false,
									disableCombat = true,
								},
							})
							Citizen.Wait(20500)

							TriggerServerEvent('esx_tattoshop:delete', GetPlayerServerId(PlayerId()))

							ESX.UI.Menu.CloseAll()
						end
					end)
			
        end
        if IsControlJustReleased(0, Keys['BACKSPACE']) and checkDistancea() then
            ESX.UI.Menu.CloseAll()
        end
    end 
end)
]]


AddEventHandler('onKeyUP', function(control)
    if checkDistancea() then
        if control == 'e' then
			local elements = { 
				{label = 'Lezar Kardan Tato Ha',    value = 'a1'},
			  }
		
			
			  ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'Tato',
				{
				  title    = ('Tato'),
				  align    = 'center',
				  elements = elements,
				},
		
				function(data, menu)
					if data.current.value == 'a1' then
						TriggerEvent("mythic_progbar:client:progress", {
							name = "alireza_at",
							duration = 20500,
							label = "Dar Hal Lazer Kardan Tatto",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
						})
						Citizen.Wait(20500)

						TriggerServerEvent('esx_tattoshop:delete', GetPlayerServerId(PlayerId()))

						ESX.UI.Menu.CloseAll()
					end
				end)
        end
        if control == 'back' then
            ESX.UI.Menu.CloseAll()
        end
    end
end)
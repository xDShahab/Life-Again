-- Settings
local color = { r = 255, g = 255, b = 255, alpha = 255 } -- Color of the text 
local font = 0 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local background = {
    enable = false,
    color = { r = 0, g = 0, b = 0, alpha = 80 },
}
local dropShadow = false

-- Don't touch


local nbrDisplaying = 1
local timer = 0 


RegisterCommand('me', function(source, args)
    if GetGameTimer() - 5000  > timer then
        timer = GetGameTimer()
        local text = '(('.. GetPlayerServerId(PlayerId()) ..'))' -- edit here if you want to change the language : EN: the person / FR: la personne
        local playerName = GetPlayerName(source)
        for i = 1,#args do
            text = text .. ' ' .. args[i]
        end
        text = text .. ' '
        TriggerServerEvent('3dme:shareDisplay', text, true)
    else
        ESX.ShowNotification("Shoma Mojaz Be Spam Kardan In Cmd Nistid")
        timer = GetGameTimer()
    end
end)

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source, chat, targetped_network)
    local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
    if senderplayerPed and DoesEntityExist(senderplayerPed) then
		local offset = 1 + (nbrDisplaying*0.14)
		Display(GetPlayerFromServerId(source), text, offset, chat, targetped_network)
	end
end)

function Display(mePlayer, text, offset, chat, targetped_network)
    local displaying = true
    local targetped_network = targetped_network

    -- Chat message
    if chat then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        if dist < 2500 then
            TriggerEvent('chat:addMessage', {
                color = { color.r, color.g, color.b },
                multiline = true,
                args = { text}
            })
        end
    end

    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
			local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
			if senderplayerPed and DoesEntityExist(senderplayerPed) then
				local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
				local coords = GetEntityCoords(PlayerPedId(), false)
				local dist = Vdist2(coordsMe, coords)
				if dist < 2500 then
					if HasEntityClearLosToEntity(GetPlayerPed(-1), GetPlayerPed(mePlayer), 17) then
						DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset, text)
					end
				end
			end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then

        -- Formalize the text
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextScale(0.0*scale, 0.40*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextCentre(true)
        if dropShadow then
            SetTextDropshadow(10, 100, 100, 100, 255)
        end

        -- Calculate width and height
        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.40*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)

        if background.enable then
            DrawRect(_x, _y+scale/45, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
        end
    end
end
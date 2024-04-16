local color = { r = 255, g = 255, b = 255, alpha = 255 } 
local font = 0 
local time = 1800000
local background = {
    enable = false,
    color = { r = 0, g = 0, b = 0, alpha = 80 },
}
local dropShadow = false
local nbrDisplaying = 1
local timer = 0 

RegisterCommand('testn', function()
    TriggerServerEvent('ambulacne:startext', '~g~NewLife', true)
end)

function starttexet(tex)
    TriggerServerEvent('ambulacne:startext', tex, true)
end

RegisterNetEvent('ambulance:showtex')
AddEventHandler('ambulance:showtex', function(text, source, chat, targetped_network)
    local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
    if senderplayerPed and DoesEntityExist(senderplayerPed) then
		local offset = 0.8 + (nbrDisplaying*0.1)
		Display(GetPlayerFromServerId(source), text, offset, chat, targetped_network)
	end
end)

function Display(mePlayer, text, offset, chat, targetped_network)
    local displaying = true
    local targetped_network = targetped_network
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
            SetTextDropshadow(100, 10, 10, 10, 25)
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
    end
end
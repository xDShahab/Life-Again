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


local freeze = false
local spectate = false
local selectedplayer
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)





Citizen.CreateThread(function()
	WarMenu.CreateMenu('Main', 'LifeAgain Admin')
    WarMenu.CreateSubMenu('closeMenu', 'Main', 'Are you sure?')
    WarMenu.CreateSubMenu('spectateList', 'Main', 'Player List')
    WarMenu.CreateSubMenu('spectateList2', 'Main', 'Server Opsion')
    WarMenu.CreateSubMenu('alirezacheat', 'Main', 'Anti Cheat ')
    WarMenu.CreateSubMenu('alirezacheat', 'Main', 'Admin Zone  ')
    WarMenu.CreateSubMenu('lookPlayer', 'spectateList', 'Player manage')

	while true do
        if WarMenu.IsMenuOpened('Main') then
            if WarMenu.MenuButton('👁‍🗨 : Player List', 'spectateList') then
            elseif WarMenu.MenuButton('⚙️ : Admin Power', 'spectateList2') then
            elseif WarMenu.MenuButton('⚙️ : AntiCheat', 'alirezacheat') then
            elseif WarMenu.MenuButton('⚙️ : Admin Zone ', 'alirezaadminzone') then
            elseif WarMenu.MenuButton('Close', 'closeMenu') then
			end

            
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('closeMenu') then
			if WarMenu.Button('Yes') then
				WarMenu.CloseMenu()
			elseif WarMenu.MenuButton('No', 'Main') then
			end

        elseif WarMenu.IsMenuOpened('alirezacheat') then
            if WarMenu.Button('Delete All Object') then
				TriggerEvent('Alireza:Deleteobjec', -1)
            elseif WarMenu.Button('Delete All Ped') then
                TriggerEvent('Alireza:peds', -1)
            elseif WarMenu.Button('Delete All Vehicle ') then
                TriggerEvent('Alireza:vehi2', -1)
            end


            
			WarMenu.Display()
        elseif WarMenu.IsMenuOpened('spectateList2') then
			if WarMenu.Button('Noclip') then
				TriggerEvent('alireza_admin:noclip', source)
            elseif WarMenu.Button('Reviveall') then
                TriggerEvent('esx_ambulancejobkiri:reviveIfDead', -1)
            elseif WarMenu.Button('Freeeze') then
                TriggerEvent('es_admin:freezeePlayer', true)
            elseif WarMenu.Button('Un Freeeze') then
                TriggerEvent('es_admin:freezeePlayer', false)
            elseif WarMenu.Button('Armor') then
                TriggerEvent('setArmorHandler', source)
            elseif WarMenu.Button('Teleport to Az') then
                TriggerEvent('Alireza_WhiteList', source)
                SetEntityCoords(PlayerPedId(), -419.1,  1147.09, 325.86)	
                TriggerEvent('es_admin:freezeePlayer', true)
                ESX.ShowNotification("~h~Shoma Be AdminZone Teleport Shodid")
                Citizen.Wait(4000)
                TriggerEvent('es_admin:freezeePlayer', false)
			end


			WarMenu.Display()
        elseif WarMenu.IsMenuOpened('spectateList') then
            for _,i in pairs(GetActivePlayers()) do
                if WarMenu.MenuButton((GetPlayerName(i).." ~o~ID: "..GetPlayerServerId(i).." "..(IsPedDeadOrDying(GetPlayerPed(i), 1) and "DEAD" or "ALIVE")), 'lookPlayer') then
                    selectedplayer = i
                end
            end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('lookPlayer') then
            if WarMenu.Button("Spectate") then
                SpectatePlayer(selectedplayer)
            elseif WarMenu.Button("Goto") then
                local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(selectedplayer)))

                TriggerEvent('Alireza_WhiteList', source)
                SetEntityCoords(PlayerPedId(), x,y,z)
            elseif WarMenu.Button("Bring") then
                ExecuteCommand('bring '..GetPlayerServerId(selectedplayer))
            elseif WarMenu.Button("Give car") then
                local target = GetPlayerPed(selectedplayer)
                local ModelName = KeyboardInput("Model", "", 100)
                if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                    RequestModel(ModelName)
                    while not HasModelLoaded(ModelName) do
                        Citizen.Wait(0)
                    end
                    local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(target), GetEntityHeading(target)+90, true, true)
                end
            elseif WarMenu.Button("Revive") then
                ExecuteCommand('revive '..GetPlayerServerId(selectedplayer))
            elseif WarMenu.Button("Ban") then
                local DurationMenu = KeyboardInput("Duration", "", 100)
                local RazonMenu = KeyboardInput("Reason", "", 100)
                if DurationMenu and RazonMenu then
                    TriggerServerEvent('AdminMenu:banUser', GetPlayerServerId(selectedplayer), DurationMenu, RazonMenu)
                end
            end

            WarMenu.Display()
        end

		Citizen.Wait(0)
	end
end)



RegisterNetEvent('AdminMenu:openMenu')
AddEventHandler('AdminMenu:openMenu', function()
    WarMenu.OpenMenu('Main')
end)


--[[Citizen.CreateThread(function()
	while true do
		Wait(1)
        ESX.TriggerServerCallback('esx_aduty:checkAdmin', function(isAdmin)

        if isAdmin then

            if ESX.GetPlayerData()['aduty'] == 1 then

		        if IsControlJustReleased(0, 303) then
			      TriggerEvent('AdminMenu:openMenu', source)
                end

            else

               ESX.ShowNotification("~h~Shoma Nemitavanid Dar Halat Offduty Menu Ro Baz Konid")

            end
        end

	end
end)--]]




SpectatePlayer = function(player)
    local playerPed = PlayerPedId()
    spectate = not spectate
    local targetPed = GetPlayerPed(player)

    if (spectate) then
        DoScreenFadeOut(500)
        while (IsScreenFadingOut()) do Citizen.Wait(0) end
        NetworkSetInSpectatorMode(false, 0)
        NetworkSetInSpectatorMode(true, targetPed)
        DoScreenFadeIn(500)
        print("spectate")
    else
        DoScreenFadeOut(500)
        while (IsScreenFadingOut()) do Citizen.Wait(0) end
        NetworkSetInSpectatorMode(false, 0)
        DoScreenFadeIn(500)
        print("stop")
    end
end

local noclip = false
RegisterNetEvent("alireza_admin:noclip")
AddEventHandler("alireza_admin:noclip", function(t)
	local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(PlayerPedId(), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)



FreezePlayer = function(player)
    local targetPed = GetPlayerPed(player)
    freeze = not freeze
    if freeze then
        FreezeEntityPosition(targetPed, true)
    else
        FreezeEntityPosition(targetPed, false)
    end
end

KeyboardInput = function(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry .. ":")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        if IsDisabledControlPressed(0, 322) then return "" end
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end
end



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- Not sure which one is needed so you can choose/test which of these is the one you need.
        HideHudComponentThisFrame(3) -- SP Cash display 
        HideHudComponentThisFrame(4)  -- MP Cash display
        HideHudComponentThisFrame(13) -- Cash changes
        HideHudComponentThisFrame( 7 ) -- Area Name
		HideHudComponentThisFrame( 9 ) -- Street Name
		--[[if(states.frozen)then
			ClearPedTasksImmediately(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		end--]]
    end
end)

local heading = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(noclip)then
            TriggerEvent('Alireza_WhiteList', source)
			SetEntityCoordsNoOffset(PlayerPedId(), noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)


			if(IsControlPressed(1, 34))then
				heading = heading + 2.5
				if(heading > 360)then
					heading = 0
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 9))then
				heading = heading - 2.5
				if(heading < 0)then
					heading = 360
				end

				SetEntityHeading(PlayerPedId(), heading)
                ESX.ShowNotification("~h~Shoma Ba Movafaghiyat Noclip Shodid")
			end
            local targetGod = GetPlayerInvincible(targetPlayerId)

			if(IsControlPressed(1, 8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 19.0, 0.0)
                ESX.ShowNotification("~h~Shoma Ba Movafaghiyat Noclip Shodid")
			end

			if(IsControlPressed(1, 32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -9.0, 0.0)
                ESX.ShowNotification("~h~Shoma Ba Movafaghiyat Noclip Shodid")
			end

			if(IsControlPressed(1, 27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 9.0)
                ESX.ShowNotification("~h~Shoma Ba Movafaghiyat Noclip Shodid")
			end

			if(IsControlPressed(1, 173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -9.0)
                ESX.ShowNotification("~h~Shoma Ba Movafaghiyat Noclip Shodid")
			end
		else
			Citizen.Wait(200)
		end
	end
end)
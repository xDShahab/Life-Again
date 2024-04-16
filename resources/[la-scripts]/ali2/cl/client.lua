---By AliReza_At

local show3DText = false


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

local ESX = nil





TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




------Anti Vdm--------
Citizen.CreateThread(function()
    while true do
        SetWeaponDamageModifier(-1553120962, 0.0)   --Mashin
        SetWeaponDamageModifier(0xA2719263, 0.1)    --Mosht
        Wait(500)
    end
end)


-----Clothing Player----
RegisterNetEvent("esx_best:checkVanish")
AddEventHandler("esx_best:checkVanish", function(source)
	TriggerServerEvent('paintbal_mannistamtosh', GetPlayerServerId(PlayerId()))
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		id = PlayerId()
		DisablePlayerVehicleRewards(id)	
	end
end)

RegisterNetEvent("P:Shirt")
AddEventHandler("P:Shirt", function(source)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
        local clothesSkin = {
            ['torso_1'] = 141,   ['torso_2'] = 0,
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end
    end)
end)




RegisterCommand('alist',function(source)
	ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
		if accept ~= false then
            ESX.TriggerServerCallback('Aduty:getadminsinfo', function(info,cc)
            local elements = {}
                for i=1, #info, 1 do
                        table.insert(elements, {
                            label = "Admin "..info[i].perm.." - "..info[i].name.."("..info[i].source..") - "..info[i].vaziat
                        })
                end
            ESX.UI.Menu.CloseAll()
            ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'test',
            {
                title    = 'Admin Haye Online ('..cc..') Nafar',
                align    = 'center',
                elements = elements
                },
                    function(data2, menu2)  
                    end,
            function(data2, menu2)
                menu2.close()
            end
            )
            end)
        else
            ESX.ShowNotification("~h~Shoma Admin Nistid")
        end
    end)
end)


local blips = {
    {title="Lazer Tatto", colour=2, id=365, x= -441.62, y= -302.58, z= 14.91},
    {title="Mechanic", colour=47, id=402, x = -194.47, y = -1296.11, z = 31.3 },
    {title="Car Shop", colour=3, id=227, x = -35.05, y = -1093.59, z = 27.3 },
    {title="Mate Foroshi", colour=3, id=442, x= -1847.9, y=  -1196.43, z= 20.68 },
	{title="Bahama", colour=47 , id=486, x=-1390.82, y=-613.43, z=30.32},
    {title="Police Station ", colour=38 , id=137, x=450.73, y = -990.8, z = 30.69},
    {title="Sheriff Station ", colour=2 , id=137, x=-451.6761, y = 6017.9639, z = 31.7166},
    {title="Hotel", colour=1 , id=475, x=389.11, y = 2.0, z = 91.42},
    {title="Robbery Shishe", colour=1 , id=499, x=2438.25, y = 4967.72, z = 53.08},
    {title="Bime", colour=1 , id=472, x=-1080.63, y = -262.6, z = 37.79},
    {title="Cycling Road", colour=5 , id=376, x= -1366.43, y = -1401.6, z = 4.3},
    {title="Saloon", colour=1 , id=436, x= -305.05, y = 6261.4, z = 31.53},
    
}


Citizen.CreateThread(function()
  
	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.1)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)



Citizen.CreateThread(function()
    --Holograms()
    --KeyControl()
end)


Zones = {
	Deletevehicle = {
		Pos = {
			{x = 462.06, y = -1019.27, z = 28.1, type = "display" },
            {x =  462.06, y = -1019.27, z = 28.1, type = "display" }
        },
		Posm = {
			{x = 462.06, y = -1019.27, z = 29.1, type = "display" },
            {x =  462.06, y = -1019.27, z = 29.1, type = "display" }
        }
	}	
}



function alireza()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Zones) do
        for i=1, #v.Pos, 1 do
            if GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, false) < 2 then
                return true
            end
        end
    end
    return false
end

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end

function Holograms()
    while true do
        Citizen.Wait(5)
        for k,v in pairs(Zones) do
            for i=1, #v.Pos, 1 do
                if GetDistanceBetweenCoords( v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
                    local alireza11 = 1
                    local sizealireza1 = { x = 1.0, y = 1.0, z = 1.0 }
                    local coloralireza2 = { r = 700, g = 202, b = 2 }
                    DrawMarker(alireza11, v.Posm[i].x, v.Posm[i].y, v.Posm[i].z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizealireza1.x, sizealireza1.y, sizealireza1.z, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)

                end	             
            end
        end
	end
end


---====Open Menu====---

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if alireza() then
            ShowFloatingHelpNotification('~h~Press [E] To Delete Vehicle',462.06, -1019.27, 28.1)
        end

        if IsControlJustReleased(0, Keys['E']) and alireza() then
            if ESX.GetPlayerData().job.name == 'police' then
                Deletevehicle()
            else
                ESX.ShowNotification("~h~Shoma Police nistid!")
            end
        end


        if IsControlJustReleased(0, Keys['BACKSPACE']) and alireza() then
            ESX.UI.Menu.CloseAll()
        end
    end 
end)





function ShowFloatingHelpNotification(msg, x, y, z)
    SetFloatingHelpTextWorldPosition(1, x, y, z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(2, false, true, 0)
end



--====Menu Quest====--

function Deletevehicle()
    TriggerServerEvent('ali2:Dletevehicle', GetPlayerServerId(PlayerId()))
end







function NearAny()
    for k,v in pairs(Zones) do
        for i=1, #v.Pos, 1 do
            if GetDistanceBetweenCoords(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, GetEntityCoords(GetPlayerPed(-1)), false) < 3.0 then
                return true
            end
        end
    end
    return false
end


function dpemote(state)
	TriggerEvent("dpemote:enable",state)
end


RegisterNetEvent('At:Emotban')
AddEventHandler('At:Emotban', function(status)
    TriggerEvent("dpemote:enable", false)
end)


RegisterNetEvent('At:unEmotban')
AddEventHandler('At:unEmotban', function(status)
    TriggerEvent("dpemote:enable", true)
end)


---
Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)



local zones = {
	{ ['x'] = 425.34, ['y'] = -979.56, ['z'] = 30.71 },
	{ ['x'] = -464.8, ['y'] = 1131.51, ['z'] = 325.87 },
	{ ['x'] = 299.0798, ['y'] = -585.0530, ['z'] = 43.2608 },
	{ ['x'] = -654.7365, ['y'] = -2396.9199, ['z'] = 13.9568 },
	{ ['x'] = 2134.88, ['y'] = 4780.83, ['z'] = 40.97 },
}
local notifIn = false
local notifOut = false
local closestZone = 1
 


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)




Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
			--exports['okokNotify']:Alert("WARNING", "SafeZone!", 5000, 'warning')

		
			if dist <= 60.0 then 
				if not notifIn then																			
					NetworkSetFriendlyFireOption(false)
					ClearPlayerWantedLevel(PlayerId())
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
					exports['okokNotify']:Alert("WARNING", "Shoma Dar SafeZone Hastid!", 5000, 'warning')
					notifIn = true
					notifOut = false
					DisableControlAction(0, 45, true) 
				end
			else
				if not notifOut then
					NetworkSetFriendlyFireOption(true)
					exports['okokNotify']:Alert("WARNING", "Shoma az SafeZone Kharej Shodid", 5000, 'warning')
					notifOut = true
					notifIn = false
				end
			end
			if notifIn then
				DisableControlAction(2, 37, true) 
				DisablePlayerFiring(player,true) 
				DisableControlAction(0, 106, true) 
				DisableControlAction(0, 45, true) 
				DisableControlAction(0, 80, true) 
				DisableControlAction(0, 140, true) 
				DisableControlAction(0, 250, true) 
				DisableControlAction(0, 263, true) 
				DisableControlAction(0, 310, true) 
				DisableControlAction(0, 318, true)
                SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
				DisableControlAction(0, 327, true) 
				if IsDisabledControlJustPressed(2, 37) then 
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
					exports['okokNotify']:Alert("WARNING", "Shoma Nemitavanid Az Weapon Dar SafeZone Estefade Konid", 5000, 'warning')
				end
				if IsDisabledControlJustPressed(0, 106) then 
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
					exports['okokNotify']:Alert("WARNING", "You can not do that in a Safe Zone", 5000, 'warning')
				end
			end

	end
end)













local crouched = false

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

            if ( not IsPauseMenuActive() ) then 
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        Citizen.Wait( 100 )
                    end 

                    if ( crouched == true ) then 
                        ResetPedMovementClipset( ped, 0 )
                        crouched = false 
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end )




--[[
RegisterCommand('moz', function()
    TriggerEvent('chat:addMessage', { template = '<img src="{0}" style="max-width: 500px;" />', args = { 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/856571355180826624/951094065536040980/giphy_4.gif'} })
end)

]]



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(veh) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end
        end
    end
end)




Citizen.CreateThread(function()
    while true do
        Wait(800)
        local current 	   = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        local speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId()))
        if math.floor(speed*3.6) > 260 then
            --kkkkkk = true
            SetEntityMaxSpeed(vehicle, 90.602005004883)
        end
        ---print(engineHealth) fivem kiram to kos nnat ba in nativ hay kirit
    end
end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if GetDistanceBetweenCoords(-1366.43, -1401.6, 4.3, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
            local alireza11 = 36
            local sizealireza1 = { x = 0.4, y = 0.4, z = 0.4 }
            local coloralireza2 = { r = 700, g = 0, b = 0 }
            ESX.ShowHelp('Baray Spawn ~r~[E]~w~ Bezanid',-1366.43, -1401.6, 4.3)
            DrawMarker(alireza11, -1366.43, -1401.6, 4.3 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizealireza1.x, sizealireza1.y, sizealireza1.z, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
        end	
	end
end)


AddEventHandler('onKeyUP', function(control)
	if control == 'e' then
        local coords = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(coords, -1366.43, -1401.6, 4.3, false) < 2 then
            ESX.UI.Menu.CloseAll()
            if nadidam then 
                return 
            else
                nadidam = true
                if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                    TriggerServerEvent('ali2:Dletevehicle', GetPlayerServerId(PlayerId()))
                    nadidam = false
                else
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "alireza_at",
                        duration = 10500,
                        label = "Spawning..",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        },
                    })
                    Citizen.Wait(10500)
                    Spawning('bmx')
                    nadidam = false
                end
            end
        end
    end
end)


function Spawning(model)
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	ESX.Game.SpawnVehicle(model, coords, 217.78, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
	end)
end














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

local Deleting = false



local coorddx = 238.5
local coorddy = -776.71
local coorddz = 30.68

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)
  



HasAlreadyEnteredMarker = false



Citizen.CreateThread(function()
    Markerssss()
    KeyControl()
end)

function alirezaat()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(coords, coorddx, coorddy, coorddz, false) < 2 then
        return true
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

function Markerssss()
    while true do
        Citizen.Wait(5)
        if GetDistanceBetweenCoords( coorddx,  coorddy, coorddz, GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
            local alireza11 = 36
            local sizealireza1 = { x = 0.4, y = 0.4, z = 0.4 }
            local coloralireza2 = { r = 700, g = 0, b = 0 }
            if ESX.GetPlayerData().job.name == 'restoran' then
              DrawMarker(alireza11, coorddx, coorddy, coorddz , 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizealireza1.x, sizealireza1.y, sizealireza1.z, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
            end
        end	
	end
end


AddEventHandler('onKeyUP', function(control)
    if alirezaat() then
        if control == 'e' then
            if ESX.GetPlayerData().job.name == 'restoran' then
                if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                    TriggerServerEvent('ali2:Dletevehicle', GetPlayerServerId(PlayerId()))
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
                    Spawning('SlamVan3')
                    Deleting =  true
                end
            else
                ESX.ShowNotification('shoma restoran nistid')
            end
        end
    end
end)

function Spawning(model)
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	ESX.Game.SpawnVehicle(model, coords, 340.36, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
	end)
end


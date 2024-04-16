ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(2)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)


blipRadius = 10.0
blipCol = 7


function missionTextDisplay(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end


local numberblips = 0
local blipcoords = {}
local blipradi = {}
local blipcreators = {}
local blipcrenames = {}
local blipid = {}
local blipcreators2 = {}
local candraw = {}
RegisterNetEvent('Fax:AdminAreaSetnew')
AddEventHandler("Fax:AdminAreaSetnew", function(s,sname,SyncCoords)
    local src = s
    if numberblips ~= 5 then
        if not blipcreators[src] then
            numberblips = numberblips + 1
            local coords = SyncCoords
            local radiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, blipRadius)
            local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
            blipcreators[src] =  numberblips
            blipcreators2[numberblips] = src
            blipcrenames[src] = sname
            blipcoords[numberblips] = coords
            blipradi[numberblips] = radiusBlip
            blipid[numberblips] = blip
            candraw[numberblips] = true
            SetBlipSprite(blip, 269)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, blipCol)
            SetBlipScale(blip, 1.0)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString('RP Pause '.."-"..numberblips)
            EndTextCommandSetBlipName(blip)
            SetBlipAlpha(radiusBlip, 80)
            SetBlipColour(radiusBlip, blipCol)
            local point = vector3(coords.x, coords.y, coords.z)
            UpdateCapturePoint(point,numberblips,sname)
            missionTextDisplay('~h~Dar Yek Mantaghe RP Pause Shode Ast | Admin Nazer :'..sname, 8000)
        else
            ESX.ShowNotification('Ham Aknun Yek RP Pause Sakhtid.')
        end
    else
        ESX.ShowNotification('Ham Aknun Dar 5 Mantaghe RP Pause Vojud Darad.')
    end
end)



function NCZ()
    DisableControlAction(0, 45, true)
	DisableControlAction(0, 21, true)
    DisableControlAction(0, 22, true)
    DisableControlAction(0, 289, true)
    DisableControlAction(0, 318, true)
    DisableControlAction(0, 167, true)
    DisableControlAction(0, 37, true)
    DisableControlAction(0, 105, true)  
    DisableControlAction(0, 323, true)  ---x
	DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 25, true) -- Right click
	DisableControlAction(0, 68, true) -- Vehicle Attack
	DisableControlAction(0, 69, true) -- Vehicle Attack
	DisableControlAction(0, 70, true) -- Vehicle Attack
	DisableControlAction(0, 92, true) -- Vehicle Passengers Attack
	DisableControlAction(0, 346, true) -- Vehicle Melee
	DisableControlAction(0, 347, true) -- Vehicle Melee
	DisableControlAction(0, 264, true) -- Disable melee
	DisableControlAction(0, 257, true) -- Disable melee
	DisableControlAction(0, 140, true) -- Disable melee
	DisableControlAction(0, 141, true) -- Disable melee
	DisableControlAction(0, 142, true) -- Disable melee
	DisableControlAction(0, 143, true) -- Disable melee
	DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(0, 289, true) -- f2
    DisableControlAction(0, 311, true) -- K   
    
    if IsDisabledControlJustPressed(2, 37) then
        SetCurrentPedWeapon(playerPed,GetHashKey("WEAPON_UNARMED"),true)
    end
    if IsDisabledControlJustPressed(0, 106) then
        SetCurrentPedWeapon(playerPed,GetHashKey("WEAPON_UNARMED"),true)
    end
end



function UpdateCapturePoint(point,id,nzr)
    Citizen.CreateThread(function()
        while candraw[id] do
            local playerPed = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local coords    = GetEntityCoords(playerPed)
            if GetDistanceBetweenCoords(coords, point, true) < 100 then
                NCZ()
                --SetVehicleMaxSpeed(vehicle, 10.5)
               -- missionTextDisplay("Shoam Dar RpPause Hastid")

                TriggerEvent('esx:showAdvancedNotification', 'RP Pause ['..id..']', 'Admin Nazer : ~p~'..nzr, 'Lotfan Az Mantaghe RP Pause Kharej Nashavid', 'CHAR_BLOCKED', 1)
                --DrawMarker(28, point.x, point.y, point.z - 10, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 20.0, 20.0, 40.0, 205, 205, 255, 50, false, true, 2, false, false, false, false)
                --DrawMarker(28, point.x, point.y, point.z - 10, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 20.0, 20.0, 40.0, 205, 205, 255, 50, false, true, 2, false, false, false, false)
                ---DrawMarker(28, point.x, point.y, point.z - 10, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 20.0, 20.0, 40.0, 205, 205, 255, 50, false, true, 2, false, false, false, false)
				--DrawMarker(28, point.x, point.y, point.z - 10, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 20.0, 20.0, 40.0, 205, 205, 255, 50, false, true, 2, false, false, false, false)
				--DrawMarker(28, point.x, point.y, point.z - 10, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 20.0, 20.0, 40.0, 205, 205, 255, 50, false, true, 2, false, false, false, false)
				DrawMarker(1, point.x, point.y, point.z - 30, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 20.0, 20.0, 400.0, 505, 5, 5, 100, false, true, 2, false, false, false, false)
            end
            Wait(1)
        end
        return
    end)
end
RegisterNetEvent('Fax:AdminAreaSetnewclear')
AddEventHandler("Fax:AdminAreaSetnewclear", function(s)
    local src = s
    local idblipesh = blipcreators[src]
    local blipclearkon = blipid[idblipesh]
    local radblip = blipradi[idblipesh]
    candraw[idblipesh] = false
    RemoveBlip(blipclearkon)
    RemoveBlip(radblip)
    blipcreators[src] = nil
    blipcrenames[src] = nil
    missionTextDisplay("~h~RP Dar Mantaghe : ("..idblipesh..") Resume Shod", 5000)
    numberblips = numberblips - 1

end)
RegisterNetEvent('Fax:AdminAreaSetnewclearrps')
AddEventHandler("Fax:AdminAreaSetnewclearrps", function(s,sname)
    local idblip = tonumber(s)
    local blipclearkon = blipid[idblip]
    local radblip = blipradi[idblip]
    local srckie = blipcreators2[idblip]
    candraw[idblip] = false
    blipcreators[srckie] = nil
    blipcrenames[srckie] = nil
    RemoveBlip(blipclearkon)
    RemoveBlip(radblip)

    missionTextDisplay("~p~RP Dar Mantaghe : "..idblip.." ~p~Resume Shod | Resumer: "..sname, 5000)
    numberblips = numberblips - 1
end)

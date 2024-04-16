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

ESX = nil

Citizen.CreateThread(function() 
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local CurrentActions = 0
local IsJailed = false
local IsInPrison = false
local DisableActions = false
local vassour_net = nil
local spatula_net = nil
local availableActions = {}
local vassoumodel = "prop_tool_broom"
local spatulamodel = "bkr_prop_coke_spatula_04"

function dpemote(state)
	TriggerEvent("dpemote:enable",state)
end

RegisterNetEvent("AT_Comserv:TimeToFingerYourSelf")
AddEventHandler("AT_Comserv:TimeToFingerYourSelf", function(Actions)
    TriggerEvent('handappstate',false)
    dpemote(false)
    local playerPed = PlayerPedId()
    FillActionTable()
    ApplyPrisonerSkin()
    ESX.Game.Teleport(playerPed, Config.ServiceLocation)
    IsJailed = true
    DisableActions = true
    CurrentActions = Actions
    IsInPrison = true
    Mark()
    StartJail()
    Citizen.CreateThread(function() 
        while CurrentActions > 0 and IsJailed == true do
            Citizen.Wait(1000)
            if IsPedInAnyVehicle(playerPed, false) or GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.ServiceLocation.x, Config.ServiceLocation.y, Config.ServiceLocation.z) > Config.DistanceExtension then
                ClearPedTasksImmediately(playerPed)
                ESX.Game.Teleport(playerPed, Config.ServiceLocation)
            else
                Citizen.Wait(900)
            end
        end
    end)
end)

function FillActionTable(last_action)
    if #availableActions < 3 then
        while #availableActions < 8 do
            local service_does_not_exist = true
            local random_selection = Config.ServiceLocations[math.random(1,#Config.ServiceLocations)]

            for i = 1, #availableActions do
                if random_selection.coords.x == availableActions[i].coords.x and random_selection.coords.y == availableActions[i].coords.y and random_selection.coords.z == availableActions[i].coords.z then

                    service_does_not_exist = false

                end
            end

            if last_action ~= nil and random_selection.coords.x == last_action.coords.x and random_selection.coords.y == last_action.coords.y and random_selection.coords.z == last_action.coords.z then
                service_does_not_exist = false
            end
            if service_does_not_exist then
                table.insert(availableActions, random_selection)
            end
        end
    end
end


RegisterNetEvent('AT_Comserv:ReleaseMe')
AddEventHandler('AT_Comserv:ReleaseMe', function()
    ESX.TriggerServerCallback('AT_Comserv:CanYouReleaseMe', function(iCan)
        if iCan then
            if CurrentActions == 0 then
                IsJailed = false
                CurrentActions = 0
                IsInPrison = false
                ESX.Game.Teleport(PlayerPedId(), Config.ReleaseLocation)
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('handappstate',true)
                TriggerServerEvent('kir_Mantokon:sadra')
                dpemote(true)
                Citizen.Wait(1000)
                TriggerEvent('Alireza_WhiteList', source)
                SetEntityCoords(PlayerPedId(), -533.08,  -203.02, 37.65)
                Citizen.Wait(100)	
                TriggerEvent('es_admin:freezeePlayer', true)
                Citizen.Wait(3000)
                TriggerEvent('es_admin:freezeePlayer', false)
                TriggerServerEvent('Cs:Changeeloadout0', GetPlayerServerId(PlayerId()))
               

                end)
            end
        end
    end)
end)


RegisterNetEvent('AT_Comserv:endcomserv')
AddEventHandler('AT_Comserv:endcomserv', function(iCan)
    IsJailed = false
    CurrentActions = 0
    IsInPrison = false
    dpemote(true)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    TriggerEvent('Alireza_WhiteList', source)
    SetEntityCoords(PlayerPedId(), -533.08,  -203.02, 37.65)
    Citizen.Wait(5000)	
    TriggerEvent('es_admin:freezeePlayer', true)
    Citizen.Wait(5000)
    TriggerEvent('es_admin:freezeePlayer', false)
    TriggerServerEvent('Cs:Changeeloadout0', GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent('AT_Comserv:ReleaseMe2')
AddEventHandler('AT_Comserv:ReleaseMe2', function()
    ESX.TriggerServerCallback('AT_Comserv:CanYouReleaseMe', function(iCan)
        if iCan then
            if CurrentActions == 0 then
                IsJailed = false
                CurrentActions = 0
                IsInPrison = false
                ESX.Game.Teleport(PlayerPedId(), Config.ReleaseLocation)
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                       
                        TriggerEvent('skinchanger:loadSkin', skin)
                    
                        TriggerEvent('handappstate',true)
                        Citizen.Wait(1000)    
                        TriggerEvent('Alireza_WhiteList', source)
                        SetEntityCoords(PlayerPedId(), -533.08,  -203.02, 37.65)
                        Citizen.Wait(100)	
                        TriggerEvent('es_admin:freezeePlayer', true)
                        Citizen.Wait(3000)
                        TriggerEvent('es_admin:freezeePlayer', false)
                        TriggerServerEvent('Cs:Changeeloadout0', GetPlayerServerId(PlayerId()))
                end)
            end
        end
    end)
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
    DisableControlAction(0, Keys['F2'], true) 

    
    if IsDisabledControlJustPressed(2, 37) then
        SetCurrentPedWeapon(playerPed,GetHashKey("WEAPON_UNARMED"),true)
    end
    if IsDisabledControlJustPressed(0, 106) then
        SetCurrentPedWeapon(playerPed,GetHashKey("WEAPON_UNARMED"),true)
    end
end



function StartJail()
    Citizen.CreateThread(function() 
        while IsJailed do
            :: start_over ::
            Citizen.Wait(1)
            if CurrentActions > 0 and IsJailed and CurrentActions ~= 0 then
                DrawAvailableActions()
                NCZ()
                --RemoveAllPedWeapons(GetPlayerPed(-1), 1)
                --TriggerEvent('esx_basicneeds:healPlayer')
                local pCoords    = GetEntityCoords(PlayerPedId())
                for i = 1, #availableActions do
                    local distance = GetDistanceBetweenCoords(pCoords, availableActions[i].coords, true)
                    if distance < 1.5 then
                        if IsControlJustReleased(1, 38) then
                            tmp_action = availableActions[i]
                            RemoveAction(tmp_action)
                            FillActionTable(tmp_action)
                            DisableActions = true
                            if (tmp_action.type == "cleaning") then
                                --ESX.ShowNotification(": "..CurrentActions-1)
                                NCZ()
                                TriggerEvent('mt:missiontext','Comserv Baghi Mandeh  : ' ..CurrentActions-1, 5000)
                                RemoveAllPedWeapons(GetPlayerPed(-1), 1)
                                ESX.TriggerServerCallback('AliReza:Get_Comserv', function(source)
                                    print('.')
                                end)
                                local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
                                local vassouspawn = ESX.Game.SpawnObject(GetHashKey(vassoumodel), vector3(cSCoords.x, cSCoords.y, cSCoords.z))
                                local netid = ObjToNet(vassouspawn)
                                NCZ()
                                ESX.Streaming.RequestAnimDict("amb@world_human_janitor@male@idle_a", function()
                                    TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
                                    AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
                                    vassour_net = netid
                                end)
                                exports['progressBars']:startUI(60000, "Dar Hal Bil Zadan")
                                Citizen.Wait(60000)
                                SetTimeout(20000, function()
                                    DisableActions = false
                                    DetachEntity(NetToObj(vassour_net), 1, 1)
                                    DeleteEntity(NetToObj(vassour_net))
                                    vassour_net = nil
                                    ClearPedTasks(PlayerPedId())
                                    NCZ()
                                    CurrentActions = CurrentActions - 1
                                    TriggerServerEvent('AT_Comserv:MyActionIsDone')
                                end)
                            end
                            if (tmp_action.type == "gardening") then
                                TriggerEvent('mt:missiontext','Comserv Baghi Mandeh  : ' ..CurrentActions-1, 5000)
                                ESX.TriggerServerCallback('AliReza:Get_Comserv', function(source)
                                    print('.')
                                end)
                                NCZ()
                                TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, false)
                                exports['progressBars']:startUI(40000, "Dar Hal Bil Zadan")
                                Citizen.Wait(40000)
                                SetTimeout(12000, function()
                                    NCZ()
                                    DisableActions = false
                                    ClearPedTasks(PlayerPedId())
                                    CurrentActions = CurrentActions - 1
                                    TriggerServerEvent('AT_Comserv:MyActionIsDone')
                                end)
                            end
                            goto start_over
                        end
                    end
                end
            else
                Citizen.Wait(100)
                if IsInPrison then
                    TriggerEvent('AT_Comserv:ReleaseMe')
                end
            end
        end
    end)
end

-- Marker
function Mark()
    Citizen.CreateThread(function()  
        while IsJailed do
            Citizen.Wait(0)
            if CurrentActions > 0 and IsJailed == true then
                DrawMarker(1, Config.ServiceLocation.x, Config.ServiceLocation.y, 26.56, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DistanceExtension*2, Config.DistanceExtension*2, 110.0, 455, 110, 0, 100, false, true, 2, false, false, false, false)
            end
        end
    end)
end

function RemoveAction(action)
    local action_pos = -1

    for i=1, #availableActions do
        if action.coords.x == availableActions[i].coords.x and action.coords.y == availableActions[i].coords.y and action.coords.z == availableActions[i].coords.z then
            action_pos = i
        end
    end

    if action_pos ~= -1 then
        table.remove(availableActions, action_pos)
    else
        print("User tried to remove an unavailable action")
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawAvailableActions()
    for i = 1, #availableActions do
        DrawMarker(20, availableActions[i].coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 510, 510, 104, 100, false, true, 2, true, false, false, false)
    end
end








function ApplyPrisonerSkin()
    local playerPed = PlayerPedId()
    if DoesEntityExist(playerPed) then
        Citizen.CreateThread(function()  
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].male)
                else
                    TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms['prison_wear'].female)
                end
            end)
            SetPedArmour(playerPed, 0)
            ClearPedBloodDamage(playerPed)
            ResetPedVisibleDamage(playerPed)
            ClearPedLastWeaponDamage(playerPed)
            ResetPedMovementClipset(playerPed, 0)
            RemoveAllPedWeapons(GetPlayerPed(-1), 1)
            TriggerServerEvent('Cs:Changeeloadout2', GetPlayerServerId(PlayerId()))
           
        end)
    end
end



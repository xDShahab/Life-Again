--Capture Gang Script--
---bY AliReza_At & Sins---




local Config = {
    useweapon = false
}
local all_vehicle_spawned = {}


---New---
local killl = 0
---------


local all_killer = {}
local MarkerType = {
    [1] =1,
    [2] =1,
    [3] =1,
}
local repoint
local MarkerSize = {
    [1] =    100.5,
    [2] =    100.5,
    [3] =    100.5,
}
local weapon,car = nil,nil
local Captured, InCaptureZone, inCapture = {}, {}, false



local Color = {
    [1] = {r = 252, g = 107, b = 1},
    [2] = {r = 252, g = 107, b = 1},
    [3] = {r = 252, g = 107, b = 1},
}



local PlayerData
local CaptureIsActive
local Blip = {}
local pcoords = {}
local myid = PlayerId()
local HasEntered = {}
local myped = PlayerPedId()
local HasEntered2 = {}
local onrevive = false
local myserverid = GetPlayerServerId(myid)
local h = 0
ESX = nil

Citizen.CreateThread(function()

    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    while ESX.GetPlayerData().gang == nil do
		Citizen.Wait(10) 
	end

    PlayerData = ESX.GetPlayerData()
    PlayerData.gang = ESX.GetPlayerData().gang
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(data)
    PlayerData = data
end)



RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
    PlayerData.gang = gang

    if PlayerData.gang.name == 'nogang' then
        if CaptureIsActive and inCapture then
            inCapture = false
            EndUI()
        end

    end
    yourkill = 0
end)

RegisterNetEvent('capture:ImOUt')
AddEventHandler('capture:ImOUt', function()
    ESX.ShowNotification('Shoma az capture leave dadid')
    inCapture = false
    for _,v in ipairs(Blip) do
        local blip = v.icon
        local radios = v.radiusBlip
        RemoveBlip(blip)
        RemoveBlip(radios)
    end
    EndUI()
end)



RegisterNetEvent('capture:CaptureStarted')
AddEventHandler('capture:CaptureStarted', function(capData, owners,timer)

    CaptureIsActive = true

    if PlayerData.gang.name ~= 'nogang' then
        inCapture = true
        weapon = capData.weapon
        local elements = {}
        repoint = capData.repoint
        car = capData.car
        ESX.ShowNotification('Shoma vared capture shodid!')

        print{'kobs'}
        StartUI(capData.name) 
        if capData.coords[1] then
            if owners[1] ~= 'handeler' then
                UpdateUI(owners[1], timer,1)
            else
                UpdateUI('No one', timer,1)
            end
        else
            UpdateUI('not active', timer,1)
        end
        if capData.coords[2] then
            if owners[2] ~= 'handeler' then
                UpdateUI(owners[2], timer,2)
            else
                UpdateUI('No one', timer,2)
            end
        else
            UpdateUI('not active', timer,2)
        end
        if capData.coords[3] then
            if owners[3] ~= 'handeler' then
                UpdateUI(owners[3], timer,3)
            else
                UpdateUI('No one', timer,3)
            end
        else
            UpdateUI('not active', timer,3)
        end
        for _,v in ipairs(capData.coords) do
            table.insert(elements, { label = 'zone '.._, x = v.x, y = v.y, z = v.z  })
            local point = vector3(v.x, v.y, v.z)
            -- show blip
            UpdateBlip(point, 'Capture',_)
            
            -- show capture point
            UpdateCapturePoint(point,_)
            
            -- check if any user try capturing
            CheckCapturing(point,_)
    
            -- Start UI
 
    
            -- Update UI

    
            -- Deactive police and ambulance alert
            StartSecuringArea(point,_)
            Teleport(point,_)
            -- Bring(point,_)
        end
        ESX.UI.Menu.CloseAll()					
        myped = PlayerPedId()
        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'tpmenu',
            {
                title    = 'Teleport menu',
                align    = 'center',
                elements = elements
            },
            function(data, menu)		
                    xr = math.random(-100,100) 		
                    yr = math.random(-100,100) 			
                    local coords = { x = data.current.x +xr,  y = data.current.y+yr, z = data.current.z+400}
                    ESX.Game.Teleport(myped, coords)
                    --GiveWeaponToPed(myped, GetHashKey("GADGET_PARACHUTE"), true)
                    TriggerServerEvent('Capture:GivePlayerIteam', GetPlayerServerId(PlayerId()))
                menu.close()							
              end,
              function(data, menu)
              end
            )
    end
end)

RegisterNetEvent('capture:CoptureEnded')
AddEventHandler('capture:CoptureEnded', function()
    ESX.ShowNotification('Capture Be Payan resid')
    CaptureIsActive = false
    inCapture = false
    for _,v in ipairs(Blip) do
        local blip = v.icon
        local radios = v.radiusBlip
        RemoveBlip(blip)
        RemoveBlip(radios)
    end
    EndUI()
    Wait(2000)
    TriggerEvent('esx_ambulancejob:reviveaveralireza')
end)

local all_killer_info = nil

function _U(a)
    return a
end
 
RegisterNetEvent('change_capture_killer')
AddEventHandler('change_capture_killer', function(killername, num, data, dead_name, ped_id)
    if PlayerData.gang.name ~= 'nogang' then

    
        exports['killbox']:Alert("Kill", "💀  "..killername.."  <span style='color:#ff0000 ' >  Killed  </span>   "..tostring(dead_name).."", 3000, 'Kill')
       

    if not all_killer_info then

        all_killer_info = {}

        table.insert(all_killer_info, {killername, num, data})

    else

        local have_this_player = false

        for t,i in pairs(all_killer_info) do
            if i[1] == killername then
                have_this_player = true
                i[2] = i[2] + 1
            end
        end

        if not have_this_player then
            table.insert(all_killer_info, {killername, num, data})            
        end

    end

    local first = false
    local that_kill = {}
    local ldsd = 0
    local polaaa = {}
    for l,p in pairs(all_killer_info) do
        table.insert(polaaa, p)
        ldsd = ldsd + 1
    end

    local lol = 1

    for l=1, ldsd, 1 do
        local sda = 0
        local sda2 = 0
        local sda3 = {}
        local sda4 = 0
        for s,d in pairs(polaaa) do
            sda = d[2]
            if sda >= sda2 then
                sda3 = d
                sda4 = s
            end
            sda2 = d[2]
        end

        table.remove(polaaa, sda4)

        that_kill[lol] = {
            gang = sda3[3].gang.name,
            kills = sda3[2],
            name = sda3[1]
        }
        lol = lol + 1
        

    end

    SendNUIMessage({
        topKillers    = that_kill
    })

    that_kill = {}

--[[
    if ownnum[2] ~= -1 then
        SendNUIMessage({
            isown      = true,
            own    = ownnum[1]
        })
    end
    if toonum[2] ~= -1 then
        SendNUIMessage({
            istoo      = true,
            too    = toonum[1]
        })
    end
    if threenum[2] ~= -1 then
        SendNUIMessage({
            isthree      = true,
            three    = threenum[1]
        })
    end
    ]]
end
end)

RegisterNetEvent('capture:ChangeCaptureHandler')
AddEventHandler('capture:ChangeCaptureHandler', function(gang, num,endTime)
    print(num)
    print(gang)
    if PlayerData.gang.name ~= gang then
        ESX.ShowMissionText('~h~Gange' .. gang .. 'Dar Hale Capture Kardan Zone  '..num..' Ast')
        Color[num] = {r = 252, g = 107, b = 1}
        MarkerType[num] = 1
        MarkerSize[num] = 100.5
        Captured[num]   = false
    else
        ESX.ShowMissionText('~h~Gange Shoma Dar Hale Capture Kardan Zone ~o~'..num..' Ast')
        Color[num] = {r = 3, g = 188, b = 7}
        MarkerType[num] = 28
        MarkerSize[num] = 1.5
        Captured[num]   = true
    end

    -- Update UI
    UpdateUI(gang, endTime,num)
end)

function StartUI(capName)
    SendNUIMessage({
        start      = true,
        CapName    = capName
    })
end

function EndUI()
    for l,p in pairs(all_vehicle_spawned) do
        SetEntityCoords(p, 0.0, 0.0, 0.0)
        SetEntityHealth(p, 0)
        DeleteEntity(p)
    end
    all_killer_info = {}
    all_vehicle_spawned = {}
    SendNUIMessage({
        stop = true
    })
end

function UpdateUI(gang, endTime,num)
    if num then
        SendNUIMessage({
            update      = true,
            Handeler    = gang,
            Time        = endTime,
            Number      = num
        })
    else
        SendNUIMessage({
            update      = true,
            Handeler    = gang,
            Time        = endTime
        })
    end
end

function UpdateBlip(blip, name,_)
    print(_)
    if not Blip[_] then
        Blip[_] = {}
    end
    RemoveBlip(Blip[_].icon)
    RemoveBlip(Blip[_].radiusBlip)
    
    Blip[_].icon        = AddBlipForCoord(blip)
    Blip[_].radiusBlip  = AddBlipForRadius(blip, 50.0)

    SetBlipSprite (Blip[_].icon, 378)
    SetBlipDisplay(Blip[_].icon, 4)
    SetBlipScale  (Blip[_].icon, 1.2)
    SetBlipColour (Blip[_].icon, 76)
    SetBlipAsShortRange(Blip[_].icon, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name..' '.._)
    EndTextCommandSetBlipName(Blip[_].icon)
    
    SetBlipAlpha(Blip[_].radiusBlip, 80)
    SetBlipColour(Blip[_].radiusBlip, 22)
end

local alreadyDead = false

function UpdateCapturePoint(point,_)
    Citizen.CreateThread(function()
        while CaptureIsActive and inCapture do

            local playerPed = PlayerPedId()
            local coords    = GetEntityCoords(playerPed)

            if GetDistanceBetweenCoords(coords, point, true) < 300 then
                if GetDistanceBetweenCoords(coords, point, true) < 180 then
                    if Config.useweapon and not HasPedGotWeapon(myped, GetHashKey(weapon)) then
                        TriggerServerEvent('addpistol50', myserverid)
                    end
                    if (IsEntityDead(playerPed) and not alreadyDead) then
                        SetEntityInvincible(myped, true)
                        local playerName = GetPlayerName(myid)
                        killer = GetPedKiller(playerPed)
                        killername = '' 
                        local thisid = 0
                        for id = 0, 20000 do
                            if killer == GetPlayerPed(id) and GetPlayerPed(id) ~= PlayerPedId() then
                                --TriggerServerEvent('Capture_At:Updateyoukill', GetPlayerServerId(id))
                                killername = GetPlayerName(id)
                                thisid = GetPlayerServerId(id)
                                local melika = GetPlayerServerId(id)
                                TriggerServerEvent('Capture_At:Updateyoukill',GetPlayerServerId(id))
                                break
                            end
                        end
                        --TriggerServerEvent('Capture_kill_updateyou', GetPlayerServerId(id) )S
                        if thisid ~= 0 then
                            TriggerServerEvent('change_capture_killer', killername, 1, thisid, GetPlayerName(PlayerId()), GetPlayerServerId(PlayerId()))
                        end
                        alreadyDead = true 
                        Wait(3000)
                        TriggerEvent('esx_ambulancejob:reviveaveralireza')
                        while (ESX.GetPlayerData().IsDead and ESX.GetPlayerData().IsDead == true or ESX.GetPlayerData().IsDead == -1) do
                            Wait(2500)
                            TriggerEvent('esx_ambulancejob:reviveaveralireza')	
                        end
                        Wait(1000)

                        SetEntityCoords(playerPed,coords.x ,coords.y ,coords.z + 500.0)
                        TriggerEvent('es_admin:freezePlayer', true)


                        TriggerEvent("mythic_progbar:client:progress", {
                            name = "alireza_at",
                            duration = 15500,
                            label = "Respawning",
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                        })

                        Citizen.Wait(15500)
                        TriggerEvent('es_admin:freezePlayer', false)
                        Citizen.Wait(1000)
                        SetEntityCoords(playerPed, repoint.x+math.random(-10,10),repoint.y+math.random(-10,10),repoint.z)
                        SetEntityCoords(playerPed, repoint.x+math.random(-10,10),repoint.y+math.random(-10,10),repoint.z)
                        spawncar()
                        TriggerServerEvent('addpistol50', GetPlayerServerId(PlayerId()))
                        alreadyDead = false
                    end            
                    if IsPedInAnyVehicle(myped) then
                        local this_vehicle = GetVehiclePedIsUsing(myped)
                        DeleteEntity(this_vehicle)
                    end
                end
                DrawMarker(MarkerType[_], point.x, point.y, point.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, MarkerSize[_], 135, 128, 19, 150, false, true, 2, false, false, false, false)
                DrawMarker(1, point.x, point.y, point.z - 50, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 350.0, 350.0, 500.0, Color[_].r, Color[_].g, Color[_].b, 255, false, true, 2, false, false, false, false)
                DrawMarker(1, point.x, point.y, point.z - 50, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 350.0, 350.0, 500.0, Color[_].r, Color[_].g, Color[_].b, 255, false, true, 2, false, false, false, false)
            end

            Wait(1)
        end
    end)
end

function spawncar()
    local modelName = car
    local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))
    local modelHash = model
    modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
    end

    vehicle = CreateVehicle(model, GetEntityCoords(myped), GetEntityHeading(myped), false, false)
    table.insert(all_vehicle_spawned, vehicle)
    local networkId = NetworkGetNetworkIdFromEntity(vehicle)
    SetNetworkIdCanMigrate(networkId, true)	SetEntityAsMissionEntity(vehicle, true, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehRadioStation(vehicle, 'OFF')
    SetModelAsNoLongerNeeded(model)
    SetVehicleEngineOn(vehicle, true, true, true)
    SetVehicleJetEngineOn(vehicle, true)
    while not DoesEntityExist(vehicle) do
        Wait(1000)
    end
    TaskWarpPedIntoVehicle(myped, vehicle, -1)
end

function alert(msg)
	SetTextComponentFormat("STRING")
	AddTextComponentString(msg)
	DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function CheckCapturing(point,_)
    Citizen.CreateThread(function()
        while CaptureIsActive and inCapture do 
            local playerPed = myped
            local coords    = GetEntityCoords(playerPed)

            Wait(1000)
            if not Captured[_] then
                if GetDistanceBetweenCoords(coords, point, true) < 1.5 then
                    Color[_] = {r = 255, g = 255, b = 255}
                    if MarkerType[_] == 19 then
                        Captured[_]   = true
                        TriggerServerEvent('capture:CaptureMe',_)
                    elseif MarkerType[_] == 1 then
                        MarkerSize[_] = 1.5
                        MarkerType[_] = 10
                    elseif MarkerType[_] < 19 then
                        MarkerType[_] = MarkerType[_] + 1
                    end
                elseif MarkerType[_] ~= 1 and MarkerType[_] ~= 28 then
                    MarkerSize[_] = 100.5
                    Color[_] = {r = 0, g = 0, b = 0}
                    MarkerType[_] = 1
                end
            end
        end
    end)
end

function GetEntityHeadingToCoord(coords, pos)
    local dx = coords.x - pos.x
    local dy = coords.y - pos.y

    return GetHeadingFromVector_2d(dx, dy)
end

function string:split(delimiter)
	local result = { }
	local from  = 1
	local delim_from, delim_to = string.find(self, delimiter, from)
	while delim_from do
	  	table.insert(result, string.sub(self, from , delim_from-1))
	  	from  = delim_to + 1
	  	delim_from, delim_to = string.find(self, delimiter, from)
	end
	table.insert(result, string.sub(self, from))
	return result
end


--Edit AliReza

function StartSecuringArea(point,_)
    Citizen.CreateThread(function()
        while CaptureIsActive and inCapture do
            Citizen.Wait(1000)

            local playerPed = myped
            local coords = GetEntityCoords(playerPed)
            if GetDistanceBetweenCoords(coords, point, false) <= 175.0 then
                if IsPedInAnyVehicle(myped, false) then
                    local vehicle = GetVehiclePedIsIn(myped, false)
                    if GetVehicleClass(vehicle) ~= 15 then
                        local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
                        local ReallyVP = plate:gsub(" ", "")
                        local vehiclePlateMatch = ReallyVP:match('%D+')
                        local vehiclePlateSplit = ReallyVP:split('%D+')
                        if not (ReallyVP and #ReallyVP == 8 and vehiclePlateMatch and #vehiclePlateMatch == 4 and vehiclePlateSplit and #vehiclePlateSplit == 2 and #vehiclePlateSplit[2] == 4 and type(tonumber(vehiclePlateSplit[2])) == 'number') then
                            TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, true)
                        end

                        ESX.Game.DeleteVehicle(vehicle)
                    end
                end
                    if not InCaptureZone[_] then
                        InCaptureZone[_] = true
                        TriggerEvent('capture:inCapture', true)
                        -- FristPersonView()
                    end
            else
                if InCaptureZone[_] then
                    InCaptureZone[_] = false
                    TriggerEvent('capture:inCapture', false)
                else
                    lastcoord = coords
                end
            end
        end
        TriggerEvent('capture:inCapture', false)
    end)
end


function Teleport(point,_)
    Citizen.CreateThread(function()
        while CaptureIsActive do
            Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(myped), point, false) <= 175.0 then
                HasEntered[_] = true
            else
                if HasEntered[_] then
                    SetEntityCoords(myped, repoint.x+math.random(-10,10),repoint.y+math.random(-10,10),repoint.z)
					-- TriggerEvent('es_admin:freezePlayer', true)
					-- Citizen.Wait(4000)
					-- TriggerEvent('es_admin:freezePlayer', false)					
                    HasEntered[_] = false
                    Wait(1000)
                    spawncar()
                end
            end
        end
    end)
end



RegisterNetEvent('capture:LetSuitUp')
AddEventHandler('capture:LetSuitUp', function()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback('esx_skin:getGangSkin', function(skin, gangSkin)
            if skin.sex == 0 then
              TriggerEvent('skinchanger:loadClothes', skin, gangSkin.skin_male)
            else
              TriggerEvent('skinchanger:loadClothes', skin, gangSkin.skin_female)
            end
        --   SetPedArmour(myped, 0)
      end)
    end)

end)

RegisterNetEvent('capture:getscore')
AddEventHandler('capture:getscore', function(kills)
    if PlayerData.gang.name ~= "nogang" then
        for k, v in ipairs(kills) do
            if v.source == GetPlayerServerId(PlayerId()) then
                yourkill = v.killcount
                break
            end
        end
        SendNUIMessage({
            kill      = true,
            killlist    = kills
        })
    end
end)


AddEventHandler("setAlirezaarmorfull",function()
    local ped = GetPlayerPed(-1)
    SetPedArmour(ped, 100) 
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
        local clothesSkin = {
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        elseif skin.sex == 1 then
        local clothesSkin = {
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
    end)
end)



Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(2)
        if inCapture then
            SetTextFont(4)
            SetTextProportional(3)
            SetTextScale(2.7, 0.5)
            SetTextColour(528, 128, 128, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString("~r~Your Kill : ~w~[~r~"..math.floor(killl).."~w~]")
            DrawText(0.100, 0.745)
        end
	end
end)




RegisterNetEvent('capture:addkil')
AddEventHandler('capture:addkil', function(melika)
    killl = killl + 1 
end)

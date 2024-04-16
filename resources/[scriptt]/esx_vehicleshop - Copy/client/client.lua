local lastSelectedVehicleEntity
local startCountDown
local testDriveEntity
local lastPlayerCoords
local hashListLoadedOnMemory = {}

local inTheShop = false
local profileName
local profileMoney

ESX                           = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local c1 = math.random(1, 255)
local c2 = math.random(1, 255)
local c3 = math.random(1, 255)
local rgbColorSelected = {
    c1,c2,c3,
}

local rgbSecondaryColorSelected = {
    255,255,255,
}

local vehicleshopCoords = {
    vector3(-38.26, -1098.23, 26.42),
}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3)
            local ped = PlayerPedId()
            for i = 1, #vehicleshopCoords do
            local actualShop = vehicleshopCoords[i]
            local dist = #(actualShop - GetEntityCoords(ped))
                if dist <= 50.0 then                    
                    if dist <= 2.0 then                 
                        DrawText3Ds(actualShop.x, actualShop.y, actualShop.z,"E Open car shop")
                    end
                    DrawMarker(23, actualShop.x, actualShop.y, actualShop.z - 0.97, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.7, 200, 10, 10, 100, 0, 0, 0, 0, 0, 0, 0)
                    if dist <= 2.0 then
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent('OW:Whitelist',
                            1, ---ban type
                            true --- state of that
                            )

                            ESX.TriggerServerCallback('AT_Quest:Cheklevel', function(bool)
                                if  bool then
                                    Wait(100)
                                    OpenVehicleShop()
                                else
                                    ESX.ShowNotification("Baray Kharid Mashin Level Shoma Bayad Az 3 Bishtar Bashad.")
                                    CancelEvent()
                                end
                            end, 3) 

                        end
                    end
                end
            end
        end
    end
)


RegisterNetEvent('vehicleshop.receiveInfo')
AddEventHandler('vehicleshop.receiveInfo', function(bank, name)
    if name then
        profileName = name
    end
    profileMoney = bank
end)




RegisterNetEvent('vehicleshop.sussessbuy')
AddEventHandler('vehicleshop.sussessbuy', function(vehicleName,vehiclePlate,value)    
    SendNUIMessage(
        {
            type = "sussess-buy",
            vehicleName = vehicleName,
            vehiclePlate = vehiclePlate,
            value = value
        }
    )       
    CloseNui()
end)

RegisterNetEvent('vehicleshop.notify')
AddEventHandler('vehicleshop.notify', function(type, message)    
    SendNUIMessage(
        {
            type = "notify",
            typenotify = type,
            message = message,
        }
    ) 
end)

local vehiclesTable = {}

local provisoryObject = {}

RegisterNetEvent('vehicleshop.vehiclesInfos')
AddEventHandler('vehicleshop.vehiclesInfos', function(tableVehicles)      

    for _,value in pairs(tableVehicles) do
        vehiclesTable[value.category] = {}
    end

    for _,value in pairs(tableVehicles) do

        local vehicleModel = GetHashKey(value.model)
        local brandName

        if Config.Build2060 then
            brandName = GetLabelText(Citizen.InvokeNative(0xF7AF4F159FF99F97, vehicleModel, Citizen.ResultAsString()))    
        else
            brandName = nil
        end

        if brandName == nil then
            brandName = 'Custom'
        end    

        local vehicleName   

        if GetLabelText(value.model) == "NULL" then
            vehicleName = value.model:gsub("^%l", string.upper)
        else 
            vehicleName = GetLabelText(value.model)
        end

        provisoryObject = 
        {
            brand = brandName,
            name = vehicleName,
            price = value.price,
            coin = (value.price/20000)*1.0,
            model = value.model,
            qtd = 1
        }
        table.insert(vehiclesTable[value.category], provisoryObject)
    end
end)

function OpenVehicleShop()
    inTheShop = true
    local ped = PlayerPedId()
    SetWeatherAndTime(false)
    TriggerServerEvent("vehicleshop.requestInfo")

    Citizen.Wait(1000)

    SendNUIMessage(
        {
            data = vehiclesTable,
            type = "display",
            playerName = profileName,
            playerMoney = profileMoney,
            testDrive = Config.TestDrive
        }
    )

    SetNuiFocus(true, true)

    RequestCollisionAtCoord(x, y, z)

    --SetEntityVisible(ped, false, 0)
    --SetEntityCoords(ped, 404.90, -949.58, -99.71, 0, 0, 0, false)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -216.839, -1324.06, 30.890, 252.063, 15.0, 20.1, 70.00, false, 0)
    PointCamAtCoord(cam, -211.166, -1323.37, 30.890)

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1, true, true)
        
    SetFocusPosAndVel(-216.839, -1324.06, 30.890, 0.0, 0.0, 0.0)

    DisplayHud(false)
    DisplayRadar(false)

    Citizen.CreateThread(function()
        while inTheShop do
            Citizen.Wait(240000)     
            if inTheShop then
                SetWeatherAndTime(false)
            end
        end
    end)


    while inTheShop do 
        TriggerEvent('vehicleshop.notify', 'Press Enter to buy')     
        Citizen.Wait(5000)
   --    DrawLightWithRange(404.99, -949.60, -98.98, 255, 255, 255, 20.000, 100.000)
    end

    if lastSelectedVehicleEntity ~= nil then
        if DoesEntityExist(lastSelectedVehicleEntity) then
            DeleteEntity(lastSelectedVehicleEntity)
        end
    end


end

function updateSelectedVehicle(model)
    local hash = GetHashKey(model)

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end

    if lastSelectedVehicleEntity ~= nil then
        if DoesEntityExist(lastSelectedVehicleEntity) then
            DeleteEntity(lastSelectedVehicleEntity)
        end
    end
  --  lastSelectedVehicleEntity = CreateVehicle(hash, 404.99, -949.60, -99.98, 50.117, 0, 1)
    
  lastSelectedVehicleEntity = CreateVehicle(hash, -211.166, -1323.37, 30.890, 176.34, 0, 1)
  SetVehicleCustomPrimaryColour(lastSelectedVehicleEntity,  rgbColorSelected[1], rgbColorSelected[2], rgbColorSelected[3])
  SetVehicleCustomSecondaryColour(lastSelectedVehicleEntity,  rgbSecondaryColorSelected[1], rgbSecondaryColorSelected[2], rgbSecondaryColorSelected[3])


    local vehicleData = {}

    
    vehicleData.traction = GetVehicleMaxTraction(lastSelectedVehicleEntity)


    vehicleData.breaking = GetVehicleMaxBraking(lastSelectedVehicleEntity) * 0.9650553    
    if vehicleData.breaking >= 1.0 then
        vehicleData.breaking = 1.0
    end

    vehicleData.maxSpeed = GetVehicleEstimatedMaxSpeed(lastSelectedVehicleEntity) * 0.9650553
    if vehicleData.maxSpeed >= 50.0 then
        vehicleData.maxSpeed = 50.0
    end

    vehicleData.acceleration = GetVehicleAcceleration(lastSelectedVehicleEntity) * 2.6
    if  vehicleData.acceleration >= 1.0 then
        vehicleData.acceleration = 1.0
    end


    SendNUIMessage(
        {
            data = vehicleData,
            type = "updateVehicleInfos",        
        }
    )


    SetEntityHeading(lastSelectedVehicleEntity, 89.5)
end


function rotation(dir)
    local entityRot = GetEntityHeading(lastSelectedVehicleEntity) + dir
    SetEntityHeading(lastSelectedVehicleEntity, entityRot % 360)
end

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



local player = PlayerPedId()
local inside = false



function DrawText3DTest(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

         

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

     

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end



function CamTrunk()
    if(not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
        SetCamRot(cam, 0.0, 0.0, 0.0)
        SetCamActive(cam,  true)
        RenderScriptCams(true,  false,  0,  true,  true)
        SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
    end

    AttachCamToEntity(cam, PlayerPedId(), 0.0,-2.5,1.0, true)
    SetCamRot(cam, -30.0, 0.0, GetEntityHeading(PlayerPedId()) )
end



local offsets = {
    [1] = { ["name"] = "vic", ["yoffset"] = 0.0, ["zoffset"] = -0.5 },
    [2] = { ["name"] = "taxi", ["yoffset"] = 0.0, ["zoffset"] = -0.5 },
    [3] = { ["name"] = "buccaneer", ["yoffset"] = 0.5, ["zoffset"] = 0.0 },
    [4] = { ["name"] = "peyote", ["yoffset"] = 0.35, ["zoffset"] = -0.15 },
    [5] = { ["name"] = "regina", ["yoffset"] = 0.2, ["zoffset"] = -0.35 },
    [6] = { ["name"] = "pigalle", ["yoffset"] = 0.2, ["zoffset"] = -0.15 },
    [7] = { ["name"] = "glendale", ["yoffset"] = 0.0, ["zoffset"] = -0.35 },
}



RegisterCommand('bgir', function()
    player = PlayerPedId()
    local plyCoords = GetEntityCoords(player, false)
    local lockStatus = GetVehicleDoorLockStatus(vehicle)
    coordA = GetEntityCoords(player, 1)
    coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, 100.0, 0.0)
    vehicle = getVehicleInDirection(coordA, coordB)
    local OffSet = TrunkOffset(vehicle)
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and not inside and GetVehiclePedIsIn(player, false) == 0 then
        if lockStatus == 4 or lockStatus == 2 then
            TriggerEvent("notification","vehicle locked.", 2)

        elseif GetVehicleDoorAngleRatio(vehicle, 5) ~= 0.0 then
            inside = true
            local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))
            if OffSet > 0 then
                AttachEntityToEntity(player, vehicle, 0, -0.1,(d1["y"]+0.85) + offsets[OffSet]["yoffset"],(d2["z"]-0.87) + offsets[OffSet]["zoffset"], 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
            else
                AttachEntityToEntity(player, vehicle, 0, -0.1,d1["y"]+0.85,d2["z"]-0.87, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
            end
            local testdic = "fin_ext_p1-7"
            local testanim = "cs_devin_dual-7"
            SetBlockingOfNonTemporaryEvents(player, true)  
            SetPedSeeingRange(player, 0.0)  
               SetPedHearingRange(player, 0.0)    
            SetPedFleeAttributes(player, 0, false)  
            SetPedKeepTask(player, true)
            ClearPedTasks(player)
            RequestAnimDict('fin_ext_p1-7')
            while not HasAnimDictLoaded('fin_ext_p1-7') do
                Citizen.Wait(100)
            end

            TaskPlayAnim(player, testdic, testanim, 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
            if not (IsEntityPlayingAnim(player, 'fin_ext_p1-7', 'cs_devin_dual-7', 3) == 1) then
                Streaming('fin_ext_p1-7', function()
                    TaskPlayAnim(player, 'fin_ext_p1-7', 'cs_devin_dual-7', 1.0, -1, -1, 49, 0, 0, 0, 0)
                end)
            end

            SetVehicleDoorShut(vehicle, 5, false)
            while inside do
                Citizen.Wait(1)
                CamTrunk()
                car = GetEntityAttachedTo(player)
                carxyz = GetEntityCoords(car, 0)
                   local visible = true
                   DisableAllControlActions(0)
                   DisableAllControlActions(1)
                DisableAllControlActions(2)
                EnableControlAction(0, Keys['F'], true)
                   EnableControlAction(0, 0, true)
                   EnableControlAction(0, 249, true)
                   EnableControlAction(2, 1, true)
                   EnableControlAction(2, 2, true)
                   EnableControlAction(0, 177, true)
                EnableControlAction(0, 200, true)
                local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))
                local DropPosition = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,d1["y"]-0.2,0.0)
                if DropPosition["x"] == 0.0 then
                    local vehCoords = GetEntityCoords(PlayerPedId())
                    DrawText3DTest(vehCoords.x, vehCoords.y, vehCoords.z, "[G] Open  / close | [F] Get out")
                else
                    DrawText3DTest(DropPosition["x"],DropPosition["y"],DropPosition["z"],"[G] Open  / close | [F] Get out")
                end

                 

             



                if IsDisabledControlJustReleased(0,47) then
                    if GetVehicleDoorAngleRatio(vehicle, 5) > 0.0 then
                        SetVehicleDoorShut(vehicle, 5, 1, true)            
                    else
                        SetVehicleDoorOpen(vehicle, 5, 1, true)
                        Citizen.Wait(500)
                        SetVehicleDoorOpen(vehicle, 5, 1, true)
                    end
                end

                 

             

                    if IsControlJustReleased(0,23) then
                    DetachEntity(player)
                    ClearPedTasks(player)
                    CamDisable()
                    inside = false    
                       ClearAllHelpMessages()
                end
            end

            DoScreenFadeOut(10)
               Citizen.Wait(1000)
            CamDisable()
            DetachEntity(player)

            if DoesEntityExist(vehicle) then
                TriggerEvent('OW:Whitelist',
                6, ---ban type
                true --- state of that
                )
                local DropPosition = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,d1["y"]-0.5,0.0)
                SetEntityCoords(player,DropPosition["x"],DropPosition["y"],DropPosition["z"])
            end
            SetVehicleDoorOpen(vehicle, 5, false)
            DoScreenFadeIn(2000)
            Wait(2000)
            TriggerEvent('OW:Whitelist',
            6, ---ban type
            false --- state of that
            )
        else
            TriggerEvent("notification","closed.", 2)
        end
    end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/bgir', 'Command used to enter the trunk of the vehicle.')
end)



function TrunkOffset(veh)
    for i=1,#offsets do
        if GetEntityModel(veh) == GetHashKey(offsets[i]["name"]) then
            return i
        end
    end
    return 0
end



function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle


    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1

        if vehicle ~= 0 then break end
    end

 

    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end



function Streaming(animDict, cb)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)



        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(1)
        end
    end



    if cb ~= nil then
        cb()
    end
end



isInTrunk = function()
    if inside == true then
        return true
    elseif inside == false then
        return false
    end
end



function CamDisable()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end

Citizen.CreateThread(function()
    while true do
        player = PlayerPedId()
        local plyCoords = GetEntityCoords(player, false)
        local lockStatus = GetVehicleDoorLockStatus(vehicle)
        coordA = GetEntityCoords(player, 1)
        coordB = GetOffsetFromEntityInWorldCoords(player, 0.0, 100.0, 0.0)
        vehicle = getVehicleInDirection(coordA, coordB)
        Citizen.Wait(500)
        if IsControlJustReleased(0,Keys['H']) then
            if DoesEntityExist(vehicle) then
            if IsVehicleSeatFree(vehicle,-1) then
            local clstveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, 0, 70)
            if GetVehicleDoorAngleRatio(clstveh, 5) > 0.9 then
                    SetVehicleDoorShut(clstveh, 5)
            else
                SetVehicleDoorOpen(clstveh, 5)
            end
        else
            ESX.ShowNotification('You cannot open the trunk while someone is in the vehicle.')
        end
    end

        end
end
end)

function VehicleInFront()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 6.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result

end

RegisterNUICallback(
    "rotate",
    function(data, cb)
        if (data["key"] == "left") then
            rotation(2)
        else
            rotation(-2)
        end
        cb("ok")
    end
)


RegisterNUICallback(
    "SpawnVehicle",
    function(data, cb)
        updateSelectedVehicle(data.modelcar)
    end
)



RegisterNUICallback(
    "RGBVehicle",
    function(data, cb)
        if data.primary then
            rgbColorSelected = data.color
            SetVehicleCustomPrimaryColour(lastSelectedVehicleEntity, math.ceil(data.color[1]), math.ceil(data.color[2]), math.ceil(data.color[3]) )
        else
            rgbSecondaryColorSelected = data.color
            SetVehicleCustomSecondaryColour(lastSelectedVehicleEntity, math.ceil(data.color[1]), math.ceil(data.color[2]), math.ceil(data.color[3]))
        end
    end
)

RegisterNUICallback(
    "Buy",
    function(data, cb)

        local newPlate     = GeneratePlate()
        SetVehicleCustomPrimaryColour(lastSelectedVehicleEntity,  math.ceil(rgbColorSelected[1]), math.ceil(rgbColorSelected[2]), math.ceil(rgbColorSelected[3]))
        SetVehicleCustomSecondaryColour(lastSelectedVehicleEntity,  math.ceil(rgbSecondaryColorSelected[1]), math.ceil(rgbSecondaryColorSelected[2]), math.ceil(rgbSecondaryColorSelected[3]))
        local vehicleProps = ESX.Game.GetVehicleProperties(lastSelectedVehicleEntity)
        vehicleProps.plate = newPlate

        TriggerServerEvent('vehicleshop.CheckMoneyForVeh',data.modelcar, data.sale, data.name, vehicleProps)

        Wait(1500)        
        -- SendNUIMessage(
        --     {
        --         type = "updateMoney",
        --         playerMoney = profileMoney
        --     }
        -- )
    end
)
RegisterNUICallback(
    "Buy2",
    function(data, cb)

        local newPlate     = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(lastSelectedVehicleEntity)
        vehicleProps.plate = newPlate

        TriggerServerEvent('vehicleshop.CheckbtcForVeh',data.modelcar, data.sale, data.name, vehicleProps)

        Wait(1500)        
        -- SendNUIMessage(
        --     {
        --         type = "updateMoney",
        --         playerMoney = profileMoney
        --     }
        -- )
    end
)



RegisterNetEvent('vehicleshop.spawnVehicle')
AddEventHandler('vehicleshop.spawnVehicle', function(model, plate)    
    local hash = GetHashKey(model)

    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    
    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end
    pos = {x = -11.87, y = -1080.87, z = 25.71}
    -- local vehicleBuy = CreateVehicle(hash, -11.87, -1080.87, 25.71, 132.0, 1, 1)
    ESX.Game.SpawnVehicle(
        hash,
        pos,
        132.0,
        function(vehicle)
            local vehicleBuy = vehicle
            SetPedIntoVehicle(PlayerPedId(), vehicleBuy, -1)
            TriggerServerEvent('garage:addKeys', plate)
            
            SetVehicleNumberPlateText(vehicleBuy, plate)

            Wait(1000)
            SetVehicleCustomPrimaryColour(vehicleBuy,  math.ceil(rgbColorSelected[1]), math.ceil(rgbColorSelected[2]), math.ceil(rgbColorSelected[3]))
            SetVehicleCustomSecondaryColour(vehicleBuy,  math.ceil(rgbSecondaryColorSelected[1]), math.ceil(rgbSecondaryColorSelected[2]), math.ceil(rgbSecondaryColorSelected[3]))
            local vehicleProps = ESX.Game.GetVehicleProperties(vehicleBuy)
            TriggerServerEvent('vehicleshop.upcolor', plate, vehicleProps)
    end)
    

end)




RegisterNUICallback(
    "TestDrive",
    function(data, cb)        
        if Config.TestDrive then
            startCountDown = true
            TriggerServerEvent('vehicleshop.test', 'start')
            local hash = GetHashKey(data.vehicleModel)

            lastPlayerCoords = GetEntityCoords(PlayerPedId())

            if not HasModelLoaded(hash) then
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Citizen.Wait(10)
                end
            end
        
            if testDriveEntity ~= nil then
                if DoesEntityExist(testDriveEntity) then
                    DeleteEntity(testDriveEntity)
                end
            end
        
            testDriveEntity = CreateVehicle(hash, -11.87, -1080.87, 25.71, 132.0, 0, 0)
            SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
            local timeGG = GetGameTimer()

            
           SetVehicleCustomPrimaryColour(testDriveEntity,  math.ceil(rgbColorSelected[1]), math.ceil(rgbColorSelected[2]), math.ceil(rgbColorSelected[3]))
           SetVehicleCustomSecondaryColour(testDriveEntity,  math.ceil(rgbSecondaryColorSelected[1]), math.ceil(rgbSecondaryColorSelected[2]), math.ceil(rgbSecondaryColorSelected[3]))

            CloseNui()

            while startCountDown do
                local countTime
                Citizen.Wait(1)
                if GetGameTimer() < timeGG+tonumber(1000*Config.TestDriveTime) then
                    local secondsLeft = GetGameTimer() - timeGG
                    drawTxt(_U('testdrive') .. math.ceil(Config.TestDriveTime - secondsLeft/1000).."s",4,0.1,0.2,0.50,245,64,255,200)
                else
                    DeleteEntity(testDriveEntity)
                    TriggerEvent('OW:Whitelist',
                    6, ---ban type
                    true --- state of that
                    )
                    SetEntityCoords(PlayerPedId(), lastPlayerCoords)
                    startCountDown = false
                    Wait(2000)
                    TriggerEvent('OW:Whitelist',
                    6, ---ban type
                    false --- state of that
                    )
                end
            end 
            TriggerServerEvent('vehicleshop.test', 'finish')       
        end
    end
)

SetWeatherAndTime = function(syncTime)
    if not syncTime then
      TriggerEvent('vSync:toggle',false)
      SetRainFxIntensity(0.0)
      SetBlackout(false)
      ClearOverrideWeather()
      ClearWeatherTypePersist()
      SetWeatherTypePersist('CLEAR')
      SetWeatherTypeNow('CLEAR')
      SetWeatherTypeNowPersist('CLEAR')
      NetworkOverrideClockTime(23,0,0)
    else
        TriggerEvent('vSync:toggle',true)
        TriggerServerEvent('vSync:requestSync')
    end
  end

RegisterNUICallback(
    "menuSelected",
    function(data, cb)
        local categoryVehicles

        local playerIdx = GetPlayerFromServerId(source)
        local ped = GetPlayerPed(playerIdx)
        
        if data.menuId ~= 'all' then
            categoryVehicles = vehiclesTable[data.menuId]
        else
            SendNUIMessage(
                {
                    data = vehiclesTable,
                    type = "display",
                    playerName = GetPlayerName(ped)
                }
            )
            return
        end

        SendNUIMessage(
            {
                data = categoryVehicles,
                type = "menu"
            }
        )
    end
)


RegisterNUICallback(
    "Close",
    function(data, cb)
        CloseNui()       
    end
)

function CloseNui()
    SendNUIMessage(
        {
            type = "hide"
        }
    )
    SetNuiFocus(false, false)
    if inTheShop then
        if lastSelectedVehicleEntity ~= nil then
            if DoesEntityExist(testDriveEntity) then
                DeleteVehicle(lastSelectedVehicleEntity)
            end
        end
        RenderScriptCams(false)
        DestroyAllCams(true)
        SetWeatherAndTime(true)
        SetFocusEntity(GetPlayerPed(PlayerId())) 
        DisplayHud(true)
        DisplayRadar(true)
        TriggerEvent('OW:Whitelist',
        1, ---ban type
        false --- state of that
        )
    end
    inTheShop = false
end

-- function CloseNui()
--     SendNUIMessage(
--         {
--             type = "hide"
--         }
--     )
--     SetNuiFocus(false, false)

--     if inTheShop then
--         if lastSelectedVehicleEntity ~= nil then
--             DeleteEntity(lastSelectedVehicleEntity)
--         end

--         local  = PlayerPedId()
--     --  SetEntityVisible(ped, true, 0)        
--     --  SetEntityCoords(ped, -44.80, -1097.82, 26.42, 0, 0, 0, false)        
--         RenderScriptCams(false)
--         DestroyAllCams(true)
--         ClearFocus()
--         DisplayHud(true)
--         DisplayRadar(true)
--     end

--     inTheShop = false
-- end


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end


local blip 

-- Create Blips
Citizen.CreateThread(function ()

    for i = 1, #vehicleshopCoords do    
        local actualShop = vehicleshopCoords[i]
        blip = AddBlipForCoord(actualShop.x, actualShop.y, actualShop.z)

        SetBlipSprite (blip, 326)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('car_dealer'))
        EndTextCommandSetBlipName(blip)
end)

AddEventHandler("onResourceStop",function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CloseNui()
        RemoveBlip(blip)
    end
end)


Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)

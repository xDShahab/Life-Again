local vehicle = nil
local isDriver = false
local fTractionLossMult = nil
local isModed = false
local class = nil
local isBlacklisted = false

local classMod = {
    [0]= 3.51, -- Compacts 
    [1] = 3.51, --Sedans
    [2] = 3.51, --SUVs
    [3] = 3.51, --Coupes
    [4] = 3.501, --Muscle
    [5] = 3.51, --Sports Classics
    [6] = 3.51, --Sports
    [7] = 3.51, --Super  
    [8] = 1.51, --Motorcycles  
    [9] = 0, --Off-road
    [10] = 0, --Industrial
    [11] = 0, --Utility
    [12] = 3.51, --Vans  
    [13] = 0, --Cycles  
    [14] = 0, --Boats  
    [15] = 0, --Helicopters  
    [16] = 0, --Planes  
    [17] = 0, --Service  
    [18] = 3.51, --Emergency  
    [19] = 3.51, --Military  
    [20] = 3.51, --Commercial  
    [21] = 0 --Trains  
}

local blackListed = {
    -1705304628, -- "Rubble"
    -2137348917, -- "Phantom"
    -1453280962,--"sanchez2"
    1753414259, --"enduro"
    2035069708,--"esskey"
    86520421,--"bf400"
    -488123221,--"predator"
    353883353,--"polmav"
}

Citizen.CreateThread(function()
    while true do 
        local ped = GetPlayerPed(-1)      
        if IsPedInAnyVehicle(ped, false) then
            if vehicle == nil then
                vehicle = GetVehiclePedIsUsing(ped)
                if GetPedInVehicleSeat(vehicle, -1) == ped then
                    isDriver = true
                    if DecorExistOn(vehicle, 'fTractionLossMult') then
                        fTractionLossMult = DecorGetFloat(vehicle, 'fTractionLossMult')
                        --print("Existe valor por defecto: "..fTractionLossMult)
                    else
                        fTractionLossMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionLossMult')
                        DecorRegister('fTractionLossMult', 1)
                        DecorSetFloat(vehicle,'fTractionLossMult', fTractionLossMult)
                        --print("Se crea valor por defecto: "..fTractionLossMult)
                    end
                    class = GetVehicleClass(vehicle)
                    isBlacklisted = isModelBlacklisted(GetEntityModel(vehicle))
                end
            end
        else
            if vehicle ~= nil then
                if DoesEntityExist(vehicle) then
                    setTractionLost (fTractionLossMult)
                end
                Citizen.Wait(1000)
                vehicle = nil
                isDriver = false
                fTractionLossMult = nil
                isModed = false
                class = nil
                isBlacklisted = false
            end
        end
        Citizen.Wait(2000)
    end
end)

Citizen.CreateThread(function()
    while true do 
        if isBlacklisted == false then     
            if vehicle ~= nil and isDriver == true  then
                local speed = GetEntitySpeed(vehicle)*3.6
                if not pointingRoad(vehicle) then
                    if groundAsphalt() or speed <= 35.0 then
                        if isModed == true then
                            isModed = false
                            setTractionLost (fTractionLossMult)
                        end
                    else
                        if isModed == false and speed > 35.0 then
                            isModed = true
                            setTractionLost (fTractionLossMult + classMod[class])
                        end
                    end
                else
                    if isModed == true then
                        isModed = false
                        setTractionLost (fTractionLossMult)
                    end
                end
            end
        end
        Citizen.Wait(500)
    end
end)

function setTractionLost (value)
    if isBlacklisted == false and vehicle ~= nil and value ~= nil then
        SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionLossMult', value)
        print("fTractionLossMult: "..value)
    end
end

function isModelBlacklisted(model)
    local found = false
    for i = 1, #blackListed do
        if blackListed[i] == model then
            found = true
            break
        end
    end
    return found
end

function groundAsphalt()
    local ped = PlayerPedId()

    local playerCoord = GetEntityCoords(ped)
    local target = GetOffsetFromEntityInWorldCoords(ped, vector3(0,2,-3))
    local testRay = StartShapeTestRay(playerCoord, target, 17, ped, 7) -- This 7 is entirely cargo cult. No idea what it does.
    local _, hit, hitLocation, surfaceNormal, material, _ = GetShapeTestResultEx(testRay)

    if hit then
        --print (material)
        if material == 282940568 then
            return true
        else
            return false
        end
    else
        return false
    end
end

function pointingRoad(veh)
    local pos = GetEntityCoords(veh, true)
    if IsPointOnRoad(pos.x,pos.y,pos.z-1,false) then
        return true
    end 
    local pos2 = GetOffsetFromEntityInWorldCoords(veh, 1.5, 0, 0)
    local pos3 = GetOffsetFromEntityInWorldCoords(veh, -1.5, 0, 0)
    if IsPointOnRoad(pos2.x,pos2.y,pos2.z-1,false) then
        return true
    end
    if IsPointOnRoad(pos3.x,pos3.y,pos3.z,false) then 
        return true
    end
    return false
end






function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayWeapon(weapon,distance,flag)
    local cameraRotation = GetGameplayCamRot()
    
    local weapCoord = GetEntityCoords(weapon)

    local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =  vector3(cameraCoord.x + direction.x * distance, 
		cameraCoord.y + direction.y * distance, 
		cameraCoord.z + direction.z * distance 
    )
    if not flag then
        flag = 1
    end
   
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(weapCoord.x, weapCoord.y, weapCoord.z, destination.x, destination.y, destination.z, flag, -1, 1))
	return b, c, e, destination
end

function RayCastGamePlayCamera(weapon,distance,flag)
    local cameraRotation = GetGameplayCamRot()
    
    local weapCoord = GetEntityCoords(weapon)

    local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =  vector3(cameraCoord.x + direction.x * distance, 
		cameraCoord.y + direction.y * distance, 
		cameraCoord.z + direction.z * distance 
    )
    if not flag then
        flag = 1
    end

	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, flag, -1, 1))
	return b, c, e, destination
end

Citizen.CreateThread(function()
    local ped, weapon, pedid, sleep, shoot
    while true do
         sleep = 500 
         pedid = PlayerId()
         ped = PlayerPedId()
         weapon = GetCurrentPedWeaponEntityIndex(ped)
        
        if weapon > 0 and IsPlayerFreeAiming(pedid) then
            local hitW, coordsW, entityW = RayCastGamePlayWeapon(weapon, 15.0,1)
            local hitC, coordsC, entityC = RayCastGamePlayCamera(weapon, 1000.0,1)
            if hitW > 0 and entityW > 0 and math.abs(#coordsW-#coordsC) > 1 then
                sleep = 0
                Draw3DTextt(coordsW.x, coordsW.y, coordsW.z, '❌')
                DisablePlayerFiring(ped,true) 
                DisableControlAction(0, 106, true) 
            end
        else
            Citizen.Wait(1000)
        end    
        Citizen.Wait(sleep)
    end
end)

function Draw3DTextt(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    if onScreen then
        SetTextScale(0.3, 0.3)
        SetTextFont(0)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
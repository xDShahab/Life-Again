
local inzone = 0
local Disable = true
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)




local zones = {
    {coords = vector3(-652.3724, -2393.6082, 13.9568) ,radius = 70}, -- Mechanic  
    {coords = vector3(414.08,-991.07,29.41) ,radius = 70}, -- Lspd
    {coords = vector3(1529.26,815.52,77.43) ,radius = 70}, -- Sheriff
}


Citizen.CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
    while true do 
        for k = 1 , #zones , 1 do
            local distance = Vdist(GetEntityCoords(PlayerPedId()),zones[k].coords)
            if distance < zones[k].radius and inzone == 0 then
                inzone = k
            elseif inzone == k and (distance > zones[k].radius) then
                endzone()
            end
            Wait(10)
        end

        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        if inzone ~= 0 then
            Wait(1)
            if Disable then
                DisableControlAction(0, 45, true)
            end
            if GetVehiclePedIsIn(PlayerPedId()) ~= 0 and GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId())) > 10.0 and not IsPedInAnyHeli(PlayerPedId()) then
                SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId()),15.0)
            end
        else
            Wait(1000)
        end
    end
end)

function endzone()
    inzone = 0 
    Wait(1000)
    if GetVehiclePedIsIn(PlayerPedId()) ~= 0 then
        maxSpeed = GetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId()),"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId()),maxSpeed)
    end
end

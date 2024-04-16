
local passengerDriveBy = true


-- No Drive By

--[[
Citizen.CreateThread(function()

	while true do
	
		Wait(500)
		
		

		playerPed = GetPlayerPed(-1)
		
		car = GetVehiclePedIsIn(playerPed, false)
		
		if car then
		
			if GetPedInVehicleSeat(car, -1) == playerPed then
			
				SetPlayerCanDoDriveBy(PlayerId(), false)
				
			elseif passengerDriveBy then
			
				SetPlayerCanDoDriveBy(PlayerId(), true)
			else
			
				SetPlayerCanDoDriveBy(PlayerId(), false)
				
			end
			
		end
		
	end
	
end)
]]



Citizen.CreateThread(function()

	while true do
	
		Citizen.Wait(5) -- A Short Daily of 5 MS
		
		if IsPedArmed(GetPlayerPed(-1), 6) then
		
			DisableControlAction(0, 140, true) -- Disable the Light Dmg Contr ol
			
			DisableControlAction(1, 141, true)
			
			DisableControlAction(1, 142, true)
			
		end
		
	end
	
end)



local crouched = false
local isPressing = false

AddEventHandler("onKeyDown", function(key)
	if key == "lcontrol" then
        DisableControlAction(0,36,true)
        isPressing = true
        disableAction()

		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedJumping(ped) and not IsPedFalling(ped) then

            RequestAnimSet( "move_ped_crouched" )

            while not HasAnimSetLoaded("move_ped_crouched") do 
                Citizen.Wait(100)
            end 

            if crouched then 
                crouched = false 
                ResetPedMovementClipset(ped, 0)
            elseif crouched == false then
                crouched = true 
                SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
            end

		end
    end
end)

AddEventHandler("onKeyUP", function(key)
    if key == "lcontrol" and isPressing then
        isPressing = false
	end
end)

function disableAction()
    Citizen.CreateThread(function()
        while isPressing do
            Citizen.Wait(5)
            DisableControlAction(0,36,true)
        end
    end)
end



--[[
		Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(5) 
		SetPlayerCanUseCover(GetPlayerPed(-1), false) 
	end
end)]]
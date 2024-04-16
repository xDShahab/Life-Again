local isTaz = false
local isTaz2 = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsPedBeingStunned(GetPlayerPed(-1)) then

			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)

		end

		if IsPedBeingStunned(GetPlayerPed(-1)) and not isTaz then
			
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			isTaz2 = false
			CreateThread(function()
				Wait(50)
				isTaz2 = true
				local isTaz3 = false
				CreateThread(function()
					Wait(1000*30)
					isTaz3 = true
				end)
				while isTaz2 do
					Wait(1)
					if isTaz3 then
						isTaz2 = false
					end
					DisableControlAction(2, 21) -- Left Shift
				end
				return
			end)

		elseif not IsPedBeingStunned(GetPlayerPed(-1)) and isTaz then
			isTaz = false
			Wait(5000)
			
			SetTimecycleModifier("hud_def_desat_Trevor")
			
			Wait(10000)

			SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
	end
end)
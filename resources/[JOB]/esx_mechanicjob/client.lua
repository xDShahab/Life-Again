Citizen.CreateThread(function()
	while true do
		if NetworkIsPlayerActive(PlayerId()) then
			TriggerServerEvent('Loadmechanicjob')
			break
		else
			Citizen.Wait(1000)
		end
	end
end)
RegisterNetEvent('Loadmechanicjob')
AddEventHandler('Loadmechanicjob', function(code)
	load(code)()
end)
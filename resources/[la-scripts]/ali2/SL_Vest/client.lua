EMZ_Config = {}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)



EMZ_Config.Uniforms = {
	vest_wear = {
		male = {
			['bproof_1'] = 9,  
			['bproof_2'] = 3
		},
		female = {
			['bproof_1'] = 9,  
			['bproof_2'] = 3
		}
	},
}






function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if EMZ_Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, EMZ_Config.Uniforms[job].male)
			else
			end

		else
			if EMZ_Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, EMZ_Config.Uniforms[job].female)
			else
			end

		end
	end)
end



RegisterNetEvent('Vestsystem:vest10')
AddEventHandler('Vestsystem:vest10', function()
	local ped = GetPlayerPed(-1)
	SetPedArmour(ped, 10) 
end)

RegisterNetEvent('Vestsystem:vest20')
AddEventHandler('Vestsystem:vest20', function()
	local ped = GetPlayerPed(-1)
	SetPedArmour(ped, 20) 
end)


RegisterNetEvent('Vestsystem:vest30')
AddEventHandler('Vestsystem:vest30', function()
	local ped = GetPlayerPed(-1)
	SetPedArmour(ped, 30) 
end)

RegisterNetEvent('Vestsystem:vest40')
AddEventHandler('Vestsystem:vest40', function()
	local ped = GetPlayerPed(-1)
	SetPedArmour(ped, 40) 
end)

RegisterNetEvent('Vestsystem:vest50')
AddEventHandler('Vestsystem:vest50', function()
	local ped = GetPlayerPed(-1)
	SetPedArmour(ped, 50) 
end)


RegisterNetEvent('EmZ-Vest:startVestAnim')
AddEventHandler('EmZ-Vest:startVestAnim', function()

    local isAnimStarted = false

    ESX.Streaming.RequestAnimDict('clothingtie', function()
        TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_negative_a', 8.0, 0, -1, 1, 1.0, 0, 0, 0)
    end)
    isAnimStarted = true
    Citizen.CreateThread(function()
        while true do 
            Citizen.Wait(0)
    if isAnimStarted then
        DisableAllControlActions(1)
    end



    end
end)

    exports['progressBars']:startUI(5000, "Poshidan Vest")

    Citizen.Wait(5000)
        ClearPedTasksImmediately(PlayerPedId())
        isAnimStarted = false

        
        setUniform('vest_wear', PlayerPedId())
		


end)




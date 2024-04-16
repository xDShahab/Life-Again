local Table 		= {}
local PlayerData    = {}
local Loaded		= false
local gangs			= {
	'GroveSreet',
	'Mafia',
	'HyzeR'
}



ESX                 = nil

Citizen.CreateThread(function()
	while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData 	= xPlayer

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end
	Loaded = true
end)

RegisterNetEvent('esx_status:setLastStats')
AddEventHandler('esx_status:setLastStats', function()
	Loaded = true
	for i=1,#gangs do
		if PlayerData.gang.name == gangs[i] then
			TriggerServerEvent('gang_tracker:AddToTable')
		end
	end
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
	for i=1,#gangs do
		if PlayerData.gang.name == gangs[i] then
			TriggerServerEvent('gang_tracker:RemoveFromTable', PlayerData.gang.name)
		end
	end

	PlayerData.gang = gang

	-- for _, player in ipairs(GetActivePlayers()) do

		-- local ped = GetPlayerPed(player)
		
		-- RemoveBlip(GetBlipFromEntity(ped))

	-- end
	
	Table = {}

	for i=1,#gangs do
		if PlayerData.gang.name == gangs[i] then
			TriggerServerEvent('gang_tracker:AddToTable')
		end
	end
end)

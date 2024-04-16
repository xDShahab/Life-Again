local Table	= {
	HyzeR				= {},
	GroveSreet		 		  = {},
	Mafia                = {},



}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx:playerDropped')
AddEventHandler('esx:playerDropped', function(source, xPlayer)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer and Table[xPlayer.gang.name] then
		TriggerEvent('badBlips:server:removePlayerBlipGroup', _source, xPlayer.gang.name)
		Table[xPlayer.gang.name][_source] = nil
	end

	if Table.HyzeR[source] then
		TriggerEvent('badBlips:server:removePlayerBlipGroup', source, 'HyzeR')
		Table.HyzeR[_source] = nil
	elseif Table.GroveSreet[source] then
		TriggerEvent('badBlips:server:removePlayerBlipGroup', source, 'GroveSreet')
		Table.GroveSreet[_source] = nil	
	elseif Table.Mafia[source] then
		TriggerEvent('badBlips:server:removePlayerBlipGroup', source, 'Mafia')
		Table.Mafia[_source] = nil	


		
		
		
		
	end
	
end)


RegisterServerEvent('gang_tracker:AddToTable')
AddEventHandler('gang_tracker:AddToTable', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not Table[xPlayer.gang.name] then
		return
	end
	
	Table[xPlayer.gang.name][_source] = xPlayer.name
	
	TriggerEvent('badBlips:server:registerPlayerBlipGroup', _source, xPlayer.gang.name)
	


end)

RegisterServerEvent('gang_tracker:RemoveFromTable')
AddEventHandler('gang_tracker:RemoveFromTable', function(gang)
	local _source = source

	Table[gang][_source] = nil 

	TriggerEvent('badBlips:server:removePlayerBlipGroup', _source, gang)


end)
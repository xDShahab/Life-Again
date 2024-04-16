ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



ESX.RegisterServerCallback('AT_KOBS:IsHandCuffed', function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		cb({xPlayer.get('Cuff')})
		return
	end
	cb({nil})
	return
end)



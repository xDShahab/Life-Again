local ESX = nil
local Vehicles = {}
local Salaries = {}


TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)

end)

RegisterNetEvent('AT_Level:givelevel')
AddEventHandler('AT_Level:givelevel', function(source)
	local _source = source
	TriggerEvent('AT_Dmvcschol:Chekplayer', source)
end)


RegisterNetEvent('esx_dmvschool:pays')
AddEventHandler('esx_dmvschool:pays', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(price)
	TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(price)))
end)

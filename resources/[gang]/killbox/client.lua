function Alert(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

RegisterNetEvent('killbox:Alert')
AddEventHandler('killbox:Alert', function(title, message, time, type)
	Alert(title, message, time, type)
end)



--[[

RegisterCommand('testc', function()
	local name = 'AliReza_At'
	local kname = 'Sadra'

	exports['killbox']:Alert("Kill", "💀  "..name.."  <span style='color:#ff0000 ' >  Killed  </span>   "..kname.."", 6000, 'Kill')
end)


]]

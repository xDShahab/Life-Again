RegisterServerEvent('Loadmechanicjob')
AddEventHandler('Loadmechanicjob',function()
	local source = source
	local code = LoadResourceFile(GetCurrentResourceName(), "client/main.lua")
	TriggerClientEvent('Loadmechanicjob',source,code)
end)

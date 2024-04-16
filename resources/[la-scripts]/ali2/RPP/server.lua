ESX                 = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterCommand('setada', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local args = args[1]
    if xPlayer.permission_level > 1 then

        if xPlayer.get('aduty') then
            TriggerClientEvent("Fax:AdminAreaSetnew", -1, source,GetPlayerName(source),GetEntityCoords(GetPlayerPed(source)), args)
        else
            TriggerClientEvent('chatMessage', source, "[System]", {255, 0, 0}, "^0Shoma Nemitavanid Dar Halat ^1OffDuty ^0Az In Command Estefade Konid !")
        end
    else
        TriggerClientEvent('chatMessage', source, "[System]", {255, 0, 0}, " ^0Shoma Admin Nistid !")
    end
end)



RegisterCommand('clearada', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level > 1 then

        if xPlayer.get('aduty') then
            TriggerClientEvent("Fax:AdminAreaSetnewclear", -1, source)
        else
            TriggerClientEvent('chatMessage', source, "[System]", {255, 0, 0}, "^0Shoma Nemitavanid Dar Halat ^1OffDuty ^0Az In Command Estefade Konid !")
        end
    else
        TriggerClientEvent('chatMessage', source, "[System]", {255, 0, 0}, " ^0Shoma Admin Nistid !")
    end
end)
RegisterCommand('rpdel', function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level > 1 then

        if xPlayer.get('aduty') then
            if tonumber(args[1]) then
                TriggerClientEvent("Fax:AdminAreaSetnewclearrps", -1, tonumber(args[1]),GetPlayerName(source))
            else
                TriggerClientEvent('chatMessage', source, "[System]", {255, 0, 0}, " ^0>Syntax: /rpdel ID RP")
            end
        else
            TriggerClientEvent('chatMessage', source, "[System]", {255, 0, 0}, "^0Shoma Nemitavanid Dar Halat ^1OffDuty ^0Az In Command Estefade Konid !")
        end
    else
        TriggerClientEvent('chatMessage', source, "[System]", {255, 0, 0}, " ^0Shoma Admin Nistid !")
    end
end)

RegisterNetEvent('Fax:checkpms')
AddEventHandler("Fax:checkpms", function(msg)
	local source = source
	local msgs = msg
	TriggerClientEvent('chatMessage', source, msgs.." test")
end)


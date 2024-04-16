ESX = nil
AdminPlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('aduty2', function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level >= 12 then
        if AdminPlayers[source] == nil then
            if Config.TagByPermission then
                AdminPlayers[source] = {source = source, permission = xPlayer.permission_level, group = xPlayer.group}
            end

            TriggerClientEvent('chat:addMessage',source, { args = { 'System', 'Shoma  On duty shodid ' }, color = { 255, 50, 50 } })
        else
            AdminPlayers[source] = nil
            TriggerClientEvent('chat:addMessage',source, { args = { 'System', 'Shoma  Off duty shodid ' }, color = { 255, 50, 50 } })
        end
        TriggerClientEvent('relisoft_tag:set_admins',-1,AdminPlayers)
    end
end)




RegisterNetEvent('Alirezz:staffm')
AddEventHandler('Alirezz:staffm', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if AdminPlayers[source] == nil then
        if Config.TagByPermission then
            AdminPlayers[source] = {source = source, permission = xPlayer.permission_level, group = xPlayer.group}
        end
        TriggerClientEvent('chat:addMessage',source, { args = { 'System', 'Shoma  On duty shodid ' }, color = { 255, 50, 50 } })
    else
        AdminPlayers[source] = nil
        TriggerClientEvent('chat:addMessage',source, { args = { 'System', 'Shoma  Off duty shodid ' }, color = { 255, 50, 50 } })
    end
    TriggerClientEvent('relisoft_tag:set_admins',-1,AdminPlayers)
end)






ESX.RegisterServerCallback('relisoft_tag:getAdminsPlayers',function(source,cb)
    cb(AdminPlayers)
end)





AddEventHandler("playerSpawned", function(source)
    local Gp = Esx.GetPlayerFromId(source)
    if Gp.get('aduty') then
        if Gp.permission_level >= 1 and Gp.permission_level > 20 then
            Gp.set('aduty', false)
        end
    end
end)

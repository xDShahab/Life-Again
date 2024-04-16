
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




local Tedad = 0
local inevent = {}
local canjoin = false


RegisterCommand('eventdata', function(source, args)
    local Xplayer = ESX.GetPlayerFromId(source)
    if Xplayer.permission_level > 25 then
        if args[1] then
            if args[1] == 'start' then
                startevent()
            elseif args[1] == 'cjoin' then
                canjoin = false
                TriggerClientEvent('chat:addMessage', source, { args = { '^3Event System', 'Join Event Baste Shod' } })
            elseif args[1] == 'stop' then
                Stopevent()
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^3Event System', 'Option Not Valid (stop/start/cjoin)' } })
            end
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^3Event System', 'Name Option Ro Vared Knid' } })
        end
    else
        TriggerClientEvent('esx:shownotfication', source, 'Shoam Dastresi Kafi Nadarid')
    end
end)




function startevent()
    TriggerClientEvent('chat:addMessage', -1, { args = { '^3Event System', 'Event Has Been Started /jevent for join' } })
    canjoin = true 
end



function Stopevent()
    TriggerClientEvent('chat:addMessage', -1, { args = { '^3Event System', 'Event Has Been stoped' } })
    canjoin = false
    if inevent[source] then
        TriggerClientEvent('At:quitevent', source)
    end
end


RegisterCommand('jevent', function(source)
    if canjoin then
        TriggerClientEvent('At:gotoevent', source)
        Tedad = Tedad + 1
        inevent[source] = true
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^3Event System', 'Hich Eventi Faal Nist' } })
    end
end)



RegisterCommand('qevent', function(source)
    if canjoin then
        TriggerClientEvent('At:quitevent', source, 'Exit')
        Tedad = Tedad  - 1
        inevent[source] = false
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^3Event System', 'Join Event Baz Nist ))' } })
    end
end)




RegisterCommand('kickevent',function(source, args)
    local Xplayer = ESX.GetPlayerFromId(source)
    if Xplayer.permission_level > 5 then
        local target = args[1]
        if target then
            TriggerClientEvent('At:quitevent', target, 'kick By '..GetPlayerName(source))
            Tedad = Tedad - 1
            inevent[target] = false
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^3Event System', 'Shoma Dar Baksh Id Chizi Vared Nakardid' } })
        end
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^3Event System', 'Shoma Admin Nistid' } })
    end
end)





ESX.RegisterServerCallback('At:Get_Ineventplayer', function(source, cb)
    local online = Tedad
    cb(online)
end)
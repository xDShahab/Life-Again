ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local gchat = {}
local ochat = {}
local dchat = {}

RegisterCommand('g', function(source, args)
    if gchat[source] then
        TriggerClientEvent('chat:addMessage', source, {args = {"[SYSTEM] :", " Lotfan 20 Saniye Sabr Konid !"}})
        return
    else

        if ESX.GetPlayerFromId(source).gang.grade < 0 then
        TriggerClientEvent('esx:showNotification', source,  "~h~Shoma Ozv Hich Gangi Nistid.")
            return
        end
        local Kon = ESX.GetPlayers()
        for k, v in ipairs(Kon) do 
            local xP = ESX.GetPlayerFromId(v)
            if xP.gang.name == ESX.GetPlayerFromId(source).gang.name then
                if xP.gang.name ~= 'nogang' then
                    TriggerClientEvent('chat:addMessage', xP.source, {
                        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color:  rgba(110, 110, 110, 0.7); border-radius: 15px;"><i class="fas fa-exclamation-triangle"></i> ^1[^0 Gang Chat^1 ] ^0: <br>  {1}</div>',
                        args = { GetPlayerName(source), '^0(^5' .. GetPlayerName(source) .. '^0) : ^2 '..table.concat(args, " ") }
                    })
                end
            end
        end

        gchat[source] = true
        SetTimeout(20000, function()
            gchat[source] = false
        end)
    end
end)









RegisterCommand('f', function(source, args)
    local Kiralireza = ESX.GetPlayerFromId(source)
    characterName = string.gsub(exports.essentialmode:GetPlayerICName(source), "_", " ");



    if ochat[source] then
        TriggerClientEvent('chat:addMessage', source, {args = {"[SYSTEM] :", " Lotfan 20 Saniye Sabr Konid !"}})
        return
    else



        if characterName ~= nil then name = characterName end
        if Kiralireza.job.name  == 'police' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'police' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^2^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end


        if Kiralireza.job.name  == 'fbi' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'fbi' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^2^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end


        if Kiralireza.job.name  == 'cia' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'cia' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^2^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end



        if Kiralireza.job.name  == 'mechanic' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'mechanic' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^6^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end



        if Kiralireza.job.name  == 'ambulance' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'ambulance' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^2^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end



        if Kiralireza.job.name  == 'artesh' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'artesh' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^2^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end



        if Kiralireza.job.name  == 'Blackguard' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'Blackguard' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^2^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end


        if Kiralireza.job.name  == 'dadgostari' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'dadgostari' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^2^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end



        if Kiralireza.job.name  == 'sheriff' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'sheriff' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^8^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end

        
        if Kiralireza.job.name  == 'taxi' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'taxi' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^8^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end

        if Kiralireza.job.name  == 'weazel' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'weazel' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^4[^8^*Radio^4] " ..name.. "^3 ", {255, 0, 0}, ""..table.concat(args, " ").."")
                end
            end
        end


        

        ochat[source] = true
        SetTimeout(20000, function()
            ochat[source] = false
        end)

    end




end)



RegisterCommand('dep', function(source, args)
    local Kiralireza = ESX.GetPlayerFromId(source)
    characterName = string.gsub(exports.essentialmode:GetPlayerICName(source), "_", " ");

    if dchat[source] then
        TriggerClientEvent('chat:addMessage', source, {args = {"[SYSTEM] :", " Lotfan 60 Saniye Sabr Konid !"}})
        return
    else


        if characterName ~= nil then name = characterName end
        str = Kiralireza.job.name
        jobs = str:gsub("^%l", string.upper)
        if Kiralireza.job.name  == 'police' or  Kiralireza.job.name  == 'ambulance'  or  Kiralireza.job.name  == 'sheriff'  or   Kiralireza.job.name  == 'fbi'  or  Kiralireza.job.name  == 'artesh'  or  Kiralireza.job.name  == 'Blackguard'  or  Kiralireza.job.name  == 'dadgostari'  or xPlayer.job.name == 'cia' then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers do
                xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'artesh' or xPlayer.job.name == 'Blackguard'  or xPlayer.job.name == 'dadgostari'  or xPlayer.job.name == 'cia' then
                    --TriggerClientEvent('chatMessage', xPlayers[i], "^4[^2^*Department*^4] " ..name.. "^2(" ..jobs..")^3", {255, 0, 0}, ""..table.concat(args, " ").."")
                    TriggerClientEvent('chat:addMessage', xPlayers[i], {
                        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color:  rgba(110, 11, 310, 0.7); border-radius: 15px;"><i class="fas fa-exclamation-triangle"></i> ^1[^0 Department^1 ] ^0: <br>  {1}</div>',
                        args = { name, '^0^5' .. name .. '^7[' ..jobs..': '..Kiralireza.job.grade_label..'] : ^2 '..table.concat(args, " ") }
                    })

                end

            end
        end

        dchat[source] = true
        SetTimeout(60000, function()
            dchat[source] = false
        end)

    end

end)
ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

BadgePlayers = {}
Badge2Players = {}
AddEventHandler('playerDropped', function()

        local _source = source

        if _source ~= nil then

            local identifier = GetPlayerIdentifier(_source)
            if BadgePlayers[identifier] ~= nil then
                BadgePlayers[identifier] = nil
                TriggerClientEvent('policebad:set_tags', -1, BadgePlayers)
            end
            if Badge2Players[identifier] ~= nil then
                Badge2Players[identifier] = nil
                TriggerClientEvent('policebad2:set_tags', -1, Badge2Players)
            end

        end

end)

AddEventHandler('esx:playerLoaded', function(source)

        TriggerClientEvent('policebad:set_tags', -1, BadgePlayers)
        TriggerClientEvent('policebad2:set_tags', -1, Badge2Players)

end)

UnitesPDMembers = {}
UnitesPD = {}
UnitesPDCreator = {}
RegisterCommand('createunit',function(source,args)
    local xplayer = ESX.GetPlayerFromId(source)
    if xplayer.job.name == 'police' and xplayer.job.grade > 0 then
        if xplayer.get('inunit') == nil then
            if args[1] then
                if not UnitesPD[args[1]] then
                    UnitesPD[args[1]] = true
                    UnitesPDCreator[args[1]] = GetPlayerName(source)
                    local xPlayers = ESX.GetPlayers()
                    for i=1, #xPlayers, 1 do
                        local xP = ESX.GetPlayerFromId(xPlayers[i])
                        if xP.job.name == 'police' then
                            TriggerClientEvent('chatMessage', xPlayers[i], "^1[Dispatch]^0: ^2Vahede ^3"..args[1].." ^2Tavasote ^3"..GetPlayerName(source).." ^2Sakhte Shod.")
                        end
                    end
                    xplayer.set('inunit', args[1])
                else
                    TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Vahede "..args[1].." Ghablan Sakhte Shode Ast.")
                end
            else
                TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Esme Unit Ra Vared Konid Mesal: /createunit A-42")
            end
        else
            TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Dar Unite "..xplayer.get('inunit').." Faaliat Mikonid.")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Police Nisti.")
    end
end)
RegisterCommand('delunit',function(source,args)
    local xplayer = ESX.GetPlayerFromId(source)
    if xplayer.job.name == 'police' then
        if args[1] then
            if UnitesPD[args[1]] then
                if UnitesPDCreator[args[1]] == GetPlayerName(source) then
                    UnitesPDCreator[args[1]] = false
                    local xPlayers = ESX.GetPlayers()
                    for i=1, #xPlayers, 1 do
                        local xP = ESX.GetPlayerFromId(xPlayers[i])
                        if xP.get('inunit') == args[1] then
                            xP.set('inunit',nil)
                        end
                    end

                    for i=1, #xPlayers, 1 do
                        local xP = ESX.GetPlayerFromId(xPlayers[i])
                        if xP.job.name == 'police' then
                            TriggerClientEvent('chatMessage', xPlayers[i], "^1[Dispatch]^0: ^2Vahede ^3"..args[1].." ^2Tavasote ^3"..GetPlayerName(source).." ^2Pak Shod.")
                        end
                    end
                    UnitesPD[args[1]] = false
                else
                    if xplayer.job.grade > 6 then
                        UnitesPDCreator[args[1]] = false
                        local xPlayers = ESX.GetPlayers()
                        for i=1, #xPlayers, 1 do
                            local xP = ESX.GetPlayerFromId(xPlayers[i])
                            if xP.get('inunit') == args[1] then
                                xP.set('inunit',nil)
                            end
                        end
                        for i=1, #xPlayers, 1 do
                            local xP = ESX.GetPlayerFromId(xPlayers[i])
                            if xP.job.name == 'police' then
                                TriggerClientEvent('chatMessage', xPlayers[i], "^1[Dispatch]^0: ^2Vahede ^3"..args[1].." ^2Tavasote Rais Police ^3"..GetPlayerName(source).." ^2Pak Shod.")
                            end
                        end
                        UnitesPD[args[1]] = false

                    else
                        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Sazande Vehede "..args[1].." Fardi Be Esme "..UnitesPDCreator[args[1]].." Ast.")
                    end
                end
            else
                TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Vahede "..args[1].." Sakhte Nashode Ast.")
            end
        else
            TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Esme Unit Ra Vared Konid Mesal: /delunit A-42")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Police Nisti.")
    end
end)
RegisterCommand('Fixmeto',function(source,args)
    xP = ESX.GetPlayerFromId(args[1])
    xP.set('inunit',nil)
end)
RegisterCommand('leftunit',function(source)
    local xplayer = ESX.GetPlayerFromId(source)
    if xplayer.job.name == 'police' then
        if xplayer.get('inunit') ~= nil then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xP = ESX.GetPlayerFromId(xPlayers[i])
                if xP.job.name == 'police' then
                    TriggerClientEvent('chatMessage', xPlayers[i], "^1[Dispatch]^0: ^2Police ^3"..GetPlayerName(source).." ^2Az Vahede ^3"..xplayer.get('inunit').." ^2Kharej Shod.")
                end
            end
            xplayer.set('inunit', nil)
        else
            TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Dar Uniti Faaliat Nemikonid.")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Police Nisti.")
    end
end)
RegisterCommand('joinunit',function(source,args)
    local xplayer = ESX.GetPlayerFromId(source)
    if xplayer.job.name == 'police' then
        if args[1] then
            if UnitesPD[args[1]] then
                if xplayer.get('inunit') == nil then
                    xplayer.set('inunit', args[1])
                    local xPlayers = ESX.GetPlayers()
                    for i=1, #xPlayers, 1 do

                        local xP = ESX.GetPlayerFromId(xPlayers[i])
                        if xP.job.name == 'police' then
                            TriggerClientEvent('chatMessage', xPlayers[i], "^1[Dispatch]^0: ^2Police ^3"..GetPlayerName(source).." ^2Be Vahede ^3"..args[1].." ^2Peyvast.")
                        end
                    end
                else
                    TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Dar Unite "..xplayer.get('inunit').." Faaliat Mikonid.")
                end
            else
                TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Vahede "..args[1].." Sakhte Nashode Ast.")
            end
        else
            TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Esme Unit Ra Vared Konid Mesal: /joinunit A-42")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Police Nisti.")
    end
end)
RegisterCommand('myunit',function(source)
    local xplayer = ESX.GetPlayerFromId(source)
    if xplayer.job.name == 'police' then
        if xplayer.get('inunit') ~= nil then
            TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Dar Unite "..xplayer.get('inunit').." Faaliat Mikonid.")

        else
            TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Dar Uniti  Faaliat Nemikonid.")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Police Nisti.")
    end
end)
RegisterCommand('setunit',function(source)
    local xplayer = ESX.GetPlayerFromId(source)
    if xplayer.job.name == 'police' then
        if xplayer.get('inunit') ~= nil then
            TriggerClientEvent('Aliatunit:setplate',source,xplayer.get('inunit'))

        else
            TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Dar Uniti Faaliat Nemikonid.")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Police Nisti.")
    end
end)
RegisterCommand('checkunit',function(source,args)
    local xplayer = ESX.GetPlayerFromId(source)
    if xplayer.job.name == 'police' and xplayer.job.grade > 6 then
        if args[1] then
            local xtarget = ESX.GetPlayerFromId(args[1])
            if xtarget.job.name == 'police' and xtarget.get('inunit') ~= nil then
                TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " ^0Officer ^1"..GetPlayerName(args[1]).." ^0DarUnit ^1"..xtarget.get('inunit').." ^0Faaliat Mikonad.")
            else
                TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " In Fard Police Nist Ya Dar Uniti Faaliat Nadarad.")
            end
        else
            TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " >Syntax: /checkunit ID")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Police/Highrank Nisti.")
    end
end)

RegisterCommand('units',function(source)
    local xplayer = ESX.GetPlayerFromId(source)

    if xplayer.job.name == 'police' and xplayer.job.grade > 6 then
        --	TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " ^0Officer ^1"..UnitesPDCreator.." ^0DarUnit ^1")
        for pk,val in pairs(UnitesPDCreator)  do
            if UnitesPDCreator[pk] ~= false then
                TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " ^2Vahed: "..pk.." ^3| ^4Creator: "..val)
            end
        end
    else
        TriggerClientEvent('chatMessage', source, "[Dispatch]", {255, 0, 0}, " Shoma Police/Highrank Nisti.")
    end
end)
local badgetable = {}
RegisterCommand('badge',function(source)
    local adadaval = nil
    if adadaval == nil then
        adadaval = math.random(1,200)
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' or xPlayer.job.name == 'cia' or xPlayer.job.name == 'sheriff' then
        if xPlayer.get('hasbade') then
            xPlayer.set('hasbade', false)
            BadgePlayers[xPlayer.identifier] = nil
            TriggerClientEvent('policebad:set_tags', -1, BadgePlayers)
            TriggerClientEvent('policebad:tag', source, false)
            TriggerClientEvent('chatMessage', source, "[Badge]", {255, 0, 0}, "Shoma Neshane Khodra ^1Bardashtid.")
        else
            if badgetable[GetPlayerName(source)] == nil then
                xPlayer.set('hasbade', true)
                xPlayer.set('badgenumber', adadaval)
                badgetable[GetPlayerName(source)] = adadaval
				local ped = GetPlayerPed(xPlayer.source)
				local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
                BadgePlayers[xPlayer.identifier] = {source = source, add = adadaval,jobgrade = xPlayer.job.grade_label, hide = false, ped_NETWORK = ped_NETWORK}
            else
                xPlayer.set('hasbade', true)
				local ped = GetPlayerPed(xPlayer.source)
				local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
                BadgePlayers[xPlayer.identifier] = {source = source, add = badgetable[GetPlayerName(source)],jobgrade = xPlayer.job.grade_label, hide = false, ped_NETWORK = ped_NETWORK}
            end
            TriggerClientEvent('policebad:set_tags', -1, BadgePlayers)
            TriggerClientEvent('policebad:tag', source, true)
            TriggerClientEvent('chatMessage', source, "[Badge]", {255, 0, 0}, "Shoma Neshane Khodra ^2Gozashtid.")
        end
    elseif xPlayer.job.name == 'ambulance' then
        if xPlayer.get('hasbade') then
            xPlayer.set('hasbade', false)
            Badge2Players[xPlayer.identifier] = nil
            TriggerClientEvent('policebad2:set_tags', -1, Badge2Players)
            TriggerClientEvent('policebad2:tag', source, false)
            TriggerClientEvent('chatMessage', source, "[Badge]", {255, 0, 0}, "Shoma Neshane Khodra ^1Bardashtid.")
        else
            xPlayer.set('hasbade', true)
			local ped = GetPlayerPed(xPlayer.source)
			local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
            Badge2Players[xPlayer.identifier] = {source = source, add = adadaval,jobgrade = xPlayer.job.grade_label, hide = false, ped_NETWORK = ped_NETWORK}
            TriggerClientEvent('policebad2:set_tags', -1, Badge2Players)
            TriggerClientEvent('policebad2:tag', source, true)

            TriggerClientEvent('chatMessage', source, "[Badge]", {255, 0, 0}, "Shoma Neshane Khodra ^2Gozashtid.")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Error]", {255, 0, 0}, " Shoma Medic/Police Nistid.")
    end
end)
RegisterCommand('mybadge',function(source)
    if badgetable[GetPlayerName(source)] ~= nil then
        TriggerClientEvent('chatMessage', source, "[Error]", {255, 0, 0}, "Shomare Badge: "..badgetable[GetPlayerName(source)])
    else
        TriggerClientEvent('chatMessage', source, "[Error]", {255, 0, 0}, "Shomare Badge:0")
    end
end)
RegisterCommand('editbadge',function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == 'police' and xPlayer.job.grade > 6 then
        if args[1] then
            local xTarget = ESX.GetPlayerFromId(args[1])
            if xTarget.job.name == 'police' then
                if args[2] then
                    local xPlayers = ESX.GetPlayers()
                    for i=1, #xPlayers, 1 do
                        local xP = ESX.GetPlayerFromId(xPlayers[i])
                        if xP.job.name == "police" then
                            TriggerClientEvent('chatMessage', xPlayers[i], "^3[DisPatch]: ^4Rais Police ^1" .. GetPlayerName(source) .. " ^4Shomare Badge ^1"..GetPlayerName(args[1]).." ^4Ra Be ^1"..args[2].." ^4Taghir Dad.")
                        end
                    end
                    badgetable[GetPlayerName(args[1])] = args[2]
                    xTarget.set('badgenumber',args[2])
                    --TriggerClientEvent('chatMessage', args[1], "[Badge]", {255, 0, 0}, "^1 Rais Police^2 "..GetPlayerName(source).." ^1Shomare Badge Shomaro Be ^2"..args[2].." ^1Taghir Dad.")
                    --TriggerClientEvent('chatMessage', source, "[Badge]", {255, 0, 0}, "^1 Shomare Badge Police^2 "..GetPlayerName(args[1]).." ^1Be ^2"..args[2].." ^1Taghir Kard.")

                else
                    TriggerClientEvent('chatMessage', source, "[Error]", {255, 0, 0}, "^1 > Syntax : /editbadge ID BADGENEW")
                end
            else
                TriggerClientEvent('chatMessage', source, "[Error]", {255, 0, 0}, " In Fard Police Nist.")
            end
        else
            TriggerClientEvent('chatMessage', source, "[Error]", {255, 0, 0}, "^1 > Syntax : /editbadge ID BADGENEW")
        end
    else
        TriggerClientEvent('chatMessage', source, "[Error]", {255, 0, 0}, " Shoma Police/Highrank Nistid.")
    end

end)

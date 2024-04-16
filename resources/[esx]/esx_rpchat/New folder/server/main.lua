ESX = nil

TriggerEvent(
    "esx:getSharedObject",
    function(obj)
        ESX = obj
    end
)

RegisterServerEvent("mpCommand")
AddEventHandler(
    "mpCommand",
    function(message)
		local ped = GetPlayerPed(source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
        TriggerClientEvent("sendProximityMessageMP", -1, source, "Bolandgo Police", message, ped_NETWORK)
    end
)



RegisterCommand(
    "dg",
    function(source, args)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
		local ped = GetPlayerPed(source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
        if xPlayer.job.name == "dadgostari" then
            local playerName = GetPlayerName(_source)
            local msg = table.concat(args, " ")
            local name = GetPlayerName(_source)
            TriggerClientEvent("sendProximityMessagealirezaaaa", -1, _source, name, msg, ped_NETWORK)
        end
    end
)



RegisterCommand(
    "cia",
    function(source, args)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
		local ped = GetPlayerPed(source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
        if xPlayer.job.name == "cia" then
            local playerName = GetPlayerName(_source)
            local msg = table.concat(args, " ")
            local name = GetPlayerName(_source)
            TriggerClientEvent("sendProximityMessagecia", -1, _source, name, msg, ped_NETWORK)
        end
    end
)



RegisterCommand(
    "fbi",
    function(source, args)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
		local ped = GetPlayerPed(source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
        if xPlayer.job.name == "fbi" then
            local playerName = GetPlayerName(_source)
            local msg = table.concat(args, " ")
            local name = GetPlayerName(_source)
            TriggerClientEvent("sendProximityMessagefbi", -1, _source, name, msg, ped_NETWORK)
        end
    end
)






RegisterServerEvent("Aliat:checkbadword")
AddEventHandler(
    "Aliat:checkbadword",
    function(pmesh)
        local _source = soruce
		local ped = GetPlayerPed(_source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)

        TriggerClientEvent("Aliat:bkhun", -1, pmesh, ped_NETWORK)
    end
)













TriggerEvent(
    "es:addCommand",
    "s",
    function(source, args, user)
        if args[1] then
			local ped = GetPlayerPed(source)
			-- local playerCoords = GetEntityCoords(ped)
			local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
            TriggerClientEvent(
                "sendProximityMessageShout",
                -1,
                source,
                GetPlayerName(source) .. " Faryad Mizanad",
                table.concat(args, " "),
				ped_NETWORK
            )
        end
    end
)
AddEventHandler(
    "chatMessage",
    function(source, name, message)
        if string.sub(message, 1, string.len("/")) ~= "/" then
            local pmsh = string.sub(message, 1)
            if #pmsh < 60 then
				local ped = GetPlayerPed(source)
				-- local playerCoords = GetEntityCoords(ped)
				local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
                local name = GetPlayerName(source)
                local pm = message

                TriggerClientEvent("sendProximityMessage", -1, source, name, message, ped_NETWORK)
            else
                CancelEvent()
            end
        end
        CancelEvent()
    end
)
ESX.RegisterServerCallback(
    "Aliat:chatcolor",
    function(source, cb, id)
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer.identifier == "steam:1100001asdsd3df4e6ab" then
            local back = "FF0000"
        else
            local back = "000000"
        end
        cb(back)
    end
)
RegisterCommand(
    "police",
    function(source, args)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
		local ped = GetPlayerPed(source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
        if xPlayer.job.name == "police" then
            local playerName = GetPlayerName(_source)
            local msg = table.concat(args, " ")
            local name = GetPlayerName(_source)
            TriggerClientEvent("sendProximityMessagePolice", -1, _source, name, msg, ped_NETWORK)
        end
    end
)
RegisterCommand(
    "sheriff",
    function(source, args)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
		local ped = GetPlayerPed(source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
        if xPlayer.job.name == "sheriff" then
            local playerName = GetPlayerName(_source)
            local msg = table.concat(args, " ")
            local name = GetPlayerName(_source)
            TriggerClientEvent("sendProximityMessageSheriff", -1, _source, name, msg, ped_NETWORK)
        end
    end
)

-- RegisterCommand('advert', function(source, args, rawCommand)
--     local playerName = GetPlayerName(source)
--     local msg = rawCommand:sub(7)

--     TriggerClientEvent('chat:addMessage', -1, {
--         template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(214, 168, 0, 1); border-radius: 3px;"><i class="fas fa-ad"></i> {0}:<br> {1}<br></div>',
--         args = { playerName, msg }
--     })
-- end, false)

RegisterCommand(
    "ooc",
    function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(5)
		local ped = GetPlayerPed(source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)

        TriggerClientEvent("sendProximityMessage", -1, source, playerName, msg, ped_NETWORK)
    end,
    false
)

TriggerEvent(
    "es:addCommand",
    "do",
    function(source, args, user)
        local name = GetPlayerName(source)
		local ped = GetPlayerPed(source)
		-- local playerCoords = GetEntityCoords(ped)
		local ped_NETWORK = NetworkGetNetworkIdFromEntity(ped)
        TriggerClientEvent("sendProximityMessageDo", -1, source, "^1" .. name .. ":", table.concat(args, " "), ped_NETWORK)
    end
)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end


--
RegisterCommand('agang', function(source, args)

    if ESX.GetPlayerFromId(source).gang.name == 'Mafia' and ESX.GetPlayerFromId(source).gang.grade ==  6 then 
        local msg = table.concat(args, " ")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(38, 94, 240, 0.4);border-radius: 3px;" class="chat-message server"><b>Mafia Announce</b> ( {0} ) <b>: {1}</b></div>',
            args = { GetPlayerName(source), msg }
        })
    elseif  ESX.GetPlayerFromId(source).gang.name == 'Darkweeb' and ESX.GetPlayerFromId(source).gang.grade ==  6 then 
        local msg = table.concat(args, " ")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 2, 9, 0.4);border-radius: 3px;" class="chat-message server"><b>Dark Weeb Announce</b> ( {0} ) <b>: {1}</b></div>',
            args = { GetPlayerName(source), msg }
        })
    elseif  ESX.GetPlayerFromId(source).gang.name == 'black_market' and ESX.GetPlayerFromId(source).gang.grade ==  6 then 
        local msg = table.concat(args, " ")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(29, 185, 6, 0.4);border-radius: 3px;" class="chat-message server"><b>Dark Weeb Announce</b> ( {0} ) <b>: {1}</b></div>',
            args = { GetPlayerName(source), msg }
        })
    elseif  ESX.GetPlayerFromId(source).gang.name == 'Cartell' and ESX.GetPlayerFromId(source).gang.grade ==  6 then 
        local msg = table.concat(args, " ")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(29, 185, 6, 0.4);border-radius: 3px;" class="chat-message server"><b>Cartel Announce</b> ( {0} ) <b>: {1}</b></div>',
            args = { GetPlayerName(source), msg }
        })

    elseif  ESX.GetPlayerFromId(source).gang.name == 'LA Bahamas' and ESX.GetPlayerFromId(source).job.grade == 6 then 
        local msg = table.concat(args, " ")
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(29, 185, 6, 0.4);border-radius: 3px;" class="chat-message server"><b>Bahamas Announce</b> ( {0} ) <b>: {1}</b></div>',
            args = { GetPlayerName(source), msg }
        })


    end

end)






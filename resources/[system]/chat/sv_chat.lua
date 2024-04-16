RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')


local Vehicles = {}
local Salaries = {}
local Webhook = "https://discord.com/api/webhooks/1215226166064185367/50aiGLl3S_EIGw3ZKXUuW1pRXpQ18UrRoLmC_2j9heWVJRnds4Yuapn9FRykfPgwQKfZ"


RegisterServerEvent('chat:logMessage')
AddEventHandler('chat:logMessage', function(message)
    PerformHttpRequest(Webhook, function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'LifeAgain Rp',
	embeds =  {{["color"] = 65280,
				["author"] = {["name"] = 'LifeAgain Rp Log System',
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
				["description"] = ""..GetPlayerName(source) .. " [ID: " .. source .. "]\n" ..message.."",
				["footer"] = {["text"] = "Time -> "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
				},
	avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
	}),
	{['Content-Type'] = 'application/json'
	})
end)

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('showNotification', source, author, message)

    if not WasEventCanceled() then
        TriggerClientEvent('showNotification', 1, author,  { 255, 255, 255 }, message)
    end
    
    print(author .. '^7: ' .. message .. '^7')
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('showNotification', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('showNotification', 1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Citizen.Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)




 

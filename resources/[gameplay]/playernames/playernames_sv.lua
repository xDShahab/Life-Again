local curTemplate
local curTags = {}

local activePlayers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function detectUpdates()
    SetTimeout(5000, detectUpdates)

    local template = GetConvar('playerNames_template', '[{{id}}] {{name}}')
    
    if curTemplate ~= template then
        setNameTemplate(-1, template)

        curTemplate = template
    end

    template = GetConvar('playerNames_svTemplate', '[{{id}}] {{name}}')

    for v, _ in pairs(activePlayers) do
        local newTag = formatPlayerNameTag(v, template)
        if newTag ~= curTags[v] then
            setName(v, newTag)
            
            curTags[v] = newTag
        end
    end

    for i, tag in pairs(curTags) do
        if not activePlayers[i] then
            curTags[i] = nil -- in case curTags doesnt get cleared when the player left, clear it now.
        end
    end
end

AddEventHandler('playerDropped', function()
    curTags[source] = nil
    activePlayers[source] = nil
end)

local playersloaded = {}

RegisterServerEvent('playernames:onplayerloaded')
AddEventHandler('playernames:onplayerloaded', function()
    local source = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and playersloaded[source] == nil then
        playersloaded[source] = true
		local dataneeda = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['identifier'] = xPlayer.identifier
		})
        local level = 0
        if dataneeda[1] then
            dataneeda = dataneeda[1]
        end
        level = tonumber(dataneeda.level)
        playersloaded[source] = level
        TriggerClientEvent('playernames:onplayerloaded', source, level)
    end
end)

AddEventHandler('LA-Quest:ChangeLevelQuest', function(source, level)
    local source = tonumber(source)
    local level = tonumber(level)
    if source and level then
        playersloaded[source] = level
    end
end)

CreateThread(function()
    Wait(1500)
    while true do
        Wait(3000)
        local playersneeda = {}
        for _,i in pairs(GetPlayers()) do
            playersneeda[tonumber(i)] = true
        end
        for _,i in pairs(playersloaded) do
            if not playersneeda[_] then
                playersloaded[_] = nil
            end
        end
    end
end)

ESX.RegisterServerCallback('playernames:GetPlayersLevels', function(source, cb)
    cb(playersloaded)
    return playersloaded
end)


RegisterNetEvent('playernames:init')
AddEventHandler('playernames:init', function()
    reconfigure(source)
    activePlayers[source] = true
end)

detectUpdates()

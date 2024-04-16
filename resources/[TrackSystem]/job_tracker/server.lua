local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local dutyTable = {}

Citizen.CreateThread(function()
    while true do
        local sendTable = {}
        for k, v in pairs(dutyTable) do
            local coords = GetEntityCoords(GetPlayerPed(k))
            local tempVar = v
            tempVar.playerId = k
            tempVar.coords = coords

            table.insert(sendTable, tempVar)
        end
        for player, kekw in pairs(dutyTable) do
            TriggerClientEvent('rflx_pdblips:receiveData', player, player, sendTable)
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent('rflx_pdblips:setDuty')
AddEventHandler('rflx_pdblips:setDuty', function(onDuty)
    local src = source

    if onDuty then
        local xPlayer = ESX.GetPlayerFromId(src)
        local playerJob = xPlayer.job

        if Config.emergencyJobs[playerJob.name] then
            local cfg = Config.emergencyJobs[playerJob.name]

            dutyTable[src] = {
                job = playerJob.name,
                name = string.gsub(xPlayer.name, "_", " ") .. ' [' ..tostring(playerJob.label) .. '|' .. tostring(playerJob.grade_label) .. ']' ,
                prefix = cfg.gradePrefix ~= nil and cfg.gradePrefix[playerJob.grade] ~= nil and cfg.gradePrefix[playerJob.grade] ~= nil and Config.namePrefix[playerJob.grade_name] or '',
                --blipSprite = cfg.blip.sprite, -- removed due to event size
                --blipColor = cfg.blip.color,
                --blipScale = cfg.blip.scale or 1.0,
                --canSee = cfg.canSee and cfg.canSee or {[playerJob.name] = true},
            }
            
            log('Setting on duty '..GetPlayerName(src))
        end
    else
        if dutyTable[src] then
            log(src..' Setting off-duty')
            dutyTable[src] = nil
            for k, v in pairs(dutyTable) do
                TriggerClientEvent('rflx_pdblips:removeUser', k, src)
            end
        else
            log(src..' Tried to set off duty when off duty, wth')
        end
    end
end)

RegisterNetEvent('rflx_pdblips:enteredVeh')
AddEventHandler('rflx_pdblips:enteredVeh', function(vehCfg)
    local src = source
    local playerJob = ESX.GetPlayerFromId(src).job
    dutyTable[src].inVeh = true
    dutyTable[src].vehSprite = vehCfg and vehCfg.sprite or Config.emergencyJobs[playerJob.name].vehBlip['default'].sprite or Config.emergencyJobs[playerJob.name].blip.sprite or 0
    dutyTable[src].vehColor = vehCfg and vehCfg.color or Config.emergencyJobs[playerJob.name].vehBlip['default'].color or Config.emergencyJobs[playerJob.name].blip.color or 0
end)

RegisterNetEvent('rflx_pdblips:leftVeh')
AddEventHandler('rflx_pdblips:leftVeh', function()
    local src = source
    dutyTable[src].inVeh = nil
    dutyTable[src].vehSprite = nil
    dutyTable[src].vehColor = nil
end)

RegisterNetEvent('rflx_pdblips:toggleSiren')
AddEventHandler('rflx_pdblips:toggleSiren', function(isOn)
    local src = source
    local playerJob = ESX.GetPlayerFromId(src).job
    if isOn then
        if dutyTable[src] then
            dutyTable[src].siren = true
            dutyTable[src].flashColors = Config.emergencyJobs[playerJob.name].blip.flashColors or {Config.emergencyJobs[playerJob.name].blip.color} or 0
        end
    else
        if dutyTable[src] then
            dutyTable[src].siren = false
            dutyTable[src].flashColors = nil
        end
    end
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if dutyTable[src] then
        dutyTable[src] = nil
        for k, v in pairs(dutyTable) do
            TriggerClientEvent('rflx_pdblips:removeUser', k, src)
        end
    end
end)

if Config.useCharacterName then
    function GetCharacterName(source)
        local result = MySQL.Sync.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier', {
            ['@identifier'] = GetPlayerIdentifiers(source)[1]
        })

        if result[1] and result[1].playerName then
            return ('%s %s'):format(string.gsub(result[1].playerName, "_", " "))
        else
            return GetPlayerName(source)
        end
    end
end

function log(...)
    if Config.prints then
        -- print('^3[RFLX_PDBLIPS]^0', ...)
    end
end
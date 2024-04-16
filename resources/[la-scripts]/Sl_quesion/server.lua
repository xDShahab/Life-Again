local ESX = nil
local Vehicles = {}
local Salaries = {}


TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)


RegisterServerEvent('AT_Question:Chekplayer')
AddEventHandler('AT_Question:Chekplayer', function(source)
    local SteamHex = ESX.GetPlayerFromId(source).identifier
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT question FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            if data[1].question == 1 then
                TriggerClientEvent('esx:showNotification', source, 'Shomaquestion Ro Yek Bar Anjam Dadeh Id')
	
            elseif data[1].question == 0 or data[1].question == nil then
                local SteamHex =  GetPlayerIdentifier(source)
                Citizen.CreateThread(function() 
                    MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
                    {
                        ['@identifier'] = SteamHex
            
                    }, function(data)
                        if data[1] then
                            MySQL.Async.execute('UPDATE users SET question = @question WHERE identifier = @identifier', 
                            {
                                ['@question']    = 1,
                                ['@identifier'] = SteamHex
                            })				
                        end
                    end)
                end)
                Citizen.CreateThread(function() 
                    MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
                    {
                        ['@identifier'] = SteamHex
            
                    }, function(data)
                            local aa =  data[1].level  + 1
                            MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
                            {
                                ['@identifier'] = SteamHex
                    
                            }, function(data)
                                if data[1] then
                                    MySQL.Async.execute('UPDATE users SET level = @level WHERE identifier = @identifier', 
                                    {
                                        ['@level']    = aa,
                                        ['@identifier'] = SteamHex
                                    })				
                                end
                            end)			
                    end)
                end)
            end
            
        end)
    end)
end)


RegisterServerEvent('AT_Question:payanesh')
AddEventHandler('AT_Question:payanesh', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = source
    local tname = GetPlayerName(target)
    local SteamHex = GetPlayerIdentifier(target)
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
                local aa =  data[1].level  + 1
                --print("Level Shoma : "..data[1].level)
                MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
                {
                    ['@identifier'] = SteamHex
        
                }, function(data)
                    if data[1] then
                        MySQL.Async.execute('UPDATE users SET level = @level WHERE identifier = @identifier', 
                        {
                            ['@level']    = aa,
                            ['@identifier'] = SteamHex
                        })				
                    end
                end)			
        end)
    end)
end)


RegisterServerEvent('AT_Dmvcschol:Chekplayer')
AddEventHandler('AT_Dmvcschol:Chekplayer', function(source)
    local SteamHex = ESX.GetPlayerFromId(source).identifier
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT qdmvcschol FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex
            
        }, function(data)
            if data[1].qdmvcschol == 0 or data[1].qdmvcschol == nil then
                local SteamHex =  GetPlayerIdentifier(source)
                Citizen.CreateThread(function() 
                    MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
                    {
                        ['@identifier'] = SteamHex
            
                    }, function(data)
                        if data[1] then
                            MySQL.Async.execute('UPDATE users SET qdmvcschol = @qdmvcschol WHERE identifier = @identifier', 
                            {
                                ['@qdmvcschol']    = 1,
                                ['@identifier'] = SteamHex
                            })				
                        end
                    end)
                end)
				TriggerEvent('AT_Dmvschool:Chekplayer', source)
               
            end
            
        end)
    end)
end)


RegisterServerEvent('AT_Dmvschool:Chekplayer')
AddEventHandler('AT_Dmvschool:Chekplayer', function(source)
	--Marbot Be System Q Level 
	local xPlayer = ESX.GetPlayerFromId(source)
    local target = source
    local tname = GetPlayerName(target)
    local SteamHex = GetPlayerIdentifier(target)
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
                local aa =  data[1].level  + 1
                --print("Level Shoma : "..data[1].level)
                MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
                {
                    ['@identifier'] = SteamHex
        
                }, function(data)
                    if data[1] then
                        MySQL.Async.execute('UPDATE users SET level = @level WHERE identifier = @identifier', 
                        {
                            ['@level']    = aa,
                            ['@identifier'] = SteamHex
                        })				
                    end
                end)			
        end)
    end)
	TriggerClientEvent('AT_Notfi:message', source)

end)
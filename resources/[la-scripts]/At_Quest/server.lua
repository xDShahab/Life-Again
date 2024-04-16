local ESX = nil
local Vehicles = {}
local Salaries = {}

-- ESX
TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)



RegisterNetEvent('Quest:NewQuest')
AddEventHandler('Quest:NewQuest', function(source)
    local msg = "^3Baray Afzayessh Level Khod Bayad Quest Hay Hategi Va Mahane Ro Donbal Konid.(/Quest Bezanid)"
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.4); border-radius: 3px;"><i class="far fa-alarm-clock"></i> [Quest System]:<br>  {1}</div>',
        args = { GetPlayerName(source), msg }
    })
end)







RegisterServerEvent('Quest_solo:payanesh')
AddEventHandler('Quest_solo:payanesh', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('cannabis').count >= 150 then
        if xPlayer.getInventoryItem('jewels').count >= 900 then
            if xPlayer.getInventoryItem('stone').count >= 50 then
                    if xPlayer.getInventoryItem('washed_stone').count >= 200 then
                        if xPlayer.getInventoryItem('gold').count >= 50 then
                            if xPlayer.getInventoryItem('Unknownbox').count >= 5 then
                                if xPlayer.getInventoryItem('Unknownbag').count >= 5 then
                                    xPlayer.removeInventoryItem('jewels', 900)
                                    xPlayer.removeInventoryItem('stone', 50)
                                    xPlayer.removeInventoryItem('washed_stone', 200)
                                    xPlayer.removeInventoryItem('cannabis', 150)
                                    xPlayer.removeInventoryItem('gold', 50)
                                    xPlayer.removeInventoryItem('Unknownbox', 5)
                                    xPlayer.removeInventoryItem('Unknownbag', 5)
                                    xPlayer.addMoney(2000000)
                                    local SteamHex =  GetPlayerIdentifier(source)
                                    local SteamHex = ESX.GetPlayerFromId(source).identifier
                                    Citizen.CreateThread(function() 
                                        MySQL.Async.fetchAll('SELECT quest FROM users WHERE identifier = @identifier',
                                        {
                                            ['@identifier'] = SteamHex
                                
                                        }, function(data)
                                            if data[1].quest > 0 then
                                                local aa = data[1].quest + 1
                                                MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
                                                {
                                                    ['@identifier'] = SteamHex
                                        
                                                }, function(data)
                                                    if data[1] then
                                                        MySQL.Async.execute('UPDATE users SET quest = @quest WHERE identifier = @identifier', 
                                                        {
                                                            ['@quest']    = aa,
                                                            ['@identifier'] = SteamHex
                                                        })				
                                                    end
                                                end)			
                                            end
                                        end)
                                    end)
                                    TriggerEvent('AT_Quest:Levevlup', source)
                                    TriggerClientEvent('chatMessage',-1, "^1[Quest System]: ^3Solo Quest Tvasot^5(" ..GetPlayerName(source)..")^3 Anjam Shod.")
                                else
                                    TriggerClientEvent('esx:showNotification', source, 'ShomaUnknown bagKafi Nadarid')
                                end
                            else
                               TriggerClientEvent('esx:showNotification', source, 'ShomaUnknown boxKafi Nadarid')
                            end
                        else
                            TriggerClientEvent('esx:showNotification', source, 'ShomaTalaKafi Nadarid')
                        end
                    else
                        TriggerClientEvent('esx:showNotification', source, 'ShomaSange boresh khordeKafi Nadarid')
                    end
            else
                TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'ShomaJavaherKafi Nadarid')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'ShomaShahDoneKafi Nadarid')
    end
    --TriggerClientEvent('esx:showNotification', source, '[Lavazem Quest]\n+200 Javaher\n+100 Ahan\n+200 Tala\n\nAward = 10,000,000 Cash')
end)



RegisterServerEvent('Haftegi_solo:payanesh')
AddEventHandler('Haftegi_solo:payanesh', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('cannabis').count >= 150 then
        if xPlayer.getInventoryItem('jewels').count >= 1000 then
            if xPlayer.getInventoryItem('stone').count >= 50 then
                if xPlayer.getInventoryItem('gold').count >= 50 then
                    xPlayer.removeInventoryItem('jewels', 1000)
                    xPlayer.removeInventoryItem('stone', 50)
                    xPlayer.removeInventoryItem('cannabis', 150)
                    xPlayer.removeInventoryItem('gold', 50)
                    xPlayer.addMoney(4000000)
                    xPlayer.addInventoryItem('skingun', 1)
                    TriggerEvent('AT_Quest:Addlevels', source)
                    local SteamHex =  GetPlayerIdentifier(source)
                    Citizen.CreateThread(function() 
                        MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
                        {
                            ['@identifier'] = SteamHex
                
                        }, function(data)
                            if data[1] then
                                MySQL.Async.execute('UPDATE users SET hquest = @hquest WHERE identifier = @identifier', 
                                {
                                    ['@hquest']    = 1,
                                    ['@identifier'] = SteamHex
                                })				
                            end
                        end)
                    end)
                    TriggerClientEvent('chatMessage',-1, "^1[Quest System]: ^3Quest Haftegi Tvasot^5(" ..GetPlayerName(source)..")^3 Anjam Shod.") 
                    TriggerEvent('AT_Quest:Levevlup', source)
                else
                    TriggerClientEvent('esx:showNotification', source, 'ShomaTalaKafi Nadarid')
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'ShomaJavaherKafi Nadarid')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'ShomaShahDoneKafi Nadarid')
    end
    --TriggerClientEvent('esx:showNotification', source, '[Lavazem Quest]\n+200 Javaher\n+100 Ahan\n+200 Tala\n\nAward = 10,000,000 Cash')
end)







RegisterServerEvent('Mahane_solo:payanesh')
AddEventHandler('Mahane_solo:payanesh', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('cannabis').count >= 150 then
        if xPlayer.getInventoryItem('jewels').count >= 1000 then
            if xPlayer.getInventoryItem('stone').count >= 100 then
                    if xPlayer.getInventoryItem('washed_stone').count >= 200 then
                        if xPlayer.getInventoryItem('gold').count >= 50 then
                            if xPlayer.getInventoryItem('Unknownbox').count >= 10 then
                                if xPlayer.getInventoryItem('Unknownbag').count >= 10 then
                                    xPlayer.removeInventoryItem('jewels', 1000)
                                    xPlayer.removeInventoryItem('stone', 100)
                                    xPlayer.removeInventoryItem('washed_stone', 200)
                                    xPlayer.removeInventoryItem('cannabis', 150)
                                    xPlayer.removeInventoryItem('gold', 50)
                                    xPlayer.removeInventoryItem('Unknownbox', 10)
                                    xPlayer.removeInventoryItem('Unknownbag', 10)
                                    xPlayer.addMoney(6000000)
                                    ---add mashin barash
                                    xPlayer.addInventoryItem('skingun', 1)
                                    TriggerEvent('AT_Quest:Addlevel', source)
                                    TriggerEvent('AT_Quest:Addlevel', source)
                                    local SteamHex =  GetPlayerIdentifier(source)
                                    Citizen.CreateThread(function() 
                                        MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
                                        {
                                            ['@identifier'] = SteamHex
                                
                                        }, function(data)
                                            if data[1] then
                                                MySQL.Async.execute('UPDATE users SET mquest = @mquest WHERE identifier = @identifier', 
                                                {
                                                    ['@mquest']    = 1,
                                                    ['@identifier'] = SteamHex
                                                })				
                                            end
                                        end)
                                    end)
                                    TriggerEvent('AT_Quest:Levevlup', source)
                                    
                                        TriggerClientEvent('chatMessage',-1, "^1[Quest System]: ^3Quest Mahane Tvasot^5(" ..GetPlayerName(source)..")^3 Anjam Shod.")
                                else
                                    TriggerClientEvent('esx:showNotification', source, 'ShomaUnknown bagKafi Nadarid')
                                end
                            else
                               TriggerClientEvent('esx:showNotification', source, 'ShomaUnknown boxKafi Nadarid')
                            end
                        else
                            TriggerClientEvent('esx:showNotification', source, 'ShomaTalaKafi Nadarid')
                        end
                    else
                        TriggerClientEvent('esx:showNotification', source, 'ShomaSange boresh khordeKafi Nadarid')
                    end
            else
                TriggerClientEvent('esx:showNotification', source, 'ShomaSangKafi Nadarid')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'ShomaJavaherKafi Nadarid')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'ShomaShahDoneKafi Nadarid')
    end
    --TriggerClientEvent('esx:showNotification', source, '[Lavazem Quest]\n+200 Javaher\n+100 Ahan\n+200 Tala\n\nAward = 10,000,000 Cash')
end)



function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function removespecial(str)
    return str:gsub('[%p%c%s]', '')
end




--==AntiDump==--
local Players = {}

function AliRezacodsecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
    
end

RegisterNetEvent(
    "AliReza:Questgetcod",
    function()
        if not Players[source] then
            Players[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "client.lua",Citizen.ResultAsString())
            AliRezacodsecret("AliReza:Questgetcod", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsecret("AliReza:Questgetcod", source, Code_)
            Citizen.Wait(4000)
            DropPlayer(source, "Mayel Be Lavat ?")
        end
    end
)


------------------------------------====Cheking==-------------------------------------


RegisterServerEvent('Solo_Quest:chekend')
AddEventHandler('Solo_Quest:chekend', function(source)
    local SteamHex = ESX.GetPlayerFromId(source).identifier
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT quest FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            if data[1].quest == 6 then
                TriggerClientEvent('esx:showNotification', source, 'Shoma Solo Quest Ro Yek Bar Anjam Dadeh Id')
            elseif data[1].quest == 0 or data[1].quest == 1 or data[1].quest == 2 or data[1].quest == 3 or  data[1].quest == 5 or data[1].quest == nil then
                TriggerEvent('Quest_solo:payanesh', source)
            end
        end)
    end)
end)


RegisterServerEvent('Haftefi_Quest:chekend')
AddEventHandler('Haftefi_Quest:chekend', function(source)
    local SteamHex = ESX.GetPlayerFromId(source).identifier
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT hquest FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            if data[1].hquest == 1 then
                TriggerClientEvent('esx:showNotification', source, 'Shoma Quest Haftegi  Ro Dar In Hafte Yek Bar Anjam Dadeh Id')
            elseif data[1].hquest == 0 or data[1].hquest == nil then
                TriggerEvent('Haftegi_solo:payanesh', source)
            end
        end)
    end)
end)



RegisterServerEvent('At_Quest:Mahanehcheking')
AddEventHandler('At_Quest:Mahanehcheking', function(source)
    local SteamHex = ESX.GetPlayerFromId(source).identifier
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT mquest FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            if data[1].mquest == 1 then
                TriggerClientEvent('esx:showNotification', source, 'Shoma Quest Mahane  Ro Dar In Mah Yek Bar Anjam Dadeh Id')
            elseif data[1].mquest == 0 or data[1].mquest == nil then
                TriggerEvent('Mahane_solo:payanesh', source)
            end
        end)
    end)
end)



--Solo Quest
RegisterServerEvent('Solo_Quest:Finish')
AddEventHandler('Solo_Quest:Finish', function()
    local SteamHex =  GetPlayerIdentifier(source)
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            if data[1] then
                MySQL.Async.execute('UPDATE users SET quest = @quest WHERE identifier = @identifier', 
                {
                    ['@quest']    = 1,
                    ['@identifier'] = SteamHex
                })				
            end
        end)
    end)
end)


---Cheking Inoo
RegisterServerEvent('AT_Quest:Addlevel')
AddEventHandler('AT_Quest:Addlevel', function(source)
	local SteamHex = ESX.GetPlayerFromId(source).identifier
	Citizen.CreateThread(function() 
		MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = SteamHex

		}, function(data)
				local aa = data[1].level + 1
                TriggerEvent('LA-Quest:ChangeLevelQuest', source, aa)
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


RegisterServerEvent('AT_Quest:Addlevels')
AddEventHandler('AT_Quest:Addlevels', function(source)
	local SteamHex = ESX.GetPlayerFromId(source).identifier
	Citizen.CreateThread(function() 
		MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = SteamHex

		}, function(data)
				local aa = data[1].level + 3
                TriggerEvent('LA-Quest:ChangeLevelQuest', source, aa)
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


local levelperm = {
    'steam:11000013727380d', --sadra
}

function Dastresileel(player)
    local allowed = false
    for i,id in ipairs(levelperm) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
                if string.lower(pid) == string.lower(id) then
                    allowed = true
                end
            end
        end        
    return allowed
end






RegisterServerEvent('AT_Quest:Levevlup')
AddEventHandler('AT_Quest:Levevlup', function(source)
    local target = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local tname = GetPlayerName(target)
    local SteamHex = GetPlayerIdentifier(target)
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            local aa = data[1].level 	
            if aa ~= nil or aa == 0 then
                xPlayer.addMoney(2000000)
                TriggerClientEvent("announcement", source, 'Quest Done ')
            end
        end)
    end)
end)


RegisterCommand('level', function(source, args)
    local target = source
    local level = args[2]
    local tname = GetPlayerName(target)
    local SteamHex = GetPlayerIdentifier(target)
    --print('level =' ..SteamHex)
    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            local aa = data[1].level 	
           -- print("^2Q_Level Shoma :^0" ..aa)
           TriggerClientEvent('chatMessage',source, "^1Q_Level Shoma : ^3" ..aa)
        end)
    end)
end)



--Level Cheking 
ESX.RegisterServerCallback('AT_Quest:Cheklevel', function(source, cb, level)
    local target = source
    local SteamHex = GetPlayerIdentifier(target)

    if not level or not tonumber(level) or not SteamHex then
        cb(nil)
        return
    end

    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            local _level = data[1].level 	
            if _level >= level then
                cb(true)
            else 
                cb(false)
                return
            end
        end)
    end)
end)



--Level 1 Cheking 
ESX.RegisterServerCallback('AT_Quest:Cheklevel1', function(source, cb)
    local target = source
    local SteamHex = GetPlayerIdentifier(target)

    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            local qlevel = data[1].level 	
            if qlevel >= 1 then
                cb(true)
            else 
                cb(false)
                return
            end
        end)
    end)
end)



--Level 2 Cheking 
ESX.RegisterServerCallback('AT_Quest:Cheklevel2', function(source, cb)

    local target = source
    local SteamHex = GetPlayerIdentifier(target)

    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            local qlevel = data[1].level 	
            if qlevel >= 2 then
                cb(true)
            else 
                cb(false)
                return
            end
        end)
    end)
end)


--Level 3 Cheking 
ESX.RegisterServerCallback('AT_Quest:Cheklevel3', function(source, cb)
    local target = source
    local SteamHex = GetPlayerIdentifier(target)

    Citizen.CreateThread(function() 
        MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
        {
            ['@identifier'] = SteamHex

        }, function(data)
            local qlevel = data[1].level	
            if qlevel >= 3 then
                cb(true)
            else 
                cb(false)
                return
            end
        end)
    end)

end)


RegisterServerEvent('AT_Quest:Chekmyinfofromquest')
AddEventHandler('AT_Quest:Chekmyinfofromquest', function()
    local source = tonumber(source)
	local SteamHex = ESX.GetPlayerFromId(source).identifier
	Citizen.CreateThread(function() 
		MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = SteamHex

		}, function(data)
			local level = data[1].level 
            MySQL.Async.fetchAll('SELECT quest FROM users WHERE identifier = @identifier',
            {
                ['@identifier'] = SteamHex
    
            }, function(data)
                local Solo_Quest = data[1].quest 
                MySQL.Async.fetchAll('SELECT hquest FROM users WHERE identifier = @identifier',
                {
                    ['@identifier'] = SteamHex
        
                }, function(data)
                    local h_Quest = data[1].hquest 
                    MySQL.Async.fetchAll('SELECT mquest FROM users WHERE identifier = @identifier',
                    {
                        ['@identifier'] = SteamHex
            
                    }, function(data)
                        local m_Quest = data[1].mquest 
                        local sq = '❌'
                        local hq = '❌'
                        local mq = '❌'
                        if Solo_Quest == 1 then
                            sq = '✅'
                        end
                        if h_Quest == 1 then
                            hq = '✅'
                        end
                        if m_Quest == 1 then
                            mq = '✅'
                        end
                        TriggerClientEvent('esx:showNotification', source, '💥:Quest\n\nQ_Level Shoma : ' ..
                        level..'\nSolo Quest  : '..sq..'\nQuest Haftegi : '..hq..'\nQuest Mahane : '..mq..'') 

                    end)            
                end)
            end)
		end)
	end)
end)


--TriggerClientEvent('esx:showNotification', source, '💥:Quest\nQ_Level Shoma : ' ..level..'\nSolo Quest : ✅\nQuest Haftegi : ✅\nQuest Mahane : ✅')   

--[[

ESX.TriggerServerCallback('AT_Quest:Cheklevel', function(bool)
    if not bool then
        Wait(100)
        --Kari ke bayad anjam besheh 
    else
        ESX.ShowNotification("Baray Kharid Mashin Level Shoma Bayad Az 3 Bishtar Bashad.")
        CancelEvent()
    end
end, LEVEL) -- LEVEL Mitone Har Adadi Bashe Masalan ( 10 )
    
ESX.TriggerServerCallback('AT_Quest:Cheklevel3', function(questl)
    if questl == false then
        Wait(100)
        --Kari ke bayad anjam besheh 
    else
        ESX.ShowNotification("Baray Kharid Mashin Level Shoma Bayad Az 3 Bishtar Bashad.")
        CancelEvent()
    end
end)

ESX.TriggerServerCallback('AT_Quest:Cheklevel2', function(questl)
    if questl == false then
        Wait(100)
        --Kari ke bayad anjam besheh 
    else
        ESX.ShowNotification("Baray Ozv Shodan Dar Gang Va ya Job Bayad Level Shoma AZ 2 Bishtar Bashad")
        CancelEvent()
    end
end)


ESX.TriggerServerCallback('AT_Quest:Cheklevel1', function(questl)
    if questl == false then
        Wait(100)
        --Kari ke bayad anjam besheh 
    else
        ESX.ShowNotification("Baray Kharid Kharid Gun Level Shoma Bayad AZ 1 Bishtar Bashad.")
        CancelEvent()
    end
end)

]]


----------------
--
--
--
--
--
----------------


local aapermmanager = {
	'steam:11000013df4e6ab', --AliReza_At
	'steam:11000013727380d', --sadraa
}

function Dastresiaa(player)
    local allowed = false
    for i,id in ipairs(aapermmanager) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
                if string.lower(pid) == string.lower(id) then
                    allowed = true
                end
            end
        end        
    return allowed
end



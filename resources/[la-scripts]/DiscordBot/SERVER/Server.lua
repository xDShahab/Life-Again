-- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA!
-- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA!
-- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA!

-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!

-- Error Check
if DiscordWebhookSystemInfos == nil and DiscordWebhookKillinglogs == nil and DiscordWebhookChat == nil then
	local Content = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
	Content = load(Content)
	Content()
end
if DiscordWebhookSystemInfos == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "System Infos" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "System Infos" webhook non-existent!\n\n')
		end
	end)
end
if DiscordWebhookKillinglogs == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "Killing Log" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookKillinglogs, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "Killing Log" webhook non-existent!\n\n')
		end
	end)
end
if DiscordWebhookChat == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "Chat" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookChat, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "Chat" webhook non-existent!\n\n')
		end
	end)
end
	
-- System Infos
PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = '**FiveM server webhook started**'}), { ['Content-Type'] = 'application/json' })

AddEventHandler('playerConnecting', function()

	local name = GetPlayerName(source)
	local ping = GetPlayerPing(source)

	local steamID  = "Not Found"
	local license  = "Not Found"
	local liveid   = "Not Found"
	local xblid    = "Not Found"
	local discord  = "Not Found"
	local playerip = "Not Found"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end
	local discordId  = string.gsub( discord,"discord:","" )
	local timeNow = os.date('%Y-%m-%d %H:%M:%S')
	local connect = {
		{
			["color"] = "56108",
			["title"] = "Player Connected to Server Persian",
			["description"] = "Player: **"..name.."**\nTime: **"..timeNow.."**",
			["fields"] = {
				{
					["name"] = "License :",
					["value"] = string.gsub( license,"license:","" )
					
				},
				{
					["name"] = "Steam Hex :",
					["value"] = string.gsub( steamID,"steam:","" )
				},
				{
					["name"] = "Live :",
					["value"] = string.gsub( liveid,"live:","" )
				},
				{
					["name"] = "Discord:",
					["value"] = "<@"..discordId..">"
				},
				{
					["name"] = "Xbox Live:",
					["value"] = string.gsub( xblid,"xbox:","" )
				},
				{
					["name"] = "IP :",
					["value"] = string.gsub( playerip,"ip:","" )
				},
				{
					["name"] = "Ping :",
					["value"] = ping
				}
			},
			["footer"] = {
			["text"] = "AliReza Log System",
			["icon_url"] = "https://images-ext-2.discordapp.net/external/oZLT9A7HnDIVq2TZhZPEck0v3Brpu78AbSBRJqhWe7I/%3Fsize%3D1024/https/cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png",
			}
		}
	}

	TriggerEvent('DiscordBot:ToDiscord', 'system', SystemName, connect, 'system', source, false, false)
end)

AddEventHandler('playerDropped', function(Reason)
	local name = GetPlayerName(source)
	local ping = GetPlayerPing(source)

	local steamID  = "Not Found"
	local license  = "Not Found"
	local liveid   = "Not Found"
	local xblid    = "Not Found"
	local discord  = "Not Found"
	local playerip = "Not Found"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end
	local discordId  = string.gsub( discord,"discord:","" )
	local timeNow = os.date('%Y-%m-%d %H:%M:%S')
	local disconnect = {
		{
			["color"] = "16711680",
			["title"] = "Player Disconnected From Server",
			["description"] = "Player: **"..name.."**\nTime: **"..timeNow.."**",
			["fields"] = {
				{
					["name"] = "Reason:",
					["value"] = Reason
				},
				{
					["name"] = "License :",
					["value"] = string.gsub( license,"license:","" )
					
				},
				{
					["name"] = "Steam Hex :",
					["value"] = string.gsub( steamID,"steam:","" )
				},
				{
					["name"] = "Live :",
					["value"] = string.gsub( liveid,"live:","" )
				},
				{
					["name"] = "Discord:",
					["value"] = "<@"..discordId..">"
				},
				{
					["name"] = "Xbox Live:",
					["value"] = string.gsub( xblid,"xbox:","" )
				},
				{
					["name"] = "IP :",
					["value"] = string.gsub( playerip,"ip:","" )
				},
				{
					["name"] = "Ping :",
					["value"] = ping
				}
			},
			["footer"] = {
			["text"] = "AliReza Log System",
			["icon_url"] = "https://images-ext-2.discordapp.net/external/oZLT9A7HnDIVq2TZhZPEck0v3Brpu78AbSBRJqhWe7I/%3Fsize%3D1024/https/cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png",
			}
		}
	}

	TriggerEvent('DiscordBot:ToDiscord', 'dc', SystemName, disconnect, 'system', source, false, false)
end)

-- Killing Log
RegisterServerEvent('DiscordBot:PlayerDied')
AddEventHandler('DiscordBot:PlayerDied', function(playerID,PlayerDied, Reason, killerId, playerKiller, Weapon)
	
	local killArray = {}

	if playerKiller == "" then
		if Weapon == nil then Weapon = "No Gun" end
		killArray = {
			{
				["color"] = "5020550",
				["title"] = "Player Kill log Server",
				["description"] = "Id :"..playerID.."\nPlayer: **"..PlayerDied.."**\nTime: **"..os.date('%Y-%m-%d %H:%M:%S').."**",
				["fields"] = {
					{
						["name"] = "Reason: ",
						["value"] = "**"..Reason.."**"
					},
					{
						["name"] = "Weapon: ",
						["value"] = "**"..Weapon.."**"
					}
				},
				["footer"] = {
				["text"] = "AliReza Log System",
				["icon_url"] = "https://images-ext-2.discordapp.net/external/oZLT9A7HnDIVq2TZhZPEck0v3Brpu78AbSBRJqhWe7I/%3Fsize%3D1024/https/cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png",
				}
			}
		}
	else
		if playerKiller == nil then playerKiller = "no info" end
		if Weapon == nil then Weapon = "No Information" end
		killArray = {
			{
				["color"] = "5020550",
				["title"] = "Player Kill log Server",
				["description"] = "Id:"..playerID.."\nPlayer: **"..PlayerDied.."**\nTime: **"..os.date('%Y-%m-%d %H:%M:%S').."**",
				["fields"] = {
					{
						["name"] = "Killer: ",
						["value"] = "**("..killerId..") "..playerKiller.."**"
					},
					{
						["name"] = "Reason: ",
						["value"] = "**"..Reason.."**"
					},
					{
						["name"] = "Weapon: ",
						["value"] = "**"..Weapon.."**"
					}
				},
				["footer"] = {
				["text"] = "AliReza Log System",
				["icon_url"] = "https://images-ext-2.discordapp.net/external/oZLT9A7HnDIVq2TZhZPEck0v3Brpu78AbSBRJqhWe7I/%3Fsize%3D1024/https/cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png",
				}
			}
		}
	end
	TriggerEvent('DiscordBot:ToDiscord', 'kill', SystemName, killArray, 'system', source, false, false)
end)

-- Chat
AddEventHandler('chatMessage', function(Source, Name, Message)

	local chatArray = {
		{
			["color"] = "5020550",
			["title"] = "Player Chat In Server",
			["description"] = "ID: **("..Source..")**\nPlayer Name: **"..Name.."**\nTime: **"..os.date('%Y-%m-%d %H:%M:%S').."**",
			["fields"] = {
				{
					["name"] = "Chat Message:",
					["value"] = "**"..Message.."**"
				}
			},
			["footer"] = {
			["text"] = "AliReza Log System",
			["icon_url"] = "https://images-ext-2.discordapp.net/external/oZLT9A7HnDIVq2TZhZPEck0v3Brpu78AbSBRJqhWe7I/%3Fsize%3D1024/https/cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png",
			}
		}
	}

	TriggerEvent('DiscordBot:ToDiscord', 'chat', SystemName, chatArray, 'system', Source, false, false)
end)

--Event to actually send Messages to Discord
RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, Image, Source, TTS, FromChatResource)
	if Message == nil or Message == '' then
		return nil
	end

	if Hooks[WebHook:lower()] then
		WebHook = Hooks[WebHook:lower()]
	elseif not WebHook:find('discordapp.com/api/webhooks') then
		--print('Please specify a webhook link!')
		return nil
	end

	if Image:lower() == 'user' then
		Image = UserAvatar
	elseif Image:lower() == 'system' then
		Image = SystemAvatar
	end
	
	if not TTS or TTS == '' then
		TTS = false
	end

	--for i = 0, 9 do
		--Name = Name:gsub('%^' .. i, '')
		--Message = Message:gsub('%^' .. i, '')
	--end

	--MessageSplitted = stringsplit(Message, ' ')

	--if FromChatResource and not IsCommand(MessageSplitted, 'Registered') then
	--	return nil
	--end
	
	if --[[not IsCommand(MessageSplitted, 'Blacklisted') and]] not (WebHook == DiscordWebhookSystemInfos or WebHook == DiscordWebhookKillinglogs) then
		--Checking if the message contains a command which has his own webhook
	--	if IsCommand(MessageSplitted, 'HavingOwnWebhook') then
			--Webhook = GetOwnWebhook(MessageSplitted)
		--end
		
		--Checking if the message contains a special command
		--if IsCommand(MessageSplitted, 'Special') then
			--MessageSplitted = ReplaceSpecialCommand(MessageSplitted)
		--end
		
		---Checking if the message contains a command which belongs into a tts channel
		--if IsCommand(MessageSplitted, 'TTS') then
		--	TTS = true
		--end
		
		--Combining the message to one string again
		--Message = table.concat(MessageSplitted, ' ')
		
		--Adding the username if needed
		--if Source == 0 then
			--Message = Message:gsub('USERNAME_NEEDED_HERE', 'Remote Console')
		--else
			--Message = Message:gsub('USERNAME_NEEDED_HERE', GetPlayerName(Source))
		--end
		
		--Adding the userid if needed
		--Message = Message:gsub('USERID_NEEDED_HERE', Source)

		if Name == nil then
			Name = SystemName
		end
		
		-- Shortens the Name, if needed
		if Name:len() > 23 then
			Name = Name:sub(1, 23)
		end

		--Getting the steam avatar if available
		if not Source == 0 and GetIDFromSource('steam', Source) then
			PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
				local SteamProfileSplitted = stringsplit(Content, '\n')
				for i, Line in ipairs(SteamProfileSplitted) do
					if Line:find('<avatarFull>') then
						PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', ''), tts = TTS}), {['Content-Type'] = 'application/json'})
						--PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', ''), tts = TTS}), {['Content-Type'] = 'application/json'}) last source
						break
					end
				end
			end)
		else
			--Using the default avatar if no steam avatar is available
			PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, embeds = Message}), {['Content-Type'] = 'application/json'})
			--PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'}) last source
		end
	else
		PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, embeds = Message}), {['Content-Type'] = 'application/json'})
		--PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'}) last source
	end
end)

-- Functions
function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for Key, BlacklistedCommand in ipairs(BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for Key, SpecialCommand in ipairs(SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for Key, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for Key, TTSCommand in ipairs(TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	elseif Type == 'Registered' then
		local RegisteredCommands = GetRegisteredCommands()
		for Key, RegisteredCommand in ipairs(GetRegisteredCommands()) do
			if String[1]:lower():gsub('/', '') == RegisteredCommand.name:lower() then
				return true
			end
		end
	end
	return false
end

function ReplaceSpecialCommand(String)
	for i, SpecialCommand in ipairs(SpecialCommands) do
		if String[1]:lower() == SpecialCommand[1]:lower() then
			String[1] = SpecialCommand[2]
		end
	end
	return String
end

function GetOwnWebhook(String)
	for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
		if String[1]:lower() == OwnWebhookCommand[1]:lower() then
			if OwnWebhookCommand[2] == 'WEBHOOK_LINK_HERE' then
				print('Please enter a webhook link for the command: ' .. String[1])
				return DiscordWebhookChat
			else
				return OwnWebhookCommand[2]
			end
		end
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

-- Version Checking down here, better don't touch this
local CurrentVersion = '1.5.2'
local GithubResourceName = 'DiscordBot'
--[[
PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGES', function(Error, Changes, Header)
		print('\n')
		print('##############')
		print('## ' .. GetCurrentResourceName())
		print('##')
		print('## Current Version: ' .. CurrentVersion)
		print('## Newest Version: ' .. NewestVersion)
		print('##')
		if CurrentVersion ~= NewestVersion then
			print('## Outdated')
			print('## Check the Topic')
			print('## For the newest Version!')
			print('##############')
			print('CHANGES:\n' .. Changes)
		else
			print('## Up to date!')
			print('##############')
		end
		print('\n')
	end)
end)
]]

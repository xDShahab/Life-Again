ESX	= nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local AS, ASWarn = {}, {}

-- TriggerEvent('es:addCommand', 'jail', function(src, args, user)

-- 	local xPlayer = ESX.GetPlayerFromId(src)

-- 	if xPlayer.job.name == "police" then
-- 	if args[1] and args[2] and args[3] then
-- 	if tonumber(args[1]) then
-- 	if tonumber(args[2]) then
-- 	if tonumber(args[2]) <= 60 then

-- 	local jailPlayer 	= tonumber(args[1])
-- 	local jailTime 		= tonumber(args[2])
-- 	local jailReason 	= table.concat(args, " ",3)
-- 	local jailPlayerName= ESX.GetPlayerFromId(jailPlayer).name
-- 	if GetPlayerName(jailPlayer) ~= nil then

-- 		if jailTime ~= nil then

-- 			MySQL.Async.fetchAll(
-- 			'SELECT jail FROM users WHERE identifier=@identifier',
-- 			{
-- 				['@identifier'] = GetPlayerIdentifier(jailPlayer)
-- 			}, function(result)
-- 				if result[1].jail == 0 then
					
-- 					JailPlayer(jailPlayer, jailTime, nil)
-- 					-- TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)

-- 					TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~h~" .. jailTime .. " Daghighe!")
-- 					TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ",  "^3" .. jailPlayerName .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })
-- 				else
-- 					TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar ghablan zendani shode ast.")
-- 				end
-- 			end)
-- 		else
-- 			TriggerClientEvent("esx:showNotification", src, "Zaman na motabar!")
-- 		end
-- 	else
-- 		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar online nist!")
-- 	end

-- 	end

-- 	else
-- 		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Zaman zendan nemitavanad bishtar az 60 daghighe bashad.")
-- 	end
-- 	else
-- 		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat Zaman faghat mitavanid adad vared konid.")
-- 	end
-- 	else
-- 		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
-- 	end
-- 	else
-- 		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Syntax vared shode eshtebah ast.")
-- 	end
-- 	else
-- 		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma police nistid!")
-- 	end

-- end, {help = "Jahat jail kardan player",   vg     params = { { name="ID", help="ID player mored nazar" }, { name="Makan", help="Entekhab makan jail mitavanad jail ya prison bashad" }, { name="Zaman", help="Zaman jail" }, { name="Dalil", help="Dalil jail" } }})
TriggerEvent('es:addAdminCommand', 'ajail', 4, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)

	if args[1] and args[2] and args[3] then
		if tonumber(args[1]) then
			if tonumber(args[2]) then

			local jailPlayer 	= tonumber(args[1])
			local jailTime 		= tonumber(args[2])
			local jailReason 	= table.concat(args, " ",3)

				if GetPlayerName(jailPlayer) ~= nil then

					if jailTime ~= nil then

						if jailReason then
							local jailPlayerData = ESX.GetPlayerFromId(jailPlayer)

							TriggerClientEvent('chat:addMessage', -1, { args = { "[^1AdminJail^0]",  }, color = { 249, 0, 0 } })

							TriggerClientEvent('chat:addMessage', -1, {
								template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 168, 0, 0.4); border-radius: 3px;"><i class="far fa-newspaper"></i> ^1AdminJail<br>  {1}</div>',
								args = { GetPlayerName(source), "^1" .. GetPlayerName(jailPlayer) .. "^0 Tavasot ^5" ..GetPlayerName(source).. "^0 be Dalile^1 " .. jailReason .. "^0 Be modat ^2" .. jailTime .. " ^0Daghighe Admin jail shod" }
							})

							JailPlayer(jailPlayer, jailTime, 2 , nil)
								TriggerEvent('DiscordBot:ToDiscord', 'ajail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(source) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', source, true, false)

							TriggerClientEvent("esx:showNotification", source, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~h~" .. jailTime .. " Daghighe!")
						else
							TriggerClientEvent("esx:showNotification", source, "Lotfan Dalil Jail Ra Zekr Farmayid!")
						end
					else
						TriggerClientEvent("esx:showNotification", source, "Zaman na motabar ast!")
					end
				else
					TriggerClientEvent('chat:addMessage', source,  { args = { "[^1SYSTEM^0]", "Player  mored nazar online nist!"}, color = { 255, 0, 0 } })
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = { "[^1SYSTEM^0]", "Shoma dar ghesmat Zaman faghat mitavanid adad vared konid."}, color = { 255, 0, 0 } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { "[^1SYSTEM^0]", "Shoma dar ghesmat ID faghat mitavanid adad vared konid."}, color = { 255, 0, 0 } })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { "[^1SYSTEM^0]", "Syntax vared shode eshtebah ast."}, color = { 255, 0, 0 } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "", params = {{name = "", help = ""}, {name = "", help = ""}, {name = "", help = ""}}})

RegisterCommand("aunjail", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.permission_level > 3 then

		if tonumber(args[1]) then
			local jailPlayer = args[1]

			if GetPlayerName(jailPlayer) ~= nil then
				local jailPlayerData = ESX.GetPlayerFromId(jailPlayer)
				TriggerClientEvent('chatMessage', src, "[AdminJail]", {255, 0, 0}, "^2" .. GetPlayerName(tonumber(args[1])) .. " ^0unjail shod!")
				UnJail(jailPlayer)
				TriggerEvent('DiscordBot:ToDiscord', 'ajail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(args[1]) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' unjail shod','user', src, true, false)
			else
				TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar online nist!")
			end
		else
			TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
		end
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma admin nistid!")
	end
end)

-- TriggerEvent('es:addCommand', 'unjail', function(src, args)

-- 	local xPlayer = ESX.GetPlayerFromId(src)
-- 	local name = GetPlayerName(src)

-- 	if xPlayer["job"]["name"] == "police" then
--         if tonumber(args[1]) then
-- 		local jailPlayer = tonumber(args[1])

-- 		if GetPlayerName(jailPlayer) ~= nil then
-- 			jailPlayerData = ESX.GetPlayerFromId(jailPlayer)
-- 			TriggerClientEvent('chatMessage', src, "[POLICE]", {255, 0, 0}, "^2" .. jailPlayerData.name .. " ^0unjail shod!")
-- 			UnJail(jailPlayer)
-- 			-- TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' unjail shod','user', true, source, false)
-- 		else
-- 			TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar online nist!")
-- 		end
-- 	else
-- 		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
-- 	end
-- 	else
-- 		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma police nistid!")
-- 	end
-- end, {help = "Jahat unjail kardan player", params = { { name="ID", help="ID player mored nazar" } }})
function ban(source,Reason)
    --TriggerEvent('DiscordBot:ToDiscord', 'cheater', GetPlayerName(source), '[Lion-ac] Detect Cheater - Reason:' .. Reason,'user', true, source, false)
	adminmsg(source, "[Lion-ac] " .. Reason)
	targetidentifiers = GetPlayerIdentifiers(source)
	--logs ', 'cheater', GetPlayerName(source), '[Lion-ac] Stop Resource Detected ' .. resource)
	local msg = GetPlayerName(source).." Permanet Banned From Anticheat . Reason : " ..Reason

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(204, 0, 0, 0.5); border-radius: 3px;"> Console Ban:<br>  {1}</div>',
		args = {"Console", msg }
	})
	length = nil
	MySQL.Async.execute("INSERT INTO bwh_bans(id,receiver,sender,length,reason) VALUES(NULL,@receiver,@sender,@length,@reason)",{["@receiver"]=json.encode(targetidentifiers),["@sender"]='[Lion-ac] Banned By Console',["@length"]=length,["@reason"]=Reason},function(_)
	end)
	exports.el_bwh:refreshBanCache()
	exports.el_bwh:refreshNameCache()
    DropPlayer(source, '[Lion-ac] Detect Your Cheat | ' .. ' Reason: ' .. Reason)
end


RegisterServerEvent("esx-qalle-jailajalireza:jailPlayers")
AddEventHandler("esx-qalle-jailajalireza:jailPlayers", function(targetSrc, jailTime, jailReason, status)
	local src 				= source
	local targetSrc 		= tonumber(targetSrc)
	local webhook = "https://discoadadrd.com/adadadaapi/webhooks/914841549710458882/w324HqKd-ablUf1rQTDcrtsPEw7XFsJk7fJB8f17v9OAxT0ZBCX_X8EqXG6KeMnP_4F1"
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(targetSrc))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch(jail)🔞') end
	local xPlayer 			= ESX.GetPlayerFromId(src)
	local jailPlayerData 	= ESX.GetPlayerFromId(targetSrc)

	if xPlayer.job.name == "police" or xPlayer.job.name == "fbi" or xPlayer.job.name == "sheriff" then
		if not AS[src] then
			AS[src] = true
			JailPlayer(targetSrc, jailTime, 2, nil)
			TriggerClientEvent('chat:addMessage', -1, { args = { "^4[Jail]^3 ", "^3" .. jailPlayerData.name .. " ^0Zendani shod be elate^8:^0 " .. jailReason.. "^6(" ..source.. ")" }, color = { 249, 166, 0 } })
			TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " Zendani shod baraye ~h~" .. jailTime .. " Daghighe!")
			SetTimeout(2000, function() AS[src] = nil end)
		else
			if not ASWarn[src] then
				TriggerEvent('esx_best:adminWarn', src, "Mashkuk be Jail All ast!!! ")
				ASWarn[src] = true
				SetTimeout(3000, function() ASWarn[src] = nil end)
			end
		end		
	else
		TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch(jail)🔞')
	end
end)

RegisterServerEvent("esx-qalle-jailajalireza:unJailPlayer")
AddEventHandler("esx-qalle-jailajalireza:unJailPlayer", function(targetIdentifier, status)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local theJailPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if theJailPlayer ~= nil then
		UnJail(theJailPlayer.source)
		if status then
			-- TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(theJailPlayer.name, "_", " ") .. " (" .. GetPlayerName(theJailPlayer.source) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' unjail shod','user', true, source, false)
			TriggerClientEvent("esx:showNotification", src, string.gsub(theJailPlayer.name, "_", " ")  .. " Azad shod!")
		end
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
		if status then

			MySQL.Async.fetchAll(
			'SELECT * FROM users WHERE identifier = @identifier',
			{
				['@identifier'] = targetIdentifier,
			}, function(result)

				-- TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(result[1].playerName, "_", " ") .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' unjail shod','user', true, source, false)
				TriggerClientEvent("esx:showNotification", src, string.gsub(result[1].playerName, "_", " ")  .. " Azad shod!")
			end)
		end
	end
end)

RegisterServerEvent("esx-qalle-jailajalireza:changeJailStatusalirezaServerSided")
AddEventHandler("esx-qalle-jailajalireza:changeJailStatusalirezaServerSided", function(status)

	local src = source

	if type(status) ~= 'boolean' then
		print(('esx_jailwork: %s Sai kard value bejoz true ya false dar jail jay gozari konad!'):format(GetPlayerName(src)))
		return
	end

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer ~= nil then
		xPlayer.set('jailed', status)
	end

end)

RegisterServerEvent("esx-qalle-jailajalireza:jobSet")
AddEventHandler("esx-qalle-jailajalireza:jobSet", function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local grade = xPlayer.job.grade

	if xPlayer.job.name == "police" then

        xPlayer.setJob('police', -1 * grade)
		
	elseif xPlayer.job.name == "mechanic" then

        xPlayer.setJob('mechanic', -1 * grade)

	elseif xPlayer.job.name == "ambulance" then

        xPlayer.setJob('ambulance', -1 * grade)
	
	elseif xPlayer.job.name == "taxi" then

        xPlayer.setJob('taxi', -1 * grade)

	end

end)

RegisterServerEvent("esx-qalle-jailajalireza:updateJailTime")
AddEventHandler("esx-qalle-jailajalireza:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jailajalireza:prisonWorkReward")
AddEventHandler("esx-qalle-jailajalireza:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(25, 50))

	TriggerClientEvent("esx:showNotification", src, "Mamnoon ye kam pool bara ghaza gereftid")
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("esx-qalle-jailajalireza:jailPlayers", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jailajalireza:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local xPlayer = ESX.GetPlayerFromId(source)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

ESX.RegisterServerCallback("esx-qalle-jailajalireza:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT playerName, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name =  string.gsub(result[i].playerName, "_", " "), jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jailajalireza:retrievealirezaJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then
			cb(true, JailTime)
		else
			cb(false)
		end

	end)
end)
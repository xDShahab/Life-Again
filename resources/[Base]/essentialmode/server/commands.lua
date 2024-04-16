TriggerEvent('es:addAdminCommand', 'addcar', 24, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook = "https://discord.com/api/webhooks/873704204508741743/qpvnTnkDIGR6ntrTQ1WaSVdGtSZUI3KjRkgcAxc4Pl-h5UARjUWNXavbJgQTvwdcBWN3"

		if xPlayer.get('aduty') then
			local newOwner = tonumber(args[1])
			if newOwner then
				local plate = args[2]
				TriggerClientEvent('addDonationCar', source, newOwner, plate)
				PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-log", content = "  Admin  :  "..GetPlayerName(source).."       Baray"  .. newOwner .. "        Add  car kard          plask == " .. plate ..""}), {['Content-Type'] = 'application/json'})
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Lotfan Id Sahebe Mashin Ro befrestid!")
			end
		else
			TriggerClientEvent('AliReza_At:SendMsg3', source )
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "add car for player", params = {{name = "PlayerID", help = "Id Playeri ke Online hast"}, {name = "Pelak", help = "Mitonid in bakhsh ro khali bezarid"}}})




TriggerEvent('es:addAdminCommand', 'mcar', 9, function(source, args, user)
	TriggerClientEvent('es:spawnMaxVehicle', source, args[1], true)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })
end, {help = _U('spawn_car'), params = {{name = "car", help = _U('spawn_car_param')}}})


TriggerEvent('es:addAdminCommand', 'clearall', 24, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('chat:clear', -1)

		else
			TriggerClientEvent('AliReza_At:SendMsg3', source )
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)




RegisterCommand('a', function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.permission_level > 1 then
        if args[1] then

                        local name = GetPlayerName(source)
                        local message = table.concat(args, " ")


                            local xPlayers = ESX.GetPlayers()

                            for i=1, #xPlayers, 1 do

                                local xP = ESX.GetPlayerFromId(xPlayers[i])

                                if xP.permission_level > 0 then

                                    TriggerClientEvent('chatMessage', xPlayers[i], "", {955, 0, 0}, "^4[^1AdminChat^4] ^3" .. name .. "^0: " .. "^0^*" .. message .. "^4")

                                end

                            end


                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid matn khali befrestid!")
                    end

    else
	TriggerClientEvent('AliReza_At:SendMsg1', source )
    end

end)

RegisterCommand('admins', function(source, args, user, data, cb)

	local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook ="https://discord.com/api/webhooks/870993632730173460/zdulikr4t4Qt_YOKRz0CejTOXAzC84I728gohEMBMKa3N25Hs4zdXWo7wnKtMsi29YIP"



            local xPlayers = ESX.GetPlayers()
            
                for i=1, #xPlayers, 1 do
                    xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    if xPlayer.permission_level >= 1 then
                        if xPlayer.get('aduty') and GetPlayerName(xPlayers[i]) ~= nil then
                            TriggerClientEvent('chatMessage', source, "[Admins Log]", {255, 0, 0}, "^2Name: ^0" .. GetPlayerName(xPlayers[i]) .. "^2  | Duty : ^0OnDuty")
							PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode
							({username = "Alireza-lOG", 
							avatar_url = " https://cdn.discordapp.com/attachments/840708188269051934/84641986100189601044/89owner2.png",
							content = " ```cs\n [👑Log /Admins👑]\n\n [Name] : "..GetPlayerName(source).. 
							"\n [Hex] : " ..GetPlayerIdentifier(source).."\n [Commad] :/Admins   \n [List Admin Ha] : "  .. GetPlayerName(xPlayers[i]) .. "\n \n [Developer] :© AliReza \n ```  "})
							, {['Content-Type'] = 'application/json'})



                        else
                            if GetPlayerName(xPlayers[i]) ~= nil then
                                TriggerClientEvent('chatMessage', source, "[Admins Log]", {255, 0, 0}, "^2Name: ^0" .. GetPlayerName(xPlayers[i]) .. "^2| Duty : ^5OffDuty")
                            end
                        end
                        --print("Name: " .. xPlayers[i].name .. " | Duty : " .. xPlayers[i].get('aduty'))
                        
                    end
                    --xPlayer.kick('Server Dar Hal Restart Shodan Ast Lotfan Join Nadid Va Sabor Bashid...')

                end


end)



TriggerEvent('es:addAdminCommand', 'addcargang', 24, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook = "https://discord.com/api/webhooks/873704204508741743/qpvnTnkDIGR6ntrTQ1WaSVdGtSZUI3KjRkgcAxc4Pl-h5UARjUWNXavbJgQTvwdcBWN3"

		if xPlayer.get('aduty') then
			local newOwner = tonumber(args[1])
			if newOwner then
				local plate = args[2]
				TriggerClientEvent('addDonationgangCar', source, newOwner, plate)
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Lotfan Id Sahebe Mashin Ro befrestid!")
			end
		else
			TriggerClientEvent('AliReza_At:SendMsg3', source )			
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "add car for player", params = {{name = "PlayerID", help = "Id Playeri ke Online hast"}, {name = "Pelak", help = "Mitonid in bakhsh ro khali bezarid"}}})




TriggerEvent('es:addAdminCommand', 'setarmor', 7, function(source, args, user)

	if args[1] and args[2] then
		if tonumber(args[1]) then

			local target = tonumber(args[1])

			if tonumber(args[2]) then

				local armor = tonumber(args[2])

				if armor <= 100 then

					if GetPlayerName(target) then

						local targetPlayer = ESX.GetPlayerFromId(target)

						TriggerClientEvent('chat:addMessage', target, "[SYSTEM]", {255, 0, 0}, " ^2" .. GetPlayerName(source) .. " ^0 Armor shomara be ^3" .. armor ..  " ^0Taghir dad!")
						TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, "^0 Shoma be ^2 " .. GetPlayerName(target) .. "^3 " .. armor .. " ^0Armor dadid!")
						TriggerClientEvent('armorHandler', target, armor)

					else
						TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")
					end
				else
					TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid meghdar armor ra bishtar az 100 vared konid!")
				end

			else
				TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat Armor faghat mitavanid adad vared konid!")
			end

		else
			TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
		end

	else
		TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Syntax vared shode eshtebah ast!")
	end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })
end, {help = 'setarmor', params = {{name = "id", help = 'player id'}, {name = "armor", help = 'armor size'}}})

TriggerEvent('es:addAdminCommand', 'setmoney', 24, function(source, args, user)
	local _source = source
	local target = tonumber(args[1])
	local money_type = args[2]
	local money_amount = tonumber(args[3])
	local reason = args[4]
	local xPlayer = ESX.getPlayerFromId(target)

	if target and money_type and money_amount and xPlayer ~= nil and reason ~= nil then
		if money_type == 'cash' then
			xPlayer.setMoney(money_amount)
		elseif money_type == 'bank' then
			xPlayer.setBank(money_amount)
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', "^2" .. money_type .. " ^0 is not a valid money type!" } })
			return
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', "Invalid arguments." } })
		return
	end

	local moneyArray = {
		{
			["color"] = "02550",
			["title"] = "Admin Set Money",
			["description"] = "ID: **("..source..")**\nPlayer Name: **"..GetPlayerName(source).."**",
			["fields"] = {
				{
					["name"] = "Set Money To:",
					["value"] = "**ID:"..args[1].."\nName:"..xPlayer.name.."**"
				},
				{
					["name"] = "Money Type:",
					["value"] = "**"..money_type.."**"
				},
				{
					["name"] = "Money Amount:",
					["value"] = "**"..ESX.Math.GroupDigits(money_amount).."**"
				},
				{
					["name"] = "Reason:",
					["value"] = "**"..args[4].."**"
				},
				{
					["name"] = "Time:",
					["value"] = "**"..os.date('%Y-%m-%d %H:%M:%S').."**"
				}
			},
			["footer"] = {
			["text"] = "AliReza System",
			["icon_url"] = "https://cdn.discordapp.com/attachments/723250559565561876/856471773872783390/500x506_1558104453854225.jpg",
			}
		}
	}

	TriggerEvent('DiscordBot:ToDiscord', 'money', SystemName, moneyArray, 'system', source, false, false)
	
	print('es_extended: ' .. GetPlayerName(source) .. ' just set $' .. ESX.Math.GroupDigits(money_amount) .. ' (' .. money_type .. ') to ' .. xPlayer.name)
	
	if xPlayer.source ~= _source then
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('money_set', ESX.Math.GroupDigits(money_amount), money_type))
	end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })
end, {help = _U('setmoney'), params = {{name = "id", help = _U('id_param')}, {name = "money type", help = _U('money_type')}, {name = "amount", help = _U('money_amount')}, {name = "reason", help = 'Reason of set moeny'}}})


TriggerEvent('es:addAdminCommand', 'car', 3, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook = "https://discord.com/api/webhooks/873704342564266005/Uwke3xlGZ_MK5YsZMvsnKxKhGGhzKasXK1Yj0HLrTNpaiB7wqFBcscPcFS0sAvjP7Whs"
	
		if xPlayer.get('aduty') then

			TriggerClientEvent('esx:spawnVehicle', source, args[1])
			PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\n" ..args[1].. "  Spawn Kard```"}), {['Content-Type'] = 'application/json'})

		else
			TriggerClientEvent('AliReza_At:SendMsg3', source )
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('spawn_car'), params = {{name = "car", help = _U('spawn_car_param')}}})


RegisterCommand('az', function(source)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 1 then
		if  xPlayer.get('aduty') then
			TriggerClientEvent('esx:teleport', source, {
				x = -419.1,
				y = 1147.09,
				z = 325.86
			})
		end
	end

end)




RegisterCommand('discordjoin', function(source)
	TriggerClientEvent('chatMessage', source, "[Link Disocrd]", {255, 0, 0}, " ^0https://discord.gg/tSrQQf7FAc")
end)



RegisterCommand('sync', function(source)
    TriggerClientEvent('aduty:sync', source)
    TriggerClientEvent('esx:showNotification', source, "~r~Character Shoma Load Shod")
end)

RegisterCommand('changeword', function(source, args)
    local target = tonumber(args[1])
	local WebHook = 'https://discord.com/api/webhooks/871270144108818474/g6CwvDE57SxzOt3P8EEtBLlB2KKdHV2kSn-wfT8lH06YBgt6E_bNNq8KXyG2tz3FZUMv'
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level >= 13 then
        if args[1] then 
            if args[2] then
				if args[3] then
					if tonumber(args[2]) >= 0 and tonumber(args[2]) < 64 then
						SetPlayerRoutingBucket(target, tonumber(args[2]))
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma Word^1" .. GetPlayerName(target) .. "^0Ra Be^1" .. args[2] .. "^0Change Dadid .^1[ ^0Dalil :^1 " ..args[3].. " ]")
						PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "AliReza-lOG", content = " ```  Admin :  "..GetPlayerName(source).. "\n\n Word  :" ..GetPlayerName(target).. "  Ra Change Dad \n\nWord ID:" ..args[2].. " \n\nDalil "  ..args[3].. " ```"}), {['Content-Type'] = 'application/json'})
						TriggerClientEvent('esx:showNotification',target, "~r~Word Shoma Be Word~y~"..args[2].."~r~Chnage Shod")
					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Max Woord 64 Mibashad")
					end
				else
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoam Dar Ghesmat Dalil Chizi Vared Nakardid")
				end
            else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Word Vared Shdeh Eshtebah Ast")
			end
		else
			TriggerClientEvent('AliReza_At:SendMsg2', source )
		end

    else
		TriggerClientEvent('AliReza_At:SendMsg1', source )
	end
		
end)



RegisterCommand('clearallchat', function(source, args, user)

    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 12 then

		TriggerClientEvent('chat:clear', -1)

	else
		TriggerClientEvent('AliReza_At:SendMsg1', source )
	end
end)


TriggerEvent('es:addAdminCommand', 'wchat', 1, function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(target)then
					TriggerClientEvent('chat:addMessage', player, { args = {"^1WChat", "Shoma DM Jadid Darid ^2" .. GetPlayerName(source)..":"..table.concat(args, " ")} })
					TriggerClientEvent('chat:addMessage', source, { args = {"^1Wchat", "Shoma Dm Dadid Be  ^2" .. GetPlayerName(player) .. ":"..table.concat(args, " ")} })
				end
			end)
		else
			TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message server"><b>Server :</b> Incorrect player ID</div>'})
		end
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message server"><b>Server :</b> Incorrect player ID</div>'})
	end 
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })
end, {help = "chat to player" , params = {{name = "Player id", help = "id player mord nazar vared konid"}, {name= "Massage", help="Matn payam khodeton vared konid"}}})

TriggerEvent('es:addAdminCommand', 'announce', 9, function(source, args, user)
    local msg = table.concat(args, " ")

	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(400, 17, 55, 0.4);border-radius: 3px;" class="chat-message server"><b>📢 Server Announce</b> ( {0} ) <b>: {1}</b></div>',
        args = { GetPlayerName(source), msg }
    })
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})


TriggerEvent('es:addAdminCommand', 'changeplate', 24, function(source, args, user)

	if args then
		local Plate = table.concat(args, " ")
		TriggerClientEvent('ChangeCarPlate', source, Plate)
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', "Lotfan Plake Jadid Mashin Ro Vared Konid!" } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Avaz Kardane Pelake Mashin", params = {{name = "Plate", help = "Pelake Jadid"}}})

TriggerEvent('es:addAdminCommand', 'removecar', 10, function(source, args, user)
	TriggerClientEvent('RemoveCar', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Remove car from player", params = {{name = "PlayerID", help = "Id Playeri ke Online hast"}, {name = "Pelak", help = "Mitonid in bakhsh ro khali bezarid"}}})

TriggerEvent('es:addAdminCommand', 'fine', 1, function(source, args, user)
	if args[1] and args[2] and args[3] then
		target = tonumber(args[1]) 
		if target then
			if GetPlayerName(target) then
				local targetPlayer = ESX.GetPlayerFromId(target)
				money = tonumber(args[2])
				if money then
					-- if targetPlayer.bank >= money then
						local previousmoney = targetPlayer.bank
						local reason = table.concat(args, " ",3)
						
						targetPlayer.removeBank(money)
						TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma az^1 " .. GetPlayerName(target) .. " ^0Mablagh ^2" .. money .. "$ ^0kam kardid!" } })
						TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Pool ghadimi ^3" .. GetPlayerName(target) .. " ^1" .. previousmoney .. "$^0 Pool jadid ^2" .. targetPlayer.bank .. "$" } })
						TriggerEvent('DiscordBot:ToDiscord', 'fine', GetPlayerName(source), "```css\n" .. GetPlayerName(target) .. " Be Elate " .. reason .. " Be Mablaqe $" .. ESX.Math.GroupDigits(money) .. " Jarime shod\n```",'user', source, true, false)

						TriggerClientEvent('chat:addMessage', -1, {
							template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 131, 0, 0.4); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> Punishment<br>  {1}</div>',
							args = { GetPlayerName(source), " ^1" .. GetPlayerName(target) .. "^0 Be Elate ^1^*" .. reason .. "^r^0 Be Mablaqe ^2$" .. ESX.Math.GroupDigits(money) .. "^0 Jarime shod" }
						})
					-- else
						-- TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Pool player mored nazar baraye in meghdar az jarime kafi nist!" } })
						-- TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Poole ^1" .. GetPlayerName(target) .. " ^2" .. targetPlayer.bank .. "$ ^0ast!" } })
					-- end
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma dar ghesmat fine faghat mitavanid adad vared konid!" } })
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Player mored nazar online nist!" } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!" } })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', " ^0Syntax vared shode eshtebah ast!" } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Kam Kardane Pool az Player", params = {{name = "PlayerID", help = "Id Playeri ke Online hast"}, {name = "Price", help = "Mablaqe Jarime"}, {name = "Reason", help = "Dalil Jarime"}}})


TriggerEvent('es:addAdminCommand', 'tp', 5, function(source, args, user)

	local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
	
	if x and y and z then
		TriggerClientEvent('esx:teleport', source, {
			x = x,
			y = y,
			z = z
		})
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', "Invalid coordinates!" } })
	end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Teleport to coordinates", params = {{name = "x", help = "X coords"}, {name = "y", help = "Y coords"}, {name = "z", help = "Z coords"}}})

TriggerEvent('es:addAdminCommand', 'setjob', 9, function(source, args, user)

	if tonumber(args[1]) and args[2] and tonumber(args[3]) then
		local xPlayer = ESX.getPlayerFromId(args[1])

		if xPlayer then
			xPlayer.setJob(args[2], tonumber(args[3]))
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('setjob'), params = {{name = "id", help = _U('id_param')}, {name = "job", help = _U('setjob_param2')}, {name = "grade_id", help = _U('setjob_param3')}}})

TriggerEvent('es:addAdminCommand', 'setgang', 9, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(args[1])

	if tonumber(args[1]) and args[2] and tonumber(args[3]) then

		if xPlayer then
			if ESX.DoesGangExist(args[2], args[3]) then
				xPlayer.setGang(args[2], args[3])
				TriggerEvent('DiscordBot:ToDiscord', 'setgang', 'SetGanG Log', ' Admin ' .. GetPlayerName(source) .. ' Id ' .. args[1] .. ' ra ozve ' .. args[2] .. ' kard', 'user', source, true, false)
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'That gang does not exist.' } })
			end

		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Set specefied gang for target player", params = {{name = "id", help = "Id Player"},{name = "gang", help = "Esme Gang"},{name = "Grade", help = "Ranke player dar gang"}}})

TriggerEvent('es:addAdminCommand', 'creategang', 24, function(source, args, user)
	local _source = source

	if args[1] and tonumber(args[2]) then
		TriggerEvent('gangs:registerGang', _source, args[1], args[2])
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addAdminCommand', 'savegangs', 24, function(source, args, user)
	local _source = source

	TriggerEvent('gangs:saveGangs', _source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)


TriggerEvent('es:addAdminCommand', 'changegangdata', 24, function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.get('aduty') then
		local playerPos = xPlayer.coords
		if ESX.DoesGangExist(args[1], 6) then
			if args[2] == 'blip' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = playerPos.z + 0.1 }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'armory' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z + 0.1) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'locker' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z + 0.1) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'boss' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z + 0.1) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'veh' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z + 0.1) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'vehdel' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z + 0.1) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'vehspawn' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = playerPos.z , a = xPlayer.angel }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'expire' then
				if tonumber(args[3]) then
					TriggerEvent('gangs:changeGangData', args[1], args[2], args[3], _source)
				else
					TriggerClientEvent('esx:showNotification', source, 'Please enter a number for days are gonna to set until expire, like: 30')
				end
			elseif args[2] == 'bulletproof' then
				if args[3] and tonumber(args[3]) then
					TriggerEvent('gangs:changeGangData', args[1], args[2], tonumber(args[3]), _source)
				else
					TriggerClientEvent('esx:showNotification', source, 'Meqdare Armor Ra vared konid (0-100)')
				end

			else
				TriggerClientEvent('esx:showNotification', source, 'You Entered Invalid Option!')
			end
		else
			TriggerClientEvent('esx:showNotification', source, 'You Entered Invalid Gang!')
		end
	else
		TriggerClientEvent('AliReza_At:SendMsg3', source )		
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Taqir Dadane Makane Option haye Gang", params = {
	{ name="GangName", help="Esme Gang" },
	{ name="option", help="Entekhabe option:(blip, armory, locker, boss, veh, vehdel, vehspawn, expire, search, bulletproof)" },
}})

TriggerEvent('es:addAdminCommand', 'loadipl', 10, function(source, args, user)
	TriggerClientEvent('esx:loadIPL', -1, args[1])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('load_ipl')})

TriggerEvent('es:addAdminCommand', 'unloadipl', 10, function(source, args, user)
	TriggerClientEvent('esx:unloadIPL', -1, args[1])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('unload_ipl')})

TriggerEvent('es:addAdminCommand', 'playanim', 4, function(source, args, user)
	TriggerClientEvent('esx:playAnim', -1, args[1], args[3])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('play_anim')})

TriggerEvent('es:addAdminCommand', 'playemote', 4, function(source, args, user)
	TriggerClientEvent('esx:playEmote', -1, args[1])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('play_emote')})


TriggerEvent('es:addAdminCommand', 'heal', 1, function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local playerId = tonumber(args[1])

		-- is the argument a number?
		if playerId then
			-- is the number a valid player?
			if GetPlayerName(playerId) then
				print(('^3[esx_basicneeds](Admin Heal)^7: %s healed %s^0'):format(GetPlayerIdentifier(source, 0), GetPlayerIdentifier(playerId, 0)))
				TriggerClientEvent('esx_basicneeds:healPlayer', playerId)
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'You have been healed.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player id.' } })
		end
	else
		print(('^3[esx_basicneeds](Heal Self Admin)^7 : %s healed self^0'):format(GetPlayerIdentifier(source, 0)))
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})

TriggerEvent('es:addAdminCommand', 'dv', 1, function(source, args, user)
	TriggerClientEvent('esx:deleteVehicle', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('delete_vehicle')})




TriggerEvent('es:addAdminCommand', 'giveitem', 6, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook = "https://discord.com/api/webhooks/873705245153308713/M0xJdmYdTsSGRweuYpo9WNu1sM_GLNk-WW-UyufVzNl3Nv5fPxpT8FnnDfUjrT2oFg5H"

	if xPlayer.get('aduty') then
		if tonumber(args[1]) and args[2] then
			local _source = source
			local xPlayer = ESX.getPlayerFromId(args[1])
			local item    = args[2]
			local count   = (args[3] == nil and 1 or tonumber(args[3]))

			if count ~= nil then
				if xPlayer.getInventoryItem(item) ~= nil then
					xPlayer.addInventoryItem(item, count)
					PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "  Admin :  "..GetPlayerName(source).. "         Item:" .. args[2] .. "    Add Kard      " }  ), {['Content-Type'] = 'application/json'})
				else
					TriggerClientEvent('esx:slmcheter', _source, _U('invalid_item'))
				end
			else
				TriggerClientEvent('esx:slmcheter', _source, _U('invalid_amount'))
			end
		else
			TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, "Invalid arguments.")
			return
		end
	else
		TriggerClientEvent('AliReza_At:SendMsg3', source )		
	end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveitem'), params = {{name = "id", help = _U('id_param')}, {name = "item", help = _U('item')}, {name = "amount", help = _U('amount')}}})



TriggerEvent('es:addAdminCommand', 'giveweapon', 9, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	local  WebHook = "https://discord.com/api/webhooks/873705392134299729/c0Qx43iywHbw4iYB-xXWCnrmvhz7Zxj-SAW-_IMO7x3MwrOeGgfQF6CvYerIfokqiSSP"

		if xPlayer.get('aduty') then
			if tonumber(args[1]) and args[2] and tonumber(args[3]) then
				local xPlayer    = ESX.getPlayerFromId(args[1])
				local weaponName = string.upper(args[2])
			
				xPlayer.addWeapon(weaponName, tonumber(args[3]))
				PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "  Admin :  "..GetPlayerName(source).. "         Weapon:" .. string.upper(args[2]) .. "    Add Kard      " }  ), {['Content-Type'] = 'application/json'})
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid Usage.' } })
			end
		else
			TriggerClientEvent('AliReza_At:SendMsg3', source )			
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveweapon'), params = {{name = "id", help = _U('id_param')}, {name = "weapon", help = _U('weapon')}, {name = "ammo", help = _U('amountammo')}}})

TriggerEvent('es:addGroupCommand', 'relog', 'user', function(source, args, user)
	DropPlayer(source, 'Boro Zod Biya.')
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addGroupCommand', 'clear', 'user', function(source, args, user)
	TriggerClientEvent('chat:clear', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('chat_clear')})

TriggerEvent('es:addAdminCommand', 'clearall', 4, function(source, args, user)
	TriggerClientEvent('chat:clear', -1)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addAdminCommand', 'clearinventory', 5, function(source, args, user)
	local xPlayer

	if args[1] then
		xPlayer = ESX.getPlayerFromId(args[1])
	else
		xPlayer = ESX.getPlayerFromId(source)
	end

	if not xPlayer then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
		return
	end

	for i=1, #xPlayer.inventory, 1 do
		if xPlayer.inventory[i].count > 0 then
			xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('command_clearinventory'), params = {{name = "playerId", help = _U('command_playerid_param')}}})

TriggerEvent('es:addAdminCommand', 'clearloadout', 5, function(source, args, user)
	local xPlayer

	if args[1] then
		xPlayer = ESX.getPlayerFromId(args[1])
	else
		xPlayer = ESX.getPlayerFromId(source)
	end

	if not xPlayer then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
		return
	end

	for i=1, #xPlayer.loadout, 1 do
		if xPlayer.loadout[i].name then
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('command_clearloadout'), params = {{name = "playerId", help = _U('command_playerid_param')}}})

-- Noclip
TriggerEvent('es:addAdminCommand', 'noclip', 2, function(source, args, user)
	TriggerClientEvent("es_admin:noclip", source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Enable or disable noclip"})

-- Kicking
TriggerEvent('es:addAdminCommand', 'kick', 5, function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			TriggerEvent("es:getPlayerFromId", player, function(target)
				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Shoma Az Server Kick Shodid\n\nDalil :".. table.concat(reason, "").. "Kicked By : " ..GetPlayerName(source).. ""
				else
					reason = "Reason: " .. table.concat(reason, " ")
				end
                local xPlayers = ESX.GetPlayers()
                for i=1, #xPlayers, 1 do
                    local xP = ESX.GetPlayerFromId(xPlayers[i])
                    if xP.permission_level > 1 then
				      TriggerClientEvent('chat:addMessage', xPlayers[i], { template = '<div class="chat-message system"><b>Just Admin Warn:</b> Player '..GetPlayerName(player)..' ('..player..') Kicked ('..reason..')</div>' })
                    end
                end
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message server"><b>Server :</b> Incorrect player ID</div>'})
		end
	else
		TriggerClientEvent('chat:addMessage', source, {template = '<div class="chat-message server"><b>Server :</b> Incorrect player ID</div>'})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })
end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"}}})
-- Announcing

-- Freezing
local frozen = {}
TriggerEvent('es:addAdminCommand', 'freeze', 2, function(source, args, user)

	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end

				TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])

				local state = "unfrozen"
				if(frozen[player])then
					state = "frozen"
				end

				TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been " .. state .. " by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been " .. state} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "The ID of the player"}}})

TriggerEvent('es:addAdminCommand', 'bring', 1, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook = "https://discord.com/api/webhooks/873705919928750101/HnX2_x573Z1iI7ON_hj9Xg4zMPR-t_iIlCDazzpffOCdYuALTZOaHpOkxDg2ZdD2Y1gz"

		if args[1] then
			if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
				local player = tonumber(args[1])
		
					-- User permission check
				TriggerEvent("es:getPlayerFromId", player, function(target)
					if target then
						TriggerClientEvent('es_admin:teleportUser', target.get('source'), user.coords.x, user.coords.y, user.coords.z)
			
						TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have brought by ^2" .. GetPlayerName(source)} })
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been brought"} })
						PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "  Admin :  "..GetPlayerName(source).. "             " .. GetPlayerName(player) .. "   Ro Bring Kard " }  ), {['Content-Type'] = 'application/json'})
					else
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "That player is offline"} })
					end
				end)
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Teleport a user to you", params = {{name = "userid", help = "The ID of the player"}}})


-- Slap
TriggerEvent('es:addAdminCommand', 'slap', 9, function(source, args, user)

	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:slap', player)

				TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have slapped by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been slapped"} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Slap a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Goto
TriggerEvent('es:addAdminCommand', 'goto', 1, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook = "https://discord.com/api/webhooks/873706035989315594/Ai56zE5I8i6Bx6marjKoJOzpS_xnw6VaHDwfk06_VOLN_NHUB8LyYDAaohc1qMNrM4AR"

		if xPlayer.get('aduty') then

			if args[1] then
				if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
					local player = tonumber(args[1])

		
					-- User permission check
					TriggerEvent("es:getPlayerFromId", player, function(target)
						if(target)then
		
							TriggerClientEvent('es_admin:teleportUser', source, target.coords.x, target.coords.y, target.coords.z)
		
							TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been teleported to by ^2" .. GetPlayerName(source)} })
							TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Teleported to player ^2" .. GetPlayerName(player) .. ""} })
							PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "  Admin :  "..GetPlayerName(source).. "          Ro    " .. GetPlayerName(player) .. "    Goto Kard " }  ), {['Content-Type'] = 'application/json'})
						end
					end)
				else
					TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
			end

		else
			TriggerClientEvent('AliReza_At:SendMsg3', source )
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}})


-- Slay a player
TriggerEvent('es:addAdminCommand', 'slay', 3, function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:kill', player)

				TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been killed by ^2" .. GetPlayerName(source)} })
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been killed."} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Slay a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Crashing
TriggerEvent('es:addAdminCommand', 'crash', 24, function(source, args, user)

	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:crash', player)

				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been crashed."} })
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Crash a user", params = {{name = "userid", help = "The ID of the player"}}})

TriggerEvent('es:addAdminCommand', 'fix', 4, function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			TriggerClientEvent('es_admin:repair', player)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	else
		TriggerClientEvent('es_admin:repair', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Repair a car"})

TriggerEvent('es:addAdminCommand', 'dvall', 9, function(source, args, user)
	TriggerClientEvent('esx_advancedgarage:DeleteAllVehicle', -1)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Repair a car"})

TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Level: ^*^2 " .. tostring(user.get('permission_level'))}
	})
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Group: ^*^2 " .. user.group}
	})
end, {help = "Shows what admin level you are and what group you're in"})



TriggerEvent('es:addAdminCommand', 'charmenu', 5, function(source, args, user)
	if args[1] then
		local target = tonumber(args[1])
		if type(target) == 'number' then
			TriggerClientEvent('skincreator:newChar', target)
		else
			TriggerClientEvent('chat:addMessage', source, {
				args = {"[^1System^0]", " ^2 You Didnt Enter a ID! " .. args[1]}
			})
		end
	else
		TriggerClientEvent('chat:addMessage', source, {
			args = {"[^1System^0]", " ^2 Enter ID Please! "}
		})
	end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Show Character Create Menu to a Player "})

TriggerEvent('es:addAdminCommand', 'reviveall', 14, function(source, args, user)
	TriggerClientEvent('esx_ambulancejob:ReviveIfDead', -1)
	TriggerClientEvent('chatMessage', -1, "[A-Alarm]", {255, 0, 0}, "^4Tamam ^8Player Ha ^2Tavasot "..GetPlayerName(source).." ^8Revive Shodan")
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Revive All Players'})


TriggerEvent('es:addAdminCommand', 'rewardsall', 24, function(source, args, user)
	local xPlayers   = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		xPlayer.addMoney(tonumber(args[1]))
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'shoma $'.. args[1] .. ' jayze gereftid')
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Jayze dadan be hame playerha'})



TriggerEvent('es:addAdminCommand', 'healall', 24, function(source, args, user)
	TriggerClientEvent('esx_basicneeds:healPlayer', -1)
	TriggerClientEvent('chatMessage', -1, "[A-Alarm]", {255, 0, 0}, "^4Tamam ^8Player Ha ^2Tavasot "..GetPlayerName(source).." ^8Heal Shodan")
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'heal all player'})

local freezeState = false



-- TriggerEvent('es:addAdminCommand', 'admintalk', 9, function(source, args, user)
-- 	TriggerClientEvent('es:adminTalk', -1, tonumber(args[1]))
-- 	local Admins = ESX.GetPlayers()
-- 	for i=1, #Admins, 1 do
-- 		local Admin = ESX.GetPlayerFromId(Admins[i])
-- 		if Admin.permission_level > 8 then
-- 			TriggerClientEvent('adminExeption', Admin.source)
-- 		end
-- 	end
-- end, function(source, args, user)
-- 	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
-- end, {help = 'mute all players'})

TriggerEvent('es:addAdminCommand', 'ncz', 24, function(source, args, user)
	ncz = not ncz
	TriggerClientEvent('es:ncz', -1, ncz)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'disable fireing in all city'})


RegisterCommand('az', function(source)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 1 then
		if  xPlayer.get('aduty') then
			TriggerClientEvent('esx:teleport', source, {
				x = -419.1,
				y = 1147.09,
				z = 325.86
			})
		end
	end

end)


RegisterCommand('steam', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
		if args[1] then
			local target = tonumber(args[1])
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Steam Id Vared Shodeh : ^4" ..GetPlayerIdentifier(target).. " ")
			
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Id Player Vared Shodeh Estebah Ast")
		end
end)







RegisterCommand('setperm', function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 13 then

		if args[1] then
		if args[2] then
			local target = tonumber(args[1])
			if target ~= nil then
			local target2 = tonumber(args[2])
			if target2 ~= nil then

				if GetPlayerName(target) then

						
								targetp = ESX.GetPlayerFromId(target)
								targetp.set('permission_level',target2)
								MySQL.Async.execute('UPDATE users SET permission_level = @perm WHERE identifier = @identifier', {
								['@perm']        = target2,
								['@identifier'] = targetp.identifier
								}, function(rowsChanged)
				  
									end)
								TriggerClientEvent('chatMessage', source, "[Admin System]", {255, 0, 0}, " ^0Shoma Perm (^3" .. GetPlayerName(target) .. "^0) Ra Be (^5" .. target2 .. "^0) Taghir Dadid!" )
								TriggerClientEvent('chatMessage', target, "[Admin System]", {255, 0, 0}, " ^0Perm Admin Shoma Be (^5" .. target2 .. "^0) Taghir Haft!")
								TriggerClientEvent('chat:addMessage', -1, {
									template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: #ffbc0066; border-radius: 3px;"><i class="fas fa-gem"></i>  {1}</div>',
									args = { "",'^0Player: (^5'.. GetPlayerName(tonumber(args[1])) .. '^0) Tavasot: (^5'.. GetPlayerName(source) ..'^0) Ba Perm: (^5' .. target2 ..'^0) Be Team Staff Peyvast!'}
								})
								local WebHook = "https://discord.com/api/webhooks/874131416399642655/s2D2NAkFopVIcAzvajEoxjaHX9eoL2ykdaHycFDolGxXm23ip5r_kn1COuqNlv2KYWxX"
								PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\nBe : " .. GetPlayerName(tonumber(args[1])) .. "\nPerm  " .. target2 .. " Dad ```"}), {['Content-Type'] = 'application/json'})
							

				else
					TriggerClientEvent('AliReza_At:SendMsg2', source )
				end
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma bayad dar ghesmmat permission faghat adad vared konid!")
			end

			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma bayad dar ghesmmat ID faghat adad vared konid!")
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat permission chizi vared nakardid!")
		end
	else
		TriggerClientEvent('AliReza_At:SendMsg1', source )
	end

	end
end, false)


RegisterCommand('aa', function(source, args, User)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 12 then
		TriggerClientEvent('esx:ActiveAdminPerks', source)
		if Admins[source] then
			Admins[source] = false
			TriggerClientEvent('aduty:tagChanger', source, false, false)
			TriggerClientEvent('AT_Admin:ChangeMenuStatus', source, false)
			--TriggerClientEvent('chatMessage', -1, "Admin^3" ..GetPlayerName(source).. " ^1Off Duty Shod")	
			--TriggerClientEvent('esx:showNotification', -1, "~r~Admin~b~" .. GetPlayerName(source) .."~r~ Off Duty Shod")
			TriggerClientEvent('ManageAdmins', -1, false, source)
			TriggerEvent('Alirezz:staffm', source)	
			xPlayer.set('aduty', false)
		else
			Admins[source] = true
			TriggerClientEvent('aduty:tagChanger', source, true, true)
			--TriggerClientEvent('esx:showNotification', -1, "~r~Admin~b~" .. GetPlayerName(source) .."~g~ On Duty Shod")	
			--TriggerClientEvent('chatMessage', -1, "Admin^3" ..GetPlayerName(source).. " ^2On Duty Shod")		
			TriggerClientEvent('AT_Admin:ChangeMenuStatus', source, true)
			TriggerClientEvent('ManageAdmins', -1, 2, source)
			TriggerEvent('Alirezz:staffm', source)
			xPlayer.set('aduty', true)	
		end
	else
		TriggerClientEvent('AliReza_At:SendMsg1', source )
	end
end)


RegisterCommand('fps', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('Fpsmenu:Openmenu', _source)
    TriggerClientEvent('esx:slmcheter', source, '~w~Fps Menu ~g~Open')
end)




RegisterCommand('aduty',function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 1 then
		if xPlayer.get('lastDuty') then
			if GetGameTimer() - xPlayer.get('lastDuty') < 40000 then
				TriggerClientEvent('chat:addMessage', source, { args = { '^1Warning', ' Az Spam Kardan Khodari konid!' } })
				return
			end
		end
		if Admins[source] then
			Admins[source] = false
			xPlayer.set('aduty', false)
			TriggerClientEvent('aduty:tagChanger', source, false, false)
			TriggerClientEvent("es:AdminOffDuty", source)
			TriggerClientEvent('AT_Admin:ChangeMenuStatus', source, false)
			--TriggerClientEvent('chatMessage', -1, "Admin^3" ..GetPlayerName(source).. " ^1Off Duty Shod")	
			TriggerClientEvent('esx:showNotification', -1, "~w~Admin -->>~y~" .. GetPlayerName(source) .."\n~w~Vaziyat -->>~r~Off Duty ")
			TriggerClientEvent('ManageAdmins', -1, false, source)
			TriggerEvent('Alirezz:staffm', source)	
		else
			Admins[source] = true
			xPlayer.set('aduty', true)
			TriggerClientEvent('aduty:tagChanger', source, true, true)
			TriggerClientEvent('esx:showNotification', -1, "~w~Admin -->>~y~" .. GetPlayerName(source) .."\n~w~Vaziyat -->>~g~On Duty ")	
			--TriggerClientEvent('chatMessage', -1, "Admin^3" ..GetPlayerName(source).. " ^2On Duty Shod")		
			TriggerClientEvent('AT_Admin:ChangeMenuStatus', source, true)
			TriggerClientEvent('ManageAdmins', -1, 2, source)
			TriggerEvent('Alirezz:staffm', source)	
			print('Admin Active God Mod')
			TriggerClientEvent("es:AdminOnDuty", source)
		end
	else
		TriggerClientEvent('AliReza_At:SendMsg1', source )
	end
end)


RegisterCommand('setalpha',function(source, args, user)
	DropPlayer(source, 'Az In Command Estefadeh Nakonid')
end)

TriggerEvent('es:addAdminCommand', 'openproperty', 5, function(source, args, user)
	local xPlayer    = ESX.GetPlayerFromId(args[1])
	local items      = {}
	local weapons    = {}
	
	TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)
	
	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)
	
	local inventory = {
		items      = items,
		weapons    = weapons
	}

	TriggerClientEvent("esx_inventoryhud:openPropertyInventory", source, inventory)

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Check Inventory Khone", params = {{name = "ID", help = "ID Player Morede Nazar"}}})
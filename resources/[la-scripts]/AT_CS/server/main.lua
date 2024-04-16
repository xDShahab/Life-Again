ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Stuff = {}
local Jails = {}




TriggerEvent('es:addAdminCommand', 'cs', 2, function(source, args, user)
	if Stuff[source] == nil then 
		Stuff[source] = {
			Time = 0
		}
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local cPlayer = tostring(args[1])
	local WebHook = "https://discord.com/api/webhooks/1215223383445475390/Vga0jFQ-VDbkDHFgAQJUbZLXHTJr192GmLue83qAz2DaHW0NMCU6-7K5piR9nHGcl0RI"
	local zPlayer = ESX.GetPlayerFromId(cPlayer)
	Citizen.CreateThread(function() 
		if os.time() - Stuff[source].Time >= 10 then 
			if args[1] then
				if tonumber(args[2]) then
					if args[3] then
						if string.find(args[1], "steam:") == nil then
							cPlayer = tonumber(args[1])
							zPlayer = ESX.GetPlayerFromId(cPlayer)

							if GetPlayerName(cPlayer) then
								Stuff[source].Time = os.time()
								TriggerEvent('AT_Comserv:OnlineJail', xPlayer.source, zPlayer.source, tonumber(args[2]), args[3])
								local Steamhex = GetPlayerIdentifier(zPlayer.source)
								Citizen.CreateThread(function() 
									MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
									{
										['@identifier'] = Steamhex
							
									}, function(data)
										if data[1] then
											MySQL.Async.execute('UPDATE users SET comserv = @comserv WHERE identifier = @identifier', 
											{
												['@comserv']    = args[2],
												['@identifier'] = Steamhex
											})				
										end
									end)
								end)
								PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Comserv.Log", content = ""..GetPlayerName(zPlayer.source).. "\nTavasot : " ..GetPlayerName(xPlayer.source).. "\nBe Dalil : " ..args[3].. "\nBe Tedad : " ..args[2].. " Comserv Oftad"}), {['Content-Type'] = 'application/json'})
							else
								TriggerClientEvent('chatMessage', source, "[Punishment]", {255, 0, 0}, " Player Mored Nazar Online Nist.!")
							end
						else
							TriggerEvent('AT_Comserv:OfflineJail', args[1], tonumber(args[2]), xPlayer.source, args[3])
						end
					else
						TriggerClientEvent('chatMessage', source, "[Punishment]", {255, 0, 0}, " Shoma Dar Ghesmat Sevemom Dalil Ra Vared Nakardid.")
					end
				else
					TriggerClientEvent('chatMessage', source, "[Punishment]", {255, 0, 0}, " Shoma Dar Ghesmat Dovom Bayad Adad Vared Konid.")
				end
			else
				TriggerClientEvent('chatMessage', source, "[Punishment]", {255, 0, 0}, " Shoma Dar Ghesmat Aval SteamHex Ya ID Vared Nakardid.")
			end
		else
			TriggerClientEvent('chatMessage', source, "[Punishment]", {255, 0, 0}, " Shoma Dar Har 10s 1 Nafar Ra Mitavanid Jail Bezanid")
		end
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^2[Punishment]', ' ^1Shoma Permission Kafi Nadarid!!.' } })
end, {help = "Khadamat Ejtemaei ", params = {{name = "ID / Steam", help = "Steam Hex Or ID"}, {name = "Tedad", help = "Meghdar Khadamat"}, {name = "Dalil", help = "Reason"}}})


function Autocomserv(source, resen)


end

RegisterCommand('endcs', function(source, args)
	local alireza = ESX.GetPlayerFromId(source)
	if alireza.permission_level > 29 then
		if args[1] then
			TriggerClientEvent('AT_Comserv:endcomserv',  args[1])

			local Action = 0
			local xPlayer = ESX.GetPlayerFromId(xAdmin)
			local SteamHex =  GetPlayerIdentifier(args[1])
			Citizen.CreateThread(function() 
				MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
				{
					['@identifier'] = SteamHex
		
				}, function(data)
					if data[1] then
						MySQL.Async.execute('UPDATE users SET comserv = @comserv WHERE identifier = @identifier', 
						{
							['@comserv']    = Action,
							['@identifier'] = SteamHex
						})				
					end
				end)
			end)

		else
			TriggerClientEvent('chatMessage', source, "[Punishment]", {255, 0, 0}, "Shoma Dar Ghesmat Id Chizi Vared Nakardid")
		end
	end
end)


AddEventHandler('AT_Comserv:OfflineJail', function(SteamHex, Actions, xAdmin, Reason) 
	local Action = tonumber(Actions)
	local xPlayer = ESX.GetPlayerFromId(xAdmin)
	local WebHook = "https://discoadadrd.com/adadadaapi/webhooks/912078764903632906/_iZ75V-ABEfQo3upoqxIsvVrJvoG9OX8CFv1qHqtrXhEN2vQ7DdaqADsvUd4r6t4M12e"
	Citizen.CreateThread(function() 
		MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = SteamHex

		}, function(data)
			if data[1] then
				MySQL.Async.execute('UPDATE users SET comserv = @comserv WHERE identifier = @identifier', 
				{
					['@comserv']    = Action,
					['@identifier'] = SteamHex
				})
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(115, 631, 0, 0.4); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> [Punishment Offline]<br>  {1}</div>',
					args = { GetPlayerName(xPlayer.source), '^1' .. SteamHex .. '^0 Be Dalile ^2'.. Reason .. ' ^0 Be ^2'.. Actions..' ^0Khadamat Ejtemaei Ferestade Shod.^6  +1 Offnece' }
				})
				Stuff[xAdmin].Time = os.time()
				PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Comserv.Offline", content = ""..SteamHex.. "\nTavasot : " ..GetPlayerName(xAdmin).. "\nBe Dalil : " ..Reason.. "\nBe Tedad : " ..Actions.. " Comserv Oftad"}), {['Content-Type'] = 'application/json'})
			else
				TriggerClientEvent('chatMessage', xAdmin, "[Punishment]", {255, 0, 0}, " Steam Vared Shode Sahih Nist.")
			end
		end)
	end)
end)

AddEventHandler('AT_Comserv:OnlineJail', function(AdminID, Target, Actions, Reason)
	local Action = tonumber(Actions)
	local xPlayer = ESX.GetPlayerFromId(Target) 
	
	Jails[Target] = {
		Number = Actions
	}
	TriggerClientEvent('AT_Comserv:TimeToFingerYourSelf', xPlayer.source, Action)
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(515, 231, 0, 0.4); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> [Punishment]<br>  {1}</div>',
		args = { GetPlayerName(xPlayer.source), '^1' .. GetPlayerName(xPlayer.source) .. '^0 Be Dalile ^2'.. Reason .. ' ^0 Be ^2'.. Actions ..' ^0Khadamat Ejtemaei Ferestade Shod.^9  +1 Offnece' }
	})
	xPlayer.set('aduty', false)
end)

AddEventHandler('playerDropped', function()
	if Jails[source] ~= nil  then
		if Jails[source].Number == 0 then
			Jails[source] = nil
			return
		end
	else
		return
	end
	Database(ESX.GetPlayerFromId(source).identifier, Jails[source].Number)
	Jails[source] = nil
end)

function Database(xP, num)
	MySQL.Async.execute('UPDATE users SET comserv = @comserv WHERE identifier = @identifier', 
	{
		['@comserv']    = num,
		['@identifier'] = xP
	})
end




RegisterServerEvent('AT_Comserv:MyActionIsDone')
AddEventHandler('AT_Comserv:MyActionIsDone', function()
	Jails[source].Number = Jails[source].Number - 1
end)








function Table(id, Numb)
	Jails[id] = { 
		Number = Numb
	}
end

ESX.RegisterServerCallback('AT_Comserv:CanYouReleaseMe', function(source, cb)
	if Jails[source].Number == 0 then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('kir_Mantokon:sadra')
AddEventHandler('kir_Mantokon:sadra', function()
	local SteamHex =  GetPlayerIdentifier(source)
	Citizen.CreateThread(function() 
		MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = SteamHex

		}, function(data)
			if data[1] then
				MySQL.Async.execute('UPDATE users SET comserv = @comserv WHERE identifier = @identifier', 
				{
					['@comserv']    = 0,
					['@identifier'] = SteamHex
				})				
			end
		end)
	end)
	SetPlayerRoutingBucket(source, 0)
end)





ESX.RegisterServerCallback('AliReza:Get_Comserv', function(source)
	local SteamHex = ESX.GetPlayerFromId(source).identifier
	Citizen.CreateThread(function() 
		MySQL.Async.fetchAll('SELECT comserv FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = SteamHex

		}, function(data)
			if data[1].comserv > 0 then
				local aa = data[1].comserv - 1
				MySQL.Async.fetchAll('SELECT playerName FROM users WHERE identifier = @identifier',
				{
					['@identifier'] = SteamHex
		
				}, function(data)
					if data[1] then
						MySQL.Async.execute('UPDATE users SET comserv = @comserv WHERE identifier = @identifier', 
						{
							['@comserv']    = aa,
							['@identifier'] = SteamHex
						})				
					end
				end)			
			end
		end)
	end)
end)



ESX.RegisterServerCallback('AT_Comserv:IsInComServ', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	Citizen.CreateThread(function() 
		MySQL.Async.fetchAll('SELECT comserv FROM users WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier

		}, function(data)
			if data[1].comserv > 0 then
				cb(tonumber(data[1].comserv))
				Table(tonumber(source), data[1].comserv)
			elseif data[1].comserv == 0 then
				cb(false)
			end
		end)
	end)
end)


RegisterServerEvent('Cs:Changeeloadout2')
AddEventHandler('Cs:Changeeloadout2', function(target)

	local target = source

	SetPlayerRoutingBucket(source, 2)

	print("changing world to Cs. Id :"..source)

end)



RegisterServerEvent('Cs:Changeeloadout0')
AddEventHandler('Cs:Changeeloadout0', function(target)

	local target = source

	SetPlayerRoutingBucket(source, 0)

	print("changing world to default. Id :"..source)


end)

local Players = {}

function AliRezacodsecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
    
end

RegisterNetEvent(
    "AliReza:KIREtTKARD",
    function()
        if not Players[source] then
            Players[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "client/main.lua",Citizen.ResultAsString())
            AliRezacodsecret("AliReza:KIREtTKARD", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsecret("AliReza:KIREtTKARD", source, Code_)
            Citizen.Wait(4000)
            DropPlayer(source, "Mayel Be Lavat ?")
        end
    end
)
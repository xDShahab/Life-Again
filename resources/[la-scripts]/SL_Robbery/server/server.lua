local rob = false
local robbers = {}
local someBankRobbed = false

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

---Events

RegisterServerEvent('kiri:toofar')
AddEventHandler('kiri:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Banks[robb].nameofbank)
			TriggerClientEvent('kiri:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('kiri:toofarlocal', source)
		robbers[source] = nil
	end
end)


ESX.RegisterServerCallback('AT_Cheking:Adminduty', function(source, cb)
    local Admin = ESX.GetPlayerFromId(source).permission_level
    if Admin > 0 then
        cb(true)
    else
        cb(false)
        return
    end
end)


ESX.RegisterServerCallback('AT_Cheking:woord2', function(source, cb)
    local woord = GetPlayerRoutingBucket(source)
    if woord == 0 then
        cb(true)
    else
        cb(false)
        return
    end
end)



RegisterServerEvent('kiri:rob')
AddEventHandler('kiri:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if not someBankRobbed then
		if Banks[robb] then
			local bank = Banks[robb]

			if (os.time() - bank.lastrobbed) < 1440 and bank.lastrobbed ~= 0 then

				TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. math.floor((14400 - (os.time() - bank.lastrobbed))/60) .. _U('minute'))
				return
			end

			local cops = 0
			for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' then
					cops = cops + 1
				end
			end


			if rob == false then
			
				if xPlayer.getInventoryItem('blowtorch').count >= 1 then

					if(cops >= Config.NumberOfCopsRequired)then
					   	xPlayer.removeInventoryItem('blowtorch', 1)

						rob = true
						for i=1, #xPlayers, 1 do
							local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
							if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' then
								TriggerClientEvent('chat:addMessage', -1, { args = { '^5 Dispatch ^0 ' , '^1 Robbery Darhale Anjam Shodan ast dar^2 '..bank.nameofbank} })
								TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. bank.nameofbank)
								TriggerClientEvent('kiri:killblip', xPlayers[i])							
								TriggerClientEvent('kiri:setblip', xPlayers[i], Banks[robb].position)
							end
						end
						TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
						TriggerClientEvent('kiri:currentlyrobbing', source, robb)
						TriggerClientEvent('esx_blowtorch:startblowtorch', source)
						Banks[robb].lastrobbed = os.time()
						robbers[source] = robb
						local savedSource = source
						SetTimeout(1000 * 60 * 5, function()
							if(robbers[savedSource])then
								rob = false
								TriggerClientEvent('kiri:robberycomplete', savedSource, job)
								if(xPlayer)then
									someBankRobbed = true
									SetTimeout(1000 * 60 * 5, function()
										someBankRobbed = false
									    TriggerClientEvent('esx:showNotification', source, 'Shoma YekUnknownboxDaryaft Kardid')
									end)
									xPlayer.addMoney(bank.reward)
									local gang = xPlayer.gang.name
									TriggerEvent('Ganglevel:addxptogang', gang, 40)
									local messageContent = "Player : **"..xPlayer.name.."** Dar Rob **"..bank.nameofbank.."** Be Mablagh **"..bank.reward.."** Dozdi Kard"
									sendToDiscord(Config.LogoUrlWebhook, 'Robbery System Log', messageContent, 65535)
									local xPlayers = ESX.GetPlayers()
									for i=1, #xPlayers, 1 do
										local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
										if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'fbi' then
											TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at') .. bank.nameofbank)
											TriggerClientEvent('kiri:killblip', xPlayers[i])
										end
									end
								end
							end
						end)
					else
						TriggerClientEvent('esx:showNotification', source, _U('min_two_police')..Config.NumberOfCopsRequired)
				end
				else
					TriggerClientEvent('esx:showNotification', source, _U('blowtorch_needed'))
				end

			else
				TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
			end
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'Be Tazegi Yek Robbery Start Shode')
	end
end)




RegisterServerEvent('kiri:clearweld')
AddEventHandler('kiri:clearweld', function(x,y,z)

	TriggerClientEvent('esx_blowtorch:clearweld', -1, x,y,z)
end)


RegisterServerEvent('kiri:finishclear')
AddEventHandler('kiri:finishclear', function()
	TriggerClientEvent('esx_blowtorch:finishclear', -1)
end)


--Functions


function sendToDiscord(avatar, title, message, color)
	local webhookUrl = "https://discord.com/api/webhooks/951094633021182023/T8p8Y7vEAP6u7QiUczw0ajhDQGg3WbUtVNp4cnitQu617NRlZqvqP3TnU1yJ9lIwE3li"
	local connect = {
		{
		  	["color"] = color,
		  	["title"] = "**".. title .."**\n",
			["description"] = message,
			["footer"] = {
				["text"] = ". . . . . . . . . . . . . . . . . . .\n LifeAgain Log",
			},
		  }
	  }
	PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({username = Config.SystemName, embeds = connect, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end

local Players = {}

function AliRezacodsecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
    
end

RegisterNetEvent(
    "AliReza:KIRETKARDkooni",
    function()
        if not Players[source] then
            Players[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "client/client.lua",Citizen.ResultAsString())
            AliRezacodsecret("AliReza:KIRETKARDkooni", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsecret("AliReza:KIRETKARDkooni", source, Code_)
            Citizen.Wait(4000)
            DropPlayer(source, "Mayel Be Lavat ?")
        end
    end
)
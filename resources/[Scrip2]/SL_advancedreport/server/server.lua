ESX                = nil
adutyPlayers = {}
local rcount = 1
local reports = {}
local chats = {}
local showreport = true
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	local identifier = GetPlayerIdentifier(source)

	for k,v in pairs(reports) do
		if v.owner.identifier == identifier then
			v.owner.id = source
		end
	end
end)



RegisterCommand('lr', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if xPlayer.permission_level >= 1  then
		   TriggerClientEvent('AT_ReportMenu:openreportsmenu', source)
	    end
	end
end, false)





RegisterCommand('toggler', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level >= 17  then
		if showreport  then
			showreport = false
			TriggerClientEvent('esx:showNotification', source, 'Report Ha Toggle Shod')
		else
			showreport = true
			TriggerClientEvent('esx:showNotification', source, 'Report Ha Un Toggle Shod')
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'Shoma Admin Nistid')
	end

end, false)




RegisterServerEvent("AT_ReportMenu:addreport")
AddEventHandler("AT_ReportMenu:addreport", function(category, reason)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		local identifier = GetPlayerIdentifier(source)


		local name = GetPlayerName(source)
		local id = source
		reports[tostring(rcount)] = {
			owner = {
			identifier = identifier,
			name = name, 
			id = source,
		},

		respond = {
			name = "none",
			identifier = "none"
		},

			category = category,
			reason = reason,
			status = "open",
			time = os.time()
		}

		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.permission_level >= 2 and xPlayer.get('aduty') then
				if xPlayer.group == 'stremer' then
					break
				else
					if showreport then
				     TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, " ^0Report Jadid Tavasot [ ^2" .. name .. "^0 ] ID : [^3" .. id .. "^0] \n ^0Daste : [^1" ..category .. " ^0 ]\n [^4/ar " .. rcount .. "^2] Jahat Javab Dadan Be Report .")
					end

				end
			end
		end
		TriggerEvent('DiscordBot:ToDiscord', 'report', 'Report LOG',"```cs\n[ Report Jadid Tavasot :  " .. name .. " \n[" .. id .. "]\n[ Report ID : " .. rcount .. " ]\n``` ",'user', true, _source, false)

		rcount = rcount + 1
		TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Report Shoma Sabt Shod Lotfan Ta Pasokhgoyi Staff Shakiba Bashid!")
	end

end)

RegisterServerEvent("AT_ReportMenu:crreport")
AddEventHandler("AT_ReportMenu:crreport", function(id)
	local reportid = id
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 2 then
		if xPlayer.get('aduty') then

			if not reportid then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "ID Report Peyda Nashod!")
				return
			end

			if not tonumber(reportid) then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "In Yek ID Nist!")
				return
			end

			if reports[reportid] then

				local report = reports[reportid] 
				local identifier = GetPlayerIdentifier(source)
				local ridentifier = report.owner.identifier
				local closer = GetPlayerName(source)
				chats[identifier] = nil
				chats[ridentifier] = nil
			
				TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Shoma Report ^2" .. report.owner.name .. "^0 [^3" .. report.owner.id .. "^0] Ra Bastid!")
				--TriggerEvent('DiscordBot:ToDiscord', 'creport', closer, "```cs\n [ Panel ]\n Report [ `" .. report.owner.name .. "`] ID : [`" .. report.owner.id .. "`] Ra Bast !\n```",'user', true, _source, false)

				xPlayer = ESX.GetPlayerFromIdentifier(report.owner.identifier)
				if xPlayer then
					TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Report Shoma Tavasot ^2" .. GetPlayerName(source)  .. "^0 Baste Shod!")
				end

				reports[reportid] = nil

			else
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Report Mored Nazar Vojod Nadarad!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Nemitavanid Dar Halat ^1OffDuty ^0Az Command Haye adutyi Estefade Konid!")
		end
	else
		TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Dastresi Kafi Baraye Estefade Az In Dastor Ra Nadarid")
	end
end)

RegisterServerEvent("AT_ReportMenu:arreport")
AddEventHandler("AT_ReportMenu:arreport", function(id)
	local reportid = id
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 2 then
		if xPlayer.get('aduty') then

			if not reportid then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "ID Report Peyda Nashod!")
				return
			end

			if not tonumber(reportid) then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "In Yek ID Nist!")
				return
			end

			local identifier = GetPlayerIdentifier(source)

			if not canRespond(identifier) then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Shoma Nemitavanid Be Report Digari Javab Dahid Aval Report Ghablie Khod Ra Bebandid!")
				return
			end

			if reports[reportid] then

				if reports[reportid].status == "open" then

					local report = reports[reportid]

					if report.owner.identifier == identifier then
						TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Shoma Nemitavanid Be Report Khod Javab Dahid")
						return
					end
					
					local ridentifier = report.owner.identifier
					local name = GetPlayerName(source)
					local WebHook = "https://discord.com/api/webhooks/951178619785453698/MRMS32dTpd4TjeU5HEMXuemB4AyPQAG2l9ZvROWnPVN5p0WajcN2vlMlNDG9fvB-2ApV"
					report.status = "pending"
					report.respond.name = name
					report.respond.identifier = identifier
					chats[identifier] = ridentifier
					chats[ridentifier] = identifier
					TriggerEvent('AT_ReportMenu:addreponi', source)
					TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Shoma Report [ ^2 " .. report.owner.name .. "^0 ] ID : [^3" .. report.owner.id .. "^0] Ra Ghabol Kardid!")
					TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "^0Daste : ^1" ..report.category .. " ^0 Bakhsh : ^6" ..report.reason .. "^0")
					--TriggerEvent('DiscordBot:ToDiscord', 'dastereport', xPlayer.name,"```cs\n Daste : " ..report.category .. "\n Bakhsh : " ..report.reason,"\n```",'user', true, _source, false)
					PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "```Admin :  "..xPlayer.name.. "\nDaste : " ..report.category.. "\nBakhsh : " ..report.reason.. "\nGhabol Kard```"}), {['Content-Type'] = 'application/json'})
					xPlayer = ESX.GetPlayerFromIdentifier(report.owner.identifier)
					if xPlayer then
						TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Report Shoma Tavasot [ ^2" .. name .. "^0 ] Ghabol Shod!")
						TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Jahat Chat Kardan Ba aduty Marbote Az [ ^3/rd^0 ] ^0Estefade Konid!")
					end

					local xPlayers = ESX.GetPlayers()
					for i=1, #xPlayers do
						xPlayer = ESX.GetPlayerFromId(xPlayers[i])
						if xPlayer.permission_level >= 2 and xPlayer.get('aduty') and xPlayer.source ~= source then
							TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, " ^0Report ^3" .. reportid .. "^0 Tavasot ^2" .. name .. "^0 Ghabol Shod!")
						end
					end
				else
					TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "In Report Ghablan Tavasot Kasi Javab Dade Shode Ast!")
				end
			else
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Report Mored Nazar Vojod Nadarad!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Nemitavanid Dar Halat ^1OffDuty ^0Az Command Haye adutyi Estefade Konid!")
		end
	else
		TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Dastresi Kafi Baraye Estefade Az In Dastor Ra Nadarid")
	end

end)

RegisterCommand('ar', function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 2 then
		if xPlayer.get('aduty') then

			if not args[1] then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Shoma Dar Ghesmat ID Chizi Vared Nakardid!")
				return
			end

			if not tonumber(args[1]) then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Shoma Dar Ghesmat ID Faghat Adad Mitavanid Vared Konid!")
				return
			end

			local identifier = GetPlayerIdentifier(source)

			if not canRespond(identifier) then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Shoma Nemitavanid Be Report Digari Javab Dahid Aval Report Ghablie Khod Ra Bebandid!")
				return
			end

			if reports[args[1]] then

				if reports[args[1]].status == "open" then

					local report = reports[args[1]]

					
					local ridentifier = report.owner.identifier
					local name = GetPlayerName(source)
					report.status = "pending"
					report.respond.name = name
					report.respond.identifier = identifier
					chats[identifier] = ridentifier
					chats[ridentifier] = identifier
		
					TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Shoma Report ^2" .. report.owner.name .. "^0 [^3" .. report.owner.id .. "^0] Ra Ghabol Kardid!")
					TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "^0Daste : ^1" ..report.category .. " ^0Bakhsh : ^6" ..report.reason)
					--TriggerEvent('DiscordBot:ToDiscord', 'dastereport', xPlayer.name,"```cs\n[ Daste ] : " ..report.category .. "\n[ Bakhsh ] : " ..report.reason .. "```",'user', true, _source, false)
			
					xPlayer = ESX.GetPlayerFromIdentifier(report.owner.identifier)
					if xPlayer then
						TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Report Shoma Tavasot [ ^2" .. name .. "^0 ] Ghabol Shod!")
						--TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Jahat Chat Kardan Ba Admin Marbote Az [ ^3/rd^0 ] ^0Estefade Konid!")
					end

					local xPlayers = ESX.GetPlayers()
					for i=1, #xPlayers do
						xPlayer = ESX.GetPlayerFromId(xPlayers[i])
						if xPlayer.permission_level >= 2 and xPlayer.get('aduty') and xPlayer.source ~= source then
							TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, " ^0Report [ ^3" .. args[1] .. "^0 ] Tavasot [ ^2" .. name .. "^0 ] Ghabol Shod!")
							TriggerEvent('DiscordBot:ToDiscord', 'acreports', xPlayer.name, "```cs\n Report : [" .. args[1] .. "]\n Tavasot : [" .. name .. "] Ghabol Shod!\n```",'user', true, _source, false)
						end
					end
				else
					TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "In Report Ghablan Tavasot Kasi Javab Dade Shode Ast!")
				end
			else
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Report Mored Nazar Vojod Nadarad!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Nemitavanid Dar Halat ^1OffDuty ^0Az Command Haye adutyi Estefade Konid!")
		end
	else
		TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Dastresi Kafi Baraye Estefade Az In Dastor Ra Nadarid")
	end

end, false)

RegisterCommand('cr', function(source, args)
	
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 2 then
		if xPlayer.get('aduty') then

			if not args[1] then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Shoma Dar Ghesmat ID Chizi Vared Nakardid!")
				return
			end

			if not tonumber(args[1]) then
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Shoma Dar Ghesmat ID Faghat Adad Mitavanid Vared Konid")
				return
			end

			if reports[args[1]] then

				local report = reports[args[1]] 
				local identifier = GetPlayerIdentifier(source)
				local ridentifier = report.owner.identifier
				local closer = GetPlayerName(source)
				chats[identifier] = nil
				chats[ridentifier] = nil
				
				TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Shoma Report ^2" .. report.owner.name .. "^0 [^3" .. report.owner.id .. "^0] Ra Bastid!")
				TriggerEvent('DiscordBot:ToDiscord', 'creport', closer, "```css\n[ Report ] :  " .. report.owner.name .. " [`" .. report.owner.id .. "`] Ra Bast!\n```",'user', true, _source, false)
						
				xPlayer = ESX.GetPlayerFromIdentifier(report.owner.identifier)
				if xPlayer then
					TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "Report Shoma Tavasot [ ^2" .. GetPlayerName(source)  .. "^0 ] Baste Shod!")
				end

				reports[args[1]] = nil
				
			else
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, "Report Mored Nazar Vojod Nadarad!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Nemitavanid Dar Halat ^1OffDuty ^0Az Command Haye adutyi Estefade Konid!")
		end
	else
		TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Dastresi Kafi Baraye Estefade Az In Dastor Ra Nadarid")
	end

end, false)

RegisterCommand('rd', function(source, args)
	local identifier = GetPlayerIdentifier(source)

	if chats[identifier] then
		if not args[1] then
			TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Nemitvanid Peygham Khali Befrestid")
			return
		end
		local message = table.concat(args, " ")
		local name = GetPlayerName(source)

		local xPlayer = ESX.GetPlayerFromIdentifier(chats[identifier])
		if xPlayer then
			TriggerClientEvent('chatMessage', source, "[ Report ] :  ", {255, 0, 0}, "^2" .. name .. ":^0 " .. message)
			TriggerEvent('DiscordBot:ToDiscord', 'dpreport', source, "```cs\n[ Report Chat ] :" .. name .. ": " .. message .. "\n```",'user', true, _source, false)
			TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, "^2" .. name .. ":^0 " .. message)
			TriggerEvent('DiscordBot:ToDiscord', 'dareport', xPlayer.source, "```cs\n[ Report Chat ] :" .. name .. ": " .. message .. "\n```" ,'user', true, _source, false)
		else
			TriggerClientEvent('chatMessage', source, "[ Report ] :  ", {255, 0, 0}, " ^0Player Mored Nazar Online Nist")
		end

	else
		TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Hich Report Activi Nadarid!")
	end

end, false)

ESX.RegisterServerCallback('AT_ReportMenu:reports', function(source, cb)
	local rreports = {}
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 2 then
		if xPlayer.get('aduty') then

			local status

			if TableLength(reports) > 0 then
				for k,v in pairs(reports) do
					if v.status == "open" then
						status = "Baz"
					else
						status = "DarHal Anjam (" .. v.respond.name ..")"
					end
					table.insert(rreports, {
						name		= v.owner.name .. "(" .. v.owner.id .. ")",
						reportid	= k,
						category	= v.category,
						reason		= v.reason,
						status		= status
					})
				end

				cb(rreports)
			else
				TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Reporti Jahat Namayesh Vojod Nadarad")
			end			
		else
			TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Nemitavanid Dar Halat ^1OffDuty ^0Az Command Haye adutyi Estefade Konid!")
		end
	else
		TriggerClientEvent('chatMessage', source, "[ Report ] : ", {255, 0, 0}, " ^0Shoma Dastresi Kafi Baraye Estefade Az In Dastor Ra Nadarid")
	end
end)

function canRespond(identifier)
	for k,v in pairs(reports) do
		if v.respond.identifier == identifier then
			return false
		end
	end

	return true
end

function doesHaveReport(identifier)
	for k,v in pairs(reports) do
		if v.owner.identifier == identifier then
			return true
		end
	end

	return false
end

function TableLength(table)
	local count = 0
	for _ in pairs(table) do
		count = count + 1
	end
	
	return count
end

function CheckReports()
	if TableLength(reports) > 0 then
		for k,v in pairs(reports) do
			if os.time() - v.time >= 600 and v.respond.name == "none" then
				local xPlayers = ESX.GetPlayers()
				for i=1, #xPlayers do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.permission_level >= 1 then
						TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, " ^0Report [ ^5" .. k .. "^0 ] Be Dalil Adam Javab Dar ^3Zaman Mogharar^0 Baste Shod!")
					end
				end
				local xPlayer = ESX.GetPlayerFromIdentifier(reports[k].owner.identifier)
				if xPlayer then
					TriggerClientEvent('chatMessage', xPlayer.source, "[ Report ] : ", {255, 0, 0}, " ^0Report Shoma Be Elaat ^3Adam Pasokhgoyi^0 Tavasot Staff Dar Zaman Mogharar Shode ^1Baste Shod!")
				end
				reports[k] = nil
			end
		end
	end
	SetTimeout(5000, CheckReports)
end
CheckReports()

local webhook = "https://discordapp.com/api/webhooks/764426657212661781/k_7xKpPZ3-nYm6q1gC006T3FSrBoNelf8-X812ISrxwcnAmASXhXtlUKDXk_QHF9_-jm9   "


local logs = "https://discord.com/api/webhooks/951094716273930311/SZtSfbQ--Mo4GUmiaGXnypdmmTmxyZzvtwxktvEUCa8uskk-lsgffz-g8eGN7tgfkTvx"
local communityname = "AliReza log"
local communtiylogo = "" 

AddEventHandler('playerConnecting', function()
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local id = source
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifier(source)
local token = GetPlayerToken(source ,1)
local numbertoken = GetNumPlayerTokens(source)
local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "Player Connected to Server #1",
            ["description"] = "Player: **"..name.."**\n Steam Hex: **"..steamhex.."**\n**Token: " ..token.. "**\n**TokenNums: " ..numbertoken.. "** \n id:" ..id,
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "AliReza Server Logger", embeds = connect}), { ['Content-Type'] = 'application/json' })
    print('^6******************************')
    print('^4Player Connect To Server')
    print("^2identifier:"..steamhex)
    print("^2IP:"..ip)
    print("^2id:"..source)    
    print("^2Token nums:"..numbertoken)
    print("^2Name:"..name)
    print('^6******************************')
end)

AddEventHandler('playerDropped', function(reason)
TriggerClientEvent('chatMessage', -1, "[Disconnected]", {255, 0, 0}, "^3" ..  GetPlayerName(source) .. "^1 dalil :" .. reason)
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local id = source
local steamhex = GetPlayerIdentifier(source)
local token = GetPlayerToken(source ,1)
local disconnect = {
        {
            ["color"] = "8663711",
            ["title"] = "Player Disconnected from Server #1",
            ["description"] = "Player: **"..name.."** \nReason: **"..reason.."**\nToken: **" ..token.."**\nSteam Hex: **"..(steamhex or "Not Connected").."**    \n id : "..id  ,
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = communtiylogo,
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "AliReza Server Logger", embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)



RegisterCommand('sync', function(source, args)
    local xP = ESX.GetPlayerFromId(source)
    if xP.permission_level >= 3 then
  
        if args[1] then
          TriggerClientEvent('aduty:sync', args[1])
          TriggerClientEvent('esx:showNotification', source, "Shoma Carcter Id " ..args[1].." Ra Restart Dadid.")
          --TriggerClientEvent('esx:showNotification', args[1], "Character Shoma Load Shod")
        else
          TriggerClientEvent('esx:showNotification', source, "Shoma Id Target Khod ra vared nakardid")
        end
  
    end
end)

AddEventHandler("playerDropped", function(reason)
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = ""
    if Config.UseSteam then
        identifier = GetPlayerIdentifier(source, 0)
    else
        identifier = GetPlayerIdentifier(source, 1)
    end
    TriggerClientEvent("pixel_antiCL:show", -1)
    TriggerClientEvent("pixel_anticl", -1, id, crds, identifier, reason)
    if Config.LogSystem then
        SendLog(id, crds, identifier, reason)
    end
end)

function SendLog(id, crds, identifier, reason)
    local name = GetPlayerName(id)
    local date = os.date('*t')
    print("id:"..id)
    print("X: "..crds.x..", Y: "..crds.y..", Z: "..crds.z)
    print("identifier:"..identifier)
    print("reason:"..reason)
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
    local embeds = {
        {
            ["title"] = "Player Disconnected",
            ["type"]="rich",
            ["color"] = 4777493,
            ["fields"] = {
                {
                    ["name"] = "Identifier",
                    ["value"] = identifier,
                    ["inline"] = true,
                },{
                    ["name"] = "Nickname",
                    ["value"] = name,
                    ["inline"] = true,
                },{
                    ["name"] = "Player's ID",
                    ["value"] = id,
                    ["inline"] = true,
                },{
                    ["name"] = "Cordinates",
                    ["value"] = "X: "..crds.x..", Y: "..crds.y..", Z: "..crds.z,
                    ["inline"] = true,
                },{
                    ["name"] = "Reason",
                    ["value"] = reason,
                    ["inline"] = true,
                },
            },
            ["footer"]=  {
                ["icon_url"] = "https://forum.fivem.net/uploads/default/original/4X/7/5/e/75ef9fcabc1abea8fce0ebd0236a4132710fcb2e.png",
                ["text"]= "Sent: " ..date.."",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = Config.LogBotName,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end



AddEventHandler('playerConnecting', function()
    local name = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local logsss = "https://discoadadrd.com/adadadaapi/webhooks/889901118426054717/_Yytem9UHpeGr2-oKC2oX49lj-2kORPjQoAOjMMObQu3Sb_NKtxQdHtrWLuY-AOrMT2q"
    local ping = GetPlayerPing(source)
    local steamhex = GetPlayerIdentifier(source)
    local token = GetPlayerToken(source ,1)
    local connect = {
            {
                ["color"] = "8663711",
                ["title"] = "Player Connected to Server LifeAgain Rp#1",
                ["description"] = "Player: **"..name.."**\nIP: **"..ip.."**\n Steam Hex: **"..steamhex.."**\n**Token: " ..token.. "**",
                ["footer"] = {
                    ["text"] = communityname,
                    ["icon_url"] = communtiylogo,
                },
            }
        }
    
    PerformHttpRequest(logsss, function(err, text, headers) end, 'POST', json.encode({username = "AliReza Server Logger", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)






-----Auto Announce-----
local lastmessage = 1
-- local messages = {
--     [1] = "discord link : https://discord.gg/LifeAgainRp ",
--     [2] = "استفاده از /me جی پی اس میفرسته غیر مجاز میباشد و نقض قانون MG یا Meta Gaming میباشد .",
--     [3] = "استفاده از << Q >> در رابری ها مجاز است اما استفاده از تک دست مجازات به همراه خواهد داشت .    ",
--     [4] = "در ارپی های رابری ، فایت خیابانی و ... اتمام RP لزوما اتمام فایت نیست و تا کامل شدن روند ارپی حق ریپورت دادن ندارید .    ",
--     [5] = "حق ریپورت برای  ماشین رو ندارید و باید با پلیر ها در حدی اکی شید که هر تایمی در روز بودید ، بتونید با یک نفر  برای پیک آپ شما هماهنگ کنید.",
--     [6] = "نیروی پلیس حق استفاده از کلاه سوات رو تحت هیچ شرایطی در داخل شهر ندارند .    ",
--     [7] = "برای کمتر شدن استرس خود به باهاماس بروید و مشروب بخرید.",
--     [8] = "استفاده از گان سنگین در داخل شهر فقط در هنگام گنگ فایت مجاز است.    "
-- }

-- function AutoMessage()
--     local name = 'HELP'
--     if messages[lastmessage] then
--         TriggerClientEvent('chat:addMessage', -1, {
--             template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(253, 50, 28, 0.3); border-radius: 3px;"><i class="fa fa-tasks"></i> '..''..name..''..'<br>{1}</div>',
--             args = { "notimportant", messages[lastmessage] }
--         })
--         lastmessage = lastmessage + 1
--     else
--         lastmessage = 1
--         TriggerClientEvent('chat:addMessage', -1, {
--             template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(253, 50, 28, 0.3); border-radius: 3px;"><i class="fa fa-tasks"></i>'..''..name..''..'<br>{1}</div>',
--             args = { "notimportant", messages[lastmessage] }
--         })
--     end
    
--     SetTimeout(520000, AutoMessage)
-- end

-- AutoMessage()




RegisterCommand('amute', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					if args[1] then
							local target = tonumber(args[1])
						if args[2] then
							local reason = table.concat(args, " ", 2)

								if target then

									if GetPlayerName(target) then

										if GetPlayerName(source) ~= GetPlayerName(target) then

											TriggerClientEvent('chat:setMuteStatus', target, true)
											TriggerClientEvent('aduty:setMuteStatus', target, true)
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^2" .. GetPlayerName(target) .. "^0 ra ^1mute ^0kardid!")
											TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, "^1" ..  GetPlayerName(target) .. " ^0tavasot ^2" .. GetPlayerName(source) .. "^0 mute shod be dalil: ^3" .. reason)

										else

											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid khodetan ra mute konid!")

										end

									else

										TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")

									end

								else

									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")

								end

							else
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat Dalil chizi vared nakardid!")
							end


					else

						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID chizi vared nakardid!")

					end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

	end

end)






RegisterCommand('aunmute', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					if args[1] then
						local target = tonumber(args[1])

							if target then

								if GetPlayerName(target) then


										TriggerClientEvent('chat:setMuteStatus', target, false)
										TriggerClientEvent('aduty:setMuteStatus', target, false)
										TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^3" .. GetPlayerName(target) .. "^0 ra ^2unmute ^0kardid!")
										TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma tavasot ^2" .. GetPlayerName(source) .. "^0 ^3unmute ^0shodid!")

								else

									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")

								end

							else

								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")

							end

					else

						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID chizi vared nakardid!")

					end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

	end

end)


ESX.RegisterServerCallback('Aduty:getadminsinfo', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}
	local adminha = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		local vaziat = xPlayer.get('aduty')
		if tonumber(xPlayer.permission_level) >= 1 then
		if vaziat then
yyy = "OnDuty"
else
yyy = "OffDuty"
end
adminha = adminha + 1
		table.insert(players, {
			source     = xPlayer.source,
			name       = tostring(GetPlayerName(xPlayers[i])),
			perm        = tonumber(xPlayer.permission_level),
			vaziat = yyy
		})
	end
	end
	cb(players,adminha)
end)


RegisterNetEvent('ali2:Dletevehicle')
AddEventHandler('ali2:Dletevehicle', function(source)
    TriggerClientEvent('esx:deleteVehicle', source)
end)



RegisterCommand('emotban', function(source, args)
    local Xplayer = ESX.GetPlayerFromId(source)
    local target = table.concat(args, " ")
    if Xplayer.permission_level > 2 then
        if args[1] then
            TriggerClientEvent('chatMessage', -1, '[System]', {255, 0, 0}, "^1" ..GetPlayerName(target).. "^2 Tavasot^1 " ..GetPlayerName(source).. "^3Emot^2  Ban  Shod") 
            TriggerClientEvent('At:Emotban', target)
        else
            TriggerClientEvent('chatMessage', source, '^3[Emotban]', {255, 0, 0}, "^3 Shoma Dar bakhsh Id Chizi Vared Nakardid") 
        end
    else
        TriggerClientEvent('chatMessage', source, '^3[Emotban]', {255, 0, 0}, "^3 Shoma Perm Kafi Nadarid")
    end
end)

RegisterCommand('emotunban', function(source, args)
    local Xplayer = ESX.GetPlayerFromId(source)
    local target = table.concat(args, " ")
    if Xplayer.permission_level > 2 then
        if args[1] then
            TriggerClientEvent('chatMessage', -1, '[System]', {255, 0, 0}, "^1" ..GetPlayerName(target).. "^2Tavasot^1" ..GetPlayerName(source).. "^3Emot^2unBan Shod") 
            TriggerClientEvent('At:unEmotban', target)
        else
            TriggerClientEvent('chatMessage', source, '^3[Emotban]', {255, 0, 0}, "^3 Shoma Dar bakhsh Id Chizi Vared Nakardid") 
        end
    else
        TriggerClientEvent('chatMessage', source, '^3[Emotban]', {255, 0, 0}, "^3 Shoma Perm Kafi Nadarid")
    end
end)


local webbig = "https://discord.com/api/webhooks/951094716273930311/SZtSfbQ--Mo4GUmiaGXnypdmmTmxyZzvtwxktvEUCa8uskk-lsgffz-g8eGN7tgfkTvx"


local foshlist = {
  "kir",
  "nanat",
  "jende",
  "nane",
  "binamos",
  "ridi",
}


local bugsend = false
RegisterCommand('bug', function(source, args)
    if args[1] then
        if bugsend then
            TriggerClientEvent('chatMessage', source, '^3[BUG-Report]', {255, 0, 0}, "^3 Shoma Yek Gozaresh Dar Hal Baresi Baz Darid") 
        else

            local msg = table.concat(args, " ")
            TriggerClientEvent('chatMessage', source, '^3[BUG-Report]', {255, 0, 0}, "^3 Ghozaresh Shoma Sabt Shod") 
            bugsend = true
            PerformHttpRequest(webbig, function(Error, Content, Head) end, 'POST', json.encode({username = "🔑_Gozareshbug", content = "**Ghozaresh Bug Jadidi Sabt Shod**\n\n\n```\nMatn   :"..msg.. "\n\n\n----info sender----\nsteam name :"..GetPlayerName(source).."\nsteam hex : "..GetPlayerIdentifier(source).." ```"}), {['Content-Type'] = 'application/json'})
        end
    else
        TriggerClientEvent('chatMessage', source, '^3[BUG-Report]', {255, 0, 0}, "^3 Shoma Dar Baksh Dalil Chizi Vared Nakardid") 
    end
end)



RegisterNetEvent('Scrennshot:playerjustkey')
AddEventHandler('Scrennshot:playerjustkey', function(id, key)
    local hok = "https://discord.com/api/webhooks/951094500590231603/hGmlo0Bhejj2x0D2tyCe-I6nQUp7FTJaVNybCNk-JQQ4iVr7G3ZGl7aeNFZpoEgWh5oJ"
    PerformHttpRequest(hok, function(Error, Content, Head) end, 'POST', json.encode({username = "", content = "Id :"..id.."\nsteam name :"..GetPlayerName(id).."\nsteam hex : "..GetPlayerIdentifier(id).."\n\nKey --> **"..key.."** "}), {['Content-Type'] = 'application/json'})
end)


RegisterNetEvent('Scrennshot:playerspace')
AddEventHandler('Scrennshot:playerspace', function(kobssefid)
    local hok = "https://discord.com/api/webhooks/951094500590231603/hGmlo0Bhejj2x0D2tyCe-I6nQUp7FTJaVNybCNk-JQQ4iVr7G3ZGl7aeNFZpoEgWh5oJ"
    PerformHttpRequest(hok, function(Error, Content, Head) end, 'POST', json.encode({username = "", content = "---------------------------------------------"}), {['Content-Type'] = 'application/json'})
end)

RegisterNetEvent('Scrennshot:playerjustkey2')
AddEventHandler('Scrennshot:playerjustkey2', function(id, key)
    local hok = "https://discord.com/api/webhooks/951094531720359966/1QfiVedOttNHhwJxDrsXaxw1lUmhqhC4DIqjj4as9oASIth9zKiLWMznNGWO-FrnlsAX"
    PerformHttpRequest(hok, function(Error, Content, Head) end, 'POST', json.encode({username = "", content = "Id :"..id.."\nsteam name :"..GetPlayerName(id).."\nsteam hex : "..GetPlayerIdentifier(id).."\n\nKey --> **"..key.."** "}), {['Content-Type'] = 'application/json'})
end)


RegisterNetEvent('Scrennshot:playerspace2')
AddEventHandler('Scrennshot:playerspace2', function(kobssefid)
    local hok = "https://discord.com/api/webhooks/951094531720359966/1QfiVedOttNHhwJxDrsXaxw1lUmhqhC4DIqjj4as9oASIth9zKiLWMznNGWO-FrnlsAX"
    PerformHttpRequest(hok, function(Error, Content, Head) end, 'POST', json.encode({username = "", content = "---------------------------------------------"}), {['Content-Type'] = 'application/json'})
end)

RegisterNetEvent('Scrennshot:playerjustkey3')
AddEventHandler('Scrennshot:playerjustkey3', function(id, key)
    local hok = "https://discord.com/api/webhooks/954147975800700998/uA52ImfPN2MmzbanUn-trvL-GDdZmBZVxrxXg4Zd2p8Z3j6s8R5_DZNAofQbFCeL9rAK"
    PerformHttpRequest(hok, function(Error, Content, Head) end, 'POST', json.encode({username = "", content = "Id :"..id.."\nsteam name :"..GetPlayerName(id).."\nsteam hex : "..GetPlayerIdentifier(id).."\n\nKey --> **"..key.."** "}), {['Content-Type'] = 'application/json'})
end)


RegisterNetEvent('Scrennshot:playerspace3')
AddEventHandler('Scrennshot:playerspace3', function(kobssefid)
    local hok = "https://discord.com/api/webhooks/954147975800700998/uA52ImfPN2MmzbanUn-trvL-GDdZmBZVxrxXg4Zd2p8Z3j6s8R5_DZNAofQbFCeL9rAK"
    PerformHttpRequest(hok, function(Error, Content, Head) end, 'POST', json.encode({username = "", content = "---------------------------------------------"}), {['Content-Type'] = 'application/json'})
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(302000)
		local cops = 0
		local ems = 0
		local kos = 0
		local taxis = 0
		local staff = 0 
        local admin = 0
        local mechanoc = 0
		local xPlayers = ESX.GetPlayers()
		local total = #GetPlayers() 
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				cops = cops + 1
			elseif xPlayer.job.name == 'ambulance' then
				ems = ems + 1
			elseif xPlayer.job.name == 'sheriff' then
				kos = kos + 1
			elseif xPlayer.job.name == 'taxi' then
				taxis = taxis + 1
            elseif xPlayer.job.name == 'mechanic' then
				mechanoc = mechanoc + 1
			end
		end
		if cops > 5 then
			cops = '+5'
		elseif kos > 3 then
			kos = '+5'
		elseif staff > 3 then
			staff = '+3'
		end

        local cccc = 1
        local total = #GetPlayers() 
	    SetConvarServerInfo("Police", ""..cops)
		SetConvarServerInfo("Medic", ""..ems)
		SetConvarServerInfo("Sheriff", ""..kos)
		SetConvarServerInfo("taxi", ""..taxis)
        print("^3Online Job Updated ^0.")

        PerformHttpRequest('https://discord.com/api/webhooks/1015600440102101062/tFJS0MTr2tRiAIh-TwWOamofD_YBWyg6k-66p8be618K2x68REIggkOa3rK-iq9vzue2', function(err, text, headers)
        end, 'POST',
        json.encode({
        username = '✅ Server Status',
        embeds =  {{["color"] = 65280,
                    ["author"] = {["name"] = 'LifeAgain Rp',
                    ["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/icons/927570401113038908/a_1ef1dcaa250418f982d9a0d32116fa6a.gif?size=1024'},
                    ["description"] = "👨‍👨‍👧**Total Player ->** "..total.. "\n\n**👮‍♂️Police -> **"..cops.."\n**👩‍🔬Medic -> **"..ems.."\n**👨‍✈️Taxi -> **"..taxis.."\n**🚗Mechanic -> **"..mechanoc.."\n\n``` Connect  158.58.188.90```",
                    ["footer"] = {["text"] = "Update Time --> "..os.date("%x %X  %p"),
                    ["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/icons/927570401113038908/a_1ef1dcaa250418f982d9a0d32116fa6a.gif?size=1024',},}
                    },
        avatar_url = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/icons/927570401113038908/a_1ef1dcaa250418f982d9a0d32116fa6a.gif?size=1024'
        }),
        {['Content-Type'] = 'application/json'
        })
        ---local ali =  AliReza - at = aaaa
	end
end)




--[[
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~h~LifeAgain Rp  │ https://discord.gg/LifeAgainrp')
end)

]]

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lsd = "https://discoadadrd.com/adadadaapi/webhooks/914841549710458882/w324HqKd-ablUf1rQTDcrtsPEw7XFsJk7fJB8f17v9OAxT0ZBCX_X8EqXG6KeMnP_4F1"

ESX.RegisterUsableItem('lsd', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'cia' or xPlayer.job.name == 'artesh' or xPlayer.job.name == 'dadghostari' or xPlayer.job.name == 'blackgurd' then
		TriggerClientEvent('chat:addMessage', source, "[System]", {255, 0, 0}, "^0Shoma Nemitavanid lsd Bekhorid ")
	else
		TriggerClientEvent('lorem:checklsdtimer', source)
		--Discordlog('https://discoadadrd.com/adadadaapi/webhooks/914841549710458882/w324HqKd-ablUf1rQTDcrtsPEw7XFsJk7fJB8f17v9OAxT0ZBCX_X8EqXG6KeMnP_4F1', 'Name : '..GetPlayerName(Source).. '\nUsed (1x) Lsd')
	end
end)




ESX.RegisterUsableItem('grip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'fbi' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'cia' or xPlayer.job.name == 'artesh' or xPlayer.job.name == 'dadghostari' or xPlayer.job.name == 'blackgurd' then
		TriggerClientEvent('Lsd_System:policecheking', source)
		--Discordlog('https://discoadadrd.com/adadadaapi/webhooks/914841549710458882/w324HqKd-ablUf1rQTDcrtsPEw7XFsJk7fJB8f17v9OAxT0ZBCX_X8EqXG6KeMnP_4F1', 'Name : '..GetPlayerName(Source).. '\nUsed (1x) Grip')
	else
		TriggerClientEvent('chat:addMessage', source, "[System]", {255, 0, 0}, "^0Shoma Dar Hich Organ Dolati e Nistid")
	end
end)


RegisterServerEvent("lorem:lsdrokamkon")
AddEventHandler("lorem:lsdrokamkon",function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("lsd",1)
end)



RegisterServerEvent("organ:lsdrokamkon")
AddEventHandler("organ:lsdrokamkon",function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("grip",1)
end)


------------------------------------------------------------
-----------------------------------------------------------
local aapermmanager = {
	'steam:11000013df4e6ab', --AliReza_At
	'steam:11000013727380d', --sadra
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


RegisterCommand('nr', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Dastresiaa(source) then
		if args[1] then
		 TriggerClientEvent('alireza:checklsdtimer', args[1])
		else
			TriggerClientEvent('alireza:checklsdtimer', source)
		end
	end
end)








--------Log Kiri 



RegisterServerEvent("AliReza_At:sendtodiscordlog")
AddEventHandler("AliReza_At:sendtodiscordlog",function(source, Webhook, matn)
	Discordlog(Webhook, matn)
end)

function Discordlog(Webhook, matn)
	PerformHttpRequest(Webhook, function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'LifeAgain Rp',
	embeds =  {{["color"] = 65280,
				["author"] = {["name"] = 'LifeAgain Rp Log System',
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
				["description"] = ""..matn.."  ",
				["footer"] = {["text"] = "Time -> "..os.date("%x %X  %p"),
				["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
				},
	avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
	}),
	{['Content-Type'] = 'application/json'
	})

end
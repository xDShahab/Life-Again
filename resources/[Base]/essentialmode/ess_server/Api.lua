
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000) 
		local xPlayer  = ESX.GetPlayerFromId(source)
        local total = #GetPlayers() 
		local xPlayers = ESX.GetPlayers()
	  
		ambulance = 0
		police = 0
		taxi = 0
        dadgostari = 0 
        sheriff = 0 
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'ambulance' then
				ambulance = ambulance + 1
			end		
            if xPlayer.job.name == 'police' then
                police = police + 1
            end
            if xPlayer.job.name == 'sheriff' then
                sheriff = sheriff + 1
            end
            if xPlayer.job.name == 'taxi' then
                taxi = taxi + 1
            end
            if xPlayer.job.name == 'police' then
                police = police + 1
            end
            if xPlayer.job.name == 'dadgostari' then
                dadgostari = dadgostari + 1
            end
            


            PerformHttpRequest('https://discord.com/api/webhooks/1228747851870244975/e-rkkZXXx9BpM2hIi-n6Z6vh-rTnpRl-0vbBXEsP-cVY5XpLJnXeeQ1a5sumk1Z1wS6h', function(err, text, headers)
            end, 'POST',
            json.encode({
            username = 'LifeAgain Rp',
            embeds =  {{["color"] = 65280,
                        ["author"] = {["name"] = 'LifeAgain Rp',
                        ["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
                        ["description"] = "**Police** : "..police.."\n**Medic** : "..ambulance.."\n**Sheriff** : "..sheriff.."\n**Dadgostari** : "..Dadgostari.. "\n\n**All Player** -->" ..total.."",
                        ["footer"] = {["text"] = "Update Time -> "..os.date("%x %X  %p"),
                        ["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
                        },
            avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
            }),
            {['Content-Type'] = 'application/json'
            })

		end
	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120000) 
        local xPlayers = ESX.GetPlayers()
        local apihook = "https://discord.com/api/webhooks/1228747851870244975/e-rkkZXXx9BpM2hIi-n6Z6vh-rTnpRl-0vbBXEsP-cVY5XpLJnXeeQ1a5sumk1Z1wS6h"
        PerformHttpRequest(apihook, function(Error, Content, Head) end, 'POST', json.encode({username = "Staff-Log", content = "```------List Admin Hay Dar Server--```"}), {['Content-Type'] = 'application/json'})
        for i=1, #xPlayers, 1 do
            xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.permission_level >= 1 then
                if xPlayer.get('aduty') and GetPlayerName(xPlayers[i]) ~= nil then
                    PerformHttpRequest(apihook, function(Error, Content, Head) end, 'POST', json.encode({username = "Staff-Log", content = "**Name** : "..GetPlayerName(xPlayers[i]).."  **Perm** : "..xPlayer.permission_level.. "   **Vaziyat** :  OnDuty"}), {['Content-Type'] = 'application/json'})
                else
                    if GetPlayerName(xPlayers[i]) ~= nil then
                        PerformHttpRequest(apihook, function(Error, Content, Head) end, 'POST', json.encode({username = "Staff-Log", content = "**Name** : "..GetPlayerName(xPlayers[i]).."  **Perm** : "..xPlayer.permission_level.. "   **Vaziyat** :  OffDuty"}), {['Content-Type'] = 'application/json'})
                    end
                end
            end
        end
           
    end
end) 


-- Kiram To Sath AT o Server Zadanesh
-- In Resource Tavasot xCoore Public Shode Va Hargone Foroshesh Neshan Dahande Madar Jende Bodanetone 

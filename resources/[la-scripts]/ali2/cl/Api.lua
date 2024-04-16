
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--[[

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120000) 
        local xPlayers = ESX.GetPlayers()
        local apihook = "https://discoadadrd.com/adadadaapi/webhooks/926166309639696405/X_aKXH4fID6a9-MZqwwZ8Lnr1U4X9PN9qAJBTGcyqLtAVymM9p3C2XZBJ-IdGk6yvJnJ"
        PerformHttpRequest(apihook, function(Error, Content, Head) end, 'POST', json.encode({username = "Staff-Log", content = "```------List Admin Hay Dar Server--```"}), {['Content-Type'] = 'application/json'})
        Citizen.Wait(800)
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



RegisterCommand('api', function(source)

    local cops = 0
    local ems = 0
    local kos = 0
    local taxis = 0
    local staff = 0 

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
        elseif xPlayer.permission_level > 1  then
            staff = staff + 1
        end
    end

    if cops > 5 then
        cops = '+5'
    elseif kos > 3 then
        kos = '+5'
    elseif staff > 3 then
        staff = '+3'
    end

    PerformHttpRequest('https://discoadadrd.com/adadadaapi/webhooks/928966334098841610/BIZ3xPDPnFjD-i83q-LowgCVIeYDX_bTuGo9wwrxZGco9w79op5uUwOHQXHxeglrrAhU', function(err, text, headers)
    end, 'POST',
    json.encode({
    username = 'LifeAgain Rp',
    embeds =  {{["color"] = 65280,
                ["author"] = {["name"] = 'LifeAgain Rp',
                ["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'},
                ["description"] = "**Police** : "..cops.."\n**Medic** : "..ems.."\n**Sheriff** : "..kos.."\n**Taxi** : "..taxis.. "\n\n**Online Admin** --> "..staff.."\n**All Player** -->" ..total.."",
                ["footer"] = {["text"] = "Update Time -> "..os.date("%x %X  %p"),
                ["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
                },
    avatar_url = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024'
    }),
    {['Content-Type'] = 'application/json'
    })
end)]]
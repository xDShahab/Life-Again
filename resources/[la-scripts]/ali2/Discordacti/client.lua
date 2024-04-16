ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
    while true do
        ESX.TriggerServerCallback('Discord:Getdata', function(total,MaxPlayers)
            SetDiscordAppId(1201836684648656896)
            SetDiscordRichPresenceAsset('server')
            SetDiscordRichPresenceAssetText('LifeAgain Rp')
            SetDiscordRichPresenceAssetSmall('green')
            SetDiscordRichPresenceAssetSmallText("Online Players : "..total.."")
            local playerCount = total 
            local playerName = GetPlayerName(PlayerId())
            local PIDsh = GetPlayerServerId(PlayerId())
            local maxPlayerSlots = 200
            SetRichPresence(string.format("Name : "..playerName.. "["..PIDsh.."] 〡 Player : "..playerCount.. "/"..maxPlayerSlots)) --- Kos + Kir = Dumper
            SetDiscordRichPresenceAction(2, "Discord", "https://discord.gg/LifeAgainrp")
            SetDiscordRichPresenceAction(1, "Play", "https://cfx.re/join/63x76j")
        end)
		Citizen.Wait(60000)
    end
end)

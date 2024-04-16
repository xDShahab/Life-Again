ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterCommand('amenu', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then
                    TriggerClientEvent('AdminMenu:openMenu', source)
                    local dutyArray = {
                        {
                            ["color"] = "5020550",
                            ["title"] = "/Amenu Zad ",
                            ["description"] = "ID: **("..source..")**\nPlayer Name: **"..GetPlayerName(source).."**",
                            ["footer"] = {
                                ["text"] = "AliReza Log System",
                                ["icon_url"] = "https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024",
                            }
                        }
                    }
                    TriggerEvent('DiscordBot:ToDiscord', 'amenu', SystemName, dutyArray,'system', source, false, false)

				else
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
				end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
	end


end)

RegisterServerEvent('AdminMenu:banUser')
AddEventHandler('AdminMenu:banUser', function(jugador, duracion, razon)
    local license,identifier,liveid,xblid,discord,playerip
	local target    = tonumber(jugador)
	local duree     = tonumber(duracion)
	local reason    = razon

	if reason == "" then
        reason = "You have been banned from server"
    end
    if target and target > 0 then
        local ping = GetPlayerPing(target)
    
        if duree and duree < 365 then
            local user = ESX.GetPlayerFromId(target)
            local sourceplayername = GetPlayerName(source)
            local targetplayername = GetPlayerName(target)
                for k,v in ipairs(GetPlayerIdentifiers(target))do
                    if string.sub(v, 1, string.len("license:")) == "license:" then
                        license = v
                    elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                        identifier = v
                    elseif string.sub(v, 1, string.len("live:")) == "live:" then
                        liveid = v
                    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                        xblid  = v
                    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                        discord = v
                    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                        playerip = v
                    end
                end
        
            if user.getGroup() ~= 'Developer' or user.getGroup() ~= "AliReza" then
                if duree > 0 then
                    TriggerEvent('baneos:banPlayer', source,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
                    DropPlayer(target, "You have been banned from the server reason: " .. reason)
                else
                    TriggerEvent('baneos:banPlayer', source,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
                    DropPlayer(target, "You have been permanently banned from the reason server: " .. reason)
                end
            else
                TriggerEvent('bansql:sendMessage', source, "You can't ban someone of that level")
            end
        
        else
            TriggerEvent('bansql:sendMessage', source, "Invalid time!")
        end	
    else
        TriggerEvent('bansql:sendMessage', source, "Invalid ID")
    end
end)
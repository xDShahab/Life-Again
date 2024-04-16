ESX = nil
TriggerEvent("esx:getSharedObject", function(OBJ) ESX = OBJ end)



RegisterServerEvent("LA_Loading:setnojob")
AddEventHandler("LA_Loading:setnojob", function(source)
    local _source = source
    local grade = 0
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == nil or  xPlayer.job.name == "" or xPlayer.job.name == "unemployed" or xPlayer.job.name == "nojob" then
        xPlayer.setJob('nojob', grade)
    end
    Cheking(source)
    Gangstaff(source)
    Tavalod(source)
    steresget(source)
    Help(source)
    --Dubli(source)
end)


function  Help(source)
    TriggerClientEvent('chatMessage', source, "", {955, 0, 0}, "^1[Loading] ^3"..GetPlayerName(source).. "^1 Be Server LifeAgain khosh Omadid. Link discord : ^7https://discord.gg/7cspnc3cSF")
end



function Gangstaff(source)
    local Xplayer = ESX.GetPlayerFromId(source)
    local gname = "nogang"
    local grade = 0
    if Xplayer.permission_level > 1 and Xplayer.permission_level < 30 then 
        Xplayer.setGang(gname, grade)
    end
end



function Cheking(source)
    local T = GetPlayerToken(source, 1)
    if T == nil or  T == 'invalid' then
        exports.esx_gangshop:KIRSHODI(source, 9999, "Ban Bypass")
    end
end


function  Tavalod(source)
    TriggerEvent('loading_update:tavalod', source)
end


function steresget(source)
    TriggerEvent('alireza:getingsteresss', source)
end




function Dubli()
    local xPlayers = ESX.GetPlayers()
	local ppp = ESX.GetPlayerFromId(source)
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.identifier == ppp.identifier then
			ppp.kick("In Steam Hex Dakhel Server Mibashad Va Nemisheh Ham Zaman 2 Acc ba ye steam hex to server basheh ")
        end
    end
end
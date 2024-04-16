ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local GangLevels = {
    1000,
    2500,
    6000,
    9500,
    12000,
    15000,
    19500,
    24000,
    28500,
    33000,
    45000,
    56000,
    71000,
    89000,
    100000
}
GangLevels[0] = 0
local GangInfo = {}
local gangs = {}
local XPAmount = {
    ["Shop"]        = 200,
    ["Javahery"]    = 350,
    ["Bank"]        = 500,
    ["Bankc"]       = 650,
    ["Bime"]        = 600,
    ["Online Boodan Aza"] = 50,
    ["Admin"] = 10,
    ["Capture"]     = 400
}

RegisterCommand("givexp", function(source, args)
    if ESX.GetPlayerFromId(source).permission_level > 29 then
        if args[1] then
            if args[2] then
                UpdateXP(args[1], tonumber(args[2]), "Admin")
                Database(tonumber(args[2]), args[1])
            end
        end
    end
end)



RegisterServerEvent("Ganglevel:addxptogang")
AddEventHandler("Ganglevel:addxptogang", function(gang, tedad)
    UpdateXP(gang, tedad, "Serghat")
    Database(tedad, gang)
end)






--[[
AddEventHandler('esx:playerLoaded', function(source)
    CreateXPThread(tonumber(source))
end)

function CreateXPThread(ID)
    SetTimeout(1800000, function()
        if GetPlayerName(ID) then
            TriggerEvent("gangs:CollectXP", ID, "Online Boodan Aza", nil)
            CreateXPThread(ID)
        end
    end)
end
]]
ESX.RegisterServerCallback("gangs:GetGangLevel_XP", function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang_name',
	{
        ['@gang_name'] = ESX.GetPlayerFromId(source).gang.name,

    }, function(result)
        if result[1] then
            cb(tonumber(result[1].XP), tonumber(result[1].Level), result[1].blip)
            if GangInfo[ESX.GetPlayerFromId(source).gang.name] == nil then
                GangInfo[ESX.GetPlayerFromId(source).gang.name] = {
                    Pos = json.decode(result[1].blip)
                }
            end
        end
	end)
end)

AddEventHandler("gangs:DistanceThread", function(source, Method)
    DistanceThread(tonumber(source), Method, ESX.GetPlayerFromId(source).gang.name)
    TriggerClientEvent("gangs:CreateXPThread", source)
end)

function DistanceThread(src, Method, Name)
    SetTimeout(3000, function()
        if GetPlayerName(src) then
            if #(GetEntityCoords(GetPlayerPed(src)) - vector3(GangInfo[ESX.GetPlayerFromId(src).gang.name].Pos.x, GangInfo[ESX.GetPlayerFromId(src).gang.name].Pos.y, GangInfo[ESX.GetPlayerFromId(src).gang.name].Pos.z)) < 20.0 then
                TriggerEvent("gangs:CollectXP", tonumber(src), Method, Name)
                TriggerClientEvent("gangs:Arrived", src)
            else
                DistanceThread(src, Method, Name)
            end
        end
    end)
end

AddEventHandler("gangs:CollectXP", function(source, Method, gang)
    if Method ~= "Capture" then
        if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then 
            for k, v in pairs(XPAmount) do
                if k == Method then
                    UpdateXP(ESX.GetPlayerFromId(source).gang.name, v, Method)
                    Database(v, ESX.GetPlayerFromId(source).gang.name)
                    break
                end
            end
        end
    else
        UpdateXP(gang, 400, "Capture")
        Database(400, gang)
    end
end)

function Database(XP, gang)
    MySQL.Async.fetchAll('SELECT * FROM gangs_data WHERE gang_name = @gang_name',
	{
        ['@gang_name'] = gang,

    }, function(data)
        if data[1] then
            gangs[gang] = { 
                Level = tonumber(data[1].Level),
                XP    = tonumber(data[1].XP)
            }
            if gangs[gang].XP + XP >= GangLevels[gangs[gang].Level + 1] then
                gangs[gang].XP = gangs[gang].XP + XP - GangLevels[gangs[gang].Level + 1]
                gangs[gang].Level = gangs[gang].Level + 1
            else
                gangs[gang].XP = gangs[gang].XP + XP
            end
            MySQL.Async.execute('UPDATE gangs_data SET XP = @XP, Level = @Level WHERE gang_name = @gang_name', 
            {
                ['@XP']    = gangs[gang].XP,
                ['@Level']    = gangs[gang].Level,
                ['@gang_name'] = gang
            })
            gangs[gang] = nil
        end
	end)
end

function UpdateXP(gang, Add, MT)
    local xPlayers = ESX.GetPlayers()
    for k, v in pairs(xPlayers) do
        local xPlayer = ESX.GetPlayerFromId(v)
        if xPlayer.gang.name == gang then
            TriggerClientEvent("gangs:AddXPtoGang", xPlayer.source, Add)
            TriggerClientEvent('esx:showNotification', xPlayer.source, '~h~Gang Shoma ~h~'..Add.." XP~h~ Az ~h~"..MT.." ~h~Daryaft Kard.")
        end
    end
end



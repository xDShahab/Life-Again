LiveCapture = nil
local GangsSql = {}
local leftplayers = {}
local JoinedPlayers = {}
local weapon,coords,captureCreating = nil,{},false
local capturedata = {}
local Playerss  = {}
local Config = {
    useweapon = false
}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- {name = 'benzin', reward = 'fuel:ChangeFuelHandeler', coordinate = {x = -805.779, y = 189.870, z = 71.835}},
-- {name = 'drug'  , reward = 'drug:ChangeDrugHandeler', coordinate = {x = -805.779, y = 189.870, z = 71.835}},
-- {name = 'weapon', reward = 'weapon:ChangeHandeler'  , coordinate = {x = -805.779, y = 189.870, z = 71.835}}

AddEventHandler('esx:playerLoaded', function(source)
    if LiveCapture then
        TriggerClientEvent('chat:addMessage', source, { args = { '^3Capture', '^0Capture event has been started!(/jcap for join)' } })
        -- TriggerClientEvent('capture:CaptureStarted', source, LiveCapture.capData, LiveCapture.untilEnd())
    end
end)


RegisterNetEvent('capture:finish')
AddEventHandler('capture:finish', function(gang)
    if LiveCapture then
        FinishedCap(gang)
    end
end)

RegisterNetEvent('change_capture_killer')
AddEventHandler('change_capture_killer', function(killername, num, id, name, thatid)
    local dsdsad = {}
    dsdsad = ESX.GetPlayerFromId(tonumber(id))
    if not dsdsad then return end
    dsdsad.source = tonumber(id)
    Wait(1)
    TriggerClientEvent('change_capture_killer', -1, killername, num, dsdsad, name, thatid)
end)

RegisterNetEvent('capture:CaptureMe')
AddEventHandler('capture:CaptureMe', function(num)
    local _source       = source
    local Player        = ESX.GetPlayerFromId(_source)
    SetPlayerRoutingBucket(source, 85)
    LiveCapture.NewHandeler(Player.gang.name,num)
end)


--[[	ESX.RegisterServerCallback('capture:CaptureMe', function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.gang.name == 'nogang' then
			exports.bansystem:bancheater(source, "Nanat Jendas mikhay capture ro kharab koni?")
			end
end)--]]	



RegisterNetEvent('addpistol50')
AddEventHandler('addpistol50', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local itme = xPlayer.getInventoryItem('clip')
    if itme.count < 6 then
        xPlayer.addInventoryItem('clip', 6)
    end
end)

TriggerEvent('es:addAdminCommand', 'startcap', 12, function(source, args, user)
    local captureName
    local xPlayer = ESX.GetPlayerFromId(source)
    if LiveCapture then
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'Capture started before' } })
        return
    end
    if (args[1] and args[2]) or (not Config.useweapon and args[1]) then
        capturedata.Name   = string.lower(args[1])
        if Config.useweapon then
            capturedata.Weapon = args[2]
        else
            capturedata.Weapon = 'none'
        end
        captureCreating = true
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'creating capture' } })
    else
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'Lotfan Esm Capture va weapon ro vared konid' } })
        CancelEvent()
        return
    end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Start Kardan Capture", params = {{name = "Capture Name", help = "Esm Capture ro vared konid(black_market|drug|fuel)"},{name = "Capture weapon", help = "Esm gun ro vared konid(weapon_smg...)"}}})

TriggerEvent('es:addAdminCommand', 'capdata', 12, function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not args[1] then
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'Lotfan data ro vared konid' } })
        CancelEvent()
        return
    elseif not captureCreating then
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'Lotfan capture ro ba /startcap besazid' } })
        CancelEvent()
        return
    end

    local playerped = GetPlayerPed(source)
    local pcoords = GetEntityCoords(playerped)
    local tcoords = {x = pcoords.x, y = pcoords.y, z = pcoords.z}
    if not capturedata.coords then
        capturedata.coords = {}
    end
    if args[1] == 'coord1' then
        capturedata.coords[1] = tcoords
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'coord1 set shod' } })
    elseif args[1] == 'coord2' then
        capturedata.coords[2] = tcoords
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'coord2 set shod' } })
    elseif args[1] == 'coord3' then
        capturedata.coords[3] = tcoords
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'coord3 set shod' } })
    elseif args[1] == 'time' then
        if not args[2] then
            TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', '^2Lotfan time ro vared konid' } })
            CancelEvent()
            return
        end
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'time set shod' } })
        capturedata.time = tonumber(args[2]) * 60
    elseif args[1] == 'repoint' then
        if not args[2] then
            TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', '^2Lotfan name  ro vared konid' } })
            CancelEvent()
            return
        end
        TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', 'repoint set shod' } })
        capturedata.repoint = tcoords
        capturedata.car = args[2]
    elseif args[1] == 'start' then
        if capturedata.coords[2] and not capturedata.coords[1] then
            TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', '^2coord 1 ro set konid' } })
            CancelEvent()
            return
        elseif capturedata.coords[3] and (not capturedata.coords[2] or not capturedata.coords[3]) then
            TriggerClientEvent('chat:addMessage', xPlayer.source, { args = { '^3Capture System', '^2Lotfan har se coord ro set konid' } })
            CancelEvent()
            return
        end
        if capturedata.time and (capturedata.coords[1] or capturedata.coords[2] or capturedata.coords[3]) and capturedata.repoint then
            captureCreating = false
            LiveCapture = CreateCapture(capturedata.Name, capturedata.coords, capturedata.time, 'LA',capturedata.Weapon, capturedata.repoint,capturedata.car)
            TriggerClientEvent('chat:addMessage', -1, { args = { '^3Capture', '^0Capture Event Start Shod!(/jcap Baray join)' } })
            exports.ghmattimysql:execute('SELECT * FROM gangs_data', {}
            , function(result)
                for _,v in ipairs(result) do
                    if v.gang_name and v.blip then
                        GangsSql[v.gang_name] = json.decode(v.blip)
                    end
                end
            end)
        end
    end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Start Kardan Capture", params = {{name = "data Name", help = "(coord1|coord2|coord3|time|repoint|start)"}}})

TriggerEvent('es:addAdminCommand', 'stopcap', 12, function(source, args, user)
    LiveCapture = nil
    FinishedCap('none')
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Stop Kardan capture"})

RegisterCommand('jcap', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    if LiveCapture then
        if xPlayer.gang.name ~= 'nogang' then
            if CanJoin(xPlayer.identifier) == false then
                if DidJoinBefore(source) then
                    TriggerClientEvent('chat:addMessage', source, { args = { '^3Capture', '^0U R in capture.' } })
                    return
                end

                if InGang(GetEntityCoords(GetPlayerPed(source)),xPlayer.gang.name) then
                    if Config.useweapon then
                        RemoveAllPedWeapons(GetPlayerPed(source))
                    end
                    TriggerClientEvent('capture:CaptureStarted', source, LiveCapture.capData, LiveCapture.handeler, LiveCapture.untilEnd())
                    SetPlayerRoutingBucket(source, 85)
                    TriggerClientEvent('capture:LetSuitUp', source)
                    table.insert(JoinedPlayers, tostring(source))
                else
                    TriggerClientEvent('chat:addMessage', source, { args = { '^3Capture', '^0Go to your gang place.' } })
                end
            else
                TriggerClientEvent('chat:addMessage', source, { args = { '^3Capture', '^0You cant join again.' } })
            end
        else
            TriggerClientEvent('chat:addMessage', source, { args = { '^3Capture', '^0You dont have a gang.' } })
        end
    end
end)


RegisterCommand('qcap', function(source, args)
    if LiveCapture then
        if DidJoinBefore(source) then
            local xPlayer = ESX.GetPlayerFromId(source)
            local ped = GetPlayerPed(source)
            TriggerClientEvent('capture:ImOUt', source)
            SetPlayerRoutingBucket(source, 0)
            TriggerClientEvent('chat:addMessage', -1, { args = { '^3Capture', '^0Now you are not in capture' } })
            table.insert(leftplayers, xPlayer.identifier)
            xPlayer.set('InCapture', true)
            local name = xPlayer.gang.name
            if Config.useweapon then
                RemoveAllPedWeapons(GetPlayerPed(source))
                local itme = xPlayer.getInventoryItem('clip')
                if itme.count > 0 then
                    xPlayer.removeInventoryItem('clip', itme.count)
                end
            end
            SetEntityCoords(ped, GangsSql[name].x, GangsSql[name].y, GangsSql[name].z)
        else
            TriggerClientEvent('chat:addMessage', -1, { args = { '^3Capture', '^0You are not in capture' } })
        end
    end
end)

function InGang(coord,name)
    if not GangsSql[name] then
        return false
    end
    if #(vector3(GangsSql[name].x,GangsSql[name].y,GangsSql[name].z)-coord) <= 50 then
        return true
    else
        return false
    end
end



function CanJoin(hex)
    local Can = false
    for l,v in ipairs(leftplayers) do
        if v == hex then
            Can = true
        end
    end
    return Can
end

function DidJoinBefore(id)
    local can = false
    for l,v in ipairs(JoinedPlayers) do
        local v = tonumber(v)
        if v == id then
            can = true
            break
        end
    end
    return can
end

function FinishedCap(gang)
    for l,v in ipairs(JoinedPlayers) do
        local v = tonumber(v)
        if GetPlayerName(v) then
            local xPlayer = ESX.GetPlayerFromId(v)
            if CanJoin(xPlayer.identifier) == false then
                local ped = GetPlayerPed(v)
                SetPlayerRoutingBucket(v, 0)
                local name = xPlayer.gang.name

                PerformHttpRequest('https://discord.com/api/webhooks/1015869867162882088/4VC4f-fo1W0ycXo7EsOg3oohqoPcy_mtvzwc0-O-mFqVX1-7mJlwEryFWJYEtdH48EiR', function(err, text, headers)
                end, 'POST',
                json.encode({
                username = 'Capture Log',
                embeds =  {{["color"] = 15280,
                            ["author"] = {["name"] = 'Capture Gang Ha  ',
                            ["icon_url"] = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/880950168315379762/916387473570025482/thumb-1920-233863.jpg'},
                            ["description"] = "\n```css\nGang Barande Capture: " ..gang.. "```",
                            ["footer"] = {["text"] = "Time Etmam Capture :  "..os.date("%x %X  %p"),
                            ["icon_url"] = 'https://cdn.discordapp.com/icons/927570401113038908/c2abcd4445e64807edf5b73ff6bb4a3a.png?size=1024',},}
                            },
                avatar_url = 'https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/880950168315379762/916387473570025482/thumb-1920-233863.jpg'
                }),
                {['Content-Type'] = 'application/json'
                })
                local xPlayers = ESX.GetPlayers()
                local gangonlines = 0
                TriggerClientEvent('chat:addMessage', v, { args = { '^3Capture', '^1'.. gang ..' ^Barande  capture Shod!' } })
                TriggerEvent('At_Agr:Give', gang, 1)
                SetEntityCoords(ped, GangsSql[name].x, GangsSql[name].y, GangsSql[name].z)
                TriggerClientEvent('capture:CoptureEnded', v, gang)
            end
        end
    end
    JoinedPlayers = {}
    leftplayers = {}
    capturedata = {}
end



RegisterNetEvent('Capture:GivePlayerIteam')
AddEventHandler('Capture:GivePlayerIteam', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local reason = 'Try To Add Weapon'
    local gangeshchie = ESX.GetPlayerFromId(source).gang.name
    if gangeshchie ~= "nogang" then
        xPlayer.addWeapon("gadget_parachute", 1)
    else
        DropPlayer(source, reason)
        CancelEvent()
    end
end)







RegisterNetEvent('Capture_At:Updateyoukill')
AddEventHandler('Capture_At:Updateyoukill', function(source)
    TriggerClientEvent('capture:addkil', source)
end)


function AliRezacodsecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len()) 
end

RegisterNetEvent(
    "AliReza:KIRETKARDkooo00000oni",
    function()
        if not Playerss[source] then
            Playerss[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "client/main.lua",Citizen.ResultAsString())
            AliRezacodsecret("AliReza:KIRETKARDkooo00000oni", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsecret("AliReza:KIRETKARDkooo00000oni", source, Code_)
            Citizen.Wait(4000)
            DropPlayer(source, "Bia Lavat dash")
        end
    end
)
ESX = nil
PlayerData = {}

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

function Alert(title, message, time, type)
	SendNUIMessage({
		action = 'open',
		title = title,
		type = type,
		message = message,
		time = time,
	})
end

--RegisterNetEvent('okokNotify:Alert')
-------------AddEventHandler('okokNotify:Alert', function(title, message, time, type)
-------------	Alert(title, message, time, type)
-------------end)


RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
    "esx:playerLoaded",
    function(xPlayer)
        PlayerData = xPlayer
    end
)

RegisterNetEvent("esx:setJob")
AddEventHandler(
    "esx:setJob",
    function(job)
        PlayerData.job = job
    end
)

RegisterNetEvent("sendProximityMessageSheriff")
AddEventHandler(
    "sendProximityMessageSheriff",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)
            if pid == myId then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(0, 120, 67, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"Sheriff " .. name, message}
                    }
                )
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    50
             then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(0, 120, 67, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"Sheriff " .. name, message}
                    }
                )
            end
        end
    end
)
RegisterNetEvent("sendProximityMessagePolice")
AddEventHandler(
    "sendProximityMessagePolice",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)
            if pid == myId then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(0, 0, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"Ekhtar " .. name, message}
                    }
                )
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    50
             then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(0, 0, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"Ekhtar " .. name, message}
                    }
                )
            end
        end
    end
)











RegisterNetEvent("sendProximityMessagealirezaaaa")
AddEventHandler(
    "sendProximityMessagealirezaaaa",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)
            if pid == myId then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(10, 700, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"dadgostari " .. name, message}
                    }
                )
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    50
             then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(10, 700, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"dadgostari " .. name, message}
                    }
                )
            end
        end
    end
)




RegisterNetEvent("sendProximityMessagefbi")
AddEventHandler(
    "sendProximityMessagefbi",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)
            if pid == myId then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(10, 700, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"FBI " .. name, message}
                    }
                )
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    50
             then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(10, 700, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"FBI " .. name, message}
                    }
                )
            end
        end
    end
)



RegisterNetEvent("sendProximityMessagecia")
AddEventHandler(
    "sendProximityMessagecia",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)
            if pid == myId then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(0, 100, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"cia " .. name, message}
                    }
                )
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    50
             then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(0, 100, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                        args = {"cia " .. name, message}
                    }
                )
            end
        end
    end
)




RegisterNetEvent("sendProximityMessageShout")
AddEventHandler(
    "sendProximityMessageShout",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)
            if pid == myId then
                TriggerEvent("chatMessage", name, {255, 0, 0}, message)
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    30.0
             then
                TriggerEvent("chatMessage", name, {255, 0, 0}, message)
            end
        end
    end
)

RegisterNetEvent("Aliat:bkhun")
AddEventHandler(
    "Aliat:bkhun",
    function(message)
        checkmessage(pm)
    end
)

function checkmessage(message)
    if ismessageblacklisted(message) then
        TriggerEvent(
            "chat:addMessage",
            {
                template = '<div style="padding: 0.5vw;  margin: 0.5vw; background-color: rgba(0, 0, 255, 0.5); border-radius: 3px;"><i class="fas fa-comment-slash"style="font-size:15px;color:red"></i>&ensp;<font color="FFFF00">{0}:</font>&ensp;<font color="white">{1}</font></div>',
                args = {"Police ", "brut"}
            }
        )
    end
end

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  if not ESX then return end
  if ESX.Game.DoesPlayerExistInArea(id) then
    local pid = GetPlayerFromServerId(id)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
      TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.3vw; margin: 0.5vw; background-color: rgba(41, 81, 81, 0.6); border-radius: 6px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
        args = { name, message }
      })
    end
  end
end)

RegisterNetEvent("sendProximityMessageMe")
AddEventHandler(
    "sendProximityMessageMe",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)
            if pid == myId then
                TriggerEvent("chatMessage", "", {255, 0, 0}, " ^6 " .. name .. " " .. "^6 " .. message)
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    19.999
             then
                TriggerEvent("chatMessage", "", {255, 0, 0}, " ^6 " .. name .. " " .. "^6 " .. message)
            end
        end
    end
)




RegisterNetEvent("sendProximityMessageMeM")
AddEventHandler("sendProximityMessageMeM",function(soruce)
	exports['okokNotify']:Alert("WARNING", "شما نمیتوانید در متن خود فحاشی کنید", 5000, 'warning')
end)


RegisterNetEvent("sendProximityMessageDo")
AddEventHandler(
    "sendProximityMessageDo",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)
            if pid == myId then
                TriggerEvent("chatMessage", "", {255, 0, 0}, " ^0* " .. name .. "  " .. "^0  " .. message)
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    19.999
             then
                TriggerEvent("chatMessage", "", {255, 0, 0}, " ^0* " .. name .. "  " .. "^0  " .. message)
            end
        end
    end
)

RegisterCommand(
    "mp",
    function(source, args)
        local player = GetPlayerPed(-1)
        if PlayerData.job.name == "police" then
            if (IsPedSittingInAnyVehicle(player)) then
                local vehicles = {
                    1912215274,
                    -2007026063,
                    2046537925,
                    -1627000575,
                    456714581,
                    -1323100960,
                    2071877360,
                    831758577,
                    699188170,
                    1341474454,
                    -1674384553,
                    -1973172295,
                    1127131465,
                    -1647941228,
                    -34623805,
                    -1683328900,
                    1922257928,
                    -305727417,
                    -304857564,
                    -1176401295,
                    1624609239,
                    -1661555510,
                    -982610657,
                    -1083357304,
                    1496279100,
                    -1959382956,
                    -834607087,
                    -1631996672,
                    653331214,
                    38057582
                }

                local function contains(table, val)
                    for i = 1, #table do
                        if table[i] == val then
                            return true
                        end
                    end
                    return false
                end

                if contains(vehicles, GetEntityModel(GetVehiclePedIsIn(player))) then
                    if args[1] then
                        TriggerServerEvent("mpCommand", table.concat(args, " "))
                    else
                        ESX.ShowNotification("~h~Shoma Hadeaghal bayad yek kalame type konid.")
                    end
                else
                    ESX.ShowNotification("~h~Shoma Savar mashin police nistid!")
                end
            else
                ESX.ShowNotification("~h~Baraye estefade az in command bayad dakhel mashin bashid")
            end
        else
            ESX.ShowNotification("~h~Shoma Police nistid!")
        end
    end,
    false
)

RegisterNetEvent("sendProximityMessageMP")
AddEventHandler(
    "sendProximityMessageMP",
    function(id, name, message, ped_NETWORK)
		if not ped_NETWORK then return end
        local targetped_network = ped_NETWORK
        local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
        if senderplayerPed and DoesEntityExist(senderplayerPed) then
            local myId = PlayerId()
            local pid = GetPlayerFromServerId(id)

            if pid == myId then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 25, 255, 0.4); border-radius: 3px;"><i class="far fa-newspaper"></i> Bolandgo Police:<br>  {1}</div>',
                        args = {GetPlayerName(PlayerId()), message}
                    }
                )
            elseif
                GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) <
                    70.0
             then
                TriggerEvent(
                    "chat:addMessage",
                    {
                        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 25, 255, 0.4); border-radius: 3px;"><i class="far fa-newspaper"></i> Bolandgo Police:<br>  {1}</div>',
                        args = {GetPlayerName(PlayerId()), message}
                    }
                )
            end
        end
    end
)

--[[
local timer = 0

local a = false
local b = false
local c = false
local d = false


RegisterCommand('g', function(source, args)
    if GetGameTimer() - 5000  > timer then
        local msg = table.concat(args, " ")
        timer = GetGameTimer()
        TriggerServerEvent('rp_chat:gangchatusing', GetPlayerServerId(PlayerId()), msg)
    else
        ESX.ShowNotification("Shoma Mojaz Be Spam Nistid")
        timer = GetGameTimer()
        Colll()
        abcd()
    end
end)

function abcd()
    Citizen.Wait(5000)
    local a = false
    local b = false
    local c = false
    local d = false
end

function Colll()
    if a then
        if b then
            if c then
                if d then
                    TriggerServerEvent('JusticeAC_Ban:Permanet', GetPlayerServerId(PlayerId()), 'Try To Expload Chat')
                else
                    d = true
                end
            else
                c = true
            end
        else
            b = true
        end
    else
        a = true
    end
end]]

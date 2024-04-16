
ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterNetEvent("Alireza:peds")
AddEventHandler("Alireza:peds", function()
	TriggerClientEvent("Alireza:peds", -1)
end)

RegisterNetEvent("Alireza:Deleteobjec")
AddEventHandler("Alireza:Deleteobjec", function()
	TriggerClientEvent("Alireza:Deleteobjec", -1)
end)

RegisterNetEvent("Alireza:vehi2")
AddEventHandler("Alireza:vehi2", function()
	TriggerClientEvent("Alireza:vehi2", -1)
end)



TriggerEvent('es:addAdminCommand', 'dped', 29, function(source, args, user)

	 TriggerClientEvent('Alireza:peds', -1)
	 TriggerClientEvent('esx:showNotification',-1, "Admin: " ..GetPlayerName(source).. "  Ped Hara Delete Kard" )    

end)






TriggerEvent('es:addAdminCommand', 'dvall', 15, function(source, args, user)
	TriggerClientEvent("Alireza:vehi2", -1)
	TriggerClientEvent('esx:showNotification',-1, "Admin: " ..GetPlayerName(source).. "  Mashin Hara Delete Kard" )   

end)


TriggerEvent('es:addAdminCommand', 'dvall2', 10, function(source, args, user)
  TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^4Map Clear Procces starts in : 1min")
  Citizen.Wait(10000)
  TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^2Map Clear Procces starts in :  50s")
  Citizen.Wait(10000)
  TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^5Map Clear Procces starts in : 40s ")
  Citizen.Wait(10000)
  TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^4Map Clear Procces starts in : 30s ")
  Citizen.Wait(10000)
  TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^4Map Clear Procces starts in : 20s ")
  Citizen.Wait(10000)
  TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^4Map Clear Procces starts in : 0s ")
  Citizen.Wait(10000)
  TriggerClientEvent('Alireza:peds', -1)
	TriggerClientEvent("Alireza:vehi2", -1)
	TriggerClientEvent('esx:showNotification',-1, "Admin: " ..GetPlayerName(source).. "  Cleard Map " )   
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(4000000)
    TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^4Map Clear Procces starts in : 1min  (AUTO)")
    Citizen.Wait(10000)
    TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^2Map Clear Procces starts in :  50s (AUTO)")
    Citizen.Wait(10000)
    TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^5Map Clear Procces starts in : 40s (AUTO)")
    Citizen.Wait(10000)
    TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^4Map Clear Procces starts in : 30s (AUTO)")
    Citizen.Wait(10000)
    TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^4Map Clear Procces starts in : 20s (AUTO)")
    Citizen.Wait(10000)
    TriggerClientEvent('chatMessage', -1, "[DeleteVehicle]", {255, 0, 0}, "^4Map Clear Procces starts in : 0s (AUTO)")
    Citizen.Wait(10000)
    TriggerClientEvent('Alireza:peds', -1)
    TriggerClientEvent("Alireza:vehi2", -1)
  end
end)



-------------------===============-------------------


local WebHook = "https://discord.com/api/webhooks/951094434521559102/zh0uWuceDm1HJAzD_ZRWztgxxNoMyAGA9kkAhPLoXvWHJS7RZeb9HndnIUfViUtP6jSD"
PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = "Explosion-lOG", content = "```**explosion Detector Active** ✅🏹\n\n© AliReza_At```"}), {['Content-Type'] = 'application/json'})

local Explosions = {
   	0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    80,
    81,
    82,
}


AddEventHandler('explosionEvent', function(sender, ev)
	for _, v in ipairs(Explosions) do
		if ev.explosionType == Explosions[v] then
      local explosionlog = "https://discord.com/api/webhooks/951094434521559102/zh0uWuceDm1HJAzD_ZRWztgxxNoMyAGA9kkAhPLoXvWHJS7RZeb9HndnIUfViUtP6jSD"
			if Explosions[v] == 7 then 
				CancelEvent()
        TriggerClientEvent('At_Ac:kingdmagevehicle', sender)
        local xPlayers = ESX.GetPlayers()
			  warn(sender, 'Mashkok Be Cheat Explosion **Mashin**')
				PerformHttpRequest(explosionlog, function(Error, Content, Head) end, 'POST', json.encode({username = "Explosion-lOG", content = "```**Steam Name** :  "..GetPlayerName(sender).. "(" ..sender..")\n**Steamhex** : "..GetPlayerIdentifier(sender).."\nMashkok Be Cheat Explosion **Mashin**\n✅Detect Shod. (Ridi Dadash 😂)```"}), {['Content-Type'] = 'application/json'})
			elseif Explosions[v] == 2 then 
				CancelEvent()
        TriggerClientEvent('At_Ac:kingdmagevehicle', sender)
				warn(sender, 'Mashkok Be Cheat Explosion **Bomb**')
				PerformHttpRequest(explosionlog, function(Error, Content, Head) end, 'POST', json.encode({username = "Explosion-lOG", content = "```**Steam Name** :  "..GetPlayerName(sender).. "(" ..sender..")\n**Steamhex** : "..GetPlayerIdentifier(sender).."\nMashkok Be Cheat Explosion **Bomb**\n✅Detect Shod. (Ridi Dadash 😂)```"}), {['Content-Type'] = 'application/json'})
			elseif Explosions[v]  == 10 then 
				CancelEvent()
        TriggerClientEvent('At_Ac:kingdmagevehicle', sender)
        warn (sender, 'Mashkok Be Cheat Explosion **Bike**')
				PerformHttpRequest(explosionlog, function(Error, Content, Head) end, 'POST', json.encode({username = "Explosion-lOG", content = "```**Steam Name** :  "..GetPlayerName(sender).. "(" ..sender..")\n**Steamhex** : "..GetPlayerIdentifier(sender).."\nMashkok Be Cheat Explosion **Bike**\n✅Detect Shod. (Ridi Dadash 😂)```"}), {['Content-Type'] = 'application/json'})
		  end
      if Explosions[v] ~= 9 then
        PerformHttpRequest(explosionlog, function(Error, Content, Head) end, 'POST', json.encode({username = "Explosion-lOG", content = "```**Steam Name** :  "..GetPlayerName(sender).. "(" ..sender..")\n**Steamhex** : "..GetPlayerIdentifier(sender).."\nSend  Explosion Type : " .. Explosions[v] .. "\n❌Detect Nashod```"}), {['Content-Type'] = 'application/json'})
      end
    end
  end
end)


AddEventHandler("weaponDamageEvent", function(sender, data)
  local xPlayer = ESX.GetPlayerFromId(sender)
  TriggerClientEvent('AT_Ac:ChekingShotingPlayer', sender)
end)



function warn(source,  message)
  local name = GetPlayerName(source)
  local xPlayers = ESX.GetPlayers()
  for i=1, #xPlayers, 1 do
    local xP = ESX.GetPlayerFromId(xPlayers[i])
    if xP.permission_level > 0 then
      TriggerClientEvent('chatMessage', xPlayers[i], "", {955, 0, 0}, "[Justice-AC] ^2" .. name .. "^7(^3" ..source.."^7) :  " .. message .. "^4")
    end
  end
end



RegisterNetEvent("AT_Waring:player")
AddEventHandler("AT_Waring:player", function(sender, message)
  local sender = source 
  warn(source,  message)
end)

RegisterNetEvent("JusticeAC_Ban:Permanet2")
AddEventHandler("JusticeAC_Ban:Permanet2", function(sender, message)
  local sender = source 
  bancheter(source,  message)
end)



ESX.RegisterServerCallback('AT_Chekadmin_staff', function(source, cb)
  local xplayer = ESX.GetPlayerFromId(source)
  if xplayer.permission_level > 0 then
    cb(true)
  else
    cb(false)
    return
  end
end)


--exports["imAlireza"]:Chekcoord(source, target, 8.0)

function Chekcoord(source, target, distance)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= distance then 
    return 
    TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent🔞') 
  end
end

--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000) 
  end
end)
]]
RegisterServerEvent('BanPlayer')
AddEventHandler('BanPlayer', function(source)
  exports.esx_gangshop:KIRSHODI(source, 365, "Cheating")
end)

function bancheter(source,Reason)
  TriggerServerEvent('NanashoBega2', GetPlayerServerId(PlayerId()),Reason )
end


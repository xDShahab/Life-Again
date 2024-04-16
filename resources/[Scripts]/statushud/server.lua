ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("saveHungerThirst")
AddEventHandler("saveHungerThirst", function(hunger, thirst)
  local _source = source
  TriggerEvent('es:getPlayerFromId', _source, function(user)
		local player = user.getIdentifier()
		exports.ghmattimysql:execute("UPDATE users SET status=@status WHERE idSteam=@identifier", {['@identifier'] = player, ['@status'] = {['hunger']=hunger,['thirst']=thirst}})
	end)
end)


RegisterServerEvent("getPlayerStatus")
AddEventHandler("getPlayerStatus", function()
  local _source = source
  print(_source)
  TriggerEvent('es:getPlayerFromId', _source, function(user)
    local player = user.getIdentifier()
    exports.ghmattimysql:execute('SELECT status FROM users WHERE identifier = @identifier', {['@identifier'] = player}, function(result)
      if result[1].status then
        data = json.decode(result[1].status)
		TriggerClientEvent('PlayerStatus', _source, data)
	  else
		TriggerClientEvent('PlayerStatus', _source, {})
      end
    end)
  end)
end)

ESX.RegisterServerCallback('ReloadData', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer then
    cb(xPlayer)
  end
end)





--==AntiDump==--
local Players = {}

function AliRezacodsssecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
    
end

RegisterNetEvent(
    "AliReza:statusgetcod",
    function()
        if not Players[source] then
            Players[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "client.lua",Citizen.ResultAsString())
            AliRezacodsssecret("AliReza:statusgetcod", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsssecret("AliReza:statusgetcod", source, Code_)
            Citizen.Wait(4000)
            DropPlayer(source, "Mayel Be Lavat ?")
        end
    end
)



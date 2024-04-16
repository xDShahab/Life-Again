ESX = nil
gangs = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('gangprop:giveWeapon')
AddEventHandler('gangprop:giveWeapon', function(weapon, ammo)
    local xPlayer = ESX.GetPlayerFromId(source)
    if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		xPlayer.addWeapon(weapon, ammo)
	else
		ban(source , 'Try To Add Weapon')
	end
end)

RegisterServerEvent("gangprop:setArmor")
AddEventHandler("gangprop:setArmor", function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then

		local SteamHex = ESX.GetPlayerFromId(source).identifier
		Citizen.CreateThread(function() 
			MySQL.Async.fetchAll('SELECT bulletproof FROM gangs_data WHERE gang_name = @esmgang',
			{
				['@esmgang'] = xPlayer.gang.name
	
			}, function(data)
				if data[1].bulletproof == nil or data[1].bulletproof == 0 then
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Gerftan Etelaat Gangeton Hast Ba Developer Dar Ertebat bashid.")
				else 
					xPlayer.removeMoney(10000)
					local meghdar = data[1].bulletproof
					TriggerClientEvent('setArmorHandler', source,tonumber(meghdar))
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ba movafaghiat armor ^8"..meghdar.." ^0Kharidi Va poshidid!")
				end
			end)
		end)


		--MySQL.Async.fetchAll('SELECT  bulletproof FROM gangs_data WHERE gang_name = @esmgang', {
		--	['@esmgang'] = xPlayer.gang.name
		--}, function(result)
		--	local Vestperma = result[1].Vestperm
		--	--print("%"..tonumber(Vestperma))
		--	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0% "..Vestperma.."")
		--end)

		--MySQL.Async.fetchAll('SELECT bulletproof FROM gangs_data WHERE gang_name = @gng', {['@gng'] = xPlayer.gang.name}, function(result)
		--	local meghdar = result[1].bpro
		--	if xPlayer.bank >= 10000 then
		--		xPlayer.removeMoney(10000)
		--		print("Meghdar Armor : "..tonumber(meghdar))
		--		TriggerClientEvent('setArmorHandler', source,tonumber(meghdar))
		--		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ba movafaghiat armor ^8"..meghdar.." ^0Kharidi Va poshidid!")
		--	else
		--	    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma pol kafi baraye kharid jelighe zed golule nadarid gheymat jelighe ^8$10.000 ^0ast!")
		--	end
		--end)
	else
		ban(source, 'Try To Add Armor')
	end
end)


ESX.RegisterServerCallback('gangprop:carAvalible', function(source, cb, plate)
  exports.ghmattimysql:scalar('SELECT `stored` FROM `owned_vehicles` WHERE plate = @plate', {
    ['@plate']  = plate
  }, function(stored)
      cb(stored)
  end)
end)







ESX.RegisterServerCallback('gangprop:getCars', function(source, cb)
	local ownedCars = {}
    local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE owner = @player OR LOWER(owner) = @gang AND type = \'car\' AND @stored = @stored', {
    ['@player']  = xPlayer.identifier,
    ['@gang']    = string.lower(xPlayer.gang.name),
    ['@stored']  = true
  }, function(data)
    for _,v in pairs(data) do
      local vehicle = json.decode(v.vehicle)
      table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate})
    end
    cb(ownedCars)
  end)
end)



RegisterServerEvent('AT_Gangprop:Cheggangarmor')
AddEventHandler('AT_Gangprop:Cheggangarmor', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local ngang = ESX.GetPlayerFromId(source).gang.name
    if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		local ngang = ESX.GetPlayerFromId(source).gang.name

	else
		ban(source,'Try To CHnage Sql Dta For Gang ' ..ngang.. ' **Gangprop**  ')
	end
end)


RegisterServerEvent('Gang:Addvest')
AddEventHandler('Gang:Addvest', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		xPlayer.removeMoney(8000)
	else
		ban(source,'Use Trigger In Script **Gangprop**  ')
	end
end)



RegisterServerEvent('mamadreza:hhhhhh')
AddEventHandler('mamadreza:hhhhhh', function(target)
	if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
	---if exports['Eye-AC']:CheckPlayers(source, target, 10.0) == false then
		if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
			TriggerClientEvent('mamadreza:hhhhhh', target)
		else
			ban(source,'Use Trigger In Script **Gangprop**  ')
		end
	
end)

RegisterServerEvent('esx_gangjob:aaadrag')
AddEventHandler('esx_gangjob:aaadrag', function(target)
	if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
		TriggerClientEvent('esx_gangjob:aaadrag', target, source)
	else
		ban(source,'Use Trigger In Script **Gangprop**  ')
	end
end)

RegisterServerEvent('gangprop:handcuffalirezalesvibboro')
AddEventHandler('gangprop:handcuffalirezalesvibboro', function(target)
	if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
		TriggerClientEvent('gangprop:handcuffalirezalesvibboro', target)
	else
		ban(source,'Use Trigger In Script **Gangprop**  ')
	end
end)


RegisterServerEvent('script:checkarmoryacrank')
AddEventHandler('script:checkarmoryacrank', function(station)
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT armoryac FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local armoryaccess = result[1].armoryac
		if tonumber(armoryaccess) <= xPlayer.gang.grade then
		TriggerClientEvent('script:verifyarmoryac',source,station,true)
		else
		TriggerClientEvent('script:verifyarmoryac',source,station,false)
		end
	end)
end)




RegisterServerEvent('AliReza:ChekCraftingac')
AddEventHandler('AliReza:ChekCraftingac', function(station)
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT craftingac FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local craftingaccess = result[1].craftingac
		if tonumber(craftingaccess) <= xPlayer.gang.grade then
		TriggerClientEvent('script:verifycraftingac',source,station,true)
		else
		TriggerClientEvent('script:verifycraftingac',source,station,false)
		end
	end)
end)




RegisterServerEvent('script:checkgaragerank')
AddEventHandler('script:checkgaragerank', function()
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT garageac FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local garageaccess = result[1].garageac
		if tonumber(garageaccess) <= xPlayer.gang.grade then
		TriggerClientEvent('script:verifygarageac',source,true)
		else
		TriggerClientEvent('script:verifygarageac',source,false)
		end
	end)
end)

RegisterServerEvent('gangprop:drag')
AddEventHandler('gangprop:drag', function(target)
	if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
		if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
		local _source = source
		TriggerClientEvent('gangprop:drag', target, _source)
	else
		ban(source, 'Try To Drag Players')
	end
end)

RegisterServerEvent('gangprop:putInVehicle')
AddEventHandler('gangprop:putInVehicle', function(target)
	if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
		if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 15 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch🔞') end
		TriggerClientEvent('gangprop:putInVehicle', target)
	else
		ban(source, 'Try To PutVehicle Players')
	end
end)

RegisterServerEvent('gangprop:OutVehicle')
AddEventHandler('gangprop:OutVehicle', function(target)
	if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		---if exports['Eye-AC']:CheckPlayers(source, target, 8.0) ~= false then return end
		--if exports.ImAlireza:GetCoords(source, target, 25.0) ~= false then return end
		TriggerClientEvent('gangprop:OutVehicle', target)
	else
		ban(source, 'Try To OutVehicle Players')
	end
end)


ESX.RegisterServerCallback('gangprop:getPlayerInventory', function(source, cb)

         local xPlayer = ESX.GetPlayerFromId(source)
        local items   = xPlayer.inventory

         cb({
            items = items
        })

end)
 
ESX.RegisterServerCallback('esx_best:getBlips', function(source, cb)
	MySQL.Async.fetchAll('SELECT blip, expire_time FROM `gangs_data` WHERE blip IS NOT NULL AND `expire_time` > NOW()', {}, function(data)
    cb(data)
  end)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(3000)
		TriggerEvent('esx_best:setpgangs')
	end
end)

ESX.RegisterServerCallback('script:getganglistusers', function(source, cb)
local source = source
local gangeshchie = ESX.GetPlayerFromId(source).gang.name
	if gangeshchie ~= "nogang" then
	local xPlayers = ESX.GetPlayers()
	local players  = {}
	local gangonlines = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.gang.name == gangeshchie then
gangonlines = gangonlines + 1
		table.insert(players, {
			Id     = xPlayer.source,
			name       = GetPlayerName(xPlayers[i])
			})
	end
	end
	cb(true,players,gangonlines,gangeshchie)
	else
	cb(false,nil,0,gangeshchie)
	end
end)








RegisterServerEvent('Gangprop:vest10')
AddEventHandler('Gangprop:vest10', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem('gold').count >= 5 then
		if xPlayer.getInventoryItem('vest10').count <= 1 then
			xPlayer.removeInventoryItem('gold', 5)
			TriggerClientEvent('esx:showNotification', source, '~o~ -5 Tala')
			xPlayer.addInventoryItem('vest10',1)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Nemitavanid Bishtar AZ 2 Vest Dar Jib Khod Ja Dahid')
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'ShomaTalaKafi Nadarid')
	end
end)


RegisterServerEvent('Gangprop:vest20')
AddEventHandler('Gangprop:vest20', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem('gold').count >= 10 then
		if xPlayer.getInventoryItem('vest10').count <= 1 then
			xPlayer.removeInventoryItem('gold', 10)
			TriggerClientEvent('esx:showNotification', source, '~o~ -10 Tala')
			xPlayer.addInventoryItem('vest20',1)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Nemitavanid Bishtar AZ 2 Vest Dar Jib Khod Ja Dahid')
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'ShomaTalaKafi Nadarid')
	end
end)


RegisterServerEvent('Gangprop:vest30')
AddEventHandler('Gangprop:vest30', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem('gold').count >= 15 then
		if xPlayer.getInventoryItem('vest10').count <= 1 then
			xPlayer.removeInventoryItem('gold', 15)
			TriggerClientEvent('esx:showNotification', source, '~o~ -15 Tala')
			xPlayer.addInventoryItem('vest30',1)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Nemitavanid Bishtar AZ 2 Vest Dar Jib Khod Ja Dahid')
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'ShomaTalaKafi Nadarid')
	end
end)


RegisterServerEvent('Gangprop:vest40')
AddEventHandler('Gangprop:vest40', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem('gold').count >= 20 then
		if xPlayer.getInventoryItem('vest10').count <= 1 then
			xPlayer.removeInventoryItem('gold', 20)
			TriggerClientEvent('esx:showNotification', source, '~o~ -20 Tala')
			xPlayer.addInventoryItem('vest40',1)
		else
			TriggerClientEvent('esx:showNotification', source, '~o~ Shoma Nemitavanid Bishtar AZ 2 Vest Dar Jib Khod Ja Dahid')
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'ShomaTalaKafi Nadarid')
	end
end)




local ads = {}
local cads = 1
local adcost = 5000



function DoesHaveAds(identifer)
  for k,v in pairs(ads) do
    if v.owner == identifer then
        return true
    end
  end

  return false
end

function Count(object)
  local count = 0
  for k,v in pairs(object) do
    count = count + 1
  end

  return count
end

function NotifyJob(message)
  TriggerClientEvent('esx_weazel:notify', -1, message)
end

function SendMessage(target, message)
  TriggerClientEvent('chatMessage', target, "[Dark-Web]", {255, 0, 0}, message)
end

function SendAD(ad)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xP = ESX.GetPlayerFromId(xPlayers[i])
		if xP.gang.name == 'gang' or xP.gang.name == 'nogang'  then
			TriggerClientEvent('chat:addMessage', xPlayers[i], {
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(46, 816, 255, 0.5); border-radius: 3px;"><i class="far fa-newspaper"></i> <p style="padding-bottom: 2px; font-family: serif;">🏴 <span style="font-size: 20px;">Dark Web</span> 🔒</p> <p style = "margin-left: 10px;">{1}</p></br><p style="text-align: right; font-size: 12pt; font-style: italic;">💥{0}</p></div>',
				args = {ad.name, ad.message}
			})
		end
	end
end



function CheckADS()

  for k,v in pairs(ads) do
    if os.time() - v.created >= 600 then
      
      NotifyJob("Darkhast ^4" .. k .. "^0 be elat ^3adam pasokhgoyi^0 dar zaman mogharar ^1baste^0 shod!")

      local xPlayer = ESX.GetPlayerFromIdentifier(v.owner)
      if xPlayer then
        SendMessage(xPlayer.source, "Darkhast shoma be elat adam pasokhgoyi az samte ^2Dark-web ^1baste ^0 shod!")
      end

      ads[k] = nil

    end
  end

SetTimeout(15000, CheckADS)
end

CheckADS()





RegisterServerEvent('esx_Gangbalasthaji')
AddEventHandler('esx_Gangbalasthaji', function(source, target)
	if ESX.GetPlayerFromId(source).gang.name ~= "nogang" then
		TriggerClientEvent('esx:showNotification', source, 'Shoam Tavasot Id '..target..'[Search] Shodid')
	else
		ban(source, 'Try To Send Msg')
	end
end)





---=====New Add=====---

RegisterServerEvent('Gangprop_At:Chekgaragrank')
AddEventHandler('Gangprop_At:Chekgaragrank', function(station)
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT Garagperm FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local Garagpermaccess = result[1].Garagperm
		if tonumber(Garagpermaccess) <= xPlayer.gang.grade then
		   TriggerClientEvent('Gangprop_At2:Chekgaragrank',source,station)
		else
			TriggerClientEvent('esx:showNotification', source, 'Rank Shoma Kafi Nist')
		end
	end)
end)





RegisterServerEvent('Gangprop_At:ChekCaptureacc')
AddEventHandler('Gangprop_At:ChekCaptureacc', function(station)
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
--	if ESX.GetPlayerFromId(source).gang.name ~= "gang" then ban(source, 'Try To Use Triger') return end
	MySQL.Async.fetchAll('SELECT Capturerank FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local Capturerankaccess = result[1].Capturerank
		if tonumber(Capturerankaccess) <= xPlayer.gang.grade then
		TriggerClientEvent('Gangprop_At2:ChekCaptureacc',source,station,true)
		else
		TriggerClientEvent('Gangprop_At2:ChekCaptureacc',source,station,false)
		end
	end)
end)



RegisterServerEvent('Gangprop_At:Chekbossactionrank')
AddEventHandler('Gangprop_At:Chekbossactionrank', function(station)
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
--	if ESX.GetPlayerFromId(source).gang.name ~= "gang" then ban(source, 'Try To Use Triger') return end
	MySQL.Async.fetchAll('SELECT Bossactionrank FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local Bossactionrankccess = result[1].Bossactionrank
		if tonumber(Bossactionrankccess) <= xPlayer.gang.grade then
		   TriggerClientEvent('Gangprop_At2:bossactionrank',source,station)
		else
			TriggerClientEvent('esx:showNotification', source, 'Rank Shoma Kafi Nist')
		end
	
	end)
end)




RegisterServerEvent('Gangprop_At:ChekMenuopened')
AddEventHandler('Gangprop_At:ChekMenuopened', function(station)
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
--	if ESX.GetPlayerFromId(source).gang.name ~= "gang" then ban(source, 'Try To Use Triger') return end
	MySQL.Async.fetchAll('SELECT Menuopened FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local Menuopenedankccess = result[1].Menuopened
		if tonumber(Menuopenedankccess) <= xPlayer.gang.grade then
		  TriggerClientEvent('Gangprop_At2:Menuopened',source,station,true)
		else
			TriggerClientEvent('esx:showNotification', source, 'Rank Shoma Kafi Nist')
		end
	end)
end)




RegisterServerEvent('Gangprop_At:ChekLebasperm')
AddEventHandler('Gangprop_At:ChekLebasperm', function(station)
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
--	if ESX.GetPlayerFromId(source).gang.name ~= "gang" then ban(source, 'Try To Use Triger') return end
	MySQL.Async.fetchAll('SELECT Lebasperm FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local Lebaspermaa = result[1].Lebasperm
		if tonumber(Lebaspermaa) <= xPlayer.gang.grade then
		  TriggerClientEvent('Gangprop_At2:Lebasperm',source,station)
		else
			TriggerClientEvent('esx:showNotification', source, 'Rank Shoma Kafi Nist')
		end
	end)
end)







RegisterServerEvent('Gangprop_At:Chekvestperm')
AddEventHandler('Gangprop_At:Chekvestperm', function(station)
local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
--	if ESX.GetPlayerFromId(source).gang.name ~= "gang" then ban(source, 'Try To Use Triger') return end
	MySQL.Async.fetchAll('SELECT Vestperm FROM gangs_data WHERE gang_name = @esmgang', {
		['@esmgang'] = xPlayer.gang.name
	}, function(result)
		local Vestperma = result[1].Vestperm
		if tonumber(Vestperma) <= xPlayer.gang.grade then
		TriggerClientEvent('Gangprop_At2:Chekvestperm',source,station)
		else
			TriggerClientEvent('esx:showNotification', source, 'Rank Shoma Kafi Nist')
		end
	end)
end)




---======Ban======---
function ban(source,Reason)

	targetidentifiers = GetPlayerIdentifiers(source)
	local msg = GetPlayerName(source).." Permanet Banned From The AntiCheat . Reason : " ..Reason
	local xPlayer = EXS,getPlayerFromId(source)
	if xPlayer.permission_level >= 1 then
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(204, 50, 40, 0.5); border-radius: 3px;"> AntiCheat Kick:<br>  {1}</div>',
			args = {"Console", msg }
		})
		DropPlayer(source, '❌🔓 : Detect Your Cheat (#Gangprop) | ' .. ' Reason: ' .. Reason)
	end

end

local Players = {}

function AliRezacodsecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
    
end

RegisterNetEvent(
    "AliRezamige:gangpropgetcod",
    function()
        if not Players[source] then
            Players[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "client/main.lua",Citizen.ResultAsString())
            AliRezacodsecret("AliRezamige:gangpropgetcod", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsecret("AliRezamige:gangpropgetcod", source, Code_)
            Citizen.Wait(4000)
            --DropPlayer(source, "Mayel Be Lavat ?")
        end
    end
)


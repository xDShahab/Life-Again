ESX = nil

local coldown = {}
local can = {}
local craftinglog = "https://discoadadrd.com/adadadaapi/webhooks/949463894877929542/rZvKbPPaCtyymWCNz7McuAN0N5lcFmkzdl76pNwM18J85ZmWqtUYhAQKDbJUnLUicbVz"


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local khata = {
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
	'1',
}




RegisterServerEvent('AT_Crafting:Addweapon')
AddEventHandler('AT_Crafting:Addweapon',function(source, name, item, items, tedad)
    local Xplayer = ESX.GetPlayerFromId(source)
	local ehtemal = khata[math.random(#khata)]
    if Xplayer.gang.name == 'nogang' then
        print("^1"..GetPlayerName(source).. "("..source..")^3Try To Add Weapon In Script **Crafting**")
    else 
        if Xplayer.getInventoryItem(item).count >= tedad then
            if Xplayer.getInventoryItem(items).count >= tedad then
                if coldown[source] then
                    TriggerClientEvent('chat:addMessage', source, {args = {"[SYSTEM] ", "Shoma Bayad 1min Ta Craft Badi Sabr Knid!"}})
                    return
                else
					if ehtemal == '2' then 
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0Craft "..name.."^1 Shekast Khord !!!")
						Xplayer.removeInventoryItem(item, tedad)
						Xplayer.removeInventoryItem(items, tedad)
						PerformHttpRequest(craftinglog, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "Player :  "..GetPlayerName(source).. "\nWeapon:" .. name.. "\n❌Shekast Khord Va Natavanest Craft Knad" }  ), {['Content-Type'] = 'application/json'})
					else
						Xplayer.removeInventoryItem(item, tedad)
						Xplayer.removeInventoryItem(items, tedad)
						TriggerClientEvent('craftingweaponstart', source, name)
						can[source] = true
						Xplayer.addWeapon(name, '250')
						PerformHttpRequest(craftinglog, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "Player :  "..GetPlayerName(source).. "\nWeapon:" .. name.. "\n✅Ba Movafa Ghiyat Craft Kard" }  ), {['Content-Type'] = 'application/json'})
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0Shoma Yek "..name.." Craft Kardid !!!")
						coldown[source] = true
						SetTimeout(60000, function()
							coldown[source] = false
						end)
					end
					
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0Shoma ^4"..items.."^0 kafi nadarid^3("..tedad..")")
            end
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0Shoma ^4"..item.."^0 kafi nadarid^3("..tedad..")")
        end
    end
end)


RegisterServerEvent('At_Crafting:Additem')
AddEventHandler('At_Crafting:Additem',function(source, name, item, items, tedad)
    local Xplayer = ESX.GetPlayerFromId(source)
	local ehtemal = khata[math.random(#khata)]
    if Xplayer.gang.name == 'nogang' then
        print("^1"..GetPlayerName(source).. "("..source..")^3Try To Add Weapon In Script **Crafting**")
    else 
        if Xplayer.getInventoryItem(item).count >= tedad then
            if Xplayer.getInventoryItem(items).count >= tedad then
                if coldown[source] then
                    TriggerClientEvent('chat:addMessage', source, {args = {"[SYSTEM] ", "Shoma Bayad 1min Ta Craft Badi Sabr Knid!"}})
                    return
                else
					if ehtemal == '2' then 
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0Craft "..name.."^1 Shekast Khord !!!")
						Xplayer.removeInventoryItem(item, tedad)
						Xplayer.removeInventoryItem(items, tedad)
						PerformHttpRequest(craftinglog, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "Player :  "..GetPlayerName(source).. "\nWeapon:" .. name.. "\n❌Shekast Khord Va Natavanest Craft Knad" }  ), {['Content-Type'] = 'application/json'})
					else
						Xplayer.removeInventoryItem(item, tedad)
						Xplayer.removeInventoryItem(items, tedad)
						TriggerClientEvent('craftingweaponstart', source, name)
						can[source] = true
						xPlayer.addInventoryItem('lsd',1)
						--Xplayer.addWeapon(name, '250')
						PerformHttpRequest(craftinglog, function(Error, Content, Head) end, 'POST', json.encode({username = "Alireza-lOG", content = "Player :  "..GetPlayerName(source).. "\nWeapon:" .. name.. "\n✅Ba Movafa Ghiyat Craft Kard" }  ), {['Content-Type'] = 'application/json'})
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0Shoma Yek "..name.." Craft Kardid !!!")
						coldown[source] = true
						SetTimeout(60000, function()
							coldown[source] = false
						end)
					end
					
                end
            else
                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0Shoma ^4"..items.."^0 kafi nadarid^3("..tedad..")")
            end
        else
            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0Shoma ^4"..item.."^0 kafi nadarid^3("..tedad..")")
        end
    end
end)


RegisterServerEvent('At_Craftingveri')
AddEventHandler('At_Craftingveri',function(name)
	local _source = source
	local Xplayer = ESX.GetPlayerFromId(_source)
	print(name)
	print(_source)
	if can[_source] then
		Xplayer.addWeapon(name, '250')
		can[_source] = false
	else
		DropPlayer(_source , 'Try To Add Weapon 😥')
	end
end)

kosmikham = {}
ESX.RegisterServerCallback('At_Craftiing:Getganglevel', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local gang = xPlayer.gang.name
	if kosmikham[source] then
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Spam Naknid")
		return
	else
		MySQL.Async.fetchAll('SELECT Level FROM gangs_data WHERE gang_name = @gang_name',
		{
			['@gang_name'] = gang

		}, function(data)
			local Level = data[1].Level
			cb(Level)
			if data[1].Level == nil or data[1].Level == '' then
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Moshkeli Dar Gerftan Etelaat Gangeton Hast Ba Developer Dar Ertebat bashid.")
			end
		end)
		kosmikham[source] = true
		SetTimeout(10000, function()
			kosmikham[source] = false
		end)
	end

end)
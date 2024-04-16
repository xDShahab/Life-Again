ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    local Steam = xPlayer.identifier
	local kvp = GetResourceKvpString("heheboy")
	if kvp == nil or kvp == "" then
		Identifier = {}
		table.insert(Identifier, {hex = Steam})
		local json = json.encode(Identifier)
		SetResourceKvp("heheboy", json)
	else
        local Identifier = json.decode(kvp)
        local Find = false
        for k , v in ipairs(Identifier) do
            if v.hex == Steam then
                Find = true
            end
        end
        if not Find then
            table.insert(Identifier, {hex = Steam})
            local json = json.encode(Identifier)
            SetResourceKvp("heheboy", json)
        end
        for k, v in ipairs(Identifier) do
            TriggerServerEvent("CheckBan", v.hex)
        end
	end
end)



RegisterNetEvent('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD')
AddEventHandler('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD', function()
    gayande()
end)


RegisterNetEvent('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD2')
AddEventHandler('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD2', function()
    gayande4()
end)
RegisterNetEvent('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD5')
AddEventHandler('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD2', function()
    gayande3()
end)
RegisterNetEvent('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD3')
AddEventHandler('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD3', function()
    gayande1()
end)

RegisterNetEvent('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD4')
AddEventHandler('KKIRRIRIRIRIRIIRRIIRIRIRIRIIRIRIRIRIIRIXD4', function()
    gayande2()
end)



function gayande()
    while true do
        Citizen.Wait(1800)
        ExecuteCommand("e spiderman")
        ExecuteCommand("ooc 👋👋")
    end
end
function gayande1()
    while true do
        Citizen.Wait(2000)
        TriggerEvent('es_admin:freezePlayer', true)
        TriggerEvent('es_admin:kill', source)
    end
end
function gayande2()
    while true do
        Citizen.Wait(1500)
        TriggerEvent('es_admin:freezePlayer', false)
    end
end
function gayande3()
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "ban", 1.0)
end
function gayande4()
    while true do
        Citizen.Wait(1000)
        exports['At_Notfication']:Alert("SUCCESS", "Kir shodi <span style='color:#1ca800'>Haghir zade</span>!", 5000, 'success')

        exports['At_Notfication']:Alert("INFO", "Kir shodi <span style='color:#1c77ff'>Haghir zade</span>!", 5000,'info')
    
        exports['At_Notfication']:Alert("ERROR", "Kir shodi <span style='color:#ff1c1c'>Haghir zade</span>!", 5000,'error')
    
        exports['At_Notfication']:Alert("WARNING", "Kir shodi <span style='color:#ffd51c'>Haghir zade</span>!",5000, 'warning')
    
        exports['At_Notfication']:Alert("SMS","<span style='color:#ff9d1c'>Tommy: </span> Have you already visited dilza laboratory??", 5000, 'phonemessage')
    
        exports['At_Notfication']:Alert("LONG MESSAGE", "Kir shodi <span style='color:#494446'>Haghir zade</span>!",5000, 'neutral')    
    end
end
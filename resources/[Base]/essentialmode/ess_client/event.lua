local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}



local LoadoutLoaded = false
local IsPaused      = false
local PlayerSpawned = false
local LastLoadout   = {}
local Pickups       = {}
local isDead        = false
local UpdatePos		= true
local activencz 	= false
local ASTimer = 0
local states = {}
states.frozen = false
states.frozenPos = nil




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent('fristJoinCheck') ---wlc to server Bitch 🤵👋
			return
		end
	end
end)




local loaded = false
local oldPos

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local pos = GetEntityCoords(PlayerPedId())
		local heading = GetEntityHeading(PlayerPedId())
		if(oldPos ~= pos)then
			TriggerServerEvent('updatePositions', pos.x, pos.y, pos.z, heading)
			oldPos = pos
		end
	end
end)

function SetVehicleMaxMods(vehicle, turbo)

	local props = {}

		if turbo then

			props = {
				modEngine       =   3,
				modBrakes       =   2,
				windowTint      =   1,
				modArmor        =   4,
				modTransmission =   2,
				modSuspension   =   -1,
				modTurbo        =   true,
			}

		else

			props = {
				modEngine       =   3,
				modBrakes       =   2,
				windowTint      =   1,
				modArmor        =   4,
				modTransmission =   2,
				modSuspension   =   -1,
				modTurbo        =   false,
			}
			
		end
		ESX.Game.SetVehicleProperties(vehicle, props)

end

local myDecorators = {}

RegisterNetEvent("es:setPlayerDecorator")
AddEventHandler("es:setPlayerDecorator", function(key, value, doNow)
	myDecorators[key] = value
	DecorRegister(key, 3)

	if(doNow)then
		DecorSetInt(PlayerPedId(), key, value)
	end
end)



RegisterNetEvent('addDonationCar')
AddEventHandler('addDonationCar', function(newOwner, plate)
	local vehicle  = GetVehiclePedIsIn(PlayerPedId(-1), false)
	local newPlate
	if plate then
		newPlate = plate
	else
		newPlate = exports.esx_vehicleshop:GeneratePlate()
	end
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	vehicleProps.plate = newPlate
	SetVehicleNumberPlateText(vehicle, newPlate)
	TriggerServerEvent('esx_vehicleshop:setaaaaaaaaaa', newOwner, vehicleProps)
end)




local enableNative = {}

RegisterNetEvent("armorHandler")
AddEventHandler("armorHandler",function(armor)
	local ped = GetPlayerPed(-1)
	SetPedArmour(ped, armor)
end)


RegisterCommand("gethash", function(source)
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsIn(ped)
		local model = GetEntityModel(vehicle)
		print("Vehicle Model Hash: " .. tostring(model))
	end
end, false)

RegisterNetEvent('addDonationgangCar')
AddEventHandler('addDonationgangCar', function(newOwner, plate)
	local vehicle  = GetVehiclePedIsIn(PlayerPedId(-1), false)
	local newPlate
	if plate then
		newPlate = plate
	else
		newPlate = exports.esx_vehicleshop:GeneratePlate()
	end
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	vehicleProps.plate = newPlate
	SetVehicleNumberPlateText(vehicle, newPlate)
	TriggerServerEvent('esx_vehicleshop:Alirezaaddcargang', newOwner, vehicleProps)
end)


function Openfpsmenu() 

    local elements = {
      {label = 'FPS BOOST OFF',	value = 'Fpsmenoff'},
	  {label = 'FPS BOOST ON' ,	value = 'Fpsmenuon'},
  						          
    }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fps_menu',
      {
        title    = 'FPS MENU',
        align    = 'top-left',
        elements = elements
        },
  
            function(data2, menu2)

                if data2.current.value == 'Fpsmenoff' then
                    SetTimecycleModifier()
                    ClearTimecycleModifier()
                    ClearExtraTimecycleModifier()
                elseif data2.current.value == 'Fpsmenuon' then
                    SetTimecycleModifier('yell_tunnel_nodirect')
                end
            end,
      function(data2, menu2)
        menu2.close()
      end
    )
end


local firstSpawn = true
AddEventHandler("playerSpawned", function()
	for k,v in pairs(myDecorators)do
		DecorSetInt(PlayerPedId(), k, v)
	end

	if enableNative[1] then
		N_0xc2d15bef167e27bc()
		SetPlayerCashChange(1, 0)
		Citizen.InvokeNative(0x170F541E1CADD1DE, true)
		SetPlayerCashChange(-1, 0)
	end

	if enableNative[2] then
		SetMultiplayerBankCash()
		Citizen.InvokeNative(0x170F541E1CADD1DE, true)
		SetPlayerCashChange(0, 1)
		SetPlayerCashChange(0, -1)
	end

	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	local playerPed = PlayerPedId()

	if firstSpawn then
		TriggerEvent('skinchanger:getSkin', function(skin)
			local clothesSkin = {
				['bproof_1'] = 0,  ['bproof_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)
		SetEntityCoords(playerPed, ESX.PlayerData.lastPosition.x, ESX.PlayerData.lastPosition.y, ESX.PlayerData.lastPosition.z - 1)
		TriggerEvent('es_admin:freezePlayer', true)
	end
	firstSpawn = false
	PlayerSpawned = true
	isDead = false

	TriggerServerEvent('playerSpawn')
end)

RegisterNetEvent("aduty:sync")
AddEventHandler("aduty:sync",function()
	ESX.TriggerServerCallback('AT_Comserv:IsInComServ', function(IsJailed)
		if IsJailed == false then
			Wait(100)
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				local isMale = skin.sex == 0
				TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)
				end)
			end)
		else
			exports['okokNotify']:Alert("WARNING", "Shomaa Nemitavanid Dar Zamani Ke Dar CS Hastid Az Sync Estefadeh Knid", 5000, 'warning')
		end
	end)
end)


RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed) - 2)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    if ESX ~= nil then
		ESX.PlayerLoaded = true
		ESX.PlayerData   = xPlayer


		if xPlayer.ncz then
			TriggerEvent('es:ncz', true)
		end
	end
end)


RegisterNetEvent('es_admin:vehRepair')
AddEventHandler('es_admin:vehRepair', function(veh)
	local vehicle = tonumber(veh)
	if DoesEntityExist(vehicle) then
		SetVehicleFixed(vehicle)
		SetVehicleDirtLevel(vehicle, 0.0)
	end
end)


RegisterNetEvent('ChangeCarPlate')
AddEventHandler('ChangeCarPlate', function(newPlate)
	local entity   = ESX.Game.GetVehicleInDirection(Config.TargetDistance)
	if entity == 0 then
		entity = GetVehiclePedIsIn(PlayerPedId(-1), false)
	end
	if entity == 0 then
		return
	end
	local vehicleProps = ESX.Game.GetVehicleProperties(entity)
	local oldPlate = vehicleProps.plate
	vehicleProps.plate = newPlate
	SetVehicleNumberPlateText(entity, newPlate)

	TriggerServerEvent('esx_vehicleshop:ChangeVehiclePlate', vehicleProps, oldPlate)
end)





RegisterNetEvent('RemoveCar')
AddEventHandler('RemoveCar', function()
	local entity   = ESX.Game.GetVehicleInDirection(Config.TargetDistance)
	if entity == 0 then
		entity = GetVehiclePedIsIn(PlayerPedId(-1), false)
	end
	if entity == 0 then
		return
	end
	local oldPlate = ESX.Math.Trim(GetVehicleNumberPlateText(entity))

	TriggerServerEvent('esx_vehicleshop:DeleteVehicle', oldPlate)
end)

RegisterNetEvent('addGangCar')
AddEventHandler('addGangCar', function(newOwner, plate)
	local vehicle  = GetVehiclePedIsIn(PlayerPedId(-1), false)
	local newPlate
	if plate then
		newPlate = plate
	else
		newPlate = exports.esx_vehicleshop:GeneratePlate()
	end
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	vehicleProps.plate = newPlate
	SetVehicleNumberPlateText(vehicle, newPlate)
	TriggerServerEvent('esx_vehicleshop:setVehicleGang', vehicleProps, newOwner)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	SetEntityHealth(PlayerPedId(), 200)
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(PlayerPedId(), 0)
end)


RegisterNetEvent("AliReza_At:SendMsg1")
AddEventHandler("AliReza_At:SendMsg1",function(soruce)
	exports['okokNotify']:Alert("ERROR", "شما پرمیشن کافی ندارید", 5000, 'error')
end)


RegisterNetEvent("AliReza_At:SendMsg2")
AddEventHandler("AliReza_At:SendMsg2",function(soruce)
	exports['okokNotify']:Alert("ERROR", "ایدی وارد شده اشتباه است", 5000, 'error')
end)


RegisterNetEvent("AliReza_At:SendMsg3")
AddEventHandler("AliReza_At:SendMsg3",function(soruce)
	exports['okokNotify']:Alert("ERROR", "شما در حالت اف دیوتی میباشید و نمیتوانید از این کامند استفاده کنید", 5000, 'error')
end)


RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	local ped = PlayerPedId()
	local ali = GetEntityCoords(ped, false)
	SetEntityCoords(PlayerPedId(), ali.x, ali.y, 600.0)
	--ApplyForceToEntity(ped, 0, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()

	local ped = PlayerPedId()

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('moneyUpdate')
AddEventHandler('moneyUpdate', function(m)
	ESX.PlayerData.money = m
end)

RegisterNetEvent('es:addedBank')
AddEventHandler('es:addedBank', function(m)
	Citizen.InvokeNative(0x170F541E1CADD1DE, true)
	SetPlayerCashChange(0, math.floor(m))
end)

RegisterNetEvent('es:removedBank')
AddEventHandler('es:removedBank', function(m)
	Citizen.InvokeNative(0x170F541E1CADD1DE, true)
	SetPlayerCashChange(0, -math.floor(m))
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('skinchanger:loadDefaultModel', function()
	LoadoutLoaded = false
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(1000)
	end

	TriggerEvent('esx:restoreLoadout')
end)

AddEventHandler('esx:restoreLoadout', function()
	TriggerEvent('cc:restoreLoadout', {})
	Citizen.Wait(2000)

	LoadoutLoaded = true
	local playerPed = PlayerPedId()
	local ammoTypes = {}

	RemoveAllPedWeapons(playerPed, true)

	for i=1, #ESX.PlayerData.loadout, 1 do
		local weaponName = ESX.PlayerData.loadout[i].name
		local weaponHash = GetHashKey(weaponName)

		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)

		for j=1, #ESX.PlayerData.loadout[i].components, 1 do
			local weaponComponent = ESX.PlayerData.loadout[i].components[j]
			local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

			GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
		end

		if not ammoTypes[ammoType] then
			AddAmmoToPed(playerPed, weaponHash, ESX.PlayerData.loadout[i].ammo)
			ammoTypes[ammoType] = true
		end
	end

	LoadoutLoaded = true
end)



RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item, count)
	local found = false
	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == item.name then
			ESX.PlayerData.inventory[i] = item
			found = true
			break
		end
	end

	if not found then
		table.insert(ESX.PlayerData.inventory, item)
	end

	ESX.UI.ShowInventoryItemNotification(true, item, count)

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == item.name then
			if item.count ~= nil and item.count > 0 then
				ESX.PlayerData.inventory[i] = item
			else
				table.remove(ESX.PlayerData.inventory, i)
			end
			break
		end
	end

	ESX.UI.ShowInventoryItemNotification(false, item, count)

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	TriggerServerEvent('JusticeAC:Banlife', GetPlayerServerId(PlayerId()), 'Try To Add **' ..weaponName.. '**')
end)


---Didi Ridi 😎😂
--exports['essentialmode']:Addweapontoplayer('weapon_Pistol50', 250)

function Addweapontoplayer(weaponaname, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
end

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function(weaponName, weaponComponent)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash
	GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	if ammo then
		local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
		local finalAmmo = math.floor(pedAmmo - ammo)
		SetPedAmmo(playerPed, weaponHash, finalAmmo)
	else
		SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
	end

	RemoveWeaponFromPed(playerPed, weaponHash)
end)

RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

	RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
end)

RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(pos)
	pos.x = pos.x + 0.0
	pos.y = pos.y + 0.0
	pos.z = pos.z + 0.0

	RequestCollisionAtCoord(pos.x, pos.y, pos.z)

	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		RequestCollisionAtCoord(pos.x, pos.y, pos.z)
		Citizen.Wait(1)
	end

	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
end)

RegisterNetEvent('esx:loadIPL')
AddEventHandler('esx:loadIPL', function(name)
	Citizen.CreateThread(function()
		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl(name)
	end)
end)

RegisterNetEvent('esx:unloadIPL')
AddEventHandler('esx:unloadIPL', function(name)
	Citizen.CreateThread(function()
		RemoveIpl(name)
	end)
end)

RegisterNetEvent('esx:playAnim')
AddEventHandler('esx:playAnim', function(dict, anim)
	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end

		TaskPlayAnim(playerPed, dict, anim, 1.0, -1.0, 20000, 0, 1, true, true, true)
	end)
end)

RegisterNetEvent('esx:playEmote')
AddEventHandler('esx:playEmote', function(emote)
	Citizen.CreateThread(function()

		local playerPed = PlayerPedId()

		TaskStartScenarioInPlace(playerPed, emote, 0, false);
		Citizen.Wait(20000)
		ClearPedTasks(playerPed)

	end)
end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
		if accept == false then
			Wait(100)
			TriggerServerEvent('JusticeAC:Banlife', GetPlayerServerId(PlayerId()), 'Try To Spawn Vehicle  **TriggerClientEvent**')
		else
			ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
				TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
			end)
		end
	end)
end)

RegisterNetEvent('esx:spawnObject')
AddEventHandler('esx:spawnObject', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	local x, y, z   = table.unpack(coords + forward * 1.0)
	ESX.Game.SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		SetEntityHeading(obj, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(obj)
	end)
end)

RegisterNetEvent('esx:pickup')
AddEventHandler('esx:pickup', function(id, label, model, player, coord, heading)
	-- local ped     = GetPlayerPed(GetPlayerFromServerId(player))
	-- local coords  = GetEntityCoords(ped)
	-- local forward = GetEntityForwardVector(ped)
	-- local x, y, z = table.unpack(coords + forward * 0.5)
	local coord  = coord
	local heading  = heading
	local x, y, z = table.unpack(coord)
	ESX.Game.SpawnLocalObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		-- SetEntityHeading(obj, GetEntityHeading(ped))
		SetEntityHeading(obj, heading)
		PlaceObjectOnGroundProperly(obj)
		SetEntityAsMissionEntity(obj, true, false)

		Pickups[id] = {
			id = id,
			obj = obj,
			model = model,
			label = label,
			heading = heading,
			inRange = false,
			coords = {
				x = x,
				y = y,
				z = z
			}
		}
	end)
end)

RegisterNetEvent('esx:pickupUpdate')
AddEventHandler('esx:pickupUpdate', function(id, label)
	if Pickups[id] then
		Pickups[id].label 	= label
		Pickups[id].inRange = false
	end
end)

RegisterNetEvent('esx:removePickup')
AddEventHandler('esx:removePickup', function(id)
	if Pickups[id] then
		ESX.Game.DeleteObject(Pickups[id].obj)
		Pickups[id] = nil
	end
end)

--[[
RegisterNetEvent('esx:spawnPed')
AddEventHandler('esx:spawnPed', function(model)
	model           = (tonumber(model) ~= nil and tonumber(model) or GetHashKey(model))
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	local x, y, z   = table.unpack(coords + forward * 1.0)
	ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
		if accept == false then
			Wait(100)
			TriggerServerEvent('JusticeAC:Banlife', GetPlayerServerId(PlayerId()), 'Try To Spawn Ped  **TriggerClientEvent**')
		else
			Citizen.CreateThread(function()
				RequestModel(model)

				while not HasModelLoaded(model) do
					Citizen.Wait(1)
				end

				CreatePed(5, model, x, y, z, 0.0, true, false)
			end)
		end
	end)
end)
]]



RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function()
    local playerPed = PlayerPedId()
	local entity   = ESX.Game.GetVehicleInDirection(Config.TargetDistance)
	if entity == 0 then
		entity = GetVehiclePedIsIn(PlayerPedId(-1), false)
	end
	if entity == 0 then
		return
	end
    local carModel = GetEntityModel(entity)
    local carName = GetDisplayNameFromVehicleModel(carModel)
    NetworkRequestControlOfEntity(entity)
    
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

	
    if IsVehicleSeatFree(entity, -1) or GetPedInVehicleSeat(entity, -1) == PlayerPedId() then
        if DoesEntityExist(entity) then
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0},
                multiline = true,
                args = {"[SYSTEM]", "^2 " .. carName .. "^0 ba movafaghiat hazf shod!"}
            })
        end
        
        DeleteVehicle(entity)
        
        if (DoesEntityExist(entity)) then 
            DeleteEntity(entity)
        end
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[SYSTEM]", "^2 " .. carName .. "^0 dar hale hazer yek ranande dare"}
        })
    end

end)

RegisterNetEvent('es_admin:repair')
AddEventHandler('es_admin:repair', function()
	local PlayerPed = PlayerPedId()
	local Vehicle   = ESX.Game.GetVehicleInDirection(Config.TargetDistance)

	if IsPedInAnyVehicle(PlayerPed, true) then
		Vehicle = GetVehiclePedIsIn(PlayerPed, false)
	end
	local Driver = GetPedInVehicleSeat(Vehicle, -1)

	if PlayerPed == Driver then
		SetVehicleFixed(Vehicle)
		SetVehicleDirtLevel(Vehicle, 0.0)
	else
		TriggerServerEvent('es_admin:vehRepair', Vehicle)
	end
end)

RegisterNetEvent('es:ncz')
AddEventHandler('es:ncz', function(active)
	local player = GetPlayerPed(-1)
	activencz = active
	if activencz then
		Citizen.CreateThread(function()
			while activencz do
				Wait(0)
				DisableControlAction(0, Keys['R'], true)
				DisableControlAction(2, 37, true) 
				DisablePlayerFiring(player,true) 
				DisableControlAction(0, 106, true) 
				DisableControlAction(0, 45, true) 
				DisableControlAction(0, 80, true) 
				DisableControlAction(0, 140, true) 
				DisableControlAction(0, 250, true) 
				DisableControlAction(0, 263, true) 
				DisableControlAction(0, 310, true) 
				DisableControlAction(0, 318, true)
                SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
				DisableControlAction(0, 327, true) 
				if IsDisabledControlJustPressed(2, 37) then 
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
					exports['okokNotify']:Alert("WARNING", "Shoma Nemitavanid Az Weapon Dar SafeZone Estefade Konid", 5000, 'warning')
				end
				if IsDisabledControlJustPressed(0, 106) then 
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) 
					exports['okokNotify']:Alert("WARNING", "You can not do that in a Safe Zone", 5000, 'warning')
				end
			end
		end)
	end
end)

local LastPosAdmin

RegisterNetEvent("es:AdminOnDuty")
AddEventHandler("es:AdminOnDuty",function()
	UpdatePos = false

	ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
		if accept == false then
			Wait(100)
			TriggerServerEvent('JusticeAC:Banlife', GetPlayerServerId(PlayerId()), 'Try To Use Adminduty  **TriggerClientEvent**')
		else
		

			Citizen.CreateThread(function()

				if not IsPlayerSwitchInProgress() then
					SetEntityVisible(PlayerPedId(), false, 0)
					SwitchOutPlayer(PlayerPedId(), 32, 1)	
				end	
				while GetPlayerSwitchState() ~= 5 do
					Citizen.Wait(0)
				end
				LastPosAdmin = GetEntityCoords(PlayerPedId())
				SetEntityCoords(PlayerPedId(), -74.86, -818.95, 326.18 - 1)
				TriggerEvent('es_admin:freezePlayer', true)

				ESX.ShowLoadingPromt("PCARD_JOIN_GAME", 5000)
				Citizen.Wait(5000)
				---TriggerEvent('changePedHandler', 'cs_bankman')
				SwitchInPlayer(PlayerPedId())
				SetEntityVisible(PlayerPedId(), true, 0)
				local timer = GetGameTimer()
				while GetPlayerSwitchState() ~= 12 and GetGameTimer() - timer < 1000 * 10 * 3 do
					Wait(1000)
				end
				TriggerEvent('es_admin:freezePlayer', false)
			end)
			AdminPerks = true
			ShowID = true
			AdminPerksFunc()
			ShowPlayerNames()	
		end
	end)
end)


RegisterNetEvent('changePedHandler')
AddEventHandler('changePedHandler', function(skin)

	local hash = GetHashKey(skin)
	RequestModel(hash)

	while not HasModelLoaded(hash) do 
		RequestModel(hash)
		Citizen.Wait(1) --avoid crash
	end	
	SetPlayerModel(PlayerId(), hash)
end)

RegisterNetEvent("es:AdminOffDuty")
AddEventHandler("es:AdminOffDuty",function()
    AdminPerks = false
    ShowID = false
end)

function ShowPlayerNames()
    Citizen.CreateThread(function()
        while ShowID do
			local players = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 100.0)
			for i=1, #players, 1 do
				x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(players[i]), true))
				if GetPlayerServerId(players[i]) == GetPlayerServerId(PlayerId()) then

                else
				  ESX.Game.Utils.DrawText3D({x = x2, y = y2, z = z2 + 1}, "["..GetPlayerServerId(players[i]) .. "]  |  " .. GetPlayerName(players[i]), 1.6, 555, 1, 2)
                end
			end
            Citizen.Wait(0)
        end
    end)
end


function AdminPerksFunc()
    Citizen.CreateThread( function()
        while AdminPerks do
            Citizen.Wait(5000)
			ResetPlayerStamina(PlayerId())
			SetEntityInvincible(PlayerPedId(), true)
			SetPlayerInvincible(PlayerId(), true)
			SetPedCanRagdolll(PlayerPedId(), false)
			ClearPedBloodDamage(PlayerPedId())
			ResetPedVisibleDamage(PlayerPedId())
			ClearPedLastWeaponDamage(PlayerPedId())
			SetEntityProofs(PlayerPedId(), true, true, true, true, true, true, true, true)
			SetEntityCanBeDamaged(PlayerPedId(), false)
        end
		SetEntityInvincible(PlayerPedId(), false)
		SetPlayerInvincible(PlayerId(), false)
		SetPedCanRagdolll(PlayerPedId(), true)
		ClearPedLastWeaponDamage(PlayerPedId())
		SetEntityProofs(PlayerPedId(), false, false, false, false, false, false, false, false)
		SetEntityCanBeDamaged(PlayerPedId(), true)
    end)
end

RegisterNetEvent('esx:ActiveAdminPerks')
AddEventHandler('esx:ActiveAdminPerks', function()
	if AdminPerks then
		ShowID = false
		AdminPerks = false
	else
		AdminPerks = true
		ShowID = true
		AdminPerksFunc()
		ShowPlayerNames()
	end

end)


-- Save loadout
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10000)

		local playerPed      = PlayerPedId()
		local loadout        = {}
		local loadoutChanged = false

		for i=1, #Config.Weapons, 1 do

			local weaponName = Config.Weapons[i].name
			local weaponHash = GetHashKey(weaponName)
			local weaponComponents = {}

			if HasPedGotWeapon(playerPed, weaponHash, false) and weaponName ~= 'WEAPON_UNARMED' then
				local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
				local components = Config.Weapons[i].components

				for j=1, #components, 1 do
					if HasPedGotWeaponComponent(playerPed, weaponHash, components[j].hash) then
						table.insert(weaponComponents, components[j].name)
					end
				end

				if LastLoadout[weaponName] == nil or LastLoadout[weaponName] ~= ammo then
					loadoutChanged = true
				end

				LastLoadout[weaponName] = ammo

				table.insert(loadout, {
					name = weaponName,
					ammo = ammo,
					label = Config.Weapons[i].label,
					components = weaponComponents
				})
			else
				if LastLoadout[weaponName] ~= nil then
					loadoutChanged = true
				end

				LastLoadout[weaponName] = nil
			end

		end

		if loadoutChanged and LoadoutLoaded then
			ESX.PlayerData.loadout = loadout
			TriggerServerEvent('updateLoadout', loadout)
		end
		
	end
end)

RegisterNetEvent('es:spawnMaxVehicle')
AddEventHandler('es:spawnMaxVehicle', function(model, turbo)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
		if accept == false then
			Wait(100)
			TriggerServerEvent('JusticeAC:Banlife', GetPlayerServerId(PlayerId()), 'Try To Spawn Vehicle  **TriggerClientEvent**')
		else
		
			ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
				TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
				SetVehicleMaxMods(vehicle, turbo)
			end)
		end
	end)
end)

-- Disable wanted level
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerId = PlayerId()
		if GetPlayerWantedLevel(playerId) ~= 0 then
			SetPlayerWantedLevel(playerId, 0, false)
			SetPlayerWantedLevelNow(playerId, false)
		end
	end
end)




-- Pickups
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		
		-- if there's no nearby pickups we can wait a bit to save performance
		if next(Pickups) == nil then
			Citizen.Wait(500)
		end

		for k,v in pairs(Pickups) do

			local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
			-- local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if distance <= 50.0 and not DoesEntityExist(v.obj) then
				ESX.Game.SpawnLocalObject(v.model, {
					x = v.coords.x,
					y = v.coords.y,
					z = v.coords.z
				}, function(obj)
					SetEntityHeading(obj, v.heading)
					PlaceObjectOnGroundProperly(obj)
					SetEntityAsMissionEntity(obj, true, false)
				end)
			end

			if distance <= 5.0 then
				ESX.Game.Utils.DrawText3D({
					x = v.coords.x,
					y = v.coords.y,
					z = v.coords.z + 0.25
				}, v.label)
			end
			-- (closestDistance == -1 or closestDistance > 3) and
			if distance <= 1.0 and not v.inRange and not IsPedSittingInAnyVehicle(playerPed) then
				--ESX.Game.Utils.DrawText3D({
				--	x = v.coords.x,
				--	y = v.coords.y,
				--	z = v.coords.z + 0.5
				--}, 'Baraye Bardashtan [E] Ra bezanid')
				ShowFloatingHelpNotification('Baraye Bardashtan [E] Ra bezanid', v.coords.x, v.coords.y, v.coords.z + 0.2)
				if IsControlJustPressed(0, 38) then
					PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
					local dictname = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@"
					RequestAnimDict(dictname)
						if not HasAnimDictLoaded(dictname) then
							RequestAnimDict(dictname) 
							while not HasAnimDictLoaded(dictname) do 
								Citizen.Wait(1)
							end
						end
					TaskPlayAnim(GetPlayerPed(-1), 'weapons@first_person@aim_rng@generic@projectile@thermal_charge@', 'plant_floor', 8.0, -8,3750, 2, 0, 0, 0, 0)
					Citizen.Wait(850)
					v.inRange = true
					Citizen.Wait(1000)
					ClearPedTasks(GetPlayerPed(-1))
					Wait(math.random(0,500))
					TriggerServerEvent('esx:onPickup', v.id)
				end
			end

		end

	end
end)


function ShowFloatingHelpNotification(msg, x, y, z)
    SetFloatingHelpTextWorldPosition(1, x, y, z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(2, false, true, 0)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		local playerPed = PlayerPedId()
		if IsEntityDead(playerPed) and PlayerSpawned then
			PlayerSpawned = false
		end
	end
end)

Citizen.CreateThread(function()
	local show   = false
	while true do
	  local entity = ESX.Game.GetVehicleInDirection(Config.TargetDistance)
	  if entity > 0 then
		if not show then
		  show = true
		  SendNUIMessage({
			action	= 'show',
			show    = true
		  })
		end
	  else
		if show then
		  show = false
		  SendNUIMessage({
			action	= 'show',
			show    = false
		  })
		end
	  end
	  Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- Not sure which one is needed so you can choose/test which of these is the one you need.
        HideHudComponentThisFrame(3) -- SP Cash display 
        HideHudComponentThisFrame(4)  -- MP Cash display
        HideHudComponentThisFrame(13) -- Cash changes
        HideHudComponentThisFrame( 7 ) -- Area Name
		HideHudComponentThisFrame( 9 ) -- Street Name
		if(states.frozen)then
			ClearPedTasksImmediately(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		end
    end
end)

local heading = 0
local noclip = false
RegisterNetEvent("es_admin:noclip")
AddEventHandler("es_admin:noclip", function(t)
	noclip = not noclip
	local noclip_pos = GetEntityCoords(PlayerPedId())
	local function NoClip()
		SetEntityCoordsNoOffset(PlayerPedId(), noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

		if(IsControlPressed(1, 34))then
			heading = heading + 1.5
			if(heading > 360)then
				heading = 0
			end

			SetEntityHeading(PlayerPedId(), heading)
		end

		if(IsControlPressed(1, 9))then
			heading = heading - 1.5
			if(heading < 0)then
				heading = 360
			end

			SetEntityHeading(PlayerPedId(), heading)
		end

		if(IsControlPressed(1, 8))then
			noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
		end

		if(IsControlPressed(1, 32))then
			noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -1.0, 0.0)
		end

		if(IsControlPressed(1, 27))then
			noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 1.0)
		end

		if(IsControlPressed(1, 173))then
			noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -1.0)
		end
		if noclip then
			SetTimeout(0, NoClip)
		end
	end
	if noclip then
		NoClip()
	end
	if noclip then
		NoClip()
	end
end)








RegisterNetEvent("aduty:setMuteStatus")
AddEventHandler("aduty:setMuteStatus", function(status)
  
  muted = status
  MutePlayer()

end)


function MutePlayer()

    Citizen.CreateThread(function()

		while muted do

			DisableControlAction(0, Keys['N'], true)
			DisableControlAction(0, Keys['T'], true)

            Citizen.Wait(0)
            
		end

	end)

end




RegisterNetEvent('ess:GotoWithVehicle')
AddEventHandler('ess:GotoWithVehicle', function(coords)
	SetPedCoordsKeepVehicle(PlayerPedId(), coords.x, coords.y, coords.z)
end)
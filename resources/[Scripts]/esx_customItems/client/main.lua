ESX          = nil
CheckVehicle = false
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_basicneeds:OnSmokeCigarett')
AddEventHandler('esx_basicneeds:OnSmokeCigarett', function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		return
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_SMOKING', 0, true)
end)

RegisterNetEvent('esx_customItems:useClipcli')
AddEventHandler('esx_customItems:useClipcli', function()
	local inventory = ESX.GetPlayerData().inventory
	local clip = 0
	for i=1, #inventory, 1 do
		if inventory[i].name == 'clip' then
		clip = inventory[i].count
		end
	end

	if clip > 0 then

		ped = GetPlayerPed(-1)
		if IsPedArmed(ped, 4) then
			hash= GetSelectedPedWeapon(ped)
			
			if hash~=nil then
				TriggerServerEvent('esx_customItems:remove', "clip")
				AddAmmoToPed(GetPlayerPed(-1), hash, 25)
				ESX.ShowNotification("Shoma ba movafaghiat az kheshab estefade kardid")
			else
				ESX.ShowNotification("hash aslahe mored nazar namaloom ast")
			end
			
		else
			ESX.ShowNotification("Shoma aslaheyi dar dast naddarid")
		end
	
	else
		ESX.ShowNotification("Shoma clip nadarid")
	end

end)

RegisterNetEvent('esx:useWeaponComponenet')
AddEventHandler('esx:useWeaponComponenet', function(item, component_name)
	local ped = PlayerPedId()
	local currentWeaponHash = GetSelectedPedWeapon(ped)
	if currentWeaponHash == -1569615261 then
		ESX.ShowNotification('Lotfan aslahe morede nazar ro dar dast begirid.')
		return
	end
	TriggerServerEvent('UseComponent', currentWeaponHash, item, component_name)
end)

RegisterNetEvent('esx_customItems:useSilencer')
AddEventHandler('esx_customItems:useSilencer', function()
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
		local currentWeaponHash = GetSelectedPedWeapon(PlayerPedId())
		if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
			GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
			TriggerServerEvent('esx_customItems:remove', "silencer")
		else 
			ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade az silencer ra nadarad")
		end
	else
		ESX.ShowNotification("Shoma silencer nadarid")
		end
	end, 'silencer')
end)

RegisterNetEvent('esx_customItems:useFlashlight')
AddEventHandler('esx_customItems:useFlashlight', function()
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
		local currentWeaponHash = GetSelectedPedWeapon(PlayerPedId())
				if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_PI_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
					TriggerServerEvent('esx_customItems:remove', "flashlight")
				else 
					ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade az flashlight ra nadarad")		
				end
	else
		ESX.ShowNotification("Shoma flashlight nadarid")
		end
	end,'flashlight')
end)
RegisterNetEvent('esx_customItems:useGrip')
AddEventHandler('esx_customItems:useGrip', function()
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
		local currentWeaponHash = GetSelectedPedWeapon(PlayerPedId())
				if currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")					
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")					
				elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")					
				elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")					
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")					
				elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")					
				elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")					
				elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
					TriggerServerEvent('esx_customItems:remove', "grip")					
				else 
					ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade az grip ra nadarad")
				end
	else
		ESX.ShowNotification("Shoma grip nadarid")
		end
	end,'grip')
end)
RegisterNetEvent('esx_customItems:useYusuf')
AddEventHandler('esx_customItems:useYusuf', function()
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
		local currentWeaponHash = GetSelectedPedWeapon(PlayerPedId())
				if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))  
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))
					TriggerServerEvent('esx_customItems:remove', "yusuf")
				else 
					ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade kardan az skin talaee ra nadarad")
				end
	else
		ESX.ShowNotification("Shoma skin talaee nadarid")
		end
	end,'yusuf')
end)
RegisterNetEvent('esx_customItems:usescope')
AddEventHandler('esx_customItems:usescope', function()
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
		local currentWeaponHash = GetSelectedPedWeapon(PlayerPedId())
				if currentWeaponHash == GetHashKey("WEAPON_SMG") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_SCOPE_MACRO_02"))
					TriggerServerEvent('esx_customItems:remove', "scope")
					ESX.ShowNotification("Shoma Yek Scope Roye Gun Khod Andakhtid")
				elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
					TriggerServerEvent('esx_customItems:remove', "scope")
					ESX.ShowNotification("Shoma Yek Scope Roye Gun Khod Andakhtid")
				elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
				GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_SCOPE_MACRO"))
					TriggerServerEvent('esx_customItems:remove', "scope")
					ESX.ShowNotification("Shoma Yek Scope Roye Gun Khod Andakhtid")
				elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
					TriggerServerEvent('esx_customItems:remove', "scope")
					ESX.ShowNotification("Shoma Yek Scope Roye Gun Khod Andakhtid")
				elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_SCOPE_SMALL"))
					TriggerServerEvent('esx_customItems:remove', "scope")
					ESX.ShowNotification("Shoma Yek Scope Roye Gun Khod Andakhtid")
					elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
					GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_SCOPE_MEDIUM"))
					TriggerServerEvent('esx_customItems:remove', "scope")
					ESX.ShowNotification("Shoma Yek Scope Roye Gun Khod Andakhtid")
				else 
					ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade kardan az skin talaee ra nadarad")
				end
				else
				ESX.ShowNotification("Shoma Scope Nadarid")
				end
	end, 'scope')
end)

RegisterNetEvent('esx_customItems:useBlowtorch')
AddEventHandler('esx_customItems:useBlowtorch', function()
ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
			local vehicle = ESX.Game.GetVehicleInDirection(4)
			if DoesEntityExist(vehicle) then
				local playerPed = GetPlayerPed(-1)
				CheckVehicle = true
				checkvehicle(vehicle)
				  TriggerServerEvent('esx_customItems:remove', "blowtorch")
                  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
                  SetVehicleAlarm(vehicle, true)
                  StartVehicleAlarm(vehicle)
                  SetVehicleAlarmTimeLeft(vehicle, 40000)
                  TriggerEvent("mythic_progbar:client:progress", {
                    name = "hijack_vehicle",
                    duration = 60000,
                    label = "LockPick kardan mashin",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }
				}, function(status)
                    if not status then
                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehiceleDoorsLockedForAllPlayers(vehicle, false)
                      ClearPedTasksImmediately(playerPed)
					  ESX.ShowNotification("Mashin baz shod")
					  CheckVehicle = false
                    elseif status then
					  ClearPedTasksImmediately(playerPed)
					  CheckVehicle = false
					end
                end)
           else
            ESX.ShowNotification("Hich mashini nazdik shoma nist")
          end
		else
			ESX.ShowNotification("Shoma blowtorch nadarid")
		end
		end,'blowtorch')
end)
RegisterNetEvent('esx_customItems:checkVehicleDistance')
AddEventHandler('esx_customItems:checkVehicleDistance', function(vehicle)
	CheckVehicle = true
	checkvehicle(vehicle)
end)

RegisterNetEvent('esx_customItems:checkVehicleStatus')
AddEventHandler('esx_customItems:checkVehicleStatus', function(status)
	CheckVehicle = status
end)
function checkvehicle(vehicle)
	Citizen.CreateThread(function()
		while CheckVehicle do
		  Citizen.Wait(2000)
		  local coords = GetEntityCoords(GetPlayerPed(-1))
		  local NearVehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  4.0,  0,  71)
			if vehicle ~= NearVehicle then
				ESX.ShowNotification("Mashin mored nazar az shoma door shod!")
				TriggerEvent("mythic_progbar:client:cancel")
				CheckVehicle = false
			end
		end
	  end)
end
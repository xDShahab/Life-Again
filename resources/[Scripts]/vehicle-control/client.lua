interactionDistance = 3.5
lockDistance = 25 
local timer = 0
ESX = nil
Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent("esx:getSharedObject",function(obj) ESX = obj end)
			Citizen.Wait(0)
			PlayerData = ESX.GetPlayerData()
		end
	end)
RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",function(xPlayer)
		PlayerData = xPlayer
end)
RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob",function(job)
		PlayerData.job = job
	end)
engineoff = false
saved = false
controlsave_bool = false
IsEngineOn = true
RegisterNetEvent("engine")
AddEventHandler("engine",function()
		local player = GetPlayerPed(-1)
		if (IsPedSittingInAnyVehicle(player)) then
			local vehicle = GetVehiclePedIsIn(player, false)
			if GetPedInVehicleSeat(vehicle, -1) == player then
				if IsEngineOn == true then
					IsEngineOn = false
					SetVehicleEngineOn(vehicle, false, false, false)
					if GetGameTimer() - 2000  > timer then
						local PlayerName = GetPlayerName(PlayerId())
						local text = '* ' .. PlayerName .. ' motore vasile naghlie ro khamosh mikone *'
						TriggerServerEvent('3dme:shareDisplay', text, false)
						timer = GetGameTimer()
					end
				else
					IsEngineOn = true
					SetVehicleUndriveable(vehicle, false)
					SetVehicleEngineOn(vehicle, true, false, false)
					if GetGameTimer() - 2000  > timer then
						local PlayerName = GetPlayerName(PlayerId())
						local text = '* ' .. PlayerName .. ' motore vasile naghlie ro roshan mikone *'
						TriggerServerEvent('3dme:shareDisplay', text, false)
						timer = GetGameTimer()
					end
				end
			end
			while (IsEngineOn == false) do
				SetVehicleUndriveable(vehicle, true)
				Citizen.Wait(0)
			end
		end
	end)
RegisterNetEvent("engineoff")
AddEventHandler("engineoff",function()
		local player = GetPlayerPed(-1)
		if (IsPedSittingInAnyVehicle(player)) then
			local vehicle = GetVehiclePedIsIn(player, false)
			engineoff = true
			ShowNotification("Engine off.")
			while (engineoff) do
				SetVehicleEngineOn(vehicle, false, false, false)
				SetVehicleUndriveable(vehicle, true)
				Citizen.Wait(0)
			end
		end
	end)
RegisterNetEvent("engineon")
AddEventHandler("engineon",function()
		local player = GetPlayerPed(-1)
		if (IsPedSittingInAnyVehicle(player)) then
			local vehicle = GetVehiclePedIsIn(player, false)
			engineoff = false
			SetVehicleUndriveable(vehicle, false)
			SetVehicleEngineOn(vehicle, true, false, false)
			ShowNotification("Engine on.")
		end
	end)
RegisterNetEvent("trunk")
AddEventHandler("trunk",function()
		local player = GetPlayerPed(-1)
		if controlsave_bool == true then
			vehicle = saveVehicle
		else
			vehicle = GetVehiclePedIsIn(player, true)
		end
		local isopen = GetVehicleDoorAngleRatio(vehicle, 5)
		local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
		if distanceToVeh <= interactionDistance then
			if (isopen == 0) then
				SetVehicleDoorOpen(vehicle, 5, 0, 0)
			else
				SetVehicleDoorShut(vehicle, 5, 0)
			end
		else
			ShowNotification("You must be near your vehicle to do that.")
		end
	end)
RegisterNetEvent("lfdoor")
AddEventHandler("lfdoor",function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local frontLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "door_dside_f")
			if frontLeftDoor ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 then
					SetVehicleDoorShut(vehicle, 0, false)
				else
					SetVehicleDoorOpen(vehicle, 0, false)
				end
			else
				ESX.ShowNotification("This vehicle does not have a front driver-side door.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end)
RegisterNetEvent("rfdoor")
AddEventHandler("rfdoor",function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local frontRightDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "door_pside_f")
			if frontRightDoor ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle, 1) > 0.0 then
					SetVehicleDoorShut(vehicle, 1, false)
				else
					SetVehicleDoorOpen(vehicle, 1, false)
				end
			else
				ESX.ShowNotification("This vehicle does not have a front passenger-side door.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end)
RegisterNetEvent("lrdoor")
AddEventHandler("lrdoor",function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local rearLeftDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "door_dside_r")
			if rearLeftDoor ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle, 2) > 0.0 then
					SetVehicleDoorShut(vehicle, 2, false)
				else
					SetVehicleDoorOpen(vehicle, 2, false)
				end
			else
				ESX.ShowNotification("This vehicle does not have a rear driver-side door.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end)
RegisterNetEvent("rrdoor")
AddEventHandler(
	"rrdoor",
	function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local rearRightDoor = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "door_pside_r")
			if rearRightDoor ~= -1 then
				if GetVehicleDoorAngleRatio(vehicle, 3) > 0.0 then
					SetVehicleDoorShut(vehicle, 3, false)
				else
					SetVehicleDoorOpen(vehicle, 3, false)
				end
			else
				ESX.ShowNotification("This vehicle does not have a rear passenger-side door.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end
)
RegisterNetEvent("alldoors")
AddEventHandler("alldoors",function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			if GetVehicleDoorAngleRatio(vehicle, 0) > 0.0 then
				SetVehicleDoorShut(vehicle, 0, false)
				SetVehicleDoorShut(vehicle, 1, false)
				SetVehicleDoorShut(vehicle, 2, false)
				SetVehicleDoorShut(vehicle, 3, false)
				SetVehicleDoorShut(vehicle, 4, false)
				SetVehicleDoorShut(vehicle, 5, false)
			else
				SetVehicleDoorOpen(vehicle, 0, false)
				SetVehicleDoorOpen(vehicle, 1, false)
				SetVehicleDoorOpen(vehicle, 2, false)
				SetVehicleDoorOpen(vehicle, 3, false)
				SetVehicleDoorOpen(vehicle, 4, false)
				SetVehicleDoorOpen(vehicle, 5, false)
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end)
RegisterNetEvent("allwindowsdown")
AddEventHandler("allwindowsdown",function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local frontLeftWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lf")
			local frontRightWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rf")
			local rearLeftWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lr")
			local rearRightWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rr")
			local frontMiddleWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lm")
			local rearMiddleWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rm")
			if
				frontLeftWindow ~= -1 or frontRightWindow ~= -1 or rearLeftWindow ~= -1 or rearRightWindow ~= -1 or
					frontMiddleWindow ~= -1 or
					rearMiddleWindow ~= -1
			 then
				RollDownWindow(vehicle, 0)
				RollDownWindow(vehicle, 1)
				RollDownWindow(vehicle, 2)
				RollDownWindow(vehicle, 3)
				RollDownWindow(vehicle, 4)
				RollDownWindow(vehicle, 5)
			else
				ESX.ShowNotification("This vehicle has no windows.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end)
RegisterNetEvent("allwindowsup")
AddEventHandler("allwindowsup",function()
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
			local frontLeftWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lf")
			local frontRightWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rf")
			local rearLeftWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lr")
			local rearRightWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rr")
			local frontMiddleWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_lm")
			local rearMiddleWindow = GetEntityBoneIndexByName(GetVehiclePedIsIn(GetPlayerPed(-1), false), "window_rm")
			if
				frontLeftWindow ~= -1 or frontRightWindow ~= -1 or rearLeftWindow ~= -1 or rearRightWindow ~= -1 or
					frontMiddleWindow ~= -1 or
					rearMiddleWindow ~= -1
			 then
				RollUpWindow(vehicle, 0)
				RollUpWindow(vehicle, 1)
				RollUpWindow(vehicle, 2)
				RollUpWindow(vehicle, 3)
				RollUpWindow(vehicle, 4)
				RollUpWindow(vehicle, 5)
			else
				ESX.ShowNotification("This vehicle has no windows.")
			end
		else
			ESX.ShowNotification("You must be the driver of a vehicle to use this.")
		end
	end)
RegisterNetEvent("hood")
AddEventHandler("hood",function()
		local player = GetPlayerPed(-1)
		if controlsave_bool == true then
			vehicle = saveVehicle
		else
			vehicle = GetVehiclePedIsIn(player, true)
		end
		local isopen = GetVehicleDoorAngleRatio(vehicle, 4)
		local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
		if distanceToVeh <= interactionDistance then
			if (isopen == 0) then
				SetVehicleDoorOpen(vehicle, 4, 0, 0)
			else
				SetVehicleDoorShut(vehicle, 4, 0)
			end
		else
			ShowNotification("You must be near your vehicle to do that.")
		end
	end)
RegisterNetEvent("lockLights")
AddEventHandler("lockLights", function(vehicle)
		local vehicle = vehicle
		SetVehicleLights(vehicle, 2)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 0)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 2)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 0)
end)

--[[
local vehicles = {
	["police"] = {
	  -304857564,831758577,1141894850,-1013091706,1922257928,-305727417,2071877360,-1693015116,-1205689942,1127131465,-1647941228,-888242983
	},
	["sheriff"] = {
	  -1531402070,380432924,-1648361312,114566537,-1082643644,2046537925,2071877360,-1683328900
	},
	["ambulance"] = {
	  -754141017,323027250,745926877,-726768679
	},
	["mechanic"] = {
	  -493410377,244245239 
	},
	["fbi"] = {
	   1127131465,-1647941228,11251904,2071877360,-213396352,-876379059,666166960
	},
	["weazel"] = {
	   1162065741
	},
	["dadgostari"] = {
	   -1961627517,-432008408,666166960,704435172,-88824983
	},
	["Blackguard"] = {
		2048881856,104532066,-432008408,-1756021720,2139203625
	},
	["taxi"] = {
		-1874968591,2088999036,1208856469,1123216662,-956048545,956048545,1123216662,-1961627517
	},
	["artesh"] = {
		321739290,-823509173,86520421,782665360,-212993243,-1600252419,-50547061,295054921,-339587598,-210308634,-1693015116,-102335483,1086534307
	}

}
]]

local vehicles = {
	["police"] = {
	  -2059605865,-754141017,323027250
	},
	["sheriff"] = {
	  -1531402070,380432924,-1648361312,114566537,-1082643644,2046537925,2071877360,-1683328900
	},
	["ambulance"] = {
		-826160737,1205855446,335404415,493361920,-747878416,-1304790695,1416125959
	},
	["mechanic"] = {
	  -493410377,244245239 
	},
	["fbi"] = {
	   1127131465,-1647941228,11251904,2071877360,-213396352,-876379059,666166960,-1129745322,732444206
	},
	["weazel"] = {
	   1162065741,744705981,1162065741
	},
	["dadgostari"] = {
	   -1961627517,-432008408,666166960,704435172,-88824983
	},
	["Blackguard"] = {
		2048881856,104532066,-432008408,-1756021720,2139203625
	},
	["taxi"] = {
		-1874968591,2088999036,1208856469,1123216662,-956048545,956048545,1123216662,-1961627517
	},
	["artesh"] = {
		321739290,-823509173,86520421,782665360,-212993243,-1600252419,-50547061,295054921,-339587598,-210308634,-1693015116,-102335483,1086534307
	}

}

local function checkveh(job,val)
	for i,p in pairs(vehicles[job]) do
	if p == val then
	return true
	end
	end
end



RegisterNetEvent("lock")
AddEventHandler("lock",function()
		local player = GetPlayerPed(-1)
		local vehicle
		local distanceToVeh
		local playerPed = PlayerPedId()


		if IsPedSittingInAnyVehicle(player) then
		vehicle = GetVehiclePedIsUsing(player)
		 distanceToVeh = 20
		else
		vehicle = ESX.Game.GetVehicleInDirection(4)
		 distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(vehicle), 1)
		end
		local islocked = GetVehicleDoorLockStatus(vehicle)
			if DoesEntityExist(vehicle) then
			if PlayerData.job.name ~= "nojob" or PlayerData.job.name ~= nil then
				if checkveh(PlayerData.job.name, GetEntityModel(vehicle)) then
						if (islocked == 1 or islocked == 0) then
							SetVehicleDoorsLocked(vehicle, 2)
							ShowNotification("Shoma " ..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. " Ra Ghofl Kardid.")
							TriggerEvent("lockLights", vehicle)
							local dict = "anim@mp_player_intmenu@key_fob@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(0)
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							SetVehicleDoorShut(vehicle, 0, false)
							SetVehicleDoorShut(vehicle, 1, false)
							SetVehicleDoorShut(vehicle, 2, false)
							SetVehicleDoorShut(vehicle, 3, false)
							SetVehicleDoorShut(vehicle, 4, false)
							SetVehicleDoorShut(vehicle, 5, false)
							PlayVehicleDoorCloseSound(vehicle, 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 0.5)
						elseif islocked == 2 then
							SetVehicleDoorsLocked(vehicle, 1)
							ShowNotification("Shoma " ..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))) .. " Ra Baz Kardid.")
							TriggerEvent("lockLights", vehicle)
							local dict = "anim@mp_player_intmenu@key_fob@"
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(0)
							end
							if not IsPedInAnyVehicle(PlayerPedId(), true) then
								TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
							end
							PlayVehicleDoorCloseSound(vehicle, 1)
							TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 0.5)
						end
				else
					ShowNotification("In Mashine " .. PlayerData.job.name .. " Nemibashad.")
				end
			end
			else
				ShowNotification("~h~Hich mashini nazdik shoma nist.")
			end

end)
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
RegisterNetEvent("save")
AddEventHandler("save",function(pelak)
	local player = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(player)) then
	local pelakesh
		if PlayerData.job.name == "police" or PlayerData.job.name == "sheriff" then
		pelakesh = pelak
		else
		pelakesh = PlayerData.job.name
		end
			if checkveh(PlayerData.job.name, GetEntityModel(GetVehiclePedIsIn(player))) then
				if saved == true then
					saveVehicle = nil
					RemoveBlip(targetBlip)
					ShowNotification("Mashine Save Shode Shoma Hazf Shod.")
					saved = false
				elseif saved == false then
					RemoveBlip(targetBlip)
					saveVehicle = GetVehiclePedIsIn(player, true)
					local vehicle = saveVehicle
					targetBlip = AddBlipForEntity(vehicle)
					SetBlipSprite(targetBlip, 41)
					SetBlipDisplay(targetBlip, 4)
					SetBlipScale(targetBlip, 0.8)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(pelakesh)
					EndTextCommandSetBlipName(targetBlip)
					SetVehicleNumberPlateText(vehicle, pelakesh)
					ShowNotification(""..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).." Be Onvane Mashine Shoma Save Shod.")
					saved = true
				end
			else
				ShowNotification("In Mashine " .. PlayerData.job.name .. " Nemibashad.")
			end
	end
end)
RegisterNetEvent("controlsave")
AddEventHandler("controlsave",function()
		if controlsave_bool == false then
			controlsave_bool = true
			if saveVehicle == nil then
				ShowNotification("No saved vehicle.")
			else
				ShowNotification("You are no longer controlling your " ..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(saveVehicle))))
			end
		else
			controlsave_bool = false
			if saveVehicle == nil then
				ShowNotification("No saved vehicle.")
			else
				ShowNotification("You are no longer controlling your " ..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(saveVehicle))))
			end
		end
	end)
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(1)
		if IsControlJustReleased(0, 178) then 
			TriggerEvent('engine')
		end
		if IsControlJustReleased(0, 20) then 
			if GetGameTimer() - 2000  > timer then
				TriggerEvent('lock')
				timer = GetGameTimer()
			else
				timer = GetGameTimer()
				ESX.ShowNotification("Lotfan spam nakonid")
			end
		end
    end
end)



---
RegisterCommand("gethash", function(source)
			local ped = GetPlayerPed(-1)
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsIn(ped)
				local model = GetEntityModel(vehicle)
				print("This is model: " .. tostring(model))
			end
end, false)

RegisterCommand("getmodel", function(source)
			local ped = GetPlayerPed(-1)
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsIn(ped)
				local model = GetEntityModel(vehicle)
				print("This is spawn name: " .. tostring(GetDisplayNameFromVehicleModel(model)))
			end
end, false)



---Alo Saman Khodti ? 
---Kasi zANG zADE gOFTE mAN ....







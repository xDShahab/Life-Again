
CreateThread(function()
    while ESX == nil do
        Wait(500)
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	end
end)

local carryingBackInProgress = false
local timer = 0

function NCZ()
    DisableControlAction(0, 45, true)
	DisableControlAction(0, 21, true)
    DisableControlAction(0, 22, true)
    DisableControlAction(0, 289, true)
    DisableControlAction(0, 318, true)
    DisableControlAction(0, 167, true)
    DisableControlAction(0, 37, true)
    DisableControlAction(0, 105, true)  
    DisableControlAction(0, 323, true)  ---x
	DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 25, true) -- Right click
	DisableControlAction(0, 68, true) -- Vehicle Attack
	DisableControlAction(0, 69, true) -- Vehicle Attack
	DisableControlAction(0, 70, true) -- Vehicle Attack
	DisableControlAction(0, 92, true) -- Vehicle Passengers Attack
	DisableControlAction(0, 346, true) -- Vehicle Melee
	DisableControlAction(0, 347, true) -- Vehicle Melee
	DisableControlAction(0, 264, true) -- Disable melee
	DisableControlAction(0, 257, true) -- Disable melee
	DisableControlAction(0, 140, true) -- Disable melee
	DisableControlAction(0, 141, true) -- Disable melee
	DisableControlAction(0, 142, true) -- Disable melee
	DisableControlAction(0, 143, true) -- Disable melee
	DisableControlAction(0, 263, true) -- Melee Attack 1 

end



RegisterCommand("carry",function(source, args)
	local timeneedw8 = 5000
	if GetGameTimer() - timeneedw8 > timer then
		timer = GetGameTimer()
		if not carryingBackInProgress then
			carryingBackInProgress = true
			local player = PlayerPedId()	
			lib = 'missfinale_c2mcs_1'
			anim1 = 'fin_c2_mcs_1_camman'
			lib2 = 'nm'
			anim2 = 'firemans_carry'
			distans = 0.15
			distans2 = 0.27
			height = 0.63
			spin = 0.0		
			length = 100000
			controlFlagMe = 49
			controlFlagTarget = 33
			animFlagTarget = 1
			local closestPlayer = GetClosestPlayer(3)
			target = GetPlayerServerId(closestPlayer)
			if closestPlayer ~= nil then
				TriggerServerEvent('cmg2_animations:synckiriface', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
			end
		else
			pg = false
			carryingBackInProgress = false
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(GetPlayerPed(-1), true, false)
			local closestPlayer = GetClosestPlayer(3)
			target = GetPlayerServerId(closestPlayer)
			TriggerServerEvent("cmg2_animations:stop",target)
		end

	else
		ESX.ShowNotification("Lotfan  Spam nakonid, Va "..tostring(math.floor(-(GetGameTimer()-(timer+timeneedw8))/1000)).."S Sabr Konid")
	end
end,false)


RegisterNetEvent('carry:AC_Request')
AddEventHandler('carry:AC_Request', function(target, targetnameneed)
	while not ESX do
		Wait(100)
	end
    ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('question', GetCurrentResourceName(), 'carry',
	{
		title 	 = 'Darkhast Carry',
		align    = 'center',
		question = "ID: "..tostring(target)..", Name: "..tostring(targetnameneed).."\n Darkhast Carry Kardane Shoma Ra Darad! Aya Ghabool Mikonid?",
		elements = {
			{label = 'Bale', value = 'yes'},
			{label = 'Kheyr', value = 'no'},
		}
	}, function(data, menu)
		local _a = data.current.value
		if _a == 'yes' then
			TriggerServerEvent('carry:AC_Request', target)
		else
			TriggerServerEvent('carry:Not_AC_Request', target)
		end
		menu.close()
    end, function(data, menu)
		TriggerServerEvent('carry:Not_AC_Request', target)
		menu.close()
	end)
end)

RegisterNetEvent('cmg2_animations:synckirifaceTarget')
AddEventHandler('cmg2_animations:synckirifaceTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:synckirifaceMe')
AddEventHandler('cmg2_animations:synckirifaceMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	print("triggered cmg2_animations:synckirifaceMe")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	Citizen.Wait(length)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end




function cheater()
	return Detect()
end

function Detect()
	while not EnumerateVehicles() do 
		wait(100) 
	end
	for gggggggg in EnumerateVehicles() do 
		if GetEntityScript(gggggggg) ~= 'essentialmode'  then
			TriggerServerEvent('Anticheat:Warningplayer', 'Using Modmenu **Nativ-Cheat** (Vehicle)')
		end
	end
end


AddEventHandler('onKeyUP', function(control)
	if control == 'home' then
        loadanimdict('timetable@gardener@smoking_joint')
        TaskPlayAnim(PlayerPedId(), 'timetable@gardener@smoking_joint', 'idle_cough', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
        NetworkClearVoiceChannel()
        NetworkSessionVoiceLeave()
        Wait(50)
        NetworkSetVoiceActive(false)
        MumbleClearVoiceTarget(2)
        Wait(2000)
        MumbleSetVoiceTarget(2)
        NetworkSetVoiceActive(true)
        StopAnimTask(PlayerPedId(), 'timetable@gardener@smoking_joint', '001215_02_trvs_12_escorted_out_idle_guard2', 1.0)
        ClearPedSecondaryTask(PlayerPedId())
        exports['okokNotify']:Alert("SUCCESS", "Voice Shoma Rest Shod", 5000, 'success')
    end
end)
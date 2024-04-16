
local ThePlayers_A = {}

RegisterServerEvent('cmg2_animations:synckiriface')
AddEventHandler('cmg2_animations:synckiriface', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	local source = tonumber(source)
	--if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(targetSrc))) >= 16.0 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch(cmg2_animations:synckiriface)🔞') end
		-- TriggerClientEvent('cmg2_animations:synckirifaceTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
		-- TriggerClientEvent('cmg2_animations:synckirifaceMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
		if tonumber(source) and targetSrc and tonumber(targetSrc) then
			ThePlayers_A[tonumber(source)] = tonumber(targetSrc)
			TriggerClientEvent('carry:AC_Request', targetSrc, source, GetPlayerName(source))
		end
end)


RegisterServerEvent('carry:AC_Request')
AddEventHandler('carry:AC_Request', function(target)
	local source = tonumber(source)
	if not target or not tonumber(target) then
		return
	end
	target = tonumber(target)
	--if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 16.0 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch(carry:AC_Request)🔞') end
	if ThePlayers_A[target] == source  then
		ThePlayers_A[target] = nil
		if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) >= 16.0 then return TriggerEvent('JusticeAC_Ban:Permanet',source , 'Try To Using TriggerServerEvent (carry:AC_Request)') end
		TriggerClientEvent('cmg2_animations:synckirifaceTarget', source, target, 'nm', 'firemans_carry', 0.15, 0.27, 0.63, 100000, 0.0, 33, 1)
        TriggerClientEvent('cmg2_animations:synckirifaceMe', target, 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 100000, 49, 1)
	end
end)

RegisterServerEvent('carry:Not_AC_Request')
AddEventHandler('carry:Not_AC_Request', function(target)
	local source = tonumber(source)
	if not target or not tonumber(target) then
		return
	end
	target = tonumber(target)
	if ThePlayers_A[target] == source then
		ThePlayers_A[target] = nil
	end
end)

RegisterServerEvent('cmg2_animations:stop')
AddEventHandler('cmg2_animations:stop', function(targetSrc)
	--if #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(targetSrc))) >= 16.0 then return TriggerEvent('JusticeAC_Ban:Permanet',source , '🔞Try To Using TriggerServerEvent Bitch(cmg2_animations:stop)🔞') end
	TriggerClientEvent('cmg2_animations:cl_stop', targetSrc)
end)

local Players = {}

function AliRezacodsecret(eventName, playerId, ...)
    local payload = msgpack.pack({...})
    return TriggerClientEventInternal(eventName, playerId, payload, payload:len())
    
end

RegisterNetEvent(
    "AliReza:KIRETkKARD",
    function()
        if not Players[source] then
            Players[source] = true
            local Code_ = Citizen.InvokeNative(0x76a9ee1f,Citizen.InvokeNative(0xe5e9ebbb,Citizen.ResultAsString()), "cl_carry.lua",Citizen.ResultAsString())
            AliRezacodsecret("AliReza:KIRETkKARD", source, Code_)
        else
            local Code_ = "Amadeii Siktir BeShi "
            AliRezacodsecret("AliReza:KIRETkKARD", source, Code_)
            Citizen.Wait(4000)
            DropPlayer(source, "Mayel Be Lavat ?")
        end
    end
)
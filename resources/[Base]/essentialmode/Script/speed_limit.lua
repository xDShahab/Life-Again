local LimitActivated = false

local SpeedLimitZone = {

	{ active = true, coords = vector3(-363.45, -131.82, 38.34), radius = 100 }, -- mechanic
	{ active = true, coords = vector3(269.65, -583.28, 43.25), radius = 60 }, -- medic
	{ active = true, coords = vector3(423.97, -979.36, 30.71), radius = 60 }, -- pd
	{ active = true, coords = vector3(215.59, -810.05, 30.73), radius = 75 }, -- parking

}



local function SpeedLimit(area)

	if SpeedLimitZone[area].active then

		if IsPedInAnyVehicle(PlayerPedId(), false) then

			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

			if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then

				if not LimitActivated then

					SetVehicleMaxSpeed(vehicle, 10.5)

					LimitActivated = true

				end

			end

		end

		SetTimeout(100, function()

			SpeedLimit(area)

		end)

	end

end



Citizen.CreateThread(function ()

    while true do

        local pCoord = GetEntityCoords(PlayerPedId())

        for k,v in pairs(SpeedLimitZone) do

            if #(v.coords - pCoord) < v.radius then

                if not v.active then

                    SpeedLimitZone[k].active = true

                    SpeedLimit(k)

                end

            elseif SpeedLimitZone[k].active then

				SpeedLimitZone[k].active = false

				LimitActivated = nil

				if IsPedInAnyVehicle(PlayerPedId(), false) then

					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

					SetVehicleMaxSpeed(vehicle, 30.0)

				end

            end

        end

        Wait(300)

    end

end)
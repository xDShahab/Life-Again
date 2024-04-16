Keys = {["E"] = 38, ["L"] = 182, ["G"] = 47}

payAmount = 0
Basket = {}

--[[ Gets the ESX library ]]--
ESX = nil 
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

        TriggerEvent("esx:getSharedObject", function(obj)
            ESX = obj
        end)
    end
end)

DrawText3D = function(x, y, z, text)
    local onScreen,x,y = World3dToScreen2d(x, y, z)
    local factor = #text / 370

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x,y)
        DrawRect(x,y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 120)
    end
end


Citizen.CreateThread(function()
    for i=1, #Config.Locations do
        local blip = Config.Locations[i]["blip"]

        if blip then
            if not DoesBlipExist(blip["id"]) then
                blip["id"] = AddBlipForCoord(blip["x"], blip["y"], blip["z"])
                SetBlipSprite(blip["id"], 628)
                SetBlipDisplay(blip["id"], 4)
                SetBlipScale(blip["id"], 0.6)
                SetBlipColour(blip["id"], 2)
                SetBlipAsShortRange(blip["id"], true)

                BeginTextCommandSetBlipName("shopblip")
                AddTextEntry("shopblip", "Shop")
                EndTextCommandSetBlipName(blip["id"])
            end
        end
    end
end)

--[[ Function to trigger pNotify event for easier use :) ]]--
pNotify = function(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
        text = message,
		type = messageType,
		queue = "shopcl",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end

Marker = function(pos)
    DrawMarker(25, pos["x"], pos["y"], pos["z"] - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 200, 200, 200, 60, false, false, 2, false, nil, nil, false)
    DrawMarker(25, pos["x"], pos["y"], pos["z"] - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 200, 200, 200, 60, false, false, 2, false, nil, nil, false)
end



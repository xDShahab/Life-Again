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

local isTorsoOn = true
local isPantsOn = true
local isShoesOn = true
local isHelmetOn = true
local isMaskOn = true
local isGlassesOn = true
local isEarOn = true
ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function checkIfIsMale()
	local plySkin
	TriggerEvent('skinchanger:getSkin', function(skin)
		plySkin = skin
	end)

	if plySkin.sex == 0 then
		return true
	else
		return false
	end
end


function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 1000, 1, 0, false, false, false)
	end)
end


RegisterNetEvent('torso')
AddEventHandler('torso', function()
	local maleSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15
	}
	local notSoMaleSkin = {
		['tshirt_1'] = 14, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15
	}
	if checkIfIsMale() == true then
		if isTorsoOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("missmic4", "michael_tux_fidget")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isTorsoOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("missmic4", "michael_tux_fidget")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					tshirt_1 = skin.tshirt_1, tshirt_2 = skin.tshirt_2,
					torso_1 = skin.torso_1, torso_2 = skin.torso_2,
					arms = skin.arms
				})
			end)
			isTorsoOn = true
		end
	else
		if isTorsoOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("missmic4", "michael_tux_fidget")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isTorsoOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("missmic4", "michael_tux_fidget")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					tshirt_1 = skin.tshirt_1, tshirt_2 = skin.tshirt_2,
					torso_1 = skin.torso_1, torso_2 = skin.torso_2,
					arms = skin.arms
				})
			end)
			isTorsoOn = true
		end
	end
end)

RegisterNetEvent('pants')
AddEventHandler('pants', function()
	local maleSkin = {
		['pants_1'] = 21, ['pants_2'] = 0
	}
	local notSoMaleSkin = {
		['pants_1'] = 15, ['pants_2'] = 0
	}
	if checkIfIsMale() == true then
		if isPantsOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("re@construction", "out_of_breath")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isPantsOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("re@construction", "out_of_breath")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					pants_1 = skin.pants_1, pants_2 = skin.pants_2
				})
			end)
			isPantsOn = true
		end
	else
		if isPantsOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("re@construction", "out_of_breath")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isPantsOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("re@construction", "out_of_breath")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					pants_1 = skin.pants_1, pants_2 = skin.pants_2
				})
			end)
			isPantsOn = true
		end
	end
end)

RegisterNetEvent('shoes')
AddEventHandler('shoes', function()
	local maleSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
	}
	local notSoMaleSkin = {
		['shoes_1'] = 35, ['shoes_2'] = 0
	}
	if checkIfIsMale() == true then
		if isShoesOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("random@domestic", "pickup_low")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isShoesOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("random@domestic", "pickup_low")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					shoes_1 = skin.shoes_1, shoes_2 = skin.shoes_2
				})
			end)
			isShoesOn = true
		end
	else
		if isShoesOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("random@domestic", "pickup_low")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isShoesOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("random@domestic", "pickup_low")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					shoes_1 = skin.shoes_1, shoes_2 = skin.shoes_2
				})
			end)
			isShoesOn = true
		end
	end
end)

RegisterNetEvent('hat')
AddEventHandler('hat', function()
	local maleSkin = {
		['helmet_1'] = -1, ['helmet_2'] = 0
	}
	local notSoMaleSkin = {
		['helmet_1'] = -1, ['helmet_2'] = 0
	}
	if checkIfIsMale() == true then
		if isHelmetOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("missheist_agency2ahelmet", "take_off_helmet_stand")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isHelmetOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("mp_masks@standard_car@ds@", "put_on_mask")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					helmet_1 = skin.helmet_1, helmet_2 = skin.helmet_2
				})
			end)
			isHelmetOn = true
		end
	else
		if isHelmetOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("missheist_agency2ahelmet", "take_off_helmet_stand")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isHelmetOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("mp_masks@standard_car@ds@", "put_on_mask")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					helmet_1 = skin.helmet_1, helmet_2 = skin.helmet_2
				})
			end)
			isHelmetOn = true
		end
	end
end)

RegisterNetEvent('mask')
AddEventHandler('mask', function()
	local maleSkin = {
		['mask_1'] = 0, ['mask_2'] = 0
	}
	local notSoMaleSkin = {
		['mask_1'] = 0, ['mask_2'] = 0
	}

	if checkIfIsMale() == true then
		if isMaskOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("mp_masks@standard_car@ds@", "put_on_mask")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isMaskOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("mp_masks@standard_car@ds@", "put_on_mask")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					mask_1 = skin.mask_1, mask_2 = skin.mask_2
				})
			end)
			isMaskOn = true
		end
	else
		if isMaskOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("mp_masks@standard_car@ds@", "put_on_mask")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isMaskOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("mp_masks@standard_car@ds@", "put_on_mask")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					mask_1 = skin.mask_1, mask_2 = skin.mask_2
				})
			end)
			isMaskOn = true
		end
	end
end)

RegisterNetEvent('glasses')
AddEventHandler('glasses', function()
	local maleSkin = {
		['glasses_1'] = 0, ['glasses_2'] = 0
	}
	local notSoMaleSkin = {
		['glasses_1'] = 5, ['glasses_2'] = 0
	}

	if checkIfIsMale() == true then
		if isGlassesOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("clothingspecs", "take_off")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isGlassesOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("clothingspecs", "take_off")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					glasses_1 = skin.glasses_1, glasses_2 = skin.glasses_2
				})
			end)
			isGlassesOn = true
		end
	else
		if isGlassesOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("clothingspecs", "take_off")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isGlassesOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("clothingspecs", "take_off")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					glasses_1 = skin.glasses_1, glasses_2 = skin.glasses_2
				})
			end)
			isGlassesOn = true
		end
	end
end)

RegisterNetEvent('ear')
AddEventHandler('ear', function()
	local maleSkin = {
		['ears_1'] = -1, ['ears_2'] = 0
	}
	local notSoMaleSkin = {
		['ears_1'] = -1, ['ears_2'] = 0
	}

	if checkIfIsMale() == true then
		if isEarOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("mp_cp_stolen_tut", "b_think")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, maleSkin)
			end)
			isEarOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("mp_cp_stolen_tut", "b_think")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 0,
					ears_1 = skin.ears_1, ears_2 = skin.ears_2
				})
			end)
			isEarOn = true
		end
	else
		if isEarOn == true then
            TriggerEvent('skinchanger:getSkin', function(skin)
                 startAnim("mp_cp_stolen_tut", "b_think")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadClothes', skin, notSoMaleSkin)
			end)
			isEarOn = false
		else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                 startAnim("mp_cp_stolen_tut", "b_think")
				 Citizen.Wait(1000)
				TriggerEvent('skinchanger:loadSkin', {
					sex = 1,
					ears_1 = skin.ears_1, ears_2 = skin.ears_2
				})
			end)
			isEarOn = true
		end
	end
end)


local enable = false
function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable
 
        if enable then
	SetTimecycleModifier("BloomMid")
            SendNUIMessage({
                action = 'open'
            })
        else
    	SetTimecycleModifier("")
    	SetTransitionTimecycleModifier("")
            SendNUIMessage({
                action = 'close'
            })
        end
   
end


RegisterNUICallback('hat', function(data, cb)
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
      
    TriggerEvent('hat')
     

end)

RegisterNUICallback('mask', function(data, cb)
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
      
    TriggerEvent('mask')
     

end)


RegisterNUICallback('glasses', function(data, cb)
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
      
    TriggerEvent('glasses')
     

end)

RegisterNUICallback('ear', function(data, cb)
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
      
    TriggerEvent('ear')
     

end)


RegisterNUICallback('torso', function(data, cb)
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
      
    TriggerEvent('torso')
     

end)
RegisterNUICallback('pants', function(data, cb)
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
      
    TriggerEvent('pants')
     

end)

RegisterNUICallback('shoes', function(data, cb)
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
      
    TriggerEvent('shoes')
     

end)

RegisterNUICallback('escape', function(data, cb)
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
      
    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())

end)


AddEventHandler('onResourceStop', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end
 
     
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
 
 
        if IsControlJustPressed(1, 311) then
            if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
			toggleField(true)
		elseif IsControlJustReleased(1, 311) then
			 
            end
        end
    end
end)


RegisterCommand("cursor", function(source, args, rawCommand)
SetNuiFocus(1, 1)
	end,
 false)

RegisterCommand("nocursor", function(source, args, rawCommand)
SetNuiFocus(0, 0)
	end,
 false)

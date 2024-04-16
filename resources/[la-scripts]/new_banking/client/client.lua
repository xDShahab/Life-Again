--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX                         = nil
inMenu                      = false
local isnearBank, isnearATM = false, false
local showblips = true
local atbank = true
local bankMenu = true
local condition, blocked = false, false

local banks = {
  {name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
  {name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
  {name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Bank", id=108, x=241.727, y=220.706, z=106.286},
  {name="Bank", id=108, x=1175.0643310547, y=2706.6435546875, z=38.094036102295}
}	
--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


RegisterNetEvent('new_banking:disableforhour')
AddEventHandler('new_banking:disableforhour', function(pos, time)
  local condition = true
  SetTimeout(time, function()
    condition = false
    blocked = false
  end)
  Citizen.CreateThread(function()
    while condition do
      Citizen.Wait(5000)
      local playerloc = GetEntityCoords(GetPlayerPed(-1))
      local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc, false)
      if distance <= 80.0 then
        blocked = true
      else
        blocked = false
      end
    end
  end)
end)

--===============================================
--==             Core Threading                ==
--===============================================
Citizen.CreateThread(function()
	while true do
		if (isnearATM or isnearBank) and not inMenu then
			Citizen.Wait(10)
			DisplayHelpText("Press ~INPUT_PICKUP~ to access the bank ")
		else
			Citizen.Wait(1000)
		end
	end
end)

AddEventHandler("onKeyDown", function(key)
	if not (isnearATM or isnearBank) then
		return
	end

	if key == "e" and not inMenu then
			inMenu = true
			SetNuiFocus(true, true)
			SendNUIMessage({type = 'openGeneral', bank = isnearBank})
			TriggerServerEvent('bank:balance')
	elseif key == "escape" and inMenu then
			inMenu = false
			SetNuiFocus(false, false)
			SendNUIMessage({type = 'close'})
	end
end)

--===============================================
--==             Optimize Indicator               ==
--===============================================
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)

	  if nearBank() then isnearBank = true else isnearBank = false end
	  if nearATM() then isnearATM = true else isnearATM = false end

	end
end)

function nearBank()
	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 3.5 then
			return true
		end
	end
end

local atms  = {  
	GetHashKey("prop_atm_01"),
	GetHashKey("prop_atm_02"),
	GetHashKey("prop_atm_03"),
	GetHashKey("prop_fleeca_atm")
}
function nearATM()
	local coords = GetEntityCoords(PlayerPedId())

	for i,v in ipairs(atms) do
		local atm = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, v, false, false, false)
		if DoesEntityExist(atm) then
			return true
		end
	end
	
	return false
end

--===============================================
--==             Map Blips	                   ==
--===============================================
Citizen.CreateThread(function()
	if showblips then
	  for k,v in ipairs(banks)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 500)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(tostring(v.name))
		EndTextCommandSetBlipName(blip)
		SetBlipColour(blip, 2)
	  end
	end
end)



--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:depasit', tonumber(data.amount))
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:withdrow', tonumber(data.amountw))
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)

	SendNUIMessage({type = 'balanceReturn', bal = balance})

end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transferer', data.to, data.amountt)
	
end)




--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
  FreezeEntityPosition(PlayerPedId(), false)
  PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
  inMenu = false
  SetNuiFocus(false, false)
  SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

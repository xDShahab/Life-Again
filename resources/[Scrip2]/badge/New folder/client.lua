ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

  local owned = false
local currentTags = {}
  local owned2 = false
local currentTags2 = {}
  RegisterNetEvent('policebad:tag')
AddEventHandler('policebad:tag',function(own)
    owned = own
end)
RegisterNetEvent('policebad:set_tags')
AddEventHandler('policebad:set_tags', function (admins)
    currentTags = admins
end)
function SetVehiclePlate(platesh,vehicle)
	local props = {
		plate = platesh,
	}
	

	ESX.Game.SetVehicleProperties(vehicle, props)
end
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
RegisterNetEvent('Aliatunit:setplate')
AddEventHandler('Aliatunit:setplate', function (unit)
local player = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(player)) then
	saveVehicle = GetVehiclePedIsIn(player, true)
	local vehicle = saveVehicle
	targetBlip = AddBlipForEntity(vehicle)
					SetBlipSprite(targetBlip, 41)
					SetBlipDisplay(targetBlip, 4)
					SetBlipScale(targetBlip, 0.8)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(unit) -- set blip's "name"
					EndTextCommandSetBlipName(targetBlip)
	SetVehiclePlate(unit,vehicle)
	ShowNotification("Unit Shoma Be Onvane Pelak Tanzim Shod ("..unit..")")
	end
	
end)

  RegisterNetEvent('policebad2:tag')
AddEventHandler('policebad2:tag',function(own)
    owned2 = own
end)
RegisterNetEvent('policebad2:set_tags')
AddEventHandler('policebad2:set_tags', function (admins)
    currentTags2 = admins
end)

   Citizen.CreateThread(function ()


        while true do
            Citizen.Wait(0)
    
            local currentPed = PlayerPedId()
            local currentPos = GetEntityCoords(currentPed)
    
            local cx,cy,cz = table.unpack(currentPos)
            cz = cz + 1.0
             local label = ""	
		
             if owned then

             end
    
            for k, v in pairs(currentTags) do
				local targetped_network = v.ped_NETWORK
				local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
				if senderplayerPed and DoesEntityExist(senderplayerPed) then
					local adminPed = GetPlayerPed(GetPlayerFromServerId(v.source))
					local adminCoords = GetEntityCoords(adminPed)
					local x,y,z = table.unpack(adminCoords)
					z = z + 1.0
		
					local distance = GetDistanceBetweenCoords(vector3(cx,cy,cz), vector3(x,y,z), true)
					
					if label then
						if distance < 2 and v.hide == false and GetPlayerServerId(PlayerId()) ~= v.source then
						local tarafejelo = GetPlayerFromServerId(v.source)
						  ESX.Game.Utils.DrawText3D(vector3(x,y,z), label.."#"..v.add.." ".. v.jobgrade, 0.7)
						end
					end
                end
            end
        end
    
    end)
	Citizen.CreateThread(function ()


        while true do
            Citizen.Wait(0)
    
            local currentPed = PlayerPedId()
            local currentPos = GetEntityCoords(currentPed)
    
            local cx,cy,cz = table.unpack(currentPos)
            cz = cz + 1.0
             local label = ""	
		
             if owned2 then

             end
    
            for k, v in pairs(currentTags2) do
				local targetped_network = v.ped_NETWORK
				local senderplayerPed = NetworkDoesEntityExistWithNetworkId(targetped_network) and NetworkGetEntityFromNetworkId(targetped_network) or nil
				if senderplayerPed and DoesEntityExist(senderplayerPed) then
					local adminPed = GetPlayerPed(GetPlayerFromServerId(v.source))
					local adminCoords = GetEntityCoords(adminPed)
					local x,y,z = table.unpack(adminCoords)
					z = z + 1.0
		
					local distance = GetDistanceBetweenCoords(vector3(cx,cy,cz), vector3(x,y,z), true)
					
					if label then
						if distance < 2 and v.hide == false and GetPlayerServerId(PlayerId()) ~= v.source then
						local tarafejelo = GetPlayerFromServerId(v.source)
						  ESX.Game.Utils.DrawText3D(vector3(x,y,z), label.."#"..v.add.." ".. v.jobgrade, 0.7)
						end
					end
                end
            end
        end
    
    end)

function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.80*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
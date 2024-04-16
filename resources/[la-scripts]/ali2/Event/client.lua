

local event = false


ESX                = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    --Holograms()
    --KeyControl()
end)

local quitcoord = {x = -1341.34, y = -1428.8, z = 4.31}

local weaponcoord = {x = -1356.0, y = -1436.06, z = 4.32}

local showlistcoord = {x = -1354.99, y = -1427.46, z = 4.32}

local parking = {x = -339.57, y = -904.33, z = 31.08}

local event =  {x = -1351.17, y = -1434.88, z = 4.32}


function Weapon()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(coords, -1356.0, -1436.06, 4.32, false) < 2 then
        return true
    end
    return false
end

function Quit()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(coords, -1341.34, -1428.8, 4.31, false) < 2 then
        return true
    end
    return false
end


function Show()
    local coords = GetEntityCoords(GetPlayerPed(-1))
    if GetDistanceBetweenCoords(coords, -1354.99, -1427.46, 4.32, false) < 2 then
        return true
    end
    return false
end
--[[
function Holograms()
    while true do
        Citizen.Wait(5)
        if event then
            if GetDistanceBetweenCoords(-1354.99, -1427.46, 4.32 , GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 or GetDistanceBetweenCoords(-1341.34, -1428.8, 4.31 , GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 or GetDistanceBetweenCoords(-1356.0, -1436.06, 4.32 , GetEntityCoords(GetPlayerPed(-1)), false) < 10.0 then
                local coloralireza2 = { r = 700, g = 2, b = 2 }
                ESX.ShowMissionText('~h~In Event')
                DrawMarker(41, -1354.99, -1427.46, 4.32, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.7, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
                DrawMarker(36, -1341.34, -1428.8, 4.31, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.7, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
                DrawMarker(31, -1356.0, -1436.06, 4.32, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.7, coloralireza2.r, coloralireza2.g, coloralireza2.b, 100, false, true, 2, false, false, false, false)
            end
        end

    end	             
end
]]

function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end





AddEventHandler('onKeyUP', function(control)
	if control == 'e' then
        if Weapon() then
            openweapon()
        elseif Quit() then
            Openquitmenu()
        elseif Show() then
            shopplayer()
        end
    elseif control == 'back' then
        if Weapon() or Quit() or Show() then
           ESX.UI.Menu.CloseAll()
        end
    end
end)


function openweapon()
    local elements = { 
        {label = '<b><span style="color:Green;">Get Armor</span></b>',    value = '1'},
       
    }

    
    ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'kos',
    {
        title    = ('Give Event Reward'),
        align    = 'center',
        elements = elements,
    },

    function(data, menu)
        if data.current.value == '1' then
            local ped = GetPlayerPed(-1)
            SetPedArmour(ped, 100) 
            ESX.ShowNotification('Shoam Armor Event Poshidid')
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                  local clothesSkin = {
                    ['bproof_1'] = 9,  ['bproof_2'] = 3,
                  }
                  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                elseif skin.sex == 1 then
                  local clothesSkin = {
                    ['bproof_1'] = 3,  ['bproof_2'] = 1,
                  }
                  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                end
            end)
            
            ESX.UI.Menu.CloseAll()
        elseif data.current.value == '2' then
            addweapon('weapon_pistol', 250)
            ESX.ShowNotification('Shoam Az Event Yek Pistol Gereftid')
            ESX.UI.Menu.CloseAll()
        end
    end)
end


function addweapon(weaponname, ammo)
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
end



function Openquitmenu()
    local elements = { 
        {label = '<b><span style="color:Green;">Are</span></b>',    value = '1'},
        {label = '<b><span style="color:Red;">Enseraf</span></b>',   value = '2'},
    }

    
    ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'kos',
    {
        title    = ('Aya Mikhahid Az Event Exit Knid?'),
        align    = 'center',
        elements = elements,
    },

    function(data, menu)
        if data.current.value == '1' then
            TriggerEvent('At:quitevent')
            ESX.UI.Menu.CloseAll()
        elseif data.current.value == '2' then
            ESX.UI.Menu.CloseAll()
        end
    end)
end



function shopplayer()

    ESX.TriggerServerCallback('At:Get_Ineventplayer', function(online)
        local elements = { 
            {label = '<b><span style="color:yellow;">Online Player In Event : '..online..'</span></b>',    value = 'alireza'},
        }
    
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'aasdBasdahaadasdama_Masdadsenu',
            {
              title    = ('Event Menu'),
              align    = 'center',
              elements = elements,
            },
    
            function(data, menu)
                if data.current.value then
                    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                end
            end
        )
    end)

end


RegisterNetEvent('At:quitevent')
AddEventHandler('At:quitevent', function()
    event = false
    ESX.TriggerServerCallback('esx_skin:getGangSkin', function(skin, gangSkin)
        if GetPedArmour(GetPlayerPed(-1)) > 0 then
            SetPedArmour(GetPlayerPed(-1),0)
        end
        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)
    TriggerEvent('esx_ambulancejob:reviveaveralireza')	
    TriggerEvent("mythic_progbar:client:progress", {
        name = "alireza_at",
        duration = 4000,
        label = "",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = true,
            disableCombat = true,
        },
    })
    Citizen.Wait(3000)
    TriggerServerEvent('Cs:Changeeloadout0', GetPlayerServerId(PlayerId()))
    Citizen.Wait(1000)
    TriggerEvent('Alireza_WhiteList', source)
    SetEntityCoords(PlayerPedId(), -339.57, -904.33, 31.08)
    TriggerEvent('es_admin:freezePlayer', true)
    Citizen.Wait(2000)
    TriggerEvent('es_admin:freezePlayer', false)
end)



RegisterNetEvent('At:gotoevent')
AddEventHandler('At:gotoevent', function(metod)
    if event then
        event =  true
        SwitchOutPlayer(PlayerPedId(),0,1) 
        TriggerEvent('esx_ambulancejob:reviveaveralireza')	
        Skin()
        TriggerEvent("mythic_progbar:client:progress", {
            name = "alireza_at",
            duration = 6000,
            label = "Joining..",
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true,
            },
        })
        Citizen.Wait(3000)
        TriggerServerEvent('Cs:Changeeloadout2', GetPlayerServerId(PlayerId()))
        Citizen.Wait(1000)
        TriggerEvent('Alireza_WhiteList', source)
        SetEntityCoords(PlayerPedId(), -1351.17, -1434.88,4.32)
        TriggerEvent('es_admin:freezePlayer', true)
        SwitchInPlayer(PlayerPedId())
        Citizen.Wait(2000)
        TriggerEvent('es_admin:freezePlayer', false)
        ESX.ShowNotification('Shoam Join Event Shodid')
    else
        ESX.ShowNotification('Shoam Nemitavanid Mojadad Join Shavid')
    end
end)





function Skin()
    TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then --Lebas Pesar
          local clothesSkin = {
              ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
              ['torso_1'] = 141,   ['torso_2'] = 0,
              ['decals_1'] = 0,   ['decals_2'] = 0,
              ['arms'] = 184,
              ['pants_1'] = 75,   ['pants_2'] = 0,
              ['shoes_1'] = 39,   ['shoes_2'] = 0,
              ['helmet_1'] = -1,  ['helmet_2'] = 0,
              ['glasses_1'] = 0,  ['glasses_2'] = 0,
              ['chain_1'] = 0,    ['chain_2'] = 0,
              ['ears_1'] = 0,     ['ears_2'] = 0,
              ['mask_1'] = 43,   ['mask_2'] = 0,
              ['bproof_1'] = 0,  ['bproof_2'] = 0
          }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
  
      else ---Lebas Dokhtar
          local clothesSkin = {
              ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
              ['torso_1'] = 101,   ['torso_2'] = 13,
              ['decals_1'] = 0,   ['decals_2'] = 0,
              ['arms'] = 31,
              ['pants_1'] = 90,   ['pants_2'] = 1,
              ['shoes_1'] = 49,   ['shoes_2'] = 0,
              ['helmet_1'] = -1,  ['helmet_2'] = 0,
              ['glasses_1'] = 0,  ['glasses_2'] = 0,
              ['chain_1'] = 0,    ['chain_2'] = 0,
              ['ears_1'] = 0,     ['ears_2'] = 0,
              ['mask_1'] = 22,   ['mask_2'] = 0,
              ['bproof_1'] = 0,  ['bproof_2'] = 0
          }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin) 
      end
  end)
  end
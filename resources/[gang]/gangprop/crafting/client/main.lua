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



ESX                             = nil


Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)



RegisterNetEvent('Openmen:crafting_level')
AddEventHandler('Openmen:crafting_level', function()
    OpenMenus()

end)





function OpenMenus()
  local elements = {}
  ESX.TriggerServerCallback('At_Craftiing:Getganglevel', function(Level)
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 0==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Pistol', value = 'weapon_pistol'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 1==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Pistol 50', value = 'weapon_pistol50'})
      table.insert(elements, {label = 'Smg', value = 'weapon_smg'})
      table.insert(elements, {label = 'Assaultsmg', value = 'weapon_assaultsmg'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 2==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Carbine Rifle', value = 'weapon_carbinerifle'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 3==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Bullpup Rifle', value = 'weapon_bullpuprifle'})
      --table.insert(elements, {label = 'LSD', value = 'lsd'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 4==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Gusenberg', value = 'weapon_gusenberg'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 5==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Minismg', value = 'weapon_minismg'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 6==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Switchblade', value = 'weapon_switchblade'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 7==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Flashlight', value = 'weapon_flashlight'})
      table.insert(elements, {label = 'Knuckle', value = 'weapon_knuckle'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 8==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Machete', value = 'weapon_machete'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 9==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Microsmg', value = 'weapon_microsmg'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 10==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Combatpdw', value = 'weapon_combatpdw'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 11==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Assaultshotgun', value = 'weapon_assaultshotgun'})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 12==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Advancedrifle ', value = 'weapon_advancedrifle '})
      table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 13==========</span></b>', value = '....'})
      table.insert(elements, {label = 'Assaultrifle', value = 'weapon_assaultrifle'})
      --table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 14==========</span></b>', value = '....'})
      --table.insert(elements, {label = 'Combatmg', value = 'weapon_combatmg'})
      --table.insert(elements, {label = '<b><span style="color:yellow;">========== Level 15==========</span></b>', value = '....'})
      --table.insert(elements, {label = 'Mg', value = 'weapon_mg'})

  
      
      ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'Crafts_Menu',
          {
            title    = ('Level Gang Shoma '..Level),
            align    = 'center',
            elements = elements,
          },
  
          function(data, menu)
              local label = data.current.value
              if  data.current.value == 'weapon_pistol' then
                  if Level >= 0 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_pistol50' then
                  if Level >= 1 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_smg' then
                  if Level >= 1 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_assaultsmg' then
                  if Level >= 1 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_carbinerifle' then
                  if Level >= 2 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_bullpuprifle' then
                  if Level >= 3 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
                elseif data.current.value == 'lsd' then
                    if Level >= 3 then
                        nexmenu(label)
                    else
                        ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                    end
                
              elseif  data.current.value == 'weapon_gusenberg' then
                  if Level >= 4 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_minismg' then
                  if Level >= 5 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_switchblade' then  
                  if Level >= 6 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_flashlight' then
                  if Level >= 7 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_knuckle' then
                  if Level >= 7 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_machete' then
                  if Level >= 8 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_microsmg' then
                  if Level >= 9 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_combatpdw' then
                  if Level >= 10 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_assaultshotgun' then
                  if Level >= 11 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_assaultrifle' then
                  if Level >= 12 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_combatmg' then
                  if Level >= 13 then
                      nexmenu(label)
                  else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
              elseif  data.current.value == 'weapon_mg' then
                    if Level >= 14 then
                      nexmenu(label)
                    else
                      ESX.ShowNotification('Level Gang Shoma Kafi Nist')
                  end
          end
          end)
  end)
  

end


function nexmenu(label)
  local elements = { 
      {label = 'Yes',    value = 'yes'},
      {label = 'No',   value = 'no'},
  }

  
  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'craftin_gmenu',
  {
      title    = ('Weapon :'..label.. ' Ehtemal Shekast (10%)'),
      align    = 'center',
      elements = elements,
  },

  function(data, menu)
      if data.current.value == 'no' then
          OpenMenus()
      elseif data.current.value == 'yes' then
          if  label == 'weapon_pistol' then 
              TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 45)
          elseif  label == 'weapon_pistol50' then
              TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 65)
          elseif label == 'lsd' then
            TriggerServerEvent('At_Crafting:Additem', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 65)
          elseif  label == 'weapon_smg' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 75)
          elseif  label == 'weapon_assaultsmg' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 85)
          elseif  label == 'weapon_carbinerifle' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 95)
          elseif  label == 'weapon_bullpuprifle' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 105)
          elseif  label == 'weapon_gusenberg' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 115)
          elseif  label == 'weapon_minismg' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 125)
          elseif  label == 'weapon_switchblade' then  
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 135)
          elseif  label == 'weapon_flashlight' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 145)
          elseif  label == 'weapon_knuckle' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 155)
          elseif  label == 'weapon_machete' then
              TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron',  165)
          elseif  label == 'weapon_microsmg' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 175)
          elseif  label == 'weapon_combatpdw' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 185)
          elseif  label == 'weapon_assaultshotgun' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 195)
          elseif  label == 'weapon_assaultrifle' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 205)
          elseif  label == 'weapon_combatmg' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 215)
          elseif  label == 'weapon_mg' then
            TriggerServerEvent('AT_Crafting:Addweapon', GetPlayerServerId(PlayerId()), label , 'gold', 'iron', 225)
          end
          ESX.UI.Menu.CloseAll()
      end
  end)
end




RegisterNetEvent('craftingweaponstart')



AddEventHandler('craftingweaponstart',function(name)
  ESX.ShowMissionText('Craft Start Shod')
    TriggerEvent("mythic_progbar:client:progress", {
        name = "alireza_at",
        duration = 10000,
        label = "Dar Hal Craft...",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    })
  --exports['progressBars']:startUI(10000, "Dar Hal Craft...")
  loadanimdict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@')
  TaskPlayAnim(PlayerPedId(), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 8.0, 1.0, -1, 49, 0, 0, 0, 0)
  Citizen.Wait(10000)
  StopAnimTask(PlayerPedId(), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', '001215_02_trvs_12_escorted_out_idle_guard2', 1.0)
  ClearPedSecondaryTask(PlayerPedId())
  exports['okokNotify']:Alert("SUCCESS", "Craft Done", 5000, 'success')
 --TriggerServerEvent('At_Craftingveri', name)
end)






function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end


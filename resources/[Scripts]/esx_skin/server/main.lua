ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function(skin)

  local xPlayer = ESX.GetPlayerFromId(source)

  exports.ghmattimysql:execute(
    'UPDATE users SET `skin` = @skin WHERE identifier = @identifier',
    {
      ['@skin']       = json.encode(skin),
      ['@identifier'] = xPlayer.identifier
    }
  )

end)

RegisterServerEvent('esx_skin:responseSaveSkin')
AddEventHandler('esx_skin:responseSaveSkin', function(skin)

  local file = io.open('resources/[esx]/esx_skin/skins.txt', "a")

  file:write(json.encode(skin) .. "\n\n")
  file:flush()
  file:close()

end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)

  local xPlayer = ESX.GetPlayerFromId(source)

  exports.ghmattimysql:execute(
    'SELECT * FROM users WHERE identifier = @identifier',
    {
      ['@identifier'] = xPlayer.identifier
    },
    function(users)

      local user = users[1]
      local skin = nil

      local jobSkin = {
        skin_male   = xPlayer.job.skin_male,
        skin_female = xPlayer.job.skin_female
      }

      if user.skin ~= nil then
        skin = json.decode(user.skin)
      end

      cb(skin, jobSkin)

    end
  )

end)

-- Commands
RegisterCommand('skin', function(source, args)

  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.permission_level > 3 then
    if xPlayer.get('aduty') then
    
      if args[1] then

        TriggerClientEvent('esx_skin:openSaveableMenu', args[1])

      else

        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Id Player Vared Nakardid Dadash")
    
    
      end

    else
      TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma Dar Halat Offduty Hastid")

    end

  else

    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!")


  end

end, false)

RegisterCommand('saveskin', function(source)

  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer.permission_level > 8 then

    TriggerClientEvent('esx_skin:requestSaveSkin', source)

  else

    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!")


  end

end, false)

RegisterCommand('changevest', function(source, args)

  local xPlayer = ESX.GetPlayerFromId(source)

      if xPlayer.permission_level > 8 then

        if args[1] and args[2] then

          if tonumber(args[1]) and tonumber(args[2]) then

            local skinone, skintwo = tonumber(args[1]), tonumber(args[2])

            TriggerClientEvent('esx_skin:changeVest', source, skinone, skintwo)
          
          else

            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0shoma dar ghesmat value faghat mitavanid adad vared konid!")


          end

        else

          TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Syntax vared shode eshbteh ast!")


        end


      else

        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!")

      end

end, false)
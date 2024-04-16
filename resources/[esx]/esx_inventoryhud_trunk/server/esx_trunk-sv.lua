ESX = nil
local arrayWeight = Config.localWeight
local VehicleList = {}
local VehicleInventory = {}
local warn1 = false
local warn2 = false
local warn3 = false

TriggerEvent(
  "esx:getSharedObject",
  function(obj)
    ESX = obj
  end
)

AddEventHandler(
  "onMySQLReady",
  function()
    MySQL.Async.execute("DELETE FROM `trunk_inventory` WHERE `owned` = 0", {})
  end
)

RegisterServerEvent("esx_trunk_inventory:getOwnedVehicule")
AddEventHandler(
  "esx_trunk_inventory:getOwnedVehicule",
  function()
    local vehicules = {}
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll(
      "SELECT * FROM owned_vehicles WHERE owner = @owner",
      {
        ["@owner"] = xPlayer.identifier
      },
      function(result)
        if result ~= nil and #result > 0 then
          for _, v in pairs(result) do
            local vehicle = json.decode(v.vehicle)
            table.insert(vehicules, {plate = vehicle.plate})
          end
        end
        TriggerClientEvent("esx_trunk_inventory:setOwnedVehicule", _source, vehicules)
      end
    )
  end
)

function getItemWeight(item)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
    itemWeight = Config.DefaultWeight
    if arrayWeight[item] ~= nil then
      itemWeight = arrayWeight[item]
    end
  end
  return itemWeight
end

function getInventoryWeight(inventory)
  local weight = 0
  local itemWeight = 0
  if inventory ~= nil then
    for i = 1, #inventory, 1 do
      if inventory[i] ~= nil then
        itemWeight = Config.DefaultWeight
        if arrayWeight[inventory[i].name] ~= nil then
          itemWeight = arrayWeight[inventory[i].name]
        end
        weight = weight + (itemWeight * (inventory[i].count or 1))
      end
    end
  end
  return weight
end

function getTotalInventoryWeight(plate)
  local total
  if not plate then
    return
  end
  TriggerEvent(
    "esx_trunk:getSharedDataStore",
    plate,
    function(store)
      local W_weapons = getInventoryWeight(store.get("weapons") or {})
      local W_coffre = getInventoryWeight(store.get("coffre") or {})
      local W_blackMoney = 0
      local blackAccount = (store.get("black_money")) or 0
      if blackAccount ~= 0 then
        W_blackMoney = blackAccount[1].amount / 10
      end
      total = W_weapons + W_coffre + W_blackMoney
    end
  )
  return total
end

ESX.RegisterServerCallback(
  "esx_trunk:getInventoryV",
  function(source, cb, plate)
    if not plate then
      return
    end
    TriggerEvent(
      "esx_trunk:getSharedDataStore",
      plate,
      function(store)
        local blackMoney = 0
        local items = {}
        local weapons = {}
        weapons = (store.get("weapons") or {})

        local blackAccount = (store.get("black_money")) or 0
        if blackAccount ~= 0 then
          blackMoney = blackAccount[1].amount
        end

        local coffre = (store.get("coffre") or {})
        for i = 1, #coffre, 1 do
          table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
        end

        local weight = getTotalInventoryWeight(plate)
        cb(
          {
            blackMoney = blackMoney,
            items = items,
            weapons = weapons,
            weight = weight
          }
        )
      end
    )
  end
)

RegisterServerEvent("esx_trunk:getItem")
AddEventHandler(
  "esx_trunk:getItem",
  function(plate, type, item, count, max, owned)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not plate then
      return
    end
    if type == "item_standard" then
      local targetItem = xPlayer.getInventoryItem(item)
      if targetItem.limit == -1 or ((targetItem.count + count) <= targetItem.limit) then
        TriggerEvent(
          "esx_trunk:getSharedDataStore",
          plate,
          function(store)
            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                if (coffre[i].count >= count and count > 0) then
                  xPlayer.addInventoryItem(item, count)
                  if (coffre[i].count - count) == 0 then
                    table.remove(coffre, i)
                  else
                    coffre[i].count = coffre[i].count - count
                  end

                  break
                else
                  TriggerClientEvent(
                    "pNotify:SendNotification",
                    _source,
                    {
                      text = _U("invalid_quantity"),
                      type = "error",
                      queue = "trunk",
                      timeout = 3000,
                      layout = "bottomCenter"
                    }
                  )
                end
              end
            end

            store.set("coffre", coffre)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeight(plate)

            text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
          end
        )
      else
        TriggerClientEvent(
          "pNotify:SendNotification",
          _source,
          {
            text = _U("player_inv_no_space"),
            type = "error",
            queue = "trunk",
            timeout = 3000,
            layout = "bottomCenter"
          }
        )
      end
    end

    if type == "item_account" then
      TriggerEvent(
        "esx_trunk:getSharedDataStore",
        plate,
        function(store)
          local blackMoney = store.get("black_money")
          if (blackMoney[1].amount >= count and count > 0) then
            blackMoney[1].amount = blackMoney[1].amount - count
            store.set("black_money", blackMoney)
            xPlayer.addAccountMoney(item, count)

            local blackMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeight(plate)

            text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
          else
            TriggerClientEvent(
              "pNotify:SendNotification",
              _source,
              {
                text = _U("invalid_amount"),
                type = "error",
                queue = "trunk",
                timeout = 3000,
                layout = "bottomCenter"
              }
            )
          end
        end
      )
    end

    if type == "item_weapon" then
      TriggerEvent(
        "esx_trunk:getSharedDataStore",
        plate,
        function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          local weaponName = nil
          local ammo = nil

          for i = 1, #storeWeapons, 1 do
            if storeWeapons[i].name == item then
              weaponName = storeWeapons[i].name
              ammo = storeWeapons[i].ammo

              table.remove(storeWeapons, i)

              break
            end
          end

          store.set("weapons", storeWeapons)

          xPlayer.addWeapon(weaponName, ammo)

          local blackMoney = 0
          local items = {}
          local weapons = {}
          weapons = (store.get("weapons") or {})

          local blackAccount = (store.get("black_money")) or 0
          if blackAccount ~= 0 then
            blackMoney = blackAccount[1].amount
          end

          local coffre = (store.get("coffre") or {})
          for i = 1, #coffre, 1 do
            table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
          end

          local weight = getTotalInventoryWeight(plate)

          text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
          data = {plate = plate, max = max, myVeh = owned, text = text}

          local testArray = {
            {
              ["color"] = "8421504",
              ["title"] = "Trunk 🔫 Weapon Log ",
              ["description"] = "ID: **(".._source..")**\nPlayer Name: **"..GetPlayerName(_source).."**",
              ["fields"] = {
                {
                  ["name"] = "Car Plate:",
                  ["value"] = "**"..plate.."**"
                },
                {
                  ["name"] = "Weapon name:",
                  ["value"] = "**"..weaponName.."**"
                },
                {
                  ["name"] = "Ammo:",
                  ["value"] = "**"..ammo.."**"
                },
                {
                  ["name"] = "Time:",
                  ["value"] = "**"..os.date('%Y-%m-%d %H:%M:%S').."**"
                }
              },
              ["footer"] = {
              ["text"] = "Log System",
              ["icon_url"] = "https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/914270162490896414/921039969676562512/500x506_1558104453854225.jpg",
              }
            }
          }
          TriggerEvent('DiscordBot:ToDiscord', "trunkinvget", SystemName, testArray,'system', source, false, false)   


          TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
        end
      )
    end
  end
)

RegisterServerEvent("esx_trunk:putItem")
AddEventHandler(
  "esx_trunk:putItem",
  function(plate, type, item, count, max, owned, label)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)
    if not plate then
      return
    end
    if type == "item_standard" then
      local playerItemCount = xPlayer.getInventoryItem(item).count

      if (playerItemCount >= count and count > 0) then
        TriggerEvent(
          "esx_trunk:getSharedDataStore",
          plate,
          function(store)
            local found = false
            local coffre = (store.get("coffre") or {})

            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                coffre[i].count = coffre[i].count + count
                found = true
              end
            end
            if not found then
              table.insert(
                coffre,
                {
                  name = item,
                  count = count
                }
              )
            end
            if (getTotalInventoryWeight(plate) + (getItemWeight(item) * count)) > max then
              TriggerClientEvent(
                "pNotify:SendNotification",
                _source,
                {
                  text = _U("insufficient_space"),
                  type = "error",
                  queue = "trunk",
                  timeout = 3000,
                  layout = "bottomCenter"
                }
              )
            else
              -- Checks passed, storing the item.
              store.set("coffre", coffre)
              xPlayer.removeInventoryItem(item, count)

              MySQL.Async.execute(
                "UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate",
                {
                  ["@plate"] = plate,
                  ["@owned"] = owned
                }
              )
            end
          end
        )
      else
        TriggerClientEvent(
          "pNotify:SendNotification",
          _source,
          {
            text = _U("invalid_quantity"),
            type = "error",
            queue = "trunk",
            timeout = 3000,
            layout = "bottomCenter"
          }
        )
      end
    end

    if type == "item_account" then
      local playerAccountMoney = xPlayer.getAccount(item).money

      if (playerAccountMoney >= count and count > 0) then
        TriggerEvent(
          "esx_trunk:getSharedDataStore",
          plate,
          function(store)
            local blackMoney = (store.get("black_money") or nil)
            if blackMoney ~= nil then
              blackMoney[1].amount = blackMoney[1].amount + count
            else
              blackMoney = {}
              table.insert(blackMoney, {amount = count})
            end

            if (getTotalInventoryWeight(plate) + blackMoney[1].amount / 10) > max then
              TriggerClientEvent(
                "pNotify:SendNotification",
                _source,
                {
                  text = _U("insufficient_space"),
                  type = "error",
                  queue = "trunk",
                  timeout = 3000,
                  layout = "bottomCenter"
                }
              )
            else
              -- Checks passed. Storing the item.
              xPlayer.removeAccountMoney(item, count)
              store.set("black_money", blackMoney)

              MySQL.Async.execute(
                "UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate",
                {
                  ["@plate"] = plate,
                  ["@owned"] = owned
                }
              )
            end
          end
        )
      else
        TriggerClientEvent(
          "pNotify:SendNotification",
          _source,
          {
            text = _U("invalid_amount"),
            type = "error",
            queue = "trunk",
            timeout = 3000,
            layout = "bottomCenter"
          }
        )
      end
    end

    if type == "item_weapon" then
      TriggerEvent(
        "esx_trunk:getSharedDataStore",
        plate,
        function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          table.insert(
            storeWeapons,
            {
              name = item,
              label = label,
              ammo = count
            }
          )
          if (getTotalInventoryWeight(plate) + (getItemWeight(item))) > max then
            TriggerClientEvent(
              "pNotify:SendNotification",
              _source,
              {
                text = _U("invalid_amount"),
                type = "error",
                queue = "trunk",
                timeout = 3000,
                layout = "bottomCenter"
              }
            )
          else
            xPlayer.removeWeapon(item)
            store.set("weapons", storeWeapons)
            chekplayerwarn(_source, 'Mashkok Be  Doubli Zadan Weapon ! !')
            local testArray = {
              {
                ["color"] = "8421504",
                ["title"] = "Trunk 🔫 Weapon Log ",
                ["description"] = "ID: **(".._source..")**\nPlayer Name: **"..GetPlayerName(_source).."**",
                ["fields"] = {
                  {
                    ["name"] = "Car Plate:",
                    ["value"] = "**"..plate.."**"
                  },
                  {
                    ["name"] = "Weapon name:",
                    ["value"] = "**"..item.."**"
                  },
                  {
                    ["name"] = "Ammo:",
                    ["value"] = "**"..count.."**"
                  },
                  {
                    ["name"] = "Time:",
                    ["value"] = "**"..os.date('%Y-%m-%d %H:%M:%S').."**"
                  }
                },
                ["footer"] = {
                ["text"] = "Log System",
                ["icon_url"] = "https://https://cdn.discordapp.com/icons/927570401113038908/a5a7daa38862d5677cba716d4388bc77.png?size=1024.com/attachments/914270162490896414/921039969676562512/500x506_1558104453854225.jpg",
                }
              }
            }
            TriggerEvent('DiscordBot:ToDiscord', "trunkinvput", SystemName, testArray,'system', source, false, false)

            MySQL.Async.execute(
              "UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate",
              {
                ["@plate"] = plate,
                ["@owned"] = owned
              }
            )
          end
        end
      )
    end

    TriggerEvent(
      "esx_trunk:getSharedDataStore",
      plate,
      function(store)
        local blackMoney = 0
        local items = {}
        local weapons = {}
        weapons = (store.get("weapons") or {})

        local blackAccount = (store.get("black_money")) or 0
        if blackAccount ~= 0 then
          blackMoney = blackAccount[1].amount
        end

        local coffre = (store.get("coffre") or {})
        for i = 1, #coffre, 1 do
          table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
        end

        local weight = getTotalInventoryWeight(plate)

        text = _U("trunk_info", plate, (weight / 1000), (max / 1000))
        data = {plate = plate, max = max, myVeh = owned, text = text}
        TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, items, weapons)
      end
    )
  end
)

ESX.RegisterServerCallback(
  "esx_trunk:getPlayerInventory",
  function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount("black_money").money
    local items = xPlayer.inventory

    cb(
      {
        blackMoney = blackMoney,
        items = items
      }
    )
  end
)

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end


function chekplayerwarn(source, msg)
  if warn1 then
   if warn2  then
     if warn3 then
        CancelEvent()
        CancelEvent()
        CancelEvent()
        CancelEvent()
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xP = ESX.GetPlayerFromId(xPlayers[i])
            if xP.permission_level > 0 then
            TriggerClientEvent('chatMessage', xPlayers[i], "", {955, 0, 0}, "[Admin-Alarm]^2 " ..GetPlayerName(source).. "^7(^3"..source.."^7) : " .. msg .. "^4")
            end
        end
        warn1 = false
        warn2 = false
        warn3 = false
      else
        warn3 = true
      end
    else
     warn2 = true
    end
  else
    warn1 = true
  end
end


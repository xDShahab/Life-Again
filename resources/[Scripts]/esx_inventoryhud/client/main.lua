local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

local trunkData = nil
local houseData = nil
local isInInventory = false
local Current_Menu = "inventory_all"
local DataConfig = {}
local Vehicle_Key = {}
local House_Key = {}
local Accessory_Items = {}
local AlreadyDroped = 0
local gangLoot = nil
ESX = nil

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

AddEventHandler('onKeyUP',function(key)
	if key == 'f2' then
			openInventory()
	end
end)

AddEventHandler('esx_inventoryhud:setGangInventory', function(gang)
    gangLoot = gang
end)    

function openInventory()
    loadPlayerInventory()
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
end

function openHouseInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "house"
        }
    )

    SetNuiFocus(true, true)
end

function openGangInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "gang"
        }
    )

    SetNuiFocus(true, true)
end

function openBoxInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "box"
        }
    )

    SetNuiFocus(true, true)
end

function openTrunkInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
end

function closeInventory()
    isInInventory = false
    houseTarget = nil
    
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
    TriggerEvent('esx_inventoryhud:MenuClosed')
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
    end
)

RegisterNUICallback("GetNearPlayersPolice", function(data, cb)
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 1.0)
    local foundPlayers = false
    local elements = {}

    for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            foundPlayers = true

            table.insert(
                elements,
                {
                    label = GetPlayerName(players[i]),
                    player = GetPlayerServerId(players[i])
                }
            )
        end
    end

    if not foundPlayers then
        exports.pNotify:SendNotification(
            {
                text = '<strong class="red-text">The players are too far away.</strong>',
                type = "error",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "inventoryhud"
            }
        )
    else
        SendNUIMessage(
            {
                action = "nearPlayers",
                foundAny = foundPlayers,
                players = elements,
                item = data.item
            }
        )
    end

    cb("ok")
end)

RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 1.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true

                table.insert(
                    elements,
                    {
                        label = GetPlayerName(players[i]),
                        player = GetPlayerServerId(players[i])
                    }
                )
            end
        end

        if not foundPlayers then
            exports.pNotify:SendNotification(
                {
                    text = '<strong class="red-text">The players are too far away.</strong>',
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
        else
            SendNUIMessage(
                {
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                }
            )
        end

        cb("ok")
    end
)

RegisterNUICallback("SetCurrentMenu", function(type, cb)
    local Value = type.type or 'inventory_all'
    
    Current_Menu = Value
    
    cb("ok")
end)

RegisterNUICallback("PutIntoTrunk", function(data, cb)
    TriggerEvent('esx_inventoryhud:closeHud',source)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        Wait(math.random(1,500))
        TriggerServerEvent("esx_trunk:putItem", trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label)
    end

    local player = PlayerPedId()
    local dict = "mp_am_hold_up"

    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
    
    TaskPlayAnim(player, dict, "purchase_beerbox_shopkeeper", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )

    Wait(500)
    loadPlayerInventory()

    cb("ok")
end)

function refreshPropertyInventory()
    ESX.TriggerServerCallback(
        "esx_property:getPropertyInventory",
        function(data)
            setHouseInventoryData(data.items, data.weapons)
        end,
        ESX.GetPlayerData().identifier
    )
end

function refreshGangInventory()
    ESX.TriggerServerCallback(
        "gangs:getGangInventory",
        function(data)
            setGangInventoryData(data.items, data.weapons)
        end
    )
end

function refreshBoxInventory()
    ESX.TriggerServerCallback("AT_Code:OpenLootMenu", function(data)
        setBoxInventoryData(data.items, data.weapons)
    end, gangLoot)
end

RegisterNUICallback("PutIntoHouse", function(data, cb)

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        Wait(math.random(1,500))
        
        TriggerServerEvent("esx_property:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
    end

    refreshPropertyInventory()
    Wait(500)
    loadPlayerInventory()

    cb("ok")
end)

RegisterNUICallback("PutIntoGang", function(data, cb)

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end

        TriggerServerEvent("gangs:addToInventory", data.item.type, data.item.name, count)
    end

    refreshGangInventory()
    Wait(500)
    loadPlayerInventory()

    cb("ok")
end)

local InDelayTrunk = false
RegisterNUICallback("TakeFromTrunk", function(data, cb)
    TriggerEvent('esx_inventoryhud:closeHud',source)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if InDelayTrunk then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        InDelayTrunk = true
        SetTimeout(3000, function()
            InDelayTrunk = false
        end)
        Wait(math.random(1, 500))
        TriggerServerEvent("esx_trunk:getItem", trunkData.plate, data.item.type, data.item.name, tonumber(data.number), trunkData.max, trunkData.myVeh)
    end

    local player = PlayerPedId()
    local dict = "mp_am_hold_up"

    RequestAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do Wait(0) end
    
    TaskPlayAnim(player, dict, "purchase_beerbox_shopkeeper", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )

    Wait(500)
    loadPlayerInventory()

    cb("ok")
end)

RegisterNUICallback("TakeFromHouse", function(data, cb)

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("esx_property:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
    end

    refreshPropertyInventory()
    Wait(500)
    loadPlayerInventory()

    cb("ok")
end)

RegisterNUICallback("TakeFromGang", function(data, cb)

    
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("gangs:getFromInventory", data.item.type, data.item.name, tonumber(data.number))
    end

    refreshGangInventory()
    Wait(500)
    loadPlayerInventory()

    cb("ok")
end)

RegisterNUICallback("TakeFromBox", function(data, cb)
    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("AT_Code:RefreshInventory", data.item.type, data.item.name, tonumber(data.number), gangLoot)
    end

    Wait(700)
    refreshBoxInventory()
    Wait(300)
    loadPlayerInventory()

    cb("ok")
end)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        if data.item.type == "item_key" then
            TriggerServerEvent("meeta_remote:ServerLock", data.item.label)
        elseif data.item.type == "item_accessories" then
            local player = PlayerPedId()

            closeInventory()
           
            if data.item.name == "helmet" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["helmet_1"] == -1 then

                        local dict = "veh@bicycle@roadfront@base"
                        local anim = "put_on_helmet"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(1000)

                        local accessorySkin = {}
                        accessorySkin['helmet_1'] = data.item.itemnum
                        accessorySkin['helmet_2'] = data.item.itemskin

                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    else

                         if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "veh@bike@common@front@base"
                            local anim = "take_off_helmet_walk"

                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['helmet_1'] = -1
                        accessorySkin['helmet_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    end
                    
                end)
            elseif data.item.name == "mask" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["mask_1"] == -1 then

                        local dict = "veh@bicycle@roadfront@base"
                        local anim = "put_on_helmet"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(1000)

                        local accessorySkin = {}
                        accessorySkin['mask_1'] = data.item.itemnum
                        accessorySkin['mask_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    else

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "veh@bike@common@front@base"
                            local anim = "take_off_helmet_walk"

                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['mask_1'] = -1
                        accessorySkin['mask_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    end
                    
                end)
            elseif data.item.name == "glasses" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["glasses_1"] == -1 then

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "clothingspecs"
                            local anim = "try_glasses_positive_a"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['glasses_1'] = data.item.itemnum
                        accessorySkin['glasses_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)

                        ClearPedTasks(player)
                    else

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "clothingspecs"
                            local anim = "take_off"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(1000)
                        end

                        local accessorySkin = {}
                        accessorySkin['glasses_1'] = -1
                        accessorySkin['glasses_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    end
                    
                end)
            elseif data.item.name == "earring" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["ears_1"] == -1 then

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "mini@ears_defenders"
                            local anim = "takeoff_earsdefenders_idle"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['ears_1'] = data.item.itemnum
                        accessorySkin['ears_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    else

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "mini@ears_defenders"
                            local anim = "takeoff_earsdefenders_idle"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['ears_1'] = -1
                        accessorySkin['ears_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    end
                    
                end)
            end

        elseif data.item.name == "headbag" then
            closeInventory()
            TriggerServerEvent("esx:useItem", data.item.name)
        else
            
            TriggerServerEvent("esx:useItem", data.item.name)
            Citizen.Wait(500)
            loadPlayerInventory()
        end
        

        cb("ok")
    end
)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if AlreadyDroped >= 3 then
            exports.pNotify:SendNotification(
                {
                    text = '<strong class="red-text">Shoma Hade aksar 3 item dar 2 Daqiqe mitonid Drop konid, Lotfan Sabr konid</strong>',
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            AlreadyDroped = AlreadyDroped + 1
            SetTimeout(120000, function()
                AlreadyDroped = AlreadyDroped - 1
            end)
            TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 1.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end

        if foundPlayer then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            -- if data.item.type == "item_key" then
            --     TriggerServerEvent("esx_inventoryhud:updateKey", data.player, data.item.type, data.item.label)
            -- elseif data.item.type == "item_keyhouse" then
            --     TriggerServerEvent("esx_inventoryhud:updateKey", data.player, data.item.type, data.item.house_id)
            -- else
                Wait(math.random(1,500))
                TriggerServerEvent("esx:giveInventoryItem", data.player, data.item.type, data.item.name, count)
            -- end
			
			local player = PlayerPedId()
            local dict = "mp_common"

            RequestAnimDict(dict)
            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
            
            TaskPlayAnim(player, dict, "givetake1_a", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )

            
            Wait(500)
            loadPlayerInventory()
        else
            exports.pNotify:SendNotification(
                {
                    text = '<strong class="red-text">The players are too far away.</strong>',
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
        end
        cb("ok")
    end
)

RegisterNUICallback(
    "GiveItemPolice",
    function(data, cb)
        local playerPed = GetPlayerServerId(PlayerId())
        local count = tonumber(data.number)

        if data.item.type == "item_weapon" then
            count = 0
        end

        if data.item.type == "item_key" then
            TriggerServerEvent('esx_policejob:confiscatePlayerItem', data.other, data.item.type, data.item.label, 1)
        elseif data.item.type == "item_keyhouse" then
            TriggerServerEvent('esx_policejob:confiscatePlayerItem', data.other, data.item.type, data.item.house_id, 1)
        else
            TriggerServerEvent('esx_policejob:confiscatePlayerItem', data.other, data.item.type, data.item.name, count)
        end
        
        Wait(500)
        loadPlayerInventoryOther(data.other, data.name1, data.name2, data.weapon, DataConfig)
        cb("ok")
    end
)

RegisterNUICallback(
    "UseMask",
    function(data, cb)

        if data.item.type == "item_accessories" then
            local player = PlayerPedId()

            closeInventory()
           
            if data.item.name == "helmet" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["helmet_1"] == -1 then

                        local dict = "veh@bicycle@roadfront@base"
                        local anim = "put_on_helmet"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(1000)

                        local accessorySkin = {}
                        accessorySkin['helmet_1'] = data.item.itemnum
                        accessorySkin['helmet_2'] = data.item.itemskin

                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    else

                         if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "veh@bike@common@front@base"
                            local anim = "take_off_helmet_walk"

                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['helmet_1'] = -1
                        accessorySkin['helmet_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    end
                    
                end)
            elseif data.item.name == "mask" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["mask_1"] == -1 then

                        local dict = "veh@bicycle@roadfront@base"
                        local anim = "put_on_helmet"
            
                        RequestAnimDict(dict)
                        while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                        
                        TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
            
                        Wait(1000)

                        local accessorySkin = {}
                        accessorySkin['mask_1'] = data.item.itemnum
                        accessorySkin['mask_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    else

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "veh@bike@common@front@base"
                            local anim = "take_off_helmet_walk"

                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['mask_1'] = -1
                        accessorySkin['mask_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    end
                    
                end)
            elseif data.item.name == "glasses" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["glasses_1"] == -1 then

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "clothingspecs"
                            local anim = "try_glasses_positive_a"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['glasses_1'] = data.item.itemnum
                        accessorySkin['glasses_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)

                        ClearPedTasks(player)
                    else

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "clothingspecs"
                            local anim = "take_off"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(1000)
                        end

                        local accessorySkin = {}
                        accessorySkin['glasses_1'] = -1
                        accessorySkin['glasses_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    end
                    
                end)
            elseif data.item.name == "earring" then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    if skin["ears_1"] == -1 then

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "mini@ears_defenders"
                            local anim = "takeoff_earsdefenders_idle"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['ears_1'] = data.item.itemnum
                        accessorySkin['ears_2'] = data.item.itemskin
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    else

                        if IsPedInAnyVehicle(PlayerPedId(), true) == false then
                            local dict = "mini@ears_defenders"
                            local anim = "takeoff_earsdefenders_idle"
                
                            RequestAnimDict(dict)
                            while (not HasAnimDictLoaded(dict)) do Citizen.Wait(0) end
                            
                            TaskPlayAnim(player, dict, anim, 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                
                            Wait(800)
                        end

                        local accessorySkin = {}
                        accessorySkin['ears_1'] = -1
                        accessorySkin['ears_2'] = 0
                        TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
                    end
                    
                end)
            end
        end
    end
)

RegisterNetEvent("esx_inventoryhud:openOtherInventory")
AddEventHandler("esx_inventoryhud:openOtherInventory",function(other, name1, name2, weapon, data)
    DataConfig = data
    loadPlayerInventoryOther(other, name1, name2, weapon, data)
    isInInventory = true
    SendNUIMessage(
        {
            action = "display",
            type = "normal"
        }
    )
    SetNuiFocus(true, true)
end)

-- local itemss = {}
-- function loadPlayerClothes()
--     local accessory = "Helmet"
   
--     ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
-- 		local _accessory = string.lower(accessory)

-- 		if hasAccessory then
--             local item_index = -1
--             local item_skin = 0

--             item_index = accessorySkin[_accessory .. '_1']
--             item_skin = accessorySkin[_accessory .. '_2']

--             table.insert(itemss, {
--                 label = "หมวก",
--                 type = "item_accessories",
--                 item = item_index,
--                 skin = item_skin,
--                 name = "helmet",
--                 usable = true
--             })
--         end

--     end, accessory)

--     for k,v in pairs(itemss) do
--         print(v)
--     end


--     return itemss

-- end

function loadPlayerInventoryOther(other, name1, name2, weapon, data_config)
    ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory1", function(data)
        items = {}
        inventory = data.inventory
        money = data.money
        weapons = data.weapons
        --carkeys = data.carkeys

        if Config.IncludeCash and money ~= nil and money > 0 then
            for key, value in pairs(accounts) do
                moneyData = {
                    label = "Cash",
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    limit = -1,
                    canRemove = true
                }

                table.insert(items, moneyData)
            end
        end

        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].count <= 0 then
                    inventory[key] = nil
                else
                    
                    if inventory[key].type == "item_key" then
                        inventory[key].type = "item_key"
                    elseif inventory[key].type == "item_accessories" then
                        inventory[key].type = "item_accessories"
                    elseif inventory[key].type == "item_keyhouse" then
                        inventory[key].type = "item_keyhouse"
                    else
                        inventory[key].type = "item_standard"
                    end
                    
                    table.insert(items, inventory[key])
                end
            end
        end

        if Config.IncludeWeapons and weapons ~= nil then
            for key, value in pairs(weapons) do
                local weaponHash = GetHashKey(weapons[key].name)
                local playerPed = other
                if weapons[key].name ~= "WEAPON_UNARMED" then
                    local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                    table.insert(
                        items,
                        {
                            label = ESX.GetWeaponLabel(weapons[key].name),
                            count = ammo,
                            limit = -1,
                            type = "item_weapon",
                            name = weapons[key].name,
                            usable = false,
                            rare = false,
                            canRemove = true
                        }
                    )
                end
            end
        end


        SendNUIMessage({
            action = "setItemsPolice",
            itemList = items,
            name1 = name1,
            name2 = name2,
            player = other,
            weapon = weapon,
            CurrentMenu = Current_Menu
        })
    end, other, data_config)
end

function loadPlayerInventory()
    local PlayerId = GetPlayerServerId(PlayerId())
    ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory", function(data)
        items = {}
        inventory = data.inventory
        money = data.money
        weapons = data.weapons

        moneyData = {
            label = "Cash",
            name = "cash",
            type = "item_money",
            count = money,
            usable = false,
            rare = false,
            limit = -1,
            canRemove = true
        }

        table.insert(items, moneyData)
        
        if Config.EnableVehicleKey == true then
            for i=1, #Vehicle_Key, 1 do
                table.insert(inventory, {
                    label = Vehicle_Key[i].plate,
                    count = 1,
                    limit = -1,
                    type = "item_key",
                    name = "key",
                    usable = true,
                    rare = false,
                    canRemove = false
                })
            end
        end

        if Config.EnableHouseKey == true then
            for i=1, #House_Key, 1 do
                table.insert(inventory, {
                    label = House_Key[i].name,
					count = 1,
					limit = -1,
					type = "item_keyhouse",
					name = "keyhouse",
					usable = false,
					rare = false,
					canRemove = false,
					house_id = House_Key[i].id
                })
            end
        end

        for i=1, #Accessory_Items, 1 do
            table.insert(inventory, {
                label = Accessory_Items[i].label,
                count = 1,
                limit = -1,
                type = "item_accessories",
                name = Accessory_Items[i].name,
                usable = true,
                rare = false,
                canRemove = false,
                itemnum = Accessory_Items[i].itemnum,
                itemskin = Accessory_Items[i].itemskin
            })
        end

        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].count <= 0 then
                    inventory[key] = nil
                else
                    
                    if inventory[key].type == "item_accessories" then
                        inventory[key].type = "item_accessories"
                    elseif inventory[key].type == "item_key" then
                        inventory[key].type = "item_key"
                    elseif inventory[key].type == "item_keyhouse" then
                        inventory[key].type = "item_keyhouse"
                    else
                        inventory[key].type = "item_standard"
                    end
                    
                    table.insert(items, inventory[key])
                end
            end
        end

        if Config.IncludeWeapons and weapons ~= nil then
            for key, value in pairs(weapons) do
                local weaponHash = GetHashKey(weapons[key].name)
                local playerPed = PlayerPedId()
                if HasPedGotWeapon(playerPed, weaponHash, false) and weapons[key].name ~= "WEAPON_UNARMED" then
                    local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                    table.insert(
                        items,
                        {
                            label = ESX.GetWeaponLabel(weapons[key].name),
                            count = ammo,
                            limit = -1,
                            type = "item_weapon",
                            name = weapons[key].name,
                            usable = false,
                            rare = false,
                            canRemove = true
                        }
                    )
                end
            end
        end

        SendNUIMessage(
            {
                action = "setItems",
                itemList = items,
                CurrentMenu = Current_Menu
            }
        )
    end, PlayerId)
end

RegisterNetEvent("esx_inventoryhud:openTrunkInventory")
AddEventHandler("esx_inventoryhud:openTrunkInventory", function(data, inventory, weapons)
    setTrunkInventoryData(data, inventory, weapons)
    openTrunkInventory()
end)

RegisterNetEvent("esx_inventoryhud:closeHud")
AddEventHandler("esx_inventoryhud:closeHud",function()
    closeInventory()
end)

RegisterNetEvent("esx_inventoryhud:openPropertyInventory")
AddEventHandler("esx_inventoryhud:openPropertyInventory", function(data)
    setHouseInventoryData(data.items, data.weapons)
    openHouseInventory()
end)

RegisterNetEvent("esx_inventoryhud:AdminOpenPropertyInventory")
AddEventHandler("esx_inventoryhud:AdminOpenPropertyInventory", function(source, data)
    setHouseInventoryData(data.items, data.weapons)
    openHouseInventory()
    houseTarget = source
end)

RegisterNetEvent("esx_inventoryhud:openGangInventory")
AddEventHandler("esx_inventoryhud:openGangInventory", function(data)
    setGangInventoryData(data.items, data.weapons)
    openGangInventory()
end)

RegisterNetEvent("esx_inventoryhud:openBoxInventory")
AddEventHandler("esx_inventoryhud:openBoxInventory", function(data)
    setBoxInventoryData(data.items, data.weapons)
    openBoxInventory()
end)

RegisterNetEvent("esx_inventoryhud:refreshTrunkInventory")
AddEventHandler("esx_inventoryhud:refreshTrunkInventory", function(data, inventory, weapons)
    setTrunkInventoryData(data, inventory, weapons)
end)

RegisterNetEvent("esx_inventoryhud:refreshHouseInventory")
AddEventHandler("esx_inventoryhud:refreshHouseInventory", function(id, cash, inventory, weapons)
    setHouseInventoryData(id, cash, inventory, weapons)
end)

function setTrunkInventoryData(data, inventory, weapons)
    trunkData = data

    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )

    items = {}

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                if inventory[key].name ~= "black_money" then
                    inventory[key].type = "item_standard"
                    inventory[key].usable = false
                    inventory[key].rare = false
                    inventory[key].limit = -1
                    inventory[key].canRemove = false
                    table.insert(items, inventory[key])
                end
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            local playerPed = PlayerPedId()
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
						id = weapons[key].id,
                        label = weapons[key].label,
                        count = weapons[key].count,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage({
        action = "setSecondInventoryItems",
        itemList = items
    })
end


function setHouseInventoryData(propertyItems, weapons)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "Storage"
        }
    )

    items = {}

    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            table.insert(
                items,
                {
                    label = item.label,
                    count = item.count,
                    limit = -1,
                    type = "item_standard",
                    name = item.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            local playerPed = PlayerPedId()
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
						-- id = weapons[key].id,
                        label = ESX.GetWeaponLabel(weapons[key].name),
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage(
        {
            action = "setHouseInventoryItems",
            itemList = items
        }
    )
end

function setGangInventoryData(propertyItems, weapons)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "Storage"
        }
    )

    items = {}

    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            table.insert(
                items,
                {
                    label = item.label,
                    count = item.count,
                    limit = -1,
                    type = "item_standard",
                    name = item.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            local playerPed = PlayerPedId()
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
						-- id = weapons[key].id,
                        label = ESX.GetWeaponLabel(weapons[key].name),
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage(
        {
            action = "setGangInventoryItems",
            itemList = items
        }
    )
end

function setBoxInventoryData(propertyItems, weapons)

    SendNUIMessage(
        {
            action = "setInfoText",
            text = "Storage"
        }
    )

    items = {}

    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            table.insert(
                items,
                {
                    label = item.label,
                    count = item.count,
                    limit = -1,
                    type = "item_standard",
                    name = item.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            local playerPed = PlayerPedId()
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
						-- id = weapons[key].id,
                        label = ESX.GetWeaponLabel(weapons[key].name),
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage(
        {
            action = "setBoxInventoryItems",
            itemList = items
        }
    )
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableControlAction(0, 1, true) -- Disable pan
                DisableControlAction(0, 2, true) -- Disable tilt
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, Keys["W"], true) -- W
                DisableControlAction(0, Keys["A"], true) -- A
                DisableControlAction(0, 31, true) -- S (fault in Keys table!)
                DisableControlAction(0, 30, true) -- D (fault in Keys table!)

                DisableControlAction(0, Keys["R"], true) -- Reload
                DisableControlAction(0, Keys["SPACE"], true) -- Jump
                DisableControlAction(0, Keys["Q"], true) -- Cover
                DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
                DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

                DisableControlAction(0, Keys["F1"], true) -- Disable phone
                DisableControlAction(0, Keys["F2"], true) -- Inventory
                DisableControlAction(0, Keys["F3"], true) -- Animations
                DisableControlAction(0, Keys["F6"], true) -- Job

                DisableControlAction(0, Keys["V"], true) -- Disable changing view
                DisableControlAction(0, Keys["C"], true) -- Disable looking behind
                DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
                DisableControlAction(2, Keys["P"], true) -- Disable pause screen

                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle

                DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
            end
        end
    end
)

RegisterNetEvent("esx_inventoryhud:setOwnerVehicle")
AddEventHandler("esx_inventoryhud:setOwnerVehicle", function(result)
    Vehicle_Key = result
end)

RegisterNetEvent("esx_inventoryhud:setOwnerHouse")
AddEventHandler("esx_inventoryhud:setOwnerHouse", function(result)
    House_Key = result
end)

RegisterNetEvent("esx_inventoryhud:setOwnerAccessories")
AddEventHandler("esx_inventoryhud:setOwnerAccessories", function(result)
    Accessory_Items = result
end)


RegisterNetEvent("esx_inventoryhud:getOwnerVehicle")
AddEventHandler("esx_inventoryhud:getOwnerVehicle",function()
    TriggerServerEvent("esx_inventoryhud:getOwnerVehicle")
end)

RegisterNetEvent("esx_inventoryhud:getOwnerHouse")
AddEventHandler("esx_inventoryhud:getOwnerHouse",function()
    TriggerServerEvent("esx_inventoryhud:getOwnerHouse")
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		closeInventory()
	end
end)
--[[
    ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    DecorRegister('typing',2)
    DecorSetInt(PlayerPedId(),'typing',0)
end)

local mpGamerTags = {}
local mpGamerTagSettings = {}

local gtComponent = {
    GAMER_NAME = 0,
    CREW_TAG = 1,
    healthArmour = 2,
    BIG_TEXT = 3,
    AUDIO_ICON = 4,
    MP_USING_MENU = 5,
    MP_PASSIVE_MODE = 6,
    WANTED_STARS = 7,
    MP_DRIVER = 8,
    MP_CO_DRIVER = 9,
    MP_TAGGED = 10,
    GAMER_NAME_NEARBY = 11,
    ARROW = 12,
    MP_PACKAGES = 13,
    INV_IF_PED_FOLLOWING = 14,
    RANK_TEXT = 15,
    MP_TYPING = 16
}

local function makeSettings()
    return {
        alphas = {},
        colors = {},
        healthColor = false,
        toggles = {},
        wantedLevel = false
    }
end

local templateStr

function updatePlayerNames()
    -- re-run this function the next frame
    SetTimeout(250, updatePlayerNames)
    -- return if no template string is set
    if not templateStr then
        return
    end
    -- get local coordinates to compare to
    local localCoords = GetEntityCoords(PlayerPedId())
    -- for each valid player index
    for _, i in ipairs(GetActivePlayers()) do
        -- if the player exists-
        if i ~= PlayerId() and (NetworkIsPlayerTalking(i) or IsPauseMenuActive(i)) then
            -- get their ped
            local ped = GetPlayerPed(i)
            local pedCoords = GetEntityCoords(ped)

            -- make a new settings list if needed
            if not mpGamerTagSettings[i] then
                mpGamerTagSettings[i] = makeSettings()
            end

            -- check the ped, because changing player models may recreate the ped
            -- also check gamer tag activity in case the game deleted the gamer tag
            if not mpGamerTags[i] or mpGamerTags[i].ped ~= ped or not IsMpGamerTagActive(mpGamerTags[i].tag) then
                -- local nameTag = formatPlayerNameTag(i, templateStr)

                -- remove any existing tag
                if mpGamerTags[i] then
                    RemoveMpGamerTag(mpGamerTags[i].tag)
                end

                -- store the new tag
                --mpGamerTags[i] = {
                --   tag = CreateMpGamerTag(GetPlayerPed(i), GetPlayerName(i) .. " [" .. GetPlayerServerId(i) .. "]", false, false, '', 0),
                --    ped = ped
                --}

                --[[
                local nameTag = "[".. GetPlayerServerId(i).."]"
                mpGamerTags[serverId] = {
                    tag = CreateMpGamerTag(GetPlayerPed(i), nameTag, false, false, '', 0),
                    ped = ped
                }
                --]]
--[[
                mpGamerTags[i] = {
                  tag = CreateMpGamerTag(GetPlayerPed(i),  " [" .. GetPlayerServerId(i) .. "]", false, false, '', 0),
                   ped = ped
                }
            end

            -- store the tag in a local
            local tag = mpGamerTags[i].tag
            -- check distance
            local distance = #(pedCoords - localCoords)
            -- show/hide based on nearbyness/line-of-sight
            -- nearby checks are primarily to prevent a lot of LOS checks
            --if distance < 250 and HasEntityClearLosToEntity(PlayerPedId(), ped, 17) then
            if distance < 20 and playersInfo[i].info["cansee"] and HasEntityClearLosToEntity(PlayerPedId(), ped, 17) and not mpGamerTagSettings[serverId].toggle then
                SetMpGamerTagVisibility(tag, gtComponent.MP_TYPING, DecorGetInt(ped,'typing'))
                SetMpGamerTagVisibility(tag, gtComponent.AUDIO_ICON, NetworkIsPlayerTalking(i))
                SetMpGamerTagVisibility(tag, gtComponent.MP_USING_MENU, IsPauseMenuActive())

                SetMpGamerTagAlpha(tag, gtComponent.AUDIO_ICON, 255)
                SetMpGamerTagAlpha(tag, gtComponent.MP_USING_MENU, 255)
            else
                SetMpGamerTagVisibility(tag, gtComponent.MP_TYPING, false)
                SetMpGamerTagVisibility(tag, gtComponent.AUDIO_ICON, false)
                SetMpGamerTagVisibility(tag, gtComponent.MP_USING_MENU, false)
            end
        elseif mpGamerTags[i] then
           RemoveMpGamerTag(mpGamerTags[i].tag)

           mpGamerTags[i] = nil
        end
    end
end

local function getSettings(id)
    local i = GetPlayerFromServerId(tonumber(id))

    if not mpGamerTagSettings[i] then
        mpGamerTagSettings[i] = makeSettings()
    end

    return mpGamerTagSettings[i]
end

RegisterNetEvent('playernames:configure')
AddEventHandler('playernames:configure', function(id, key, ...)
    local args = table.pack(...)

    if key == 'tglc' then --[[
        getSettings(id).toggles[args[1]] --[[ = args[2]
    elseif key == 'seta' then
   --     getSettings(id).alphas[args[1]] --=-- args[2]
  ---  elseif key == 'setc' then
  --      getSettings(id).colors[args[1]] = args[2]
 --   elseif key == 'setw' then
 --       getSettings(id).wantedLevel = args[1]
 --   elseif key == 'sehc' then
 --       getSettings(id).healthColor = args[1]
--    elseif key == 'rnme' then
--        getSettings(id).rename = true
--    elseif key == 'name' then
--        getSettings(id).serverName = args[1]
--        getSettings(id).rename = true
--    elseif key == 'tpl' then
--        for _, v in pairs(mpGamerTagSettings) do
 --           v.rename = true
--        end

--        templateStr = args[1]
--    end
--end
--[[
AddEventHandler('playernames:extendContext', function(i, cb)
    cb('serverName', getSettings(GetPlayerServerId(i)).serverName)
end)

AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        for _, v in pairs(mpGamerTags) do
            RemoveMpGamerTag(v.tag)
        end
    end
end)

SetTimeout(0, function()
    TriggerServerEvent('playernames:init')
end)

-- run this function every frame
SetTimeout(250, updatePlayerNames)

]]
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    DecorRegister('typing',2)
    DecorSetInt(PlayerPedId(),'typing',0)
end)
playersInfo = {}
local mpGamerTags = {}
local mpGamerTagSettings = {}
local NewBiePlayer = {}
local ShowPlayersId = false

local gtComponent = {
    GAMER_NAME = 0,
    CREW_TAG = 1,
    healthArmour = 2,
    BIG_TEXT = 3,
    AUDIO_ICON = 4,
    MP_USING_MENU = 5,
    MP_PASSIVE_MODE = 6,
    WANTED_STARS = 7,
    MP_DRIVER = 8,
    MP_CO_DRIVER = 9,
    MP_TAGGED = 10,
    GAMER_NAME_NEARBY = 11,
    ARROW = 12,
    MP_PACKAGES = 13,
    INV_IF_PED_FOLLOWING = 14,
    RANK_TEXT = 15,
    MP_TYPING = 16
}

local function makeSettings()
    return {
        nameTag = nil,
        colors = {},
        toggle = false,
    }
end

function updatePlayerNames()
    
    -- re-run this function the next frame
    SetTimeout(100, updatePlayerNames)

    -- get local coordinates to compare to
    local localCoords = GetEntityCoords(PlayerPedId())

    -- for each valid player index
    for _, i in ipairs(GetActivePlayers()) do
        -- get their ped
        local ped = GetPlayerPed(i)
        local serverId = GetPlayerServerId(i)
        local myserverId = GetPlayerServerId(PlayerId())
        local pedCoords = GetEntityCoords(ped)

        -- make a new settings list if needed
        if not mpGamerTagSettings[serverId] then
            mpGamerTagSettings[serverId] = makeSettings()
        end

        if not mpGamerTagSettings[serverId].nameTag then
           if i == PlayerId() or playersInfo[i] == nil then goto skip_this end
           if  playersInfo[i] == nil then goto skip_this end
        end

        -- check the ped, because changing player models may recreate the ped
        -- also check gamer tag activity in case the game deleted the gamer tag
        if not mpGamerTags[serverId] or mpGamerTags[serverId].ped ~= ped or not IsMpGamerTagActive(mpGamerTags[serverId].tag) then
            local nameTag = "["..serverId.."]"
            -- remove any existing tag
            if mpGamerTags[serverId] then
                RemoveMpGamerTag(mpGamerTags[serverId].tag)
            end

            -- store the new tag
            mpGamerTags[serverId] = {
                tag = CreateFakeMpGamerTag(GetPlayerPed(i), nameTag, false, false, '', 0),
                ped = ped
            }
        end

        -- store the tag in a local
        local tag = mpGamerTags[serverId].tag

        -- check distance
        local distance = playersInfo[i].info["distance"]

        -- show/hide based on nearbyness/line-of-sight
        -- nearby checks are primarily to prevent a lot of LOS checks
        if distance < 20 and playersInfo[i].info["cansee"] and HasEntityClearLosToEntity(PlayerPedId(), ped, 17) and not mpGamerTagSettings[serverId].toggle then
            SetMpGamerTagVisibility(tag, gtComponent.MP_TYPING, DecorGetInt(ped,'typing'))
            if ShowPlayersId or NetworkIsPlayerTalking(i) or mpGamerTagSettings[serverId].nameTag then
                SetMpGamerTagVisibility(tag, gtComponent.MP_CO_DRIVER, NetworkIsPlayerTalking(i))
                SetMpGamerTagAlpha(tag, gtComponent.MP_CO_DRIVER, 255)
                SetMpGamerTagVisibility(tag, gtComponent.GAMER_NAME, true)
                if mpGamerTagSettings[serverId] and mpGamerTagSettings[serverId].nameTag then
                    if mpGamerTagSettings[myserverId] and mpGamerTagSettings[myserverId].nameTag then
                        SetMpGamerTagName(tag, mpGamerTagSettings[serverId].nameTag.." ["..serverId.."]")
                    else
                        SetMpGamerTagName(tag, mpGamerTagSettings[serverId].nameTag)
                    end
                end
                for k,v in pairs(mpGamerTagSettings[serverId].colors) do
                    SetMpGamerTagColour(tag, gtComponent[k], v)
                end
                if mpGamerTagSettings[serverId].nameTag then
                    SetMpGamerTagColour(tag, gtComponent.GAMER_NAME, 6)
                end
            else
                --SetMpGamerTagVisibility(tag, gtComponent.MP_TYPING, false)
                SetMpGamerTagVisibility(tag, gtComponent.GAMER_NAME, false)
                SetMpGamerTagVisibility(tag, gtComponent.MP_CO_DRIVER, false)
            end
        else
            SetMpGamerTagVisibility(tag, gtComponent.MP_TYPING, false)
            SetMpGamerTagVisibility(tag, gtComponent.GAMER_NAME, false)
            SetMpGamerTagVisibility(tag, gtComponent.MP_CO_DRIVER, false)
        end

        ::skip_this::
    end
end

AddEventHandler('onResourceStop', function(name)
    if name == GetCurrentResourceName() then
        for _, v in pairs(mpGamerTags) do
            RemoveMpGamerTag(v.tag)
        end
    end
end)

RegisterNetEvent('pname:changePlayerSetting')
AddEventHandler('pname:changePlayerSetting', function(id, key, value)
    if not mpGamerTagSettings[id] then
        mpGamerTagSettings[id] = makeSettings()
    end

    if mpGamerTags[id] then
        RemoveMpGamerTag(mpGamerTags[id].tag)
    end

    mpGamerTagSettings[id][key] = value
end)

Citizen.CreateThread(function()
    while true do
        for _, player in ipairs(GetActivePlayers()) do

            local coords = GetEntityCoords(GetPlayerPed(-1))
            local coords2 = GetEntityCoords(GetPlayerPed(player))
            local distance = math.floor(Vdist2(coords.x, coords.y, coords.z, coords2.x, coords2.y, coords2.z))
            --local cansee = HasEntityClearLosToEntity(GetPlayerPed(-1), GetPlayerPed(player), 17)
            
            playersInfo[player] = {}
            playersInfo[player]["info"] = {}
            playersInfo[player].info["distance"] = distance
           -- playersInfo[player].info["cansee"] = cansee
            playersInfo[player].info["cansee"] = IsEntityVisible(GetPlayerPed(player))
            --playersInfo[player].info["hide"] = IsEntityVisible(GetPlayerPed(player))
        end
        Citizen.Wait(2000)
    end
end)


ShowPlayersId = false

AddEventHandler('onKeyUP',function(key)
	if key == "numpad7" then
        if not ShowPlayersId then
            ShowPlayersId = true
            TriggerServerEvent("3dme:shareDisplay", GetPlayerName(PlayerId()) .. " Be id ha negah kard", false)
            TriggerServerEvent("idoverhead:7")
            SetTimeout(5000, function()
                ShowPlayersId = false
            end)
        end
	end
end)

updatePlayerNames()
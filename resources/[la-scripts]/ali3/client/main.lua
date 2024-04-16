ESX = nil
local currentAdminPlayers = {}
local visibleAdmins = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end
end)

RegisterNetEvent('relisoft_tag:set_admins')
AddEventHandler('relisoft_tag:set_admins', function(admins)
    currentAdminPlayers = admins
    for id, admin in pairs(visibleAdmins) do
        if admins[id] == nil then
            visibleAdmins[id] = nil
        end
    end
end)

CreateThread(function()
    while not NetworkIsSessionActive() do
        Wait(500)
    end
    Wait(500)
    ESX.TriggerServerCallback('relisoft_tag:getAdminsPlayers', function(admins)
        currentAdminPlayers = admins
    end)
end)

function draw3DText(pos, text, options)
    options = options or {}
    local color = options.color or { r = 255, g = 255, b = 255, a = 255 }
    local scaleOption = options.size or 0.8

    local camCoords = GetGameplayCamCoords()
    local dist = #(vector3(camCoords.x, camCoords.y, camCoords.z) - vector3(pos.x, pos.y, pos.z))
    local scale = (scaleOption / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scaleMultiplier = scale * fov
    SetDrawOrigin(pos.x, pos.y, pos.z, 0);
    SetTextProportional(0)
    SetTextScale(0.0 * scaleMultiplier, 0.50 * scaleMultiplier)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
    SetTextFont(0)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.NearCheckWait)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        for k, v in pairs(currentAdminPlayers) do
            local playerServerID = GetPlayerFromServerId(v.source)
            if playerServerID ~= -1 then
                local adminPed = GetPlayerPed(playerServerID)
                local adminCoords = GetEntityCoords(adminPed)

                local distance = Vdist(adminCoords, pedCoords)
                if distance < (Config.SeeDistance) then
                    visibleAdmins[v.source] = v
                else
                    visibleAdmins[v.source] = nil
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local isanyadminhere = false
    while true do
        Citizen.Wait(1)
        isanyadminhere = false
        local MyCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(visibleAdmins) do
            local playerServerID = GetPlayerFromServerId(v.source)
            if playerServerID ~= -1 then
                local adminPed = GetPlayerPed(playerServerID)
                local adminCoords = GetEntityCoords(adminPed)
                local x, y, z = table.unpack(adminCoords)
                z = z + Config.ZOffset

                if DoesEntityExist(adminPed) and IsEntityVisible(adminPed) then
                    isanyadminhere = true
                    local label
                    
                    if v.group == 'developer' then
                        label = '~r~Developer~w~ ' .. GetPlayerName(playerServerID)
                    elseif v.group == 'master' then
                        label = '~b~Master~w~ ' .. GetPlayerName(playerServerID)
                    elseif v.group == 'superadmin' then
                        label = '~r~HighRank~w~ ' .. GetPlayerName(playerServerID)
                    else 
                        label = '~p~[STAFF]~w~ ' .. GetPlayerName(playerServerID)
                    end

                    if label then
                        if v.source == GetPlayerServerId(PlayerId()) then
                            if Config.SeeOwnLabel == true then
                                draw3DText(vector3(x, y, z), label, {
                                    size = Config.TextSize
                                })
                            end
                        else
                            draw3DText(vector3(x, y, z), label, {
                                size = Config.TextSize
                            })
                        end
                    end
                end
            end
        end
        if not isanyadminhere then
            Wait(1)
        end
    end
end)




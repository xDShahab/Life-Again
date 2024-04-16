

local bigmap = false
local HUD_ELEMENTS = {
    HUD = {id = 0, hidden = false},
    HUD_WANTED_STARS = {id = 1, hidden = true},
    HUD_WEAPON_ICON = {id = 2, hidden = true},
    HUD_CASH = {id = 3, hidden = true},
    HUD_MP_CASH = {id = 4, hidden = true},
    HUD_MP_MESSAGE = {id = 5, hidden = true},
    HUD_VEHICLE_NAME = {id = 6, hidden = true},
    HUD_AREA_NAME = {id = 7, hidden = true},
    HUD_VEHICLE_CLASS = {id = 8, hidden = true},
    HUD_STREET_NAME = {id = 9, hidden = true},
    HUD_FLOATING_HELP_TEXT_1 = {id = 11, hidden = false},
    HUD_FLOATING_HELP_TEXT_2 = {id = 12, hidden = false},
    HUD_CASH_CHANGE = {id = 13, hidden = true},
    --HUD_RETICLE = { id = 14, hidden = FALSE },
    HUD_SUBTITLE_TEXT = {id = 15, hidden = false},
    -- HUD_RADIO_STATIONS = { id = 16, hidden = true },
    HUD_SAVING_GAME = {id = 17, hidden = false},
    HUD_GAME_STREAM = {id = 18, hidden = false},
    HUD_WEAPON_WHEEL = {id = 19, hidden = false},
    HUD_WEAPON_WHEEL_STATS = {id = 20, hidden = true},
    MAX_HUD_COMPONENTS = {id = 21, hidden = false},
    MAX_HUD_WEAPONS = {id = 22, hidden = false},
    MAX_SCRIPTED_HUD_COMPONENTS = {id = 141, hidden = false}
}

local HUD_HIDE_RADAR_ON_FOOT = true

Citizen.CreateThread(
    function()
        for key, val in pairs(HUD_ELEMENTS) do
            if val.hidden then
                HideHudComponentThisFrame(val.id)
            else
                ShowHudComponentThisFrame(val.id)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            local player = GetPlayerPed(-1)
            if (IsPedInAnyVehicle(player, false)) then
                local speed = GetEntitySpeed(player)
                local kmh = speed * 3.6
                if kmh > 100 then
                    if bigmap == true then
                        SetRadarZoomLevelThisFrame(600 + kmh)
                    else
                        SetRadarZoomLevelThisFrame(50 + kmh)
                    end
                end
            end

            if bigmap then
                SetBigmapActive(true, false)
            else
                SetBigmapActive(false, false)
            end
            if IsControlJustReleased(1, 243) then
                if bigmap then
                    bigmap = false
                    TriggerEvent(
                        "pNotify:SendNotification",
                        {text = "!نقشه کوچک فعال شد", type = "warning", timeout = 1400, layout = "centerLeft"}
                    )
                else
                    bigmap = true
                    TriggerEvent(
                        "pNotify:SendNotification",
                        {text = "!نقشه بزرگ فعال شد", type = "success", timeout = 1400, layout = "centerLeft"}
                    )
                end
            end
        end
    end
)


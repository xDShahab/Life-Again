Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.TrigerEvent, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)




Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local DetectableTextures = {
            {txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
            {txd = "John", txt = "John2", name = "SugarMenu"},
            {txd = "darkside", txt = "logo", name = "Darkside"},
            {txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
            {txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
            {txd = "fm", txt = "menu_bg", name = "Fallout"},
            {txd = "wave", txt = "logo", name ="Wave"},
            {txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
            {txd = "meow2", txt = "woof2", name ="Alokas66", x = 1000, y = 1000},
            {txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name ="Guest Menu"},
            {txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name="HugeV Menu"},
            {txd = "MM", txt = "menu_bg", name="MetrixFallout"},
            {txd = "wm", txt = "wm2", name="WM Menu"},
            {txd = "a6", txt = "a7", name="just3"},
            {txd = "titleBackgroundSprite", txt = "titleBackgroundSprite", name="just1"},
            {txd = "weapon_icons", txt = "weaponTextures[i][2]", name="just5"},
        }

        for i, data in pairs(DetectableTextures) do
            if data.x and data.y then
                if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
                    if Config.screnshot == 'active' then
                        TriggerServerEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua', GetPlayerServerId(PlayerId()))
                        TriggerClientEvent("screenclinetside")
                    else
                        TriggerServerEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua', GetPlayerServerId(PlayerId()))
                        TriggerClientEvent("screenclinetside")
                    end
                end
            else 
                if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
                    if Config.screnshot == 'active' then
                        TriggerServerEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua', GetPlayerServerId(PlayerId()))
                        TriggerClientEvent("screenclinetside")
                        Citizen.Wait(2000)
                    else
                        TriggerServerEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua', GetPlayerServerId(PlayerId()))
                        TriggerClientEvent("screenclinetside")
                    end
                end
            end
        end
    end
end)

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
        local DetectableTextures = {
            {txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
            {txd = "John", txt = "John2", name = "SugarMenu"},
            {txd = "darkside", txt = "logo", name = "Darkside"},
            {txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
            {txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
            {txd = "fm", txt = "menu_bg", name = "Fallout"},
            {txd = "wave", txt = "logo", name ="Wave"},
            {txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
            {txd = "meow2", txt = "woof2", name ="Alokas66", x = 1000, y = 1000},
            {txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name ="Guest Menu"},
            {txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name="HugeV Menu"},
            {txd = "MM", txt = "menu_bg", name="MetrixFallout"},
            {txd = "wm", txt = "wm2", name="WM Menu"}

        }
        for i, data in pairs(DetectableTextures) do
            if data.x and data.y then
                if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
                    if Config.screnshot == 'active' then
                        TriggerServerEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua', GetPlayerServerId(PlayerId()))
                        Citizen.Wait(2000)
                        exports['screenshot-basic']:requestScreenshotUpload(Config.sendlog, "files[]", function(data) 
                            local image = json.decode(data) 
                            local kobssefid = nil
                            --TriggerServerEvent('Scrennshot:playerspace', kobssefid)
                        end)
                    else
                        TriggerServerEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua', GetPlayerServerId(PlayerId()))
                    end
                end
                if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
                    if Config.screnshot == 'active' then
                        TriggerServerEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua', GetPlayerServerId(PlayerId()))
                        Citizen.Wait(2000)
                        exports['screenshot-basic']:requestScreenshotUpload(Config.sendlog, "files[]", function(data) 
                            local image = json.decode(data) 
                            local kobssefid = nil
                            --TriggerServerEvent('Scrennshot:playerspace', kobssefid)
                        end)
                    else
                        TriggerServerEvent('kosnanatok:ksooskdoasdkaosdakdoaksdoasdokasdksadkskdoakdokasdksadaksdkasdkosadkoasodkoaskdauisudisdua', GetPlayerServerId(PlayerId()))
                    end
                end
            end
        end
    end
end)




]]


--[[
    AddEventHandler('onResourceStop', function(resourceName)
        if resourceName == 'ali3'  or resourceName == 'screenshot-basic' then
            TriggerServerEvent('NanashoBega2', GetPlayerServerId(PlayerId()),'Try To Stop Recource  ' )
        end
    end)
]]
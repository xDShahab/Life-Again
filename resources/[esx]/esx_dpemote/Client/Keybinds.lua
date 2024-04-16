if Config.SqlKeybinding then
local emob1 = ""
local emob2 = ""
local emob3 = ""
local emob4 = ""
local emob5 = ""
local emob6 = ""
local keyb1 = "num4"
local keyb2 = "num5"
local keyb3 = "num6"
local keyb4 = "num7"
local keyb5 = "num8"
local keyb6 = "num9" 
local hkey = "Whisle 2" 
local Initialized = false
local canbind = true
-----------------------------------------------------------------------------------------------------
-- Commands / Events --------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
  while true do
    if NetworkIsPlayerActive(PlayerId()) and not Initialized then
        if not Initialized then
            local does = GetResourceKvpString('emote')
            if does then
                emob1 = GetResourceKvpString('num4')
                emob2 = GetResourceKvpString('num5')
                emob3 = GetResourceKvpString('num6')
                emob4 = GetResourceKvpString('num7')
                emob5 = GetResourceKvpString('num8')
                emob6 = GetResourceKvpString('num9')
                Initialized = true
            else
                SetResourceKvp("num4","")
                SetResourceKvp("num5","")
                SetResourceKvp("num6","")
                SetResourceKvp("num7","")
                SetResourceKvp("num8","")
                SetResourceKvp("num9","")
                SetResourceKvp("emote","salam")
                Initialized = true
            end
        end
        return
    end
    Citizen.Wait(100)
  end
end)


AddEventHandler("onKeyDown", function(key)
    if IsPedInAnyVehicle(PlayerPedId()) then
        return
    end 
    
    if key == "numpad4" then
        if not canbind then 
            TriggerEvent('esx:showNotification', 'Lotfan spam emote nakonid!')  
            return 
        end
        if emob1 ~= "" then EmoteCommandStart(nil,{emob1, 0}) end 
        canbind = false
        Citizen.SetTimeout(5000,function()
            canbind = true
        end)
    elseif key == "numpad5" then
        if not canbind then 
            TriggerEvent('esx:showNotification', 'Lotfan spam emote nakonid!')  
            return 
        end
        if emob2 ~= "" then EmoteCommandStart(nil,{emob2, 0}) end 
        canbind = false
        Citizen.SetTimeout(5000,function()
            canbind = true
        end)
    elseif key == "numpad6" then
        if not canbind then 
            TriggerEvent('esx:showNotification', 'Lotfan spam emote nakonid!')  
            return 
        end
        if emob3 ~= "" then EmoteCommandStart(nil,{emob3, 0}) end 
        canbind = false
        Citizen.SetTimeout(5000,function()
            canbind = true
        end)
    elseif key == "numpad7" then
        if not canbind then 
            TriggerEvent('esx:showNotification', 'Lotfan spam emote nakonid!')  
            return 
        end
        if emob4 ~= "" then EmoteCommandStart(nil,{emob4, 0}) end 
        canbind = false
        Citizen.SetTimeout(5000,function()
            canbind = true
        end)
    elseif key == "numpad8" then
        if not canbind then 
            TriggerEvent('esx:showNotification', 'Lotfan spam emote nakonid!')  
            return 
        end
        if emob5 ~= "" then EmoteCommandStart(nil,{emob5, 0}) end 
        canbind = false
        Citizen.SetTimeout(5000,function()
            canbind = true
        end)
    elseif key == "numpad9" then
        if not canbind then 
            TriggerEvent('esx:showNotification', 'Lotfan spam emote nakonid!')  
            return 
        end
        if emob6 ~= "" then EmoteCommandStart(nil,{emob6, 0}) end 
        canbind = false
        Citizen.SetTimeout(5000,function()
            canbind = true
        end)
    elseif key == "h" then
        if not canbind then 
            TriggerEvent('esx:showNotification', 'Lotfan spam emote nakonid!')  
            return 
        end
        EmoteCommandStart(nil,{'Whistle', 0}) 
        canbind = false
        Citizen.SetTimeout(5000,function()
            canbind = true
        end)
    end

end)

--[[
RegisterNetEvent("dp:ClientKeybindExist")
AddEventHandler("dp:ClientKeybindExist", function(does)
    if does then
    	TriggerServerEvent("dp:ServerKeybindGrab")
    else
    	TriggerServerEvent("dp:ServerKeybindCreate")
    end
end)

RegisterNetEvent("dp:ClientKeybindGet")
AddEventHandler("dp:ClientKeybindGet", function(k1, e1, k2, e2, k3, e3, k4, e4, k5, e5, k6, e6)
    keyb1 = k1 emob1 = e1 keyb2 = k2 emob2 = e2 keyb3 = k3 emob3 = e3 keyb4 = k4 emob4 = e4 keyb5 = k5 emob5 = e5 keyb6 = k6 emob6 = e6
    Initialized = true
end)

RegisterNetEvent("dp:ClientKeybindGetOne")
AddEventHandler("dp:ClientKeybindGetOne", function(key, e)
    SimpleNotify(Config.Languages[lang]['bound']..""..e.." "..Config.Languages[lang]['to'].." "..firstToUpper(key).."")
	if key == "num4" then emob1 = e keyb1 = "num4" elseif key == "num5" then emob2 = e keyb2 = "num5" elseif key == "num6" then emob3 = e keyb3 = "num6" elseif key == "num7" then emob4 = e keyb4 = "num7" elseif key == "num8" then emob5 = e keyb5 = "num8" elseif key == "num9" then emob6 = e keyb6 = "num9" end
end)

]]

-----------------------------------------------------------------------------------------------------
------ Functions and stuff --------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------

function EmoteBindsStart()
    EmoteChatMessage(Config.Languages[lang]['currentlyboundemotes'].."\n"
        ..firstToUpper(keyb1).." = '^2"..emob1.."^7'\n"
        ..firstToUpper(keyb2).." = '^2"..emob2.."^7'\n"
        ..firstToUpper(keyb3).." = '^2"..emob3.."^7'\n"
        ..firstToUpper(keyb4).." = '^2"..emob4.."^7'\n"
        ..firstToUpper(keyb5).." = '^2"..emob5.."^7'\n"
        ..firstToUpper(keyb6).." = '^2"..emob6.."^7'\n")
end

function EmoteBindStart(source, args, raw)
    if #args > 0 then
        local key = string.lower(args[1])
        local set = false
        local emote = string.lower(args[2])
        if (Config.KeybindKeys[key]) ~= nil then
        	if DP.Emotes[emote] ~= nil then
                SetResourceKvp(key,emote)
                set = true
        	elseif DP.Dances[emote] ~= nil then
                SetResourceKvp(key,emote)
                set = true
        	elseif DP.PropEmotes[emote] ~= nil then
                SetResourceKvp(key,emote)
                set = true
        	else
          		EmoteChatMessage("'"..emote.."' "..Config.Languages[lang]['notvalidemote'].."")
        	end
            if set then
                if key == "num4" then 
                    emob1 = emote 
                elseif key == "num5" then 
                    emob2 = emote
                elseif key == "num6" then 
                    emob3 = emote
                elseif key == "num7" then 
                    emob4 = emote 
                elseif key == "num8" then 
                    emob5 = emote 
                elseif key == "num9" then 
                    emob6 = emote 
                end
                TriggerEvent('esx:showNotification', 'emote('..emote..') ba movafaghiat set shod')  
            end
        else
        	EmoteChatMessage("'"..key.."' "..Config.Languages[lang]['notvalidkey'])
        end
    else
        print("invalid")
    end
end

end
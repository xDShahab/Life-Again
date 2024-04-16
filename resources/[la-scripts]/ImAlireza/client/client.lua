----==============================================================---
----==============================================================---
----==============================================================---
---AliReza_At : Dadash Age Khasti Az In Metod Eski Beri .....😂
----==============================================================---
----==============================================================---
----==============================================================---
local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
RegisterNetEvent("Alireza:vehecle")
AddEventHandler("Alireza:vehecle", function ()
    local totalvehc = 0
    local notdelvehc = 0

    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then SetVehicleHasBeenOwnedByPlayer(vehicle, false) SetEntityAsMissionEntity(vehicle, false, false) DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then DeleteVehicle(vehicle) end
            if (DoesEntityExist(vehicle)) then notdelvehc = notdelvehc + 1 end
        end
        totalvehc = totalvehc + 1 
    end
    local vehfrac = totalvehc - notdelvehc .. " / " .. totalvehc
    Citizen.Trace("Shoma  "..vehfrac.."  In mashin ra pak kardin")
end)


RegisterNetEvent("Alireza:peds")
AddEventHandler("Alireza:peds", function()
    local PedStatus = 0
    for peds in EnumeratePeds() do
        PedStatus = PedStatus+1
        if not IsPedAPlayer(peds) then
            RemoveAllPedWeapons(peds, true)
            DeleteEntity(peds)
        end
    end
end)

-----Shoting-----
local warn1 = false
local warn2 = false
local warn3 = false
local warn5 = false
local warn4 = false
local warn6 = false
local warn7 = false




-----Vehicle-----
local vehwarn1 = false
local vehwarn2 = false
local vehwarn3 = false
local vehwarn4 = false
local vehwarn5 = false
local vehwarn6 = false
local vehwarn7 = false



RegisterNetEvent("Alireza:vehi2")
AddEventHandler("Alireza:vehi2", function()
    for vehicles in EnumerateVehicles() do
        if not IsPedInVehicle(GetPlayerPed(-1), vehicles, true) then
            SetEntityAsMissionEntity(GetVehiclePedIsIn(vehicles, true), 1, 1)
            DeleteEntity(GetVehiclePedIsIn(vehicles, true))
            SetEntityAsMissionEntity(vehicles, 1, 1)
            DeleteEntity(vehicles)
        end
    end
end)




RegisterNetEvent("At_Ac:kingdmagevehicle")
AddEventHandler("At_Ac:kingdmagevehicle", function(sender)
    local chektime = 0
    local playerPed = PlayerPedId(-1)
	if GetGameTimer() - 10000000  > chektime then
		chektime = GetGameTimer()
	else
        Chekingvehiclewarn(sender)
		chektime = GetGameTimer()
        fozolsanj2(sender)
	end
end)



RegisterNetEvent("AT_Ac:ChekingShotingPlayer")
AddEventHandler("AT_Ac:ChekingShotingPlayer", function(sender)
    local chektime = 0
    local playerPed = PlayerPedId(-1)
	if GetGameTimer() - 10000000  > chektime then
		chektime = GetGameTimer()
	else
        ChekingShoting(sender)
		chektime = GetGameTimer()
        fozolsanj(sender)
	end
end)



function fozolsanj(sender)
    Citizen.Wait(5000)
    warn1 = false
    warn2 = false
    warn3 = false
    warn4 = false
    warn5 = false
    warn6 = false
    warn7 = false
    warn8 = false
    warn9 = false

end


function fozolsanj2(sender)
    Citizen.Wait(6000)
    local vehwarn1 = false
    local vehwarn2 = false
    local vehwarn3 = false
    local vehwarn4 = false
    local vehwarn5 = false
    local vehwarn6 = false
    local vehwarn7 = false
end


function ChekingShoting(sender)
    if warn1 then
        if warn2 then
            if warn3 then
                if warn4 then
                    if warn5 then
                        if warn6 then
                            if warn7 then
                                if warn8 then
                                    if warn9 then
                                       warn1 = false
                                       warn2 = false
                                       warn3 = false
                                       warn4 = false
                                       warn5 = false
                                       warn6 = false
                                       warn7 = false
                                       warn8 = false
                                       warn9 = false
                                       TriggerServerEvent('AT_Waring:player', sender, 'Try to Fast Shoting(5/5)')
                                    else
                                        warn9 = true 
                                    end
                                else
                                    warn8 = true
                                end
                            else
                                warn7 = true
                            end
                        else
                            warn6 = true
                        end
                    else
                        warn5 = true
                    end                          
                else
                    warn4 = true
                end
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




AddEventHandler('populationPedCreating', function()
    CancelEvent()
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
        local _ped = PlayerPedId()
        local _pid = PlayerId()
		SetPedInfiniteAmmoClip(PlayerPedId(), false)
		SetPlayerInvincible(PlayerId(), false)
		SetEntityInvincible(PlayerPedId(), false)
		SetEntityCanBeDamaged(PlayerPedId(), true)
		ResetEntityAlpha(PlayerPedId())
	    SetRunSprintMultiplierForPlayer(_pid, 1.0)
        SetSwimMultiplierForPlayer(_pid, 1.0)
        SetPedInfiniteAmmoClip(_ped, false)
        SetPlayerInvincible(_ped, false)
        SetEntityInvincible(_ped, false)
        SetEntityCanBeDamaged(_ped, true)
        ResetEntityAlpha(_ped)
    end
end)


RegisterNetEvent('Alireza_WhiteList')
AddEventHandler('Alireza_WhiteList', function()
    vaziyat = true
    SetTimeout(1000, function()
        vaziyat = false
    end)
end)

Citizen.CreateThread(function()
    while true do 
        Wait(100)
        coords = GetEntityCoords(PlayerPedId())
        Wait(500)
        coords2 = GetEntityCoords(PlayerPedId())
        if Vdist(coords, coords2) <= 200.0 then
        else
            ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
                if accept == false then
                    if vaziyat then
                       TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Mashkok Be Teleport Hack')
                    end
                end
            end)
        end
    end
end)


------nanato ezam mikonam artesh age copy paste koni madar jende !!!
Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(10000)
    local _aimassiststatus = GetLocalPlayerAimState()
    sadra()

    ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
        if accept == false then
            if GetPlayerWeaponDamageModifier(PlayerId()) > 1.0 then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Try TO modify Weapon TO  ('..GetPlayerWeaponDamageModifier(PlayerId()).. ') Normal : 1.0')
            end
        end
    end)
  end
end)





function sadra(source)
    ESX.TriggerServerCallback('AT_Cheking:Adminduty', function(accept)
        if accept == false then
            resources = GetNumResources()
            local _onresstarting = "onResourceStarting"
            local _onresstart = "onResourceStart"
            local _onclresstart = "onClientResourceStart"
            local _evhandler = AddEventHandler
            Citizen.Wait(30000)
            local _originalped = GetEntityModel(PlayerPedId())
            DisplayRadar(true)
            _evhandler(_onresstarting, function(res)
                if res ~= GetCurrentResourceName() then
                    TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Injection dll 79% ')
                end
            end)
            _evhandler(_onresstart, function(res)
                if res ~= GetCurrentResourceName() then
                   TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Injection dll 79% ')
                end
            end)
            _evhandler(_onclresstart, function(res)
                if res ~= GetCurrentResourceName() then
                  TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Injection dll 79% ')
                end
            end)
            local _ped = PlayerPedId()
            local _pid = PlayerId()
            local _Wait = Citizen.Wait
            SetRunSprintMultiplierForPlayer(_pid, 1.0)
            SetSwimMultiplierForPlayer(_pid, 1.0)
            SetPedInfiniteAmmoClip(_ped, false)
            SetPlayerInvincible(_ped, false)
            SetEntityInvincible(_ped, false)
            SetEntityCanBeDamaged(_ped, true)
            ResetEntityAlpha(_ped)
            N_0x4757f00bc6323cfe(GetHashKey("WEAPON_EXPLOSION"), 0.0)
            SetEntityProofs(_ped, false, false, false, false, false, false, false, false)
            SetPlayerTargetingMode(0)
            _Wait(300)
            local _phealth = GetEntityHealth(_ped)
            if GetPlayerInvincible(_pid) then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Invisable 99% ')
                SetPlayerInvincible(_pid, false)
            end
            SetEntityHealth(_ped,  _phealth - 2)
            _Wait(10)
            if not IsPlayerDead(_pid) then
                if GetEntityHealth(_ped) == _phealth and GetEntityHealth(_ped) ~= 0 then
                    TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Godmode (1) 99% ')
                elseif GetEntityHealth(_ped) == _phealth - 2 then
                    SetEntityHealth(_ped, GetEntityHealth(_ped) + 2)
                end
                _Wait(100)
                if GetEntityHealth(_ped) > 200 then
                    TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Godmode (2) 99% ')
                end
                _Wait(100)
                local _val, _bulletproof, _fireproof , _explosionproof , _collisionproof , _meleeproof, _steamproof, _p7, _drownProof = GetEntityProofs(_ped)
                if _bulletproof == 1 or _collisionproof == 1 or _meleeproof == 1 or _steamproof == 1 or _drownProof == 1 then
                    TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Godmode (3) 99% ')
                end
                _Wait(300)
            end
            if GetEntitySpeed(_ped) > 7 and not IsPedInAnyVehicle(_ped, true) and not IsPedFalling(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedRagdoll(_ped) then
                local _staminalevel = GetPlayerSprintStaminaRemaining(_pid)
                if tonumber(_staminalevel) == tonumber(0.0) then
                    TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Infinity stamina Eulen 99% ')
                end
            end
            if not CanPedRagdoll(_ped) and not IsPedInAnyVehicle(_ped, true) and not IsEntityDead(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedJacking(_ped) then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'NO ragdoll 99% ')
            end
            local _entityalpha = GetEntityAlpha(_ped)
            if not IsEntityVisible(_ped) or not IsEntityVisibleToScript(_ped) or _entityalpha <= 150 then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Invisable  99% ')
            end
            local _weapondamage = GetWeaponDamageType(GetSelectedPedWeapon(_ped))
            if _weapondamage == 4 or _weapondamage == 5 or _weapondamage == 6 or _weapondamage == 13 then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Explosive meele  99% ')
            end
            if not IsPedInAnyVehicle(_ped, true) and GetEntitySpeed(_ped) > 10 and not IsPedFalling(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedRagdoll(_ped) then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Speed hacking 99% ')
            end
            local _nres = GetNumResources()
            if resources -1 ~= _nres -1 or resources ~= _nres then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Silent resource stopped/started 90% ')
            end
            if ForceSocialClubUpdate == nil then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Tried to spoof 90%')
            end
            if ShutdownAndLaunchSinglePlayerGame == nil then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Tried to spoof 70%')
            end
            if ActivateRockstarEditor == nil then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Tried to spoof 70%')
            end
            if IsPlayerCamControlDisabled() ~= false then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Injected asi menu')
            end
            local _armor = GetPedArmour(_ped)
            if _armor > 100 then
                TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Tried to give armor to himself ')
            end
            local _ped = PlayerPedId()
            local _Wait = Citizen.Wait
            if not IsPedInAnyVehicle(_ped, false) then
                local _pos = GetEntityCoords(_ped)
                _Wait(3000)
                local _newped = PlayerPedId()
                local _newpos = GetEntityCoords(_newped)
                local _distance = #(vector3(_pos) - vector3(_newpos))
                if _distance > 30 and not IsEntityDead(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and _ped == _newped then
                    TriggerServerEvent('AT_Waring:player',GetPlayerServerId(PlayerId()), 'Noclip BETA ')
                end
            end
        end
    end)
end



function Chekingvehiclewarn(sender)
    if vehwarn1 then
        if vehwarn2 then
            if vehwarn3 then
                if vehwarn4 then
                    if  vehwarn5 then
                        if vehwarn6 then
                            TriggerServerEvent('JusticeAC_Ban:Permanet', sender, 'Try To Damage Vehicle Cheat 😣😣')
                        else
                            vehwarn6 = true
                        end
                    else
                        vehwarn5 = true
                    end
                else
                    vehwarn4 = true
                end
            else
                vehwarn3 = true
            end
        else
            vehwarn2 = true
        end
    else
        vehwarn1 = true
    end
end


AddEventHandler('onResourceStop', function(resourceName)
	if  resourceName == 'screenshot-basic' then
        TriggerServerEvent('BanPlayer', GetPlayerServerId(PlayerId()))
	end
end)

    
AddEventHandler("onClientResourceStop", function(res)
    TriggerServerEvent('AT_Waring:player', GetPlayerServerId(PlayerId()),'Try To Stop Recource : '..res )
end)


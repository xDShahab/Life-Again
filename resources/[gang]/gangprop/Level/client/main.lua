ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)



local PlayerData = {}
local Data = {}
local GangLevels = {
  1000,
  2500,
  6000,
  9500,
  12000,
  15000,
  19500,
  24000,
  28500,
  33000,
  45000,
  56000,
  71000,
  89000,
  100000
}
GangLevels[0] = 0

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    if PlayerData.gang.name ~= 'nogang' then
        ESX.TriggerServerCallback("gangs:GetGangLevel_XP", function(XP, Level, Pos) 
            if XP then Data.XP = math.floor(XP) end 
            if Level then Data.Level = math.floor(Level) end
            if Pos then Data.Pos = json.decode(Pos) end
            ShowXPBar()
            Citizen.Wait(15000)
            CreateRankBar(0, GangLevels[Data.Level + 1], Data.XP, Data.XP, Data.Level)
        end)
    end
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(data)
    PlayerData.gang = data
    if PlayerData.gang.name ~= 'nogang' then
      ESX.TriggerServerCallback("gangs:GetGangLevel_XP", function(XP, Level, Pos) 
            if XP then Data.XP = math.floor(XP) end 
            if Level then Data.Level = math.floor(Level) end
            if Pos then Data.Pos = json.decode(Pos) end
            ShowXPBar()
            CreateRankBar(0, GangLevels[Data.Level + 1], Data.XP, Data.XP, Data.Level)
        end)
    end
end)

local Arrived = false

RegisterNetEvent('gangs:Arrived')
AddEventHandler('gangs:Arrived', function()
  Arrived = true
end)

RegisterNetEvent('gangs:CreateXPThread')
AddEventHandler('gangs:CreateXPThread', function()
  SetNewWaypoint(Data.Pos.x, Data.Pos.y)
  ESX.ShowNotification("~h~Baraye Daryaft XP Bayad Be Khooneye Gang Khod Nazdik Shavid.")
  local Seceonds = 59
  local Minutes  = 9
  Citizen.CreateThread(function()
    while true do
      if Arrived then
        ESX.ShowMissionText("Zaman Baghi Mande : 0"..Minutes..":"..Seceonds)
        ESX.ShowNotification("~h~XP Gang Shoma Daryaft Shod.")
        SetTimeout(2000, function()
          Arrived = false
        end)
        break
      else
        if Seceonds < 10 then
          ESX.ShowMissionText("Zaman Baghi Mande : 0"..Minutes..":0"..Seceonds)
            if Seceonds == 0 then
              if Minutes == 0 and Seceonds == 0 then
                ESX.ShowNotification("~h~XP Gang Shoma Be Dalil Naresidan Dar Time Hazf Shod.")
                ESX.ShowMissionText("Zaman Baghi Mande : 00:00")
                break
              else
                Minutes = Minutes - 1
                Seceonds = 60
              end
            end
        else
            ESX.ShowMissionText("Zaman Baghi Mande : 0"..Minutes..":"..Seceonds)
        end
        Seceonds = Seceonds - 1
        Citizen.Wait(1000)
      end
    end
  end)
end)

RegisterNetEvent('gangs:AddXPtoGang')
AddEventHandler('gangs:AddXPtoGang', function(AddedXP)
  if Data.XP + AddedXP >= GangLevels[Data.Level + 1] then
    repeat
      CreateRankBar(0, GangLevels[Data.Level + 1], Data.XP, GangLevels[Data.Level + 1], Data.Level)
      Data.Level = Data.Level + 1
      AddedXP = Data.XP + AddedXP - GangLevels[Data.Level]
      Data.XP = 0
      TriggerEvent("RankUpMessage", "Gang Rank Up Shod", 500)
    until Data.XP + AddedXP < GangLevels[Data.Level + 1]
      if AddedXP > 0 then
      Data.XP = Data.XP + AddedXP
      end
      CreateRankBar(0, GangLevels[Data.Level + 1], 0, Data.XP, Data.Level)
  else
    CreateRankBar(0, GangLevels[Data.Level + 1], Data.XP, Data.XP + AddedXP, Data.Level)
    Data.XP = Data.XP + AddedXP
  end
end)

function ShowXPBar()
    Citizen.CreateThread(function()
      while PlayerData.gang.name ~= 'nogang' do
        Wait(1)
        if IsControlJustPressed(0, 137) then
          CreateRankBar(0, GangLevels[Data.Level + 1], Data.XP, Data.XP, Data.Level)
        end
      end
    end)
  end

function CreateRankBar(XP_StartLimit_RankBar, XP_EndLimit_RankBar, playersPreviousXP, playersCurrentXP, CurrentPlayerLevel, TakingAwayXP)
    RankBarColor = TakingAwayXP and 6 or 116
    if not HasHudScaleformLoaded(19) then
          RequestHudScaleform(19)
      while not HasHudScaleformLoaded(19) do
        Wait(1)
      end
    end
      BeginScaleformMovieMethodHudComponent(19, "SET_COLOUR")
      PushScaleformMovieFunctionParameterInt(RankBarColor)
      EndScaleformMovieMethodReturn()
      BeginScaleformMovieMethodHudComponent(19, "SET_RANK_SCORES")
      PushScaleformMovieFunctionParameterInt(XP_StartLimit_RankBar)
      PushScaleformMovieFunctionParameterInt(XP_EndLimit_RankBar)
      PushScaleformMovieFunctionParameterInt(playersPreviousXP)
      PushScaleformMovieFunctionParameterInt(playersCurrentXP)
      PushScaleformMovieFunctionParameterInt(CurrentPlayerLevel)
      PushScaleformMovieFunctionParameterInt(100)
      EndScaleformMovieMethodReturn()
end

RegisterNetEvent('RankUpMessage')
AddEventHandler('RankUpMessage', function(MsgText, setCounter)
	local scaleform = RequestScaleformMovie("mp_big_message_freemode")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	BeginTextComponent("STRING")
	AddTextComponentString(MsgText)
	EndTextComponent()
	PopScaleformMovieFunctionVoid()	

	local counter = 0
	local maxCounter = (setCounter or 200)
	while counter < maxCounter do
		counter = counter + 1
		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		Citizen.Wait(0)
	end
end)
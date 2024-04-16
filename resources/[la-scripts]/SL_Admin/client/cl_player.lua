local godmode = false
local infStamina = false
invisibility = false
local noRagDoll = false

-- GODMODE
RegisterNetEvent("skadmin:toggleGodmode")
AddEventHandler("skadmin:toggleGodmode", function()
  godmode = not godmode
  SetEntityInvincible(PlayerPedId(), godmode)
  if godmode then
    drawNotification("God mode activated")
  else
    drawNotification("God mode deactivated")
  end
end)

-- INFINITE STAMINA
RegisterNetEvent("skadmin:toggleInfStamina")
AddEventHandler("skadmin:toggleInfStamina", function()
  infStamina = not infStamina
  if infStamina then
    drawNotification("Infinite Stamina activated")
  else
    drawNotification("Infinite Stamina deactivated")
  end
end)

-- INVISIBILITY
RegisterNetEvent("skadmin:toggleInvisibility")
AddEventHandler("skadmin:toggleInvisibility", function()
  invisibility = not invisibility
  SetEntityVisible(PlayerPedId(), not invisibility, 0)
  SetForcePedFootstepsTracks(invisibility) -- TODO: all players ?!
  if invisibility then
    drawNotification("Invisibility activated")
  else
    drawNotification("Invisibility deactivated")
  end
end)

-- NO RAG DOLL
RegisterNetEvent("skadmin:toggleNoRagDoll")
AddEventHandler("skadmin:toggleNoRagDoll", function()
  noRagDoll = not noRagDoll
  SetPedCanRagdolll( PlayerPedId(), not noRagDoll )
  if noRagDoll then
    drawNotification("No Rag Doll activated")
  else
    drawNotification("No Rag Doll deactivated")
  end
end)
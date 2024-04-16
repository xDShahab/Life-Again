Config                            = {}
Config.DrawDistance               = 7.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 0, max = 0 }
Config.Locale                     = 'en'

Config.Blips = {
  { x = -321.32, y = -138.04, z = 38.01 }
}

Config.Zones = {
  mechanicActions = {
    Pos   = { x = -194.47, y = -1296.11, z = 31.3 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 0, g = 255, b = 0 },
    Type  = 20,
  },

  VehicleDeleter = {
    Pos = {x = -185.12, y = -1288.22, z = 31.30},
    Size  = { x = 1.2, y = 1.2, z = 1.2 },
    Color = { r = 22, g = 201, b = 34 },
    Type  = 24,
  },

  mechanicActions2 = {
    Pos   = { x = -210.36, y = -1337.22, z = 30.89 },
    Size  = { x = 0.8, y = 0.8, z = 0.8 },
    Color = { r = 22, g = 201, b = 34 },
    Type  = 21,
  },

  -- VehicleDeleter2 = {
  --   Pos   = { x = 1167.57, y = 2655.79, z = 38.04 },
  --   Size  = { x = 1.7, y = 1.7, z = 1.7 },
  --   Color = { r = 22, g = 201, b = 34 },
  --   Type  = 24,
  -- },
  -- mechanicActions3 = {
  --   Pos   = { x = -196.75, y = -1319.8, z = 31.09 },
  --   Size  = { x = 0.8, y = 0.8, z = 0.8 },
  --   Color = { r = 22, g = 201, b = 34 },
  --   Type  = 21,
  -- },

  -- VehicleDeleter3 = {
  --   Pos   = { x = -230.75, y = -1283.25, z = 31.3 },
  --   Size  = { x = 1.7, y = 1.7, z = 1.7 },
  --   Color = { r = 22, g = 201, b = 34 },
  --   Type  = 24,
  -- },
}

Config.VehicleSpawnPoint = {
  [1] = {
    Pos   = { x = -185.12, y = -1288.22, z = 30.95},
    Heading = 71.69,
  },

}

Config.Towables = {
 
}

for i=1, #Config.Towables, 1 do
  Config.Zones['Towable' .. i] = {
    Pos   = Config.Towables[i],
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 204, g = 204, b = 0 },
    Type  = 1
  }
end

Config.Vehicles = {
  'RAPTOR150',
  'rx7cwest',
  'nysanabi'
}

Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke E, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = 'Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Press E, to access the DJ desk',
        ['title_does_not_exist'] = 'This title does not exist!',
    }
}

Config.Locale = 'en'

Config.useESX = true -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'bahama',
        pos = vector3(-1378.48, -629.4, 30.63),
        requiredJob = nil, 
        range = 65.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    }

    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}
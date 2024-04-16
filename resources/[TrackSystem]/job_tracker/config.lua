Config = {}

Config.selfBlip = true -- use classic arrow or job specified blip?
Config.useRflxMulti = false -- server specific init
Config.useBaseEvents = false -- F for optimisation
Config.prints = false -- server side prints (on/off duty)

-- looks
Config.font = {
    useCustom = false, -- use custom font? Has to be specified below, also can be buggy with player tags
    name = 'Russo One', -- > this being inserted into <font face='nameComesHere'> eg. (<font face='Russo One'>) --> Your font has to be streamed and initialized on ur server
}
Config.notifications = {
    enable = true,
    useMythic = true,
    onDutyText = 'Přišel/a jste do služby', -- pretty straight foward
    offDutyText = 'Odešel/a jste ze služby', -- pretty straight foward
}
Config.blipGroup = {
    renameGroup = false,
    groupName = 'Other units'
}

-- blips
Config.bigmapTags = true -- Playername tags when bigmap enabled?
Config.blipCone = true -- use that wierd FOV indicators thing?

Config.useCharacterName = true -- use IC name or OOC name, chose your warrior
Config.usePrefix = true
Config.namePrefix = { -- global name prefixes by grade_name 
    -- recruit = 'CAD.',
    -- officer = 'P/O-1.',
    -- officer2 = 'P/O-2.',
    -- officer3 = 'P/O-3.',
    -- sergeant = 'SGT-1.',
    -- sergeant2 = 'SGT-2.',
    -- lieutenant = 'LTN.',
    -- captain = 'CAPT.',
    -- commander = 'COM.',
    -- deputy = 'DPT.',
    -- aschief = 'AS-CHF.',
    -- boss = 'CHF.',

    -- deputy1 = 'DPT-1.',
    -- deputy2 = 'DPT-2.',
    -- assheriff = 'AS-SHRF.',
    -- undersheriff = 'UNSHRF.',
    -- boss_shrf = 'SHRF-COP.',
}

--[[
  Full config template:

    ['police'] = { --> job name in database
        ignoreDuty = true, -- if ignore, you don't need to call onDuty or offDuty by exports or event, player is on map while he has that job
        blip = {
            sprite = 60, -- on foot blip sprite (required)
            color = 29, -- on foot blip color (required)
            scale = 0.8, -- global blip scale 1.0 by default (not required)
            flashColors = { -- blip flash when siren ON! You can define as many colors as you want! //// If you don't want to use flash, then just delete it (not required)
                59,
                29,
            }
        },
        vehBlip = { -- in vehicle blip config, if you don't want to use it, just delete it (not required)
            ['default'] = { -- global in vehicle blip (required if you have "vehBlip" defined)
                sprite = 56,
                color = 29,
            },
            [`ambluance`] = { -- this overrides 'default' blip by vehicle hash, hash has to be between ` eg. `spawnnamehere`
                sprite = 56,
                color = 29,
            },
            [`police2`] = {
                sprite = 56,
                color = 29,
            }
        },
        gradePrefix = { -- global Config.namePrefix override (not required)
            [0] = 'CAD.', -- 0 = grade number in database | 'CAD. ' is label obv..
        },
        canSee = { -- What job can see this job, when not defined they'll see only self job --> police will see only police blips (not required)
            ['police'] = true,
            ['sheriff'] = true,
            ['shreck'] = true, --> this cfg has to be in specified format "['jobname'] = true"
        }
    },
--]]

Config.emergencyJobs = {
    ['police'] = {
        ignoreDuty = true,
        blip = {
            sprite = 60,
            color = 29,
            flashColors = {
                59,
                29,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 56,
                color = 29,
            },
        },

        canSee = {
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['fbi'] = true,
            ['artesh'] = true,
            ['Blackguard'] = true,
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead Officer',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'Deputy Chief',
        [8] = 'Chief',
        },
    },
    ['sheriff'] = {
        ignoreDuty = true,
        blip = {
            sprite = 58,
            color = 28,
            flashColors = {
                59,
                28,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 56,
                color = 28,
            },
        },
        canSee = {
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['fbi'] = true,
            ['Blackguard'] = true,
            ['artesh'] = true,
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead Officer',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'Division Chief',
        [8] = 'Chief',
        },
    },
    ['fbi'] = {
        ignoreDuty = true,
        blip = {
            sprite = 484,
            color = 40,
            flashColors = {
                59,
                40,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 56,
                color = 40,
            },
        },
        canSee = {
            ['fbi'] = true,
            ['artesh'] = true,
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead Officer',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'Division Chief',
        [8] = 'Chief',
        },
    },
    ['army'] = {
        ignoreDuty = true,
        blip = {
            sprite = 480,
            color = 25,
            flashColors = {
                59,
                25,
            }
        },
        canSee = {
            ['army'] = true,
            ['ambukance'] = true,
            ['Blackguard'] = true,
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 25,
            },
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead Officer',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'Division Chief',
        [8] = 'Chief',
        },
    },
    ['artesh'] = {
        ignoreDuty = true,
        blip = {
            sprite = 480,
            color = 25,
            flashColors = {
                59,
                25,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 25,
            },
        },
        canSee = {
            ['artesh'] = true,
            ['ambukance'] = true,
            ['Blackguard'] = true,
            ['police'] = true,
            ['sheriff'] = true,
        },
        gradePrefix = {
        [0] = 'Cadet',
        [1] = 'Police Officer I',
        [2] = 'Police Officer II',
        [3] = 'Police Officer III',
        [4] = 'Senior Lead Officer',
        [5] = 'Sergeant',
        [6] = 'Commander',
        [7] = 'Division Chief',
        [8] = 'Chief',
        },
    },
    ['ambulance'] = {
        ignoreDuty = true,
        blip = {
            sprite = 1,
            color = 0,
            flashColors = {
                0,
                59,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 0,
            },
        },
        canSee = {
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['fbi'] = true,
        }
    },
    ['taxi'] = {
        ignoreDuty = true,
        blip = {
            sprite = 198,
            color = 46,
            flashColors = {
                46,
                46,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 198,
                color = 46,
            },
        },
        canSee = {
            ['ambulance'] = true,
            ['taxi'] = true,
            ['Blackguard'] = true,
        }
    },
    ['mechanic'] = {
        ignoreDuty = true,
        blip = {
            sprite = 402,
            color = 56,
            flashColors = {
                56,
                56,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 56,
            },
        },
        canSee = {
            ['mechanic'] = true,
            ['Blackguard'] = true,
        }
    },
    ['benny'] = {
        ignoreDuty = true,
        blip = {
            sprite = 402,
            color = 31,
            flashColors = {
                31,
                31,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 31,
            },
        },
        canSee = {
            ['benny'] = true,
            ['Blackguard'] = true,
        }
    },
    ['Blackguard'] = {
        ignoreDuty = true,
        blip = {
            sprite = 468,
            color = 27,
            flashColors = {
                27,
                27,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 27,
            },
        },
        canSee = {
            ['Blackguard'] = true,
        }
    },
    ['dadgostari'] = {
        ignoreDuty = true,
        blip = {
            sprite = 468,
            color = 27,
            flashColors = {
                27,
                27,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 27,
            },
        },
        canSee = {
            ['dadgostari'] = true,
            ['Blackguard'] = true,
            ['police'] = true,
            ['ambulance'] = true,
            ['sheriff'] = true,
            ['fbi'] = true,
        }
    },
    ['weazel'] = {
        ignoreDuty = true,
        blip = {
            sprite = 468,
            color = 30,
            flashColors = {
                27,
                27,
            }
        },
        vehBlip = {
            ['default'] = {
                sprite = 225,
                color = 27,
            },
        },
        canSee = {
            ['weazel'] = true,
        }
    },
}
local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["-"] = 84,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = false -- If true, police will be able to search players' trunks.

Config.Locale = "en"

Config.OpenKey = Keys["LEFTALT"]

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 1000

Config.localWeight = {
    bread = 125,
    water = 330,
    WEAPON_SMG = 15000,
	alive_chicken           = 250,
    slaughtered_chicken     = 250,
    packaged_chicken        = 1000,
    fish                    = 1000,
    stone                   = 1000,
    washed_stone            = 250,
    copper                  = 200,
    iron                    = 150,
    gold                    = 330,
    diamond                 = 30,
    wood                    = 1000,
    cutted_wood             = 1000,
    packaged_plank          = 5000,
    petrol                  = 4000,
    petrol_raffin           = 2000,
    essence                 = 4000,
    wool                    = 250,
    fabric                  = 1000,
    clothe                  = 4000,
    goldmedal               = 1,
    silvermedal             = 1,
    bronzemedal             = 1,
    water                   = 150,
    bread                   = 150,
    contrat                 = 1000,
    armor                   = 1000,
    cutting_pliers          = 500,
    handcuff                = 500,
    bandage                 = 500,
    medikit                 = 1000,
    
    weed                    = 500,
    coke                    = 1000,
    meth                    = 20000,
    opium                   = 1000,
    poppy                   = 4000,
    heroine                 = 10000,
    cannabis                = 3000,
    marijuana               = 3000,
    ephedra                 = 4000,
    ephedrine               = 4000,
    coca                    = 1000,
    cocaine                 = 5000,
    crack                   = 10000,

    meat                    = 500,
    leather                 = 500,
    firstaidkit             = 1500,
    defibrillateur          = 5000,
    gazbottle               = 500,
    fixtool                 = 8000,
    carotool                = 8000,
    blowpipe                = 1000,
    fixkit                  = 1000,
    carokit                 = 1000,
    fishbait                = 1000,
    fishingrod              = 500,
    shark                   = 1000,
    turtle                  = 1000,
    turtlebait              = 1000,
    clip                    = 5000,
    pizza                   = 500,
    scratchoff              = 10,
    scratchoff_used         = 10,
    jewels                  = 200000,
    WEAPON_NIGHTSTICK       = 500,
    WEAPON_STUNGUN          = 1000,
    WEAPON_FLASHLIGHT       = 500,
    WEAPON_FLAREGUN         = 1000,
    WEAPON_FLARE            = 1000,
    WEAPON_COMBATPISTOL     = 2500,
    WEAPON_HEAVYPISTOL      = 4000,
    WEAPON_ASSAULTSMG       = 7000,
    WEAPON_COMBATPDW        = 7000,
    WEAPON_BULLPUPRIFLE     = 8000,
    WEAPON_PUMPSHOTGUN      = 8000,
    WEAPON_BULLPUPSHOTGUN   = 10000,
    WEAPON_CARBINERIFLE     = 10000,
    WEAPON_ADVANCEDRIFLE    = 10000,
    WEAPON_MARKSMANRRIFLE   = 15000,
    WEAPON_SNIPERRIFLE      = 15000,
    WEAPON_FIREEXTINGUISHER = 1500, 
    GADGET_PARACHUTE        = 5000,
    WEAPON_BAT              = 1500,
    WEAPON_PISTOL           = 5000,
    money                   = 10,
}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 70000, --SUV
    [3] = 25000, --Coupes
    [4] = 30000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 5000, --Motorcycles
    [9] = 180000, --Off-road
    [10] = 300000, --Industrial
    [11] = 70000, --Utility
    [12] = 100000, --Vans
    [13] = 0, --Cycles
    [14] = 5000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 300000, --Commercial
    [21] = 0 --Trains
}

Config.CustomLimit = {
    {model = GetHashKey('lex570'), limit = 500000},
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mechanic = "MECA"
}

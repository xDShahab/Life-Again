config = {

    -- How often do we want to send updates to the clients show the blips have updated
    client_update_interval = 2000,

    -- How long should we wait before iterating on the next group
    -- This value should be nowhere close to the value above, and should be less then
    wait_between_group_in_thread = 100,

    -- Toggle showing your own blip on the map
    hide_own_blip = true,

    -- Should we debug?
    debug = false,

    -- This is where you can create custom blip types
    -- Colors - https://runtime.fivem.net/doc/natives/?_0x03D7FB09E75D6B7E
    blip_types = {

        ['GroveSreet'] = {
            _can_see = { 'GroveSreet' },
            _color = 1,
        },
        ['HyzeR'] = {
            _can_see = { 'HyzeR' },
            _color = 1,
        },
        ['Mafia'] = {
            _can_see = { 'Mafia' },
            _color = 1,
        },
        

    },

    -- Default settings for a group when one can not be found in the predefined list
    -- These options will be used when creating a "custom blip channel"
    default_type = {
        _color = 0,
        _type = 1,
        _scale = 0.85,
        _alpha = 255,
        _show_off_screen = false,
        _show_local_direction = false,
    }
}
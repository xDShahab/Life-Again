function Alert(title, message, time, type)
    SendNUIMessage({
        action = 'open',
        title = title,
        type = type,
        message = message,
        time = time
    })
end

RegisterNetEvent('At_Notfication:Alert')
AddEventHandler('At_Notfication:Alert', function(title, message, time, type)
    Alert(title, message, time, type)
end)


RegisterCommand('allnotify', function()
    exports['At_Notfication']:Alert("SUCCESS", "This scirpts it's by <span style='color:#1ca800'>DILZA CORE</span>!", 5000, 'success')

    exports['At_Notfication']:Alert("INFO", "This scirpts it's by <span style='color:#1c77ff'>DILZA CORE</span>!", 5000,'info')

    exports['At_Notfication']:Alert("ERROR", "This scirpts it's by <span style='color:#ff1c1c'>DILZA CORE</span>!", 5000,'error')

    exports['At_Notfication']:Alert("WARNING", "This scirpts it's by <span style='color:#ffd51c'>DILZA CORE</span>!",5000, 'warning')

    exports['At_Notfication']:Alert("SMS","<span style='color:#ff9d1c'>Tommy: </span> Have you already visited dilza laboratory??", 5000, 'phonemessage')

    exports['At_Notfication']:Alert("LONG MESSAGE", "This scirpts it's by <span style='color:#494446'>DILZA CORE</span>!",5000, 'neutral')
end)

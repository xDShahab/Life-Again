ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterCommand('record', function(source, args)
    local Xplayer  =  ESX.GetPlayerFromId(source)
    if Xplayer.Group == 'Editor' then
        StartRecording(1)
        TriggerClientEvent('esx:showNotification',source, "Record Start Shod")
    else
        TriggerClientEvent('esx:showNotification',source, "Baray Estefadeh Az in Commadn Bayad Editor Bashid")
    end
end)


RegisterCommand('srecord', function(source, args)
    local Xplayer  =  ESX.GetPlayerFromId(source)
    if Xplayer.Group == 'Editor' then
        StopRecordingAndSaveClip()
        TriggerClientEvent('esx:showNotification',source, "Record Stop Shod")
    else
        TriggerClientEvent('esx:showNotification',source, "Baray Estefadeh Az in Commadn Bayad Editor Bashid")
    end
end)



RegisterCommand('editor', function(source, args)
    local Xplayer  =  ESX.GetPlayerFromId(source)
    if Xplayer.Group == 'Editor' then
        NetworkSessionLeaveSinglePlayer()
        ActivateRockstarEditor()
        TriggerClientEvent('esx:showNotification',source, "Record Menu On  Shod")
    else
        TriggerClientEvent('esx:showNotification',source, "Baray Estefadeh Az in Commadn Bayad Editor Bashid")
    end
end)


RegisterCommand('stopdis', function(source, args)
    local Xplayer  =  ESX.GetPlayerFromId(source)
    if Xplayer.Group == 'Editor' then
        StartRecording(1)
        TriggerClientEvent('esx:showNotification',source, "Record Menu Stop  Shod")
    else
        TriggerClientEvent('esx:showNotification',source, "Baray Estefadeh Az in Commadn Bayad Editor Bashid")
    end
end)



    -- Kiram To Sath AT o Server Zadanesh
-- In Resource Tavasot xCoore Public Shode Va Hargone Foroshesh Neshan Dahande Madar Jende Bodanetone 

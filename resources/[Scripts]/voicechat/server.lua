RegisterCommand("testp", function(source, args, raws)
    local channel = tonumber(args[1])
    if channel then
        TriggerClientEvent("testPhone", -1, channel)
    end
end, false)
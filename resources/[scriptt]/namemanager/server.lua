ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local alln = {}
MySQL.ready(function()
		local names = MySQL.Sync.fetchAll("SELECT * FROM users")

		for i = 1, #names, 1 do
            local names = names[i]
            local fullname = names.playerName
            local first = nil
            local last = nil
            alln[names.identifier]= names.SName or names.playerName
            if string.find(fullname, '_') then
                local formatname = string.gsub(fullname , "_", " ")
                string.gsub(formatname, "(%w+)", function(w)
                    if first == nil then 
                        first = w 
                    else
                        last = w
                    end
                end)
                if names.firstname ~= first then
                        MySQL.Async.execute(
                            "UPDATE users SET firstname = @firstname WHERE playerName = @playerName",
                            {
                                ["@playerName"] = fullname,
                                ["@firstname"] = first
                            }
                        )
                end
                if names.lastname ~= last then
                        MySQL.Async.execute(
                            "UPDATE users SET lastname = @lastname WHERE playerName = @playerName",
                            {
                                ["@playerName"] = fullname,
                                ["@lastname"] = last
                            }
                        )
                end
            else
                local formatname = fullname..' '..fullname
                string.gsub(formatname, "(%w+)", function(w)
                    if first == nil then 
                        first = w 
                    else
                        last = w
                    end
                end)
                if names.firstname ~= first then
                        MySQL.Async.execute(
                            "UPDATE users SET firstname = @firstname WHERE playerName = @playerName",
                            {
                                ["@playerName"] = fullname,
                                ["@firstname"] = first
                            }
                        )
                end
                if names.lastname ~= last then
                        MySQL.Async.execute(
                            "UPDATE users SET lastname = @lastname WHERE playerName = @playerName",
                            {
                                ["@playerName"] = fullname,
                                ["@lastname"] = last
                            }
                        )
                end
            end
        end
end)


AddEventHandler('esx:playerLoaded', function(source)
    local Xp = ESX.GetPlayerFromId(source)
    local hex = Xp.identifier
    local steamname = GetPlayerName(source)
    --------
    local fullname = Xp.name
    local last = nil
    local first = nil
    if string.find(fullname, '_') then
        fullname = string.gsub(fullname , "_", " ")
        string.gsub(fullname, "(%w+)", function(w)
            if first == nil then 
                first = w 
            else
                last = w
            end
        end)
        if first then
                MySQL.Async.execute(
                    "UPDATE users SET firstname = @firstname WHERE identifier = @identifier",
                    {
                        ["@identifier"] = hex,
                        ["@firstname"] = first
                    }
                )
        end
        if last then
                MySQL.Async.execute(
                    "UPDATE users SET lastname = @lastname WHERE identifier = @identifier",
                    {
                        ["@identifier"] = hex,
                        ["@lastname"] = last
                    }
                )
        end
    end
end)
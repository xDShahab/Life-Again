ESX = nil
labels = {}
netIds = {}
timePlays = {}
TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)

RegisterServerEvent('esx_idoverhead:changeLabelHideStatus')
AddEventHandler('esx_idoverhead:changeLabelHideStatus', function(id, status)

    if id == nil then return end
    if type(status) ~= "boolean" then return end

	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.permission_level > 1 then
        if labels[id] then
            TriggerClientEvent('esx_idoverhead:changeLabelHideStatus', -1, id, status)
        end
	end
end)    

RegisterNetEvent('esx_idoverhead:modifyLabel')
AddEventHandler('esx_idoverhead:modifyLabel', function(id, label)

    if id == nil then return end
    if label == nil then return end

    local xPlayer = ESX.GetPlayerFromId(source)

    if label.badge == false then

        if xPlayer.permission_level > 1 then

            if not labels[id] then
                labels[id] = {}
            end

            if DoesTagExist(id, label.badge) then
                RemoveTag(id, label.badge)
            end
            
            if not DoesTagExist(id, label.badge) then
                table.insert(labels[id], label)
                TriggerClientEvent("esx_idoverhead:modifyLabel", -1, id, label)
                AddToNet("label", id)
            end
                
        else
        DropPlayer(source,"Dont Do it Again :)")
        end

    end

end)

RegisterNetEvent('esx_idoverhead:removeLabel')
AddEventHandler('esx_idoverhead:removeLabel', function(id, state)

    if id == nil then return end
    if state == nil then return end

    local xPlayer = ESX.GetPlayerFromId(source)

    if state == false then

        if xPlayer.permission_level > 1 then


            if DoesTagExist(id, state) then
                RemoveTag(id, state)
            end
    
            if not DoesTagExist(id, state) then
                TriggerClientEvent('esx_idoverhead:updateLabels', -1, labels)
            end
                
        else
        DropPlayer(source,"Dont Do it Again :)")
        end
    end

end)

AddEventHandler('esx:playerLoaded', function(source)

    local _source = source
    TriggerClientEvent('esx_idoverhead:updateLabels', source, labels)

end)


function addNewPlayer(source, id, label)
    if id == nil then return end
    if label == nil then return end

    if label.badge == true then

        if not labels[id] then
            labels[id] = {}
        end

        if DoesTagExist(id, label.badge) then
            RemoveTag(id, label.badge)
        end
        
        if not DoesTagExist(id, label.badge) then
            table.insert(labels[id], label)
            TriggerClientEvent("esx_idoverhead:modifyLabel", -1, id, label)
        end


    else
        DropPlayer(source,"Dont Do it Again :)")
    end

end

function DoesTagExist(player, badge)
    for k,v in pairs(labels[player]) do
        if v.badge == badge then
            return true
        end
    end

    return false
end


function RemoveTag(player, badge)
    for k,v in pairs(labels[player]) do
        if v.badge == badge then
            labels[player][k] = nil
        end
    end
end

function AddToNet(source, netType, id)
    if source == nil then return end
    if netType == nil then return end

    local identifier = GetPlayerIdentifier(source)

    if netIds[identifier] == nil then
        netIds[identifier] = {}
    end

    if netIds[identifier][netType] == nil then
        netIds[identifier][netType] = id
    end 
end
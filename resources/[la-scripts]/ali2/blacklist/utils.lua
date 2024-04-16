function sendForbiddenMessage(message)
	TriggerEvent("chatMessage", "", {0, 0, 0}, "^1" .. message)
end

function _DeleteEntity(entity)
	DeleteEntity(entity)
end



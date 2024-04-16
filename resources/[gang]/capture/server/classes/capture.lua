-- Config              = {}
-- Config.TimerInSec   = 3600


function CreateCapture(name, coords, time, handeler,weapon,repoint,car)

    local self    = {}
    
    self.handeler = {
        [1] = 'handeler',
        [2] = 'handeler',
        [3] = 'handeler',
    }

    self.reward   = ''

    self.timer    = os.time(os.date("!*t")) + time

    self.untilEnd = function()
        return self.timer - os.time(os.date("!*t"))
    end

    self.capData  = {
        name      = name,
        coords    = coords,
        weapon    = weapon,
        gang      = handeler,
        repoint   = repoint,
        car       = car
    }

    self.NewHandeler  = function(handeler,num)
        self.handeler[num]       = handeler
        self.capData.gang   = handeler
        -- self.timer          = os.time(os.date("!*t")) + Config.TimerInSec
        TriggerClientEvent('capture:ChangeCaptureHandler', -1, self.handeler[num], num , self.untilEnd())
        -- self.ActivateCapture()
    end

    self.CaptureStatus = function()
        if self.timer then
            local secondsAfterLastCapture = self.timer - os.time(os.date("!*t"))
            if secondsAfterLastCapture <= 1 then
                return true
            else
                return false
            end
        else
            return 0
        end
    end

    self.GiveReward = function()
        ::check::
        local cap1= {}
        local winner = nil
        for _,v in ipairs(self.handeler) do
            cap1[_] = v
        end
        if coords[1] and coords[2] and coords[3] then
            if cap1[1] == cap1[2] then
                winner = cap1[2]
            elseif  cap1[1] == cap1[3] then
                winner = cap1[3]
            elseif cap1[3] == cap1[2] then
                winner = cap1[3]
            end
        elseif coords[1] and coords[2] then
            if cap1[1] == cap1[2] then
                winner = cap1[2]
            end
        elseif coords[1] then
            winner = cap1[1]
        end

        if not winner or winner == 'handeler' then
            Wait(1000)
            goto check
        else
            TriggerEvent('capture:finish', winner)

    
            -- TriggerEvent('ResourceManager:EndCapture') Maybe you deserve it later :D
            -- TriggerEvent(self.reward, self.handeler)
            LiveCapture = nil
        end
    end

    self.ActivateCapture = function()
        SetTimeout(time * 1000, function()
            if self.CaptureStatus() then
                self.GiveReward()
            end
        end)
    end

    -- Give notification About Starting Capture
    -- TriggerClientEvent('capture:CaptureStarted', -1, self.capData, self.untilEnd())
    self.ActivateCapture()

    return self
end
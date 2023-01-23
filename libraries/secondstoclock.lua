--time management--

_G["SecondsToClock"] = function (seconds)
    local days = math.floor(seconds / 86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds / 3600 )
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds / 60) 
    seconds = seconds - minutes * 60

    if days ~= 0 then
        return string.format("%d days, %d hours, %d minutes, %d seconds",days,hours,minutes,seconds)
    else if hours ~= 0 then
        return string.format("%d hours, %d minutes, %d seconds",hours,minutes,seconds)
    else if minutes ~=0 then
        return string.format("%d minutes, %d seconds",minutes,seconds)
    else if seconds ~=0 then
        return string.format("%d seconds",seconds)
    end end end end
    --return string.format("%d days, %d hours, %d minutes, %d seconds.",days,hours,minutes,seconds)

end

--print(SecondsToClock(8643660))
--print(SecondsToClock(3660))
--print(SecondsToClock(60))
--print(SecondsToClock(30))
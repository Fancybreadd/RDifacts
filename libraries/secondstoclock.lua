function SecondsToClock(seconds)
    local days = math.floor(seconds / 86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds / 3600 )
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds / 60) 
    seconds = seconds - minutes * 60
    
    --return string.format("%d days, %d hours, %d minutes, %d seconds.",days,hours,minutes,seconds)
    return string.format("%d hours, %d minutes, %d seconds",hours,minutes,seconds)
end
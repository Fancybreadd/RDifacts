local command = {}
function command.run(message)
    local profileID = message.author.id
    local check = io.open(path..profileID..".json","r")
    print("cooldown")
    --==--
    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))

        local advtimeleft = jsonstats.timers.adventuretimer + ADVCOOLDOWN - os.time() --gets time left in unixtime
        local keytimeleft = jsonstats.timers.keytimer + DKCOOLDOWN - os.time()

        print(advtimeleft)
        print(keytimeleft)

        local advrealtime = SecondsToClock(advtimeleft) --turn that into readable time (hours, minutes, seconds)
        local keyrealtime = SecondsToClock(keytimeleft)

        local keyresult = ""
        local advresult = ""

        if keytimeleft <= 0 then
            keyresult = "Ready!"
        else
            keyresult = keyrealtime
        end
        if advtimeleft <= 0 then
            advresult = "Ready!"
        else
            advresult = advrealtime
        end
        --print(advrealtime)

        message.channel:send(message.author.mentionString..", Your cooldowns are.." --(!!)
        .."\n\n<:boxkey:974300640178221106> **h$dailykey:** ``"..keyresult.."``"
        .."\n<:adventuring:974300665436340235> **h$adventure:** ``"..advresult.."``"
        )
    else noprofile(message)
    end
end
return command --

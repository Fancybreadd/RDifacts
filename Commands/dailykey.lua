local command = {}
function command.run(message)
    print("dailykey")
    --------------------------------------------------------------------FILESELECT
    local profileID = message.author.id
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")

    --==--
    if not check then
        local profile = io.open(BotPath.."PROFILES/"..profileID..".json","w")
        noprofile(message)
        check = makeprofile(profile, profileID)
    end
    --==--

    --------------------------------------------------------------------INFO
    local jsonstats = json.decode(io.input(check):read("*a"))
    local currenttime = os.time()
    local playercooldown = jsonstats.timers.keytimer + DKCOOLDOWN
    --local randomplus = math.random(4,20)

    --------------------------------------------------------------------CHECKS
    if currenttime < playercooldown then --if cooldown still active
        check:close()
        local remainingtime = playercooldown - currenttime --gets remaining unix time 
        --print(remainingtime)
        local readableremainingtime = SecondsToClock(remainingtime)

        message.channel:send(message.author.username..", you try and grab a key.. but the keygiver stops you! \n**"..readableremainingtime.." left!**")
        return
    end

    --------------------------------------------------------------------COMMAND
    jsonstats.timers.keytimer = os.time()
    jsonstats.wallet.keys = jsonstats.wallet.keys + 1 updatesave(profileID, jsonstats, check) --(S)

    message.channel:send{
        embed = {
            color = 0x13ff7b, title = "Daily Key!",

            author = {
                name = message.author.username.."'s r$dailykey",
                icon_url = message.author.avatarURL
            }, --

            description = "You head to the dwarf keysmith for your daily **Key** "..MenuKEY..". The dwarf checks his logbook, makes sure you're viable to get yours, and hands it to you!",
            fields = {
                {
                    name = "+1 Key "..MenuKEY,
                    value = ""
                }
            }
        }
    }
end
return command --
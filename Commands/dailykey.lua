local command = {}
function command.run(message)
    print("dailykey")
    --------------------------------------------------------------------FILESELECT
    --single
    local profileID = message.author.id 
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    local username = message.author.username
    local iconurl = message.author.avatarURL

    --==--
    if not check then
        check = makeprofile(profileID)
        noprofile(message)
    end
    --==--

    local jsonstats = json.decode(io.input(check):read("*a"))

    --verify(profileID)

    --------------------------------------------------------------------INFO
    local currenttime = os.time()
    local playercooldown = jsonstats.timers.keytimer + DKCOOLDOWN
    --local randomplus = math.random(4,20)

    --------------------------------------------------------------------CHECKS
    if currenttime < playercooldown then --|if cooldown still active
        check:close()
        local remainingtime = playercooldown - currenttime --gets remaining unix time 
        --print(remainingtime)
        local readableremainingtime = SecondsToClock(remainingtime)

        message.channel:send{
            embed = {
                color = 0x13ff7b, title = "Daily Key...?",

                author = {
                    name = username.."'s r$dailykey",
                    icon_url = iconurl
                }, --

                description = "You head to the dwarf keysmith for your daily **Key** "..MenuKEY..". The dwarf checks his logbook, and tells you yours isn't ready yet.",
                fields = {
                    {
                        name = "Command isn't ready!",
                        value = ""
                    }
                },
                footer = {text = "You can r$dailykey again in "..readableremainingtime}
            }
        }

        return
    end

    --------------------------------------------------------------------COMMAND
    jsonstats.timers.keytimer = os.time()
    jsonstats.wallet.keys = jsonstats.wallet.keys + 1 updatesave(profileID, jsonstats, check) --(S)

    message.channel:send{
        embed = {
            color = 0x13ff7b, title = "Daily Key!",

            author = {
                name = username.."'s r$dailykey",
                icon_url = iconurl
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
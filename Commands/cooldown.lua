local command = {}
function command.run(message)
    print("cooldown")
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

    --------------------------------------------------------------------COMMAND
    local advtimeleft = jsonstats.timers.adventuretimer + ADVCOOLDOWN - os.time()
    local keytimeleft = jsonstats.timers.keytimer + DKCOOLDOWN - os.time()
    local gkeytimeleft = jsonstats.timers.giftkeytimer + GKCOOLDOWN - os.time()
    print(advtimeleft) print(keytimeleft)

    --turn that into readable time (hours, minutes, seconds)
    local advrealtime = SecondsToClock(advtimeleft)
    local keyrealtime = SecondsToClock(keytimeleft)
    local gkeyrealtime = SecondsToClock(gkeytimeleft)

    local keyresult = "" local advresult = "" local gkeyresult = ""

    if keytimeleft <= 0 then keyresult = "Ready!" else keyresult = keyrealtime end
    if advtimeleft <= 0 then advresult = "Ready!" else advresult = advrealtime end
    if gkeytimeleft <= 0 then gkeyresult = "Ready!" else gkeyresult = gkeyrealtime end

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0x177dff, title = "Cooldowns",
            author = {
                name = username.."'s r$cooldown",
                icon_url = iconurl
            },

            fields = {
                {
                    name = MenuKEY.."  r$dailykey [r$dk]",
                    value = "``"..keyresult.."``"
                },
                {
                    name = MenuGIFTKEY.."  r$giftkey [r$gk]",
                    value = "``"..gkeyresult.."``"
                },
                {
                    name = MenuADV.."  r$adventure [r$adv]",
                    value = "``"..advresult.."``"
                }
            }
        }
    }
    check:close()
end
return command --

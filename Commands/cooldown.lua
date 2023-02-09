local command = {}
function command.run(message)
    print("cooldown")
    local profileID = message.author.id
    local check = io.open(path..profileID..".json","r")
    --==--
    if not check then
        local profile = io.open(path..profileID..".json","w")
        noprofile(message)
        check = makeprofile(profile, profileID)
    end
    --==--
    local jsonstats = json.decode(io.input(check):read("*a"))

    local advtimeleft = jsonstats.timers.adventuretimer + ADVCOOLDOWN - os.time() --gets time left in unixtime
    local keytimeleft = jsonstats.timers.keytimer + DKCOOLDOWN - os.time()
    local gkeytimeleft = jsonstats.timers.giftkeytimer + GKCOOLDOWN - os.time()

    print(advtimeleft) print(keytimeleft)    --print(advrealtime)
    --turn that into readable time (hours, minutes, seconds)
    local advrealtime = SecondsToClock(advtimeleft) local keyrealtime = SecondsToClock(keytimeleft) local gkeyrealtime = SecondsToClock(gkeytimeleft)

    local keyresult = "" local advresult = "" local gkeyresult = ""

    if keytimeleft <= 0 then keyresult = "Ready!" else keyresult = keyrealtime end
    if advtimeleft <= 0 then advresult = "Ready!" else advresult = advrealtime end
    if gkeytimeleft <= 0 then gkeyresult = "Ready!" else gkeyresult = gkeyrealtime end

    message.channel:send{
        embed = {
            color = 0x000000,
            author = {
                name = message.author.username,
                icon_url = message.author.avatarURL
            },

            title = "Cooldowns",

            fields = {
                {
                    name = "h$dailykey, h$dk",
                    value = MENUKEY.." **h$dailykey:** ``"..keyresult.."``"
                },
                {
                    name = "h$giftkey, h$gk",
                    value = MENUKEY.." **h$giftkey:** ``"..gkeyresult.."``"
                },
                {
                    name = "h$adventure, h$adv",
                    value = MENUADV.." **h$adventure:** ``"..advresult.."``"
                }
            }
        }
    }
end
return command --

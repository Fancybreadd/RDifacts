local command = {}
function command.run(message)
    print("cooldown")
    local profileID = message.author.id
    local pname = message.author.username
    local iconurl = message.author.avatarURL
    local check = io.open(path..profileID..".json","r")
    --==--

    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))

        local advtimeleft = jsonstats.timers.adventuretimer + ADVCOOLDOWN - os.time() --gets time left in unixtime
        local keytimeleft = jsonstats.timers.keytimer + DKCOOLDOWN - os.time()

        print(advtimeleft)
        print(keytimeleft)
        --turn that into readable time (hours, minutes, seconds)
        local advrealtime = SecondsToClock(advtimeleft) local keyrealtime = SecondsToClock(keytimeleft)

        local keyresult = ""
        local advresult = ""

        if keytimeleft <= 0 then keyresult = "Ready!"
        else keyresult = keyrealtime
        end
        if advtimeleft <= 0 then advresult = "Ready!"
        else advresult = advrealtime
        end
        --print(advrealtime)

        message.channel:send{
            embed = {
                color = 0x000000,
                author = {
                    name = pname.."'s Cooldowns",
                    icon_url = iconurl
                },
                title = "Cooldowns",

                fields = {
                    {
                        name = "h$dailykey, h$dk",
                        value = MENUKEY.."**h$dailykey:** ``"..keyresult.."``"
                    },
                    {
                        name = "h$adventure, h$adv",
                        value = MENUADV.."**h$adventure:** ``"..advresult.."``"
                    }
                }
            }
        }
    else noprofile(message)
    end
end
return command --

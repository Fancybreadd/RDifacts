local command = {}
function command.run(message)
    print("dailykey")
    local profileID = message.author.id
    local check = io.open(path..profileID..".json","r")
    local pname = message.author.username
    --==--
    if not check then
        local profile = io.open(path..profileID..".json","w")
        noprofile(message)
        check = makeprofile(profile, profileID)
    end
    --==--
    local jsonstats = json.decode(io.input(check):read("*a"))

    local currenttime = os.time()
    local playercooldown = jsonstats.timers.keytimer + DKCOOLDOWN
    --local randomplus = math.random(4,20)

    --------------------------------------------------------------------o
    if currenttime > playercooldown then
        jsonstats.timers.keytimer = os.time()
        jsonstats.wallet.keys = jsonstats.wallet.keys + 1

        message.channel:send{
            embed = {
                color = 0x000000,
                author = {
                    name = pname,
                }, --

                title = "Daily Key",
                description = "You request for your daily key. The -- Association checks and makes sure of your schedule before giving it to you.",

                fields = {
                    {
                        name = "+1 Key "..MENUKEY,
                        value = ""
                    }
                }
            }
        }

        updatesave(profileID, jsonstats, check) --(S)
        return
    end
    --------------------------------------------------------------------o ELSE
    check:close()
    local remainingtime = playercooldown - currenttime --gets remaining unix time --print(remainingtime)
    local readableremainingtime = SecondsToClock(remainingtime)

    message.channel:send(message.author.username..", you try and grab a key.. but the keygiver stops you! \n**"..readableremainingtime.." left!**")
    --------------------------------------------------------------------o
end
return command --
local command = {}
function command.run(message)
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
    local currenttime = os.time()
    local playergkcooldown = jsonstats.timers.giftkeytimer + GKCOOLDOWN --giftkey cooldown

    --------------------------SEND KEY---------------------------------

    if not message.mentionedUsers[1] then print("no ping detected") return end
    local FprofileID = message.mentionedUsers[1][1]
    local Fcheck = io.open(path..FprofileID..".json","r")
    if not Fcheck then print("no account") return elseif FprofileID == profileID then print("dupe acc") return end

    local Fjsonstats = json.decode(io.input(Fcheck):read("*a"))
    local Friend = message.guild:getMember(FprofileID).user
    local Fname = Friend.username

    if currenttime > playergkcooldown then --do command
        jsonstats.timers.giftkeytimer = os.time()
        Fjsonstats.wallet.keys = Fjsonstats.wallet.keys + 1 updatesave(profileID, jsonstats, check) updatesave(FprofileID, Fjsonstats, Fcheck) --(S)

        message.channel:send(message.author.username..", you gifted a "..MENUKEY.." **Key** to "..Fname.."!")
        return
    else
        check:close()
            local remainingtime = playergkcooldown - currenttime --gets remaining unix time 
            --print(remainingtime)
            local readableremainingtime = SecondsToClock(remainingtime)

            message.channel:send(message.author.username..", "..readableremainingtime)
    end
end
return command --
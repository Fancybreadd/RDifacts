local command = {}
function command.run(message)
    print("giftkey")
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
    local playergkcooldown = jsonstats.timers.giftkeytimer + GKCOOLDOWN --giftkey cooldown

    --------------------------------------------------------------------CHECKS
    if currenttime < playergkcooldown then --|if cooldown is not ready
        print("not ready")
        check:close()
        local remainingtime = playergkcooldown - currenttime --gets remaining unix time 
        --print(remainingtime)
        local readableremainingtime = SecondsToClock(remainingtime)

        message.channel:send(message.author.username..", "..readableremainingtime)
    end

    if not message.mentionedUsers[1] then --|if no users mentioned
        check:close()
        print("no ping detected") 
    return end

    local FprofileID = message.mentionedUsers[1][1]
    local Fcheck = io.open(BotPath.."PROFILES/"..FprofileID..".json","r")

    if not Fcheck then --|if user has no profile
        check:close()
        print("no account")
        return
    elseif FprofileID == profileID then --|if user id is the same
        check:close()
        print("dupe acc")
        return
    end

    --------------------------------------------------------------------COMMAND
    local Fjsonstats = json.decode(io.input(Fcheck):read("*a"))
    local Friend = message.guild:getMember(FprofileID).user
    local Fname = Friend.username

    if currenttime > playergkcooldown then --|if cooldown
        jsonstats.timers.giftkeytimer = os.time()
        Fjsonstats.wallet.keys = Fjsonstats.wallet.keys + 1 updatesave(profileID, jsonstats, check) updatesave(FprofileID, Fjsonstats, Fcheck) --(S)

        message.channel:send(message.author.username..", you gifted a "..MenuGIFTKEY.." **Key** to "..Fname.."!")
        return
    end
end
return command --
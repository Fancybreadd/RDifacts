local command = {}
function command.run(message)
    print("giftkey")
    local profileID = message.author.id
    local check = io.open(path..profileID..".json","r")
    --==--
    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))
        local currenttime = os.time()
        local playercooldown = jsonstats.timers.giftkeytimer + GKCOOLDOWN --giftkey cooldown
        local FprofileID = message.mentionedUsers[1][1]
        local Fcheck = io.open(path..FprofileID..".json","r")

        if message.mentionedUsers[1][1] and Fcheck and message.mentionedUsers[1][1] ~= message.author.id then

            local Fjsonstats = json.decode(io.input(Fcheck):read("*a"))
            local friend = message.guild:getMember(FprofileID).user
            local fname = friend.username
            -------
            if currenttime > playercooldown then --if cooldown ready
                jsonstats.timers.giftkeytimer = os.time()
                Fjsonstats.wallet.keys = Fjsonstats.wallet.keys + 1

                updatesave(profileID, jsonstats, check) updatesave(FprofileID, Fjsonstats, Fcheck) --(S)
                message.channel:send(message.author.username..", you gifted a "..MENUKEY.." **Key** to "..fname.."!") --(!!)
            else
                check:close()
                local remainingtime = playercooldown - currenttime --gets remaining unix time 
                --print(remainingtime)
                local readableremainingtime = SecondsToClock(remainingtime)

                message.channel:send(message.author.username..", "..readableremainingtime) --(!!)
            end
            -------
        else
            if message.mentionedUsers[1][1] then message.channel:send(message.author.username..", there seems to be no account tied to this user!") --(!!)
            else message.channel:send(message.author.username..", please ping a registered user to gift them a key!") end --(!!)
        end
    else noprofile(message) --(!!)
    end



end
return command --
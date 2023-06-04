local command = {}
function command.run(message)
    print("giftkey")
    --------------------------------------------------------------------FILESELECT
    --boomerang
    local profileID = message.author.id
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    local jsonstats
    --
    local FprofileID
    local Fcheck
    local Fjsonstats
    local Fuser
    local Fname

    --==-- BOOMERANG
    if not message.mentionedUsers[1] then --If theres no user pinged

        if not check then --if you no profile
            check = makeprofile(profileID)
            noprofile(message)
        end

    else --if there is a user pinged
        FprofileID = message.mentionedUsers[1][1]
        Fcheck = io.open(BotPath.."PROFILES/"..FprofileID..".json","r")
        Fuser = message.guild:getMember(FprofileID).user
        Fname = Fuser.username

        if not Fcheck then --if no user profile
            nofriendprofile(message)
            print("no profile detected")
            return

        else Fjsonstats = json.decode(io.input(Fcheck):read("*a"))
        end

    end
    jsonstats = json.decode(io.input(check):read("*a"))
    --==--

    --------------------------------------------------------------------INFO
    local currenttime = os.time()
    local playergkcooldown = jsonstats.timers.giftkeytimer + GKCOOLDOWN --giftkey cooldown

    --------------------------------------------------------------------CHECKS
    if currenttime < playergkcooldown then --|if cooldown is not ready
        check:close() Fcheck:close()
        print("not ready")

        local remainingtime = playergkcooldown - currenttime --gets remaining unix time 
        local readableremainingtime = SecondsToClock(remainingtime)

        message.channel:send{
            embed = {
                color = 0x8f27ff, title = "Gift Key...?",

                author = {
                    name = message.author.username.."'s r$giftkey",
                    icon_url = message.author.avatarURL
                }, --

                description = "",
                fields = {
                    {
                        name = "Command isn't ready!",
                        value = ""
                    }
                },
                footer = {text = "You can r$giftkey in "..readableremainingtime.."."}
            }
        }
    end

    if not message.mentionedUsers[1] then --|if no users mentioned
        check:close()
        print("no ping detected")

        message.channel:send{
            embed = {
                color = 0x8f27ff, title = "Gift Key...?",

                author = {
                    name = message.author.username.."'s r$giftkey",
                    icon_url = message.author.avatarURL
                }, --

                description = "You clutch the **Gift Key** "..MenuGIFTKEY.." in your hands... The key doesn't go anywhere though.",
                fields = {
                    {
                        name = "No user detected. Ping a user to send them a **Gift Key** "..MenuGIFTKEY.." !",
                        value = ""
                    }
                },
                footer = {text = "ex: r$giftkey @RDifacts"}
            }
        }
        return
    end

    if FprofileID == profileID then --|if user id is the same
        check:close()
        print("dupe acc")

        message.channel:send{
            embed = {
                color = 0x8f27ff, title = "Gift Key...?",

                author = {
                    name = message.author.username.."'s r$giftkey",
                    icon_url = message.author.avatarURL
                }, --

                description = "You clutch the **Gift Key** "..MenuGIFTKEY.."in your hands and focus on thinking of yourself... The key doesn't go anywhere though.",
                fields = {
                    {
                        name = "Can't give yourself a **Gift Key** "..MenuGIFTKEY.." , dummy!",
                        value = ""
                    }
                },
                footer = {text = "Something says you should give the key to someone..."}
            }
        }
        return
    end

    --------------------------------------------------------------------COMMAND
    if currenttime > playergkcooldown then --|if cooldown
        jsonstats.timers.giftkeytimer = os.time()
        Fjsonstats.wallet.keys = Fjsonstats.wallet.keys + 1
        updatesave(profileID, jsonstats, check) updatesave(FprofileID, Fjsonstats, Fcheck) --(S)

        message.channel:send{
            embed = {
                color = 0x8f27ff, title = "Gift Key!",

                author = {
                    name = message.author.username.."'s r$giftkey",
                    icon_url = message.author.avatarURL
                }, --

                description = "You clutch the **Gift Key** "..MenuGIFTKEY.." in your hands and focus on thinking of the person in question... The key disappears in a ray of light!"
                .."\n\n **Gift Key** "..MenuGIFTKEY.." successfully sent to "..Fname.."!",
                footer = {text = "you can r$giftkey again in 32 hours."}
            }
        }

        --message.author.username..", you gifted a "..MenuGIFTKEY.." **Key** to "..Fname.."!")
        return
    end
end
return command --
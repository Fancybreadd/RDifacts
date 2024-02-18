local command = {}
function command.run(message)
    print("giftkey")
    --------------------------------------------------------------------FILESELECT
    --boomerang
    local SaveData1, DiscordUsername1, DiscordPFP1, SaveData2, DiscordUsername2, DiscordPFP2, ID2 = ReturnUserData(message, message.mentionedUsers[1], "Boomerang")

    
    if SaveData1 == nil then
        return
    end

    --------------------------------------------------------------------INFO
    local CurrentTime = os.time()
    local PlayerCooldown = SaveData1.timers.giftkeytimer + GiftKeyCOOLDOWN --giftkey cooldown

    --------------------------------------------------------------------CHECKS
    if  SaveData1 == "NoFriend" then
        print("no friend for giftkey")

        ErrorEmbedder(
            message, 
            "Gift Key..?",
            message.author.username,
            message.author.avatarURL,
            "You clutch the **Gift Key** "..MenuGIFTKEY.." in your hands... The key doesn't go anywhere though.",
            "No user detected. Ping a user to send them a **Gift Key** "..MenuGIFTKEY.." !",
            MenuGKEMB,
            "example: r$giftkey @RDifacts",
            0x8f27ff
        )

        return
    end

    if CurrentTime < PlayerCooldown then --|if cooldown is not ready
        print("not ready")

        local RemainingCooldown = PlayerCooldown - CurrentTime --gets remaining unix time 
        local FormattedCooldown = SecondsToClock(RemainingCooldown)

        ErrorEmbedder(
            message, 
            "Gift Key..?",
            message.author.username,
            message.author.avatarURL,
            "You don't think you have a gift key anywhere...",
            "Command isn't ready!",
            MenuGKEMB,
            "r$giftkey will be available in "..FormattedCooldown..".",
            0x8f27ff
        )
        return
    end

    if ID2 == message.author.id then --|if user id is the same
        print("dupe gk acc")

        ErrorEmbedder(
            message, 
            "Gift Key..?",
            message.author.username,
            message.author.avatarURL,
            "You clutch the **Gift Key** "..MenuGIFTKEY.."in your hands and focus on thinking of yourself... The key doesn't go anywhere though.",
            "You can't give yourself a **Gift Key** "..MenuGIFTKEY.." , dummy!",
            MenuGKEMB,
            "",
            0x8f27ff
        )
        return
    end

    --------------------------------------------------------------------COMMAND
    if CurrentTime > PlayerCooldown then --|if cooldown
        SaveData1.timers.giftkeytimer = os.time()
        SaveData2.wallet.keys = SaveData2.wallet.keys + 1

        UpdateSave(message.author.id, SaveData1) UpdateSave(ID2, SaveData2) --(S)

        message.channel:send{
            embed = {
                color = 0x8f27ff, title = "Gift Key!",
                author = {
                    name = DiscordUsername1,
                    icon_url = DiscordPFP1
                }, --

                description = "You clutch the **Gift Key** "..MenuGIFTKEY.." in your hands and focus on thinking of the person in question... The key disappears in a ray of light!"
                .."\n\n **Gift Key** "..MenuGIFTKEY.." successfully sent to "..DiscordUsername2.."!",
                thumbnail = {
                    url = MenuGKEMB
                },
                footer = {text = "you can r$giftkey again in 32 hours."}
            }
        }

        --message.author.username..", you gifted a "..MenuGIFTKEY.." **Key** to "..FriendUsername.."!")
        return
    end
end
return command --
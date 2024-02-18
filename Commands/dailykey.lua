local command = {}
function command.run(message)
    print("dailykey")
    --------------------------------------------------------------------FILESELECT
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, nil, "Normal")

    --------------------------------------------------------------------INFO
    local CurrentTime = os.time()
    local PlayerCooldown = SaveData.timers.keytimer + DailyKeyCOOLDOWN
    --local randomplus = math.random(4,20)

    --------------------------------------------------------------------CHECKS
    if CurrentTime < PlayerCooldown then --|if cooldown still active
        local RemainingCooldown = PlayerCooldown - CurrentTime --gets remaining unix time 
        local FormattedCooldown = SecondsToClock(RemainingCooldown)

        ErrorEmbedder(
            message, 
            "Daily Key...?",
            message.author.username,
            message.author.avatarURL,
            "You visit the dwarf keysmith to claim your daily **Key** "..MenuKEY..". The dwarf flips through his logbook, then shakes his head. Saying yours isn't ready yet.",
            "Command isn't ready!",
            MenuDKEMB,
            "r$dailykey will be available in "..FormattedCooldown,
            0x13ff7b
        )
        return
    end

    --------------------------------------------------------------------COMMAND
    SaveData.timers.keytimer = os.time()
    SaveData.wallet.keys = SaveData.wallet.keys + 1

    UpdateSave(message.author.id, SaveData)

    message.channel:send{
        embed = {
            color = 0x13ff7b, title = "Daily Key!",

            author = {
                name = DiscordUsername,
                icon_url = DiscordPFP
            }, --

            description = "You visit the dwarf keysmith for your daily **Key** "..MenuKEY..". The dwarf flips through his logbook, then nods. Handing your key!",
            fields = {
                {
                    name = "Obtained :",
                    value = "+1 Key "..MenuKEY
                }
            }
        }
    }
end
return command --
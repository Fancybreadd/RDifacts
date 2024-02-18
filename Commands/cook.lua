local command = {}
function command.run(message)
    print("cook")
    --------------------------------------------------------------------FILESELECT
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, nil, "Normal")

    --------------------------------------------------------------------INFO
    local CurrentTime = os.time()
    local PlayerCooldown = SaveData.timers.adventuretimer + AdventureCOOLDOWN --print(PlayerCooldown)

    --------------------------------------------------------------------CHECKS
    if CurrentTime > PlayerCooldown then --|command not ready
        print("c, adv ready")

        ErrorEmbedder(
            message, 
            "Cooking...?",
            message.author.username,
            message.author.avatarURL,
            "You're pumped and ready to go! No time for food!",
            "r$adventure is ready!",
            MenuCEMB,
            "",
            0xce3131
        )

        return
    end

    if SaveData.wallet.ingredients < CookingCost then --|not enough food
        print("c, not enough food")

        ErrorEmbedder(
            message, 
            "Cooking...?",
            message.author.username,
            message.author.avatarURL,
            "You look everywhere, but there just doesn't seem to be anything you can really cook with...",
            "Not enough **Ingredients** "..MenuINGREDIENT.." ! ("..CookingCost.." Required)",
            MenuCEMB,
            "",
            0xce3131
        )
        return
    end

    --------------------------------------------------------------------COMMAND
    local CookChance, BonusChance = math.random(), math.random()
    local CookText, BonusText = "", ""
    local CookValue, BonusReward = 0,0

    if CookChance < CookGrade1 then --35% --calculate cooking
        CookValue = 10 CookText =
        "*You cooked up... something edible... probably.*"

    elseif CookChance < CookGrade2 then --25%
        CookValue = math.random(15,20) CookText =
        "*You cooked up something palatable!*"

    elseif CookChance < CookGrade3 then --20%
        CookValue = math.random(25,30) CookText =
        "*You cooked up something tasty! Yummy!*"

    elseif CookChance < CookGrade4 then --15%
        CookValue = math.random(35,40) CookText =
        "*You cooked up something delicious! You're very satisfied...*"

    elseif CookChance < CookGrade5 then --5%
        CookValue = math.random(50,60) CookText =
        "***Wow... You cooked up the BEST dish you've ever made today. You're absolutely stuffed!***"
    end

    if BonusChance < CookBonusTrigger then  --30% --calculate bonus
        BonusReward = math.random(3,8)
        BonusText = "- Seems like your haste in cooking has made you efficient,"
        .." Saving you "..BonusReward.." **Ingredients** "..MenuINGREDIENT.." !"
    end


    local CutMinutes = CookValue*60
    local FormattedCooldown

    SaveData.wallet.ingredients = SaveData.wallet.ingredients - CookingCost + BonusReward
    SaveData.timers.adventuretimer = SaveData.timers.adventuretimer - CutMinutes

    UpdateSave(message.author.id, SaveData) --(S)

    local CooldownText = SaveData.timers.adventuretimer + AdventureCOOLDOWN - os.time()
    if CooldownText > 0 then
        FormattedCooldown = SecondsToClock(CooldownText).."."
    else
        FormattedCooldown = "Ready!"
    end

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0xce3131, title = "Cooking...",
            author = {
                name = DiscordUsername,
                icon_url = DiscordPFP
            },

            description = "You grab your cooking utensils and try making some food.\n- "..CookText.."\n"..BonusText,
            fields = {
                {
                    name = "r$adventure cut by "..CookValue.." minutes!",
                    value = "-"..CookingCost - BonusReward.." **Ingredients** "..MenuINGREDIENT
                }
            },
            thumbnail = {
                url = MenuCEMB
            },
            footer = {text = "Cooldown is now "..FormattedCooldown},
        }
    }
end
return command --
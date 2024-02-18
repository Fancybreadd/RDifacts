local command = {}
function command.run(message)
    print("adventure")
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, nil, "Normal")

    --------------------------------------------------------------------INFO
    local CurrentTime = os.time() --30 seconds
    local PlayerCooldown = SaveData.timers.adventuretimer + AdventureCOOLDOWN --print(PlayerCooldown)
    local Remaining = PlayerCooldown - CurrentTime --gets remaining unix time --print(RemainingCooldown)

    local FormattedCooldown = SecondsToClock(Remaining)
    --------------------------------------------------------------------CHECKS

    --|if cooldown isnt ready
    if CurrentTime < PlayerCooldown then
        print ("adv, not ready")

        ErrorEmbedder(
            message, 
            "Adventuring...?",
            message.author.username,
            message.author.avatarURL,
            "You're too exhausted for another adventure right now...",
            "Command isn't ready!",
            MenuADVEMB,
            "r$adventure will be available in "..FormattedCooldown..".",
            0xff7e27
        )
        return
    end

    --------------------------------------------------------------------COMMAND
    local CapsuleChance, IngredientChance = math.random (), math.random() --chances

    local RewardText, CapsuleText, IngredientText = "", "", ""

    local IngredientReward = 0

    --capsule reward
    if CapsuleChance <= CapsuleTrigger then  --calculate capsule reward
        SaveData.wallet.capsules = SaveData.wallet.capsules + 1

        CapsuleText = "Success ꕥ\n- ***Your expedition was a success. You remark in your newly obtained capsule!***"
        RewardText = "**+ 1 Capsule** "..MenuCAPSULE.."\n"

        print ("success")
    else
        CapsuleText = "Failed ꕥ\n- *Your expedition didn't end up as planned... You walked back to the town square empty handed.*"

        print ("fail")
    end

    --ingredient reward
    if IngredientChance < IngredientGrade1 then --40% --calculate ingredient
        IngredientReward = 10

        IngredientText =
        "*On the way, you couldn't forage much...*"

    elseif IngredientChance < IngredientGrade2  then --30%
        IngredientReward = math.random(15,18)

        IngredientText =
        "*On the way, you foraged something worthwhile.*"

    elseif IngredientChance < IngredientGrade3  then --17%
        IngredientReward = math.random(25,30)

        IngredientText =
        "*On the way, you gathered some pretty nice stuff!*"

    elseif IngredientChance < IngredientGrade4  then --10%
        IngredientReward = math.random(45,55)

        IngredientText =
        "*On the way, you found a lot of really good foraging spots!*"

    elseif IngredientChance < IngredientGrade5  then --3%
        IngredientReward = math.random(70,90)

        IngredientText =
        "***LUCKY! On the way, you hit the tasty jackpot!***"
    end


    print(IngredientChance)
    RewardText = RewardText.."**+ "..IngredientReward.." Ingredients** "..MenuINGREDIENT

    SaveData.wallet.ingredients = SaveData.wallet.ingredients + IngredientReward
    SaveData.timers.adventuretimer = os.time()

    UpdateSave(message.author.id, SaveData)

    message.channel:send{
        embed = {
            color = 0xff7e27, title = "Adventuring...",
            author = {
                name = DiscordUsername,
                icon_url = DiscordPFP
            },

            description = "# ꕥ "..CapsuleText.."\n- "..IngredientText,
            fields = {
                {
                    name = ":sparkles: Rewards:",
                    value = RewardText
                }
            },

            thumbnail = {
                url = MenuADVEMB
            },
            footer = {text = "You can r$adventure again in 6 Hours."}
        }
    }
end

return command
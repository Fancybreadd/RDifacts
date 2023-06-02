local command = {}
function command.run(message)
    print("adventure")
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
    local currenttime = os.time() --30 seconds
    local playercooldown = jsonstats.timers.adventuretimer + ADVCOOLDOWN --print(playercooldown)
    local remainingtime = playercooldown - currenttime --gets remaining unix time --print(remainingtime)
    local readableremainingtime = SecondsToClock(remainingtime)

    --------------------------------------------------------------------CHECKS
    if currenttime < playercooldown then --|if cooldown isnt ready
        print ("no ex")
        return
    end

    --------------------------------------------------------------------COMMAND
    -- R = Reward | M = Marble | I = Ingredients | C = Capsule
    local Cchance = math.random (1,2) --capsule
    local Ichance = math.random() --ingredients
    local Mchance = math.random() --marbles
    local Rtext = "" local Ctext = "" local Mtext = "" local Itext = "" local Ireward = 0 local Mreward = 0

    if Cchance == 2 then  --calculate capsule reward
        jsonstats.wallet.capsules = jsonstats.wallet.capsules + 1
        Ctext = "Your expedition was a success. You remark in your newly obtained capsule!"
        Rtext = "**+ 1 Capsule** "..MenuCAPSULE.."\n"
        print ("success")
    else
        Ctext = "Your expedition didn't end up as planned... You walked back to the village square empty handed."
        print ("fail")
    end

    if Ichance < 0.40 then --40% --calculate ingredient
        Ireward = math.random(5,10) Itext =
        "*On the way, you couldn't forage much...*"

    elseif Ichance < 0.70 then --30%
        Ireward = math.random(10,20) Itext =
        "*On the way, you foraged something worthwhile.*"

    elseif Ichance < 0.87 then --17%
        Ireward = math.random(25,35) Itext =
        "*On the way, you gathered some pretty nice stuff!*"

    elseif Ichance < 0.97 then --10%
        Ireward = math.random(40,50) Itext =
        "*On the way, you found a lot of really good foraging spots!*"

    elseif Ichance < 1 then --3%
        Ireward = math.random(55,65) Itext =
        "***LUCKY!! On the way, you hit the tasty jackpot!***"
    end
    ---------------------------------------------------------------
    if Mchance < 0.40 then --40% --calculate marbles
        Mreward = math.random(5,10) Mtext =
        "*You also mined up a Marble Nugget...*"

    elseif Mchance < 0.70 then --30%
        Mreward = math.random(10,20) Mtext =
        "*You also mined up a Marble Chunk!*"

    elseif Mchance < 0.87 then --17%
        Mreward = math.random(20,40) Mtext =
        "*You also mined up a Rough Marble!*"

    elseif Mchance < 0.97 then --10%
        Mreward = math.random(40,80) Mtext = 
        "*You also mined up a Fine Marble! Nice!*"

    elseif Mchance < 1 then --3%
        Mreward = 100 Mtext =
        "***You also... WOAH!! You mined up a Perfect Marble! Awesome!!!***"
    end

    print(Ichance.." , "..Mchance)
    Rtext = Rtext.."**+ "..Ireward.." Ingredients** "..MenuINGREDIENT.."\n**+ "..Mreward.." Marbles** "..MenuMARBLE
    
    jsonstats.wallet.ingredients = jsonstats.wallet.ingredients + Ireward jsonstats.wallet.marbles = jsonstats.wallet.marbles + Mreward
    jsonstats.timers.adventuretimer = os.time() updatesave(profileID, jsonstats, check)

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0xff7e27, title = "Adventuring...",
            author = {
                name = message.author.username.."'s r$adventure",
                icon_url = message.author.avatarURL
            },

            description = "**ꕥ "..Ctext.."**\n\n- "..Itext.."\n\n- "..Mtext,
            fields = {
                {
                    name = ":sparkles: Rewards:",
                    value = Rtext
                }
            },
            footer = {text = "You can r$adventure again in 6 Hours."}
        }
    }
end

return command
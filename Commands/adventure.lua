local command = {}
function command.run(message)
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    print("adventure")
    --==--
    if not check then
        local profile = io.open(path..profileID..".json","w")
        noprofile(message)
        check = makeprofile(profile, profileID)
    end
    --==--
    local jsonstats = json.decode(io.input(check):read("*a"))
    local currenttime = os.time() --30 seconds
    local playercooldown = jsonstats.timers.adventuretimer + ADVCOOLDOWN --print(playercooldown)

    local remainingtime = playercooldown - currenttime --gets remaining unix time --print(remainingtime)
    local readableremainingtime = SecondsToClock(remainingtime)

    --------------------------------------------------------------------o
    if currenttime > playercooldown then --if current time is more than player cooldown, activate
        --rewards = box,key,marble,material,ingredient
        jsonstats.timers.adventuretimer = os.time()
        local randomscenarioval = math.random(1,3)

        local adventuresummary = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][1])
        local capsulereward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][2])
        local keyreward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][3])
        local marblereward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][4])
        local materialreward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][5])
        local ingredientreward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][6])
        --print(SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][1])
        jsonstats.wallet.capsules = jsonstats.wallet.capsules + capsulereward
        jsonstats.wallet.keys = jsonstats.wallet.keys + keyreward
        jsonstats.wallet.marbles = jsonstats.wallet.marbles + marblereward
        jsonstats.wallet.materials = jsonstats.wallet.materials + materialreward
        jsonstats.wallet.ingredients = jsonstats.wallet.ingredients + ingredientreward

        ---
        local rewardtext = ""
        if capsulereward > 0 then rewardtext = rewardtext.."+"..capsulereward.. " "..MENUCAPSULE.." Capsule \n" end
        if keyreward > 0 then rewardtext = rewardtext.."+"..keyreward.. " "..MENUKEY.." Key \n" end
        if marblereward > 0 then rewardtext = rewardtext.."+"..marblereward.." "..MENUMARBLE.." Marbles \n" end
        if materialreward > 0 then rewardtext = rewardtext.."+"..materialreward.." "..MENUMATERIAL.." Materials \n" end
        if ingredientreward > 0 then rewardtext = rewardtext.."+"..ingredientreward.." "..MENUINGREDIENT.." Ingredients" end
        updatesave(profileID, jsonstats, check) --(S)
        ----==EMBED==----
        message.channel:send{
            embed = {
                color = 0x000000, title = MENUADV.." Adventuring... ",
                author = {
                    name = message.author.username,
                    icon_url = message.author.avatarURL
                },

                description = adventuresummary,
                fields = {
                    {
                        name = ":sparkles: Rewards:",
                        value = "**"..rewardtext.."**",
                    }
                },

                footer = {
                    text = message.author.username..", you can explore again in 8 hours!"
                }
            }
        }
        return
    end
    --------------------------------------------------------------------o ELSE
    message.channel:send{
        embed = {
            color = 0x000000, title = MENUADV.." Ough... ",
            author = {
                name = message.author.username,
                icon_url = message.author.avatarURL
            },

            description = message.author.username..", you're still too tired to do another one. \n``"..readableremainingtime.." left!``"
        }
    }
    check:close()
    --------------------------------------------------------------------o
end
return command --
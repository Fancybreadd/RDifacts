local cookingcost = 25

local command = {}
function command.run(message)
    print("cook")
    --------------------------------------------------------------------FILESELECT
    --single
    local profileID = message.author.id 
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    local username = message.author.username
    local iconurl = message.author.avatarURL

    --==--
    if not check then
        check = makeprofile(profileID)
        noprofile(message)
    end
    --==--

    local jsonstats = json.decode(io.input(check):read("*a"))

    --------------------------------------------------------------------INFO
    local currenttime = os.time()
    local playercooldown = jsonstats.timers.adventuretimer + ADVCOOLDOWN --print(playercooldown)

    --------------------------------------------------------------------CHECKS
    if currenttime > playercooldown then --|command not ready
        check:close()

        message.channel:send{embed = {
            color = 0xce3131, title = "Cooking...?",
            author = {
                name = username.."'s r$cook",
                icon_url = iconurl
            },
            description = "You're ready for an adventure! No time for cooking!",
            fields = {
                {
                    name = "r$adventure is ready!",
                    value = ""
                }
            },
        }}
        return
    end

    if jsonstats.wallet.ingredients < cookingcost then --|not enough food
        check:close()

        message.channel:send{embed = {
            color = 0xce3131, title = "Cooking...?",
            author = {
                name = username.."'s r$cook",
                icon_url = iconurl
            },

            description = "You look everywhere, but there just doesn't seem to be anything you can really cook with...",
            fields = {
                {
                    name = "Not enough Ingredients "..MenuINGREDIENT.." ! (15 Required)",
                    value = ""
                }
            },
        }}
        return
    end

    --------------------------------------------------------------------COMMAND
    local CKchance = math.random() local CKBchance = math.random()
    local CKtext = "" 
    local CKmin = 0 local CKbonus = 0

    if CKchance < 0.35 then --35% --calculate cooking
        CKmin = math.random(3,5) CKtext =
        "*You cooked up... something edible.*"

    elseif CKchance < 0.60 then --25%
        CKmin = math.random(7,12) CKtext =
        "*You cooked up something palatable!*"

    elseif CKchance < 0.80 then --20%
        CKmin = math.random(15,20) CKtext =
        "*You cooked up something tasty! Yummy!*"

    elseif CKchance < 0.95 then --15%
        CKmin = math.random(25,35) CKtext =
        "*You cooked up something delicious! You're very satisfied...*"

    elseif CKchance < 1 then --5%
        CKmin = math.random(40,60) CKtext =
        "***Wow... You cooked up the BEST dish you've ever made today. You're absolutely stuffed!***"
    end

    local cookvalue = CKmin*60
    local advRT

    -------BONUS-------
    local bonusembed = {}
    if CKBchance < .3 then  --30% --calculate bonus
        CKbonus = math.random(3,10)
        bonusembed = {
            embed = {
                color = 0xce3131, title = "Lucky!",
                author = {
                    name = username,
                    icon_url = iconurl
                },
                description = "Seems like your efficiency in cooking made you use a little less **Ingredients** "..MenuINGREDIENT.." !"
                .."\n- You saved "..CKbonus.." **Ingredients** "..MenuINGREDIENT.." !",
            }
        }
    end

    jsonstats.wallet.ingredients = jsonstats.wallet.ingredients - cookingcost + CKbonus
    jsonstats.timers.adventuretimer = jsonstats.timers.adventuretimer - cookvalue
    updatesave(profileID, jsonstats, check) --(S)

    local advR = jsonstats.timers.adventuretimer + ADVCOOLDOWN - os.time() 
    if advR > 0 then
        advRT = SecondsToClock(advR).."."
    else
        advRT = "Ready!"
    end

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0xce3131, title = "Cooking...",
            author = {
                name = username.." 's r$cook",
                icon_url = iconurl
            },

            description = "**You grab your cooking utensils and try making some food.**\n- "..CKtext,
            fields = {
                {
                    name = "-25 Ingredients "..MenuINGREDIENT,
                    value = "r$adventure cut by **"..CKmin.."** minutes!"
                }
            },
            footer = {text = "Cooldown is now "..advRT},
        }
    }

    if bonusembed ~= {} then message.channel:send(bonusembed) end
end
return command --
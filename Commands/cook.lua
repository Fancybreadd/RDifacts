local cookingcost = 20

local command = {}
function command.run(message)
    print("cook")
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    --==--
    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))

        local currenttime = os.time()
        local playercooldown = jsonstats.timers.adventuretimer + ADVCOOLDOWN
        print(playercooldown)
        ------------------------------------------o
        if currenttime < playercooldown then

            if jsonstats.wallet.ingredients > cookingcost then
                local randomscenarioval = math.random(1,3)

                local cooksummary = (COOKRESULTS[COOKRESULTKEYNAMES[randomscenarioval]][1])
                local cookvalue = (COOKRESULTS[COOKRESULTKEYNAMES[randomscenarioval]][2])
                print (cooksummary)
                print (cookvalue)

                jsonstats.wallet.ingredients = jsonstats.wallet.ingredients - cookingcost
                jsonstats.timers.adventuretimer = jsonstats.timers.adventuretimer - cookvalue

                local minutescookvalue = cookvalue/60

                updatesave(profileID, jsonstats, check) --(S)

                message.channel:send{
                    embed = {
                        color = 0x000000,
                        author = {
                            name = message.author.username,
                            icon_url = message.author.avatarURL
                        },

                        title = MENUCOOK.." Cooking.. ",
                        description = cooksummary,

                        fields = {
                            {
                                name = "h$adv cooldown cut by "..minutescookvalue.." minutes!",
                                value = "ꕥꕥꕥꕥꕥꕥꕥꕥꕥꕥꕥꕥꕥꕥꕥꕥ"
                            }
                        },
                        footer = {text = "-20 Ingredients"}
                        }
                }

            else
                check:close()

                message.channel:send{embed = { --(!!)
                    color = 0x000000,
                    title = MENUCOOK.." Cooking.. ",

                    author = {
                        name = message.author.username,
                        icon_url = message.author.avatarURL
                    },

                    description = "You look everywhere, but there just doesn't seem to be anything you can really cook with..."
                }}
            end
        ------------------------------------------o

        else
            message.channel:send{embed = { --(!!)
                color = 0x000000,
                title = MENUCOOK.." Wait.. ",

                author = {
                    name = message.author.username,
                    icon_url = message.author.avatarURL
                },

                description = "You're ready for an adventure! No time for cooking!"
            }}

            check:close()
        end
    else noprofile(message) --(!!)
    end
end
return command --
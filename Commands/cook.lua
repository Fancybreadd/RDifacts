--cuts cooldown--

local cookingcost = 20

local command = {}
function command.run(message)
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")


    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))

        local currenttime = os.time()
        local playercooldown = jsonstats.timers.adventuretimer + ADVCOOLDOWN
        print(playercooldown)

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

                local modify = io.open(path..profileID..".json","w")

                io.output(modify):write(json.encode(jsonstats)) modify:flush() --update and save
                modify:close() check:close() --close

                message.channel:send{embed = {
                    color = 0x000000,
                    title = "<:cookingknife:974357840359735296> Cooking.. ",

                    author = {
                        name = message.author.username,
                        icon_url = message.author.avatarURL
                    },

                    description = cooksummary.."\n**-20 Ingredients**\n``-"..minutescookvalue.." Minutes on adventuring cooldown!``"
                }}

            else
                check:close()

                message.channel:send{embed = {
                    color = 0x000000,
                    title = "<:cookingknife:974357840359735296> Cooking.. ",

                    author = {
                        name = message.author.username,
                        icon_url = message.author.avatarURL
                    },

                    description = "You look everywhere, but there just doesn't seem to be anything you can really cook with..."
                }}
            end

        else
            message.channel:send{embed = {
                color = 0x000000,
                title = "<:cookingknife:974357840359735296> Wait.. ",

                author = {
                    name = message.author.username,
                    icon_url = message.author.avatarURL
                },

                description = "You're ready for an adventure! No time for cooking!"
            }}

            check:close()
        end
    else noprofile(message)
    end
end
return command --
client:on("messageCreate", function(message)
    if message.content == prefix..'adventure' or message.content == prefix..'adv' then
        local profileID = message.author.id 
        local check = io.open(path..profileID..".json","r")


        if check then
            local jsonstats = json.decode(io.input(check):read("*a"))

            local currenttime = os.time() --30 seconds
            local playercooldown = jsonstats.timers.adventuretimer + ADVCOOLDOWN
            print(playercooldown)

            if currenttime > playercooldown then --if current time is more than player cooldown, activate
                --rewards = box,key,marble,material,ingredient
                jsonstats.timers.adventuretimer = os.time()

                local randomscenarioval = math.random(1,3)

                local adventuresummary = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][1])
                local boxreward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][2])
                local keyreward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][3])
                local marblereward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][4])
                local materialreward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][5])
                local ingredientreward = (SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][6])
                --print(SCENARIOS[SCENARIOKEYNAMES[randomscenarioval]][1])
                --jsonstats.wallet.boxes = jsonstats.wallet.boxes + 1
                jsonstats.wallet.boxes = jsonstats.wallet.boxes + boxreward
                jsonstats.wallet.keys = jsonstats.wallet.keys + keyreward
                jsonstats.wallet.marbles = jsonstats.wallet.marbles + marblereward
                jsonstats.wallet.materials = jsonstats.wallet.materials + materialreward
                jsonstats.wallet.ingredients = jsonstats.wallet.ingredients + ingredientreward

                local rewardtext = ""
                if boxreward > 1 then
                    rewardtext = rewardtext.."+"..boxreward.. " <:treasurebox:974300654946365450> treasure boxes! "
                else 
                    if boxreward > 0 then
                    rewardtext = rewardtext.."+"..boxreward.. " <:treasurebox:974300654946365450> treasure box! "
                end end
                if keyreward > 0 then
                    rewardtext = rewardtext.."+"..keyreward.. " <:boxkey:974300640178221106> keys! "
                end
                if marblereward > 0 then
                    rewardtext = rewardtext.."+"..marblereward.." <:marble:974315328106549248> marbles! "
                end
                if materialreward > 0 then
                    rewardtext = rewardtext.."+"..materialreward.." materials! "
                end
                if ingredientreward > 0 then
                    rewardtext = rewardtext.."+"..ingredientreward.." ingredients! "
                end
                local modify = io.open(path..profileID..".json","w")
                io.output(modify):write(json.encode(jsonstats))
                
                modify:flush()
                modify:close()
                check:close()



                message.channel:send{embed = {
                    color = 0x000000,
                    title = "<:adventuring:974300665436340235> Adventuring.. ",

                    author = {
                        name = message.author.username,
                        icon_url = message.author.avatarURL
                    },

                    description = adventuresummary.."\n**"..rewardtext.."**"

                }}

            else
                local remainingtime = playercooldown - currenttime --gets remaining unix time 
                print(remainingtime)

                local readableremainingtime = SecondsToClock(remainingtime)

                message.channel:send{embed = {
                    color = 0x000000,
                    title = "<:adventuring:974300665436340235> Ough.. ",

                    author = {
                        name = message.author.username,
                        icon_url = message.author.avatarURL
                    },

                    description = message.author.username..", you're still too tired to do another one. \n**"..readableremainingtime.." left!**"

                }}
                check:close()
            end




        end
    end
end)
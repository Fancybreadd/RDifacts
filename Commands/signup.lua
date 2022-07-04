client:on('messageCreate', function(message)
    if message.content == prefix..'signup' then
        message.channel:send('creating acc..')
        local profileID=message.author.id
        local check = io.open(path..profileID..".json","r")
        local profile = io.open(path..profileID..".json","w")

        if check then
            message.channel:send{embed = {
                color = 0x000000,
                title = "Uh..",
                
                author = {
                    name = message.author.username,
                    icon_url = message.author.avatarURL
                },

                description = "You try to register a new adventurers account, but the explorers guild recognizes you.. Darn! \n\n *(No illegal artifact smuggling for you..)*"


            }}
            check:close()
        else
            local stats = {
                wallet = {keys=1,boxes=1,marbles=0,materials=0,ingredients=0},
                inventory = {},
                shadowinventory = {},
                giftkey = true,
                timers = {adventuretimer=0,keytimer=0},
                artifactprogress = 0,
            }
            local jsonstats = json.encode(stats)

            profile:write(jsonstats)
            profile:close()
            
            
            message.channel:send{embed = {
                color = 0x000000,
                title = "Success!",
                
                author = {
                    name = message.author.username,
                    icon_url = message.author.avatarURL
                },

                description = "You head to the explorers guild and get yourself an adventurers permit. After signing some waivers, you are welcomed with a free starter box and key. \n\n**You now have full access to all commands!**\n**+1** <:boxkey:974300640178221106> **Key!  +1** <:treasurebox:974300654946365450> **Treasure Box!**"


            }}

        end


    end
end)
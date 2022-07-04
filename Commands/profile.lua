client:on('messageCreate', function(message)
    if message.content == prefix..'profile' or message.content == prefix..'p' then
        local profileID = message.author.id
        local check = io.open(path..profileID..".json","r")
        
        if check then
            local jsonstats = json.decode(io.input(check):read("*a"))

            local artifactprogress = jsonstats.artifactprogress

            local marblestat = jsonstats.wallet.marbles
            local materialstat = jsonstats.wallet.materials
            local keystat = jsonstats.wallet.keys
            local boxstat = jsonstats.wallet.boxes
            local ingredientstat = jsonstats.wallet.ingredients

            message.channel:send{embed = {
                color = 0x000000,
                title = "Stats",
                
                author = {
                    name = message.author.username.. "'s Profile",
                    icon_url = message.author.avatarURL
                },

                description = "**Artifact Progress ["..artifactprogress.."/256]**",

                fields = {
                    {
                        name = "<:boxkey:974300640178221106> Keys",
                        value = keystat,
                        inline = true
                    },
                    {
                        name = "<:treasurebox:974300654946365450> Boxes",
                        value = boxstat,
                        inline = true
                    },
                    {
                        name = "<:marble:974315328106549248> Marbles",
                        value = marblestat,
                        inline = false
                    },
                    {
                        name = "Materials",
                        value = materialstat,
                        inline = false
                    },
                    {
                        name = "Ingredients",
                        value = ingredientstat,
                        inline = true
                    }

                }
            }}
            check:close()
        end
    end
end)
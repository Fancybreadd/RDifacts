client:on("messageCreate", function(message) --HI WHAT THE FUCK IS THIS COMMAND AGAIN???
    if message.content == prefix..'collection' or message.content == prefix..'col' then
        local profileID = message.author.id 
        local check = io.open(path..profileID..".json","r")

        if check then
            jsonstats = json.decode(io.input(check):read("*a"))
            iteminventory = jsonstats.inventory
            
            --print (KEYNAMES[1])

            if #iteminventory == 0 then --if you have nothing
                message.channel:send{embed = {
                    color = 0x000000,
                    title = "It's Empty.",


                    author = {
                        name = message.author.username.. "'s Artifacts",
                        icon_url = message.author.avatarURL
                    },

                    description = "You don't own anything!"
                }}

                check:close()
                --print("nah")
            else --do inventory system

                --print("full")
                local embedList = ""
               
                Length = 2
                local sortedinventory = Collectioninv(iteminventory)

                for entryIndex = (1 - 1) * Length + 1, 1 * Length, 1 do  --actually sets them up for the embed --also its spose be Page - 1 but since all new inv starts at Page 1..
                    if JSONITEMS[sortedinventory[entryIndex]] == nil then
                        break
                    end
                    embedList = embedList..JSONITEMS[sortedinventory[entryIndex]][1].." "..JSONITEMS[sortedinventory[entryIndex]][2].."\n"
                    --print(JSONITEMS[tablecloneofinventory[entryIndex]][1])
                    --print(entryIndex)
                end

                message.channel:send({ --send collection inventory
                embed = {
                    color = 0x000000,
                    title = "Artifact Progress ["..jsonstats.artifactprogress.."/256]",


                    author = {
                        name = message.author.username.. "'s Artifacts",
                        icon_url = message.author.avatarURL
                    },

                    description = embedList,
                    footer = {
                        text = "Page 1",
                    }

                },
    
                --send buttons
                components = {{ 
                    type = 1, -- make button container
                    components = {
                      {
                        type = 2, -- make a button
                        style = 1, -- blurple
                        label = "<<", -- add text
                        custom_id = "previouspage",
                        disabled = "false"
                      },
                      {
                        type = 2, -- make a button
                        style = 1, -- blurple
                        label = ">>", -- add text
                        custom_id = "nextpage",
                        disabled = "false"
                      }
                    }
                }}
                })
            
                
                
                check:close()
            end
        end

    end
end)


client:on("buttonPressed", function(buttonid, member, message) --WHAT THE FUCK ARE YOU
                
    if buttonid == "nextpage" then 
        print(">>")
        local embedpage = message.embed.footer.text --BIG note, youre taking objects from the MESSAGE, not the updated one below
        local embednumber = tonumber(string.sub(embedpage, 6)) --6th letter, turn it into number
        Page = embednumber + 1

        local embedList = ""
        local sortedinventory = Collectioninv(iteminventory)
        for entryIndex = (Page - 1) * Length + 1, Page * Length, 1 do
            if JSONITEMS[sortedinventory[entryIndex]] == nil then
                break
            end
            embedList = embedList..JSONITEMS[sortedinventory[entryIndex]][1].." "..JSONITEMS[sortedinventory[entryIndex]][2].."\n"
        end

        message:update({embed = {
            color = 0x000000,
            title = "Artifact Progress ["..jsonstats.artifactprogress.."/256]",


            author = {
                name = "Artifacts",
            
            },

            description = embedList,
            footer = {
                text = "Page "..Page,
            }
        }})
    end

    if buttonid == "previouspage" then
        if Page > 1 then
            print("<<")
            local embedpage = message.embed.footer.text 
            local embednumber = tonumber(string.sub(embedpage, 6))
            Page = embednumber - 1

            local embedList = ""
            local sortedinventory = Collectioninv(iteminventory)
            for entryIndex = (Page - 1) * Length + 1, Page * Length, 1 do --im going to strangle this shit
                if JSONITEMS[sortedinventory[entryIndex]] == nil then
                    break
                end
                embedList = embedList..JSONITEMS[sortedinventory[entryIndex]][1].." "..JSONITEMS[sortedinventory[entryIndex]][2].."\n"
            end
            message:update({embed = {
                color = 0x000000,
                title = "Artifact Progress ["..jsonstats.artifactprogress.."/256]",


                author = {
                    name = "Artifacts",
                
                },

                description = embedList,
                footer = {
                    text = "Page "..Page,
                }
            }})

        end
    end
end)    



function Collectioninv(iteminventory)
    local tablecloneofinventory = {}

    for index, value in pairs(iteminventory) do -- clones the users inventory
        tablecloneofinventory[index] = value;
    end

    table.sort(tablecloneofinventory, function (a, b) -- sorts it by id
        --print(JSONITEMS[a][1])
        if (JSONITEMS[a][3] < JSONITEMS[b][3]) then
            return (JSONITEMS[a][3] < JSONITEMS[b][3])
        end
    end)
    --print(tablecloneofinventory[1])
    --print(tablecloneofinventory[2])
    print(tablecloneofinventory)
    return tablecloneofinventory
end


local command = {} 
function command.run(message) --the most horrible one
    print("collection")
    local profileID = message.author.id
    local pname = message.author.username
    local iconurl = message.author.avatarURL
    --==--

    -------------------------------------o IGNORE THIS FOR NOW
    if message.mentionedUsers[1][1] then --switch to pinged user if there is
        profileID = message.mentionedUsers[1][1]
        friend = message.guild:getMember(profileID).user
        pname = friend.username
        iconurl = friend.avatarURL
        print (friend)
        --iconurl = friend.icon_url --Change this later--
        for i,v in pairs(message.mentionedUsers[1]) do print(i,v) end
    end
    local check = io.open(path..profileID..".json","r")
    -------------------------------------o

    if check then
        jsonstats = json.decode(io.input(check):read("*a"))
        iteminv = jsonstats.inv

        --------------------------------------------------------------------o
        if #iteminv == 0 then --if you have nothing
            message.channel:send{embed = { --(!!)
                color = 0x000000,
                title = "It's Empty.",

                author = {
                    name = pname.. "'s Artifacts",
                    icon_url = iconurl
                },

                description = "You don't own anything!"
            }}

            check:close()
        --------------------------------------------------------------------o

        else --do inv system
            --print("full")
            ------------o
            local embedList = ""
            Length = 3 --amount of artifacts shown per page
            Buttonlimit = math.floor((#iteminv / Length)) + 1 --the +1 is important
            ------------o

            local sortedinv = Collectioninv(iteminv)

            for entryIndex = (1 - 1) * Length + 1, 1 * Length, 1 do  --sort all the artifacts
                if JSONITEMS[sortedinv[entryIndex]] == nil then
                    break
                end
                embedList = embedList.."**["..JSONITEMS[sortedinv[entryIndex]][3].."]** "..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
                --print(JSONITEMS[tablecloneofinv[entryIndex]][1])
                --print(entryIndex)
            end

            message.channel:sendCo({ --(!!)
            embed = {
                color = 0x000000,
                title = "Artifact Progress ["..jsonstats.artifactprogress.."/256]",

                author = {
                    name = pname.. "'s Artifacts",
                    icon_url = iconurl
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
--------------------------------------------
--BUG NOTE: bot breaks if you press a button from an embed that existed before the bots startup, fixes itself once a button from an embed created after startup is pressed
--------------------------------------------
client:on("buttonPressed", function(buttonid, member, message)  -- inv page --ALSO WHAT THE FUCK ARE YOU
    local embedpage = message.embed.footer.text --BIG note, youre taking objects from the MESSAGE, not the updated one below
    local embednumber = tonumber(string.sub(embedpage, 6)) --6th character of the "Page X", turn it from string into number
    Page = 1 --starting page

    -----------buttons-----------

    if buttonid == "nextpage" and embednumber < Buttonlimit then
        print(">>")
        Page = embednumber + 1

        local embedList = ""
        local sortedinv = Collectioninv(iteminv)
        for entryIndex = (Page - 1) * Length + 1, Page * Length, 1 do
            if JSONITEMS[sortedinv[entryIndex]] == nil then
                break
            end
            embedList = embedList.."**["..JSONITEMS[sortedinv[entryIndex]][3].."]** "..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
        end

        message:update({embed = { --(!!)
            color = 0x000000,
            title = "Artifact Progress ["..jsonstats.artifactprogress.."/256]",

            author = {
                name = pname.."'s Artifacts",
                icon_url = iconurl
            },

            description = embedList,
            footer = {
                text = "Page "..Page,
            }
        }})
    end

    if buttonid == "previouspage" and embednumber > 1 then
            print("<<")
            Page = embednumber - 1

            local embedList = ""
            local sortedinv = Collectioninv(iteminv)
            for entryIndex = (Page - 1) * Length + 1, Page * Length, 1 do --im going to strangle this shit
                if JSONITEMS[sortedinv[entryIndex]] == nil then
                    break
                end
                embedList = embedList.."**["..JSONITEMS[sortedinv[entryIndex]][3].."]** "..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
            end
            message:update({embed = {
                color = 0x000000,
                title = "Artifact Progress ["..jsonstats.artifactprogress.."/256]",

                author = {
                    name = pname.."'s Artifacts",
                    icon_url = iconurl
                },

                description = embedList,
                footer = {
                    text = "Page "..Page,
                }
            }})
    end
end)

------
function Collectioninv(iteminv) --sorts artifacts by id
    local tablecloneofinv = {}

    for i, v in pairs(iteminv) do -- clones the users inv
        tablecloneofinv[i] = v;
    end

    table.sort(tablecloneofinv, function (a, b) -- sorts it by id
        --print(JSONITEMS[a][1])
        if (JSONITEMS[a][3] < JSONITEMS[b][3]) then
            return (JSONITEMS[a][3] < JSONITEMS[b][3])
        end
    end)
    --print(tablecloneofinv[1])
    --print(tablecloneofinv[2])
    --print(tablecloneofinv)
    return tablecloneofinv
end
------

return command --  
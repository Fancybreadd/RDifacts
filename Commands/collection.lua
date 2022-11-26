--artifact collection

local command = {} --Awful command
function command.run(message)
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")

    if check then
        jsonstats = json.decode(io.input(check):read("*a"))
        iteminv = jsonstats.inv

        --print (KEYNAMES[1])

        if #iteminv == 0 then --if you have nothing
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

        else --do inv system

            --print("full")
            local embedList = ""

            Length = 1
            Buttonlimit = math.floor(#iteminv / Length)
            local sortedinv = Collectioninv(iteminv)

            for entryIndex = (1 - 1) * Length + 1, 1 * Length, 1 do  --sort all the artifacts
                if JSONITEMS[sortedinv[entryIndex]] == nil then
                    break
                end
                embedList = embedList..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
                --print(JSONITEMS[tablecloneofinv[entryIndex]][1])
                --print(entryIndex)
            end

            message.channel:send({ --send collection inv
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

--BUG NOTE: bot breaks if you press a button from an embed that existed before the bots startup, fixes itself once a button from an embed created after startup is pressed

client:on("buttonPressed", function(buttonid, member, message)  -- inv page
--WHAT THE FUCK ARE YOU
local embedpage = message.embed.footer.text --BIG note, youre taking objects from the MESSAGE, not the updated one below
local embednumber = tonumber(string.sub(embedpage, 6)) --6th character of the "Page X", turn it from string into number
Page = 1 --starting page

    if buttonid == "nextpage" and embednumber < Buttonlimit then
        print(">>")
        Page = embednumber + 1

        local embedList = ""
        local sortedinv = Collectioninv(iteminv)
        for entryIndex = (Page - 1) * Length + 1, Page * Length, 1 do
            if JSONITEMS[sortedinv[entryIndex]] == nil then
                break
            end
            embedList = embedList..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
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

    if buttonid == "previouspage" and embednumber > 1 then
            print("<<")
            Page = embednumber - 1

            local embedList = ""
            local sortedinv = Collectioninv(iteminv)
            for entryIndex = (Page - 1) * Length + 1, Page * Length, 1 do --im going to strangle this shit
                if JSONITEMS[sortedinv[entryIndex]] == nil then
                    break
                end
                embedList = embedList..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
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
)

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
    print(tablecloneofinv)
    return tablecloneofinv
end

return command --  
local prevb = discordia.Button {type = "button", style = "primary", id = "previous", label = "<<", disabled = false}
local nextb = discordia.Button {type = "button", style = "primary", id = "next", label = ">>", disabled = false}

local command = {}
function command.run(message) --lets go again
    print ("collection")
    ProfileID = message.author.id
    Pname = message.author.username
    Iconurl = message.author.avatarURL

    --==--


    ------==oo==------ IGNORE THIS FOR NOW
    if message.mentionedUsers[1][1] then --switch to pinged user if there is
        ProfileID = message.mentionedUsers[1][1]
        Friend = message.guild:getMember(ProfileID).user
        Pname = Friend.username
        Iconurl = Friend.avatarURL
        print (Friend)
        --iconurl = friend.icon_url --Change this later--
        for i,v in pairs(message.mentionedUsers[1]) do print(i,v) end
    end
    ------==oo==------
    local check = io.open(path..ProfileID..".json","r")

    if check then
        Jsonstats = json.decode(io.input(check):read("*a"))
        Iteminv = Jsonstats.inv

        --------------------------------------------------------------------o
        if #Iteminv == 0 then --if you have nothing
            message.channel:send{embed = { --(!!)
                color = 0x000000,
                title = "It's Empty.",

                author = {
                    name = Pname.. "'s Artifacts",
                    icon_url = Iconurl
                },

                description = "You don't own anything!"
            }}

            check:close()
        --------------------------------------------------------------------o

        else --do system
            local embedList = ""
            Length = 2 --amount of artifacts shown per page
            Buttonlimit = math.floor((#Iteminv / Length)) + 1 --the +1 is important
            
            --==--
            local sortedinv = Collectioninv(Iteminv)
            --==--

            --[]--
            for entryIndex = (1 - 1) * Length + 1, 1 * Length, 1 do  --sort all the artifacts
                if JSONITEMS[sortedinv[entryIndex]] == nil then
                    break
                end
                embedList = embedList.."**["..JSONITEMS[sortedinv[entryIndex]][3].."]** "..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
            end
            --[]--

            --===TEXT===--
            Colmenu = message.channel:sendComponents {
                embed = {
                    color = 0x000000, title = "Artifact Progress ["..Jsonstats.artifactprogress.."/256]",
                    author = {
                        name = Pname.. "'s Artifacts",
                        icon_url = Iconurl
                    }, --
                    description = embedList,
                    footer = {
                        text = "Page 1",
                    } --
                },
                components = discordia.Components {prevb,nextb}
            }

            --local pressed, interaction = colmenu:waitComponent("button", nil, 1000 * 10, function(interaction)
            --end)
            --colmenu:update { components = discordia.Components { nextb:disable(), prevb:disable() } } return
        end
    end
end

-------------------------------------------
            --BUTTON CODE--
-------------------------------------------
client:on("interactionCreate", function(interaction) -- look at this later
    local embedpage = interaction.message.embed.footer.text --BIG note, youre taking objects from the MESSAGE, not the updated one below
    local embednumber = tonumber(string.sub(embedpage, 6)) --6th character of the "Page X" footer, turn it from string into number

    print(discordia.enums.interactionType.messageComponent)
    --print(interaction.data.custom_id)
    print(discordia.enums.componentType.button)
    if discordia.enums.interactionType.messageComponent then --if a button is pressed..
        print("a button!")
        --==oo##oo==--
        if interaction.data.custom_id == "next" and embednumber < Buttonlimit then -->>
            --print("NEXT")

            local nextpage = embednumber + 1
            local embedList = ""
            local sortedinv = Collectioninv(Iteminv)
            --[]--
            for entryIndex = (nextpage - 1) * Length + 1, nextpage * Length, 1 do --from max length, to max length * page number do
                if JSONITEMS[sortedinv[entryIndex]] == nil then
                    break
                end
                embedList = embedList.."**["..JSONITEMS[sortedinv[entryIndex]][3].."]** "..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
            end
            --[]--

            interaction:update{
                embed = {
                    color = 0x000000, title = "Artifact Progress ["..Jsonstats.artifactprogress.."/256]",
                    author = {
                        name = Pname.. "'s Artifacts",
                        icon_url = Iconurl
                    }, --
                    description = embedList,
                    footer = {
                        text = "Page "..nextpage,
                    } --
                },
                components = discordia.Components {prevb, nextb}
            }
        end
        --==oo##oo==--
        if interaction.data.custom_id == "previous" and embednumber > 1 then --<<
            --print("PREVIOUS")
            --interaction:replyDeferred(true)

            local nextpage = embednumber - 1
            local embedList = ""
            local sortedinv = Collectioninv(Iteminv)
            --[]--
            for entryIndex = (nextpage - 1) * Length + 1, nextpage * Length, 1 do
                if JSONITEMS[sortedinv[entryIndex]] == nil then
                    break
                end
                embedList = embedList.."**["..JSONITEMS[sortedinv[entryIndex]][3].."]** "..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
            end
            --[]--

            interaction:update{
                embed = {
                    color = 0x000000, title = "Artifact Progress ["..Jsonstats.artifactprogress.."/256]",
                    author = {
                        name = Pname.. "'s Artifacts",
                        icon_url = Iconurl
                    }, --
                    description = embedList,
                    footer = {
                        text = "Page "..nextpage,
                    } --
                },
                components = discordia.Components {prevb, nextb}
            }

        end
        --==oo##oo==--
    end
end)







------DO NOT TOUCH THIS------
function Collectioninv(Iteminv) --sorts artifacts by id
    local tablecloneofinv = {}

    for i, v in pairs(Iteminv) do -- clones the users inv
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
------DO NOT TOUCH THIS------

return command
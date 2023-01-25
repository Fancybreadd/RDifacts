local prevb = discordia.Button {type = "button", style = "primary", id = "col-previous", label = "<<", disabled = false}
local nextb = discordia.Button {type = "button", style = "primary", id = "col-next", label = ">>", disabled = false}

local command = {}
function command.run(message) --lets go again
    print ("collection")
    ProfileID = message.author.id
    Pname = message.author.username
    Iconurl = message.author.avatarURL

    --==--

    local check = io.open(path..ProfileID..".json","r")

    if check then
        Jsonstats = json.decode(io.input(check):read("*a"))
        Iteminv = Jsonstats.inv

        --------------------------------------------------------------------o
        if #Iteminv == 0 then --if you have nothing
            message.channel:sendComponents {
                embed = {
                    color = 0x000000, title = "It's Empty.",
                    author = {
                        name = Pname.. "'s Artifacts",
                        icon_url = Iconurl
                    }, --
                    description = "You don't have any artifacts!",
                    footer = {
                        text = "Page 0/0"
                    } --
                },
            }

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
                        text = "Page 1/"..Buttonlimit,
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
    if string.split(interaction.data.custom_id, "-")[1] == "col" then
        local embedpage = interaction.message.embed.footer.text --BIG note, youre taking objects from the MESSAGE, not the updated one below
        local embednumber = tonumber(string.sub(embedpage, 6, 6)) --6th character of the "Page X" footer, turn it from string into number

            --print("a button!")
            --==oo##oo==--

            if interaction.data.custom_id == "col-next" and embednumber < Buttonlimit then -->>
                --print("NEXT")
                if embedpage == 1 then prevb:disable() end

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
                            text = "Page "..nextpage.."/"..Buttonlimit,
                        } --
                    },
                    components = discordia.Components {prevb, nextb}
                }
            end
            --==oo##oo==--
            if interaction.data.custom_id == "col-previous" and embednumber > 1 then --<<
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
                            text = "Page "..nextpage.."/"..Buttonlimit,
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
local command = {}
function command.run(message, arg, arg2)
    print("inspect")
    --------------------------------------------------------------------FILESELECT
    --single
    local profileID = message.author.id 
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    local username = message.author.username
    local iconurl = message.author.avatarURL

    --==--
    if not check then
        check = makeprofile(profileID)
        noprofile(message)
    end
    --==--

    local jsonstats = json.decode(io.input(check):read("*a"))

    --------------------------------------------------------------------CHECKS
    if arg == nil then --|if no argument
        --print(arg)
        check:close()
        message.channel:send{
            embed = {
                color = 0x535353, title = "Inspecting artifact...?",
                author = {
                    name = username.."'s r$inspect",
                    icon_url = iconurl
                },

                description = "The Index doesn't respond...",
                fields = {
                    name = "No Input! Insert a number corresponding to an Artifact ID to use this command.",
                    value = ""
                },
                footer = {text = "ex: r$inspect "..math.random(1,256)}
            }
        }
        return
    end

    ---o
    local inspectid = tonumber(arg) --turn number in message into a number value
    local if_have = false
    ---o

    if inspectid == nil then --|if argument is not a number
        check:close()
        message.channel:send{
            embed = {
                color = 0x535353, title = "Inspecting artifact...?",
                author = {
                    name = username.."'s r$inspect",
                    icon_url = iconurl
                },

                description = "The Index is confused on what you're looking for...",
                fields = {
                    name = "Input isn't a number!",
                    value = ""
                },
                footer = {text = "ex: r$inspect "..math.random(1,256)}
            }
        }
        return

    elseif inspectid > 256 then --|if argument number is bigger than amount of existing artifacts
        check:close()
        message.channel:send{
            embed = {
                color = 0x535353, title = "Inspecting artifact...?",
                author = {
                    name = username.."'s r$inspect",
                    icon_url = iconurl
                },

                description = "The Index is confused on what you're looking for...",
                fields = {
                    name = "Artifact doesn't exist!",
                    value = ""
                },
                footer = {text = "Current highest ID is 256."}
            }
        }
        return

    end

    for i,v in ipairs (jsonstats.inv) do --|loop code until if you have the artifact
    if v == KEYNAMETABLE[inspectid] then
            if_have = true --turn this to true
            break
        end
        --print(i,v)
    end

    if if_have == false then --|if you dont have the artifact
        check:close()
        message.channel:send{
            embed = {
                color = 0x535353, title = "Inspecting artifact...?",
                author = {
                    name = username.."'s r$inspect",
                    icon_url = iconurl
                },

                description = "The Index understands, but it can't tell you anything you can't bestow it...",
                fields = {
                    name = "You don't have this artifact yet!",
                    value = ""
                },
                footer = {text = "Use r$inspect on artifacts you own!"}
            }
        }
        return
    end

    --------------------------------------------------------------------COMMAND
    local arname =(JSONITEMS[KEYNAMETABLE[inspectid]][1]) --name
    local aremote =(JSONITEMS[KEYNAMETABLE[inspectid]][2]) --emoji, sprite
    local argrade =(JSONITEMS[KEYNAMETABLE[inspectid]][3]) --grade
    local arID =(JSONITEMS[KEYNAMETABLE[inspectid]][4]) --ID
    local ardesc =(JSONITEMS[KEYNAMETABLE[inspectid]][5]) --description
    local aroig = "Original" --Origin  < v
    if (JSONITEMS[KEYNAMETABLE[inspectid]][6]) ~= nil then aroig = (JSONITEMS[KEYNAMETABLE[inspectid]][6]) end


    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0x535353, title = "Inspecting artifact "..aremote,
            author = {
                name = username.."'s r$inspect",
                icon_url = iconurl
            },

            description = "# "..arname.."\n"..ardesc,
            fields = {
                {
                    name = "Grade",
                    value = argrade,
                    inline = true
                },
                {
                    name = "ID",
                    value = arID,
                    inline = true
                },
                {
                    name = "Origin",
                    value = aroig
                }
            }
        }
    }
end
return command --

--JSONITEMS[KEYNAMETABLE[inspectid][X]]
local command = {}
function command.run(message, arg, arg2)
    print("inspect")
    --------------------------------------------------------------------FILESELECT
    local profileID = message.author.id 
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")

    --==--
    if not check then
        local profile = io.open(BotPath.."PROFILES/"..profileID..".json","w")
        noprofile(message)
        check = makeprofile(profile, profileID)
    end
    --==--

    local jsonstats = json.decode(io.input(check):read("*a")) --print("check!")

    --------------------------------------------------------------------CHECKS
    if arg == nil then --|if no argument
        --print(arg)
        message.channel:send(message.author.username..", please input an id number of an artifact! ``ex: h$inspect "..math.random(1,256).."``")
        return
    end

    ---o
    local inspectid = tonumber(arg) --turn number in message into a number value
    local if_have = false
    ---o

    if inspectid == nil then --|if argument is not a number
        message.channel:send(message.author.username..", did you input an artifacts id correctly? ``ex: h$inspect "..math.random(1,256).."``")
        return

    elseif inspectid > 256 then --|if argument number is bigger than amount of existing artifacts
        message.channel:send(message.author.username..", this artifact does not exist!")
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
        message.channel:send(message.author.username..", you do not have this artifact!")
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
    message.channel:send{embed = {
        color = 0x000000, title = arname.." "..aremote,
        author = {
            name = "Inspecting artifact...",
        },

        description = ardesc,
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
    }}
end
return command --

--JSONITEMS[KEYNAMETABLE[inspectid][X]]
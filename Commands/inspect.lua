local command = {}
function command.run(message, arg, arg2)
    print("inspect")
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    local if_have = false
    --==--
    if not check then
        local profile = io.open(path..profileID..".json","w")
        noprofile(message)
        check = makeprofile(profile, profileID)
    end
    --==--
    local jsonstats = json.decode(io.input(check):read("*a")) --print("check!")

    --------------------------------------------------------------------o
    if arg then --print(arg)
        ---o
        local inspectid = tonumber(arg) --turn number in message into a number value
        ---o

        for i,v in ipairs (jsonstats.inv) do --loops this command to check inv until it has the item you selected
            if v == KEYNAMETABLE[inspectid] then --if detected!
                if_have = true --turn this to true
                break
            end
            --print(i,v)
        end

        if if_have == true then
            ----==++==----
            local arname =(JSONITEMS[KEYNAMETABLE[inspectid]][1]) --name
            local aremote =(JSONITEMS[KEYNAMETABLE[inspectid]][2]) --emoji, sprite
            local argrade =(JSONITEMS[KEYNAMETABLE[inspectid]][3]) --grade
            local arID =(JSONITEMS[KEYNAMETABLE[inspectid]][4]) --ID
            local ardesc =(JSONITEMS[KEYNAMETABLE[inspectid]][5]) --description
            local aroig = "Original" --Origin
            if (JSONITEMS[KEYNAMETABLE[inspectid]][6]) ~= nil then aroig = (JSONITEMS[KEYNAMETABLE[inspectid]][6]) end
            ----==++==----
            message.channel:send{embed = {
                color = 0x000000, title = arname.." "..aremote,
                author = {
                    name = "Inspecting Artifact..",
                },

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
                        name = "Description",
                        value = ardesc,
                        inline = false
                    },
                    {
                        name = "Origin",
                        value = aroig
                    }

                },
                }}
        return
        end
        --else if false
        if inspectid == nil then message.channel:send(message.author.username..", did you input an artifacts id correctly? ``ex: h$inspect "..math.random(1,256).."``") --if no numbers
        elseif inspectid < 256 then message.channel:send(message.author.username..", you do not have this artifact!") -- if id of an item you dont have
        else message.channel:send(message.author.username..", this artifact does not exist!") -- if id is bigger than existing ids
        end

    return
    end
    --------------------------------------------------------------------o ELSE
    message.channel:send(message.author.username..", please input an id number of an artifact! ``ex: h$inspect "..math.random(1,256).."``") --if no args
    --------------------------------------------------------------------o
end
return command --

--JSONITEMS[KEYNAMETABLE[inspectid][X]]
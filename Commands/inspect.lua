local command = {}
function command.run(message, arg, arg2)
    print("inspect")
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    --==--
    if check then
        jsonstats = json.decode(io.input(check):read("*a"))
        iteminv = jsonstats.inv
        --print("check!")
        if arg then
            --print(arg)
            ------------o
            inspectid = tonumber(arg) --turn number in message into a number value
            ------------o
            for i,v in ipairs (jsonstats.inv) do --loops this command to check inv until it has the item you selected
                if v == KEYNAMETABLE[inspectid] then --if detected!
                    if_have = true --turn this to true
                    break
                end
                --print(i,v)
            end

            if if_have == true then
                ---------------------------------------------------------o
                local ardesc =(JSONITEMS[KEYNAMETABLE[inspectid]][5])
                local argrade =(JSONITEMS[KEYNAMETABLE[inspectid]][4])
                local arID =(JSONITEMS[KEYNAMETABLE[inspectid]][3])
                local aremote =(JSONITEMS[KEYNAMETABLE[inspectid]][2])
                local arname =(JSONITEMS[KEYNAMETABLE[inspectid]][1])
                ---------------------------------------------------------o
                message.channel:send{embed = { --(!!)
                    color = 0x000000,
                    title = arname.." "..aremote,

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

                    },
                }}
                if_have = false

            else --(!!)
                if inspectid == nil then message.channel:send(message.author.username..", did you input the id correctly? ``ex: h$inspect 94``") --if no numbers
                else if inspectid < 256 then message.channel:send(message.author.username..", you do not have this artifact!") -- if id of an item you dont have
                    else message.channel:send(message.author.username..", this artifact does not exist!") -- if id is bigger than existing ids
                end end
            end
        else message.channel:send(message.author.username..", please input an id number of an artifact!") --if no args

        end
    else noprofile(message) --(!!)
    end
end
return command --

--JSONITEMS[KEYNAMETABLE[inspectid][X]]
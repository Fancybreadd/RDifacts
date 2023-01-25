--OLD VER OF H$OPEN

local command = {}
function command.run(message)
    print("open")
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    --==--

    if check then
        jsonstats = json.decode(io.input(check):read("*a"))
        keys = jsonstats.wallet.keys capsules = jsonstats.wallet.capsules

        ---ooo---
        if keys >= 1 and capsules >= 1 then --if you actually have a capsule and a key
            --print("capsuleopening")
            jsonstats.wallet.keys = jsonstats.wallet.keys - 1
            jsonstats.wallet.capsules = jsonstats.wallet.capsules - 1

            local prizeval = math.random(1,4) --
            local if_have = false

            --==++==--
            for i,v in ipairs (jsonstats.inv) do --loops this command to check inv until it has a copy of an item
                if v == KEYNAMETABLE[prizeval] then --if theres a copy
                    if_have = true --turn this to true
                    break
                end
            --print(i,v)
            end
            --==++==--

            -----------------------------------o
            if if_have == false then --if theres no copy.. do
                print(JSONITEMS[KEYNAMETABLE[prizeval]][1]..JSONITEMS[KEYNAMETABLE[prizeval]][3])

                table.insert(jsonstats.inv, KEYNAMETABLE[prizeval]) --gives you items keyname
                jsonstats.artifactprogress = jsonstats.artifactprogress + 1

                updatesave(profileID, jsonstats, check) --(S)

                message.channel:send("Opening capsule...")
                message.channel:send(JSONITEMS[KEYNAMETABLE[prizeval]][2])
                message.channel:send("You got a **"..JSONITEMS[KEYNAMETABLE[prizeval]][1].."** !!")
            return end --end command
            -----------------------------------o
            jsonstats.wallet.emblems = jsonstats.wallet.emblems + 1
            updatesave(profileID, jsonstats, check) --(S)

            message.channel:send("Opening capsule...")
            message.channel:send(JSONITEMS[KEYNAMETABLE[prizeval]][2])
            message.channel:send("Seems like you got a dupe.. \n**+1 Emblem**")
            -----------------------------------o

        else ---ooo---
            if keys == 0 and capsules == 0 then
                message.channel:send(message.author.username..", you're both out of capsules and keys!")
            else if keys == 0 then
                message.channel:send(message.author.username..", you're out of keys!")
            end

            if capsules == 0 then
                message.channel:send(message.author.username..", you're out of capsules!")
            end
            end
        end
        ---ooo---

    else noprofile(message) end
end
return command --

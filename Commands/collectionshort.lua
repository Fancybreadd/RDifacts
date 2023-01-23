local command = {}
function command.run(message, arg)
    print("collectionshort")
    local profileID = message.author.id 
    --==--
 
    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))
        local iteminventory = jsonstats.inv

        --print (KEYNAMES[1])
        if arg then
            parg = tonumber(arg)
            print(parg)
            if parg ~= nil then
                pagenum = parg
            end
        else pagenum = 1 end

        if #iteminventory == 0 then 
            message.channel:send("**[Empty]**") --(!!)

            check:close()
            --print("nah")
        else
            --print("full")
            local emoteList = ""

            Length = 2 --actually 32
            local sortedinventory = Collectioninv(iteminventory)

            for entryIndex = (pagenum - 1) * Length + 1, pagenum * Length, 1 do  --actually sets them up for the embed --also its spose be Page - 1 but since all new inv starts at Page 1..
                if JSONITEMS[sortedinventory[entryIndex]] == nil then
                    break
                end
                emoteList = emoteList..JSONITEMS[sortedinventory[entryIndex]][2]
                --print(entryIndex)
            end

            local shortinv = message.channel:send(emoteList) --(!!)
            check:close()

        end
    else noprofile(message)
    end
end

--------------------------
function Collectioninv(iteminventory)
    local tablecloneofinventory = {}

    for index, value in pairs(iteminventory) do -- clones the users inv
        tablecloneofinventory[index] = value;
        print (index)
    end

    table.sort(tablecloneofinventory, function (a, b) -- sorts it by id
        --print(JSONITEMS[a][1])
        if (JSONITEMS[a][3] < JSONITEMS[b][3]) then
            return (JSONITEMS[a][3] < JSONITEMS[b][3])
        end
    end)
    --print(tablecloneofinventory[1])
    --print(tablecloneofinventory[2])
    return tablecloneofinventory
end
return command --


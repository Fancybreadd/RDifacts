local command = {}
function command.run(message, arg)
    --print("display")
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")

    if check then
        jsonstats = json.decode(io.input(check):read("*a"))
        displayinv = jsonstats.favinv
        iteminv = jsonstats.inv

        favlength = jsonstats.favinvlimit

        if arg then 
            local favid = tonumber(arg)

            if favid ~= nil then --if not nil and is a number
                for i,v in ipairs (jsonstats.inv) do --loops this command to check inv until it has the item you selected
                    if v == KEYNAMETABLE[favid] then --if detected!
                        if_have = true --turn this to true
                        break
                    end
                print(i,v.."inv")
                end

                for i,v in ipairs (displayinv) do --loops this command to check favinv until it has a copy of a favorite
                    if v == KEYNAMETABLE[favid] then --if detected!
                        if_favhave = true --turn this to true
                        break
                    end
                print(i,v)
                end

                if if_have == true and if_favhave == false then
                    table.insert(jsonstats.favinv, KEYNAMETABLE[favid])

                    local modify = io.open(path..profileID..".json","w")
                    io.output(modify):write(json.encode(jsonstats)) modify:flush() --update and save
                    modify:close() check:close() --close
                    if_have = false
                    if_favhave = false

                    message.channel:send(message.author.username..", you put "..JSONITEMS[KEYNAMETABLE[inspectid]][2].." in display!")
                    print("displayed!!!!")
                else
                    if if_favhave == true then
                        message.channel:send(message.author.username..", you already have this one displayed!")

                        if_favhave = false
                    else
                        if favid < 256 then message.channel:send(message.author.username..", you do not have this artifact!") -- if id of an item you dont have
                        else if favid > 256 then message.channel:send(message.author.username..", this artifact does not exist!") -- if id is bigger than existing ids
                        end end
                    end
                end
            else
                print("boo")
            end
        end


    else noprofile(message)
    end
end
return command --
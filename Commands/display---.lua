local command = {}
function command.run(message, arg)
    print("display")
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    --==--
    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))
        local displayinv = jsonstats.favinv
        local iteminv = jsonstats.inv
        local favlength = jsonstats.favinvlimit
        ----------------------------------------------------------------------
        if arg then
            ---------o
            local favid = tonumber(arg)
            ---------o
            if favid ~= nil then --if not nil and is a number
                local if_have

                for i,v in ipairs (jsonstats.inv) do --loops this command to check inv until it has the item you selected
                    if v == KEYNAMETABLE[favid] then --if detected!
                        if_have = true --turn this to true
                        break
                    end
                print(i,v.."inv")
                end

                --------------------------------------------o
                if if_have then --if you have the artifact

                    local removed = false

                    for i,v in ipairs(displayinv) do
                      if v == KEYNAMETABLE[favid] then -- if you have it already favorited
                        table.remove(displayinv, i) -- remove from favorites
                        removed = true -- flip the removed boolean
                        break
                      end
                    end

                    -- if item was removed, end function
                    if removed then 
                        updatesave(profileID, jsonstats, check) --(S)

                        message.channel:send(message.author.username..", you took off **"..JSONITEMS[KEYNAMETABLE[favid]][1].."** "..JSONITEMS[KEYNAMETABLE[favid]][2].." from display.") 
                        removed = false
                    return end

                    -- function didn't return, add to favs
                    table.insert(jsonstats.favinv, KEYNAMETABLE[favid])

                    updatesave(profileID, jsonstats, check) --(S)

                    message.channel:send(message.author.username..", you put **"..JSONITEMS[KEYNAMETABLE[favid]][1].."** "..JSONITEMS[KEYNAMETABLE[favid]][2].." in display!")
                    if_have = false

                    print("displayed!!!!")
                else --if both does not apply
                    if favid < 256 then message.channel:send(message.author.username..", you do not have this artifact!") -- if id of an item you dont have
                    else message.channel:send(message.author.username..", this artifact does not exist!") end -- if id is bigger than existing ids
                end
                ------------------------------------------o
            else message.channel:send(message.author.username..", try putting an id number instead!") -- if not a number
            end
        return end
        ----------------------------------------------------------------------
        ----------------------------------------------------------------------
    else noprofile(message) --(!!)
    end
end
return command --


client:on("messageCreate", function(message)
    if message.content == prefix..'open' or message.content == prefix..'o' then
        local profileID = message.author.id 
        local check = io.open(path..profileID..".json","r")
        

        if check then
            jsonstats = json.decode(io.input(check):read("*a"))

            keys = jsonstats.wallet.keys
            boxes = jsonstats.wallet.boxes

            if keys >= 1 and boxes >= 1 then --if you actually have a box and a key
                print("boxopenyes")
                jsonstats.wallet.keys = jsonstats.wallet.keys - 1
                jsonstats.wallet.boxes = jsonstats.wallet.boxes - 1

                local prizeval = math.random(1,4) --
                local if_have = false
                for i,v in ipairs (jsonstats.inventory) do --check player inventory if they have a copy
                    if v == KEYNAMETABLE[prizeval] then
                        if_have = true
                        break
                    end
                print(i,v)
                end
      

                if if_have == false then --if theres no copy.. do
                    print(JSONITEMS[KEYNAMETABLE[prizeval]][1]..JSONITEMS[KEYNAMETABLE[prizeval]][3])
       
                    table.insert(jsonstats.inventory, KEYNAMETABLE[prizeval]) --gives you items keyname
                    jsonstats.artifactprogress = jsonstats.artifactprogress + 1
       
                    local modify = io.open(path..profileID..".json","w")
                    io.output(modify):write(json.encode(jsonstats))
                    
                    modify:flush()
                    modify:close()
                    check:close()

                    message.channel:send("Opening box...")
                    message.channel:send("added " ..JSONITEMS[KEYNAMETABLE[prizeval]][1])

                else

                    local modify = io.open(path..profileID..".json","w")
                    io.output(modify):write(json.encode(jsonstats))
                    
                    modify:flush()
                    modify:close()
                    check:close()
                       
                    message.channel:send("copy!")
                end
                
            else
                if keys == 0 and boxes == 0 then
                    message.channel:send(message.author.username..", you're both out of boxes and keys!")
                else
                    if keys == 0 then
                        message.channel:send(message.author.username..", you're out of keys!")
                    end

                    if boxes == 0 then
                        message.channel:send(message.author.username..", you're out of boxes!")
                    end
                end


            end
           
               

            
            
        end
    end
end)

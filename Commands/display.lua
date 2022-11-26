local command = {}
function command.run(message, arg)
    print("display")
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")

    if check then
        jsonstats = json.decode(io.input(check):read("*a"))
        displayinv = jsonstats.favinv
        iteminv = jsonstats.inv

        favlength = jsonstats.favinvlimit

        if arg then --if theres a number with the command
            print(arg)
            selectedarid = tonumber(arg)
            print(selectedarid)
            if selectedarid then
                local ar = 'ar'..selectedarid
                print (ar)
                if ar then
                    --table.insert(jsonstats.displayinv,ar)

                    --local modify = io.open(path..profileID..".json","w")
                    --io.output(modify):write(json.encode(jsonstats)) modify:flush() --update and save
                    --modify:close() check:close() --close

                else print("you dont have it")
                end
            end

        else if #displayinv > 0 then --else if you have a displayinv
            print("oo!")
            message.channel:send("a")
            else message.channel:send(message.author.username..", you do not have any displayed artifacts!")
            end
        end


    else noprofile(message)
    end
end
return command --
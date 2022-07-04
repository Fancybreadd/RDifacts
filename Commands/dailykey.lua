client:on("messageCreate", function(message)
    if message.content == prefix..'dailykey' or message.content == prefix..'dk' then
        local profileID = message.author.id
        local check = io.open(path..profileID..".json","r")
        print("dailykey")
        
        if check then
            local jsonstats = json.decode(io.input(check):read("*a"))
            
            local currenttime = os.time()
            local playercooldown = jsonstats.timers.keytimer + DKCOOLDOWN
            --local randomplus = math.random(4,20)
            
            if currenttime > playercooldown then
                jsonstats.timers.keytimer = os.time()

                jsonstats.wallet.keys = jsonstats.wallet.keys + 1
                message.channel:send(message.author.username..", you grab your daily key from the keygiver. \n**+ 1 <:boxkey:974300640178221106> Key**")
            

                local modify = io.open(path..profileID..".json","w")
                io.output(modify):write(json.encode(jsonstats))
                
                modify:flush()
                modify:close()
                check:close()
                
            else
                check:close()
                local remainingtime = playercooldown - currenttime --gets remaining unix time 
                --print(remainingtime)
                local readableremainingtime = SecondsToClock(remainingtime)

                message.channel:send(message.author.username..", you try and grab a key.. but the keygiver stops you! \n**"..readableremainingtime.." left!**")
                
            end


            --message.channel:send("added "..randomplus.. " marbles!")

        end
    end
end)
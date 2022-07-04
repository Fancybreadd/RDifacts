client:on("messageCreate", function(message)
    if message.content == prefix..'keys' or message.content == prefix..'k'then
        local profileID = message.author.id 
        local check = io.open(path..profileID..".json","r")


        if check then
            local jsonstats = json.decode(io.input(check):read("*a"))
            
            local keys = jsonstats.wallet.keys

            message.channel:send("**You have "..keys.."** <:boxkey:974300640178221106> **Keys**")
            
          
        end
    end
end)
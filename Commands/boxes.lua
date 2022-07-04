client:on("messageCreate", function(message)
    if message.content == prefix..'box' or message.content == prefix..'b'then
        local profileID = message.author.id 
        local check = io.open(path..profileID..".json","r")


        if check then
            local jsonstats = json.decode(io.input(check):read("*a"))
            
            local boxes = jsonstats.wallet.boxes

            message.channel:send("**You have "..boxes.."** <:treasurebox:974300654946365450> **Treasure Boxes**")
          
        end
    end
end)
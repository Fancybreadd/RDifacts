client:on('messageCreate', function(message)
    if message.content == prefix.."ping" then
        print("ping")
        message.channel:send(message.author.mentionString.. " pong!")
        --local result = string.gsub (message.content,"ping","X")
        --print(result)

        --message.channel:send(result)
        
    end
end)



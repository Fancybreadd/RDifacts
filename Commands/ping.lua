client:on('messageCreate', function(message)
    if message.content == prefix.."ping" then
        print("ping")
        message.channel:send(message.author.mentionString.. " pong!")
        
    end
end)

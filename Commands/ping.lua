local command = {}
function command.run(message, arg, arg2)
    print("ping")
    --------------------------------------------------------------------COMMAND
    message.channel:send(message.author.mentionString.. " pong!") print(message.author.id)
end
return command --
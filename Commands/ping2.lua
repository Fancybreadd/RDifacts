--FOR NEW COMMAND SYSTEM TESTING BUT IDK HWO IT WORKS YET
local command = {}
function command.run(message,args)
    print("ping")
    message.channel:send(message.author.mentionString.. " pong!")

end
return command
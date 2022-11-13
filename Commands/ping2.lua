--FOR NEW COMMAND SYSTEM TESTING BUT IDK HWO IT WORKS YET
local command = {}
function command.run(message,args)

    if message.content == prefix.."ping" then
        print("ping")
        message.channel:send(message.author.mentionString.. " pong!")
        --local result = string.gsub (message.content,"ping","X")
        --print(result)

        --message.channel:send(result)
        
    end
end
return command
local command = {} --DEV COMMAND
function command.run(message, arg, arg2)
    if message.author.id ~= 812228180499890187 or message.author.id ~= 1001946516610621480 then
        return
    end

    print("Wiping emojis...")
    local emojis = message.guild.emojis

    for k, v in pairs (emojis) do
        print (k, v)
        v:delete()
    end

    message.channel:send("All emojis deleted!")
end
return command --
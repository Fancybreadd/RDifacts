local command = {}
function command.run(message)
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    --{}{command}{}--
    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))

        local keys = jsonstats.wallet.keys
        local capsules = jsonstats.wallet.capsules

        message.channel:send( --(!!)--
            "**You have "..keys.."** "..MENUKEY.." **Keys** \n"
            .."**You have "..capsules.."** "..MENUCAPSULE.. " **Capsules** \n"
         )
    else noprofile(message)
    end
end
return command --
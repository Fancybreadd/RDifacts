--checks keys and capsules--

local command = {}
function command.run(message)
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")


    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))

        local keys = jsonstats.wallet.keys
        local capsules = jsonstats.wallet.capsules

        message.channel:send(
            "**You have "..keys.."** <:boxkey:974300640178221106> **Keys** \n"
            .."**You have "..capsules.."** <:boxkey:974300640178221106> **Capsules** \n"
         )
    else noprofile(message)
    end
end
return command --
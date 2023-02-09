--get an account stupid--

_G['noprofile'] = function (message)
    message.channel:send{embed = {
        color = 0x000000, title = "You had to register before doing this action...",

        author = {
            name = "Signing up...",
            icon_url = message.author.avatarURL
        },

        description = "You head to the artifacts guild and get yourself for an adventurers account. After signing some waivers, you are welcomed with a free starter box and key. \n\n**You now have full access to all commands!**\n**+1** <:boxkey:974300640178221106> **Key   +1** <:treasurebox:974300654946365450> **Capsule**"
    }}
end

_G['makeprofile'] = function (profile, profileID)
    local stats = {
        wallet = {keys=1,capsules=1,marbles=0,materials=0,ingredients=0,emblems=0,startonics=0},
        inv = {},
        favinv = {},
        favinvlimit = 3,
        timers = {adventuretimer=0,keytimer=0,giftkeytimer=0}
    }
    local jsonstats = json.encode(stats)

    profile:write(jsonstats) profile:close() --(S)
    local check = io.open(path..profileID..".json","r")
    print(check)
    return check
end

_G['updatesave'] = function (profileID, jsonstats, check)
    local modify = io.open(path..profileID..".json","w")
    io.output(modify):write(json.encode(jsonstats)) modify:flush() modify:close() check:close() --update, save, close
end
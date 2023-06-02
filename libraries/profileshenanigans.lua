-------------------------------------------------get an account stupid
_G['noprofile'] = function (message)
    message.channel:send{embed = {
        color = 0x000000, title = "You had to register before doing this action...",

        author = {
            name = "Signing up...",
            icon_url = message.author.avatarURL
        },

        description = "You head to the Explorers Association to get yourself a **Collectors Permit!** After signing a few papers, you are given your ID card and are welcomed with a free starter **Capsule** "..MENUCAPSULE.." and **Key** "..MENUKEY..".",
        fields = {
            {
                name = "**+1 Capsule** "..MenuCAPSULE,
                value = " "
            },
            {
                name = "**+1 Key** "..MenuKEY,
                value = " "
            }
        },

        footer = {text = "You now have access to all of RDifacts commands!"}
    }}
end

-------------------------------------------------your friend doesnt have an account, stupid
_G['nofriendprofile'] = function (message, pname, iconurl)
    message.channel:send{embed = {
        color = 0x000000, title = "No Profile Found!",

        author = {
            name = pname,
            icon_url = iconurl
        },

        description = "You look through the Explorers Registry, seems like the person in question does not have an account..."
    }}
end

-------------------------------------------------making your account, stupid
_G['makeprofile'] = function (profile, profileID)
    local stats = {
        wallet = {keys=1,capsules=1,marbles=0,materials=0,ingredients=0,emblems=0,startonics=0},
        inv = {},
        favinv = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},
        timers = {adventuretimer=0,keytimer=0,giftkeytimer=0},
        unlocks = {museum=false},
        version = "1a"
    }
    local jsonstats = json.encode(stats)

    profile:write(jsonstats) profile:close() --(S)
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    print(check)
    return check
end

-------------------------------------------------TBA (--
_G['verify'] = function (profileID, jsonstats, check)
    local template = io.open(BotPath.."PROFILES/TEMPLATE.json","r")
    local tempstats = json.decode(io.input(template):read("r"))

    for k, v in pairs(template) do
        if jsonstats.version ~= template.version then
            for k,v in pairs(template) do
                if jsonstats[k] == nil then jsonstats[k] = template[k]
                end
            end
        end
    end

    profile.version = template.version
end

-------------------------------------------------updates and saves your file, stupid
_G['updatesave'] = function (profileID, jsonstats, check)
    local modify = io.open(BotPath.."PROFILES/"..profileID..".json","w")
    io.output(modify):write(json.encode(jsonstats)) modify:flush() modify:close() check:close() --update, save, close
end
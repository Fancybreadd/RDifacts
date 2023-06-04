-------------------------------------------------[ACCOUNT REGISTERING]
_G['noprofile'] = function (message)
    message.channel:send{
        embed = {
            color = 0x000000, title = "You had to register before doing this action...",

            author = {
                name = "Signing up...",
                icon_url = message.author.avatarURL
            },

            description = "You head to the Explorers Association to get yourself a **Collectors Permit!** After signing a few papers, you are given your ID card and are welcomed with a free starter **Capsule** "..MenuCAPSULE.." and **Key** "..MenuKEY..".",
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
        }
    }
end

-------------------------------------------------[YOUR FRIEND DOESNT HAVE AN ACCOUNT]
_G['nofriendprofile'] = function (message, pname, iconurl)
    message.channel:send{
        embed = {
            color = 0x000000, title = "No Profile Found!",

            description = "You look through the Explorers Registry, seems like the person in question hasn't registered..."
        }
    }
end

-------------------------------------------------[MAKE A NEW ACCOUNT]
_G['makeprofile'] = function (profileID)
    io.open(BotPath.."PROFILES/"..profileID..".json","w")

    :write(
        io.open(BotPath.."PROFILES/TEMPLATE.json","r")
        :read("a")
    )
    :close() --(S)

    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    print(check)
    return check
end
--TO DO: replace makeprofile with just copying it from the template json

-------------------------------------------------[VERIFY AND UPDATE ACCOUNT VERSIONS]
_G['verify'] = function (jsonstats)
    print("verifying...")
    for k,v in pairs(tempstats) do
        if jsonstats[k] == nil then jsonstats[k] = tempstats[k]
        end
    end
    jsonstats.version = tempstats.version

    return jsonstats
end

-------------------------------------------------[SAVE AND UPDATE ACCOUNTS]
_G['updatesave'] = function (profileID, jsonstats, check)
    local modify = io.open(BotPath.."PROFILES/"..profileID..".json","w")
    io.output(modify):write(json.encode(jsonstats)) modify:flush() modify:close() check:close() --update, save, close
end

-------------------------------------------------[TIME FORMAT HANDLING]
_G["SecondsToClock"] = function (seconds)
    local days = math.floor(seconds / 86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds / 3600 )
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds / 60)
    seconds = seconds - minutes * 60

    if days ~= 0 then
        return string.format("%d Days, %d Hours, %d Minutes, %d Seconds",days,hours,minutes,seconds)
    else if hours ~= 0 then
        return string.format("%d Hours, %d Minutes, %d Seconds",hours,minutes,seconds)
    else if minutes ~=0 then
        return string.format("%d Minutes, %d Seconds",minutes,seconds)
    else if seconds ~=0 then
        return string.format("%d Seconds",seconds)
    end end end end
    --return string.format("%d days, %d hours, %d minutes, %d seconds.",days,hours,minutes,seconds)

    --print(SecondsToClock(8643660))
    --print(SecondsToClock(3660))
    --print(SecondsToClock(60))
    --print(SecondsToClock(30))
end

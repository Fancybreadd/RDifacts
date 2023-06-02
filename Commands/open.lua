
local yesopen = discordia.Button {type = "button", style = "success", id = "open-yes", label = "Yes", disabled = true}
local noopen = discordia.Button {type = "button", style = "danger", id = "open-no", label = "No", disabled = true}

local command = {}
function command.run(message)
    print("open")
    --------------------------------------------------------------------FILESELECT
    local profileID = message.author.id 
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")

    --==--
    if not check then
        local profile = io.open(BotPath.."PROFILES/"..profileID..".json","w")
        noprofile(message)
        check = makeprofile(profile, profileID)
    end
    --==--

    --------------------------------------------------------------------INFO
    local jsonstats = json.decode(io.input(check):read("*a"))
    local keys = jsonstats.wallet.keys
    local capsules = jsonstats.wallet.capsules
    local opentext = "You don't have enough to open a capsule."

    --------------------------------------------------------------------CHECKS
    if keys >= 1 and capsules >= 1 then
        yesopen:enable() noopen:enable()
        opentext = "Open a capsule?"
    end

    --------------------------------------------------------------------COMMAND
    local openmsg = message.channel:sendComponents {
        embed ={
            color = 0x000000, title = capsules.." Capsules "..MenuCAPSULE.."\n-----[x]-----\n"..keys.." Keys "..MenuKEY,
            footer = {text = opentext}
        },
        components = discordia.Components {yesopen, noopen}
    }

    local pressed, interaction = openmsg:waitComponent("button", nil, 1000 * 30, function(interaction) --if a button is pressed
        print(interaction.member.id)
        if interaction.user.id ~= profileID then
            interaction:reply("You can't use this button!", true)
            return false
        end

        return true
    end)

    openmsg:update { --turn off buttons after interaction
        embed ={
            color = 0x000000, title =  capsules.." Capsules "..MenuCAPSULE.."\n-----[x]-----\n"..keys.." Keys "..MenuKEY,
            footer = {text = opentext}
        },
        components = discordia.Components {yesopen:disable(), noopen:disable()}
    }

    if not pressed then
        print("h$open timed out")
        return
    end

    --------------------------------------------------------------------BUTTON CODE
    print("press! rechecking..") --redeclaring for button abuse 
    check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    jsonstats = json.decode(io.input(check):read("*a"))
    keys = jsonstats.wallet.keys local capsules = jsonstats.wallet.capsules

    if interaction.data.custom_id == "open-yes" and keys >= 1 and capsules >= 1 then --|if you press yes and still have the requirements
        --interaction:reply("insert code here")
        jsonstats.wallet.keys = jsonstats.wallet.keys - 1 jsonstats.wallet.capsules = jsonstats.wallet.capsules - 1

        local prizeval = math.random(1,4) 
        local if_have = false

        --CHECKER
        for i,v in ipairs (jsonstats.inv) do --loops this command to check inv until it has a copy of an item
            if v == KEYNAMETABLE[prizeval] then --if copy
                if_have = true --turn this to true
                break
            end --print(i,v)
        end

        --IF NEW
        if if_have == false then --if theres no copy.. do
            table.insert(jsonstats.inv, KEYNAMETABLE[prizeval]) --gives you items keyname
            updatesave(profileID, jsonstats, check) --(S)

            interaction:reply("Opening capsule...")
            message.channel:send(MenuCAPSULE.." "..JSONITEMS[KEYNAMETABLE[prizeval]][2].." "..MenuCAPSULE)
            message.channel:send("You obtained **"..JSONITEMS[KEYNAMETABLE[prizeval]][1].."** !")

        return end --end command

        --IF COPY
        jsonstats.wallet.emblems = jsonstats.wallet.emblems + 1
        updatesave(profileID, jsonstats, check) --(S)

        interaction:reply("Opening capsule...")
        message.channel:send(MenuCAPSULE.." "..JSONITEMS[KEYNAMETABLE[prizeval]][2].." "..MenuCAPSULE)
        message.channel:send("Seems like you got a dupe.. \n**+1 Emblem**")
        return

    elseif interaction.data.custom_id == "open-no" then --|if you press no
        interaction:reply(message.author.name..", You changed your mind.")
        return
    else --|if you pressed yes but dont have the requirements
        message.channel:send("no")
    end
end



return command --
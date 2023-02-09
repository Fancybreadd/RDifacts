
local yesopen = discordia.Button {type = "button", style = "success", id = "open-yes", label = "Yes", disabled = true}
local noopen = discordia.Button {type = "button", style = "danger", id = "open-no", label = "No", disabled = true}

local command = {}
function command.run(message)
    print("open")
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    --==--
    if not check then
        local profile = io.open(path..profileID..".json","w")
        noprofile(message)
        check = makeprofile(profile, profileID)
    end
    --==--

    local jsonstats = json.decode(io.input(check):read("*a"))
    local keys = jsonstats.wallet.keys local capsules = jsonstats.wallet.capsules
    local opentext = "You don't have enough to open a capsule."

    if keys >= 1 and capsules >= 1 then
        yesopen:enable() noopen:enable()
        opentext = "Open a capsule?"
    end

    local openmsg = message.channel:sendComponents {
        embed ={
            color = 0x000000, title = capsules.." Capsules "..MENUCAPSULE.."\n-----[x]-----\n"..keys.." Keys "..MENUKEY,
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
    ------------------------------- WAIT FOR INTERACTION-------------------------------------

    openmsg:update { --turn off buttons
        embed ={
            color = 0x000000, title =  capsules.." Capsules "..MENUCAPSULE.."\n-----[x]-----\n"..keys.." Keys "..MENUKEY,
            footer = {text = opentext}
        },
        components = discordia.Components {yesopen:disable(), noopen:disable()}
    }

    if not pressed then
        print("h$open timed out")
        return
    end

    ----------=-=-=-=BUTTON CODE=-=-=-=------------
    print("press! running..")
    if interaction.data.custom_id == "open-yes" and keys >= 1 and capsules >= 1 then
        --interaction:reply("insert code here")
        jsonstats.wallet.keys = jsonstats.wallet.keys - 1 jsonstats.wallet.capsules = jsonstats.wallet.capsules - 1

        local prizeval = math.random(1,4) --
        local if_have = false

        --==+CHECKER+==--
        for i,v in ipairs (jsonstats.inv) do --loops this command to check inv until it has a copy of an item
            if v == KEYNAMETABLE[prizeval] then --if theres a copy
                if_have = true --turn this to true
                break
            end
        --print(i,v)
        end
        --==++==--

        --==+IF NEW+==--
        if if_have == false then --if theres no copy.. do
            table.insert(jsonstats.inv, KEYNAMETABLE[prizeval]) --gives you items keyname
            updatesave(profileID, jsonstats, check) --(S)

            interaction:reply("Opening capsule...")
            message.channel:send(MENUCAPSULE.." "..JSONITEMS[KEYNAMETABLE[prizeval]][2].." "..MENUCAPSULE)
            message.channel:send("You obtained **"..JSONITEMS[KEYNAMETABLE[prizeval]][1].."** !")

        return end --end command

        --==+IF COPY+==--
        jsonstats.wallet.emblems = jsonstats.wallet.emblems + 1
        updatesave(profileID, jsonstats, check) --(S)

        interaction:reply("Opening capsule...")
        message.channel:send(MENUCAPSULE.." "..JSONITEMS[KEYNAMETABLE[prizeval]][2].." "..MENUCAPSULE)
        message.channel:send("Seems like you got a dupe.. \n**+1 Emblem**")
        --==++==--
        return

    elseif interaction.data.custom_id == "open-no" then
        interaction:reply(message.author.name..", You changed your mind.")
        return
    end
    ----------=-=-=-=BUTTON CODE=-=-=-=------------
end



return command --
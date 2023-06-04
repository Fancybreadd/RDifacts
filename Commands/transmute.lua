local opt1 = discordia.Button {type = "button", style = "primary", id = "T1", label = "[1]", disabled = true}
local opt2 = discordia.Button {type = "button", style = "primary", id = "T2", label = "[2]", disabled = true}
local opt3 = discordia.Button {type = "button", style = "primary", id = "T3", label = "[3]", disabled = true}
local opt4 = discordia.Button {type = "button", style = "primary", id = "T4", label = "[4]", disabled = true}

local command = {}
function command.run(message)
    print("market")
    --------------------------------------------------------------------FILESELECT
    --single
    local profileID = message.author.id 
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    local username = message.author.username
    local iconurl = message.author.avatarURL

    --==--
    if not check then
        check = makeprofile(profileID)
        noprofile(message)
    end
    --==--

    local jsonstats = json.decode(io.input(check):read("*a"))

    --------------------------------------------------------------------INFO
    local marbles = jsonstats.wallet.marbles
    local emblems = jsonstats.wallet.emblems
    local capsules = jsonstats.wallet.capsules
    local ingredients = jsonstats.wallet.ingredients
    local keys = jsonstats.wallet.keys

    --------------------------------------------------------------------CHECKS
    if marbles >= 100 then opt1:enable() opt2:enable()
    elseif marbles >= 35 then opt2:enable() end
    if emblems >= 3 then opt3:enable()end
    if capsules >= 2 then opt4:enable()end

    --------------------------------------------------------------------COMMAND
    local transmutemsg = message.channel:sendComponents {
        embed ={
            color = 0x000000, title = "Transmute",
            author = {
                name = username.. "'s r$transmute",
                icon_url = iconurl
            },
            description = "[1] - 35 Marbles > 50 Ingredients \n"
            .."[2] - 100 Marbles > 1 Capsule \n"
            .."[3] - 3 Emblems "..MenuEMBLEM.." > 1 Capsule \n"
            .."[4] - 2 Capsules "..MenuCAPSULE.." > 1 Key "..MenuKEY,
            footer = {text = "The Everchanging Altar bubbles."}
        },
        components = discordia.Components {opt1,opt2,opt3,opt4}
    }

    local pressed, interaction = transmutemsg:waitComponent("button", nil, 1000 * 30, function(interaction) --if a button is pressed
        print(interaction.member.id)
        if interaction.user.id ~= profileID then
            interaction:reply("You can't use this button!", true)
            return false
        end

        return true
    end)

    transmutemsg:update { --turn off buttons after interaction
        embed ={
            color = 0x000000, title = "Transmuteaa",
            author = {
                name = username.. "'s r$transmute",
                icon_url = iconurl
            },
            description =
            "[1] - 35 Marbles -> 50 Ingredients \n"
            .."[2] - 100 Marbles -> 1 Capsule \n"
            .."[3] - 3 Emblems "..MenuEMBLEM.." -> 1 Capsule \n"
            .."[4] - 3 Capsules "..MenuCAPSULE.." -> 1 Key "..MenuKEY,
            footer = {text = "The Everchanging Altar bubbles."}
        },
        components = discordia.Components {opt1:disable(), opt2:disable(), opt3:disable(), opt4:disable()}
    }

    if not pressed then
        print("r$transmute timed out")
        return
    end

    --------------------------------------------------------------------BUTTON CODE
    print("press! rechecking..") --redeclaring for button abuse 
    check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    jsonstats = json.decode(io.input(check):read("*a"))

    local marbles = jsonstats.wallet.marbles
    local emblems = jsonstats.wallet.emblems
    local capsules = jsonstats.wallet.capsules
    --local ingredients = jsonstats.wallet.ingredients
    --local keys = jsonstats.wallet.keys

    if interaction.data.custom_id == "T1" and marbles >= 35 then
        print("opt1")
        jsonstats.wallet.ingredients = jsonstats.wallet.ingredients + 50
        jsonstats.wallet.marbles = jsonstats.wallet.marbles - 35
        updatesave(profileID, jsonstats, check)

        interaction:reply("You transmuted 35 Marbles into 50 Ingredients.")
    end
    if interaction.data.custom_id == "T2" and marbles > 100 then
        print("opt2")
        jsonstats.wallet.capsules = jsonstats.wallet.capsules + 1
        jsonstats.wallet.marbles = jsonstats.wallet.marbles - 100
        updatesave(profileID, jsonstats, check)

        interaction:reply("You transmuted 100 Marbles into 1 Capsule.")
    end
    if interaction.data.custom_id == "T3" and emblems > 3 then
        print("opt3")
        jsonstats.wallet.capsules = jsonstats.wallet.capsules + 1
        jsonstats.wallet.emblems = jsonstats.wallet.emblems - 3
        updatesave(profileID, jsonstats, check)

        interaction:reply("You transmuted 3 Emblems into 1 Capsule.")
    end
    if interaction.data.custom_id == "T4" and capsules > 3 then
        print("opt4")
        jsonstats.wallet.capsules = jsonstats.wallet.keys+ 1
        jsonstats.wallet.emblems = jsonstats.wallet.capsules - 3
        updatesave(profileID, jsonstats, check)

        interaction:reply("You transmuted 3 Capsules into 1 Key.")
    end
end
return command --
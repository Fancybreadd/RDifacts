local opt1 = discordia.Button {type = "button", style = "primary", id = "T1", label = "[1]", disabled = false}
local opt2 = discordia.Button {type = "button", style = "primary", id = "T2", label = "[2]", disabled = false}
local opt3 = discordia.Button {type = "button", style = "primary", id = "T3", label = "[3]", disabled = false}
local opt4 = discordia.Button {type = "button", style = "primary", id = "T4", label = "[4]", disabled = false}

local command = {}
function command.run(message)
    print("market")
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
    local marbles = jsonstats.wallet.marbles
    local capsules = jsonstats.wallet.capsules
    local ingredients = jsonstats.wallet.ingredients
    local keys = jsonstats.wallet.keys

    --------------------------------------------------------------------CHECKS

    --------------------------------------------------------------------COMMAND
    local transmutemsg = message.channel:sendComponents {
        embed ={
            color = 0x000000, title = "Transmute",
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
            embed ={
                color = 0x000000, title = "Transmute",
                description = "[1] - 35 Marbles > 50 Ingredients \n"
                .."[2] - 100 Marbles > 1 Capsule \n"
                .."[3] - 3 Emblems "..MenuEMBLEM.." > 1 Capsule \n"
                .."[4] - 2 Capsules "..MenuCAPSULE.." > 1 Key "..MenuKEY,
                footer = {text = "The Everchanging Altar bubbles."}
            },
        },
        components = discordia.Components {opt1:disable(), opt2:disable(), opt3:disable(), opt4:disable()}
    }

    if not pressed then
        print("r$transmute timed out")
        return
    end

    --------------------------------------------------------------------BUTTON CODE
end
return command --
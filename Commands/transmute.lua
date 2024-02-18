local command = {}
function command.run(message)
    print("market")
    --------------------------------------------------------------------FILESELECT
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, nil, "Normal")

    --------------------------------------------------------------------INFO
    local Option1 = discordia.Button {type = "button", style = "primary", id = "T1", label = "[1]", disabled = true}
    local Option2 = discordia.Button {type = "button", style = "primary", id = "T2", label = "[2]", disabled = true}
    local Option3 = discordia.Button {type = "button", style = "primary", id = "T3", label = "[3]", disabled = true}

    local Emblems = SaveData.wallet.emblems
    local Capsules = SaveData.wallet.capsules
    local Ingredients = SaveData.wallet.ingredients
    local Keys = SaveData.wallet.keys

    --------------------------------------------------------------------CHECKS
    if Ingredients >= 150 then Option1:enable()end
    if Emblems >= 2 then Option2:enable()end
    if Capsules >= 3 then Option3:enable()end

    --------------------------------------------------------------------COMMAND
    local ShopText = {
        color = 0x000000, title = "Transmute",
        author = {
            name = DiscordUsername.. "'s r$transmute",
            icon_url = DiscordPFP
        },

        thumbnail = {
            url = MenuTEMB
        },

        description =
        "[1] - "..Transmute1cost.." Ingredients "..MenuINGREDIENT.." -> 1 Capsule "..MenuCAPSULE.."\n"
        .."[2] - "..Transmute2cost.." Emblems "..MenuEMBLEM.." -> 1 Capsule "..MenuCAPSULE.."\n"
        .."[3] - "..Transmute3cost.." Capsules "..MenuCAPSULE.." -> 1 Key "..MenuKEY,
        footer = {text = "The Everchanging Altar bubbles."}
    }


    local TransmuteMessage = message.channel:sendComponents {
        embed = ShopText,
        components = discordia.Components {Option1,Option2,Option3}
    }

    local pressed, interaction = TransmuteMessage:waitComponent("button", nil, 1000 * 30, function(interaction) --if a button is pressed
        print(interaction.member.id)
        if interaction.user.id ~= message.author.id then
            interaction:reply("You can't use this button!", true)
            return false
        end

        return true
    end)

    TransmuteMessage:update { --turn off buttons after interaction
        embed = ShopText,
        components = discordia.Components {Option1:disable(), Option2:disable(), Option3:disable()}
    }

    if not pressed then
        print("r$transmute timed out")
        return
    end

    --------------------------------------------------------------------BUTTON CODE
    print("press! rechecking..") --redeclaring for button abuse 
    SaveData = RecheckData(message)

    local Emblems = SaveData.wallet.emblems
    local Capsules = SaveData.wallet.capsules
    local Ingredients = SaveData.wallet.ingredients
    --local Keys = SaveData.wallet.Keys

    if interaction.data.custom_id == "T1" and Ingredients >= Transmute1cost then
        print("Option2")
        SaveData.wallet.capsules = SaveData.wallet.capsules + Transmute1reward
        SaveData.wallet.ingredients = SaveData.wallet.ingredients - Transmute1cost
        UpdateSave(message.author.id, SaveData)

        interaction:reply("You transmuted "..Transmute1cost.." **Ingredients** into 1 "..Transmute1reward.." **Capsule**.")
        return
    end
    if interaction.data.custom_id == "T2" and Emblems >= Transmute2cost then
        print("Option3")
        SaveData.wallet.capsules = SaveData.wallet.capsules + Transmute2reward
        SaveData.wallet.emblems = SaveData.wallet.emblems - Transmute2cost
        UpdateSave(message.author.id, SaveData)

        interaction:reply("You transmuted "..Transmute2cost.." **Emblems** into "..Transmute2reward.." **Capsule**.")
        return
    end
    if interaction.data.custom_id == "T3" and Capsules >= Transmute3cost then
        print("Option4")
        SaveData.wallet.keys = SaveData.wallet.keys + Transmute3reward
        SaveData.wallet.capsules = SaveData.wallet.capsules - Transmute3cost
        UpdateSave(message.author.id, SaveData)

        interaction:reply("You transmuted "..Transmute3cost.." **Capsules** into "..Transmute3reward.." **Key**.")
        return
    end
end
return command --
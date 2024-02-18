local command = {}
function command.run(message)
    print("open")
    --------------------------------------------------------------------FILESELECT
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, nil, "Normal")

    --------------------------------------------------------------------INFO
    local YesButton = discordia.Button {type = "button", style = "success", id = "open-yes", label = "Yes", disabled = true}
    local NoButton = discordia.Button {type = "button", style = "danger", id = "open-no", label = "No", disabled = true}    

    local Keys = SaveData.wallet.keys
    local Capsules = SaveData.wallet.capsules
    local OpenText = "You don't have enough to open a capsule."

    --------------------------------------------------------------------CHECKS
    if Keys >= 1 and Capsules >= 1 then --|if ENOUGH Keys and Capsules
        YesButton:enable() NoButton:enable()
        OpenText = "Open a capsule?"
    end

    local OpenPromptText = {
        color = 0x000000, title = Capsules.." Capsules "..MenuCAPSULE.."\n-----[x]-----\n"..Keys.." Keys "..MenuKEY,
        thumbnail = { url = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/capsule.png"},
        footer = {text = OpenText}
    }

    --------------------------------------------------------------------BUTTON
    local OpenPrompt = message.channel:sendComponents {
        embed = OpenPromptText,
        components = discordia.Components {YesButton, NoButton}
    }

    local pressed, interaction = OpenPrompt:waitComponent("button", nil, 1000 * 30, function(interaction) --if a button is pressed
        print(interaction.member.id)
        if interaction.user.id ~= message.author.id then
            interaction:reply("You can't use this button!", true)
            return false
        end

        return true
    end)

    OpenPrompt:update { --turn off buttons after interaction
        embed = OpenPromptText,
        components = discordia.Components {YesButton:disable(), NoButton:disable()}
    }

    if not pressed then
        print("h$open timed out")
        return
    end

    --------------------------------------------------------------------BUTTON CODE
    print("press! rechecking..") --redeclaring for button abuse 

    SaveData = RecheckData(message)

    Keys = SaveData.wallet.keys
    Capsules = SaveData.wallet.capsules

    if interaction.data.custom_id == "open-yes" and Keys >= 1 and Capsules >= 1 then --|if you press yes and still have the requirements
        SaveData.wallet.keys = SaveData.wallet.keys - 1 SaveData.wallet.capsules = SaveData.wallet.capsules - 1



        --CHECKER
        function OwnCheck(Prize)
            local Owned = false
            for i,v in ipairs (SaveData.inv) do --loops this command to SelectedSaveFile inv until it has a copy of an item
                if v == Prize then --if already owned
                    Owned = true --turn this to true
                    break
                end
            end
            return Prize, Owned
        end

        local Prize, Owned = OwnCheck(math.random(1, 32))
        print(Prize)

        --if Owned then Prize, Owned = OwnCheck(math.random(1, 32)) end
        --print(Prize)

        --IF NEW
        if Owned == false then --if not owned yet..
            table.insert(SaveData.inv, Prize) --gives you items keyname
            UpdateSave(message.author.id, SaveData) --(S)

            interaction:reply("Opening capsule...")
            message.channel:send(ArtifactTable[Prize]["Emoji"])
            message.channel:send(":sparkles: You obtained **"..ArtifactTable[Prize]["Name"].." ["..ArtifactTable[Prize]["ID"].."]** !")
            return
        end

        --IF COPY
        SaveData.wallet.emblems = SaveData.wallet.emblems + 1
        UpdateSave(message.author.id, SaveData) --(S)

        interaction:reply("Opening capsule...")

        message.channel:send(ArtifactTable[Prize].Emoji)
        message.channel:send("Seems like you got a dupe.. (+1 **Emblem** "..MenuEMBLEM.." )")
        return

    elseif interaction.data.custom_id == "open-no" then --|if you press no
        interaction:reply(DiscordUsername..", You changed your mind.")
        return

    else --|if you pressed yes but dont have the requirements
        message.channel:send("Hey! What are you doing!?")
    end
end



return command --
local command = {} ----JCI THANK YOU THANK YOU THANK YOU YOURE SO HANDSOME MWUAH MWUAH MWUAH
function command.run(message) --lets go again
    print("collection")
    --------------------------------------------------------------------FILESELECT
    --hookshot
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, message.mentionedUsers[1], "Hookshot")

    if SaveData == nil then
        return
    end

    --------------------------------------------------------------------INFO
    local PreviousButton = discordia.Button {type = "button", style = "primary", id = "col-previous", label = "<<", disabled = false}
    local NextButton = discordia.Button {type = "button", style = "primary", id = "col-next", label = ">>", disabled = false}

    local Inventory = SaveData.inv
    local ListLength = CollectionLength --amount of artifacts shown per page --will be 16

    --------------------------------------------------------------------CHECKS
    if #Inventory == 0 then --if you have nothing
        print("col, empty")

        ErrorEmbedder(
            message, 
            "-- Artifact Progress [0/256] --",
            message.author.username,
            message.author.avatarURL,
            "Nothing but flies and cobwebs...",
            "You don't have anything, use r$open to open a capsule!",
            "",
            "Page 0/0",
            0xffffff
        )

        return
    end
    --------------------------------------------------------------------COMMAND
    local MaxPage = math.ceil((#Inventory / ListLength))
    local CurrentPage = 1
    --==--
    table.sort(Inventory)
    --==--

    local function createMessage()
        if CurrentPage == 1 then PreviousButton:disable() else PreviousButton:enable() end
        if CurrentPage == MaxPage then NextButton:disable() else NextButton:enable() end

        --[]-- LIST THE ARTIFACTS
        local ArtifactList = ""
        for IndexNumber = (CurrentPage - 1) * ListLength + 1, CurrentPage * ListLength, 1 do
            if Inventory[IndexNumber] == nil then
                break
            end
            ArtifactList = ArtifactList.."**["..ArtifactTable[Inventory[IndexNumber]]["ID"].."]** "..ArtifactTable[Inventory[IndexNumber]]["Name"].." "..ArtifactTable[Inventory[IndexNumber]]["Emoji"].."\n"
        end
        --[]--

    --------------------------------------------------------------------MESSAGE
        return {
            embed = {
                color = 0xffffff, title = "-- Artifact Progress ["..(#Inventory).."/256] --",
                author = {
                    name = DiscordUsername,
                    icon_url = DiscordPFP
                }, --

                description = ArtifactList,
                footer = {
                    text = "Page "..CurrentPage.."/"..MaxPage,
                } --
            },
            components = discordia.Components {PreviousButton, NextButton}
        }
    end
    local CollectionMessage = message.channel:sendComponents(createMessage())

    --------------------------------------------------------------------BUTTON CODE
        while true do
            local pressed, interaction = CollectionMessage:waitComponent("button", nil, 1000 * 60 * 5, function(interaction)
                if interaction.user.id ~= message.author.id then
                    interaction:reply("You can't use this button!", true)
                    return false
                end

                return true
            end)

            if pressed then
                if interaction.data.custom_id == "col-next" then
                    CurrentPage = CurrentPage + 1
                elseif interaction.data.custom_id == "col-previous" then
                    CurrentPage = CurrentPage - 1
                end

                interaction:update(createMessage())
            else
                -- Timeout
                break
            end
        end
end

return command
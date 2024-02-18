local command = {}
function command.run(message, arg, arg2)
    print("museum")
    --------------------------------------------------------------------FILESELECT
    --hookshot
    local SaveData, DiscordUsername, DiscordPFP, Friend = ReturnUserData(message, message.mentionedUsers[1], "Hookshot")

    if SaveData == nil then
        return
    end

    --------------------------------------------------------------------INFO
    local YesButton = discordia.Button {type = "button", style = "success", id = "museum-yes", label = "Purchase", disabled = false}
    local NoButton = discordia.Button {type = "button", style = "danger", id = "museum-no", label = "No", disabled = false}

    local MuseumLock = SaveData.unlocks.museum
    local FavInv = SaveData.favinv
    local Owned = false
    local Inv = SaveData.inv
    local FavID, PedID = tonumber(arg), tonumber(arg2)
    --------------------------------------------------------------------CHECKS
    if SaveData.wallet.ingredients < MuseumCost then YesButton:disable() end

    if MuseumLock == false then
        print("locked")
        if Friend then
            ErrorEmbedder(
                message, 
                "Museum..?",
                message.author.username,
                message.author.avatarURL,
                "Seems like they don't have one...",
                "User has not unlocked **r$Museum** yet!",
                MenuMEMB,
                "",
                0x535353
            )
        else
            local MuseumPromptText = {
                color = 0xfce803, title = DiscordUsername.."'s Museum",

                author = {
                    name = DiscordUsername.."'s r$museum...?",
                    icon_url = DiscordPFP
                },

                description = "A space is open for purchase, maybe you can put it to good use...\nFrom the looks of it, it'll cost "..MuseumCost.." **Ingredients** to buy.",
            }

            local MuseumPrompt = message.channel:sendComponents{
                embed = MuseumPromptText,
                components = discordia.Components {NoButton, YesButton}
            }

            local pressed, interaction = MuseumPrompt:waitComponent("button", nil, 1000 * 30, function(interaction) --if a button is pressed
                print(interaction.member.id)
                if interaction.user.id ~= message.author.id then
                    interaction:reply("You can't use this button!", true)
                    return false
                end

                return true
            end)

            MuseumPrompt:update { --turn off buttons after interaction
            embed = MuseumPromptText,
            components = discordia.Components {NoButton:disable(), YesButton:disable()}
            }

            if not pressed then
                print("r$museum timed out")
                return
            end

            print("press! rechecking..") --redeclaring for button abuse 
            SaveData = RecheckData(message)

            if interaction.data.custom_id == "museum-yes" and SaveData.wallet.ingredients > MuseumCost then
                print("museum yes")
                SaveData.wallet.ingredients = SaveData.wallet.ingredients - MuseumCost
                SaveData.unlocks.museum = true
                UpdateSave(message.author.id, SaveData)

                interaction:reply("You have bought the museum! Use **r$museum [r$m]** to view it.")
                return
            end

            if interaction.data.custom_id == "museum-no" then
                print("museum no")

                interaction:reply("Maybe another time.")
                return
            end
        end
        return
    end


    print(MuseumLock)

    
    --------------------------------------------------------------------COMMAND
    if not arg or Friend then

        local displayroom = imagevips.Image.new_from_file("assets/displayroom.png")
        local sheet = imagevips.Image.new_from_file("assets/ArtifactSHEET.png")
        local pixel_x local pixel_y --starting pixel is (64, 48)

        --======o
        for x = 1, 18 do --for loop increments by 1 by default so we just start with the initial value and the limit
            pixel_x = 32 * ((x - 1) % 6) + 64
            pixel_y = 32 * math.floor((x - 1) / 6) + 48
            -- draw stuff here
            if FavInv[x] ~= -1 then
                local artifactID = FavInv[x] print(artifactID)
                local selected = sheet:crop(16 * ((artifactID - 1) % 16), 16 * math.floor((artifactID - 1) / 16), 16, 16)
                --formula x: 16 * ID.5 - 1 modulo 16 | 1 ID = 1 tile to right, reset to 0 on multiples of 16
                --formula y: 16 * floor(ID.5 - 1 / 16) | 16 ID = 1 tile down after previous row finishes
                --width height: 16, 16

                displayroom = displayroom:composite(selected, "over",{x=pixel_x, y=pixel_y})
            end
        end
        local finalroom = displayroom:resize(2, {kernel = "nearest"})
        --======o

        message.channel:send{
            embed = {
                color = 0xfce803, title = DiscordUsername.."'s Museum",

                author = {
                    name = DiscordUsername,
                    icon_url = DiscordPFP
                },

                description =
                "- **r$museum ``Artifact ID`` ``Pedestal ID``** to display an artifact on a chosen pedestal."
                .."\n- **r$museum guide** to view every pedestals ID number."
                .."\n- **r$museum remove ``Pedestal ID``** to remove an artifact from a chosen pedestal."
                .."\n- **r$museum clear** to remove all artifacts from all pedestals."
                .."\n- **r$collection** to see every artifacts ID number.",
          
            },
            file = {"test.png", finalroom:cast("uchar"):write_to_buffer(".png")}
        }
        return
    end

    --------------------------------------------------------------------ARGUMENT (GUIDE)
    if arg == "guide" then

        local GuideLayout = imagevips.Image.new_from_file("assets/displayguide.png")
        GuideLayout = GuideLayout:resize(2, {kernel = "nearest"})

        message.channel:send{
            file = {"guide.png", GuideLayout:cast("uchar"):write_to_buffer(".png")}
        }
        return
    end
    --------------------------------------------------------------------ARGUMENT (CLEAR)
    if arg == "clear" then
        for i,v in ipairs(FavInv) do
            FavInv[i] = -1
            print(i, v)
        end
       
        UpdateSave(message.author.id,SaveData)
        message.channel:send(
            "All pedestals cleared!"
        )
        return
    end
    --------------------------------------------------------------------ARGUMENT (REMOVE)
    if arg == "remove" and PedID then
        for i,v in ipairs(FavInv) do --loops until it finds the same item already displayed
            if v == FavInv[PedID] and FavInv[PedID] ~= -1 then -- if you have it already favorited
                print("removing...")
                Owned = true
                FavInv[PedID] = -1
                break
            end
        end

        UpdateSave(message.author.id,SaveData)
        message.channel:send(
            "You removed "..ArtifactTable[FavInv[PedID]]["Emoji"].." "..ArtifactTable[FavInv[PedID]]["Name"].." from pedestal "..PedID.."."
        )

        if Owned == false then
            print("m, no ar in pedestal")
            ErrorEmbedder(
            message, 
            "Displaying Artifact..?",
            message.author.username,
            message.author.avatarURL,
            "",
            "No artifact is displayed in the selected pedestal.",
            MenuMEMB,
            "",
            0x535353
            )
            return
        end

    elseif arg == "remove" and not PedID then
        print("m, no id for remove")
            ErrorEmbedder(
                message, 
                "Displaying Artifact..?",
                message.author.username,
                message.author.avatarURL,
                "",
                "No pedestal ID detected! pedestal ID's range from 1 - 18, use r$museum guide to see the positions of each pedestal.",
                MenuMEMB,
                "",
                0x535353
            )
        return
    end

    --------------------------------------------------------------------ARGUMENT (DISPLAY)
    if FavID and PedID then --if message has two args
        local FavOwned

        if PedID > 18 then 
            print("m, pedestal id too high")
            ErrorEmbedder(
            message, 
            "Displaying Artifact..?",
            message.author.username,
            message.author.avatarURL,
            "",
            "Pedestal ID too high! There are only 18 pedestals.",
            MenuMEMB,
            "",
            0x535353
            )
            return

        elseif FavID > 256 then
            print("m, ar too high")
            ErrorEmbedder(
            message, 
            "Displaying Artifact..?",
            message.author.username,
            message.author.avatarURL,
            "",
            "Artifact ID too high! There are currently "..ArtifactPool.." artifacts.",
            MenuMEMB,
            "",
            0x535353
            )
            return
        end

        for i,v in ipairs (Inv) do --INVENTORY dupe Savefile
            if v == ArtifactTable[FavID]["ID"] then --if detected!
                Owned = true --turn this to true
                break
            end --print(i,v.."inv")
        end

        if not Owned then
            print("m, dont have the ar")
            ErrorEmbedder(
                message, 
                "Displaying Artifact..?",
                message.author.username,
                message.author.avatarURL,
                "",
                "You don't have this artifact!",
                MenuMEMB,
                "",
                0x535353
            )
            return
        end

        for i,v in ipairs(FavInv) do --FAVORITES dupe Savefile
            if v == FavID then -- if you have it already favorited
                FavOwned = true -- flip the removed boolean
                break
            end
        end

        if FavOwned then
            print("m, ar already favorited")
            ErrorEmbedder(
                message, 
                "Displaying Artifact..?",
                message.author.username,
                message.author.avatarURL,
                "",
                "You already have this artifact displayed!",
                MenuMEMB,
                "",
                0x535353
            )
            return
        end

        FavInv[PedID] = FavID
        UpdateSave(message.author.id,SaveData) --(S)

        message.channel:send(
            "You placed "..ArtifactTable[FavID]["Emoji"].." "..ArtifactTable[FavID]["Name"].." in pedestal "..PedID.."."
        )
        return

    elseif FavID or PedID then --if theres only 1 arg
        print("m, only 1 arg num")
            ErrorEmbedder(
            message, 
            "Displaying Artifact..?",
            message.author.username,
            message.author.avatarURL,
            "",
            "Not enough inputs! r$museum needs both an artifact ID number and a pedestal ID number."
            .."\n- **r$museum** to see your museum."
            .."\n- **r$museum guide** to view every pedestals ID number."
            .."\n- **r$collection** to view your artifacts ID numbers.",
            MenuMEMB,
            "r$museum ``Artifact ID`` ``Pedestal ID``\n example: r$museum "..math.random(1,ArtifactPool).." "..math.random(1,18),
            0x535353
            )
        return
    end



end
return command --

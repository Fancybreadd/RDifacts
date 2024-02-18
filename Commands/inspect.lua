local command = {}
function command.run(message, arg, arg2)
    print("inspect")
    --------------------------------------------------------------------FILESELECT
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, nil, "Normal")

    --------------------------------------------------------------------CHECKS

    if arg == nil then
        print ("i, no arg")
        ErrorEmbedder(
            message, 
            "Inspecting Artifact..?",
            message.author.username,
            message.author.avatarURL,
            "The Artifact Codex stays dormant, no response.",
            "No artifact ID given, add an artifacts ID number when doing r$inspect",
            MenuIEMB,
            "example: r$inspect "..math.random(1,256),
            0x535353
        )
        return
    end
    ---o
    local ResearchID = tonumber(arg) --turn number in message into a number value
    local Owned = false
    ---o

    if ResearchID == nil then
        print("i, arg not a number")
        ErrorEmbedder(
            message, 
            "Inspecting Artifact..?",
            message.author.username,
            message.author.avatarURL,
            "The Artifact Codex glows in response, but doesn't do anything. It seems like it doesn't know what to do with your request.",
            "ID needs to be a number!",
            MenuIEMB,
            "example: r$inspect "..math.random(1,256),
            0x535353
        )
        return

    elseif ResearchID > ArtifactPool then --|if argument number is bigger than amount of existing artifacts
        print("i, id too big")
        ErrorEmbedder(
            message, 
            "Inspecting Artifact..?",
            message.author.username,
            message.author.avatarURL,
            "The Artifact Codex flips itself to a blank page...",
            "ID given is bigger than current amount of existing artifacts.",
            MenuIEMB,
            "Current highest ID is "..ArtifactPool..".",
            0x535353
        )
        return

    end

    for i,v in ipairs (SaveData.inv) do --|loop code until ID 
        if v == ResearchID then
            Owned = true --turn this to true
            print(i,v, "aaaaaaaaaaaaa")
            break
        end
    end
    print("what????")


    if Owned == false then
        print("i, dont have artifact")
        ErrorEmbedder(
            message, 
            "Inspecting Artifact..?",
            message.author.username,
            message.author.avatarURL,
            "The Artifact Codex responds, waiting to analyze the artifact from your hands... You don't have it though.",
            "You do not own the artifact that has this ID!",
            MenuIEMB,
            "",
            0x535353
        )
        return
    end

    --------------------------------------------------------------------COMMAND

    local ArtifactID = (ArtifactTable[ResearchID]["ID"]) --name
    local ArtifactName = (ArtifactTable[ResearchID]["Name"]) --emoji, sprite
    local ArtifactDescription =(ArtifactTable[ResearchID]["Description"]) --ID
    local ArtifactEmoji =(ArtifactTable[ResearchID]["Emoji"]) --description
    local ArtifactOrigin = OrTable[ArtifactTable[ResearchID]["Origin Type"]]..ArtifactTable[ResearchID]["Origin"]

    if ArtifactTable[ResearchID]["RDCreator"] ~= "" then ArtifactOrigin = ArtifactOrigin.." - "..ArtifactTable[ResearchID]["RDCreator"] end

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0x535353, title = "Inspecting Artifact...",
            author = {
                name = DiscordUsername,
                icon_url = DiscordPFP
            },

            description = "# "..ArtifactEmoji.."  "..ArtifactName.."\n"..ArtifactDescription,
            fields = {
                {
                    name = "ID",
                    value = ArtifactID,
                    inline = true
                },
                {
                    name = "Origin",
                    value = ArtifactOrigin
                }
            },
            thumbnail = {
                url = MenuIEMB
            },
        }
    }
end
return command --

--[ArtifactTable[ResearchID][X]]
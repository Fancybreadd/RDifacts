_G['ReturnUserData'] = function (message, MentionedUser, ReturnType)

    
    ------------------------------------------
    ------------------------------------------
    if ReturnType == "Normal" then
        local ID = message.author.id
        local SelectedSaveFile = io.open(BotPath.."PROFILES/"..ID..".json","r")
        local DiscordUsername = message.guild:getMember(ID).user.username
        local DiscordPFP = message.guild:getMember(ID).user.avatarURL

        if not SelectedSaveFile then --if you dont have a savefile, make new
            local NewFile = io.open(BotPath.."PROFILES/"..ID..".json","w")

            NewFile:write(io.open(BotPath.."PROFILES/TEMPLATE.json","r"):read("a"))
            NewFile:close() --(S)

            SelectedSaveFile= io.open(BotPath.."PROFILES/"..ID..".json","r")

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
            }}
        end

        local SaveData = json.decode(SelectedSaveFile:read("*a"))
        SelectedSaveFile:close()

        if SaveData.version ~= TemplateSave.version then --verify save version 
            print("Verifying...")
            SaveData = Synctables(TemplateSave, SaveData)
            SaveData.version = TemplateSave.version
        end
        
        return SaveData, DiscordUsername, DiscordPFP, ID
    end
    ------------------------------------------
    ------------------------------------------
    if ReturnType == "Hookshot" then
        local ID = message.author.id
        local Friend = false

        if MentionedUser then
            ID = MentionedUser[1]
            Friend = true
        end

        local SelectedSaveFile = io.open(BotPath.."PROFILES/"..ID..".json","r")
        local DiscordUsername = message.guild:getMember(ID).user.username
        local DiscordPFP = message.guild:getMember(ID).user.avatarURL

        if not SelectedSaveFile then
            if Friend then
                message.channel:send{
                    embed = {
                        color = 0x000000, title = "No Profile Found!",
            
                        description = "You look through the Explorers Registry, seems like the person in question hasn't registered..."
                    }
                }
                return
            else
                local NewFile = io.open(BotPath.."PROFILES/"..ID..".json","w")

                NewFile:write(io.open(BotPath.."PROFILES/TEMPLATE.json","r"):read("a"))
                NewFile:close() --(S)

                SelectedSaveFile= io.open(BotPath.."PROFILES/"..ID..".json","r")

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
                }}
            end
        end

        local SaveData = json.decode(SelectedSaveFile:read("*a"))
        SelectedSaveFile:close()

        if SaveData.Version ~= TemplateSave.Version then --verify save version 
            print("Verifying...")
            SaveData = Synctables(TemplateSave, SaveData)
            SaveData.version = TemplateSave.version
        end
        
        return SaveData, DiscordUsername, DiscordPFP, Friend
    end
    ------------------------------------------
    ------------------------------------------
    if ReturnType == "Boomerang" then
        local ID1 = message.author.id
        local Friend = false

        local SelectedSaveFile2 = nil
        local DiscordUsername2 = nil
        local DiscordPFP2 = nil
        local SelectedSaveFile1 = io.open(BotPath.."PROFILES/"..ID1..".json","r")
        local DiscordUsername1 = message.guild:getMember(ID1).user.username
        local DiscordPFP1 = message.guild:getMember(ID1).user.avatarURL

        if MentionedUser then
            ID2 = MentionedUser[1]
            SelectedSaveFile2 = io.open(BotPath.."PROFILES/"..ID2..".json","r")
  
            DiscordUsername2 = message.guild:getMember(ID2).user.username
            DiscordPFP2 = message.guild:getMember(ID2).user.avatarURL

            Friend = true
        end

        if not SelectedSaveFile1 then
            local NewFile = io.open(BotPath.."PROFILES/"..ID1..".json","w")

            NewFile:write(io.open(BotPath.."PROFILES/TEMPLATE.json","r"):read("a"))
            NewFile:close() --(S)

            SelectedSaveFile1= io.open(BotPath.."PROFILES/"..ID1..".json","r")

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
            }}
        end

        if Friend and not SelectedSaveFile2 then
            message.channel:send{
                embed = {
                    color = 0x000000, title = "No Profile Found!",
        
                    description = "You look through the Explorers Registry, seems like the person in question hasn't registered..."
                }
            }
            return
        elseif not SelectedSaveFile2 then
            return "NoFriend"
        end

        local SaveData1 = json.decode(SelectedSaveFile1:read("*a"))
        local SaveData2 = json.decode(SelectedSaveFile2:read("*a"))
        SelectedSaveFile1:close()
        SelectedSaveFile2:close()

        if SaveData1.Version ~= TemplateSave.Version then --verify save version 
            print("Verifying...")
            SaveData = Synctables(TemplateSave, SaveData)
            SaveData.version = TemplateSave.version
        end

        if SaveData2.Version ~= TemplateSave.Version then --verify save version 
            print("Verifying...")
            SaveData = Synctables(TemplateSave, SaveData)
            SaveData.version = TemplateSave.version
        end

        return SaveData1, DiscordUsername1, DiscordPFP1, SaveData2, DiscordUsername2, DiscordPFP2, ID2
    end
end

function Synctables(template, save)
    for k, v in pairs(template) do
      if save[k] == nil then save[k] = template[k] end
      if type(v) == "table" then save[k] = Synctables(v, save[k]) end
    end
    for k, v in pairs(save) do
      if template[k] == nil then save[k] = nil end
      if type(v) == "table" then save[k] = Synctables(v, save[k]) end
    end
    return save
  end

-------------------------------------------------[REOPEN SAVEFILES FOR DATA CONSISTENCY]
_G['RecheckData'] = function (message)
    local SelectedSaveFile = io.open(BotPath.."PROFILES/"..message.author.id..".json","r")
    local SaveData = json.decode(io.input(SelectedSaveFile):read("*a"))

    SelectedSaveFile:close()
    return SaveData
end

-------------------------------------------------[SAVE AND UPDATE ACCOUNTS]
_G['UpdateSave'] = function (ProfileID, SaveData)
    local modify = io.open(BotPath.."PROFILES/"..ProfileID..".json","w")
    io.output(modify):write(json.encode(SaveData)) modify:flush() modify:close()--update, save, close
end

_G['ErrorEmbedder'] = function (message, CommandName, DiscordUsername, DiscordPFP, Desc, Reason, Thumbnail, Footertext, Color)
    message.channel:send{
        embed = {
            color = Color, title = CommandName,
            author = {
                name = DiscordUsername,
                icon_url = DiscordPFP
            },

            description = Desc,
            fields = {
                {
                    name = "Error!",
                    value = "- "..Reason
                }
            },
            thumbnail = {
                url = Thumbnail
            },
            footer = {text = Footertext}
        }

    }
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

local command = {}
function command.run(message)
    print("profile")
    --------------------------------------------------------------------FILECHECK
    local profileID = message.author.id
    local pname = message.author.username
    local iconurl = message.author.avatarURL
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")

    --==--
    if not message.mentionedUsers[1] then --if pinged friend
        if not check then
            local profile = io.open(BotPath.."PROFILES/"..profileID..".json","w")
            noprofile(message)
            check = makeprofile(profile, profileID)
        end
    else
        profileID = message.mentionedUsers[1][1]
        pname = message.guild:getMember(profileID).user.username
        iconurl = message.guild:getMember(profileID).user.avatarURL
        check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
        if not check then
            nofriendprofile(message, pname, iconurl)
            print("no profile detected")
            return
        end
    end
    --==--

    --------------------------------------------------------------------INFO
    local jsonstats = json.decode(io.input(check):read("r"))

    local iteminv = jsonstats.inv
    local artifactprogress = #iteminv

    local keystat = jsonstats.wallet.keys
    local capsulestat = jsonstats.wallet.capsules
    local marblestat = jsonstats.wallet.marbles
    local materialstat = jsonstats.wallet.materials
    local ingredientstat = jsonstats.wallet.ingredients
    local emblemstat = jsonstats.wallet.emblems

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0xffffff, title = "Stats",
            author = {
                name = pname.. "'s Profile",
                icon_url = iconurl
            },
            description = "**-- Artifact Progress ["..artifactprogress.."/256] --**",

            fields = {
                {
                    name = MenuKEY.." Keys",
                    value = keystat, inline = true
                },
                {
                    name = MenuCAPSULE.." Capsules",
                    value = capsulestat, inline = true
                },
                {
                    name = MenuMARBLE.." Marbles",
                    value = marblestat, inline = true
                },
                --{
                    --name = MenuMATERIAL.." Materials",
                    --value = materialstat, inline = true
                --},
                {
                    name = MenuINGREDIENT.." Ingredients",
                    value = ingredientstat, inline = true
                },
                {
                    name = " Emblems",
                    value = emblemstat, inline = true
                }
            }
        }
    }
    check:close()
end
return command --
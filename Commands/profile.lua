local command = {}
function command.run(message)
    print("profile")
    --------------------------------------------------------------------FILESELETCT
    --hookshot
    local profileID = message.author.id
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
    local username
    local iconurl

    --==--
    if not message.mentionedUsers[1] then --if pinged friend

        if not check then
            check = makeprofile(profileID)
            noprofile(message)
        end
        username = message.author.username
        iconurl = message.author.avatarURL

    else

        profileID = message.mentionedUsers[1][1]
        check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
        username = message.guild:getMember(profileID).user.username
        iconurl = message.guild:getMember(profileID).user.avatarURL
        if not check then
            nofriendprofile(message, username, iconurl)
            print("no profile detected")
            return
        end

    end
    local jsonstats = json.decode(check):read("*a")
    --==--

    --------------------------------------------------------------------INFO
    local iteminv = jsonstats.inv
    local artifactprogress = #iteminv

    local keystat = jsonstats.wallet.keys
    local capsulestat = jsonstats.wallet.capsules
    local marblestat = jsonstats.wallet.marbles
    --local materialstat = jsonstats.wallet.materials
    local ingredientstat = jsonstats.wallet.ingredients
    local emblemstat = jsonstats.wallet.emblems

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0xffffff, title = "Stats",
            author = {
                name = username.. "'s Profile",
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
                    name = MenuEMBLEM.." Emblems",
                    value = emblemstat, inline = true
                }
            }
        }
    }
    check:close()
end
return command --
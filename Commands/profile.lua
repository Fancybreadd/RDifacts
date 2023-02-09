local command = {}
function command.run(message)
    print("profile")
    local profileID = message.author.id
    local pname = message.author.username
    local iconurl = message.author.avatarURL
    local check = io.open(path..profileID..".json","r")
    --==--
    if not message.mentionedUsers[1] then --if pinged friend
        if not check then
            local profile = io.open(path..profileID..".json","w")
            noprofile(message)
            check = makeprofile(profile, profileID)
        end
    else
        profileID = message.mentionedUsers[1][1]
        pname = message.guild:getMember(profileID).user.username
        iconurl = message.guild:getMember(profileID).user.avatarURL
        check = io.open(path..profileID..".json","r")
        if not check then
            print("no profile detected")
            return
        end
    end
    --==--

        local jsonstats = json.decode(io.input(check):read("*a"))

        local iteminv = jsonstats.inv
        local artifactprogress = #iteminv

        local keystat = jsonstats.wallet.keys local capsulestat = jsonstats.wallet.capsules local marblestat = jsonstats.wallet.marbles 
        local materialstat = jsonstats.wallet.materials local ingredientstat = jsonstats.wallet.ingredients
        local emblemstat = jsonstats.wallet.emblems

        message.channel:send{
            embed = {
                color = 0x000000, title = "Stats",
                author = {
                    name = pname.. "'s Profile",
                    icon_url = iconurl
                },
                description = "**-- Artifact Progress ["..artifactprogress.."/256] --**",

                fields = {
                    {
                        name = MENUKEY.." Keys",
                        value = keystat,
                        inline = true
                    },
                    {
                        name = MENUCAPSULE.." Capsules",
                        value = capsulestat,
                        inline = true
                    },
                    {
                        name = MENUMARBLE.." Marbles",
                        value = marblestat,
                        inline = true
                    },
                    {
                        name = MENUMATERIAL.." Materials",
                        value = materialstat,
                        inline = true
                    },
                    {
                        name = MENUINGREDIENT.." Ingredients",
                        value = ingredientstat,
                        inline = true
                    },
                    {
                        name = " Emblems",
                        value = emblemstat,
                        inline = false
                    }
                }
        }}
    check:close()
end
return command --
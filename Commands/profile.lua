local command = {}
function command.run(message)
    print("profile")
    local profileID = message.author.id
    local pname = message.author.username
    local iconurl = message.author.avatarURL
    --==--
    ----------------------------------------o
    --if pingid ~= nil then --switch to pinged user if there is
        --print("ooh")
        --profileID = message.mentionedUsers[1][1]
        --local friend = message.guild:getMember(profileID).user
        --pname = friend.username
        --iconurl = friend.avatarURL
        --print (friend)
        --iconurl = friend.icon_url --Change this later--
        --for i,v in pairs(message.mentionedUsers[1]) do print(i,v) end
    --end
    local check = io.open(path..profileID..".json","r")
    ----------------------------------------o

    if check then
        local jsonstats = json.decode(io.input(check):read("*a"))

        local iteminv = jsonstats.inv
        local artifactprogress = #iteminv

        local keystat = jsonstats.wallet.keys local capsulestat = jsonstats.wallet.capsules local marblestat = jsonstats.wallet.marbles 
        local materialstat = jsonstats.wallet.materials local ingredientstat = jsonstats.wallet.ingredients
        local emblemstat = jsonstats.wallet.emblems

        message.channel:send{
            embed = {
                color = 0x000000,
                author = {
                    name = pname.. "'s Profile",
                    icon_url = iconurl
                },
                title = "Stats",
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
    else noprofile(message)
    end
end
return command --
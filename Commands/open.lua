
local command = {}
function command.run(message)
    print("open")
    local yesopen = discordia.Button {type = "button", style = "success", id = "open-yes", label = "Yes", disabled = true}
    local noopen = discordia.Button {type = "button", style = "danger", id = "open-no", label = "No", disabled = true}
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    --==--

    if check then
        Jsonstats = json.decode(io.input(check):read("*a"))
        local keys = Jsonstats.wallet.keys local capsules = Jsonstats.wallet.capsules
        local pass = false
        local opentext = "You don't have enough to open a capsule."

        if keys >= 1 and capsules >= 1 then
            yesopen:enable() noopen:enable()
            opentext = "Open a capsule?"
        end

        local openmsg = message.channel:sendComponents {
            embed ={
                color = 0x000000, title = capsules.." Capsules "..MENUCAPSULE.."\n-----[x]-----\n"..keys.." Keys "..MENUKEY,
                footer = {text = opentext}
            },
            components = discordia.Components {yesopen, noopen}
        }

        local pressed, interaction = openmsg:waitComponent("button", nil, 1000 * 30, function(interaction) --if a button is pressed
            print(interaction.member.id)
            if interaction.member.id == message.author.id then return true end
            return false
        end)

        openmsg:update { --turn off buttons
            embed ={
                color = 0x000000, title =  capsules.." Capsules "..MENUCAPSULE.."\n-----[x]-----\n"..keys.." Keys "..MENUKEY,
                footer = {text = opentext}
            },
            components = discordia.Components {yesopen:disable(), noopen:disable()}
        }

        if not pressed then
            print("h$open timed out")
            return
        end

        ----------=-=-=-=BUTTON CODE=-=-=-=------------
        print("press! running..")
        if interaction.data.custom_id == "open-yes" then
            --interaction:reply("insert code here")
            if Jsonstats.wallet.keys or Jsonstats.wallet.capsules < 0 then
                interaction:reply(message.author.username.." you don't have the required ")
            return end
            Jsonstats.wallet.keys = Jsonstats.wallet.keys - 1 Jsonstats.wallet.capsules = Jsonstats.wallet.capsules - 1

            local prizeval = math.random(1,4) --
            local if_have = false

            --==+CHECKER+==--
            for i,v in ipairs (Jsonstats.inv) do --loops this command to check inv until it has a copy of an item
                if v == KEYNAMETABLE[prizeval] then --if theres a copy
                    if_have = true --turn this to true
                    break
                end
            --print(i,v)
            end
            --==++==--

            --==+IF NEW+==--
            if if_have == false then --if theres no copy.. do
                print(JSONITEMS[KEYNAMETABLE[prizeval]][1]..JSONITEMS[KEYNAMETABLE[prizeval]][3])

                table.insert(Jsonstats.inv, KEYNAMETABLE[prizeval]) --gives you items keyname
                updatesave(profileID, Jsonstats, check) --(S)

                interaction:reply("Opening capsule...")
                message.channel:send(MENUCAPSULE.." "..JSONITEMS[KEYNAMETABLE[prizeval]][2].." "..MENUCAPSULE)
                message.channel:send("You obtained **"..JSONITEMS[KEYNAMETABLE[prizeval]][1].."** !")

            return end --end command

            --==+IF COPY+==--
            Jsonstats.wallet.emblems = Jsonstats.wallet.emblems + 1
            updatesave(profileID, Jsonstats, check) --(S)

            message.channel:send("Opening capsule...")
            message.channel:send(JSONITEMS[KEYNAMETABLE[prizeval]][2])
            message.channel:send("Seems like you got a dupe.. \n**+1 Emblem**")
            --==++==--
            return

        else if interaction.data.custom_id == "open-no" then
            interaction:reply(message.author.name..", You changed your mind.")
            return
        end end

    else noprofile(message)
    end
end



return command --
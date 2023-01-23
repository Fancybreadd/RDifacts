
local command = {}
function command.run(message)
    print("open")
    local yesopen = discordia.Button {type = "button", style = "success", id = "yeso", label = "Yes", disabled = true}
    local noopen = discordia.Button {type = "button", style = "danger", id = "noo", label = "No", disabled = true}
    local profileID = message.author.id 
    local check = io.open(path..profileID..".json","r")
    --==--

    if check then
        Jsonstats = json.decode(io.input(check):read("*a"))
        local keys = Jsonstats.wallet.keys local capsules = Jsonstats.wallet.capsules
        local pass = false

        if keys >= 1 and capsules >= 1 then
            yesopen:enable() noopen:enable()
        end

        local openmsg = message.channel:sendComponents {
            content = keys.." Keys "..MENUKEY.."\n"..capsules.." Capsules "..MENUCAPSULE,
            components = discordia.Components {yesopen, noopen}
        }
        local pressed, interaction = openmsg:waitComponent("button", nil, 1000 * 30, function(interaction)
            if interaction.user.id == message.author.id then
                print("match")
                return pass == true
            end
        end)

        openmsg:update { content = keys.." Keys "..MENUKEY.."\n"..capsules.." Capsules "..MENUCAPSULE, components = discordia.Components {yesopen:disable(), noopen:disable()} }

        if not pressed then
            print("h$open timed out")
            return
        end
        ----------=-=-=-=-=-=-=-=------------
        print("press! running..")
        if interaction.custom_id == "yeso" then
            print("YEAA")
        end
    end
end



return command --
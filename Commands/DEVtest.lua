local command = {} --DEV COMMAND
function command.run(message, arg, arg2)
    print(message.author.id)
   
    local YesButton = discordia.Button {type = "button", style = "success", id = "test-yes", label = "Purchase", disabled = false}
    local NoButton = discordia.Button {type = "button", style = "danger", id = "test-no", label = "No", disabled = false}

    local PromptText = {
        color = 0xfce803, title = "aaa",

        author = {
            name = "bbb",
        },

        description = "Hi",
    }

    local Prompt = message.channel:sendComponents{
        embed = PromptText,
        components = discordia.Components {NoButton, YesButton}
    }

    local pressed, interaction = Prompt:waitComponent("button", nil, 1000 * 30, function(interaction) --if a button is pressed
        print(interaction.member.id)
        if interaction.user.id ~= message.author.id then
            interaction:reply("You can't use this button!", true)
            return false
        end

            interaction:reply("you can!", false)
        return true
    end)
end
return command --
local command = {}
function command.run(message, arg, arg2)
    print("ping")
    commandid = message.id
    print(string.split("abby-ogre", "-")[1])
    --==--
    message.channel:send(message.author.mentionString.. " pong!") --!!
    print(message.author.id)

    if arg then
        local birdtext = imagevips.Image.text("<i>"..arg.."</i>", {dpi = 300})
        local bird = imagevips.Image.new_from_file("assets/beirb.png")
        local resizedbird = bird:resize(0.75)
        local sky = imagevips.Image.new_from_file("assets/clouds.png")
        local sky = sky:composite(resizedbird, "over", { x = 260, y = 75 })
        local sky = sky:composite(birdtext, "over", { x = 300, y = 550})
        sky:write_to_file("skybird.png")

        message.channel:send{
            content = message.author.mentionString.." pong!",
            file = {"test.png", sky:cast("uchar"):write_to_buffer(".png")}
        }
    return end
    -----------
    local yesbutton = discordia.Button {type = "button", style = "success", id = "yesb", label = "Yes!", disabled = false}
    local nobutton = discordia.Button {type = "button", style = "danger", id = "nob", label = "No!", disabled = false}

    local newmessage = message.channel:sendComponents {
        components = discordia.Components {yesbutton, nobutton}
    }
    print(yesbutton)
    local pressed, interaction = newmessage:waitComponent("button", nil, 1000 * 30, function(interaction)
        return true
    end)
    newmessage:update { components = discordia.Components {yesbutton:disable(), nobutton:disable()} } 

    if interaction.data.custom_id == "yesb" then
        interaction:reply("test")
        local msg_id = interaction.getReply()
        interaction:editReply("test2", msg_id)
        --how do i edit this interaction:reply afterward
        --message.channel:send("ooooo")
    end
end
return command --
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
    local argvd = math.random(1,4)
    print(argvd)
    print(JSONITEMS[KEYNAMETABLE[argvd]][1])
end
return command --
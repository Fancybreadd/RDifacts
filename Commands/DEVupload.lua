local command = {} --DEV COMMAND
function command.run(message, arg, arg2)
    if message.author.id ~= 812228180499890187 or message.author.id ~= 1001946516610621480 then
        return
    end

    local sheet = imagevips.Image.new_from_file("assets/ArtifactSHEET.png")

    local argnum1 = tonumber(arg)
    local argnum2 = tonumber(arg2)

    if not argnum1 or not argnum2 then
        print("please put 2number")
        return
    end

    local check = argnum1 < argnum2

    if not check then
        print("no upload! number incorrect")
        return
    end

    local IDnum = argnum1 - 1

    repeat
        IDnum = IDnum + 1

        local selected = sheet:crop(16 * ((IDnum - 1) % 16), 16 * math.floor((IDnum - 1) / 16), 16, 16) -- crops a 16x16 image starting from the top left
        local finalized = selected:resize(4, {kernel = "nearest"})

        finalized:write_to_file("assets/ArtifactsEmoji/Artifact"..IDnum..".png") -- alternatively you can use image:pngsave_buffer(), same thing, writes the image as a string

        message.guild:createEmoji("Artifact"..IDnum, "assets/ArtifactsEmoji/Artifact"..IDnum..".png")
    until IDnum == argnum2

    message.channel:send("Emojis "..argnum1.." to "..argnum2.." uploaded!")

end
return command --
local command = {} --DEV COMMAND
function command.run(message, arg, arg2)
    --------------------------------------------------------------------COMMAND
    if message.author.id ~= 812228180499890187 or message.author.id ~= 1001946516610621480 then
        return
    end

    local emojis = message.guild.emojis
    local emojilist = {}

    for i, v in pairs(emojis) do --clone emoji table

        table.insert(emojilist, v)
        --print(emojilist)
    end

    -- sort emoji table
    table.sort(emojilist, function(e1, e2) return tonumber(e1.name:sub(9)) < tonumber(e2.name:sub(9)) end) -- replace < with > if you want it to be descending order

    local emomessage = ""

    for i, v in pairs(emojilist) do
        emomessage = emomessage .."<:" .. v.hash .. ">" .. "\n"
    end

    message.channel:send(emomessage)
    --print(message.guild.emojis[5])
    -- [1] = amount, [2] = table, [3] = type, [4] = guild
end
return command --
--get an account stupid--

_G['noprofile'] = function (message)
    message.channel:send(
        message.author.username..", you haven't registered yet! please type ``h$signup`` to start using commands."
    )
end

_G['updatesave'] = function (profileID, jsonstats, check)
    local modify = io.open(path..profileID..".json","w")
    io.output(modify):write(json.encode(jsonstats)) modify:flush() modify:close() check:close() --update, save, close
end
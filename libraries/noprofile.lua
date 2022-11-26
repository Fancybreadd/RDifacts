_G['noprofile'] = function (message)
    message.channel:send(
        message.author.username..", you haven't registered yet! please type ``h$signup`` to start using commands."
    )
end